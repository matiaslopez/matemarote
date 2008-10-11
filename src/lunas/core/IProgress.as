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
	 * This interface defined the methods to implement a progress display component.
	 * @author eKameleon
	 */
	public interface IProgress
	{
		

        /**
         * (Read-write) The maximum value of the progress.
         */
        function get maximum():Number ;
        function set maximum( value:Number ):void ;

        /**
         * (Read-write) The minimum value of the progress.
         */
        function get minimum():Number ;
        function set minimum( value:Number ):void ;		
		
		/**
	 	 * Indicates the position of the progress component.
	 	 */
		function get position():Number ;
		function set position( value:Number ):void ;
	
		/**
		 * Sets the position value of the progress.
		 * @param pos the position value of the progress component.
	 	 * @param noEvent (optional) this flag disabled the events of this method if this argument is <code class="prettyprint">true</code>
	 	 * @param flag (optional) An optional boolean flag use in the method.
	 	 */
		function setPosition( value:Number, noEvent:Boolean=false , flag:Boolean=false ):void ;
		
	}

}
