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
     * Draws a complex rounded rectangle. You can set the corner radius of the rectangle with the top left, top right, bottom left and bottom right corner.
     * @author eKameleon
     */
    dynamic public class RoundedComplexRectanglePen extends RectanglePen 
    {

        /**
         * Creates a new RoundedComplexRectanglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen. (default 0)
         * @param y (optional) The y position of the pen. (default 0)
         * @param width (optional) The width of the pen. (default 0)
         * @param height (optional) The height of the pen. (default 0)
         * @param topLeftRadius (optional) The radius of the upper-left corner, in pixels. (default 0)
         * @param topRightRadius (optional) The radius of the upper-right corner, in pixels. (default 0)
         * @param bottomLeftRadius (optional) The radius of the bottom-left corner, in pixels. (default 0)
         * @param bottomRightRadius (optional) The radius of the bottom-right corner, in pixels. (default 0)
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function RoundedComplexRectanglePen(graphic:*, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, topLeftRadius:Number=0 , topRightRadius:Number=0 , bottomLeftRadius:Number=0 , bottomRightRadius:Number=0, align:uint = 10)
        {
            super( graphic );
            setPen(  x , y , width , height , topLeftRadius , topRightRadius, bottomLeftRadius, bottomRightRadius, align ) ; 
        }
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public function get bottomLeftRadius():Number
        {
			return _bottomLeftRadius ;	
		}
        
        /**
         * @private
         */
        public function set bottomLeftRadius( value:Number ):void
        {
			_bottomLeftRadius = isNaN(value) ? 0 : value ;
		}        
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public function get bottomRightRadius():Number
        {
			return _bottomRightRadius ;	
		}

        /**
         * @private
         */
        public function set bottomRightRadius( value:Number ):void
        {
			_bottomRightRadius = isNaN(value) ? 0 : value ;
		}      
		
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public function get topLeftRadius():Number
        {
			return _topLeftRadius ;	
		}

        /**
         * @private
         */
        public function set topLeftRadius( value:Number ):void
        {
			_topLeftRadius = isNaN(value) ? 0 : value ;
		}    		
        
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public function get topRightRadius():Number
        {
			return _topRightRadius ;	
		}

        /**
         * @private
         */
        public function set topRightRadius( value:Number ):void
        {
			_topRightRadius = isNaN(value) ? 0 : value ;
		}          

        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _refreshAlign() ;
            graphics.drawRoundRectComplex( _x , _y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius) ;
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param topLeftRadius (optional) The radius of the upper-left corner, in pixels.
         * @param topRightRadius (optional) The radius of the upper-right corner, in pixels.
         * @param bottomLeftRadius (optional) The radius of the bottom-left corner, in pixels.
         * @param bottomRightRadius (optional) The radius of the bottom-right corner, in pixels.
         * @param align (optional) The align value of the pen.
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen( args[0], args[1], args[2], args[3], args[8] ) ;
            if ( args[4] != null && args[4] is Number )
            {
                this.topLeftRadius = isNaN( args[4] ) ? 0 : args[4] ;
            }
            if ( args[5] != null && args[5] is Number )
            {
                this.topRightRadius = isNaN( args[5] ) ? 0 : args[5] ;
            }
            if ( args[6] != null && args[6] is Number )
            {
                this.bottomLeftRadius = isNaN( args[6] ) ? 0 : args[6] ;
            }
            if ( args[7] != null && args[7] is Number )
            {
                this.bottomRightRadius = isNaN( args[7] ) ? 0 : args[7] ;
            }
        }
        
        /**
         * @private
         */
        private var _bottomLeftRadius:Number = 0 ;
        
        /**
         * @private
         */
        private var _bottomRightRadius:Number = 0 ;

        /**
         * @private
         */
		private var _topLeftRadius:Number = 0 ;
        
        /**
         * @private
         */
        private var _topRightRadius:Number = 0 ;
                
    }
}
