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
	 * This interface defines an object groupable in the application.
	 * @author eKameleon
	 */
	public interface IGroupable 
	{
		
		/**
		 * Indicates with a boolean if this object is grouped.
		 * @return <code class="prettyprint">true</code> if this object is grouped.
		 */
		function get group():Boolean ; 
		function set group( b:Boolean ):void ; 

		/**
	 	 * Indicates the name of the group of this object.
	 	 */
		function get groupName():String ; 
		function set groupName( sName:String ):void ; 
		
	}
}
