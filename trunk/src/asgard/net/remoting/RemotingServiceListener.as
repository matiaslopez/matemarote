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
    
    import vegas.events.CoreEventDispatcher;    

    /**
	 * The basic implementation of the <code class="prettyprint">IRemotingEventListener</code> interface.
	 * @author eKameleon
	 */
	public class RemotingServiceListener extends CoreEventDispatcher implements IRemotingServiceListener 
	{
		
		/**
		 * Creates a new RemotingServiceListener instance.
		 * @param service The RemotingService reference of this listener.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function RemotingServiceListener( service:RemotingService = null , bGlobal:Boolean = false , sChannel:String = null )
		{
			super ( bGlobal , sChannel ) ;
			this.service = service ;
		}
		
		/**
		 * The RemotingService reference of this listener.
		 */
		public function get service():RemotingService
		{
			return _service ;
		}
		
		/**
		 * @private
		 */
		public function set service( service:RemotingService ):void
		{
			registerService(service) ;
		}
		
		/**
		 * Indicates the verbose mode of this listener.
		 */
		public var verbose:Boolean = true ;
		
		/**
		 * Invoked when the service notify an error.
		 */
		public function error( e:RemotingEvent ):void
		{
			if ( verbose )
			{	
				getLogger().error( this + " " + e.type ) ;
			}
		}
		
		/**
		 * Invoked when the service notify a fault.
		 */
		public function fault( e:RemotingEvent ):void
		{
			if ( verbose )
			{	
				getLogger().warn( this + " " + e.type + " description:" + e.getDescription() + ", code:" + e.getCode() ) ;
			}
		}
		
		/**
		 * Invoked when the service process is finished.
		 */
		public function finish( e:ActionEvent ):void
		{
			if ( verbose )
			{				
				getLogger().info( this + " " + e.type ) ;
			}
		}			
		
		/**
		 * Registers the specified service.
		 */
		public function registerService( service:RemotingService ):void
		{
			unregisterService() ;
			_service = service ;
			if ( _service != null )
			{
				_service.addEventListener( ActionEvent.FINISH   , finish  , false, 0 , true ) ;
				_service.addEventListener( ActionEvent.START    , start   , false, 0 , true ) ;
				_service.addEventListener( ActionEvent.TIMEOUT  , timeout , false, 0 , true ) ;
				_service.addEventListener( RemotingEvent.ERROR  , error   , false, 0 , true ) ;
				_service.addEventListener( RemotingEvent.FAULT  , fault   , false, 0 , true ) ;
				_service.addEventListener( RemotingEvent.RESULT , result  , false, 0 , true ) ;
			}
		}
				
		/**
		 * Invoked when the service notify a success.
		 */
		public function result( e:RemotingEvent ):void
		{
			if ( verbose )
			{
				getLogger().debug( this + " " + e.type + " service:" + service ) ;
			}
		}
		
		/**
		 * Invoked when the service process is started.
		 */
		public function start( e:ActionEvent ):void
		{
			if ( verbose )
			{			
				getLogger().info( this + " " + e.type + " service:" + service + " gatewayUrl:" + service.gatewayUrl ) ;
			}
		}		
		
		/**
		 * Invoked when the service notify a timeout.
		 */
		public function timeout( e:ActionEvent ):void
		{
			if ( verbose )
			{	
				getLogger().warn( this + " " + e.type ) ;
			}
		}		

		/**
		 * Unregister the service register in this listener.
		 * @return True if the unregister is success.
		 */
		public function unregisterService():Boolean
		{
			if ( _service != null )
			{
				_service.removeEventListener( ActionEvent.FINISH   , finish  , false ) ;
				_service.removeEventListener( ActionEvent.START    , start   , false ) ;
				_service.removeEventListener( ActionEvent.TIMEOUT  , timeout , false ) ;
				_service.removeEventListener( RemotingEvent.ERROR  , error   , false ) ;
				_service.removeEventListener( RemotingEvent.FAULT  , fault   , false ) ;
				_service.removeEventListener( RemotingEvent.RESULT , result  , false ) ;
				_service = null ;
				return true ;	
			}
			return false ;
		}
		
		/**
		 * @private
		 */
		private var _service:RemotingService ;
		
	}

}
