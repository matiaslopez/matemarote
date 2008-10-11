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
    import vegas.errors.Warning;
    import vegas.events.BasicEvent;
    import vegas.events.FrontController;
    
    /**
     * The NetSeverGateway create a gateway between the Flash client and the FMS server.
     * @author eKameleon
     * @see NetServerConnection
     */
    public class NetServerGateway extends CoreObject
    {
        
       	/**
	     * Creates a new NetServerGateway instance.
	     */
	    public function NetServerGateway() 
	    {
    		_controller = initController() ;
    	}
        
     	/**
	     * Returns the NetConnection reference of this instance.
	     * @return the NetConnection reference of this instance.
    	 */
        public function get connection():NetServerConnection
        {
            return _connection ;
        }
        
	    /**
	     * Set the NetServerGateway controller reference.
	     * @param connection The AMF connection reference (NetServerConnection). 
	     */
	    public function set connection( connection:NetServerConnection ):void
	    {
    		if (_connection != null)
		    {
    			_connection.client = null ;
    			_connection        = null ;
		    }
		    
		    if ( connection != null )
		    {
        		_connection = connection ;
		        _connection.client = this ;
    	    }
    	    
	    }
    
    	/**
	     * Sets the NetServerGateway controller reference.
    	 */
	    public function set controller( controller:FrontController ):void
	    {
    		_controller = controller ;
    	}
        
        /*
	     * Returns the FrontController reference of this instance.
	     * @return the FrontController reference of this instance.
	     */
	    public function get controller():FrontController 
	    {
    		return _controller ;
    	}
        
	    /**
    	 * Returns <code class="prettyprint">true</code> if the eventName is registered in the Gateway Controller.
    	 * @param eventName the name of the event type in the internal controller.
    	 */
	    public function contains( eventName:String ):Boolean 
	    {
    		return _controller.contains(eventName) ;
    	}

    	/**
	     * Returns the singleton instance of class.
	     * @return singleton instance of class.
	     */
	    public static function getInstance():NetServerGateway 
	    {
    		if ( _instance == null )
		    {
    			_instance = new NetServerGateway() ;
		    }
		    return _instance ;
	    }

    	/**
    	 * Inits the NetServerGateway controller reference in the constructor of this instance.
	     * Overrides this method to customize initial Gateway controller.
    	 */
	    public function initController():FrontController 
	    {
    		return new vegas.events.FrontController() ;
    	}
        
    	/**
	     * Adds a new entry into the Gateway controller.
	     * @param eventName:String
	     * @param listener:EventListener
	     */
	    public function insert( eventName:String , listener:* ):void
	    {
    		_controller.insert(eventName, listener) ;
    	}
        
	    /**
	     * Invoked when the NetServerConnection receive from the server a shared event.
	     * You must use class mapping in the server to register the BasicEvent or the 
	     * @see BasicEvent
	     */
	    public function receiveSharedEvent( e:* ):void
	    {
    		if (_controller != null)
		    {
    			if ( e is BasicEvent )
			    {
			        _controller.fireEvent( e ) ;
			    }
			    else if ( e is String )
			    {
    				_controller.fireEvent( new BasicEvent( e as String  ) ) ;
			    }
			    else
			    {
    				throw new Warning(this + " receive a shared event or event type from the server but you can't propagate this event, the object isnt' an Event object or a String.") ;
			    }
		    }
		    else
		    {
    			throw new Warning(this + " receive a shared event or event type from the server but you can't propagate this event with a FrontController 'null' or 'undefined'.") ;	
		    }		
	    }

	    /**
	     * Remove an entry into the Gateway controller.
	     * @param eventName:String
	     */
	    public function remove( eventName:String ):void
	    {
    		_controller.remove(eventName) ;
    	}
        
        /**
         * The internal NetServerConnection reference of this gateway.
         */
	    private var _connection:NetServerConnection ;
        	
        /**
         * The internal FrontController reference of this gateway.
         */
	    private var _controller:FrontController ;

    	/**
	     * The internal singleton reference of this class.
	     */
	    private static var _instance : NetServerGateway;
        	
    }

}