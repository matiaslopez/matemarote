/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process
{
    import flash.events.IEventDispatcher;
    
    import system.Cloneable;
    
    import vegas.core.IRunnable;    
    
    /**
     * Dispatched when a process is finished.
     * @eventType andromeda.events.ActionEvent.FINISH
     * @see #notifyFinished
     */
    [Event(name="onFinished", type="andromeda.events.ActionEvent")]
    
    /**
     * Dispatched when a process is started.
     * @eventType andromeda.events.ActionEvent.START
     * @see #notifyStarted
     */
    [Event(name="onStarted", type="andromeda.events.ActionEvent")]
    
    /**
     * This interface represents a process object.
     * @author eKameleon
     */
    public interface IAction extends Cloneable, IEventDispatcher, IRunnable
    {

        /**
         * Notify an ActionEvent when the process is finished.
         */
        function notifyFinished():void ;

        /**
         * Notify an ActionEvent when the process is started.
         */
        function notifyStarted():void ;
        
    }
    
}