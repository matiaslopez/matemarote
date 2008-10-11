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
package lunas.display.button 
{
	import flash.display.DisplayObject;
	
	import lunas.core.AbstractButtonBuilder;
	import lunas.events.ButtonEvent;
	
	import pegas.colors.LightColor;
	import pegas.transitions.Tween;	

	/**
	 * The IBuilder class of the AquaButton component.
	 */
	public class LightFrameLabelButtonBuilder extends FrameLabelButtonBuilder
	{
		
		/**
		 * Creates a new LightFrameLabelButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function LightFrameLabelButtonBuilder( target:DisplayObject, bGlobal:Boolean = false, sChannel:String = null )
		{
			super( target, bGlobal, sChannel );
			_light = new LightColor( target ) ;
			_tw    = new Tween(_light) ;	
		}

		/**
		 * Invoked when the button is down.
		 */
		public function disabled( e:ButtonEvent ):void
		{
			if ( _tw.running )
			{
				_tw.stop() ;	
			}
			_light.reset() ;
		}
		
		/**
		 * Invoked when the button is down.
		 */
		public function down( e:ButtonEvent ):void
		{
			if ( _tw.running )
			{
				_tw.stop() ;	
			}
			var s:LightFrameLabelButtonStyle = (target as LightFrameLabelButton).style as LightFrameLabelButtonStyle ;
			if ( s != null )
			{
				if ( s.useEasingSelected )
				{
					_tw.duration   = s.easingSelectedDuration ;
					_tw.useSeconds = s.easingSelectedUseSeconds ;
					_tw.insertProperty( s.easingSelectedProperty, s.easingSelected, s.easingSelectedBegin, s.easingSelectedFinish ) ;
					_tw.run() ;
				}
			}
		}

		/**
		 * Initialize all register type of this builder.
		 */
		public override function initType():void
		{
			registerType( ButtonEvent.DISABLED , disabled ) ;
			registerType( ButtonEvent.DOWN     , down ) ;
			registerType( ButtonEvent.OVER     , over ) ;
			registerType( ButtonEvent.UP              ) ;
		}
	
		/**
		 * Invoked when the button is over.
		 */
		public function over( e:ButtonEvent ):void
		{
			if ( _tw.running )
			{
				_tw.stop() ;	
			}
			var s:LightFrameLabelButtonStyle = (target as LightFrameLabelButton).style as LightFrameLabelButtonStyle ;
			if ( s != null )
			{
				if ( s.useEasingOver )
				{
					_tw.duration   = s.easingOverDuration ;
					_tw.useSeconds = s.easingOverUseSeconds ;
					_tw.insertProperty( s.easingOverProperty, s.easingOver, s.easingOverBegin, s.easingOverFinish ) ;
					_tw.run() ;
				}
			}
		}
		
		/**
		 * @private
		 */
		private var _light:LightColor ;

		/**
		 * @private
		 */
		private var _tw:Tween ;		

	}
}
