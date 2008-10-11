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
    import system.Configurator;

    public class ReflectionConfigurator extends Configurator
        {
        
        /**
         * Creates a new ReflectionConfigurator instance.
         * @param config The generic object who initialize the instance.
         */
        public function ReflectionConfigurator( config:Object )
            {
            super( config );
            }
        
        /**
         * Allow to replace "::" by "." for string class representation
         * <p><b>example:</b></p>
         * <p>With <code class="prettyprint">normalizePath = false</code> you obtain <code class="prettyprint">"system.reflection::ClassInfoTest"</code>
         * and with <code class="prettyprint">normalizePath=true</code> you obtain <code class="prettyprint">"system.reflection.ClassInfoTest"</code>.</p>
         */
        public function get normalizePath():Boolean
            {
            return _config.normalizePath;
            }
        
        /**
         * @private
         */
        public function set normalizePath( value:Boolean ):void
            {
            _config.normalizePath = value;
            }
        
        }
    }

