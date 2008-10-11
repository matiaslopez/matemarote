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
  Marc Alcaraz <ekameleon@gmail.com>.

*/

package system.reflection
    {
    
    [ExcludeClass]

    /**
     * The concrete class of the TypeInfo interface.
     */
    public class _TypeInfo implements TypeInfo
        {
        
        protected var type:*;
        
        /**
         * Creates a new _TypeInfo instance.
         */
        public function _TypeInfo( o:* )
            {
            type = o;
            }
        
        /**
         * Indicates if the specified Class can be convert to an other with the "as" keyword.
         */
        public function canConvertTo( o:Class ):Boolean
            {
            return (type as o) != null;
            }

        /**
         * Indicates if the specified Class be used with the "is" keyword.
         */
        public function isSubtypeOf( o:Class ):Boolean
            {
            return type is o;
            }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
            {
            return "[TypeInfo]" ;
            }          
        
        }
    }

