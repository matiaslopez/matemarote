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
    
    import flash.events.EventDispatcher;
    
    /**
     * The logger that is used within the logging framework. This class dispatches events for each message logged using the log() method.
     * @author eKameleon
     */
    public class LogLogger extends EventDispatcher implements ILogger
    {
        
        /**
         * Creates a new LogLogger instance.
         */
        public function LogLogger( category:String )
        {
            super() ;
            _category = category;
        }
        
        /**
         * Returns the category of this logger.
         * @return the category of this logger.
         */
        public function get category():String
        {
            return _category ;
        }

        /**
         * Logs the specified data using the LogEventLevel.DEBUG level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function debug(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.DEBUG, context].concat(rest) ) ;
        }

        /**
         * Logs the specified data using the LogEventLevel.ERROR level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function error(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.ERROR, context].concat(rest) ) ;
        }

        /**
         * Logs the specified data using the LogEventLevel.FATAL level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.     
         */
        public function fatal(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.FATAL, context].concat(rest) ) ;

        }

        /**
         * Logs the specified data using the LogEvent.INFO level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function info(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.INFO, context].concat(rest) ) ;
        }

        /**
         * Logs the specified data at the given level.
         * @param level The level this information should be logged at. Valid values are:<p>
         * <li>LogEventLevel.FATAL designates events that are very harmful and will eventually lead to application failure</li>
         * <li>LogEventLevel.ERROR designates error events that might still allow the application to continue running.</li>
         * <li>LogEventLevel.WARN designates events that could be harmful to the application operation</li>
         * <li>LogEventLevel.INFO designates informational messages that highlight the progress of the application at coarse-grained level.</li>
         * <li>LogEventLevel.DEBUG designates informational level messages that are fine grained and most helpful when debugging an application.</li>
         * <li>LogEventLevel.ALL intended to force a target to process all messages.</li></p>
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function log(level:LogEventLevel, context:*, ...rest):void
        {
            
            if (level < LogEventLevel.DEBUG)
            {
                throw new ArgumentError("Level must be less than LogEventLevel.ALL.");
            }
            
           _log.apply( this, [level, context].concat(rest) ) ;
           
        }

        /**
         * Logs the specified data using the LogEventLevel.WARN level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * 
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function warn(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.WARN, context].concat(rest) ) ;
        }
        
        /**
         * Internal category value.
         */
        private var _category:String ;
        
        /**
         * Internal log method.
         */
        private function _log( level:LogEventLevel, context:*, ...rest ):void
        {
            
            if(hasEventListener(LogEvent.LOG))
            {
            
                if (context is String)
                {
                    var len:uint = rest.length ;
                    for(var i:uint = 0; i<len ; i++)
                    {
                       context = (context as String).replace(new RegExp("\\{"+i+"\\}", "g"), rest[i]);
                    }
                }

                dispatchEvent( new LogEvent( context, level ) ) ;
                
            }
            
        }
        
    }

}