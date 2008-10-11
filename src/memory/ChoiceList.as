package memory
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class ChoiceList extends ArrayCollection{
		public var index:int
		public static const SELECTION_CHANGE:String = "SELECTION_ARRAY_COLLECTION_SELECTION_CHANGED"
		
		public function ChoiceList(source:Array=null, newIndex:int=0){
			index = newIndex
			super(source);
		}
		
		public function setIndex(newSel:int):void{
			index = newSel
			dispatchEvent(new Event(SELECTION_CHANGE))
		}
		
		public function getIndex():int{
			return index
		}
		
		public function getItem():Object{
			return source[index]
		}
		
		public function stepUp():void{
			if(index < source.length -1 ){
				index ++
			}
			dispatchEvent(new Event(SELECTION_CHANGE))
		}
		
		public function stepDown():void{
			if(index > 0 ){
				index--
			}
			dispatchEvent(new Event(SELECTION_CHANGE))
		}
		
	}
}