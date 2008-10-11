package planning{
    import utils.Sounds;
    import flash.media.Sound;

    public class PlanningSounds extends Sounds {
        [Embed(source="../../res/audio/planning/drag_sound.mp3")]
        public var arrastrando:Class;
        [Embed(source="../../res/audio/planning/droppable_sound.mp3")]
        public var soltando:Class;
        [Embed(source="../../res/audio/planning/levantar.mp3")]
        public var levantar:Class;
        [Embed(source="../../res/audio/planning/soltar_bien.mp3")]
        public var bien:Class;
        [Embed(source="../../res/audio/planning/soltar_mal.mp3")]
        public var mal:Class;
        
        public function PlanningSounds(){
            for each(var name:String in ['bien', 'mal', 'arrastrando', 'soltando', 'levantar']){
        		sounds[name] = new this[name]() as Sound
        	}
        }
    }
}

