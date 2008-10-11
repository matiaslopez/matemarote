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
	import pegas.draw.Pen;	

	/**
     * This pen is the tool to draw an elipse vector shape.
     * @author eKameleon
     */
    dynamic public class EllipsePen extends Pen 
    {
        
        /**
         * Creates a new ElipsePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) A number indicating the horizontal position relative to the registration point of the parent display object (in pixels). .
         * @param y (optional) A number indicating the vertical position relative to the registration point of the parent display.
         * @param width (optional) The width value of the elipse (in pixels). 
         * @param height (optional) The height of the ellipse (in pixels). 
         * @param align  (optional) The Align value to align the shape.
         * @author eKameleon
         */
        public function EllipsePen( graphic:* , ...arguments:Array )
        {
            super( graphic );
            if ( arguments.length > 1 ) 
            {
                setPen.apply( this, arguments ) ;
            }
        }
        
        /**
         * The height value of the elipse pen.
          */
        public var height:Number ;

        /**
         * The width value of the elipse pen.
          */
        public var width:Number ;

        /**
         * The offset x value of the center of the circle.
         */
        public var x:Number ;
        
        /**
          * The offset y value of the center of the circle.
          */
        public var y:Number ;

        /**
         * Draws the shape.
         * @param x (optional) A number indicating the horizontal position relative to the registration point of the parent display object (in pixels). .
         * @param y (optional) A number indicating the vertical position relative to the registration point of the parent display.
         * @param width (optional) The width value of the elipse (in pixels). 
         * @param height (optional) The height of the ellipse (in pixels). 
         * @param align  (optional) The Align value to align the shape.
         */
        public override function draw( ...arguments:Array ):void
        {
            if ( arguments.length > 0 ) 
            {
                setPen.apply( this, arguments ) ;
            }
            super.draw() ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            var $a:uint = align ;
            var $x:Number = x ;
            var $y:Number = y ;
            var $w:Number = width ;
            var $h:Number = height ;
            if ( $a == Align.CENTER ) 
            {
                $x -= $w / 2 ;
                $y -= $h / 2 ;
            }
            else if ( $a == Align.BOTTOM ) 
            {
                $x -= $w  / 2 ;
                $y -= $h ;
            }
            else if ( $a == Align.BOTTOM_LEFT ) 
            {
                $y -= $h ;
            }
            else if ( $a == Align.BOTTOM_RIGHT ) 
            {
                $x -= $w ;
                $y -= $h ;
            }
            else if ( $a == Align.LEFT ) 
            {
                $y -= $h / 2;
            }
            else if ( $a ==  Align.RIGHT ) 
            {
                $x -= $w ;
                $y -= $h / 2;
            }
            else if ( $a == Align.TOP ) 
            {
                $x -=  $w / 2 ;
            }
            else if ( $a == Align.TOP_RIGHT ) 
            {
                $x -= $w ;
            }
            graphics.drawEllipse( $x , $y , $w , $h ) ;
        }

        /**
         * Sets the pen properties.
         * @param x (optional) A number indicating the horizontal position relative to the registration point of the parent display object (in pixels). .
         * @param y (optional) A number indicating the vertical position relative to the registration point of the parent display.
         * @param width (optional) The width value of the elipse (in pixels). 
         * @param height (optional) The height of the ellipse (in pixels). 
         * @param align  (optional) The Align value to align the shape.
         */
        public function setPen(  ...arguments:Array ):void
        {
            if ( arguments[0] != null && arguments[0] is Number )
            {
                this.x = isNaN(arguments[0]) ? 0 : arguments[0] ; // x
            }
            if ( arguments[1] != null && arguments[1] is Number )
            {
                this.y = isNaN(arguments[1]) ? 0 : arguments[1] ; // y
            }
            if ( arguments[2] != null && arguments[2] is Number )
            {
                this.width = isNaN(arguments[2]) ? 0 : arguments[2] ; // width
            }
            if ( arguments[3] != null && arguments[3] is Number )
            {
                this.height = isNaN(arguments[3]) ? 0 : arguments[3] ; // height
            }
            if ( arguments.length == 5 && arguments[4] is uint )
            {
                this.align = arguments[4] as uint ; // align
            }
        }
    
    }
    
}
