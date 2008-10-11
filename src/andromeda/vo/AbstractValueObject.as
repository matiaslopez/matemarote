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
package andromeda.vo
{
    import vegas.core.CoreObject;    

    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">IValueObject</code> interface, to minimize the effort required to implement this interface.
     * @author eKameleon
     */
    public class AbstractValueObject extends SimpleValueObject
    {
        
        /**
         * Creates a new AbstractValueObject.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function AbstractValueObject( init:Object=null )
        {
            super(init) ;
            if ( id == null )
            {
                 id = hashCode() ;
            }
        }
        
    }
}