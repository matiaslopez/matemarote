/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.transitions 
{
	import flash.display.Shape;
	import flash.events.Event;
	
	import andromeda.process.SimpleAction;
	
	import vegas.events.BasicEvent;	

	/**
	 * This singleton create a virtual Frame interval with a onEnterFrame event. 
	 * The use can register object listeners to receive by default the Event.ENTER_FRAME event.
	 * @author eKameleon
	 */
	public class FrameEngine extends SimpleAction
	{
	
		/**
	 	 * Creates a new FrameEngine instance.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
	 	 */
		public function FrameEngine( bGlobal:Boolean = false , sChannel:String = null )
		{
    		setGlobal( bGlobal , sChannel ) ;
    		_shape = new Shape() ;
		}
        
		/**
		 * Returns the singleton reference of the class.
		 * @return the singleton reference of the class.
		 */
		public static function getInstance():FrameEngine
		{
			if( _instance == null )
			{
				_instance = new FrameEngine();
			}
			return _instance ;
		}
		
		/**
		 * Release the singleton reference of the class.
		 */
		public static function release () : void
		{
			if ( _instance != null )
			{
				_instance.stop();
				_instance = null;
			}
		}		
        
		/**
		 * Start the process.
		 */
		public function start() : void
		{
			if( !running )
			{
				notifyStarted() ;
				setRunning(true) ;
				_shape.addEventListener( Event.ENTER_FRAME, _enterFrame );
			}
		}

		/**
		 * Stop the process.
		 */
		public function stop() : void
		{
			if( running )
			{
				setRunning( false ) ;
				_shape.removeEventListener( Event.ENTER_FRAME, _enterFrame );
				notifyFinished() ;
			}
		}
			
		/**
		 * The singleton reference of the class.
		 * @private
		 */
		private static var _instance:FrameEngine ;
			
		/**
		 * The internal Shape reference.
		 * @private
		 */
		private var _shape:Shape ;
		
		/**
		 * Invoked during the enterframe propagation.
		 */
		private function _enterFrame( e:Event ):void
		{
			dispatchEvent( new BasicEvent( Event.ENTER_FRAME , this ) ) ;
		}
		
	}
	
}

