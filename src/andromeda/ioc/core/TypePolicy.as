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
     * The static enumeration list of all type policies in the ObjectConfig object of the ioc factory.
     * @author eKameleon
     */
    public class TypePolicy
    {

        /**
         * Defines the 'alias' TypePolicy value. 
         * Use it if you want use only type "alias" evaluation when a new object is created in the factory. 
         */
        public static const ALIAS:String = "alias" ;
         
        /**
         * Defines the 'all' TypePolicy value. 
         * Use it if you want use only all evaluation filters when a new object is created in the factory. 
         */
        public static const ALL:String = "all" ;     
        
        /**
         * Defines the 'expression' TypePolicy value. 
         * Use it if you want use only type "expression" evaluation when a new object is created in the factory. 
         */
        public static const EXPRESSION:String = "expression" ;        
        
        /**
         * Defines the 'none' TypePolicy value.
         * Use it if you want no evaluation filter when a new object is created in the factory. 
         */
        public static const NONE:String = "none" ;
        
    }
    
}
