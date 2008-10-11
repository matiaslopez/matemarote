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
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import lunas.core.AbstractScrollbar;
    import lunas.core.EdgeMetrics;
    import lunas.display.button.FrameLabelButton;
    
    import pegas.draw.Direction;
    import pegas.draw.FillStyle;
    import pegas.draw.IFillStyle;
    import pegas.draw.ILineStyle;
    import pegas.draw.LineStyle;
    import pegas.draw.RectanglePen;	

    // TODO add timer when the thumb or the arrow button are clicked (see Flash CS3 component ? or Flex ?)
	
	/**
	 * The SimpleScrollbar component.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import flash.display.StageScaleMode ;
	 * 
	 * import pegas.draw.FillStyle ;
	 * import pegas.draw.LineStyle ;
	 * 
	 * import lunas.core.Direction ;
	 * import lunas.core.EdgeMetrics ;
	 * import lunas.display.bar.SimpleScrollbar ;
	 * import lunas.events.ButtonEvent ;
	 * import lunas.events.ComponentEvent ;
	 * 
	 * stage.scaleMode = StageScaleMode.NO_SCALE ;
	 * 
	 * var change:Function = function( e:ComponentEvent ):void
	 * {
	 *     trace( e.type + " : " + bar.position ) ;
	 * }
	 * 
	 * var bar:SimpleScrollbar = new SimpleScrollbar() ;
	 * 
	 * addChild(bar) ;
	 * 
	 * // behaviours of the scrollbar
	 * 
	 * bar.addEventListener( ComponentEvent.CHANGE , change ) ;
	 * bar.thumbSize = 30 ;
	 * bar.position  = 50 ;
	 * bar.x         = 50 ;
	 * bar.y         = 50 ;
	 * 
	 * // initialize style of the scrollbar
	 * 
	 * bar.barFillStyle    = new FillStyle( 0x921085 , 1 ) ;
	 * bar.barLineStyle    = new LineStyle( 1 , 0x6A9195, 1 ) ;
	 * bar.thumbFillStyle  = new FillStyle( 0xB5C7CA , 1 ) ;
	 * bar.thumbLineStyle  = new LineStyle( 2 , 0xFFFFFF , 1 ) ;
	 * 
	 * var shadow:DropShadowFilter = new DropShadowFilter( 1, 45, 0x000000, 0.6, 6, 6, 1, 6) ;
	 * bar.filters = [ shadow  ] ;
	 * bar.thumb.filters = [ shadow ] ;
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
	 *         case Keyboard.UP :
	 *         {
	 *             bar.position = bar.minimum ;
	 *             break ;
	 *         }
	 *         case Keyboard.DOWN :
	 *         {
	 *             bar.position = bar.maximum ;
	 *             break ;
	 *          }
	 *          case Keyboard.SPACE :
	 *          {
	 *              bar.direction = ( bar.direction == Direction.VERTICAL ) ? Direction.HORIZONTAL : Direction.VERTICAL ;
	 *              if ( bar.direction == Direction.VERTICAL )
	 *              {
	 *                  bar.setSize( 8, 200 ) ;
	 *              }
	 *              else
	 *              {
	 *                  bar.setSize( 200, 8 ) ;
	 *              }
	 *          }
	 *          default :
	 *          {
	 *              bar.minimum = 20 ; // change the minimum value of the bar
	 *              bar.maximum = 80 ; // change the maximum value of the bar
	 *              bar.invert = !bar.invert ; // invert the positive direction of the bar scroll.
	 *          }
	 *     }
	 * }
	 * 
	 * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
	 * </pre>
	 * @author eKameleon
	 */
	public class SimpleScrollbar extends AbstractScrollbar 
	{

		/**
		 * Creates a new SimpleScrollbar instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function SimpleScrollbar(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			
			super( id, isConfigurable, name );
			
			// views
			
			container = new Sprite() ;
			bar       = new Sprite() ;
			thumb     = new Sprite() ;
			
			// behaviours
			
			bar.addEventListener( MouseEvent.MOUSE_DOWN , _barDown ) ;
			bar.buttonMode    = true  ;
			bar.useHandCursor = false ;
			
			thumb.addEventListener( MouseEvent.MOUSE_DOWN , startDragging ) ;
			thumb.buttonMode    = true ;
			thumb.useHandCursor = true ;
			
			addChild(container) ;
			
			container.addChild(bar) ;
			container.addChild(thumb) ;
			
			_barPen   = new RectanglePen( bar )   ;
			_thumbPen = new RectanglePen( thumb ) ;
			
			_barPen.fill = new FillStyle( 0xA2A2A2, 1 ) ;
			_barPen.line = new LineStyle( 1, 0xA2A2A2 , 1) ;

			_thumbPen.fill = new FillStyle( 0xFFFFFF, 1 ) ;
			_thumbPen.line = new LineStyle( 1, 0xA2A2A2 , 1) ;
			
			setSize(200, 6) ;
		
		}

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
		 * (read-write) Indicates the bottom button used when the bar direction is Direction.VERTICAL.
		 */
		public function get bottomButton():FrameLabelButton
		{
			return _bottomButton ;	
		}
		
		/**
		 * @private
		 */
		public function set bottomButton( button:FrameLabelButton ):void
		{
			if ( _bottomButton != null )
			{
				if ( contains( _bottomButton ) )
				{
					removeChild( _bottomButton ) ;
				}
				_bottomButton.removeEventListener(MouseEvent.CLICK, _bottomClick) ;
				_bottomButton = null ;
			}			
			if ( button != null )
			{
				_bottomButton = button ;
				_bottomButton.addEventListener(MouseEvent.CLICK, _bottomClick) ;
			}	
			update() ;
		}
		
		/**
		 * (read-write) Indicates the left button used when the bar direction is Direction.HORIZONTAL.
		 */
		public function get leftButton():FrameLabelButton
		{
			return _leftButton ;	
		}
		
		/**
		 * @private
		 */
		public function set leftButton( button:FrameLabelButton ):void
		{
			if ( _leftButton != null )
			{
				if ( contains( _leftButton ) )
				{
					removeChild( _leftButton ) ;
				}
				_leftButton.removeEventListener(MouseEvent.CLICK, _leftClick) ;
				_leftButton = null ;
			}			
			if ( button != null )
			{
				_leftButton = button ;
				_leftButton.addEventListener(MouseEvent.CLICK, _leftClick) ;
			}	
			update() ;
		}

		/**
		 * (read-write) Indicates the right button used when the bar direction is Direction.HORIZONTAL.
		 */
		public function get rightButton():FrameLabelButton
		{
			return _rightButton ;	
		}
		
		/**
		 * @private
		 */
		public function set rightButton( button:FrameLabelButton ):void
		{
			if ( _rightButton != null )
			{
				if ( contains( _rightButton ) )
				{
					removeChild( _rightButton ) ;
				}
				_rightButton.removeEventListener(MouseEvent.CLICK, _rightClick) ;
				_rightButton = null ;
			}			
			if ( button != null )
			{
				_rightButton = button ;
				_rightButton.addEventListener(MouseEvent.CLICK, _rightClick) ;
			}	
			update() ;
		}
		
        /**
         * Determinates the fill style object of the thumb.
         */
        public function get thumbFillStyle():IFillStyle
        {
            return _thumbPen.fill ;
        }
        
        /**
         * @private
         */        
        public function set thumbFillStyle( style:IFillStyle ):void
        {
            _thumbPen.fill = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the thumb.
         */
        public function get thumbLineStyle():ILineStyle
        {
            return _thumbPen.line ;
        }
        
        /**
         * @private
         */        
        public function set thumbLineStyle( style:ILineStyle ):void
        {
            _thumbPen.line = style ;
            update() ;
        }
        

        /**
         * (read-write) Indicates the top button used when the bar direction is Direction.VERTICAL.
         */
        public function get topButton():FrameLabelButton
        {
            return _topButton ; 
        }
        
        /**
         * @private
         */
        public function set topButton( button:FrameLabelButton ):void
        {
            if ( _topButton != null )
            {
                if ( contains( _topButton ) )
                {
                    removeChild( _topButton ) ;
                }
                _topButton.removeEventListener(MouseEvent.CLICK, _topClick) ;
                _topButton = null ;
            }           
            if ( button != null )
            {
                _topButton = button ;
                _topButton.addEventListener(MouseEvent.CLICK, _topClick) ;
            }   
            update() ;
        }           
        
		/**
		 * Draw the view of the component.
		 */
		public override function draw( ...arguments:Array ):void
		{
			try
			{
				
				_reset() ;
				
				if ( direction == Direction.HORIZONTAL )
				{
					if ( leftButton != null )
					{
						addChild( leftButton ) ;
					}
					if ( rightButton != null )
					{
						rightButton.x = w - rightButton.width ;
						addChild( rightButton ) ;
					}
				}
				else
				{
					
					if ( topButton != null )
					{
						addChild( topButton ) ;
					}
					if ( bottomButton != null )
					{
						bottomButton.y = h - bottomButton.height ;	
						addChild( bottomButton ) ;
					}
				}
							
				var $x:Number, $y:Number, $w:Number, $h:Number ;
				
				var padding:EdgeMetrics = (style as SimpleScrollbarStyle).padding || EdgeMetrics.EMPTY ;
				
				var pb:Number = EdgeMetrics.filterNaNValue( padding.bottom ) ;
				var pl:Number = EdgeMetrics.filterNaNValue( padding.left ) ;
				var pr:Number = EdgeMetrics.filterNaNValue( padding.right ) ;
				var pt:Number = EdgeMetrics.filterNaNValue( padding.top ) ;
				
				if ( direction == Direction.HORIZONTAL )
				{
					$x = (leftButton != null) ? (leftButton.x + leftButton.width + pl) : 0  ;
					$y = 0 ;
					$w = w -  $x - ((rightButton != null) ? ( rightButton.width + pr ) : 0 )  ;
					$h = h ;
				}
				else
				{
					$x = 0 ;
					$y = ( topButton != null ? ( topButton.y + topButton.height ) : 0 ) + pt ;	
					$w = w ;
					$h = h - $y - ( (bottomButton != null) ? bottomButton.height : 0 ) - pb - pt ;			
				}
			
				container.x = $x ;
				container.y = $y ;
				
				_barPen.draw( 0, 0, $w , $h ) ;
			
				var hBorder:Number = EdgeMetrics.filterNaNValue( border.top )  + EdgeMetrics.filterNaNValue( border.bottom ) ;
				var wBorder:Number = EdgeMetrics.filterNaNValue( border.left ) + EdgeMetrics.filterNaNValue( border.right )  ;
		
				var s:Number = thumbSize ;
				
				thumb.x      = EdgeMetrics.filterNaNValue( border.top ) ;
				thumb.y      = EdgeMetrics.filterNaNValue( border.left ) ;
							
				if ( direction == Direction.HORIZONTAL )
				{
					_thumbPen.draw( 0, 0, s, $h - hBorder ) ;
				}
				else
				{
					_thumbPen.draw( EdgeMetrics.filterNaNValue( border.top ), EdgeMetrics.filterNaNValue( border.left ), $w - wBorder , s ) ;
				}
				
				bar.filters   = (style as SimpleScrollbarStyle).barFilters ;
				thumb.filters = (style as SimpleScrollbarStyle).thumbFilters ;
				
			}
			catch(e:Error)
			{
				//	
			}
		}
		
		/**
		 * Returns the IStyle Class of this instance.
		 * @return the IStyle Class of this instance.
	 	 */		
		public override function getStyleRenderer():Class
		{
			return SimpleScrollbarStyle ;
		}

		/**
		 * Sets with this methods the pageSize, minimum, maximum and lineScrollSize values.
		 * @param maximum Number which represetns the top of the scrolling range.
		 * @param minimum Number which represents the bottom of the scrolling range.
		 * @param lineScrollSize Number which represents the increment to move when the scroll track is pressed.
		 * @param pageSize Number which represents the size of one page.
		 */
		public function setScrollProperties( minimum:Number=0, maximum:Number=100, lineScrollSize:Number=1, pageSize:Number=0 ):void
		{
			this.maximum        = maximum ;
			this.minimum        = minimum ;
			this.lineScrollSize = lineScrollSize ;
			this.pageSize       = pageSize ;
		}

		/**
		 * Invoked when the enabled property of the component change.
		 */
		public override function viewEnabled():void 
		{
			bar.mouseEnabled   = enabled ;
			thumb.mouseEnabled = enabled ;
			if ( leftButton != null )
			{
				leftButton.enabled = enabled ;
			}
			if ( rightButton != null )
			{
				rightButton.enabled = enabled ;
			}
			if ( topButton != null )
			{
				topButton.enabled = enabled ;
			}
			if ( bottomButton != null )
			{
				bottomButton.enabled = enabled ;	
			}			
		}

		/**
		 * Invoked when the component IStyle changed.
		 */
		public override function viewStyleChanged( e:Event=null ):void 
		{
			update() ;
		}

		/**
		 * The internal container display of the bar and the thumb.
		 */
		protected var container:Sprite ;

		/**
		 * @private
		 */
		private var _barPen:RectanglePen ;

		/**
		 * @private
		 */
		private var _bottomButton:FrameLabelButton ;

		/**
		 * @private
		 */
		private var _leftButton:FrameLabelButton ;

		/**
		 * @private
		 */
		private var _rightButton:FrameLabelButton ;
	
		/**
		 * @private
		 */
		private var _thumbPen:RectanglePen ;
	
		/**
		 * @private
		 */
		private var _topButton:FrameLabelButton ;

		/**
		 * @private
		 */	
		private function _barDown( e:MouseEvent ):void
		{
			var pos:Number = direction == Direction.HORIZONTAL ? e.localX : e.localY ;
			var sign:int = invert ? -1 : 1 ;
			if ( direction == Direction.HORIZONTAL )
			{
				if ( pos < thumb.x )
				{
					sign *= -1 ;	
				}
				else if ( pos > ( thumb.x + thumb.width ) )
				{
					sign *= 1 ;	
				}
				else
				{
					sign *= 0 ;	
				}
			}
			else
			{
				if ( pos < thumb.y )
				{
					sign *= -1 ;	
				}
				else if ( pos > ( thumb.y + thumb.height ) )
				{
					sign *= 1 ;	
				}
				else
				{
					sign *= 0 ;	
				}
			}
			position += pageSize * sign ;
		}
		
		/**
		 * @private
		 */		
		private function _bottomClick( e:MouseEvent ):void
		{
			position += lineScrollSize * (invert ? -1 : 1) ;
		}		

		/**
		 * @private
		 */		
		private function _leftClick( e:MouseEvent ):void
		{
			position -= lineScrollSize * (invert ? -1 : 1) ;
		}

		/**
		 * @private
		 */	
		private function _rightClick( e:MouseEvent ):void
		{
			position += lineScrollSize * (invert ? -1 : 1) ;
		}	

		/**
		 * @private
		 */
		private function _reset():void
		{
			if ( bottomButton != null && contains( bottomButton ) ) removeChild( bottomButton ) ;
			if ( leftButton   != null && contains( leftButton )   ) removeChild( leftButton ) ;
			if ( rightButton  != null && contains( rightButton )  ) removeChild( rightButton ) ;
			if ( topButton    != null && contains( topButton )    ) removeChild( topButton ) ;
		}
		
		/**
		 * @private
		 */		
		private function _topClick( e:MouseEvent ):void
		{
			position -= lineScrollSize * (invert ? -1 : 1) ;
		}		
		
	}
}
