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

    - Marc Alcaraz <ekameleon@gmail.com>

*/
package system
    {
    	
	/**
	 * This class determinates a basic implementation to creates enumeration objects.
	 */
    public class Enum implements Serializable
        {    	
    	
        /**
         * @private
         */
        private var _name:String ;
        
        /**
         * @private
         */
        private var _value:int ;
        
		/**
		 * Creates a new Enum instance.
		 * @param value The value of the enumeration.
		 * @param name The name key of the enumeration.
		 */
		public function Enum( value:int = 0 , name:String = "" )
		  {
			_value = value ;
			_name  = name  ;
		  }
        
		/**
		 * Returns the source code String representation of the object.
		 * @return the source code String representation of the object.
		 */
		public function toSource( indent:int = 0 ):String
            {
            var classname:String = Reflection.getClassName( this );
            if( _name != "" )
                {
                    return classname + "." + _name;
                }
                return classname;
            }
        
		/**
		 * Returns the String representation of the object.
		 * @return the String representation of the object.
		 */
		public function toString():String
            {
			return _name;
            }
        
		/**
		 * Returns the primitive value of the object.
		 * @return the primitive value of the object.
		 */
		public function valueOf():int
            {
			return _value;
            }
        
        }
     
    }

