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
    import system.Strings;
    
    import vegas.events.CoreEventDispatcher;
    import vegas.logging.errors.InvalidFilterError;    

    /**
     * This class provides the basic functionality required by the logging framework for a target implementation. It handles the validation of filter expressions and provides a default level property. No implementation of the logEvent() method is provided.
     * @author eKameleon
     */
    public class AbstractTarget extends CoreEventDispatcher implements ITarget
    {
        
        /**
         * Creates a new AbstractTarget instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function AbstractTarget( bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal , sChannel );
        }

        /**
         * The static field used when throws an Error when a character is invalid.
         */        
        public static var charsInvalid:String = "The following characters are not valid\: []~$^&\/(){}<>+\=_-`!@#%?,\:;'\\" ;

        /**
         * The static field used when throws an Error when filter failed.
         */        
        public static var errorFilter:String = "Error for filter \''{0}'" ;
        
        /**
         * The static field used when throws an Error when the character placement failed.
         */        
        public static var charPlacement:String = "'*' must be the right most character." ;

        /**
         * (read-write) Returns the filters array representation of this target.
         */
        public function get filters():Array
        {
            return _filters ;
        }
        
        /**
         * (read-write) Sets the filters array of this target.
         */
        public function set filters( value:Array ):void
        {
            if (value != null && value.length > 0)
            {
                var filter:String ;
                var index:int ;
                
                var len:uint = value.length ;
                for (var i:uint = 0; i<len; i++)
                {
                    filter = value[i] ;
                    // check for invalid characters
                    if ( Log.hasIllegalCharacters(filter) )
                    {
                         throw new InvalidFilterError( Strings.format(errorFilter, filter ) + charsInvalid );
                    }

                    index = filter.indexOf("*") ;
                    if ((index >= 0) && (index != (filter.length -1)))
                    {                        
                        throw new InvalidFilterError(Strings.format( errorFilter, filter) + charPlacement);
                    }
                }
            }
            else
            {
                // if null was specified then default to all
                value = ["*"];
            }

            if (_loggerCount > 0)
            {
                Log.removeTarget(this);
                _filters = value;
                Log.addTarget(this);
            }
            else
            {
                _filters = value;
            }
            
        }
        
        /**
         * (read-write) Returns the level of this target.
         */
        public function get level():LogEventLevel
        {
            return _level ;
        }

        /**
         * (read-write) Sets the level of this target.
         */
        public function set level( value:LogEventLevel ):void
        {
            Log.removeTarget(this);
            _level = value;
            Log.addTarget(this);     
        } 

        /**
         * Insert a category in the fllters if this category don't exist.
         * Returns a boolean if the category is add in the list.
         */
        public function addCategory( category:String ):Boolean 
        {
            
            if ( _filters.indexOf( category ) == -1 ) 
            {
                return false ;
            }
            
            _filters.push( category ) ;
            
            return true ;
            
        }
        
        /**
         * Sets up this target with the specified logger.
         * Note : this method is called by the framework and should not be called by the developer.
         */
        public function addLogger(logger:ILogger):void 
        {
            if ( logger != null )
            {
                _loggerCount++;
                
                logger.addEventListener(LogEvent.LOG, _logHandler);
            }
        }

        /**
         * Add a new namespace in the filters array.
         */
        public function addNamespace(nameSpace:String):Boolean 
        {
            if (filters == null) 
            {
                filters = [] ;
            }
            if ( filters.indexOf( nameSpace ) > -1 ) 
            {
                return false ;
            }
            else
            {
                filters.push( nameSpace ) ;
                return true ;
            }
        }

        /**
         *  This method handles a <code class="prettyprint">LogEvent</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate
         *  format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the
         *  target's level.
         *
         *  <b><i>Descendants need to override this method to make it useful.</i></b>
         */        
        public function logEvent(event:LogEvent):void
        {
            // override please.
        }

        /**
         * Remove a category in the fllters if this category exist.
         * Returns a boolean if the category is remove.
         */
        public function removeCategory( category:String ):Boolean
        {
            
            var pos:Number = _filters.indexOf( category ) ;
            if ( pos > -1) 
            {
                _filters.splice(pos, 1) ;
                return true ;
            }
            else 
            {
                return false ;
            }
            
        }

        /**
         * Stops this target from receiving events from the specified logger.
         */
        public function removeLogger(logger:ILogger):void {
            
            if (logger != null)
            {
                _loggerCount--;
                logger.removeEventListener(LogEvent.LOG, _logHandler);
            }
            
        }
        
        /**
         * Removes an existing namespace in the filters array.
         */
        public function removeNamespace( nameSpace:String ):Boolean 
        {
            var pos:Number = filters.indexOf(nameSpace) ;
            if ( pos > -1) 
            {
                filters.splice(pos, 1) ;
                return true ;
            } 
            else 
            {
                return false ;
            }
        }
       
        /**
         * Storage for the filters property.
         */
        private var _filters:Array = ["*"] ;

        /**
         * Storage for the filters property.
         */
        private var _level:LogEventLevel = LogEventLevel.ALL ;

        /**
         * Count of the number of loggers this target is listening to. 
         * When this value is zero changes to the filters property shouldn't do anything.
         */
        private var _loggerCount:uint = 0 ;
        
        /**
         * This method will call the <code class="prettyprint">logEvent</code> method if the level of the
         * event is appropriate for the current level.
         */
        private function _logHandler( event:LogEvent ):void
        {
            if ( event.level.valueOf() >= level.valueOf() )
            {
                logEvent(event) ;
            }
        }
        
    }
}