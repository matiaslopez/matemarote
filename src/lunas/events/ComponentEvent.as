/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.events 
{
	import flash.events.Event;
	
	import vegas.events.BasicEvent;	

	/**
	 * The event invoked in the button or thumbs.
	 * @author eKameleon
	 */
	public class ComponentEvent extends BasicEvent 
	{

		/**
		 * Creates a new ComponentEvent instance.
		 * @param type the string type of the instance. 
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
		 */
		public function ComponentEvent(type:String, target:Object = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0)
		{
			super( type, target, context, bubbles, cancelable, time );
		}

		/**
		 * Defines the value of the type property of a 'change' event object.
		 */
		public static var CHANGE:String = Event.CHANGE ;

		/**
		 * Defines the value of the type property of a 'clear' event object.
		 */
		public static var CLEAR:String = "clear" ;

		/**
		 * Defines the value of the type property of an 'enabled' component.
		 */
		public static var ENABLED:String = "enabled" ;

		/**
		 * Defines the value of the type property of an 'enter' component.
		 */
		public static var ENTER:String = "enter" ;

		/**
		 * Defines the value of the type property of an 'hide' component.
		 */
		public static var HIDE:String = "hide" ;

		/**
		 * Defines the value of the type property of an icon change event object.
		 */
		public static var ICON_CHANGE:String = "iconChange" ;

		/**
		 * Defines the value of the type property of a label change event object.
		 */
		public static var LABEL_CHANGE:String = "labelChange" ;

		/**
		 * Defines the value of the type property of an 'move' component.
		 */
		public static var MOVE:String = "move" ;

		/**
		 * Defines the value of the type property of an 'resize' component.
		 */
		public static var RESIZE:String = "resize" ;

		/**
		 * Defines the value of the type property of an 'scroll' component.
		 */
		public static var SCROLL:String = Event.SCROLL ;

		/**
		 * Defines the value of the type property of an 'show' component.
		 */
		public static var SHOW:String = "show" ;

		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new ComponentEvent( type, target, context ) ;
		}
		
	}

}
