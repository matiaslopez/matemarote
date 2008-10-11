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
package vegas.logging.targets 
{
    import flash.events.SecurityErrorEvent;
    import flash.events.StatusEvent;
    import flash.net.LocalConnection;
    import flash.utils.clearInterval;
    import flash.utils.setInterval;
    
    import system.Reflection;
    
    import vegas.logging.LogEventLevel;
    import vegas.logging.targets.LineFormattedTarget;    

    /**
	 * Provides a logger target that uses the AirLogger console to output log messages. 
	 * See the AirLogger page project : <a href="http://code.google.com/p/airlogger/">http://code.google.com/p/airlogger/</a>
	 * @author eKameleon
	 */
	public class AirLoggerTarget extends LineFormattedTarget 
	{

		/**
		 * Creates a new AirLoggerTarget instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function AirLoggerTarget( name:String="" , autoClear:Boolean=false, bGlobal:Boolean = false, sChannel:String = null)
		{
			super(bGlobal, sChannel);
			
			_lcOut = new LocalConnection();
			_lcOut.addEventListener( StatusEvent.STATUS                , _status        , false, 0, true );
            _lcOut.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _securityError , false, 0, true);
        	
        	_lcIn = new LocalConnection() ;
        	_lcIn.allowDomain("*") ;
        	_lcIn.client = this ;
			
			_aLogStack   = [];
			_bIdentified = false;
			_bRequesting = false;
		
			if ( autoClear )
			{
				clear() ;	
			}
		
			if ( name != null )
			{
				setName( name ) ;
			}
		
			connect();	
		}
	
		/**
		 * The id message to clear the console. 
		 */
		public static const CLEAR:String = "clear" ;
			
		/**
		 * Designates informational level messages that are fine grained and most helpful 
		 * when debugging an application with the AirLogger console (10000).
		 */
		public static const DEBUG:Number = 10000 ;
		
		/**
		 * The default id in value.
		 */
		public static var DEFAULT_ID_IN : String = "" ; 
		
		/**
		 * Designates error events that might still allow 
		 * the application to continue running with the AirLogger console (40000).
		 */	
		public static const ERROR:Number = 40000 ;

		/**
		 * The 'focus' string representation.
		 */
		public static const FOCUS:String = "focus" ;
	
		/**
		 * The id who indicates if the id is already used.
		 */
		public static const ID_ALREADY_USED:String = "idAlreadyUsed" ;

		/**
		 * Designates informational messages that highlight the progress of the application 
		 * at coarse-grained level with the AirLogger console (20000).
		 */
		public static var INFO:Number = 20000 ;
		
		/**
		 * The 'out' connection suffix.
		 */
		public static var IN_SUFFIX:String = "_OUT";
		
		/**
		 * The local connection id.
		 */
		public static const LOCAL_CONNECTION_ID:String = "_AIRLOGGER_CONSOLE" ;
		
		/**
		 * The 'mainConnectionAlreadyUsed' string representation.
		 */
		public static const MAIN_CONNECTION_ALREADY_USED:String = "mainConnectionAlreadyUsed" ;
		
		/**
		 * The 'in' connection suffix.
		 */
		public static var OUT_SUFFIX:String = "_IN" ;
		
		/**
		 * The id who indicates if the tab name of the current application must change this name.
		 */
		public static var SET_TAB_NAME:String = "setTabName" ;
		
		/**
		 * Designates events that could be harmful to the application operation with the AirLogger console (30000).
		 */	
		public static var WARN:Number = 30000;

		/**
		 * Designates events that are very harmful and will eventually 
		 * lead to application failure with the AirLogger console (50000).
		 */
		public static const FATAL:Number = 50000 ;

		/**
		 * Clear the console.
		 */
		public function clear():void
		{
			_send( getAirLoggerMessage( CLEAR ) ) ;
		}
			
		/**
		 * Close the connection with the console.
		 */	
		public function close():void
		{
			_lcIn.close() ;
		}
	
		/**
		 * Connect the target with the console.
		 */
		public  function connect():void
		{
			var b:Boolean = true ;
			while( b )
			{
				try
				{
					_lcIn.connect(_getInConnectionName( DEFAULT_ID_IN ) ) ;
					b = false ;
				}
				catch( e:Error )
				{
					_lcOut.send( _getOutConnectionName() , MAIN_CONNECTION_ALREADY_USED , DEFAULT_ID_IN ) ;
					DEFAULT_ID_IN += "_" ;
				}
			}
		}
	
		/**
		 * Focus in the console.
		 */
		public function focus():void
		{
			_send( getAirLoggerMessage( FOCUS ) ) ;
		}
			
		/**
		 * Returns the generic object who contains all attributes who defines the AirLogger message to send.
		 * @return the generic object who contains all attributes who defines the AirLogger message to send.
		 */
		public function getAirLoggerMessage( type:String, message:*=null , level:LogEventLevel=null, date:Date=null , sMessageType:String=null ):Object 
		{
			var lvl:int ;
			switch (level)
			{
				case LogEventLevel.ERROR :
				{
					lvl = ERROR ;
					break ;	
				}
				case LogEventLevel.FATAL :
				{
					lvl = FATAL ;
					break ;	
				}
				case LogEventLevel.INFO :
				{
					lvl = INFO ;
					break ;	
				}
				case LogEventLevel.WARN :
				{
					lvl = WARN ;
					break ;	
				}
				default :
				{
					lvl = DEBUG ;
					break ;	
				}		
			}
			return { type:type , message: message, level:lvl, date:date, messageType:sMessageType } ;
		}
	
	   	/**
    	 * Descendants of this class should override this method to direct the specified message to the desired output.
    	 *
    	 * @param message String containing preprocessed log message which may include time, date, category, etc. 
    	 *        based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
	     */
	    public override function internalLog( message:* , level:LogEventLevel ):void
	    {
			_send( getAirLoggerMessage("log", message, level, new Date(), Reflection.getClassPath(message) ) ) ;
		}

		/**
		 * Indicates if the target is requesting.
		 */
		public function isRequesting () : Boolean
		{
			return _bRequesting ;
		}
		
		/**
		 * Indicates if the target is isIdentified.
		 */
		public function isIdentified () : Boolean
		{
			return _bIdentified ;
		}
		
		/**
		 * Launch the ping request process of the console with this target.
		 */
		public function pingRequest():void
		{
			_lcOut.send( _getOutConnectionName() , "requestID", DEFAULT_ID_IN );
		}
			
		/**
		 * Sets the unique id of the target in the console.
		 */
		public function setID( id : String ):void
		{
			try 
			{
				
				clearInterval(_nPingRequest) ; 
				_sID = id;
				_lcIn.close();
				_lcIn.connect( _getInConnectionName(_sID) ) ;
				
				_lcOut.send(_getOutConnectionName(), "confirmID", id, _sName);
			
				_bIdentified = true;
				_bRequesting = false;
				
				var l:uint = _aLogStack.length ;
				if( l > 0 )
				{
					for(var i:uint = 0;i < l; i++ )
					{
						_send(_aLogStack.shift());
					}
				}
			}
			catch ( e:Error ) 
			{
				_lcIn.connect( _getInConnectionName( DEFAULT_ID_IN ) ) ;
				_lcOut.send( _getOutConnectionName() , ID_ALREADY_USED, id) ;
			}
		}
	
		/**
		 * Sets the name of the target.
		 */
		public function setName( s:String ):void
		{
			_sName = s;
			if( _bIdentified )
			{
				_lcOut.send( _getOutConnectionName( _sID ), SET_TAB_NAME , _sName  );
			}
		}

		/**
		 * @private
		 */	
    	private var _aLogStack:Array ;
		
		/**
		 * @private
		 */
    	private var _bIdentified:Boolean ;
		
		/**
		 * @private
		 */
    	private var _bRequesting:Boolean ;
		
		/**
		 * @private
		 */
		private var _lcIn:LocalConnection ;
		
		/**
		 * @private
		 */
		private var _lcOut:LocalConnection ;
		
		/**
		 * @private
		 */
    	private var _nPingRequest:Number ;
		
		/**
		 * @private
		 */
		private var _sID:String ;	
			
		/**
		 * @private
		 */
    	private var _sName:String ;
		
		/**
		 * Returns the name of the in local connection.
		 * @return the name of the in local connection.
         * @private
         */
		private function _getInConnectionName( id:String="" ):String
		{	
			return LOCAL_CONNECTION_ID + id + IN_SUFFIX ;
		}
		
		/**
		 * Returns the name of the out local connection.
		 * @return the name of the out local connection.
         * @private
         */
		private function _getOutConnectionName ( id:String="" ) : String
		{
			return LOCAL_CONNECTION_ID + id + OUT_SUFFIX ;
		}
		
		/**
		 * Invoked when the security of the LocalConnection is changed.
         * @private
         */
		private function _securityError( event:SecurityErrorEvent ):void
		{
			trace( this + " security error : " + event ) ;
			dispatchEvent( event ) ;
		}
		
		/**
		 * Send the message to the console or bufferize the message if the console isn't connected.
         * @private
         */
		private function _send ( oMessage:* ):void
		{
			if( _bIdentified )
			{
				_lcOut.send( _getOutConnectionName( _sID ), oMessage.type, oMessage );
			}
			else
			{
				_aLogStack.push( oMessage );
			
				if( !_bRequesting )
				{					
					pingRequest();
					_nPingRequest = setInterval( pingRequest, 1000 );
					_bRequesting  = true ;
				}
			}
		}		
		
		/**
		 * @private
		 */
		private function _status( event:StatusEvent ):void 
		{
			if ( event.level == "error" )
			{
				// hack with FP < 9.0.124
			}
			else
			{
                dispatchEvent( event ) ;
			}
		}

	}
}
