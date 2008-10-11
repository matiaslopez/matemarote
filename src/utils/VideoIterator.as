package utils {
	import utils.Random; 
	
	public class VideoIterator extends Object{
		public var longVideos:Array
		public var shortVideos:Array
		public var lastLongPlayed:int
		public var lastShortPlayed:int
		public var playCount:int = 0
		
		public function VideoIterator(shortVids:Array, longVids:Array){
			shortVideos = shortVids
			longVideos = longVids
		}
	
		public function resetCount():void{
			playCount = 0
		}
		public function next():String{
			var vids:Array
			var last:int
			if(playCount%4 == 0){
				vids = longVideos
				last = lastLongPlayed
			}else{
				vids = shortVideos
				last = lastShortPlayed
			}
			var chosen:int = Random.chooseNumber(vids.length, last)
			playCount++
			if(playCount%4 == 0){
				lastLongPlayed = chosen
			}else{
				lastShortPlayed = chosen
			}
			return vids[ chosen ]
		}
	
	}
}