/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events 
{
	import flash.events.Event;
	
	import system.Reflection;	

	/**
	 * <code class="prettyprint">BasicEvent</code> is the basical event structure to work with <code class="prettyprint">vegas.events.EventDispatcher</code>.
	 * <p><b>Example</b></p>
	 * <pre class="prettyprint"> 
	 * var e:BasicEvent = new BasicEvent(type:String, target, context) ;
	 * </pre> 
	 * @author  eKameleon
	 * @see Event	
	 */
	public class BasicEvent extends Event 
	{

		/**
		 * Creates a new <code class="prettyprint">BasicEvent</code> instance.
		 * <pre class="prettyprint">
		 * var e:BasicEvent = new BasicEvent( type:String, [target:Object, [context:*, [bubbles:Boolean, [cancelable:Boolean, [time:Number]]]]]) ;
	 	 * </pre>
		 * @param type the string type of the instance. 
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 	 */
		public function BasicEvent( type:String  , target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			
			super( type , bubbles, cancelable );
			
			_context = (getContext() != null) ? getContext() : context ;
			_target  = (getTarget() != null)  ? getTarget()  : target ;	
			_time    = ( time > 0) ? time : ( (new Date()).valueOf() ) ;
			_type    = type ;
			 
		}

		/**
		 * Returns the optional context of this event.
		 * @return an object, corresponding the optional context of this event.
		 */
		public function get context():*
		{
			return getContext() ;	
		}
		
		/**
		 * Sets the optional context of this event.
		 */
		public function set context(o:*):void 
		{
			setContext(o) ;	
		}

		/**
		 * Returns the event target.
		 * @return the event target.
		 */
		public override function get target():Object
		{
			return getTarget() ;	
		}
	
		/**
		 * Sets the event target.
		 */
		public function set target(o:Object):void 
		{
			setTarget(o) ;	
		}
		
		/**
		 * Returns the timestamp of the event.
		 * @return the timestamp of the event.
		 */
		public function get timeStamp():Number 
		{
			return getTimeStamp() ;	
		}
		
		/**
		 * Returns the type of event.
		 * @return the type of event.
		 */
		public override function get type():String 
		{
			return _type ;	
		}
	
		/**
		 * Sets the type of event.
		 */
		public function set type(s:String):void 
		{
			setType(s) ;	
		}

		/**
		 * Dispatch the event with the global event flow.
		 * @see EventDispatcher.getInstance() static method.
		 */
		public function dispatch( channel:String=null ):void
		{
			EventDispatcher.getInstance( channel ).dispatchEvent( this ) ;
		}

		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new BasicEvent( type, target, context ) ;
		}

		/**
		 * Returns the optional context of this event.
		 * @return an object, corresponding the optional context of this event.
	 	 */
		public function getContext():* 
		{
			return _context ;
		}
		
		/**
		 * Returns the event target.
	 	 * @return the event target.
		 */
		public function getTarget():Object 
		{
			return _target ;
		}

		/**
		 * Returns the timestamp of the event.
		 * @return the timestamp of the event.
		 */
		public function getTimeStamp():Number 
		{	
			return _time ;
		}
		
		/**
		 * Returns the type of event.
	 	 * @return the type of event.
		 */
		public function getType():String 
		{
			return _type ;
		}

		/**
		 * Sets the optional context object of this event. 
		 */
		public function setContext(context:*):void 
		{
			_context = context || null ;
		}
		
		/**
	 	 * Sets the event target.
		 */
		public function setTarget(target:Object):void 
		{
			_target = target || null ;
		}

		/**
		 * Sets the event type of this event.
		 */
		public function setType( type:String ):void 
		{
			_type = type || null ;
		}
	
		/**
	 	 * Returns the string representation of this event.
	 	 * @return the string representation of this event.
	 	 */
		public override function toString():String 
		{
			return formatToString( Reflection.getClassName(this), "type", "target", "context", "bubbles", "cancelable", "eventPhase" ); 
		}
		
		/**
		 * @private
		 */
		private var _context:* = null ;

		/**
		 * @private
		 */
		private var _target:Object = null ;

		/**
		 * @private
		 */
		private var _time:Number ;

		/**
		 * @private
		 */
		private var _type:String ;
		
		/**
		 * Sets the timestamp of the event (used this method only in internal in the Event class).
		 */
		protected function setTimeStamp( time:Number ):void 
		{
			_time = (time >= 0) ? time : (new Date()).valueOf() ;	
		}

	}
	
		
}
