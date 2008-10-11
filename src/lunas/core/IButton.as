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
	 * This interface defines all methods to implement in a button display components.
	 * @author eKameleon
	 */
	public interface IButton extends IData, IFocusable, ILabel
	{
		
		/**
		 * Indicates a boolean value indicating whether the button behaves as a toggle switch (true) or not (false). 
		 */
		function get toggle():Boolean ;
		function set toggle( b:Boolean ):void ;
		
		/**
		 * Sets a boolean value indicating whether the button is selected (true) or not (false). 
		 * The default value is false.
		 * @param b The selected flag value.
		 * @param flag optional flag to control the method.
		 */
		function setSelected ( b:Boolean, flag:Boolean=false ):void 
		
	}
	
}
