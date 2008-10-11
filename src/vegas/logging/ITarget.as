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

    /**
     * All logger target implementations within the logging framework must implement this interface.
     * @author eKameleon
     */
    public interface ITarget
    {
        
        /**
         * (read-write) Returns the filters array of this target.
         * <p>In addition to the level setting, filters are used to provide a psuedo-hierarchical mapping for processing only those events for a given category.</p>
         * @return the filters array of this target.
         */
        function get filters():Array ;

        /**
         * (read-write) Sets the filters array of this target.
         * <p>In addition to the level setting, filters are used to provide a psuedo-hierarchical mapping for processing only those events for a given category.</p>
         */
        function set filters( value:Array ):void ;
    
        /**
         * (read-write) Returns the level of this target. 
         * Provides access to the level this target is currently set at.
         * @return the level of this target.
         */ 
        function get level():LogEventLevel ;

        /**
         * (read-write) Sets the level of this target. 
         * Provides access to the level this target is currently set at.
         */ 
        function set level( value:LogEventLevel ):void ;
    
        /**
         * Sets up this target with the specified logger.
         * Note : this method is called by the framework and should not be called by the developer.
         */
        function addLogger(logger:ILogger):void ;
        
        /**
         * Stops this target from receiving events from the specified logger.
         * Note : this method is called by the framework and should not be called by the developer.
         */
        function removeLogger(logger:ILogger):void ;
        
    }
    
}