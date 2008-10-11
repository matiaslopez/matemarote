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
    import andromeda.ioc.core.ObjectArgument;
    import andromeda.ioc.core.ObjectAttribute;
    import andromeda.ioc.core.ObjectMethod;    

    /**
     * This object create a static proxy factory configured in the IObjectDefinition and replace the natural factory of the ObjectFactory.
     * @author eKameleon
     */
    public class ObjectStaticFactoryMethod extends ObjectMethod implements IObjectFactoryStrategy 
    {
        
        /**
         * Creates a new ObjectStaticFactoryMethod instance.
         * @param type The type of the static class use to create the object with a static method.
         * @param name The name of the static method to invoke to create the object.
         * @param arguments The array of the arguments to passed-in the factory method.
         */
        public function ObjectStaticFactoryMethod( type:String , name:String , arguments:Array =null )
        {
            super( name , arguments ) ;
            this.type = type ;
        }

        /**
         * The string representation of the type name of the static factory class.
         */
        public var type:String ;
        
        /**
         * Returns the ObjectStaticFactoryMethod representation of the specified generic object or null.
         * @return the ObjectStaticFactoryMethod representation of the specified generic object or null.
         */
        public static function build( o:Object = null ):ObjectStaticFactoryMethod
        {
            if ( o == null ) 
            {
                return null ;
            }
            if ( ObjectAttribute.TYPE in o && ObjectAttribute.NAME in o )
            {
                return new ObjectStaticFactoryMethod
                ( 
                    o[ ObjectAttribute.TYPE ] as String , 
                    o[ ObjectAttribute.NAME ] as String , 
                    ObjectArgument.create( o[ ObjectAttribute.ARGUMENTS ] as Array )
                ) ;
            }
            else
            {
                return null ;
            }        
        }
        
    }
}
