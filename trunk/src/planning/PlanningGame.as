package planning{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import mate_marote.MateMaroteGame;
	import mx.core.SpriteAsset;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.DragEvent;
	import utils.SerializableEvent;
	import utils.VideoPlayer;
	import utils.VideoIterator;
	import mx.core.Application;
	import utils.MessageManager;
	import mx.controls.Label;
	
	public class PlanningGame extends MateMaroteGame{
		public var characters:Array = []
		public var houses:Array = []
		public var ownedHouses:Array = []
		public var positions:Array = []
		public var moveCount:int = 0
		public var maxMoves:int = 0
		public var sounds:PlanningSounds = new PlanningSounds()
		public var winVideos:VideoIterator = new VideoIterator(['/video/generico_bien_1.swf',],
						                                       ['/video/planning_bien_1.swf'])
				        
		public var looseVideos:VideoIterator = new VideoIterator(['/video/generico_mal_1.swf'],
						                                         ['/video/planning_mal_1.swf'])
		
        public var rotacionLbl:Label = new Label()
        public var minMovesLbl:Label = new Label()
        public var maxMovesLbl:Label = new Label()
		public var moveCountLbl:Label = new Label()

		public function PlanningGame(){
			super()
			version_number = 'v1.0'
			gameName = 'planning'
		}
		
		override public function init(e:Event):void{
			background.addChild(new Images.fondo() as SpriteAsset)			
			characters = [new PlanningCharacter(1, Images.ana),
						  new PlanningCharacter(2, Images.pancho),
						  new PlanningCharacter(3, Images.nubis)]
			for each(var c:PlanningCharacter in characters){
				c.addEventListener(PlanningCharacter.START_DRAG, onDrag)
				c.addEventListener(PlanningCharacter.DROP, onDrop)
			}
			
			houses = [new PlanningHouse(1, Images.casa_ana, characters[0], 80, 220),
					  new PlanningHouse(2, Images.casa_pancho, characters[1], 110, 210),
					  new PlanningHouse(3, Images.casa_nubis, characters[2], 110, 110),
					  new PlanningHouse(4, Images.casa_vacia, null, 110, 160)]
			
			for each(var h:PlanningHouse in houses){
				h.addEventListener(DragEvent.DRAG_OVER, playDroppable)
				h.addEventListener(DragEvent.DRAG_EXIT, playDrag)
				h.addEventListener(PlanningHouse.ON_MOVE, onPlayerMove)
				levelCanvas.addChild(h)
			}
			//Ubicaciones posibles para las casas
			positions = [new HousePosition(1,125,50),
						 new HousePosition(2,450,50),
						 new HousePosition(3,125,300),
						 new HousePosition(4,450,300)]
						 
			positions[1].invalidOrigins = [positions[2]]
			positions[2].invalidOrigins = [positions[1]]
			
			ownedHouses = houses.slice(0,3)
			super.init(e)
		}
		
		override public function multimediaSetup():void{
			gameMusicUrl = '/audio/planning/game_music.mp3'
			menuMusicUrl = '/audio/planning/menu_music.mp3'			
			super.multimediaSetup()
		}

		override public function playIntro():void{
			super.playIntro()
			MessageManager.show(this, 'Ayudalos a llegar cada uno a su casa.\nAcordate que no puede haber mas de uno en cada casa,\ny solo pueden cruzar a otra casa por los puentes.', 5000, startGame)
		}
		override public function startGame():void{
			super.startGame()
			moveCount = 0
		}
		
		override public function resetGame():void{
			setLayout([null, null, null, null, 1,2,3,4,1,2,3,0])
			super.resetGame()
		}
		
		public function setLayout(trial:Array):void{
			//Uses a TRIAL list to set house and character layout
			//                           houses   chars
			//TRIAL = [nivel, min_moves, max_moves, rotacion, 1,2,3,4, 0,0,0,0]
			for(var i:int=0; i<positions.length; i++){
				//the index of house_id in TRIAL is 4 more than i
				//the house_id in TRIAL is 1 more than the index in this.houses
				var house:PlanningHouse = houses[trial[i+4]-1]
				house.setPosition(positions[i])
				
				//the index of char_id in TRIAL is 8 more than i
				//the char_id in TRIAL is 1 more than the index in this.characters
				var ch:int = trial[i+8] as int
				if(ch){
					house.setCharacter(characters[ch-1])
				}
			}
		}
		override public function loadTrial(trial:Object):void{
			super.loadTrial(trial)
			setLayout(trial['trial'])
			maxMoves = trial['trial'][1] as int
			maxMovesLbl.text = trial['trial'][1]
			minMovesLbl.text = trial['trial'][2]
			rotacionLbl.text = trial['trial'][3]
		}
		
        
        public function checkWin():Boolean{
        	for each(var h:PlanningHouse in ownedHouses){
  				if( !h.isDone() ){
  					return false
  				}
			}
			return true
        }
        
        public function endTrial(won:Boolean, videourl:String, msg:String):void{
    		moveCount = 0
    		moveCountLbl.text = String(moveCount)
    		var after:Function = function():void{ nextTrial(won) }
    		var self:PlanningGame = this
        	if(noMedia){
        		MessageManager.show(self, msg, 3000, after)
        	}else{
        		setTimeout(function():void{
        			stopMusicPlayVideo(self, mediaUrl+videourl, after)
        		}, 500)
        	}
    	}
        
        public function onPlayerMove(e:SerializableEvent):void{
        	logger.logEvent(e)
    		moveCount++
    		moveCountLbl.text = String(moveCount)
           	if(checkWin()){
        		sounds.play('bien')
        		endTrial(true, winVideos.next(), "Bien, todo el mundo a su casa!")
        	}else if(moveCount == maxMoves){
        		sounds.play('mal')
        		endTrial(false, looseVideos.next(), "Mmm, está difícil, terminemos aca mejor :(")
        	}
        }
        
        public function onDrag(e:SerializableEvent):void{
        	logger.logEvent(e)
        	sounds.play('levantar')
        	playDrag(e)
        }
        
        public function onDrop(e:SerializableEvent):void{
        	logger.logEvent(e)
        	stopAll()
        }
        public function stopAll():void{
        	sounds.stop('arrastrando')
        	sounds.stop('soltando')
        }
        public function playDrag(e:Event):void{
        	if(!sounds.isPlaying('arrastrando')){
        		sounds.stop('soltando')
        		sounds.play('arrastrando', int.MAX_VALUE)
        	}
        }
        public function playDroppable(e:Event):void{
        	if(!sounds.isPlaying('soltando')){
        		sounds.stop('arrastrando')
        		sounds.play('soltando', int.MAX_VALUE)
        	}
        }
        override public function createDebugControls():void{
        	super.createDebugControls()
        	var rot:Label = new Label()
			rot.text = 'Rot'
			rotacionLbl.width = 10
			var minm:Label = new Label()
        	minm.text = 'Min'
        	minMovesLbl.width = 10
        	var maxm:Label = new Label()
        	maxm.text = 'Max'
        	maxMovesLbl.width = 20
        	var movc:Label = new Label()
        	movc.text = 'Mov'
        	moveCountLbl.width = 20
			with(controls){
				addChild(rot)
				addChild(rotacionLbl)
				addChild(minm)
				addChild(minMovesLbl)
				addChild(maxm)
				addChild(maxMovesLbl)
				addChild(movc)
				addChild(moveCountLbl)
        	}
        }
	}	
}

