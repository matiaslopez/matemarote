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
	import pegas.draw.RectanglePen;	

	/**
     * This pen draw a corner rectangle shape with a Graphics object.
     * @author eKameleon
     */
    dynamic public class CornerRectanglePen extends RectanglePen 
    {

        /**
         * Creates a new CornerRectanglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen. (default 0)
         * @param y (optional) The y position of the pen. (default 0)
         * @param width (optional) The width of the pen. (default 0)
         * @param height (optional) The height of the pen. (default 0)
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function CornerRectanglePen(graphic:*, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, align:uint = 10)
        {
            super( graphic, x, y, width, height, align );
        }
        
        /**
         * (read-write) Determinates the Corner value of this pen.
         */
        public function get corner():Corner 
        {
            return _corner ;
        }
    
        /**
          * @private
          */
        public function set corner( c:Corner ):void 
        {
            _corner = c || new Corner() ;
        }
        
        /**
         * @private
         */
        private var _corner:Corner = new Corner() ;
        
    }
}
