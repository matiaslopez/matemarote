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
package lunas.display.bar 
{
    import flash.display.Shape;
    import flash.geom.Rectangle;
    
    import lunas.core.AbstractProgressbar;
    import lunas.core.EdgeMetrics;
    
    import pegas.draw.Align;
    import pegas.draw.Direction;
    import pegas.draw.FillStyle;
    import pegas.draw.IFillStyle;
    import pegas.draw.ILineStyle;
    import pegas.draw.LineStyle;
    import pegas.draw.RectanglePen;
    
    import system.numeric.Mathematics;    

    /**
     * The SimpleProgressbar component.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * 
     * import pegas.draw.Align ;
     * import pegas.draw.FillStyle ;
     * import pegas.draw.LineStyle ;
     * 
     * import lunas.core.Direction ;
     * import lunas.core.EdgeMetrics ;
     * import lunas.display.bar.SimpleProgressbar ;
     * import lunas.events.ComponentEvent ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var change:Function = function( e:ComponentEvent ):void
     * {
     *     trace( e.type + " : " + bar.position ) ;
     * }
     * 
     * var bar:SimpleProgressbar = new SimpleProgressbar() ;
     * bar.addEventListener( ComponentEvent.CHANGE , change ) ;
     * bar.x = 50 ;
     * bar.y = 50 ;
     * bar.position = 50 ;
     * 
     * addChild(bar) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             bar.position -= 10 ;
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             bar.position += 10 ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *             bar.lock() ;
     *             bar.align               = Align.CENTER ; // Align.LEFT or Align.RIGHT or Align.CENTER
     *             bar.direction           = Direction.HORIZONTAL ;
     *             bar.backgroundFillStyle = new FillStyle( 0xB5C7CA , 1 ) ;
     *             bar.backgroundLineStyle = new LineStyle( 2 , 0xFFFFFF , 1 ) ;
     *             bar.barFillStyle        = new FillStyle( 0x921085 , 1 ) ;
     *             bar.barLineStyle        = new LineStyle( 1 , 0x6A9195, 1 ) ;
     *             bar.border              = new EdgeMetrics(2, 2, 2, 2) ;
     *             bar.unlock() ;
     *             bar.setSize( 200, 8 ) ;
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             bar.minimum = 20  ;
     *             bar.maximum = 200 ;
     *             break ;
     *         }
     *         default :
     *         {
     *             bar.direction = ( bar.direction == Direction.VERTICAL ) ? Direction.HORIZONTAL : Direction.VERTICAL ;
     *             if ( bar.direction == Direction.VERTICAL )
     *             {
     *                 bar.setSize( 8, 200 ) ;
     *             }
     *             else
     *             {
     *                 bar.setSize( 200, 8 ) ;
     *             }
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * 
     * trace("Press Keyboard.LEFT or Keyboard.RIGHT or Keyboard.SPACE or other keyboard touch to test this example.") ;
     * </pre>
     * @author eKameleon
     */
    public class SimpleProgressbar extends AbstractProgressbar
    {

        /**
         * Creates a new SimpleProgressbar instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function SimpleProgressbar(id:* = null, isConfigurable:Boolean = false, name:String = null)
        {
            
            super( id, isConfigurable, name );
            
            background = new Shape() ;
            bar        = new Shape() ;
            
            _backgroundPen = new RectanglePen( background ) ;
            _barPen        = new RectanglePen( bar ) ;
            
            addChild( background ) ;
            addChild( bar ) ;
            
            _backgroundPen.fill = new FillStyle( 0xFFFFFF, 1 ) ;
            _backgroundPen.line = new LineStyle( 1, 0xA2A2A2 , 1) ;
            
            _barPen.fill = new FillStyle( 0xFF0000, 1 ) ;
            _barPen.line = null ;
            
            setSize(150, 6) ;
            
        }
        
        /**
         * The background reference of this component.
         */
        public var background:Shape ;
    
        /**
         * (read-write) Indicates the align value of the bar. 
         * This property can take the 3 values Align.LEFT, Align.CENTER, Align.RIGHT.
         * The default value of the align property is Align.LEFT ;
         * @see Align
         */
        public function get align():uint
        {
            return _align ;    
        }
    
        /**
         * @private
         */
        public function set align( align:uint ):void
        {
            _align = (align == Align.LEFT || align == Align.RIGHT || align == Align.CENTER) ? align : Align.LEFT ;
            update() ;    
        }

        /**
         * Determinates the fill style object of the background.
         */
        public function get backgroundFillStyle():IFillStyle
        {
            return _backgroundPen.fill ;
        }
        
        /**
         * @private
         */        
        public function set backgroundFillStyle( style:IFillStyle ):void
        {
            _backgroundPen.fill = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the background.
         */
        public function get backgroundLineStyle():ILineStyle
        {
            return _backgroundPen.line ;
        }
        
        /**
         * @private
         */        
        public function set backgroundLineStyle( style:ILineStyle ):void
        {
            _backgroundPen.line = style ;
            update() ;
        }
    
        /**
         * The thumb reference of this bar.
         */
        public var bar:Shape ;
        
        /**
         * Determinates the fill style object of the bar.
         */
        public function get barFillStyle():IFillStyle
        {
            return _barPen.fill ;
        }
        
        /**
         * @private
         */        
        public function set barFillStyle( style:IFillStyle ):void
        {
            _barPen.fill = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the bar.
         */
        public function get barLineStyle():ILineStyle
        {
            return _barPen.line ;
        }
        
        /**
         * @private
         */        
        public function set barLineStyle( style:ILineStyle ):void
        {
            _barPen.line = style ;
            update() ;
        }
        
        /**
         * Draws the view of the component.
         */
        public override function draw( ...arguments:Array ):void
        {
            _backgroundPen.draw( 0, 0, w, h ) ;
        }        
        
        /**
         * Resize the bar.
         */
        public function resize():void 
        {
            
            var mW:Number = EdgeMetrics.filterNaNValue( border.left ) + EdgeMetrics.filterNaNValue( border.right ) ;
            var mH:Number = EdgeMetrics.filterNaNValue( border.top  ) + EdgeMetrics.filterNaNValue( border.bottom ) ;
            
            var margin:Number = (direction == Direction.VERTICAL) ? mH : mW ;
            var max:Number    = (direction == Direction.VERTICAL) ? h : w ;
                        
            var size:Number =  Mathematics.map( position , minimum, maximum , 0 , (max - margin) ) ;
                    
            var $w:Number = (direction == Direction.VERTICAL) ? ( w - mW ) : size  ;
            var $h:Number = (direction == Direction.VERTICAL) ? size : ( h - mH ) ;
            
            if ( _align == Align.RIGHT )
            {
                bar.x         = (direction == Direction.VERTICAL) ? EdgeMetrics.filterNaNValue( border.left ) : w - EdgeMetrics.filterNaNValue( border.right ) ;
                bar.y         = (direction == Direction.VERTICAL) ? h - EdgeMetrics.filterNaNValue( border.bottom ) : EdgeMetrics.filterNaNValue( border.top ) ;
                _barPen.align = (direction == Direction.VERTICAL) ? Align.BOTTOM_LEFT : Align.TOP_RIGHT ;
            }
            else if ( _align == Align.CENTER )
            {
                bar.x         = w / 2 ;
                bar.y         = h / 2 ;
                _barPen.align = Align.CENTER ;
            }
            else // Align.LEFT (default)
            {
                bar.x = EdgeMetrics.filterNaNValue( border.left ) ;
                bar.y = EdgeMetrics.filterNaNValue( border.top ) ;
                _barPen.align = Align.TOP_LEFT ;
            }
            
            _barPen.draw( 0, 0, $w, $h) ;
            
            bar.visible = position > 0 ;
        
        }
        
        /**
         * Invoked when the position of the bar is changed.
         * @param flag (optional) An optional boolean. By default this flag is passed-in the setPosition method.
         */
        public override function viewPositionChanged( flag:Boolean = false ):void 
        {
            resize() ;
        }
    
        /**
         * @private
         */
        private var _align:uint = Align.LEFT ;
        
        /**
         * @private
         */
        protected var _backgroundPen:RectanglePen ;
        
        /**
         * @private
         */
        protected var _barPen:RectanglePen ;
		
		/**
		 * The bar area Rectangle value object.
		 */
		protected var scrollArea:Rectangle ;
		
    }
}

