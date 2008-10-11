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
	
	import andromeda.events.ActionEvent;
	
	import pegas.transitions.ITransition;	

	/**
	 * This TransitionEvent class is used by the ITransition process objects.
	 * @author eKameleon
	 */
	public class TransitionEvent extends ActionEvent 
	{


		/**
		 * Creates a new TransitionEvent instance.
		 * @param type the string type of the instance. 
		 * @param target the target of the event.
		 * @param info The information object of this event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this parameter is used in the Eden deserialization.
	 	 */
		public function TransitionEvent(type:String, target:Object = null, info:* = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0)
		{
			super( type, target, info, context, bubbles, cancelable, time );
		}
		
		/**
		 * Returns the ITransition reference of this event.
		 * @return the ITransition reference of this event.
		 */
		public function get transition():ITransition
		{
			return _t ;
		}
		
		/**
	 	 * Sets the ITransition reference of this event.
	 	 */
		public function set transition( transition:ITransition ):void
		{
			_t = transition ;
		}
		
		/**
		 * Returns the ITransition id of this event.
		 * @return the ITransition id of this event.
		 */
		public function get transitionID():String
		{
			return _tID ;
		}


		/**
		 * Sets the ITransition id of this event.
	 	 */
		public function set transitionID( id:String ):void
		{
			_tID = id ;
		}

	    /**
    	 * Returns the shallow copy of this object.
    	 * @return the shallow copy of this object.
    	 */
		public override function clone():Event 
		{
			var e:TransitionEvent = new TransitionEvent( type, target, info, context ) ;
			e.transition          = transition ;
			e.transitionID        = transitionID ;
			return e ;
		}

		/**
		 * The internal ITransition reference of this event.
		 */
		private var _t:ITransition ;

		/**
		 * The internal ITransition ID of this event.
		 */
		private var _tID:String ;
		
	}

}
