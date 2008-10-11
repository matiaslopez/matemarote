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
package lunas.core 
{
    import flash.events.Event;
    import flash.events.TimerEvent;
    
    import asgard.display.CoreSprite;
    
    import lunas.core.IBuilder;
    import lunas.core.IFocusable;
    import lunas.core.IStyle;
    import lunas.events.ComponentEvent;
    import lunas.events.StyleEvent;
    
    import pegas.transitions.FrameTimer;
    
    import system.Reflection;
    import system.numeric.Mathematics;    

    /**
	 * This class provides a skeletal implementation of all the components in Lunas, to minimize the effort required to implement this interface.
	 */
	public class AbstractComponent extends CoreSprite implements IComponent
	{

		/**
		 * Creates a new AbstractComponentDisplay instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function AbstractComponent( id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			
			super( id, isConfigurable, name );
			
			addEventListener( Event.REMOVED , viewDestroyed ) ;
			
			focusRect = false ;
			tabEnabled = this is IFocusable ;
			
			___timer___ = new FrameTimer(24, 1) ;
			___timer___.addEventListener(TimerEvent.TIMER, _redraw ) ;
			
			initialize() ;
			
			var cb:Class = getBuilderRenderer() ; 
            if ( cb != null && Reflection.getClassInfo(cb).hasInterface(IBuilder) )  			
			{
				builder = ( new cb(this) as IBuilder ) ;
			}
					
			var cs:Class = getStyleRenderer() ;
            if ( cs != null && Reflection.getClassInfo(cs).hasInterface(IStyle) ) 
			{
				var path:String = Reflection.getClassPath(this) ;
				if ( StyleCollector.contains( path ) )
				{
					style = StyleCollector.get( path ) ;
				}
				else
				{
					style = new cs( path ) as IStyle ; // creates the default singleton IStyle reference of this component
				}
			}
			
		}
		
        /**
         * Indicates the thickness, in pixels, of the four edge regions around a visual component.
         */
        public function get border():EdgeMetrics
        {
            return _border ;
        }
        
        /**
         * @private
         */
        public function set border( em:EdgeMetrics ):void
        {
            _border = em ||  EdgeMetrics.EMPTY ;
            update() ;
        }
		
		/**
		 * Indicates if the events use bubbling when are dispatched.
		 */
		public var bubbles:Boolean = true ;
		
		/**
		 * Indicates the IBuilder reference of this instance.
		 */
		public function get builder():IBuilder 
		{
			return _builder ;
		}
		
		/**
		 * @private
		 */
		public function set builder( builder:IBuilder ):void
		{
			if (_builder != null) 
			{
				_builder.clear() ;
				_builder = null ;
			}
			if ( builder != null ) 
			{
				_builder        = builder ;
				_builder.target = this    ;
				_builder.run() ;
			}
		}
		
		/**
		 * Indicates the enabled state of the component.
		 */
		public function get enabled():Boolean 
		{
			return _enabled ;
		}
		
		/**
		 * Sets the enabled state of the component.
		 */
		public function set enabled( b:Boolean ):void 
		{
			_enabled = (b == true) ;
			if ( isLocked() ) 
			{
				return ;
			}
			viewEnabled() ;
			notifyEnabled() ;
		}
		
		/**
		 * Indicates with a boolean if this object is grouped.
		 * @return <code class="prettyprint">true</code> if this object is grouped.
		 */
		public function get group():Boolean
		{
			return _group ;
		}
		
		/**
		 * @private
		 */
		public function set group(b:Boolean):void
		{
			_group = b ;
			groupPolicyChanged() ;
		}

		/**
	 	 * Indicates the name of the group of this object.
	 	 */
		public function get groupName():String
		{
			return _groupName ;
		}

		/**
		 * @private
		 */
		public function set groupName(sName:String ):void
		{
			_group        = sName != null ;
			_oldGroupName = _groupName ;
			_groupName    = sName ;	
			groupPolicyChanged() ;
			_oldGroupName = _groupName ;
		}

		/**
		 * (read-only) Indicates the virtual height value of this component.
		 */
		public function get h():Number 
		{
			return _h ;	
		}
		
		/**
		 * @private
		 */
		public function set h( n:Number ):void 
		{
			_h = isNaN(n) ? 0 : Mathematics.clamp(n, minHeight, maxHeight) ; 
			notifyResized() ;
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
		 * Returns the style of this component.
		 * @return the style of this component.
		 */
		public function get style():IStyle 
		{
			return _style ;
		}
			
		/**
		 * Sets the style of this component.
		 */
		public function set style( s:IStyle ):void 
		{
			_unregisterStyle() ;
			var path:String = Reflection.getClassPath(this) ;
			if ( s == null && StyleCollector.contains( path ) )
			{
				s = StyleCollector.get( path ) ; // default IStyle of the component
			}
			else if ( s == null ) 
			{
				return ;
			}
			_style = s ; 
			_registerStyle() ;
			if ( isLocked() ) 
			{
				return ;
			}
			dispatchEvent( new StyleEvent(StyleEvent.STYLE_CHANGE , this, bubbles  ) ) ;
			update() ;
		}
		
		/**
		 * (read-only) Indicates the virtual width value of this component.
		 */
		public function get w():Number 
		{ 
			return _w ;
		}
		
		/**
		 * (read-only) Sets the virtual width value of this component.
		 */
		public function set w( n:Number ):void 
		{
			_w = isNaN(n) ? 0 : Mathematics.clamp(n, minWidth, maxWidth) ; 
			notifyResized() ;
			update() ;
		}
		
		/**
		 * Launch an event with a delayed interval.
		 */
		public function doLater():void 
		{
			if ( isLocked() ) 
			{
				return ;
			}
			___timer___.start() ;
		}
		
		/**
		 * Draw the view of the component.
		 */
		public function draw( ...arguments:Array ):void
		{
			// overrides
		}

        /**
         * Returns the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         */
		public function getBuilderRenderer():Class 
		{
			return null ; // overrides
		}
		
        /**
         * Returns the <code class="prettyprint">IStyle</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">IStyle</code> constructor use to initialize this component.
         */
		public function getStyleRenderer():Class 
		{
			return null ; // overrides
		}
		
		/**
		 * Invoked when the group property or the groupName property changed.
		 * Overrides this method in concrete class.
		 */
		public function groupPolicyChanged():void 
		{
			//
		}
		
		/**
		 * Hides the component.
		 */
		public function hide():void 
		{
			visible = false ;
			fireComponentEvent( ComponentEvent.HIDE  ) ;
		}
		
		/**
		 * Returns <code class="prettyprint">true</code> if the component is visible.
		 * @return <code class="prettyprint">true</code> if the component is visible.
	 	*/
		public function isVisible():Boolean 
		{
			return visible ;
		}
		
		/**
		 * Initialize the component.
		 * You can override this method.
		 */
		public function initialize():void 
		{
			// overrides
		}
		
		/**
		 * Moves the component.
		 * @param x The x position of the component.
		 * @param y The y position of the component.
		 */
		public function move( x:Number=NaN , y:Number=NaN ):void
		{
			if ( !isNaN(x) )
			{
				this.x = x ;
			}
			if ( !isNaN(y) )
			{
				this.y = y ;
			}
			fireComponentEvent( ComponentEvent.MOVE ) ;
		}
		
		/**
		 * Notify a change in this component.
		 */
		public function notifyChanged():void 
		{
			fireComponentEvent( ComponentEvent.CHANGE ) ;
		}		
				
		/**
		 * Notify an event when the enabled property is changed. 
		 * This event can be a ComponentEvent.ENABLED or ComponentEvent.DISABLED event.
		 */
		public function notifyEnabled():void
		{
			fireComponentEvent( ComponentEvent.ENABLED ) ;	
		}
		
		/**
		 * Notify an event when you resize the component.
		 */
		public function notifyResized():void 
		{
			viewResize() ;
			fireComponentEvent( ComponentEvent.RESIZE ) ;
		}
		
		/**
		 * Refresh the component with an object of initialization.
		 * This method launch the update() method.
		 */
		public function refresh( init:* ):void 
		{
			for ( var prop:String in init ) 
			{
				this[prop] = init[prop] ;
			}
			update() ;
		}
		
		/**
		 * Sets the virtuals width and height of the component.
		 */
		public function setSize( w:Number, h:Number):void 
		{
			_w = isNaN(w) ? 0 : Mathematics.clamp( w , minWidth, maxWidth) ; 
			_h = isNaN(h) ? 0 : Mathematics.clamp( h , minHeight, maxHeight) ; 
			notifyResized() ;
			update() ;
		}
		
		/**
		 * Sets the style property on the style declaration or object.
		 */
		public function setStyle( ...args:Array ):void 
		{
			if ( args.length == 1 && args[0] is IStyle )
			{
				style = args[0] as IStyle ;
			}
			else
			{
				style.setStyle.apply( style , args ) ;
			}
		}		
		
		/**
		 * Shows the component.
		 */
		public function show():void 
		{
			visible = true ;
			fireComponentEvent( ComponentEvent.SHOW  ) ;
		}
		
		/**
		 * Updates the component. This method is invoked when the component must be refresh.
		 */
		public override function update():void 
		{
			if ( isLocked() ) 
			{
				return ;
			}
			draw() ;
			if ( _builder != null ) 
			{
				_builder.update() ;
			}
			viewChanged() ;
			fireComponentEvent( Event.RENDER ) ;
		}
		
		/**
		 * Invoked after the draw method and when the IBuilder is updated.
		 * This method is empty you can override it.
		 */
		public function viewChanged():void 
		{
			// overrides
		}
		
		/**
		 * Invoked when the component is destroyed with a removeMovieClip.
		 * Overrides this method.
		 */
		public function viewDestroyed( e:Event=null ):void 
		{
			// overrides
		}
		
		/**
		 * Invoked when the enabled property of the component change.
		 * Overrides this method.
		 */
		public function viewEnabled():void 
		{
			// overrides
		}
		
		/**
		 * Invoked when the component is resized.
		 * Overrides this method.
		 */
		public function viewResize():void 
		{
			// overrides
		}
		
		/**
		 * Invoked when the component IStyle changed.
		 * Overrides this method.
		 */
		public function viewStyleChanged( e:Event=null ):void 
		{
			// overrides
		}

        /**
         * @private
         */
        private var _border:EdgeMetrics = EdgeMetrics.EMPTY ;		
		
		/**
		 * @private
		 */
		private var _builder:IBuilder ;
		
		/**
		 * @private
		 */
		private var _enabled:Boolean = true ;
		
		/**
		 * @private
		 */
		private var _group:Boolean ;

		/**
		 * @private
		 */
		private var _groupName:String ;
        
		/**
		 * The protected virtual height value of the component.
		 */
		protected var _h:Number = 0 ;

        /**
         * @private
         */
        protected var _oldGroupName:String ; 

		/**
		 * @private
		 */
		private var _style:IStyle ;
		
		/**
		 * @private
		 */
		private var ___timer___:FrameTimer ;		
	
		/**
		 * The protected virtual width value of the component.
		 */
		protected var _w:Number = 0 ;		
		
		/**
		 * Dispatchs a ComponentEvent with the specified type.
		 */
		protected function fireComponentEvent( type:String ):void
		{
			dispatchEvent( new ComponentEvent( type , this , bubbles )  ) ;
		}
		
		/**
		 * Redraws the component.
		 */	
		private function _redraw( ev:TimerEvent ):void 
		{
			___timer___.stop() ;
			update() ;
		}
		
		/**
		 * Register the IStyle reference of the component.
		 */
		private function _registerStyle():void
		{
			if (_style != null)
			{
				_style.addEventListener( StyleEvent.STYLE_CHANGE       , viewStyleChanged ) ;
				_style.addEventListener( StyleEvent.STYLE_SHEET_CHANGE , viewStyleChanged ) ;
			}
		}

		/**
		 * Unregister the IStyle reference of the component.
		 */
		private function _unregisterStyle():void
		{
			if ( _style != null ) 
			{
				_style.removeEventListener( StyleEvent.STYLE_CHANGE       , viewStyleChanged ) ;
				_style.removeEventListener( StyleEvent.STYLE_SHEET_CHANGE , viewStyleChanged ) ;
				_style = null ;
			}
		}

	}

}
