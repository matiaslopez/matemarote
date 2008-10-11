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

package vegas.events
{
    import flash.events.IEventDispatcher;
    
    import system.Serializable;
    
    import vegas.core.IHashable;    

    /**
	 * This interface defines the methods of the vegas.events.EventDispatcher class.
	 * @author eKameleon
	 */
    public interface IEventDispatcher extends flash.events.IEventDispatcher, IHashable, Serializable
    {
        
       /**
        * Registers an <code class="prettyprint">EventListener</code> object with an EventDispatcher object so that the listener receives notification of an event.
        */
       function registerEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
       
        /**
         * Removes an <code class="prettyprint">EventListener</code> from the EventDispatcher object.
         */
       function unregisterEventListener(type:String, listener:*, useCapture:Boolean = false):void ;
        
    }
    
}