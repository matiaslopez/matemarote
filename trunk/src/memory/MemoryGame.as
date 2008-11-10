 package memory
{
	import com.adobe.serialization.json.JSON;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.net.NetStream;
	import flash.net.NetConnection;
	import flash.media.Video;
	import flash.utils.setTimeout;
	
	import mate_marote.MateMaroteGame;
	
	import mx.containers.HBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.NumericStepper;
	import mx.core.SpriteAsset;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.NumericStepperEvent;
	import utils.SerializableEvent;
	import utils.VideoPlayer;
	import utils.VideoIterator;
	import utils.ChoiceList;
	import utils.Random;
	import utils.MessageManager;
	import mx.core.Application;
		    
	public class MemoryGame extends MateMaroteGame{
        public var currentLevel:Level
		public var settings:Object = {inter_stage_delay:2000}
		public var gameId:int = 0
		public var winVideos:VideoIterator = new VideoIterator(['/video/memoria_bien_1.swf',
						                                        '/video/memoria_bien_5.swf',
						                                        '/video/generico_bien_1.swf'],
						                                       ['/video/memoria_bien_3.swf',
							                                    '/video/memoria_bien_4.swf',
							                                    '/video/memoria_bien_2.swf'])
        
		public var looseVideos:VideoIterator = new VideoIterator(['/video/memoria_mal_1.swf',
						                                          '/video/generico_mal_1.swf'],
						                                         ['/video/memoria_mal_2.swf'])
		
		public function MemoryGame():void{
			super()
			version_number = 'v1.0'
			gameName = 'memory'
		}
		override public function init(e:Event):void{
			super.init(e)
			background.addChild(new Images.grilla() as SpriteAsset)
        }
        
        override public function resetGame():void{
        	if(currentLevel){
				currentLevel.unloadLevel()
			}
        	winVideos.resetCount()
        	looseVideos.resetCount()
			super.resetGame()
		}
        
        override public function multimediaSetup():void{
			gameMusicUrl = '/audio/memory/game_music.mp3'
			menuMusicUrl = '/audio/memory/menu_music.mp3'			
			super.multimediaSetup()
		}
        
        override public function playIntro():void{
        	if(noMedia){
				MessageManager.show(this, 'Hace click en todas las fichas, sin repetir!', 5000, startGame)
        	}else{
	        	super.playIntro()
	        	var self:MemoryGame = this
	        	setTimeout( function():void{
	        		VideoPlayer.play(self, mediaUrl+'/video/memoria_demo.swf', startGame, 640, 480)
	        	}, 500);
        	}
        }
		
		override public function startGame():void{
			currentLevel = null
			super.startGame()
		}
		
		public function onFinish(ev:SerializableEvent):void{
			logger.logEvent(ev)
			
			var videoUrl:String
			var txtMessage:String
			var txtms:int
			if( ev.event_data.won ){
				txtMessage = 'Ganaste, bien!!! :) :) :)'
				txtms = 2000
	        	videoUrl = mediaUrl+winVideos.next()
			}else{
				txtMessage = 'Ooops, a esa ya le habias hecho click :('
				txtms = 3000
				videoUrl = mediaUrl+looseVideos.next()
			}
			
			var after:Function = function():void{ nextTrial(ev.event_data.won) }
			if(noMedia){
				MessageManager.show(this, txtMessage, txtms, after)
        	}else{
				stopMusicPlayVideo(this, videoUrl, after)
        	}
		}
		
		override public function loadTrial(trial:Object):void{
			if(currentLevel){
				currentLevel.unloadLevel()
			}
			super.loadTrial(trial)
		}
		
		override public function startTrial(trial:Object):void{
			super.startTrial(trial)
			currentLevel = new Level(this, trial);
			with(currentLevel){
				addEventListener(Level.FINISH, onFinish);
				addEventListener(Level.INTER_STAGE, logger.logEvent);
				addEventListener(Level.PICTURE_SELECTED, logger.logEvent);
				addEventListener(Level.PICTURES_SHOWN, logger.logEvent);
				loadLevel()
				showPics()
			}
		}
        		
		override public function createDebugControls():void{
			super.createDebugControls()
			var delayLbl:Label = new Label()
			delayLbl.text = 'Delay:'
			var delay:NumericStepper = new NumericStepper()
			delay.value = settings.inter_stage_delay
			delay.stepSize = 100
			delay.maximum = 10000
			delay.minimum = 0
			delay.addEventListener(NumericStepperEvent.CHANGE,
					function(e:Event):void{settings.inter_stage_delay = e.currentTarget.value })

			with(controls){
				addChild(delayLbl)
				addChild(delay)
			}
		}
	}	
}