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
	
	import pegas.transitions.easing.Back;
	import pegas.transitions.easing.Elastic;	

	/**
	 * The IStyle class of the LightFrameLabelButton component.
	 */
	public class LightFrameLabelButtonStyle extends AbstractStyle 
	{
		
		/**
		 * Creates a new LightFrameLabelButtonStyle.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
		 */
		public function LightFrameLabelButtonStyle(id:* = null, init:* = null)
		{
			super( id, init );
		}

		/**
		 * The begin value of the easing when the component is over.
		 */
		public var easingOverBegin:Number = 155 ;
			
		/**
		 * The duration value of the easing when the component is over.
		 */
		public var easingOverDuration:Number = 1 ;
		
		/**
		 * The begin finish of the easing when the component is over.
	 	 */
		public var easingOverFinish:Number = 0 ;
		
		/**
		 * The easing method id in the EasingController of the application when the component is over.
		 */
		public var easingOver:Function = Elastic.easeOut ;
		
		/**
	 	 * The property value of the easing when the component is over.
	 	 */
		public var easingOverProperty:String = "brightness" ;
		
		/**
		 * The useSeconds value of the easing when the component is over.
		 */
		public var easingOverUseSeconds:Boolean = true ;
		
		/**
	 	 * The easing method id in the EasingController of the application when the component is selected.
	 	 */
		public var easingSelected:Function = Back.easeOut ;		
		
		/**
		 * The begin value of the easing when the component is selected.
		 */
		public var easingSelectedBegin:Number = 60 ;
		
		/**
	 	 * The duration value of the easing when the component is selected.
	 	 */
		public var easingSelectedDuration:Number = 2 ;
		
		/**
	 	 * The begin finish of the easing when the component is selected.
	 	 */
		public var easingSelectedFinish:Number = 0 ;

		/**
	 	 * The property value of the easing when the component is selected.
	 	 */
		public var easingSelectedProperty:String = "brightness" ;
		
		/**
	 	 * The useSeconds value of the easing when the component is selected.
	 	 */
		public var easingSelectedUseSeconds:Boolean = true ;
		
		/**
	 	 * Indicates if the component use an easing effect when the component is over.
	 	 */
		public var useEasingOver:Boolean = true ;
		
		/**
	 	 * Indicates if the component use an easing effect when the component is selected.
	 	 */
		public var useEasingSelected:Boolean = true ;
				
	}

}
