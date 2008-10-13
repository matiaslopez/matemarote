package memory
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import utils.SerializableEvent;
	import com.adobe.serialization.json.JSON;
	import utils.Random;

	
	public class Level extends EventDispatcher{
		public static const FINISH:String = "LEVEL_FINISH"
		public static const INTER_STAGE:String = "LEVEL_INTER_STAGE"
		public static const PICTURE_SELECTED:String = "PICTURE_SELECTED"
		public static const TRIAL_LOADED:String = "TRIAL_LOADED"
		public static const TRIAL_UNLOADED:String = "TRIAL_UNLOADED"
		public static const PICTURES_SHOWN:String = "PICTURES_SHOWN"
		
		public var pictures:Array = [];
		public var selections:Array = [];
		public var grouping:Number;
		public var game:MemoryGame;
		public var busy:Boolean = false //can't do anything while busy
		public var difficulty:Number;
		public var grid:Array = [];
		public var sounds:MemorySounds = new MemorySounds()
		public var trialId:int
		public var trial:Object
		
		
		public function Level(newGame:MemoryGame, trialobj:Object){
			game = newGame
			trialId = trialobj['id']
			trial = trialobj['trial']
			difficulty = trial[0]
			grouping = trial[1]
			
			for(var i:int = 0; i < trial[2].length; i++){
				var pic:Picture = new Picture(this, i+1, trial[2][i])
				pictures.push(pic)
				pic.addEventListener(MouseEvent.MOUSE_DOWN, onSelection)
			}
			
			var cell_width:int = 165
			var cell_height:int = 155
			var columns:int = 4
			var rows:int = 3
			var left_margin:int = 145
			var top_margin:int = 130
			var vert_sep:int = 16
			var horiz_sep:int = 5
			for(var w:int = 0; w<columns; w++){
				for(var h:int = 0; h<rows; h++){
					grid.push( [left_margin+w*(cell_width+horiz_sep), top_margin+h*(cell_height+vert_sep)] )
				}
			}
			
			super()
		}
		
		public function usesGrouping():Boolean{
			/* Checks the grouping attribute of the selected pictures sequence to be
			 * something like: x,x,x,y,y,y,z,z */
			if(grouping == 0){
				return false;
			}
			var blacklist:Array = []
			var prev:Object = null
			for each(var pic:Picture in selections){
				//this.grouping is one more than the corresponding pic layer.
				//grouping == 1 means group by pic.layers[0]
				var groupAttr:int = pic.layers[grouping-1]
				if(groupAttr != prev){
					if(blacklist.indexOf(groupAttr) != -1){
						return false
					}else{
						blacklist.push(groupAttr)
					}
				}
				prev = groupAttr
			}
			return true
		}
		
		public function resetLevel():void{
			selections = []
			busy = false
		}
		
		public function onSelection(e:MouseEvent):void{
			/* Handles picture selection animation, dispatches the PictureSelectedEvent
			   and possibly the 'FINISH' event */
			if(busy){return}
			busy = true
			
			dispatchEvent(new SerializableEvent(PICTURE_SELECTED, {'picId': e.currentTarget.picId, 'local_x':e.localX, 'local_y':e.localY, 'stage_x':e.stageX, 'stage_y':e.stageY}))
			if( selections.indexOf(e.currentTarget) == -1){
				selections.push(e.currentTarget)
			}else{
				sounds.play('mal')
				dispatchEvent(new SerializableEvent(FINISH, {'won':false, 'grouped':false}))
				e.currentTarget.errAnim()
				return
			}
			e.currentTarget.okAnim()
			sounds.play('bien')
			if( selections.length == pictures.length ){
				dispatchEvent(new SerializableEvent(FINISH, {'won':true, 'grouped':usesGrouping()}))
				return
			}
			setTimeout(nextChoice, 500) //Leave some time for grow to finnish
		}
		
		public function nextChoice():void{
			sounds.play('mezclando', int.MAX_VALUE)
			game.levelCanvas.visible = false
			dispatchEvent(new SerializableEvent(INTER_STAGE, game.settings.inter_stage_delay))
			setTimeout(showPics, game.settings.inter_stage_delay)
		}
		public function showPics():void{
			shuffle()
			sounds.stop('mezclando')
			game.levelCanvas.visible = true
			busy = false
			var picData:Array = []
			for each(var pic:Picture in pictures){
				picData.push([pic.x, pic.y])
			}
			dispatchEvent(new SerializableEvent(PICTURES_SHOWN, picData))
		}
		public function loadLevel():void{
			game.levelCanvas.visible = false
			var picdata:Array = []
			for each(var p:Picture in pictures){
				game.levelCanvas.addChild(p)
				picdata.push(p.serialize())
			}
			dispatchEvent(new SerializableEvent(TRIAL_LOADED, trialId))
			resetLevel()
		}
		public function unloadLevel():void{
			dispatchEvent(new SerializableEvent(TRIAL_UNLOADED, trialId))
			for each(var p:Picture in pictures){
				game.levelCanvas.removeChild(p)
			}
		}
		public function shuffle():void{
			Random.dirtyRandom(grid)
			for(var i:String in pictures){
				var pic:Picture = pictures[i]
				pic.reset()
				pic.x = grid[i][0], pic.y = grid[i][1]
			}
		}
		
	}
}