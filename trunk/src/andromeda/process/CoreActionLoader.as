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
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    
    import andromeda.process.Action;
    import andromeda.process.TimeoutPolicy;
    
    import vegas.errors.RuntimeError;    

    /**
	 * This core command object run a "loader" object and notify ActionEvent during a load process.
	 * @author eKameleon
	 */
	public class CoreActionLoader extends Action 
	{
		
		/**
		 * Creates a new CoreActionLoader instance.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function CoreActionLoader( bGlobal:Boolean = false, sChannel:String = null)
		{
			super( bGlobal, sChannel );
            _timer        = new Timer(DEFAULT_DELAY, 1) ;
			timeoutPolicy =  TimeoutPolicy.LIMIT ;
		}
		
		/**
		 * The default value of the delay before the ActionEvent.TIMEOUT event.
		 */
		public static const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
		
        /**
         * (read-only) Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public function get bytesLoaded():uint
    	{
    		return 0 ;	
    	}
        
        /**
         * (read-write) Indicates the total number of bytes in the downloaded data.
         */
        public function get bytesTotal():uint
    	{
    		return 0 ;	
    	}
   
		/**
		 * Indicates the timeout interval duration.
		 */
		public function get delay():uint
		{
			return _timer.delay ;
		}
		
		/**
		 * Indicates the loader object of this process.
		 */
		public function get loader():*
		{
			return _loader ;	
		}
		
		/**
		 * @private
		 */
		public function set loader( loader:IEventDispatcher ):void
		{
			unregister(_loader) ;
			_loader = loader ;
			register(_loader) ;
		}
		
		/**
		 * Indicates the URLRequest object who captures all of the information in a single HTTP request.
		 */
		public function get request():URLRequest
		{
			return _request ;	
		}
		
		/**
		 * @private
		 */
		public function set request( request:URLRequest ):void
		{
			_request = request ;
		}
		
        /**
         * Indicates the timeout policy of the loader.
         * @see TimeoutPolicy
         */
		public function get timeoutPolicy():TimeoutPolicy 
		{
			return _policy ;	
		}
		
		/**
		 * @private
		 */
		public function set timeoutPolicy( policy:TimeoutPolicy ):void 
		{
			_policy = policy ;
			if (_policy == TimeoutPolicy.LIMIT) 
			{
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
			}
			else 
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
			}
		}
		
		/**
		 * Cancels a load() method operation that is currently in progress for the Loader instance.
		 */
		public function close():void
		{
			notifyFinished() ;
		}
		
	    /**
	     * Notify an ActionEvent when the process is finished.
	     */
		public override function notifyFinished():void 
		{
		    setRunning(false) ;
            _timer.stop() ;
			super.notifyFinished() ;
		}

	    /**
	     * Notify an ActionEvent when the process is started.
	     */
		public override function notifyStarted():void
		{
   			setRunning(true) ;
            _timer.start() ;
			super.notifyStarted() ;
		}
		
		/**
		 * Register the loader object.
		 */
		public function register( dispatcher:IEventDispatcher ):void
		{
			if ( dispatcher != null )
			{
				dispatcher.addEventListener( Event.COMPLETE                    , complete      , false, 0, true ) ;
            	dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS       , httpStatus    , false, 0, true ) ;
            	dispatcher.addEventListener( IOErrorEvent.IO_ERROR             , ioError       , false, 0, true ) ;
            	dispatcher.addEventListener( Event.OPEN                        , open          , false, 0, true ) ;
				dispatcher.addEventListener( ProgressEvent.PROGRESS            , progress      , false, 0, true ) ;
            	dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR , securityError , false, 0, true ) ;
			}
		}
		
    	/**
	     * Run the process.
	     */
		public override function run( ...arguments:Array ):void 
		{
		    if ( loader == null )
		    {
		    	throw new RuntimeError( this + " failed the Loader reference of this process not must be 'null' or 'undefined'.") ;
		    }
		    else if ( request == null )
		    {
				throw new RuntimeError( this + " failed the URLRequest reference of this process not must be 'null' or 'undefined'.") ;
		    }
		    else
		    {
		    	notifyStarted() ;
		    	_run() ;
			}
		}

		/**
		 * Set timeout interval duration.
		 */
		public function setDelay( time:uint , useSeconds:Boolean=false):void 
		{
			if (useSeconds) 
			{
			    time = Math.round(time * 1000) ;
			}
			_timer.delay = time ;
		}	

		/**
		 * Unregister the loader object.
		 */
		public function unregister( dispatcher:IEventDispatcher ):void
		{
			if ( dispatcher != null )
			{ 
				dispatcher.removeEventListener( Event.COMPLETE                    , complete      ) ;
            	dispatcher.removeEventListener( HTTPStatusEvent.HTTP_STATUS       , httpStatus    ) ;
            	dispatcher.removeEventListener( IOErrorEvent.IO_ERROR             , ioError       ) ;
            	dispatcher.removeEventListener( Event.OPEN                        , open          ) ;
				dispatcher.removeEventListener( ProgressEvent.PROGRESS            , progress      ) ;
            	dispatcher.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , securityError ) ;
			}
		}

		/**
		 * Invoked when the loading is complete.
		 */
		protected function complete( e:Event ):void
		{
			dispatchEvent(e) ;
			notifyFinished() ;
		}

        /**
         * Dispatch HTTPStatusEvent if a call to load() attempts to access data over HTTP and the current Flash Player environment is able to detect and return the status code for the request.
         */
        protected function httpStatus( e:HTTPStatusEvent ):void
        {
            dispatchEvent(e) ;
        }

        /**
         * Dispatch IOErrorEvent if a call to load() results in a fatal error that terminates the download.
         */
        protected function ioError( e:IOErrorEvent ):void
        {
            dispatchEvent(e) ;
            notifyFinished() ;
        }

		
		/**
		 * This protected method contains the invokation of the load method of the current loader of this process.
		 */
		protected function _run():void
		{
			//
		}

        /**
         * Dispatch Event.OPEN event when the download operation commences following a call to the load() method.
         */
        protected function open(e:Event):void
        {
            dispatchEvent(e) ;
        }

		/**
		 * Invoked when the loading is in complete.
		 */
		protected function progress( e:ProgressEvent ):void
		{
			dispatchEvent(e) ;
			notifyProgress() ;
		}

        /**
         * Dispatch SecurityErrorEvent if a call to load() attempts to load data from a server outside the security sandbox. 
         */
        protected function securityError( e:SecurityErrorEvent ):void
        {
            dispatchEvent(e) ;
            notifyFinished() ;
        }
		

		/**
		 * The internal URLRequest of the loader.
		 */
		protected var _request:URLRequest ;
		
		/**
		 * @private 
		 */
		private var _timer:Timer ;

		/**
		 * @private
		 */
  		private var _policy:TimeoutPolicy = null ;

  		/**
  		 * @private
  		 */
  		private function _onTimeOut(e:TimerEvent):void
  		{
			notifyTimeOut() ;
 		    close() ;
  		}

		/**
		 * @private
		 */
		protected var _loader:* ;

	}
}

