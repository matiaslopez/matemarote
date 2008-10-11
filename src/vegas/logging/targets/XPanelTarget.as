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

    import flash.events.AsyncErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.StatusEvent;
    import flash.net.LocalConnection;
    import flash.utils.getTimer;
    
    import vegas.logging.LogEventLevel;
    
	/**
	 * Provides a logger target that uses the XPanel console to output log messages. 
	 * Thanks Farata System and <a href='http://www.faratasystems.com/xpanel/readme.pdf'>XPanel</a> console.
	 * @author eKameleon
	 */
    public class XPanelTarget extends LineFormattedTarget
    {
        
        /**
         * Creates a new XPanelTarget instance.
         */ 
        public function XPanelTarget( name:String="unknow"  )
        {
			super();
			
            _lc = new LocalConnection() ;
    	    _lc.addEventListener ( AsyncErrorEvent.ASYNC_ERROR, _onAsyncError ) ;
    	    _lc.addEventListener ( StatusEvent.STATUS, _onStatus ) ;
    		_lc.addEventListener ( SecurityErrorEvent.SECURITY_ERROR , _onSecurityError ) ;   
            _lc.send( CONNECTION_ID, DISPATCH_MESSAGE, getTimer(), START + " " + name, LEVEL_START );
            
        }

		/**
		 * The id of the LocalConnection.
		 */
        public static const CONNECTION_ID:String = "_xpanel1" ;
        
        /**
         * The dispatch message label.
         */
        public static const DISPATCH_MESSAGE:String = "dispatchMessage" ;

        /**
         * The 'all' level value of the XPanel console.
         */ 
		public static const LEVEL_ALL:uint = 0x00 ;
		
        /**
         * The 'debug' level value of the XPanel console.
         */ 
        public static const LEVEL_DEBUG:uint = 0x0001 ;

        /**
         * The 'error' level value of the XPanel console.
         */ 
		public static const LEVEL_ERROR:uint = 0x0008 ;

        /**
         * The 'fatal' level value of the XPanel console.
         */ 
		public static const LEVEL_FATAL:uint = 0x0010 ;

        /**
         * The 'information' level value of the XPanel console.
         */ 
		public static const LEVEL_INFORMATION:uint = 0x0002 ;

        /**
         * The 'none' level value of the XPanel console.
         */ 
		public static const LEVEL_NONE:Number = 0xFF ;

        /**
         * The 'start' level value of the XPanel console.
         */ 
		public static const LEVEL_START:uint = 0x0100 ;
	
        /**
         * The 'warning' level value of the XPanel console.
         */ 
		public static const LEVEL_WARNING:uint = 0x0004 ;

		/**
		 * The started value.
		 */
		public static const START:String = "Started" ;

        /**
	     * The name of the connection
	     */
        public var name:String ;

		/**
		 * This method format the log message.
		 */
        override protected function formatMessage(message:*, level:String, category:String, date:Date):String 
        {
	    	message = (typeof message == "xml") ? (message as XML).toXMLString() : message.toString();
	    	return super.formatMessage(message, level, category, date) ;
    	}
 
   	   	/**
    	 * Descendants of this class should override this method to direct the specified message to the desired output.
    	 *
    	 * @param message String containing preprocessed log message which may include time, date, category, etc. 
    	 *        based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
	     */
	    public override function internalLog( message:* , level:LogEventLevel):void
	    {
	        
	        var targetLevel:int ;
	        
	    	switch (level)
	    	{
	    		case LogEventLevel.DEBUG:
	    		{
	    			targetLevel = LEVEL_DEBUG;
	    			break;
	    		}
	    		case LogEventLevel.ERROR:
	    		{
	    			targetLevel = LEVEL_ERROR;
	    			break;
	    		}
	    		case LogEventLevel.FATAL:
	    		{
	    			targetLevel = LEVEL_FATAL;
	    			break;
	    		}
	    		case LogEventLevel.INFO:
	    		{
	    			targetLevel = LEVEL_INFORMATION;
	    			break;
	    		}
	    		case LogEventLevel.WARN:
	    		{
	    			targetLevel = LEVEL_WARNING;
	    			break;
	    		}
	    		default:
	    		{
	    			targetLevel = LEVEL_ALL;
	    			break;
	    		}
	    	}
	    	try
			{
				_lc.send( CONNECTION_ID , DISPATCH_MESSAGE , getTimer(), message, targetLevel ) ;
			}
			catch(e:Error)
			{
				
				//
				
			}
	        
	    }   

    	/**
    	 * Invoked when the LocalConnection notify an asynchronous error.
    	 */
    	private function _onAsyncError(e:AsyncErrorEvent):void
    	{
    	    //trace( "> " + this + " : " + e ) ;
    	}

    	/**
    	 * Invoked when the LocalConnection notify a status change.
    	 */
    	private function _onStatus( e:StatusEvent ):void
		{
			//trace("> " + this + " : " + e ) ;
		}

    	/**
    	 * Invoked when the LocalConnection notify a security error.
    	 */
		private function _onSecurityError( e:SecurityErrorEvent ):void
		{
		    //trace( "> " + this + " : " + e ) ;
		}
		
		/**
		 * Internal LocalConnection reference.
		 */
		private var _lc:LocalConnection ;
        
    }
}