import flash.display.Sprite;
import flash.events.MouseEvent;
import mx.core.UIComponent;
import flash.events.Event;
import mx.events.FlexEvent;
import mx.managers.DragManager;
import mx.core.DragSource;
import mx.events.DragEvent;
import flash.display.MovieClip;
import flash.display.DisplayObject;
import mx.controls.Image;
import flash.display.Shape;
import mx.core.IFlexDisplayObject;
import planning.Images;
import mx.core.SpriteAsset;
import utils.SerializableEvent;

class PlanningCharacter extends UIComponent{
	static public const START_DRAG:String = "PLANNING_CHARACTER_START_DRAG"
	static public const DROP:String = "PLANNING_CHARACTER_DROPPED"
	public var house:PlanningHouse
	public var dragHelper:SpriteAsset
	public var image:SpriteAsset
	public var nick:Number
	
	function PlanningCharacter(name:Number, newImage:Class):void{
		nick = name
		dragHelper = new newImage() as SpriteAsset
		image = new newImage() as SpriteAsset
		addChild(image)
		addEventListener(MouseEvent.MOUSE_DOWN, onDrag)
		addEventListener(DragEvent.DRAG_COMPLETE, onDragComplete)
	}
	
	private function onDrag(event:MouseEvent):void {
        dispatchEvent(new SerializableEvent(START_DRAG, {character:nick, house:house.nick}))
        var ds:DragSource = new DragSource();
        ds.addData(this, 'character');
        DragManager.doDrag(this, ds, event, dragHelper);
        visible = false
    }
    
