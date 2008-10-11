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
     * This object create a proxy factory configured in the IObjectDefinition and replace the natural factory of the ObjectFactory.
     * @author eKameleon
     */
    public class ObjectFactoryProperty extends ObjectProperty implements IObjectFactoryStrategy 
    {

        /**
         * Creates a new ObjectFactoryProperty instance.
         * @param factory The string name of the reference in the factory used to create the object.
         * @param name The name of the property.
         * @param evaluators The Array representation of all evaluators who evaluate the value of the property.
         */
        public function ObjectFactoryProperty( factory:String, name:String, evaluators:Array = null )
        {
            super( name, null, null, evaluators ) ;
            this.factory = factory ;
        }
        
        /**
         * The factory string representation of the reference of this factory method object.
         */
        public var factory:String ;         
        
        /**
         * Returns the ObjectFactoryMethod representation of the specified generic object or null.
         * @return the ObjectFactoryMethod representation of the specified generic object or null.
         */
        public static function build( o:Object=null ):ObjectFactoryProperty
        {
            if ( o == null ) 
            {
                return null ;
            }
            if ( ObjectAttribute.FACTORY in o && ObjectAttribute.NAME in o )
            {
                return new ObjectFactoryProperty
                ( 
                    o[ ObjectAttribute.FACTORY    ] , 
                    o[ ObjectAttribute.NAME       ] ,
                    o[ ObjectAttribute.EVALUATORS ] 
                ) ;
            }
            else
            {
                return null ;
            }       
        }     
        
    }
}
