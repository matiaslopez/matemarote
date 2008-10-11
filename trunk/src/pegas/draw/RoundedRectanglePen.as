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
     * Draws a rounded rectangle.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.CapsStyle ;
     * import flash.display.JointStyle ;
     * import flash.display.LineScaleMode ;
     * 
     * import pegas.draw.Align ;
     * import pegas.draw.RoundedRectanglePen ;
     * import pegas.draw.FillStyle ;
     * import pegas.draw.LineStyle ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.align = "" ;
     * 
     * var shape:Shape = new Shape() ;
     * shape.x = 740 / 2 ;
     * shape.y = 420 / 2 ;
     * 
     * var pen:RoundedRectanglePen = new RoundedRectanglePen( shape.graphics , 0, 0, 100, 80, 12, NaN,  Align.CENTER ) ;
     * pen.useClear   = true ;
     * pen.useEndFill = true ;
     * pen.fill       = new FillStyle( 0xFF0000 , 0.5 ) ;
     * pen.line       = new LineStyle( 2, 0xFFFFFF , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
     * pen.draw() ;
     * </pre>
     * @author eKameleon
     */
    dynamic public class RoundedRectanglePen extends RectanglePen 
    {

        /**
         * Creates a new RoundedRectanglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen. (default 0)
         * @param y (optional) The y position of the pen. (default 0)
         * @param width (optional) The width of the pen. (default 0)
         * @param height (optional) The height of the pen. (default 0)
         * @param ellipseWidth (optional) The width of the ellipse used to draw the rounded corners (in pixels). (default 0)
         * @param ellipseHeight (optional) Optional; if no value is specified, the default value matches that provided for the ellipseWidth parameter. 
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function RoundedRectanglePen(graphic:*, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, ellipseWidth:Number=0 , ellipseHeight:Number=NaN , align:uint = 10)
        {
            super( graphic );
            setPen(  x, y, width, height, ellipseWidth, ellipseHeight, align ) ; 
        }
        
        /**
         * The width of the ellipse used to draw the rounded corners (in pixels). 
         */
        public var ellipseWidth:Number ;
        
        /**
         *  The height of the ellipse used to draw the rounded corners (in pixels). 
         *  Optional; if no value is specified, the default value matches that provided for the ellipseWidth parameter. 
         */
        public var ellipseHeight:Number ;
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _refreshAlign() ;
            ellipseWidth  = isNaN( ellipseWidth )  ? 0 : ellipseWidth  ;
            graphics.drawRoundRect( _x , _y , width , height , ellipseWidth , ellipseHeight ) ;
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param ellipseWidth (optional) The width of the ellipse used to draw the rounded corners (in pixels). 
         * @param ellipseHeight (optional) Optional; if no value is specified, the default value matches that provided for the ellipseWidth parameter. 
          * @param align (optional) The align value of the pen.
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen( args[0], args[1], args[2], args[3], args[6] ) ;
            if ( args[4] != null && args[4] is Number )
            {
                this.ellipseWidth = isNaN( args[4] ) ? 0 : args[4] ;
            }
            if ( args[5] != null && args[5] is Number )
            {
                this.ellipseHeight = args[5] ;
            }
        }
        
    }
}
