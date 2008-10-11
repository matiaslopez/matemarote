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
    import vegas.core.CoreObject;                    

    /**
     * Defines the enumeration of all NetServerConnection status codes.
     * @author eKameleon
     */
    public class NetServerStatus extends CoreObject
    {

        /**
         * Creates a new NetServerStatus instance.
          * @param code The code property.
         */ 
        public function NetServerStatus( code:String , level:String )
        {
            this.code = code ;
        }
        
        /**
         * The code property.
         */
        public var code:String ;

        /**
         * The level property.
         */
        public var level:String ;

        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is NetServerStatus )
            {
                return ((o as NetServerStatus).code == code) && ((o as NetServerStatus).level == level) ;
            }
            else
            {
                return false ;
            }    
        }

        /**
         * Indicates if the specified code expression is register in the NetServerStatus enumeration list.
         * @return <code class="prettyprint">true</code> if the specified code expression is register in the NetServerStatus enumeration list.
         */
        public static function contains( code:String ):Boolean 
        {
            return get(code) != null ;
        }

        /**
         * Returns the specified code expression register in the NetServerStatus enumeration list.
         */
        public static function get( code:String ):NetServerStatus 
        {
            var status:Array = 
            [
                 CALL_BAD_VERSION , CALL_FAILED      , CALL_PROHIBITED ,
                 CONNECT_CLOSED   , CONNECT_FAILED   , CONNECT_INVALID , 
                 CONNECT_REJECTED , CONNECT_SHUTDOWN , CONNECT_SUCCESS
            ] ;
            var len:uint = status.length ;
            while( --len > -1 )
            {
            	if ( status[len].code == code )
            	{
            		return status[len] as NetServerStatus ;
            	}
            }
            return null ;
        }

        /**
         * Returns the source representation of this object.
         * @return the source representation of this object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return 'new asgard.net.NetServerStatus("' + code + '","' + level + '")' ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public override function toString():String
        {
            return code ;
        }

        /**
         * Validate if the specified object is a valid status value.
         * @return <code class="prettyprint">true</code> if the specified object is a valid status value.
         */
        public static function validate( o:* ):Boolean 
        {
            var status:Array = 
            [
                 CALL_BAD_VERSION , CALL_FAILED      , CALL_PROHIBITED ,
                 CONNECT_CLOSED   , CONNECT_FAILED   , CONNECT_INVALID , 
                 CONNECT_REJECTED , CONNECT_SHUTDOWN , CONNECT_SUCCESS
            ] ;
            return status.indexOf(o) > -1 ;    
        }    
        
        /**
         * Returns the primitive value of this object.
         * @return the primitive value of this object.
         */
        public function valueOf():*
        {
            return code ;
        }
                
        /**
         * Packet encoded in an unidentified format.
         */ 
        public static const CALL_BAD_VERSION:NetServerStatus = new NetServerStatus("NetConnection.Call.BadVersion", "error") ;

        /**
         * The NetConnection.call method was not able to invoke the server-side method or command.
         */ 
        public static const CALL_FAILED:NetServerStatus = new NetServerStatus("NetConnection.Call.Failed", "error") ;

        /**
         * An Action Message Format (AMF) operation is prevented for security reasons. 
         * Either the AMF URL is not in the same domain as the file containing the code calling the NetConnection.call() method, 
         * or the AMF server does not have a policy file that trusts the domain of the the file containing the code calling 
         * the NetConnection.call() method.
         */ 
        public static const CALL_PROHIBITED:NetServerStatus = new NetServerStatus( "NetConnection.Call.Prohibited" , "error" ) ;
                
        /**
         * The connection was closed successfully.
         */
        public static const CONNECT_CLOSED:NetServerStatus = new NetServerStatus( "NetConnection.Connect.Closed" , "status" ) ;

        /**
         * The connection attempt failed or the NetConnection.call method was not able to invoke the server-side method or command.
         */
        public static const CONNECT_FAILED:NetServerStatus = new NetServerStatus( "NetConnection.Connect.failed" , "error" ) ;

        /**
         * The application name specified during connect is invalid.
         */
        public static const CONNECT_INVALID:NetServerStatus = new NetServerStatus( "NetConnection.Connect.InvalidApp" , "error" ) ;
        
        /**
         * The connection attempt did not have permission to access the application.
         */
        public static const CONNECT_REJECTED:NetServerStatus = new NetServerStatus( "NetConnection.Connect.Rejected" , "error" ) ;
        
        /**
         *  The specified application is shutting down.
         */
        public static const CONNECT_SHUTDOWN:NetServerStatus = new NetServerStatus( "NetConnection.Connect.AppShutdown" , "error" ) ;
    
        /**
         * The connection attempt succeeded.
         */
        public static const CONNECT_SUCCESS:NetServerStatus = new NetServerStatus( "NetConnection.Connect.Success" , "status" ) ;        
        
    }
}