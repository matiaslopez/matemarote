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
    import lunas.core.AbstractButtonBuilder;
	import lunas.events.ButtonEvent;
	
	import pegas.colors.LightColor;
	import pegas.transitions.TweenLite;	

	/**
	 * The IBuilder class of the LightButton component.
	 */
	public class LightButtonBuilder extends AbstractButtonBuilder
	{
		
		/**
		 * Creates a new LightButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function LightButtonBuilder( target:LightButton, bGlobal:Boolean = false, sChannel:String = null )
		{
			super( target, bGlobal, sChannel );
			light = new LightColor( target ) ; // default
		}

		/**
		 * The light reference of this builder.
		 */
		public var light:LightColor ;

		/**
		 * Invoked when the button is down.
		 */
		public function disabled( e:ButtonEvent = null ):void
		{
			if (_tw != null &&  _tw.running )
			{
				_tw.stop() ;	
			}
			light.reset() ;
		}
		
		/**
		 * Invoked when the button is down.
		 */
		public function down( e:ButtonEvent = null ):void
		{
			if ( _tw != null && _tw.running )
			{
				_tw.stop() ;	
			}
			if ( light != null )
			{
				light.reset() ;
			}
			var s:LightButtonStyle = (target as LightButton).style as LightButtonStyle ;
			if ( s != null )
			{
				if ( s.tweenSelected != null )
				{
					_tw        = s.tweenSelected.clone() ;
					_tw.target = light ;
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
			registerType( ButtonEvent.UP       , up ) ;
		}

		/**
		 * Invoked when the button is over.
		 */
		public function over( e:ButtonEvent = null ):void
		{
			if ( _tw != null && _tw.running )
			{
				_tw.stop() ;	
			}
			if ( light )
			{
				light.reset() ;
			}
			var s:LightButtonStyle = (target as LightButton).style as LightButtonStyle ;
			if ( s != null )
			{
				if ( s.tweenOver != null )
				{
					_tw = s.tweenOver.clone() ;
					_tw.target = light ;
					_tw.run() ;
				}
			}
		}
		
		/**
		 * Invoked when the button is over.
		 */
		public function up( e:ButtonEvent = null ):void
		{
			
		}		

		/**
		 * @private
		 */
		private var _tw:TweenLite ;		

	}
}
