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
    import pegas.util.Trigo;    

    /**
     * This pen drawing a star shaped polygons. This pen draw stars in either direction for creating knockouts.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import pegas.draw.Align ;
     * import pegas.draw.StarPen ;
     * import pegas.draw.FillStyle ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.align = "" ;
     * 
     * var shape:Shape = new Shape() ;
     * shape.x = 740 / 2 ;
     * shape.y = 420 / 2 ;
     * 
     * var pen:StarPen = new StarPen( shape.graphics ) ;
     * pen.align = Align.CENTER ;
     * pen.fill  = new FillStyle( 0xEBD936 , 0.6 ) ;
     * pen.draw() ;
     * 
     * addChild( shape ) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             pen.draw( 0, 0, 5, 40, 60 , 0,  Align.LEFT ) ;
     *                 break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             pen.draw( 0, 0, 5, 80, 40 , 0,  Align.RIGHT ) ;
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             pen.draw( 0, 0, 20, 100, 40 , 0 , Align.TOP ) ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             pen.draw( 0, 0, 10 , 100, 60 , 0, Align.BOTTOM ) ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *             pen.x = 10 ;
     *             pen.y = 40 ;
     *             pen.points  = 8  ;
     *             pen.innerRadius = 100 ;
     *             pen.outerRadius = 50 ;
     *             pen.angle  = 40 ;
     *             pen.align  = Align.TOP_RIGHT ;
     *             pen.draw() ;
     *             break ;
     *         }
     *    }
     * }
     * 
     * var enterFrame:Function = function( e:Event ):void
     * {
     *     pen.angle += 10 ;
     *     pen.draw() ;
     * }
     * 
     * var mouseDown:Function = function( e:MouseEvent ):void
     * {
     *     stage.addEventListener( Event.ENTER_FRAME , enterFrame ) ;
     * }
     * 
     * var mouseUp:Function = function( e:MouseEvent ):void
     * {
     *     stage.removeEventListener( Event.ENTER_FRAME , enterFrame ) ;
     * }
     * 
     * stage.addEventListener( MouseEvent.MOUSE_DOWN , mouseDown ) ;
     * stage.addEventListener( MouseEvent.MOUSE_UP , mouseUp ) ;
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     * @author eKameleon
     */
    dynamic public class StarPen extends Pen 
    {

        /**
         * Creates a new StarPen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional) The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param points (optional) The number of points (Math.abs(sides) must be > 2)
         * @param innerRadius (optional) The radius of the indent of the points.
         * @param outerRadius (optional) The radius of the tips of the points.
         * @param angle (optional) The starting angle in degrees. (defaults to 0) 
         * @param align (optional) The Align value to align the shape.
         */
        public function StarPen( graphic:* , x:Number=0, y:Number=0 , points:uint=5 , innerRadius:Number = 20 , outerRadius:Number = 40 , angle:Number = 20 , align:uint = 10  )
        {
            super( graphic ) ;
            setPen( x, y, points, innerRadius, outerRadius, angle, align ) ;
        }

        /**
         * Starting angle in degrees (default to 0).
         */
        public var angle:Number = 0 ;
        
        /**
         * The radius of the indent of the points
          */
        public var innerRadius:Number ;

        /**
         * The radius of the tips of the points
          */
        public var outerRadius:Number ;

        /**
         * The number of points of the star. This value is always > 2.
          */
        public function get points():uint
        {
            return _points ;
        }
        
        /**
         * The number of sides (Math.abs(sides) must be > 2)
          */
        public function set points( i:uint ):void
        {
            _points = i > 2 ? i : 2 ;
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
            var count:Number = Math.abs(points);
            if (count>2) 
            {
                
                var $a:uint  = align ;
                var $x:Number = x ;
                var $y:Number = y ;
                var $r:Number = Math.max(outerRadius, innerRadius) ;
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
                
                var start:Number ;
                var n:Number ; 
                var dx:Number ;
                var dy:Number;
                
                var step:Number     = (Math.PI*2)/points ;
                var halfStep:Number = step / 2 ;
            
                angle = Trigo.fixAngle(angle) ;
            
                start = (angle/180) * Math.PI ;
                
                graphics.moveTo( $x + ( Math.cos(start) * outerRadius ) , $y - ( Math.sin(start) * outerRadius ) ) ;
            
                for (n=1 ; n<=count; n++) 
                {
                    dx = $x + Math.cos( start + (step*n) - halfStep ) * innerRadius ;
                    dy = $y - Math.sin( start + (step*n) - halfStep ) * innerRadius ;
                    graphics.lineTo(dx, dy) ;
                    dx = $x + Math.cos( start + (step*n) ) * outerRadius ;
                    dy = $y - Math.sin( start + (step*n) ) * outerRadius ;
                    graphics.lineTo(dx, dy);
                }
            }
        }

        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional) The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param points (optional) The number of points (Math.abs(sides) must be > 2)
         * @param innerRadius (optional) The radius of the indent of the points.
         * @param outerRadius (optional) The radius of the tips of the points.
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
                points = arguments[2] > 2 ? arguments[2] : 3 ; // points
            }
            if ( arguments[3] != null && arguments[3] is Number )
            {
                innerRadius = isNaN(arguments[3]) ? 0 : arguments[3] ; // innerRadius
            }
            if ( arguments[4] != null && arguments[4] is Number )
            {
                outerRadius = isNaN(arguments[4]) ? 0 : arguments[4] ; // outerRadius
            }
            if ( arguments[5] != null && arguments[5] is Number )
            {
                angle = arguments[5] > 0 ? arguments[5] : 0 ; // angle
            }
            if ( arguments[6] != null && arguments[6] is uint )
            {
                align = arguments[6] as uint ; // align
            }

        }

        /**
         * @private
         */
        private var _points:uint ;
    }
}
