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
    import andromeda.ioc.core.ObjectAttribute;
    import andromeda.ioc.core.ObjectProperty;    

    /**
     * This object create a static proxy factory configured in the IObjectDefinition and replace the natural factory of the ObjectFactory.
     * @author eKameleon
     */
    public class ObjectStaticFactoryProperty extends ObjectProperty implements IObjectFactoryStrategy 
    {

        /**
         * Creates a new ObjectStaticFactoryProperty instance.
         * @param type The type of the static class use to create the object reference with a static property or constant.
         * @param name The name of the static property or constant to invoke to create the object "reference".
         * @param evaluators The Array representation of all evaluators who evaluate the value of the property.
         */
        public function ObjectStaticFactoryProperty(name:String, type:String , evaluators:Array = null)
        {
            super( name, null, null, evaluators );
            this.type = type ;
        }
        
        /**
         * The string representation of the type name of the static factory class.
         */
        public var type:String ;        
        
        /**
         * Returns the ObjectStaticFactoryProperty representation of the specified generic object or null.
         * @return the ObjectStaticFactoryProperty representation of the specified generic object or null.
         */
        public static function build( o:Object=null ):ObjectStaticFactoryProperty
        {
            if ( o == null ) 
            {
                return null ;
            }
            if ( ObjectAttribute.TYPE in o && ObjectAttribute.NAME in o )
            {
                return new ObjectStaticFactoryProperty
                ( 
                    o[ ObjectAttribute.NAME       ] as String , 
                    o[ ObjectAttribute.TYPE       ] as String , 
                    o[ ObjectAttribute.EVALUATORS ] as Array 
                ) ;
            }
            else
            {
                return null ;
            }       
        }           
        
    }
}
