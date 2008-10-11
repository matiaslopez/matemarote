/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard AS3 Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net.remoting 
{
    import flash.display.DisplayObjectContainer;
    
    import asgard.net.FlashVars;
    
    import system.Strings;    

    /**
     * This factory build the gateway url of the services of this application.
     * @author eKameleon
     */
    public class RemotingGatewayUrl extends FlashVars
    {
		
		/**
		 * Creates a new RemotingGatewayUrl instance.
    	 * @param root The root of the application to resolve the FlashVars generic object (in the loaderInfo.parameters in AS3 main class).
    	 */
        public function RemotingGatewayUrl( root:DisplayObjectContainer )
        {
            super( root ) ;
        }
        
        /**
         * The name "gatewayUrl" of the flashVars passed-in. 
         */
        public var gatewayUrlName:String = "gatewayUrl" ;

        /**
         * The name "httpHost" of the flashVars passed-in. 
         */
        public var httpHostName:String = "httpHost" ;
        
        /**
         * Creates the url with the specified parameters.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var factory:RemotingGatewayUrl = new RemotingGatewayUrl( root ) ; // root is the reference of the Main class of the application
         * var url:String = factory.create("http://{0}/php/gateway.php", "localhost" ) ;
         * trace(url) ; // http://localhost/php/gateway.php
         * </pre>
         */
        public function create( gatewayUrl:String=null , httpHost:String=null ):String
        {
       		if ( contains( gatewayUrlName ) )
        	{
        		gatewayUrl = getValue( gatewayUrlName ) ;
        	}
        	if ( contains( httpHostName ) )
        	{
        		httpHost = getValue( httpHostName ) ;
        	}
        	return Strings.format( gatewayUrl, httpHost ) ;	
        }
    }
}

