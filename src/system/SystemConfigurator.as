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

    import system.Configurator;
    
    /**
     * The system configurator class.
     */
    public class SystemConfigurator extends Configurator
        {
        
        /**
         * Creates a new SystemConfigurator instance.
         * @param config This argument initialize the configurator with a generic object.
         */
        public function SystemConfigurator( config:Object )
            {
            super( config );
            }
        
        /**
         * Indicates if the config use the verbose mode or not.
         */
        public function get verbose():Boolean
            {
            return _config.verbose;
            }
        
        /**
         * @private
         */
        public function set verbose( value:Boolean ):void
            {
            _config.verbose = value;
            }
        
        /**
         * The current serializer used used by the system 
         */        
        public function get serializer():Serializer
            {
            return _config.serializer;
            }
        
        /**
         * @private
         */
        public function set serializer( value:Serializer ):void
            {
            _config.serializer = value;
            }
        
        }

    }
