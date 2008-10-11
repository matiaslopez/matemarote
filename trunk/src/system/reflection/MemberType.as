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
     * The member type enumeration class.
     */
    public class MemberType extends Enum
        {
        
        /**
         * Creates a new MemberType instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function MemberType( value:int=0, name:String="" )
            {
            super( value, name );
            }
        
        /**
         * The "variable" member type value.
         */
        public static const variable:MemberType = new MemberType( 1, "variable" );

        /**
         * The "constant" member type value.
         */
        public static const constant:MemberType = new MemberType( 2, "constant" );

        /**
         * The "accessor" member type value.
         */
        public static const accessor:MemberType = new MemberType( 3, "accessor" );

        /**
         * The "method" member type value.
         */
        public static const method:MemberType   = new MemberType( 4, "method" );

        }
    }

