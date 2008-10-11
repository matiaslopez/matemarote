/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.media
{
    import vegas.data.map.HashMap;
    import vegas.errors.Warning;    

    /**
     * This collector use a Map to register all Displays in the application.
     * @author eKameleon
     */
    public class SoundCollector
    {
    
        /**
         * Clear the SoundCollector.
         */
        public static function clear():void 
        {
            _map.clear() ;    
        }
    
        /**
         * Returns 'true' if the SoundCollector contains the display's id.
         * @return 'true' if the SoundCollector contains the display's id.
         */    
        public static function contains( id:* ):Boolean 
        {
            return _map.containsKey( id ) ;    
        }

        /**
         * Returns the CoreSound object register in the collector with the id passed-in argument.
         * @return the CoreSound object register in the collector with the id passed-in argument.
         */    
        public static function get( id:* ):CoreSound 
        {
            if ( !contains( id ) ) 
            {
                throw new Warning("[SoundCollector].get('" + id + "'). Can't find CoreSound instance." ) ;
            }
            return _map.get( id ) as CoreSound ;    
        }
    
        /**
         * Insert a CoreSound object with an unique id into the SoundCollector.
         * @param id the Id of the display to register
         * @param sound The CoreSound object to insert in the collector.
         */
        public static function insert( id:*, sound:CoreSound ):Boolean 
        {
            if ( contains(id) ) 
            {
                throw new Warning("[SoundCollector] insert method failed. A CoreSound instance is already registered with '" + id + "' name." ) ;
            }
            return _map.put(id, sound) == null  ;    
        }
    
        /**
         * Returns 'true' if the SoundCollector is 'empty'.
         * @return 'true' if the SoundCollector is 'empty'.
         */
        public static function isEmpty():Boolean 
        {
            return _map.isEmpty() ;    
        }
    
        /**
         * Removes the specified CoreSound object into the SoundCollector.
         */
        public static function remove( id:* ):void     
        {
            _map.remove(id) ;
        }

        /**
         * Returns the size of the SoundCollector.
         * @return the size of the SoundCollector.
         */
        public static function size():uint     
        {
            return _map.size() ;
        }
    
        /**
         * Internal hashmap to collect all CoreSound object in the application.
         */
        private static var _map:HashMap = new HashMap() ;
        
    }
}