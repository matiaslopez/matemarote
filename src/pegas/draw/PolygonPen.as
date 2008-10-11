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
     * This pen is the tool to draw a regular polygon vector shape.
     * @author eKameleon
     */
    dynamic public class PolygonPen extends Pen 
    {
        
        /**
         * Creates a new PolygonPen. The Pen class use composition to control a Graphics reference and draw custom vector graphic shapes.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional)The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional)The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param radius (optional) The radius of the circle (in pixels). 
         * @param align (optional) The Align value to align the shape.
         * @author eKameleon
         */
        public function PolygonPen( graphic:* , ...arguments:Array )
        {
            super( graphic ) ;
            if ( arguments.length > 1 ) 
            {
                setPen.apply( this, arguments ) ;
            }
        }
        
        /**
         * Starting angle in degrees (default to 0).
         */
        public var angle:Number = 0 ;
        
        /**
         * The radius value of the pen.
          */
        public var radius:Number ;

        /**
         * The number of sides (Math.abs(sides) must be > 2)
          */
        public function get sides():uint
        {
            return _side ;
        }
        
        /**
         * The number of sides (Math.abs(sides) must be > 2)
          */
        public function set sides( value:uint ):void
        {
            _side = value > 2 ? value : 3 ;
        }
            
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
         * @param x (optional)The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional)The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of sides (Math.abs(sides) must be > 2)
          * @param radius (optional) The radius of the circle (in pixels). 
         * @param angle (optional) The starting angle in degrees. (defaults to 0) 
         * @param align (optional) The Align value to align the shape.
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
            var count:uint = Math.abs(sides);
            if ( count>2 ) 
            {
                var $a:uint  = align ;
                var $x:Number = x ;
                var $y:Number = y ;
                var $r:Number = radius ;
                if ( $a == Align.CENTER ) 
                {
                    // default
                }
                else if ( $a == Align.BOTTOM ) 
                {
                    $y -= $r ;
                }
                else if ( $a == Align.BOTTOM_LEFT ) 
                {
                    $x += $r ;
                    $y -= $r ;
                }
                else if ( $a == Align.BOTTOM_RIGHT) 
                {
                    $x -= $r ;
                    $y -= $r ;
                }
                else if ( $a == Align.LEFT) 
                {
                    $x += $r ;
                }
                else if ( $a ==  Align.RIGHT) 
                {
                    $x -= $r ;
                }
                else if ( $a == Align.TOP) 
                {
                    $y += $r ;
                }
                else if ( $a == Align.TOP_RIGHT) 
                {
                    $x -= $r ;
                    $y += $r ;
                }
                else // TOP_LEFT
                {
                    $x += $r ;
                    $y += $r ;
                }    
                    
                var dx:Number    ;
                var dy:Number    ;

                var step:Number  = ( Math.PI * 2 )/ sides ; // calculate span of sides
                var start:Number = ( angle / 180 ) * Math.PI ; // calculate starting angle in radians
                
                graphics.moveTo( $x + ( Math.cos( start ) * $r ), $y - ( Math.sin(start) * $r ) ) ;
                
                for ( var i:uint=1 ; i<=count ; i++ ) 
                {
                    dx = $x + Math.cos( start + ( step*i ) )* $r ;
                    dy = $y - Math.sin( start + ( step*i ) )* $r ;
                    graphics.lineTo(dx, dy);
                }
            }

        }

        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional) The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of sides (Math.abs(sides) must be > 2)
         * @param radius (optional) The radius of the circle (in pixels). 
         * @param angle (optional) The starting angle in degrees. (defaults to 0) 
         * @param align (optional) The Align value to align the shape.
         */
        public function setPen( ...arguments:Array ):void
        {
            if ( arguments[0] != null && arguments[0] is Number )
            {
                x = isNaN(arguments[0]) ? 0 : arguments[0] ; // x
            }
            if ( arguments[1] != null && arguments[1] is Number )
            {
                y = isNaN(arguments[1]) ? 0 : arguments[1] ; // y
            }
            if ( arguments[2] != null && arguments[2] is Number )
            {
                sides = arguments[2] > 2 ? arguments[2] : 3 ; // sides
            }
            if ( arguments[3] != null && arguments[3] is Number )
            {
                radius = isNaN(arguments[3]) ? 0 : arguments[3] ; // radius
            }
            if ( arguments[4] != null && arguments[4] is Number )
            {
                angle = arguments[4] > 0 ? arguments[4] : 0 ; // angle
            }
            if ( arguments.length == 6 && arguments[5] is uint )
            {
                align = arguments[5] as uint ; // align
            }
        }

        /**
         * @private
         */
        private var _side:uint = 3 ;    

    }

    
}
