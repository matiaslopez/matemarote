/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{

    /**
     * The static enumeration list of all object scopes.
     * @author eKameleon
     */
    public class ObjectScope 
    {
        
        /**
         * Defines the scope of a single object definition to any number of object instances.
         */
        public static const PROTOTYPE:String = "prototype" ;  
                
        /**
         * Defines the scope of a single object definition to a single object instance per IoC container.
         */
        public static const SINGLETON:String = "singleton" ;  

        /**
         * Returns an array representation of all object scopes constants.
          * @return an array representation of all object scopes constants.
         */
        public static function getScopes():Array 
        {
            return [PROTOTYPE, SINGLETON] ;
        }        
        
        /**
         * Returns true if the passed value is a valid scope reference.
         * @return true if the passed value is a valid scope reference.
         */
        public static function validate( scope:String ):Boolean 
        {
            return getScopes().indexOf( scope ) > -1 ;
        }
        
        
    }
}
