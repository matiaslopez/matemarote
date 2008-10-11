/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.core 
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import lunas.core.IButton;
    import lunas.events.ButtonEvent;
    import lunas.events.ComponentEvent;
    import lunas.groups.RadioButtonGroup;	

    /**
	 * This class provides a skeletal implementation of the <code class="prettyprint">IButton</code> interface, to minimize the effort required to implement this interface.
	 * @author eKameleon
	 */
	public class AbstractButton extends AbstractComponent implements IButton 
	{

		/**
		 * Creates a new AbstractButton instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
	 	 */	
		public function AbstractButton(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name ) ;
			registerView() ;
			buttonMode    = true ;
			mouseEnabled  = true ;
			useHandCursor = true ;
		}
		
		/**
		 * Specifies whether this object receives mouse messages.
		 */
		public override function set buttonMode( b:Boolean ):void 
		{
			_buttonMode = enabled ;
			if ( _scope != null && _scope != this )
			{
				
				super.buttonMode = false ;
				_scope.buttonMode = _buttonMode ;
			}
			else
			{
				super.buttonMode =_buttonMode ;
			}
		}
		
		/**
		 * Indicates the data value object of the component.
		 */
		public function get data():*
		{
			return _data ;	
		}
		
		/**
		 * @private
		 */
		public function set data( value:* ):void
		{
			_data = value ;
		}
		
		/**
		 * A number value to indicated the index of this IButton.
		 */
		public var index:Number ;

		/**
	 	 * Returns the text label for a button instance.
	 	 * @return the text label for a button instance.
	 	 */
		public function get label():String
		{
			return _label ;
		}
		
		/**
	 	 * @private
	 	 */
		public function set label(str:String):void
		{
			_label = str ; 
			viewLabelChanged() ;
			dispatchEvent( new ButtonEvent( ComponentEvent.LABEL_CHANGE ) ) ;
		}

		/**
		 * Specifies whether this object receives mouse messages.
		 */
		public override function get mouseEnabled():Boolean
		{
			return ( _scope == this ) ? super.mouseEnabled : _scope.mouseEnabled ;
		}
		
		/**
		 * @private
		 */
		public override function set mouseEnabled( b:Boolean ):void 
		{
			_mouseEnabled = b ;
			if ( _scope == this )
			{
				super.mouseEnabled = _mouseEnabled && enabled ;
			}
			else
			{
				_scope.mouseEnabled = _mouseEnabled && enabled ;
			}
		}
		
		/**
		 * A flag that indicates whether this control is selected.
		 */
		public function get selected():Boolean
		{
			return _selected ;
		}
		
		/**
		 * @private
		 */
		public function set selected(b:Boolean):void
		{
			setSelected( b ) ;
		}
		
		/**
		 * Returns the scope reference of this IButton.
		 * @return the scope reference of this IButton.
		 */
		public function scope():Sprite
		{
			return _scope || this ;	
		}
		
		/**
		 * Indicates a boolean value indicating whether the button behaves as a toggle switch (true) or not (false). 
		 */
		public function get toggle():Boolean
		{
			return _toggle ;
		}

		/**
		 * @private
		 */
		public function set toggle(b:Boolean):void
		{
			_toggle = b ;	
			setSelected ( false, true ) ;
		}
		
		/**
		 * A Boolean value that, when set to true, indicates whether Flash Player displays the hand cursor when the mouse rolls over a button.
		 */
		public override function get useHandCursor():Boolean
		{
			return _useHandCursor ;
		}
		
		/**
		 * @private
		 */
		public override function set useHandCursor( b:Boolean ):void 
		{
			if ( _scope != null && _scope != this )
			{
				_scope.useHandCursor = false ;
				super.useHandCursor  = b ;
			}
			else
			{
				super.useHandCursor = b ;
			}
		}
		
		/**
		 * Invoked when the group property or the groupName property changed.
		 * Overrides this method in concrete class.
		 */
		public override function groupPolicyChanged():void 
		{
			if ( group == true ) 
			{
				addEventListener( ButtonEvent.DOWN , RadioButtonGroup.getInstance().handleEvent ) ;
			}
			else
			{
				removeEventListener( ButtonEvent.DOWN , RadioButtonGroup.getInstance().handleEvent ) ;
			}
		}		
		
		/**
		 * Register the view in argument.
		 */
		public function registerView( scope:Sprite = null ):void
		{
			unregisterView() ;
			_scope = ( scope == null ) ? this : ( ( scope.parent == this ) ? scope : this ) ;
			if( _scope != null )
			{
			
				_scope.buttonMode    = buttonMode ;
				_scope.mouseEnabled  = mouseEnabled ;
				_scope.useHandCursor = useHandCursor ;
				if ( enabled )
				{
					_registerScope() ;
				}
			}
		}
			
		/**
		 * Sets a boolean value indicating whether the button is selected (true) or not (false). 
		 * The default value is false.
		 */
		public function setSelected ( b:Boolean, flag:Boolean=false ):void 
		{
			_selected =  (_toggle) ? b : null ;
			if ( enabled )
			{
				dispatchEvent ( new ButtonEvent( _selected ? ButtonEvent.DOWN : ButtonEvent.UP , this ) ) ;
			}
			if ( flag == false ) 
			{
				dispatchEvent( new ButtonEvent( _selected ? ButtonEvent.SELECT : ButtonEvent.UNSELECT ) ) ;
			}
		}
		
		/**
		 * Unregister the view of this button.
		 */
		public function unregisterView():void
		{
			if (_scope != null) 
			{
				_scope.buttonMode    = false ;
				_scope.useHandCursor = false ;
				_scope.mouseEnabled  = false ;
				_unregisterScope() ;
				_scope = null ;
			}
		}

		/**
		 * Invoked when the enabled property of the component change.
		 */
		final public override function viewEnabled():void 
		{
			var type:String ;
			_scope.mouseEnabled = enabled ;
			if ( enabled == true ) 
			{
				type = (toggle && selected) ? ButtonEvent.DOWN : ButtonEvent.UP ;
			}
			else 
			{
				type = ButtonEvent.DISABLED ;
			}
			dispatchEvent( new ButtonEvent( type, this ) ) ;
		}
		
		/**
		 * Invoked when the label property of the component change.
		 */
		public function viewLabelChanged():void 
		{
			// overrides
		}
		
		/**
		 * @private
		 */
		private var _buttonMode:Boolean ;
		
		/**
		 * @private
		 */
		private var _data:* ;
		
		/**
		 * @private
		 */
		private var _label:String ;
		
		/**
		 * @private
		 */
		private var _mouseEnabled:Boolean ;
		
		/**
		 * The scope of the active display of this button component.
		 */
		protected var _scope:Sprite ;	

		/**
		 * @private
		 */
		private var _toggle:Boolean ;

		/**
		 * @private
		 */
		private var _selected:Boolean ;

		/**
		 * @private
		 */
		private var _useHandCursor:Boolean ;

		/**
		 * Dispatchs a ButtonEvent with the specified type.
		 */
		protected function _fireButtonEvent( type:String ):void 
		{
			dispatchEvent( new ButtonEvent( type, this , true ) ) ;
		}	
		
		/**
		 * @private
		 */
		private function _onMouseDown( e:MouseEvent ):void 
		{
			if ( !enabled )
			{
				return ;
			}
			if ( _toggle == true ) 
			{
				selected = !selected ;
			}
			else 
			{
				dispatchEvent( new ButtonEvent( ButtonEvent.DOWN , this ) ) ;
			}
		}
		
		/**
		 * @private
		 */
		private function _onMouseUp( e:MouseEvent ):void 
		{ 
			if ( !_toggle && enabled ) 
			{
				_fireButtonEvent( ButtonEvent.UP ) ;
			}
		}

		/**
		 * @private
		 */
		private function _onRollOut( e:MouseEvent ):void 
		{
			if ( !enabled )
			{
				return ;
			}
			if ( !_toggle || !_selected ) 
			{
				_fireButtonEvent( ButtonEvent.UP ) ;
				_fireButtonEvent( ButtonEvent.OUT ) ;
			}
			else if (_selected)
			{
				_fireButtonEvent( ButtonEvent.OUT_SELECTED ) ;
			}
		}

		/**
		 * @private
		 */
		private function _onRollOver( e:MouseEvent ):void 
		{
			if ( !enabled )
			{
				return ;
			}
			if ( !_toggle || !_selected ) 
			{
				_fireButtonEvent( ButtonEvent.OVER ) ;
			}
			else if (_selected) 
			{ 
				_fireButtonEvent( ButtonEvent.OVER_SELECTED ) ;
			}
		}	

		/**
		 * @private
		 */
		private function _registerScope():void
		{
			if (_scope != null) 
			{
				_scope.addEventListener( MouseEvent.ROLL_OUT    , _onRollOut  ) ; 
				_scope.addEventListener( MouseEvent.ROLL_OVER   , _onRollOver ) ;
				_scope.addEventListener( MouseEvent.MOUSE_DOWN  , _onMouseDown    ) ;
				_scope.addEventListener( MouseEvent.MOUSE_UP    , _onMouseUp  ) ;
			}
		}	
		
		/**
		 * @private
		 */
		private function _unregisterScope():void
		{
			if (_scope != null) 
			{
				_scope.removeEventListener( MouseEvent.ROLL_OUT   , _onRollOut  ) ; 
				_scope.removeEventListener( MouseEvent.ROLL_OVER  , _onRollOver ) ;
				_scope.removeEventListener( MouseEvent.MOUSE_DOWN , _onMouseDown    ) ;
				_scope.removeEventListener( MouseEvent.MOUSE_UP   , _onMouseUp  ) ;
			}
		}	
	
	}

}
