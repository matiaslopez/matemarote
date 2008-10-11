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
     * This pen drawing gears.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import pegas.draw.Align ;
     * import pegas.draw.GearPen ;
     * import pegas.draw.FillStyle ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.align = "" ;
     * 
     * var shape:Shape = new Shape() ;
     * shape.x = 740 / 2 ;
     * shape.y = 420 / 2 ;
     * 
     * var pen:GearPen = new GearPen( shape.graphics ) ;
     * pen.align = Align.CENTER ;
     * pen.fill  = new FillStyle( 0xEBD936 , 1 ) ;
     * 
     * pen.draw() ;
     * addChild( shape ) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             pen.draw( 0, 0, 6, 150, 70 , 0, 5, 40, Align.LEFT ) ;
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             pen.draw( 0, 0, 5, 80, 40 , 0, 5, 10, Align.RIGHT ) ;
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             pen.draw( 0, 0, 8, 100, 40 , 0 ,  5, 5, Align.TOP ) ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             pen.draw( 0, 0, 10 , 100, 60 , 0, 30, 5, Align.BOTTOM ) ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *             pen.x = 10 ;
     *             pen.y = 40 ;
     *             pen.sides  = 8  ;
     *             pen.holeRadius  = 40 ;
     *             pen.holeSides   = 6 ;
     *             pen.innerRadius = 120 ;
     *             pen.outerRadius = 80 ;
     *             pen.angle  = 40 ;
     *             pen.align  = Align.TOP_RIGHT ;
     *             pen.draw() ;
     *             break ;
     *         }
     *     }
     * }
     * 
     * var enterFrame:Function = function( e:Event ):void
     * {
     *     pen.angle += 15 ;
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
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     * @author eKameleon
     */
    dynamic public class GearPen extends Pen 
    {

        /**
         * Creates a new StarPen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional) The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of teeth on gear. (must be > 2)
         * @param innerRadius (optional) The radius of the indent of the teeth.
         * @param outerRadius (optional) The outer radius of the teeth.
         * @param angle (optional) The starting angle in degrees. (defaults to 0)
         * @param holeSides (optional) draw a polygonal hole with this many sides (must be > 2)
         * @param holeRadius (optional) size of hole. Default = innerRadius/3.
         * @param align (optional) The Align value to align the shape.
         */
        public function GearPen( graphic:* , x:Number=0, y:Number=0 , points:uint=5 , innerRadius:Number = 30 , outerRadius:Number = 40 , angle:Number = 0, holeSides:Number = 3 , holeRadius:Number=NaN, align:uint = 10  )
        {
            super( graphic ) ;
            setPen( x, y, points, innerRadius, outerRadius, angle, align ) ;
        }

        /**
         * Starting angle in degrees (default to 0).
         */
        public var angle:Number ;
        
        /**
         * The size of hole.
          */
        public var holeRadius:Number ;
        
        /**
         * Draw a polygonal hole with this many sides (must be > 2)
          */
        public var holeSides:Number ;

        /**
         * The radius of the indent of the teeth.
          */
        public var innerRadius:Number ;

        /**
         * The outer radius of the teeth.
          */
        public var outerRadius:Number ;

        /**
         * The number of points of the star. This value is always > 2.
          */
        public function get sides():uint
        {
            return _sides ;
        }
        
        /**
         * The number of sides (Math.abs(sides) must be > 2)
          */
        public function set sides( i:uint ):void
        {
            _sides = i > 2 ? i : 2 ;
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
         * @param x (optional) The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional) The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of teeth on gear. (must be > 2)
         * @param innerRadius (optional) The radius of the indent of the teeth.
         * @param outerRadius (optional) The outer radius of the teeth.
         * @param angle (optional) The starting angle in degrees. (defaults to 0)
         * @param holeSides (optional) draw a polygonal hole with this many sides (must be > 2)
         * @param holeRadius (optional) size of hole. Default = innerRadius/3.
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
            var sides:Number = Math.abs(sides);
            if (sides>2) 
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
                
                // init vars
                var dx:Number ;
                var dy:Number ;
        
                var step:Number    = ( Math.PI * 2 ) / sides ;
                var qtrStep:Number = step / 4 ;
                
                var start:Number = (angle/180)*Math.PI;
                
                graphics.moveTo( $x +( Math.cos(start) * outerRadius ) , $y - (Math.sin(start) * outerRadius ) ) ;
        
                // draw lines
                for ( var n:Number = 1 ; n <= sides ; n++ ) 
                {
                    dx = $x + Math.cos(start+(step*n)-(qtrStep*3)) *innerRadius ;
                    dy = $y - Math.sin(start+(step*n)-(qtrStep*3)) *innerRadius ;
                    
                    graphics.lineTo(dx, dy);
                    
                    dx = $x + Math.cos(start+(step*n)-(qtrStep*2)) * innerRadius ;
                    dy = $y - Math.sin(start+(step*n)-(qtrStep*2)) * innerRadius ;
                    
                    graphics.lineTo(dx, dy);
                    
                    dx = $x + Math.cos(start+(step*n)-qtrStep) * outerRadius;
                    dy = $y - Math.sin(start+(step*n)-qtrStep) * outerRadius;
            
                    graphics.lineTo(dx, dy);
                    
                    dx = $x + Math.cos(start+(step*n)) * outerRadius ;
                    dy = $y - Math.sin(start+(step*n)) * outerRadius ;
                    
                    graphics.lineTo(dx, dy);
                }
                
                if (holeSides>2) 
                {
                    if( isNaN(holeRadius) ) 
                    {
                        holeRadius = innerRadius/3;
                    }
                    step = ( Math.PI * 2 ) / holeSides ;
                    graphics.moveTo($x + (Math.cos(start)*holeRadius), $y - (Math.sin(start)*holeRadius) ) ;
                    for ( n=1 ; n<= holeSides ; n++ ) 
                    {
                        dx = $x + Math.cos(start+(step*n)) * holeRadius;
                        dy = $y - Math.sin(start+(step*n)) * holeRadius;
                        graphics.lineTo(dx, dy);
                    }
                }

            }
        }

        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional) The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of teeth on gear. (must be > 2)
         * @param innerRadius (optional) The radius of the indent of the teeth.
         * @param outerRadius (optional) The outer radius of the teeth.
         * @param angle (optional) The starting angle in degrees. (defaults to 0)
         * @param holeSides (optional) draw a polygonal hole with this many sides (must be > 2)
         * @param holeRadius (optional) size of hole. Default = innerRadius/3.
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
            if ( arguments[6] != null && arguments[6] is Number )
            {
                holeSides = arguments[6] > 0 ? arguments[6] : 0 ; // holeSides
            }
            if ( arguments[7] != null && arguments[7] is Number )
            {
                holeRadius = arguments[7] ; // holeRadius
            }
            if ( arguments[8] != null && arguments[8] is uint )
            {
                align = arguments[8] as uint ; // align
            }

        }

        /**
         * @private
         */
        private var _sides:uint ;
    }
}
