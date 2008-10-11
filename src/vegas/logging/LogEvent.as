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

package vegas.logging
{
    import flash.events.Event;

	/**
     * Represents the log information for a single logging event. The loging system dispatches a single event each time a process requests information be logged. This event can be captured by any object for storage or formatting.
     * @author eKameleon 
     */
    public class LogEvent extends Event
    {
        
        /**
         * Creates a new LogEvent.
         */
        public function LogEvent(context:* , level:LogEventLevel )
        {
            super(LogEvent.LOG, false, false);
            this.message = context ;
            this.level = (level == null) ? LogEventLevel.ALL : level ;
            
        }
        
        /**
         * Event type constant, identifies a logging event.
         */
        public static const LOG:String = "log";

        /**
         * Provides access to the level for this log event.
         */
        public var level:LogEventLevel ;
        
        /**
         * Provides access to the message that was logged.
         */
        public var message:* ;

        /**
         * Returns the shallow copy of the event.
         * @return the shallow copy of the LogEvent event.
         */
        public override function clone():Event
        {
            return new LogEvent(message, level);
        }

        /**
         * Returns a string value representing the level specified.
         */
        public static function getLevelString( value:LogEventLevel ):String
        {
           if (LogEventLevel.isValidLevel(value))
           {
                return value.toString() ;   
           }
           else
           {
                return "UNKNOWN" ;  
           }
        }

        
    }
        
}