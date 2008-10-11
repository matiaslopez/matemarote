/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.draw 
{
    import flash.display.Graphics;
    
    import vegas.core.CoreObject;    

    /**
     * Defines the fill style of the vector shapes. See the flash.display.graphics.beginFill method.
     * @author eKameleon
     */
    final public class FillStyle extends CoreObject implements IFillStyle
    {
        
        /**
         * Creates a new FillStyle instance.
         * @param color The color value of the fill style.
         * @param alpha The alpha value of the fill style.
         */
        public function FillStyle( color:uint, alpha:Number = 1.0 )
        {
            this.alpha = alpha ;
            this.color = color ;
        }
        
        /**
         * The empty FillStyle singleton.
         */
        public static var EMPTY:FillStyle = new FillStyle( undefined ) ;
        
        /**
         * The alpha value of the fill style.
         */
        public var alpha:Number;
    
        /**
         * The color value of the fill style.
         */
        public var color:uint;
        
        /**
         * Initialize and launch the beginFill method of the specified Graphics reference.
         */
        public function init( graphic:Graphics ):void
        {
            graphic.beginFill( color, alpha );
        }
        
    }

}
