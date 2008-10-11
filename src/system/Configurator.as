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
	 * The Configurator class defines the basic class used to creates custom configurations.
	 */    
    public class Configurator implements Serializable
        {
        
        /**
         * The internal config object of the configurator.
         * @private
         */
        protected var _config:Object;
        
		/**
		 * Creates a new Configurator object.
		 * @param config This argument initialize the configurator with a generic object.
		 */        
        public function Configurator( config:Object )
            {
            _config = {};
            load( config );
            }

        /**
         * Copy all properties in the specified passed-in object in the internal config object of the Configurator.
         */
        public function load( config:Object ):void
            {
            for( var member:String in config )
                {
                _config[member] = config[member] ;
                }
            }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
            {
            //return Serializer.serialize( _config );
            //return "";
            config.serializer.prettyIndent = indent;
            return config.serializer.serialize( _config );
            }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
            {
            return toSource();
            }
        
        }
    
    }

