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

    /**
     * Dispatched when a process is changed.
     * @eventType andromeda.events.ActionEvent.CHANGE
     * @see #notifyChanged
     */
    [Event(name="onChanged", type="andromeda.events.ActionEvent")]

    /**
     * Dispatched when a process is cleared.
     * @eventType andromeda.events.ActionEvent.CLEAR
     * @see #notifyCleared
     */
    [Event(name="onCleared", type="andromeda.events.ActionEvent")]
        
    /**
     * Dispatched when an info process is running.
     * @eventType andromeda.events.ActionEvent.INFO
     * @see #notifyInfo
     */
    [Event(name="onInfo", type="andromeda.events.ActionEvent")]
    
    /**
     * Dispatched when a process is looped.
     * @eventType andromeda.events.ActionEvent.LOOP
     * @see #notifyLooped
     */
    [Event(name="onLooped", type="andromeda.events.ActionEvent")]    
    
    /**
     * Dispatched when a process is paused.
     * @eventType andromeda.events.ActionEvent.PAUSE
     * @see #notifyPaused
     */
    [Event(name="onPaused", type="andromeda.events.ActionEvent")]     
    
    /**
     * Dispatched when a process is in progress.
     * @eventType andromeda.events.ActionEvent.PROGRESS
     * @see #notifyProgress
     */
    [Event(name="onProgress", type="andromeda.events.ActionEvent")]  
    
    /**
     * Dispatched when a process is resumed.
     * @eventType andromeda.events.ActionEvent.RESUME
     * @see #notifyResumed
     */
    [Event(name="onResumed", type="andromeda.events.ActionEvent")]  
        
    /**
     * Dispatched when a process is stopped.
     * @eventType andromeda.events.ActionEvent.STOP
     * @see #notifyStopped
     */
    [Event(name="onStopped", type="andromeda.events.ActionEvent")]      
    
    /**
     * This class simplify a full implementation of the <code class="prettyprint">Action</code> interface.
     * @author eKameleon
     */
    public class Action extends SimpleAction
    {
        
        /**
         * Creates a new Action instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function Action( bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal, sChannel ) ;
            initEventType() ;            
        }

        /**
         * The flag to determinate if the Action object is looped.
         */
        public var looping:Boolean ;
    
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new Action() ;
        }
        
        /**
         * Returns the event name use in the notifyChanged method.
         * @return the event name use in the notifyChanged method.
         */
        public function getEventTypeCHANGE():String
        {
            return _sTypeChange ;
        }
        
        /**
         * Returns the event name use in the notifyCleared method.
         * @return the event name use in the notifyCleared method.
         */
        public function getEventTypeCLEAR():String
        {
            return _sTypeClear ;
        }
        
        /**
         * Returns the event name use in the notifyInfo method.
         * @return the event name use in the notifyInfo method.
         */
        public function getEventTypeINFO():String
        {
            return _sTypeInfo ;
        }
        
        /**
         * Returns the event name use in the notifyLooped method.
         * @return the event name use in the notifyLooped method.
         */
        public function getEventTypeLOOP():String
        {
            return _sTypeLoop ;
        }
        
        /**
         * Returns the event name use in the notifyProgress method.
         * @return the event name use in the notifyProgress method.
         */
        public function getEventTypePROGRESS():String
        {
            return _sTypeProgress ;
        }
        
        /**
         * Returns the event name use in the notifyResumed method.
         * @return the event name use in the notifyResumed method.
         */
        public function getEventTypeRESUME():String
        {
            return _sTypeResume ;
        }
        
        /**
         * Returns the event name use in the notifyStopped method.
         * @return the event name use in the notifyStopped method.
         */
        public function getEventTypeSTOP():String
        {
            return _sTypeStop ;
        }
        
        /**
         * Returns the event name use in the notifyTimeOut method.
         * @return the event name use in the notifyTimeOut method.
         */
        public function getEventTypeTIMEOUT():String
        {
            return _sTypeTimeout ;
        }
        
        /**
         * Initialize the internal event's types of this process.
         */
        public function initEventType():void
        {
            _sTypeChange   = ActionEvent.CHANGE   ;
            _sTypeClear    = ActionEvent.CLEAR    ;
            _sTypeInfo     = ActionEvent.INFO     ;
            _sTypeLoop     = ActionEvent.LOOP     ;
            _sTypeProgress = ActionEvent.PROGRESS ;
            _sTypeResume   = ActionEvent.RESUME   ;
            _sTypeStop     = ActionEvent.STOP     ;
            _sTypeTimeout  = ActionEvent.TIMEOUT  ;
        }

        /**
         * Notify an ActionEvent when the process is changed.
         */
        protected function notifyChanged():void 
        {
            dispatchEvent( new ActionEvent( _sTypeChange, this ) ) ;
        }

        /**
         * Notify an ActionEvent when the process is cleared.
         */
        protected function notifyCleared():void 
        {
            dispatchEvent( new ActionEvent( _sTypeClear, this ) ) ;
        }    

        /**
         * Notify an ActionEvent when the process info is changed.
         */
        protected function notifyInfo( info:* ):void
        {
            dispatchEvent( new ActionEvent( _sTypeInfo, this , info ) ) ;
        }

        /**
         * Notify an ActionEvent when the process is looped.
         */
        protected function notifyLooped():void 
        {
            dispatchEvent( new ActionEvent( _sTypeLoop, this ) ) ;
        }

        /**
         * Notify an ActionEvent when the process is in progress.
         */
        protected function notifyProgress():void
        {
            dispatchEvent( new ActionEvent( _sTypeProgress, this ) ) ;
        }

        /**
         * Notify an ActionEvent when the process is resumed.
         */
        protected function notifyResumed():void
        {
            dispatchEvent( new ActionEvent( _sTypeResume, this ) ) ;
        }

        /**
         * Notify an ActionEvent when the process is stopped.
         */
        protected function notifyStopped():void
        {
            dispatchEvent( new ActionEvent( _sTypeStop, this ) ) ;
        }

        /**
         * Notify an ActionEvent when the process is out of time.
         */
        protected function notifyTimeOut():void
        {
            dispatchEvent( new ActionEvent( _sTypeTimeout, this ) ) ;
        }
        
        /**
         * Sets the event name use in the notifyChanged method.
         */
        public function setEventTypeCHANGE( type:String ):void
        {
            _sTypeChange = type || ActionEvent.CHANGE ;
        }
        
        /**
         * Sets the event name use in the notifyCleared method.
         */
        public function setEventTypeCLEAR( type:String ):void
        {
            _sTypeClear = type || ActionEvent.CLEAR ;
        }
        
        /**
         * Sets the event name use in the notifyInfo method.
         */
        public function setEventTypeINFO( type:String ):void
        {
            _sTypeInfo = type || ActionEvent.INFO ;
        }
        
        /**
         * Sets the event name use in the notifyLooped method.
         */
        public function setEventTypeLOOP( type:String ):void
        {
            _sTypeLoop = type || ActionEvent.LOOP ;
        }
        
        /**
         * Sets the event name use in the notifyProgress method.
         */
        public function setEventTypePROGRESS( type:String ):void
        {
            _sTypeProgress = type || ActionEvent.PROGRESS ;
        }
        
        /**
         * Sets the event name use in the notifyResumed method.
         */
        public function setEventTypeRESUME( type:String ):void
        {
            _sTypeResume = type || ActionEvent.RESUME ;
        }
        
        /**
         * Sets the event name use in the notifyStopped method.
         */
        public function setEventTypeSTOP( type:String ):void
        {
            _sTypeStop = type || ActionEvent.STOP ;
        }
        
        /**
         * Sets the event name use in the notifyTimeOut method.
         */
        public function setEventTypeTIMEOUT( type:String ):void
        {
            _sTypeTimeout = type || ActionEvent.TIMEOUT ;
        }
        
        /**
         * @private
         */
        private var _sTypeChange:String ;

        /**
         * @private
         */
        private var _sTypeClear:String ;

        /**
         * @private
         */
        private var _sTypeInfo:String ;

        /**
         * @private
         */
        private var _sTypeLoop:String ;

        /**
         * @private
         */
        private var _sTypeProgress:String ;

        /**
         * @private
         */
        private var _sTypeResume:String ;

        /**
         * @private
         */
        private var _sTypeStop:String ;

        /**
         * @private
         */
        private var _sTypeTimeout:String ;

    }

}