package mate_marote
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.errors.IOError;
    import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetStream;
	import flash.net.NetConnection;
	import flash.media.Video;
	import flash.utils.setTimeout;
	
	import mx.containers.HBox;
	import mx.containers.TitleWindow;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import utils.GameLogger;
	import utils.GameServer;
	import utils.VideoPlayer;
	import utils.SerializableEvent;
	import utils.GameLoader;
	import utils.MessageManager;

	public class MateMaroteGame extends Application{
		public static const GAME_STARTED:String = "GAME_STARTED"
		public static const GAME_FINISHED:String = "GAME_FINISHED"
		public static const GAME_TYPE:String = "MATE_MAROTE_GAME"
		public var gameName:String
		public var levelCanvas:UIComponent = new UIComponent()
		public var background:UIComponent = new UIComponent()
		public var mediaUrl:String
		public var setLevelUrl:String
		public var noMedia:Boolean
		public var debug:Boolean
		public var logger:GameLogger
		public var menuMusic:Sound
		public var menuMusicChannel:SoundChannel
		public var menuMusicUrl:String
		public var gameMusic:Sound
		public var gameMusicChannel:SoundChannel
		public var gameMusicUrl:String
		public var gameLoader:GameLoader
		public var controls:HBox = new HBox()
		public var version_number:String = ''
		public var dificulty:int = 0
		public var initialDificulty:int = 0
		public var trialCount:int = 0
		public var winsInARow:int = 0
		public var lossesInARow:int = 0
		
		//controls
        public var currentLevelLbl:Label = new Label()
        public var trialIdLbl:Label = new Label()
        public var winsLbl:Label = new Label()
        public var lossesLbl:Label = new Label()
        public var trialCountLbl:Label = new Label()

		public function MateMaroteGame(){
			addChildAt(background, 0)
			addChildAt(levelCanvas, 1)
			addEventListener(FlexEvent.APPLICATION_COMPLETE, init)
			super()
		}
		
		public function init(e:Event):void{
			setLevelUrl = Application.application.parameters.setLevelUrl
			mediaUrl = Application.application.parameters.mediaUrl
			noMedia = Application.application.parameters.noMedia
			debug = Application.application.parameters.debug

			if(!noMedia){
				multimediaSetup()
			}
			createControls()
			if(debug){
				createDebugControls()
			}
			loadGame()
		}
		
		private function loadGame():void{
			gameLoader = new GameLoader(Application.application.parameters.gameUrl)
			function gameSuccess(e:Event):void{
				initialDificulty = gameLoader.initialLevel
				resetGame()
			}
			function gameFailure(e:Event):void{
				Alert.show('Se produjo un error al cargar el juego: '+gameLoader.gameUrl)
			}
			gameLoader.addEventListener(GameLoader.LOADED, gameSuccess)
			gameLoader.addEventListener(GameLoader.FAILED, gameFailure)
			gameLoader.load()
		}
		
		public function multimediaSetup():void{
			gameMusic = new Sound(new URLRequest(mediaUrl+gameMusicUrl))
            gameMusic.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event):void{});
			menuMusic = new Sound(new URLRequest(mediaUrl+menuMusicUrl))
            menuMusic.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event):void{});
		}
		
		public function showWelcomeWindow():void {
			var playerChooser:ComboBox = new ComboBox()
            var startBtn:Button = new Button()
            startBtn.label = 'Empezar'
            
            var h:HBox = new HBox()
			with(h){
				addChild(playerChooser)
				addChild(startBtn)
			}
            var welcomeWindow:TitleWindow = new TitleWindow()
			with(welcomeWindow){
	            title = "Elegir Jugador"
	            showCloseButton = false
	            addChild(h)
            }
			function requestPlayer(e:Event):void{
				function playerOk(json:Object):void{
					if(json['status'] == 200){
						if(json[gameName+'_level']){
							initialDificulty = int(json[gameName+'_level'])
						}
						PopUpManager.removePopUp(welcomeWindow)
						playIntro()
					}else{
						Alert.show('Se produjo un error eligiendo jugador, intentalo otra vez')
					}
				}
				function playerError(json:Object):void{
					Alert.show('Se produjo un error eligiendo jugador, intentalo otra vez')
				}
				var data:Object = {'player_id':playerChooser.selectedItem.value}
				GameServer.call(Application.application.parameters.choosePlayerUrl, playerOk, playerError, data)
			}
			
			startBtn.addEventListener(FlexEvent.BUTTON_DOWN, requestPlayer)
            
            var self:MateMaroteGame = this
            function onPlayerList(json:Object):void{
            	playerChooser.dataProvider = json.players
	            PopUpManager.addPopUp(welcomeWindow, self, true)
	            PopUpManager.centerPopUp(welcomeWindow)
            }
            //Start by fetching the user list
            GameServer.call(Application.application.parameters.playerListUrl, onPlayerList)
        }
		
		public function createControls():void{
			addChild(controls)
		}
        public function createDebugControls():void{
			var version:Label = new Label()
			version.text = version_number
			
			var easy:Button = new Button()
			easy.label = '-'
			easy.addEventListener(MouseEvent.CLICK, 
					function(e:Event):void{ loadTrial(gameLoader.easierThan(dificulty)) })
			
			var hard:Button = new Button()
			hard.label = '+'
			hard.addEventListener(MouseEvent.CLICK,
					function(e:Event):void{ loadTrial(gameLoader.harderThan(dificulty)) })
	
			var current:Label = new Label()
			current.text = "Current Level:"
									
			var trial:Label = new Label()
			trial.text = 'Trial count:'
			
			var trialid:Label = new Label()
			trialid.text = 'Trialid:'
			
			var wins:Label = new Label()
			wins.text = 'Wins:'
				
			var losses:Label = new Label()
			losses.text = 'Losses:'
			
			with(controls){
				addChild(version)
				addChild(easy)
				addChild(hard)
				addChild(current)
				addChild(currentLevelLbl)
				addChild(trial)
				addChild(trialCountLbl)
				addChild(trialid)
				addChild(trialIdLbl)
				addChild(wins)
				addChild(winsLbl)
				addChild(losses)
				addChild(lossesLbl)
			}
        }
        
        public function playIntro():void{
        	if(!noMedia){
        		menuMusicChannel.stop()
        	}
        }
        public function startGame():void{
			logger = new GameLogger(Application.application.parameters.createUrl,
									Application.application.parameters.logUrl,
        							3000)
			addEventListener(MouseEvent.MOUSE_MOVE, logger.logMouse)
			addEventListener(MouseEvent.MOUSE_DOWN, logger.logMouse)
        	if(!noMedia){
        		gameMusicChannel = gameMusic.play(0, int.MAX_VALUE)
        	}
			logger.logEvent(new SerializableEvent(GAME_STARTED, gameLoader.gameData))
			trialCount = 0
			winsInARow = 0
			lossesInARow = 0
			dificulty = initialDificulty
			loadTrial(gameLoader.ofDifficulty(dificulty))
        }
        
        
        public function loadTrial(trial:Object):void{
        	trialCount++
    		
        	if(trial['trial'][0] as int != dificulty ){
        		dificulty = trial['trial'][0] as int
	        	GameServer.call(setLevelUrl, null, null, {level:dificulty})
        	}
		    logger.log('TRIAL_STARTED', trial['id'])
		    if(debug){
				currentLevelLbl.text = String(trial['trial'][0])
				trialIdLbl.text = String(trial['id'])
				trialCountLbl.text = String(trialCount)
				winsLbl.text = String(winsInARow)
				lossesLbl.text = String(lossesInARow)
			}
        }
        
        public function nextTrial(won:Boolean):void{
		    logger.log('TRIAL_ENDED', {'won': won})
        	if(trialCount >= gameLoader.trialCount){
        		endGame()
        		return
        	}
        	if(won){
        		winsInARow++
        		lossesInARow = 0
        	}else{
        		lossesInARow++
        		winsInARow = 0
        	}
        	var trial:Object
        	if(winsInARow >= gameLoader.winsBeforePromote){
        		trial = gameLoader.harderThan(dificulty)
        		winsInARow = 0
        	}else if(lossesInARow >= gameLoader.loosesBeforeDemote){
        		trial = gameLoader.easierThan(dificulty)
        		lossesInARow = 0
        	}else{
        		trial = gameLoader.ofDifficulty(dificulty)
        	}
        	loadTrial(trial)
        }
        
        public function resetGame():void{
        	if(!noMedia){
	        	if(gameMusicChannel){
	        		gameMusicChannel.stop()
	        	}
        		menuMusicChannel = menuMusic.play(0, int.MAX_VALUE)
        	}
        	showWelcomeWindow()
        }
        
        public function endGame():void{
        	var msg:TitleWindow
        	var self:MateMaroteGame = this
        	function greet():void{
        		MessageManager.remove(msg)
        		MessageManager.show(self, 'Listo, ya terminamos, Gracias por Jugar!', 6000, resetGame)
        	}
        	setTimeout(function():void{
        		msg = MessageManager.show(self, 'Listo, ya terminamos')
            	removeEventListener(MouseEvent.MOUSE_MOVE, logger.logMouse)
            	removeEventListener(MouseEvent.MOUSE_DOWN, logger.logMouse)
            	logger.logEvent(new SerializableEvent(MateMaroteGame.GAME_FINISHED))
        		logger.close(greet)
        	}, 100)
        }
        
		public function stopMusicPlayVideo(parent:UIComponent, url:String, then:Function):void{
			if(noMedia){
				then()
			}
			function music():void{
	        	gameMusicChannel = gameMusic.play(0, int.MAX_VALUE)
				then()
			}
			if(gameMusicChannel){
				gameMusicChannel.stop()
			}
			VideoPlayer.play(this, url, music)
		}
	}
}