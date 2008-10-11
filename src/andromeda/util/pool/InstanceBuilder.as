/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.util.pool 
{
    import system.Reflection;                

    /**
     * This factory object create new instances with the specified Class object.
     * @author eKameleon
     */
    internal class InstanceBuilder implements ObjectPoolBuilder
    {
    	
        /**
         * Creates a new InstanceBuilder instance.
         * @param The Class reference to create a new instance with this builder.
         */
        public function InstanceBuilder( clazz:Class )
        {
            this.clazz = clazz;
        }
        
        /**
         * The Class reference to create objects.
         */        
        private var clazz:Class;
         
        /**
         * Builds a new object with the factory.
         */
        public function build( ...args:Array ):*
        {
        	if ( clazz == null )
        	{
        	   return null ;	
        	}
            return Reflection.invokeClass(clazz, args) ; 
        }    	
                
    }
}