    private function onDragComplete(event:DragEvent):void{
        dispatchEvent(new SerializableEvent(DROP))
    	visible = true
    }
}

class PlanningHouse extends UIComponent{
	public var nick:Number
	public var character:PlanningCharacter
	public var dropY:int = 0 //When a character is in this house...
	public var dropX:int = 0 //...this point will be the bottom-middle of that character.
	public var ownerCharacter:PlanningCharacter
	private var background:Sprite
	private var pos:HousePosition
	static public const ON_MOVE:String = "PLANNING_CHARACTER_MOVED"
	
	function PlanningHouse(name:Number, image:Class, newOwnerCharacter:PlanningCharacter, newDropX:int, newDropY:int):void{
		nick = name
		addChild(new image() as SpriteAsset)
		addEventListener(DragEvent.DRAG_ENTER, onDragEnter)
		addEventListener(DragEvent.DRAG_DROP, onDragDrop)
		ownerCharacter = newOwnerCharacter
		dropX = newDropX
		dropY = newDropY
	}
	
	private function onDragEnter(e:DragEvent):void{
        if (e.dragSource.hasFormat('character') && !isOccupied()) {
	        var char:Object = e.dragSource.dataForFormat('character');	        
	        if( pos.invalidOrigins.indexOf(char.house.pos) == -1){
	            var dropTarget:UIComponent=UIComponent(e.currentTarget);
	            DragManager.acceptDragDrop(dropTarget);
	        }
        }
	}
	
	private function onDragDrop(e:DragEvent):void{
        var char:Object = e.dragSource.dataForFormat('character');
        setCharacter(char as PlanningCharacter)
        dispatchEvent(new SerializableEvent(ON_MOVE, {character:char.nick, house:nick}))
	}
	
	public function setCharacter(char:PlanningCharacter):void{
		if(char.house){
			char.house.character = null
		}
		character = char
		char.house = this
		addChild(char)
		//Find out why char has no dimensions but its image does...(nasty flash bug?)
		char.y = dropY - char.image.height
		char.x = dropX - char.image.width/2
	}
	
	public function clearCharacter():void{
		if(character){
			removeChild(character)
			character = null
		}
	}
	
	public function setPosition(newPos:HousePosition):void{
		pos = newPos
		x = pos.x - Math.abs(width/2)
		y = pos.y - Math.abs(height/2)
	}
	
	public function isOccupied():Boolean{
		return character != null
	}
	
	public function isDone():Boolean{
		return character == ownerCharacter
	}
}

class HousePosition extends Object{
	public var x:Number
	public var y:Number
	public var nick:Number
	public var invalidOrigins:Array = []

	function HousePosition(name:Number, newX:Number, newY:Number){
		x = newX
		y = newY
		nick = name
	}
}