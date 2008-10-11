/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.events 
{
	import flash.events.Event;
	
	import pegas.transitions.TweenEntry;
	
	import vegas.events.BasicEvent;	

	/**
	 * This event dispatch a TweenEntry.
	 * @author eKameleon
 	 */
	public class TweenEntryEvent extends BasicEvent 
	{

		/**
		 * Creates a new TweenEntryEvent instance.
	 	 * @param type the string type of the instance. 
		 * @param target the target of the event.
	 	 * @param context the optional context object of the event.
	 	 * @param bubbles indicates if the event is a bubbling event.
	 	 * @param cancelable indicates if the event is a cancelable event.
	 	 * @param time this parameter is used in the Eden deserialization.
	 	 */
		public function TweenEntryEvent(type:String, target:Object = null, entry:TweenEntry=null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0)
		{
			super( type, target, context, bubbles, cancelable, time );
			if ( entry != null )
			{
				setTweenEntry( entry ) ;	
			}
		}
		
		/**
		 * Default event type when a tween entry is added.
		 */
		public static var ADD_ENTRY:String = "onAddEntry" ;
		
		/**
	 	 * Default event type when all tween entries are removed.
	 	 */
		public static var CLEAR_ENTRY:String = "onClearEntry" ;
		
		/**
		 * Default event type when a tween entry is removed.
		 */
		public static var REMOVE_ENTRY:String = "onRemoveEntry" ;
		
	    /**
    	 * Returns the shallow copy of this object.
    	 * @return the shallow copy of this object.
    	 */
		public override function clone():Event 
		{
			return new TweenEntryEvent( type, target, getTweenEntry(), context ) ;
		}
		
		/**
		 * Returns the TweenEntry reference of this event.
		 * @return the TweenEntry reference of this event.
		 */
		public function getTweenEntry():TweenEntry
		{
			return _entry ;
		}
			
		/**
	 	 * Sets the TweenEntry reference of this event.
	 	 */
		public function setTweenEntry( entry:TweenEntry ):void
		{
			_entry = entry ;
		}
		
		/**
		 * The internal TweenEntry reference of this event.
		 */
		private var _entry:TweenEntry ;
		
	}

}
