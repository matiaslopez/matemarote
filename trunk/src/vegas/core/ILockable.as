/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.core
{

    /**
     * This interface is implemented by all objects lockable.
     * @author eKameleon
     */
	public interface ILockable
	{

    	/**
    	 * Returns <code class="prettyprint">true</code> if the object is locked.
    	 * @return <code class="prettyprint">true</code> if the object is locked.
    	 */
    	function isLocked():Boolean ;
	
    	/**
	     * Locks the object.
    	 */
    	function lock():void ;
	
    	/**
    	 * Unlocks the object.
	     */
	    function unlock():void ; 
		
	}
	
}