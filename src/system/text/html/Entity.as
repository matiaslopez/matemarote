/*
  
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

    - Marc Alcaraz <ekameleon@gmail.com>

*/
package system.text.html
    {
    
    /**
     * The Entity class.
     */
    public class Entity
        {
        
        /**
         * The String char value of the entity.
         */
        public var char:String;

        /**
         * The String name value of the entity.
         */
        public var name:String;

        /**
         * The Number value of the entity.
         */
        public var number:int;
        
        /**
         * Creates a new Entity instance.
         * @param char The entity character value.
         * @param name The entity name of the specified character.
         * @param number The entity number representation of the specified character.
         */
        public function Entity( char:String, name:String, number:int )
            {
            this.char   = char   ;
            this.name   = name   ;
            this.number = number ;
            }
        
        
        /**
         * Returns the 'entity number' string representation of the entity.
         * @return the 'entity number' string representation of the entity.
         */
        public function toNumber():String
            {
            return "&#"+number+";" ;
            }
        
        /**
         * Returns the 'entity string' representation of the entity.
         * @return the 'entity string' representation of the entity.
         */
        public function toString():String
            {
            return "&"+name+";" ;
            }
        
        /**
         * Returns the character value of the entity.
         * @return the character value of the entity.
         */
        public function valueOf():String
            {
            return char ;
            }
        
        }
    }

