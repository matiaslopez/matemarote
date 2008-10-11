package utils{
	import mx.core.SpriteAsset;
	import flash.events.Event;
	import utils.Random;
	import utils.GameServer;
	import flash.events.EventDispatcher;
	import com.adobe.serialization.json.JSON;

	public class GameLoader extends EventDispatcher{
		public static const LOADED:String = "GAME_DESCRIPTION_LOADED"
		public static const FAILED:String = "GAME_DESCRIPTION_FAILED"

		public var gameUrl:String
		public var gameData:Object
		public var trials:Object
		public var levels:Array
		public var loosesBeforeDemote:int
		public var winsBeforePromote:int
		public var trialCount:int
		public var initialLevel:Number
		
		public function GameLoader(url:String){
			gameUrl = url
		}
		
		public function load():void{
			GameServer.call(gameUrl, storeGame, dispatchFailed)
		}
		
		private function dispatchFailed(o:Object=null):void{
			dispatchEvent(new Event(FAILED))
		}
		
		private function storeGame(data:Object):void{
			/* create a level based index, and level list from the loaded game.
			 * TRIAL = [level,...]
			 * GAME = [initial_level, looses_before_demote, wins_before_promote, trial_count, [Trial, Trial, Trial]]
			 */
			gameData = data
			initialLevel = data[0]
			loosesBeforeDemote = data[1]
			winsBeforePromote = data[2]
			trialCount = data[3]
			trials = {}
			levels = []
			for(var trialId:int=0; trialId < data[4].length; trialId++){
				var trial:Object = data[4][trialId]
				if(!trials[trial[0]]){
					trials[trial[0]] = []
				}
				trials[trial[0]].push({'id':trialId, 'trial':trial})
				if( levels.indexOf(trial[0]) == -1 ){
					levels.push(Number(trial[0]))
				}
			}
			levels = levels.sort(Array.NUMERIC)
			dispatchEvent(new Event(LOADED))

		}
		
		private function nextOf(difficulty:Number, direction:int):Object{
			var current:int = levels.indexOf(difficulty)
			var next:int
			if(current == -1){
				next = 0
			}else{
				next = current + direction
				if(next < 0){
					next = 0
				}else if(next >= levels.length){
					next = levels.length - 1
				}
			}
			return ofDifficulty( levels[next] )
		}
		public function harderThan(difficulty:Number):Object{
			return nextOf(difficulty, 1)
		}
		public function easierThan(difficulty:Number):Object{
			return nextOf(difficulty, -1)
		}
		
		public function ofDifficulty(difficulty:Number):Object{
			if(levels.indexOf(int(difficulty)) == -1){
				difficulty = levels[0]
			}
			return Random.shuffle(trials[difficulty])[0]
		}
	}
}