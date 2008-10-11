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
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import lunas.core.AbstractButtonBuilder;
	import lunas.events.ButtonEvent;	

	/**
	 * The IBuilder class of the AquaButton component.
	 */
	public class FrameLabelButtonBuilder extends AbstractButtonBuilder 
	{
		
		/**
		 * Creates a new FrameLabelButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function FrameLabelButtonBuilder( target:DisplayObject, bGlobal:Boolean = false, sChannel:String = null )
		{
			super( target, bGlobal, sChannel );
		}
		
		/**
		 * Initialize all register type of this builder.
		 */
		public override function initType():void
		{
			registerType( ButtonEvent.DISABLED ) ;
			registerType( ButtonEvent.DOWN     ) ;
			registerType( ButtonEvent.OVER     ) ;
			registerType( ButtonEvent.UP       ) ;
		}
		
		/**
		 * Invoked when a ButtonEvent register in this button is dispatched.
		 */
		protected override function refreshState( e:Event ):void 
		{
			var type:String = e.type ;
			var states:MovieClip = (target as FrameLabelButton).states ;
			if ( states != null )
			{
				var noExistFrameLabel:Function = function( element:*, index:int, ar:Array ):Boolean
				{
				    return (element as FrameLabel).name != type ;
				} ;
				if ( !states.currentLabels.every( noExistFrameLabel , this ) )
				{
					states.gotoAndStop( type ) ;
				}
				else
				{
					states.gotoAndStop(1) ;
				}
			}
			super.refreshState(e) ;		
		}		
		
	}
}
