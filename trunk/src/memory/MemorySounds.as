package memory{
    import utils.Sounds;
    import flash.media.Sound;

    public class MemorySounds extends Sounds {
        [Embed(source="../../res/audio/memory/click_bien.mp3")]
        public var bien:Class;
        [Embed(source="../../res/audio/memory/click_mal.mp3")]
        public var mal:Class;
        [Embed(source="../../res/audio/memory/mezclando.mp3")]
        public var mezclando:Class;
        
        public function MemorySounds(){
            for each(var name:String in ['bien', 'mal', 'mezclando']){
        		sounds[name] = new this[name]() as Sound
        	}
        }
    }
}

