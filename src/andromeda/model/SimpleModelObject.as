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
package andromeda.model 
{
    import andromeda.model.AbstractModelObject;
    
    /**
     * This class provides a simple representation of the IModelObject interface.
     * @author eKameleon
     */
    public class SimpleModelObject extends AbstractModelObject 
    {

        /**
         * Creates a new SimpleModelObject instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function SimpleModelObject(id:* = null, bGlobal:Boolean = false, sChannel:String = null)
        {
            super( id, bGlobal, sChannel );
        }
    }
}
