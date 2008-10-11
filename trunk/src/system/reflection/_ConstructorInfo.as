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
     * Implementation of the ClassInfo interface.
     */
    public class _ConstructorInfo implements ConstructorInfo
        {
        
        /**
         * Creates a new _ConstructorInfo instance.
         */
        public function _ConstructorInfo( o:* )
            {
            super();
            }
        
        /**
         * Indicates the Array represent of all arguments in a constructor.
         */        
        public function get arguments():Array
            {
            return null ;
            }        
        
        /**
         * Creates the constructor representation.
         */        
        public function construct( ...args:Array ):*
            {
            return null ;
            }
        
        /**
         * Invoke the constructor representation with an array of parameters.
         */        
        public function invoke( args:Array ):*
            {
            return construct.apply(null, args) ;
            }        
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
            {
            return "[ConstructorInfo]" ;
            }        
        
        /**
         * Returns the XML representation of the constructor.
         * @return the XML representation of the constructor.
         */
        public function toXML():XML
        	{
        	return null ;
            }
                
        }
    }