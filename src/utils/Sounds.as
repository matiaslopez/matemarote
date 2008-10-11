package utils{
    import flash.media.Sound;
    import flash.media.SoundChannel;

    public class Sounds extends Object {
        public var sounds:Object = {}
        public var channels:Object = {}
        public var soundClasses:Array = []
                
        public function play(name:String, loops:int=0):void{
        	channels[name] = sounds[name].play(0, loops)
        }
        
        public function stop(name:String):void{
        	if(channels[name]){
        		channels[name].stop()
        		channels[name] = null
        	}
        }
        
        public function isPlaying(name:String):Boolean{
        	return Boolean(channels[name])
        }
    }
}

