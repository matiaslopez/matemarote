/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.core 
{
    import lunas.core.AbstractComponent;
    import lunas.core.IProgressbar;
    
    import pegas.draw.Direction;	

    /**
     * This class provides a skeletal implementation of all the <code class="prettyprint">IProgressbar</code> display components, to minimize the effort required to implement this interface.
     * @author eKameleon
     */
    public class AbstractProgressbar extends AbstractProgress implements IProgressbar 
    {

        /**
         * Creates a new AbstractProgressbar instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function AbstractProgressbar(id:* = null, isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name ) ;
            _direction = Direction.HORIZONTAL ;
        }
        
        /**
         * Indicates the direction value of this object (default value is Direction.HORIZONTAL).
         * @see Direction
         */
        public function get direction():String
        {
            return _direction ;
        }

        /**
         * @private
         */
        public function set direction( value:String ):void
        {
            _direction = (value == Direction.VERTICAL) ? Direction.VERTICAL : Direction.HORIZONTAL ;
            update() ;
        }
        
        /**
         * @private
         */
        private var _direction:String ;

    }

}
