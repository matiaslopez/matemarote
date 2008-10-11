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
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  Marc Alcaraz <ekameleon@gmail.com>

*/
package system.reflection
    {
    import system.Enum;

    /**
     * This enumeration contains all accessor types.
     */
    public class AccessorType extends Enum
        {
        
        /**
         * Creates a new AccessorType instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function AccessorType( value:int, name:String )
            {
            super(value, name);
            }
        
        /**
         * Determinates the "readOnly" accessor type value.
         */
        public static const readOnly:AccessorType  = new AccessorType( 1, "readonly" );

        /**
         * Determinates the "writeOnly" accessor type value.
         */
        public static const writeOnly:AccessorType = new AccessorType( 2, "writeonly" );
        
        /**
         * Determinates the "readWrite" accessor type value.
         */
        public static const readWrite:AccessorType = new AccessorType( 3, "readwrite" );
        
        }
    }

