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
    import lunas.core.AbstractStyle;
    
    import pegas.transitions.TweenLite;
    import pegas.transitions.easing.Bounce;
    import pegas.transitions.easing.Elastic;    

    /**
	 * The IStyle class of the LightButton component.
	 */
	public class LightButtonStyle extends AbstractStyle 
	{
		
		/**
		 * Creates a new LightButtonStyle.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function LightButtonStyle(id:* = null, init:* = null , bGlobal:Boolean = false , sChannel:String = null )
		{
			super( id , id != null , bGlobal , sChannel ) ;
		}
		
		/**
		 * The tween invoked when the button is over.
		 */		
		public var tweenOver:TweenLite = new TweenLite(null, "brightness", Bounce.easeOut, 70, 0, 1, true ) ;

		/**
		 * The tween invoked when the button is selected.
		 */		
		public var tweenSelected:TweenLite = new TweenLite(null, "brightness", Elastic.easeOut, 125, 0, 1, true ) ;

				
	}

}
