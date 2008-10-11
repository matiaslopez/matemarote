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
package andromeda.ioc.factory.strategy 
{

    /**
     * This stategy create an object in the IoC factory with an easy value if the attribute "factoryValue" is used in the object definition.
     * @author eKameleon
     */
    public class ObjectFactoryValue implements IObjectFactoryStrategy
    {
        
        /**
         * Creates a new ObjectFactoryValue instance.
         * @param value The value used in the factory strategy. 
         */
        public function ObjectFactoryValue( value:* )
        {
            this.value = value ;
        }
        
        /**
         * The value of this strategy factory.
         */
        public var value:* ;        
        
        /**
         * Returns the ObjectFactoryValue representation of the specified value or null.
         * @return the ObjectFactoryValue representation of the specified value or null.
         */
        public static function build( value:*=null ):ObjectFactoryValue
        {
            return new ObjectFactoryValue( value ) ;
        }
                
    }
}
