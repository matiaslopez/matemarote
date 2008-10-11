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
	import flash.events.IEventDispatcher;
	import flash.text.StyleSheet;
	
	import andromeda.vo.IValueObject;	

	/**
	 * The IStyle interface defines style object used in the components of your applications.
	 * @author eKameleon
	 */
	public interface IStyle extends IEventDispatcher, IValueObject
	{
		
		/**
		 * Indicates the style sheet reference of this object.
		 */
		function get styleSheet():StyleSheet ;
		function set styleSheet(ss:StyleSheet):void ;
		
		/**
		 * Returns the value of the specified property if it's exist in the object, else returns null.
		 * @return the value of the specified property if it's exist in the object or <code class="prettyprint">null</code>.
		 */
		function getStyle(prop:String):* ;

		/**
		 * Invoked in the constructor of the <code class="prettyprint">IStyle</code> instance.
		 */
		function initialize():void ;

		/**
		 * Sets the properties of this <code class="prettyprint">IStyle</code> object.
		 */
		function setStyle( ...args:Array ):void ;

		/**
		 * Updates the <code class="prettyprint">IStyle</code> object.
		 */
		function update():void ;
		
	}
}

