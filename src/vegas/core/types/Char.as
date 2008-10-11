/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.core.types
{
	import vegas.core.CoreObject;	

	/**
	 * An object of type Char contains a single field whose type is String.
	 * @author eKameleon
	 */    
    public class Char extends CoreObject
    {
        
        /**
         * Creates a new Char instance.
         */  
        public function Char( value:String="" )
        {
            _ch = value.substring(0, 1) ;
        }

		/**
		 * Returns the integer character code for the character.
		 */
    	public function getCode():Number 
    	{
	    	return _ch.charCodeAt(0) ;
    	}

		/**
		 * Returns a Eden representation of the object.
		 * @return a string representing the source code of the object.
		 */
        public override function toSource( indent:int = 0 ):String  
        {
            return 'new vegas.core.types.Char("' + _ch + '")' ;    
        }

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
		 */
        public override function toString():String
        {
            return _ch ;
        }  

		/**
		 * Returns the real value of the object.
		 * @return the real value of the object.
		 */
        public function valueOf():Object
        {
            return _ch ;
        }
        
		/**
		 * Internal string object.
		 */        
        private var _ch:String ;
        
    }
}