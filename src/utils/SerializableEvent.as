package utils
{
	import flash.events.Event;

	public class SerializableEvent extends Event{
		public var event_data:Object
		public var time:Number
		public var order:Number
		
		public function SerializableEvent(type:String, data:Object=null, the_time:Number=0){
			super(type, bubbles, cancelable);
			event_data = data
			time = the_time || new Date().getTime()
		}
		
		override public function clone():Event{
			return new SerializableEvent(type, event_data, time);
		}
		
	}
}