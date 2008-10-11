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
	import pegas.draw.CornerRectanglePen;	

	/**
     * Draws a bevel rectangle.
     * @author eKameleon
     */
    dynamic public class BevelRectanglePen extends CornerRectanglePen 
    {

        /**
         * Creates a new RoundedRectanglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param hBevel (optional) The hBevel value who defined the horizontal bevel level of all corners in this BevelRectangle pen.
         * @param vBevel (optional) The vBevel value who defined the vertical bevel level of all corners in this BevelRectangle pen.
         * @param align (optional) The align value of the pen.
         */
        public function BevelRectanglePen(graphic:*, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, hBevel:Number=0, vBevel:Number = 0 , align:uint = 10)
        {
            super( graphic );
            setPen( x, y, width, height, hBevel, vBevel , align ) ;
        }
        
        /**
          * Determinates the hBevel value who defined the horizontal bevel level of all corners in this BevelRectangle pen.
         */
        public function get hBevel():Number 
        {
            return (_hBevel <= width ) ? _hBevel : 0 ;
        }

        /**
         * @private
         */
        public function set hBevel( n:Number ):void 
        {
            _hBevel = ( n>0 ) ? n : 0 ; 
        }

        /**
         * Determinates the vBevel value who defined the vertical bevel level of all corners in this BevelRectangle pen.
         */
        public function get vBevel():Number 
        {
            return isNaN(_vBevel) ? NaN : ( (_vBevel <= height ) ? _vBevel : 0 ) ;
        }
    
        /**
         * @private
         */
        public function set vBevel( n:Number ):void 
        {
            _vBevel = (isNaN(n) || n > 0 ) ? n : 0 ; 
        }    
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _refreshAlign() ;
            
            var hb:Number = hBevel ;
            var vb:Number = isNaN(vBevel) ? hBevel : vBevel ;
        
            if (hb > 0 && vb > 0) 
            {
                var nX:Number   = _x ;
                var nY:Number   = _y ;
                var nW:Number   = nX + width ;
                var nH:Number   = nY + height ;
                var c:Corner    = corner ;
                
                var tr:Boolean  = c.tr ;
                var br:Boolean  = c.br ;
                var bl:Boolean  = c.bl ;
                var tl:Boolean  = c.tl ;
                
                graphics.moveTo ( nX + hb , nY) ;
                if (tr) 
                {
                    graphics.lineTo( nW - hb , nY) ;
                    graphics.lineTo( nW , nY + vb ) ;
                }
                else 
                {
                    graphics.lineTo( nW , nY ) ;
                }
                if (br) 
                {
                    graphics.lineTo( nW , nH - vb ) ;
                    graphics.lineTo( nW - hb , nH) ;        
                }
                else 
                {
                    graphics.lineTo( nW , nH ) ;
                }
                if (bl) 
                {
                    graphics.lineTo( nX  + hb, nH ) ;
                    graphics.lineTo( nX  ,  nH - vb ) ;
                }
                else 
                {
                    graphics.lineTo( nX , nH ) ;
                }
                if (tl) 
                {
                    graphics.lineTo( nX , nY + vb) ;
                    graphics.lineTo( nX + hb, nY);
                }
                else 
                {
                    graphics.lineTo( nX , nY ) ;
                }
            } 
            else 
            {
                super.drawShape() ;
            }
            
        }
        
        /**
         * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param hBevel (optional) The hBevel value who defined the horizontal bevel level of all corners in this BevelRectangle pen.
         * @param vBevel (optional) The vBevel value who defined the vertical bevel level of all corners in this BevelRectangle pen.
          * @param align (optional) The align value of the pen.
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen( args[0], args[1], args[2], args[3], args[6] ) ;
            if ( args[4] != null && args[4] is Number )
            {
                hBevel = args[4] ;
            }
            if ( args[5] != null && args[5] is Number )
            {
                vBevel = args[5] ;
            }
        }
        
        /**
          * @private
          */
        private var _hBevel:Number ;

         /**
          * @private
          */
        private var _vBevel:Number ;
    }
}

