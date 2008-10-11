/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.core 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import vegas.data.map.HashMap;	

	/**
	 * This class provides a skeletal implementation of the button IBuilder objects.
	 * @author eKameleon
	 */
	public class AbstractButtonBuilder extends AbstractBuilder implements IBuilder
	{

		/**
		 * Creates a new AbstractButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function AbstractButtonBuilder( target:DisplayObject, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( target, bGlobal, sChannel );
			_map = new HashMap() ;
			initType() ;
		}

		/**
		 * Returns <code class="prettyprint">true</code> if the specified type is register in the object.
		 * @return <code class="prettyprint">true</code> if the specified type is register in the object.
		 */
		public function containsType( type:String ):Boolean
		{
			return _map.containsKey(type) ;	
		}

		/**
		 * Initialize all register type of this builder.
		 * Overrides this method in the concrete implementations.
		 */
		public function initType():void
		{
			//
		}

		/**
		 * Invoked when a ButtonEvent register in this builder is dispatched.
		 */
		protected function refreshState( e:Event ):void 
		{
			var type:String = e.type ;
			var callback:* = _map.get( type ) ;
			if ( callback is Function && callback != PRESENT )
			{
				( callback as Function ).call( this , e ) ;
			}			
		}

		/**
		 * Registers the ButtonEvent type passed in argument.
		 * @param type The type of the frame event to register (choose your event in the ButtonEvent static enumeration).
		 * @param callback The optional method of the button to launch 
		 */
		public function registerType( type:String , callback:Function=null ):void
		{
			var noExist:Boolean = _map.put( type , callback == null ? PRESENT : callback ) == null ;
			if ( noExist )
			{
				target.addEventListener( type , refreshState ) ;
			}
		}
		
		/**
		 * Unregisters the ButtonEvent type passed in argument.
		 */
		public function unregisterType( type:String ):void
		{
			if ( _map.containsKey( type ) )
			{
				target.removeEventListener( type , refreshState ) ;
				_map.remove( type ) ;
			}
		}
		
		/**
		 * @private
		 */
		private var _map:HashMap ;
		
		/**
		 * @private
		 */
		private static const PRESENT:Object = new Object() ;

	}

}
