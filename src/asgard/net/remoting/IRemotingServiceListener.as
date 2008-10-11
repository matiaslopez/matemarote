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
    import andromeda.events.ActionEvent;
	
	import asgard.events.RemotingEvent;
	import asgard.net.remoting.RemotingService;	

	/**
	 * This interface provides a basic event listener for the RemotingService instances.
	 * @author eKameleon
	 */
	public interface IRemotingServiceListener 
	{
		
		/**
		 * The RemotingService reference of this listener.
		 */
		function get service():RemotingService ;
		
		/**
		 * @private
		 */
		function set service( service:RemotingService ):void ;
		
		/**
		 * Invoked when the service notify an error.
		 */
		function error( e:RemotingEvent ):void ;
		
		/**
		 * Invoked when the service notify a fault.
		 */
		function fault( e:RemotingEvent ):void ;
		
		/**
		 * Invoked when the service process is finished.
		 */
		function finish( e:ActionEvent ):void ;
	
		/**
		 * Registers the specified service.
		 */
		function registerService( service:RemotingService ):void ;	
	
		/**
		 * Invoked when the service notify a success.
		 */
		function result( e:RemotingEvent ):void ;
		
		/**
		 * Invoked when the service process is started.
		 */
		function start( e:ActionEvent ):void ;
		
		/**
		 * Invoked when the service notify a timeout.
		 */
		function timeout( e:ActionEvent ):void ;
		
		/**
		 * Unregister the service register in this listener.
		 * @return True if the unregister is success.
		 */
		function unregisterService():Boolean ;
		
	}
}
