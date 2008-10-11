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

	/**
     * The <code class="prettyprint">CommandEvent</code> to dispatch an event with a Command object inside.
     * @author eKameleon
     */
	public class CommandEvent extends BasicEvent 
	{
        
		/**
		 * Creates a new <code class="prettyprint">BooleanEvent</code> instance.
		 * @param type the string type of the instance. 
		 * @param co The Command of the event.
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 	 */
		public function CommandEvent( type:String=null , co:Command=null ,target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			super(type, target, context, bubbles, cancelable, time) ;
			setCommand(co) ;
		}
        
		/**
		 * The name of the event invoked to run a command.
		 */
		public static var RUN_COMMAND:String = "onRunCommand" ;
        
		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new CommandEvent(type, getCommand(), target, context) ;
		}
		
		/**
	 	 * Returns the Command reference.
	 	 * @return the Command reference.
	 	 */
		public function getCommand():Command
		{
			return _co ;
		}
		
		/**
	 	 * Sets the Command reference.
	 	 */
		public function setCommand( co:Command ):void
		{
			_co = co ;
		}
		
		private var _co:Command ;
        
    }
		
}
