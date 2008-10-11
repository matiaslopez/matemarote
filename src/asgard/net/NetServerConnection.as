/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.NetConnection;
    import flash.net.ObjectEncoding;
    import flash.net.Responder;
    import flash.utils.Timer;
    
    import andromeda.process.TimeoutPolicy;
    
    import asgard.events.NetServerEvent;
    
    import system.Cloneable;
    
    import vegas.core.IRunnable;
    import vegas.events.CoreEventDispatcher;    

    /**
 	 * This class extends the NetConnection class and defined an implementation based on VEGAS to used Flash Remoting or Flash MediaServer (with AMF protocol).
	 * @author eKameleon
	 */	
	public class NetServerConnection extends CoreEventDispatcher implements Cloneable, IRunnable
	{
		
		/**
		 * Creates a new NetServerConnection instance.
	 	 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function NetServerConnection( bGlobal:Boolean = false , sChannel:String = null )
		{
			
			super( bGlobal , sChannel ) ;	
						
			_nc = new NetConnection() ;
			_nc.client = this ;
			_nc.objectEncoding = ObjectEncoding.AMF0 ; // DEFAULT AMF0
			
			_nc.addEventListener( IOErrorEvent.IO_ERROR             , _onIOError) ;
			_nc.addEventListener( NetStatusEvent.NET_STATUS         , _onStatus) ;
			_nc.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _onSecurityError);
			
			_timer = new Timer( DEFAULT_DELAY, 1 ) ;
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE , _onTimeOut) ;
			
			initEventType() ;
			
		}

		/**
	     * The default internal timeout delay value in milliseconds.
	     */
		public static const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
       
        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public function get client():Object
        {
            return _nc.client ;
        }

        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public function set client( client:Object ):void
        {
           _nc.client = client ;
        }
       
        /**
         * [read-only] Indicates whether Flash Player has connected to a server through a persistent RTMP connection (true) or not (false). 
         * When connected through HTTP, this property is always false. 
         * It is always true for AMF connections to application servers. 
         */
        public function get connected():Boolean
        {
            return _nc.connected ;
        }

        /**
         * [read-only] Indicates whether Flash Player has connected to a server through a persistent RTMP connection (true) or not (false). 
         * When connected through HTTP, this property is always false. 
         * It is always true for AMF connections to application servers. 
         */
        public function get connectedProxyType():String
        {
            return _nc.connectedProxyType ;
        }

        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public static function get defaultObjectEncoding():uint
        {
            return NetConnection.defaultObjectEncoding ;
        }

        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public static function set defaultObjectEncoding( encoding:uint ):void
        {
           NetConnection.defaultObjectEncoding = encoding ;
        }

        /**
         * (read write) The ObjectEncoding class allows classes that serialize objects (such as FileStream, NetStream, NetConnection, SharedObject, and ByteArray) to work with prior versions of ActionScript.
         */
		public function get objectEncoding():uint
	    {
	        return _nc.objectEncoding ;
	    }

        /**
         * (read write) The ObjectEncoding class allows classes that serialize objects (such as FileStream, NetStream, NetConnection, SharedObject, and ByteArray) to work with prior versions of ActionScript.
         */
        public function set objectEncoding( encoding:uint ):void
        {
            _nc.objectEncoding = encoding ;
        }	
        
        /**
         * (read write) Determines whether native SSL is used for RTMPS instead of HTTPS, and whether the CONNECT method of tunneling is used to connect through a proxy server. 
         * Acceptable values are "none", "HTTP", "CONNECT", and "best". This property is used in Flex applications and Flash Media Server 2 applications. 
         */
		public function get proxyType():String
	    {
	        return _nc.proxyType ;
	    }

        /**
         * (read write) Determines whether native SSL is used for RTMPS instead of HTTPS, and whether the CONNECT method of tunneling is used to connect through a proxy server. 
         * Acceptable values are "none", "HTTP", "CONNECT", and "best". This property is used in Flex applications and Flash Media Server 2 applications. 
         */
        public function set proxyType( type:String ):void
        {
            _nc.proxyType = type ;
        }

        /**
         * [read-only] Indicates whether a secure connection was made using native Transport Layer Security (TLS) rather than HTTPS. 
         * This property is valid only when a NetConnection object is connected. 
         */
        public function get usingTLS():Boolean
        {
            return _nc.usingTLS ;
        }
        
        /**
         * The URI of the application server that was passed to NetConnection.connect(), if connect was used to connect to a server. 
         * If NetConnection.connect() hasn't yet been called or if no URI was passed, this property is undefined.
         * In The VEGAS implementation the uri property is a read-write property and we can use this property in to launch the connect process with the run method.
         * @see IRunnable
         */
		public function get uri():String
	    {
	        return _uri || _nc.uri ;
	    }

        /**
         * Sets the default URI that the NetConnection.connect() method passed. 
         */
        public function set uri( uri:String ):void
        {
            _uri = uri ;
        }
        
        /**
    	 * Adds a context header to the AMF packet structure. This header is sent with every future AMF packet.
	     * @param operation A string; identifies the header and the ActionScript object data associated with it.
	     * @param mustUnderstand A Boolean value; true indicates that the server must understand and process this header before it handles any of the following headers or messages.
	     * @param param Any ActionScript object.
	     */
        public function addHeader( operation:String , mustUnderstand:Boolean = false , param:Object = null ):void
	    {
    		_nc.addHeader( operation , mustUnderstand , param ) ;
    	}
    	
        /**
    	 * Invokes a command or method on the server running Flash Media Server, or on an application server, to which the application instance is connected. You must create a server-side function to pass to this method.
    	 * @param command A method specified in the form [objectPath/]method.
    	 * @param responder An optional object that is used to handle return values from the server. 
    	 * @param ... arguments Optional arguments that can be of any ActionScript type, including a reference to another ActionScript object. 
    	 * These arguments are passed to the method specified in the command parameter when the method is executed on the remote application server.
    	 * @return For RTMP connections, returns a Boolean value of true if a call to methodName is sent to the client ; otherwise, false. 
    	 * For application server connections, it always returns true.
	     */
        public function call( command:String, responder:Responder , ...rest:Array  ):Boolean 
        {
            return _nc.call.apply( _nc, [ command, responder ].concat( rest) ) ;
	    }

		/**
		 * Returns the shallow copy of this object.
	 	 * @return the shallow copy of this object.
		 */
		public function clone():*
		{
			return new NetServerConnection() ;
		}
		
		/**
		 * Closes the connection that was opened locally or with the server and dispatches the netStatus event with a code property of NetConnection.Connect.Closed. 
		 * @param noEvent if this argument is <code class="prettyprint">true</code> the event propagation is disabled.
		 */		
		public function close( noEvent:Boolean = false ):void 
		{
			_nc.close() ;
			_timer.stop() ;
			if (!noEvent) 
			{
			    notifyClose() ;
			}
		}

		/**
		 * Connect the client with this method.
		 */
		public function connect( command:String, ... arguments):void
		{
			notifyStarted() ;
			_nc.connect.apply( _nc, [command].concat(arguments)) ;
		}

    	/**
    	 * Returns and creates a new empty ModelObjectEvent. You can override this method.
    	 * @param type the type of the event.
    	 * @return a new empty ModelObjectEvent with the type specified in argument.
    	 */
	    public function createNewEvent( type:String ):NetServerEvent
	    {
    		return new NetServerEvent( type || null , this ) ;
    	}
    	
    	/**
    	 * Returns the internal NetConnection reference of this object.
    	 * @return the internal NetConnection reference of this object.
    	 */
		public function getNetConnection():NetConnection
		{
			return _nc ;	
		}
		
    	/**
    	 * Returns the event name use in the connection is closed.
    	 * @return the event name use in the connection is closed.
    	 */
	    public function getEventTypeCLOSE():String
	    {
			return _sTypeClose ;
		}
    
    	/**
	     * Returns the event name use in the connection is finished.
	     * @return the event name use in the connection is finished.
	     */
	    public function getEventTypeFINISH():String
	    {
			return _sTypeFinish ;
		}
        	
    	/**
    	 * Returns the event name use in the connection is started.
	     * @return the event name use in the connection is started.
	     */
    	public function getEventTypeSTART():String
    	{
			return _sTypeStart ;
		}
    	
    	/**
	     * Returns the event name use in the connection status changed.
	     * @return the event name use in the connection status changed.
	     */
	    public function getEventTypeSTATUS():String
	    {
			return _sTypeStatus ;
		}
    
        /**
	     * Returns the event name use in the connection is out of time.
    	 * @return the event name use in the connection is out of time.
    	 */
	    public function getEventTypeTIMEOUT():String
	    {
			return _sTypeTimeOut ;
		}

		/**
		 * Returns timeout interval duration.
		 */
		public function getDelay():uint
		{
			return _timer.delay ;
		}
		
    	/**
	     * Returns the singleton instance of class.
	     * @return singleton instance of class.
	     */
	    public static function getInstance():NetServerConnection
	    {
    		if ( _instance == null )
		    {
    			_instance = new NetServerConnection() ;
		    }
		    return _instance ;
	    }
		
	    /**
	     * Returns the TimeoutPolicy value of this object.
	     * @return the TimeoutPolicy value of this object.
	     * @see TimeoutPolicy
	     */
		public function getTimeoutPolicy():TimeoutPolicy 
		{
			return _policy ;	
		}
		
    	/**
    	 * This method is invoked in the constructor of the class to initialize all events.
    	 * Overrides this method.
    	 */
    	public function initEventType():void
    	{
			_sTypeClose   = NetServerEvent.CLOSE  ;
			_sTypeFinish  = NetServerEvent.FINISH ;
			_sTypeStart   = NetServerEvent.START  ;
			_sTypeStatus  = NetServerEvent.NET_STATUS ;
			_sTypeTimeOut = NetServerEvent.TIMEOUT ;			   
	    }

    	/**
    	 * Invoked when the connection is closed.
    	 */
		protected function notifyClose():void 
		{
			dispatchEvent( new NetServerEvent( _sTypeClose , this ) ) ;	
		}

    	/**
	     * Invoked when the connection is finished.
    	 */
		protected function notifyFinished():void 
		{
			dispatchEvent( new NetServerEvent( _sTypeFinish , this ) ) ;
		}

    	/**
    	 * Invoked when the connection is started.
    	 */
		protected function notifyStarted():void 
		{
			_timer.start() ;
			dispatchEvent( new NetServerEvent( _sTypeStart , this ) ) ;
		}
		
    	/**
    	 * Invoked when the status of the connection is changed.
    	 */
		protected function notifyStatus( status:NetServerStatus , info:* = null ):void 
		{
			dispatchEvent( new NetServerEvent( _sTypeStatus, this , status , info ) ) ;	
		}
	
    	/**
	     * Invoked when the connection is timeout.
	     */
	    protected function notifyTimeOut():void
		{
			dispatchEvent( new NetServerEvent( _sTypeTimeOut, this ) ) ;
		}

	    /**
	     * Runs the process of this NetServerConnection.
	     */
		public function run( ...arguments:Array ):void 
		{
			connect( _nc.uri ) ;	
		}
	
		/**
		 * Set timeout interval duration.
		 */
		public function setDelay(n:Number, useSeconds:Boolean):void 
		{
			var t:Number = (n > 0) ? n : 0 ;
			if (useSeconds) t = Math.round(t * 1000) ;
			_timer.delay = t ;
		}

	    /**
	     * Sets the event name use in the connection is closed.
	     */
	    public function setEventTypeCLOSE( type:String ):void
	    {
    		_sTypeClose = type ;
    	}

    	/**
	     * Sets the event name use in the connection is finished.
	     */
	    public function setEventTypeFINISH( type:String ):void
	    {
    		_sTypeFinish = type ;
    	}
	
    	/**
	     * Sets the event name use in the connection is started.
	     */
    	public function setEventTypeSTART( type:String ):void
	    {
    		_sTypeStart = type ;
    	}
	    
	    /**
	     * Sets the event name use in the connection status changed.
	     */
	    public function setEventTypeSTATUS( type:String ):void
	    {
			_sTypeStatus = type ;
    	}
        
	    /**
	     * Sets the event name use in the connection is out of time.
	     */
	    public function setEventTypeTIMEOUT( type:String ):void
	    {
			_sTypeTimeOut = type ;
    	}

		/**
		 * Use limit timeout interval.
		 * @see TimeoutPolicy
		 */
		public function setLimitPolicy( policy:TimeoutPolicy ):void 
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
	     * Use this method to dispatch in FMS application an event.
	     */
	    public function sharedEvent( event:* = null , context:* = null ):void 
	    {
    		if (event is Event) 
		    {
    			_nc.call( (event as Event).type, null, event ) ;
		    }
		    else if ( event is String ) 
		    {
    			_nc.call( event, null, context ) ;
		    }
	    }
        		
		/**
		 * @private
		 */
	    private static var _instance:NetServerConnection;

		/**
		 * @private
		 */

        private var _nc:NetConnection ;

		/**
		 * @private
		 */
		private var _policy:TimeoutPolicy ;


		/**
		 * @private
		 */
		private var _sTypeClose:String ;

		/**
		 * @private
		 */
		private var _sTypeFinish:String ;

		/**
		 * @private
		 */
		private var _sTypeStart:String ;

		/**
		 * @private
		 */
		private var _sTypeStatus:String ;

		/**
		 * @private
		 */
		private var _sTypeTimeOut:String ;

		/**
		 * @private
		 */
		private var _timer:Timer ;
		
		/**
		 * @private
		 */
		private var _uri:String ;
		
        /**
         * Invoked when a IOErrorEvent is notified.
         * @private
         */
        protected function _onIOError(e:IOErrorEvent):void
        {
            _timer.stop() ;
            notifyFinished() ;
        }

        /**
         * Invoked when a SecurityErrorEvent is notified.
         * @private
         */
        protected function _onSecurityError(e:SecurityErrorEvent):void
        {
            _timer.stop() ;
            notifyFinished() ;
        }		
		
        /**
         * @private
         */
        private function _onStatus( e:NetStatusEvent ):void
        {
            var status:NetServerStatus = NetServerStatus.get( e.info.code ) ;
            _timer.stop() ;
            dispatchEvent( e ) ;
            if ( status != null  )
            {
                notifyStatus( status , e.info) ;
            }
            notifyFinished() ;
        }		
		
		/**
	     * Invoked when the connection is out of time.
	     * @private
	     */
		protected function _onTimeOut(e:TimerEvent):void 
		{
			this._timer.stop() ;
			if ( this.connected )
			{
			    this.close() ;
			}
    		this.notifyTimeOut() ;
			this.notifyFinished() ;
		}
		
		
	}
	
}