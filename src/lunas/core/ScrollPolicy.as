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

	/**
	 * Values for the horizontalScrollPolicy and verticalScrollPolicy properties of the Container and ScrollControlBase classes.
	 * @author eKameleon
	 */
	public class ScrollPolicy 
	{
	
		/**
	 	 * Show the scrollbar if the children exceed the owner's dimension.
		 * The size of the owner is not adjusted to account for the scrollbars when they appear, 
		 * so this may cause the scrollbar to obscure the contents of the control or container.
		 */
		public static const AUTO:String = "auto";
		
		/**
		 * Never show the scrollbar.
		 */
		public static const OFF:String = "off";
		
		/**
		 * Always show the scrollbar.
		 * The size of the scrollbar is automatically added to the size of the owner's contents 
		 * to determine the size of the owner if explicit sizes are not specified.
	 	 */
		public static const ON:String = "on";
		
	}
}
