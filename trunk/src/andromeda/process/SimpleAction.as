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
    import andromeda.events.ActionEvent;
    
    import vegas.events.CoreEventDispatcher;    

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
     * A simple representation of the <code class="prettyprint">IAction</code> interface.
     * @author eKameleon
     */
    public class SimpleAction extends CoreEventDispatcher implements IAction
    {
    
        /**
         * Creates a new SimpleAction instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        function SimpleAction( bGlobal:Boolean = false , sChannel:String = null ) 
        {
            super(bGlobal, sChannel);        
        }

        /**
         * (read-only) Indicates <code class="prettyprint">true</code> if the process is in progress.
         */
        public function get running():Boolean 
        {
            return _isRunning ;    
        }

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public function clone():*
        {
            return new SimpleAction() ;
        }
        
        /**
         * Notify an ActionEvent when the process is finished.
         */
        public function notifyFinished():void 
        {
            dispatchEvent( new ActionEvent( ActionEvent.FINISH , this ) ) ;
        }

        /**
         * Notify an ActionEvent when the process is started.
         */
        public function notifyStarted():void
        {
            dispatchEvent( new ActionEvent( ActionEvent.START , this ) ) ;
        }
        
        /**
         * Run the process.
         * You can overrides this method in your iherited class. 
         */
        public function run( ...arguments:Array ):void 
        {
            // overrides this method.
        }

        /**
         * Changes the running property value.
         */
        protected function setRunning( b:Boolean ):void
        {
            _isRunning = b ;    
        }

        /**
         * @private
         */
        private var _isRunning:Boolean ;

    }

}