/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
package asgard.display 
{
    import flash.events.Event;
    import flash.geom.Matrix;
    
    import asgard.display.CoreSprite;
    
    import pegas.draw.Direction;
    import pegas.draw.FillGradientStyle;
    import pegas.draw.IDirectionable;
    import pegas.draw.IFillStyle;
    import pegas.draw.ILineStyle;
    import pegas.draw.IPen;
    import pegas.draw.Pen;
    import pegas.draw.RoundedComplexRectanglePen;
    import pegas.geom.Dimension;
    import pegas.util.Trigo;
    
    import system.numeric.Mathematics;
    
    import vegas.events.BasicEvent;    

    /**
     * This display is used to create a background in your application or in an other display of the application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.display.Background ;
     * 
     * import flash.display.* ;
     * 
     * import pegas.draw.* ;
     * 
     * stage.align     = StageAlign.TOP_LEFT ;
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var background:Background = new Background( "background" ) ;
     * 
     * background.lock() ; // lock the update method
     * 
     * // background.topLeftRadius = 15 ;
     * // background.bottomLeftRadius = 15 ;
     * 
     * background.fill = new FillStyle( 0xD97BD0  ) ;
     * // background.line = new LineStyle( 2, 0xFFFFFF ) ;
     * background.w    = 400 ;
     * background.h    = 300 ;
     * 
     * background.unlock() ; // unlock the update method
     * background.update() ; // force update
     * 
     * // background.setSize( 740, 400 ) ;
     * 
     * addChild( background ) ;
     * 
     * var resize:Function = function( e:Event ):void
     * {
     *     background.update() ;
     * }
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.SPACE :
     *         {
     *             if( background.isFull )
     *             {
     *                 stage.removeEventListener( Event.RESIZE, resize ) ;
     *                 background.fill   = new FillStyle( 0xD97BD0 ) ;
     *                 background.isFull = false ;
     *             }
     *             else
     *             {
     *                 stage.addEventListener( Event.RESIZE, resize ) ;
     *                 background.gradientRotation = 90 ;
     *                 background.useGradientBox   = true ;
     *                 background.fill             = new FillGradientStyle( GradientType.LINEAR, [0x071E2C,0x81C2ED], [1,1], [0,255] ) ;
     *                 background.isFull           = true ;
     *                 background.direction        = null ;
     *             }
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             background.fill      = new FillStyle( 0x000000 ) ;
     *             background.isFull    = true ;
     *             background.direction = Direction.HORIZONTAL ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             background.fill      = new FillStyle( 0xFFFFFF ) ;
     *             background.isFull    = true ;
     *             background.direction = Direction.VERTICAL ;
     *             break ;
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * 
     * trace( "Press a key to change the view of the background." ) ;
     * </pre>
     * @author eKameleon
     */
    public class Background extends CoreSprite implements IDirectionable 
    {
        
        /**
         * Creates a new Background instance.
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function Background(id:* = null, isFull:Boolean=false, isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name );
            _pen = initBackgroundPen() ;
            this.isFull = isFull ;
        }
        
        /**
         * The alignement of the background.
         * @see pegas.draw.Align
         */
        public var align:uint = 10 ;
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public var bottomLeftRadius:Number = 0 ;
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public var bottomRightRadius:Number = 0 ;
        
        /**
         * Indicates the direction value of the background when the display is in this "full" mode (default value is null).
         * @see pegas.draw.Direction
         */
        public function get direction():String
        {
            return _direction ;
        }

        /**
         * @private
         */
        public function set direction( value:String ):void
        {
            _direction = (value == Direction.VERTICAL || value == Direction.HORIZONTAL ) ? value : null ;
            if ( isFull )
            {
            	update() ;
            }
        }
        
        /**
         * Determinates the IFillStyle reference of this display.
         */
        public function get fill():IFillStyle
        {
            return _fillStyle ;
        }
        
        /**
         * @private
         */
        public function set fill( style:IFillStyle ):void
        {
            _fillStyle = style ;
            if( _pen != null )
            {
                _pen.fill = _fillStyle ;
            }
            update() ;
        }

        /**
         * The rotation value to draw the linearGradientFill method when draw the background.
         */
        public var gradientRotation:Number = 0  ;
    
        /**
         * Determinates the virtual height value of this component.
         */
        public function get h():Number 
        {
            return ( isFull && (stage != null) && (_direction != Direction.HORIZONTAL) ) ? stage.stageHeight : _h ;    
        }
        
        /**
         * @private
         */
        public function set h( n:Number ):void 
        {
            _h = Mathematics.clamp( n , minHeight, maxHeight ) ;
            notifyResized() ;
            update() ;
        }

        /**
         * Indicates if the background use full size (Stage.width and Stage.height).
         */
        public function get isFull():Boolean
        {
            return _isFull ;
        }
        
        /**
         * @private
         */
        public function set isFull( b:Boolean ):void
        {
            _isFull = b ;
            update() ;
        }

        /**
         * Determinates the <code class="prettyprint">ILineStyle</code> reference of this display.
         */
        public function get line():ILineStyle
        {
            return _lineStyle ;
        }
        
        /**
         * @private
         */
        public function set line( style:ILineStyle ):void
        {
            _lineStyle = style ;
            if( _pen != null )
            {
                _pen.line = style ;
            }
            update() ;
        }

        /**
         * This property defined the mimimun height of this component.
         */
        public var minHeight:Number ;
        
        /**
         * This property defined the mimimun width of this component.
         */
        public var minWidth:Number ;
        
        /**
         * This property defined the maximum width of this component.
         */
        public var maxWidth:Number ;
        
        /**
         * This property defined the maximum height of this component.
         */
        public var maxHeight:Number ;
        
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public var topLeftRadius:Number = 0 ;
                
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public var topRightRadius:Number = 0 ;        
        
        /**
         * Indicates if the IFillStyle of this display use gradient box matrix (only if the IFillStyle is a FillGradientStyle).
         */
        public var useGradientBox:Boolean = false ;
        
        /**
         * Determinates the virtual height value of this component.
         */
        public function get w():Number 
        {
            return ( isFull && (stage != null) && (_direction != Direction.VERTICAL) ) ? stage.stageWidth : _w ;    
        }
        
        /**
         * @private
         */
        public function set w( n:Number ):void 
        {
            _w = Mathematics.clamp( n , minWidth, maxWidth ) ;
            notifyResized() ;
            update() ;
        }

        /**
         * Draw the display.    
         * @return the <code class="prettyprint">Dimension</code> object who defines the width and the height use in the method to draw the background.
         */
        public function draw( w:Number=NaN , h:Number=NaN , offsetX:Number=0 , offsetY:Number=0 ):Dimension
         {
    
             var $w:Number = isNaN(w) ? this.w : w ;
             var $h:Number = isNaN(h) ? this.h : h ;
            
            offsetX = isNaN(offsetX) ? 0 : offsetX ;
            offsetY = isNaN(offsetY) ? 0 : offsetY ;
            
            if ( useGradientBox && fill is FillGradientStyle )
            {
                
                var matrix:Matrix = new Matrix() ;
                matrix.createGradientBox( $w, $h );
                matrix.rotate(Trigo.degreesToRadians(gradientRotation)) ;
                
                ( fill as FillGradientStyle ).matrix = matrix ;
                
            }
            else
            {
				//                    
            }        
            
            _pen.draw(offsetX, offsetY, $w, $h, topLeftRadius , topRightRadius , bottomLeftRadius , bottomRightRadius, align ) ;
                    
            _real = new Dimension( $w, $h ) ;

            return _real ;

         }
         
        /**
         * Returns the event name use when the background is resized.
         * @return the event name use when the background is resized.
          */
        public function getEventTypeRESIZE():String
        {
            return _sResize ;    
        }
    
        /**
         * Init the pen to draw the background of this display.
         * This method is invoked in the constructor of the class.
         * You can override this method to change the shape of the background.
         * @return the IPen reference to draw the background of the display.
         */
        public function initBackgroundPen():IPen
        {
            var p:RoundedComplexRectanglePen = new RoundedComplexRectanglePen( this ) ;
            p.fill = _fillStyle ;
            p.line = _lineStyle ;
            return p ;    
        }

        /**
         * Notify an event when you resize the component.
         */
        public function notifyResized():void 
        {
            dispatchEvent( new BasicEvent( _sResize , this ) ) ;
        }

        /**
         * Sets the event name use when the background is resized.
         */
        public function setEventTypeRESIZE( type:String ):void
        {
            _sResize = type || Event.RESIZE ;
        }
        
        /**
         * Sets the virtual width (w) and height (h) values of the component.
         */
        public function setSize( w:Number, h:Number ):void
        {
            _w = Mathematics.clamp( w , minWidth, maxWidth) ;
            _h = Mathematics.clamp( h , minHeight, maxHeight) ;
            notifyResized() ;
            update() ;
        }
        
        /**
         * Update the display.
         */    
        public override function update():void 
        {
            if ( isLocked() ) 
            {
                return ;
            }
            draw() ;
            viewChanged() ;
        }

        /**
         * This method is invoked after the draw() method in the update() method.
         * Overrides this method.
         */
        public function viewChanged():void
        {
            // overrides
        }
        
        /**
         * @private
         */
        private var _direction:String ;
        
        /**
         * @private
         */
        protected var _h:Number ;
        
        /**
         * @private
         */
        protected var _w:Number ;
        
        /**
         * @private
         */
        private var _fillStyle:IFillStyle ;
                
        /**
         * @private
         */
        private var _isFull:Boolean = false ;

        /**
         * @private
         */
        private var _lineStyle:ILineStyle ;

        /**
         * @private
         */
        private var _pen:IPen ;
        
        /**
         * @private
         */
        private var _real:Dimension ;

        /**
         * @private
         */
        private var _sResize:String = Event.RESIZE ;
        
    }

}

