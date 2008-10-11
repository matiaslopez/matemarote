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
package asgard.events
{
    import flash.events.Event;
    
    import asgard.net.NetServerConnection;
    import asgard.net.NetServerInfo;
    import asgard.net.NetServerStatus;
    
    import vegas.events.BasicEvent;    

    /**
     * This Event contains the NetServerConnection and status of a connection in the application.
     * @author eKameleon
     * @version 1.0.0.0
     */    
    public class NetServerEvent extends BasicEvent    
    {
        
        /**
         * Creates a new NetServerEvent instance.
         */
        public function NetServerEvent(type:String, connection:NetServerConnection=null, status:NetServerStatus=null, info:* = null)
        {
            super(type) ;
            setConnection(connection) ;
            setInfo( info ) ;
            setStatus( status ) ;
        }

        /**
         * The name of the NetServerEvent when the connection is accepted.
         */
        public static const ACCEPTED:String = "onAccepted" ;
    
        /**
         * The name of the NetServerEvent when the connection is closed.
         */
         public static const CLOSE:String = "onClosed" ;

        /**
         * The name of the NetServerEvent when the connection is finished.
         */
        public static const FINISH:String = "onFinished" ;
    
        /**
         * The name of the NetServerEvent when the connection is started.
         */
        public static const START:String = "onStarted" ;
    
        /**
         * The name of the NetServerEvent when the connection status is changed.
         */
        public static const NET_STATUS:String = "onStatus" ;

        /**
         * The name of the NetServerEvent when the connection is out of time.
         */
        public static const TIMEOUT:String = "onTimeOut" ;

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            var e:NetServerEvent = new NetServerEvent( type , getConnection(), getStatus(), getInfo()) ;
            e.setInfo (e.getInfo()) ;
            e.setStatus(e.getStatus()) ;
            return e ;
        }
        
        /**
         * Returns the NetServerConnection target of this event.
         * @return the NetServerConnection target of this event.
         */
        public function getConnection():NetServerConnection
        {
            return _connection ;
        }

        /**
         * Returns the NetServerInfo reference of this event.
         * @return the NetServerInfo reference of this event.
         */
        public function getInfo():NetServerInfo 
        {
            return _info ;    
        }
    
        /**
         * Returns the NetServerStatus reference of this event.
         * @return the NetServerStatus reference of this event.
         */
        public function getStatus():NetServerStatus 
        {
            return _status ;    
        }

        /**
         * Sets the NetServerConnection target of this event.
         */
        public function setConnection(connection:NetServerConnection):void
        {
            _connection = connection ;
        }

        /**
         * Sets the NetServerInfo reference of this event.
         * @param oInfo the info <code class="prettyprint">Object</code> used to define the NetServerInfo reference.
         */
        public function setInfo( oInfo:* ):void 
        {
            if (oInfo is NetServerInfo) 
            {
                _info = oInfo ;
            } 
            else if ( oInfo is Object ) 
            {
                _info = new NetServerInfo(oInfo) ;    
            }     
            else
            {
                _info = null ;
            }
        }
    
        /**
         * Sets the NetServerStatus reference of this event.
         * @param status the NetServerStatus of this event.
         */
        public function setStatus(status:NetServerStatus):void 
        {
            _status = NetServerStatus.validate(status) ? status : null ;
        }
        
        /**
         * @private
         */
        private var _connection:NetServerConnection ;

        /**
         * @private
         */
        private var _status:NetServerStatus ;

        /**
         * @private
         */
        private var _info:NetServerInfo ;

    }

}