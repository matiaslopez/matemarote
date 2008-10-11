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
	import flash.display.MovieClip;
	
	import lunas.core.AbstractButton;	

	/**
	 * The FrameLabelButton class is use over a "state" MovieClip with the 4 default frame's labels with the name :
 	 * <ul>
 	 * <li>"disabled" : the frame when the button is disabled.</li>
	 * <li>"down"     : the frame when the button is down.</li>
	 * <li>"over"     : the frame when the button is over.</li>
	 * <li>"up"       : the first frame when the button is up.</li>
	 * </ul>
	 * <p>The <code class="prettyprint">stop()</code> method is call in the first frame of the component when the constructor is launched.</p>
	 * This class looks like SimpleButton class but you can use the <code class="prettyprint">registerType()</code> and the <code class="prettyprint">unregisterType()</code> method to add or remove a ButtonEvent type (DISABLED, OVER, DOWN...) corresponding with a frame label in the MovieClip view of the button.
	 * <p>
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import lunas.display.button.FrameLabelButton ;
	 * import lunas.events.ButtonEvent ;
	 * 
	 * var bt:FrameLabelButton = new FrameLabelButton() ;
	 * bt.x = 50 ;
	 * bt.y = 50 ;
	 * 
	 * // only if toggle is true and selected is true
	 * 
	 * bt.registerType( ButtonEvent.OVER_SELECTED ) ;
	 * bt.registerType( ButtonEvent.OUT_SELECTED ) ;
	 * 
	 * addChild(bt) ;
	 * 
	 * try
	 * {
	 *     // The QuestionButton is the class of a MovieClip in the library of the swf who extends MovieClip
	 *     bt.states = new QuestionButton() ;
	 * }
	 * catch(e:Error )
	 * {
	 *     trace(e) ;
	 * }
	 * 
	 * // test the toggle
	 * 
	 * var keyDown:Function = function( e:KeyboardEvent ):void
	 * {
	 *     var code:uint = e.keyCode ;
	 *     switch( code )
	 *     {
	 *         case Keyboard.SPACE :
	 *         {
	 *              bt.enabled = !bt.enabled ;
	 *              break ;
	 *         }
	 *         default :
	 *         {
	 *              bt.toggle = !bt.toggle ;
	 *         }
	 *     }
	 * }
	 * 
	 * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
	 * 
	 * // debug
	 * 
	 * var debug:Function = function( e:Event ):void
	 * {
	 *     trace( "toggle:" + bt.toggle + " selected:" + bt.selected + " type:" + e.type + " enabled:" + bt.enabled ) ;
	 * }
	 * 
	 * bt.addEventListener( ButtonEvent.CLICK         , debug ) ;
	 * bt.addEventListener( ButtonEvent.DISABLED      , debug ) ;
	 * bt.addEventListener( ButtonEvent.DOWN          , debug ) ;
	 * bt.addEventListener( ButtonEvent.OUT           , debug ) ;
	 * bt.addEventListener( ButtonEvent.OUT_SELECTED  , debug ) ;
	 * bt.addEventListener( ButtonEvent.OVER          , debug ) ;
	 * bt.addEventListener( ButtonEvent.OVER_SELECTED , debug ) ;
	 * bt.addEventListener( ButtonEvent.SELECT        , debug ) ;
	 * bt.addEventListener( ButtonEvent.UNSELECT      , debug ) ;
	 * bt.addEventListener( ButtonEvent.UP            , debug ) ;
	 * </pre>
	 */
	public class FrameLabelButton extends AbstractButton 
	{

		/**
		 * Creates a new FrameLabelButton instance.
		 * @param states the MovieClip reference with the state frames of this button.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
	 	 */	
		public function FrameLabelButton( states:MovieClip=null , id:* = null, isConfigurable:Boolean = false, name:String = null )
		{
			super( id, isConfigurable, name );
			if ( states != null )
			{
				this.states = states ;
			}
		}
		
		/**
		 * This flag indicates if a new state register in the button is initialize. 
		 */
		public var initStatesEnabled:Boolean = true ;
		
		/**
		 * Indicates the MovieClip reference with the state frames of this button.
		 */
		public function get states():MovieClip
		{
			return _states ;	
		}
		
		/**
		 * @private
		 */
		public function set states( states:MovieClip ):void
		{
			if ( _states != null )
			{
				removeChild(_states) ;
			}
			_states = states ;
			if ( _states != null )
			{
                if ( initStatesEnabled )
                {
				    initStates() ;
                }
				_states.mouseEnabled = false ;
				_states.gotoAndStop(1); // fix the MovieClip and stop this frame in the first frame.
				addChild(_states) ;
			}
		}

		/**
		 * Returns <code class="prettyprint">true</code> if the specified type is register in the object.
		 * @return <code class="prettyprint">true</code> if the specified type is register in the object.
		 */
		public function containsType( type:String ):Boolean
		{
			return (builder as FrameLabelButtonBuilder).containsType( type ) ;	
		}

		/**
		 * Returns the constructor function of the <code class="prettyprint">IBuilder</code> of this instance.
		 * @return the constructor function of the <code class="prettyprint">IBuilder</code> of this instance.
		 */
		public override function getBuilderRenderer():Class
		{
			return FrameLabelButtonBuilder ;
		}

		/**
		 * Registers the ButtonEvent type passed in argument.
		 * @param type The type of the frame event to register (choose your event in the ButtonEvent static enumeration).
		 * @param callback The optional method of the button to launch 
		 */
		public function registerType( type:String , callback:Function=null ):void
		{
			(builder as FrameLabelButtonBuilder).registerType( type , callback ) ;
		}
		
		/**
		 * Unregisters the ButtonEvent type passed in argument.
		 */
		public function unregisterType( type:String ):void
		{
			(builder as FrameLabelButtonBuilder).unregisterType( type ) ;
		}		

        /**
         * @private
         */
        protected function initStates():void
        {
            x = _states.x ;
            y = _states.y ;
            _states.x = 0 ;
            _states.y = 0 ;
        }

		/**
		 * @private
		 */
		private var _states:MovieClip ;
		
		
	}

}
