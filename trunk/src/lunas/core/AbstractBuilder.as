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
    
    import vegas.events.CoreEventDispatcher;	

    /**
	 * This class provides a skeletal implementation of the <code class="prettyprint">IBuilder</code> interface, to minimize the effort required to implement this interface.
	 * @author eKameleon
	 */
	public class AbstractBuilder extends CoreEventDispatcher implements IBuilder
	{

		/**
		 * Creates a new AbstractBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function AbstractBuilder( target:DisplayObject, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( bGlobal, sChannel );
			this.target = target ;
			
		}
		
		/**
		 * (read-write) Indicates the target reference of the component.
		 */
		public function get target():DisplayObject
		{
			return _target ;
		}
		
		/**
		 * @private
		 */
		public function set target(target:DisplayObject):void
		{
			if ( _target != null )
			{
				clear() ;
			}
			_target = target ;
		}
		

		/**
		 * Clear the view of the component.
	 	 */
		public function clear():void
		{
			// overrides
		}
		
		/**
	 	 * Runs the build of the component.
		 */
		public function run(...arguments:Array):void
		{
			// overrides
		}

		/**
		 * Update the view of the component.
		 */
		public function update():void
		{
			// overrides
		}
		
		/**
		 * @private
		 */
		private var _target:DisplayObject ;

	}

}
