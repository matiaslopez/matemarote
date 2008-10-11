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
	
	import lunas.core.IStyle;
	
	import vegas.events.BasicEvent;	

	/**
	 * The <code class="prettyprint">StyleEvent</code> to dispatch an event with an <code class="prettyprint">IStyle</code> object.
	 * @author eKameleon
	 */
	public class StyleEvent extends BasicEvent 
	{
		
		/**
		 * Creates a new StyleEvent instance.
		 * @param type the string type of the instance. 
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
		 */
		public function StyleEvent(type:String, target:* = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0)
		{
			super( type, target, context, bubbles, cancelable, time );
		}
		
		/**
		 * The type event name of the StyleEvent when the style is changed in the component.
		 */
		public static const STYLE_CHANGE:String = "styleChange" ;
		
		/**
		 * The type event name of the StyleEvent when the styleSheet in the IStyle is changed.
	 	 */
		public static const STYLE_SHEET_CHANGE:String = "styleSheetChange" ;
		
		/**
		 * Returns the IStyle reference of this event.
		 * @return the IStyle reference of this event.
		 */
		public function get style():IStyle 
		{
			return target as IStyle ;
		}
		
		/**
		 * Sets the IStyle reference of this event.
		 */
		public function set style( style:IStyle ):void 
		{
			target = style ;
		}

		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new StyleEvent( type, style, context ) ;
		}
		
	}
	
}
