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
	
	import lunas.display.button.FrameLabelButton;	

	/**
	 * This LightFrameLabelButton is a button who use a LightColor motion to creates light effects when the button is over or click.
	 */
	public class LightFrameLabelButton extends FrameLabelButton 
	{

		/**
		 * Creates a new LightFrameLabelButton instance.
		 * @param states the MovieClip reference with the state frames of this button.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function LightFrameLabelButton(states:MovieClip = null, id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( states , id , isConfigurable, name ) ;
		}

		/**
		 * Returns the constructor function of the <code class="prettyprint">IBuilder</code> of this instance.
		 * @return the constructor function of the <code class="prettyprint">IBuilder</code> of this instance.
		 */
		public override function getBuilderRenderer():Class
		{
			return LightFrameLabelButtonBuilder ;
		}
		
		/**
		 * Returns the IStyle Class of this instance.
		 * @return the IStyle Class of this instance.
	 	 */
		public override function getStyleRenderer():Class 
		{
			return LightFrameLabelButtonStyle ;
		}
		
	}

}
