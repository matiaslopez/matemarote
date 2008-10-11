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
package lunas.groups 
{
	import flash.events.Event;
	
	import lunas.core.IGroupable;
	
	import vegas.core.CoreObject;
	import vegas.data.Map;
	import vegas.data.map.HashMap;	

	/**
	 * This abstract class defined a skeletal implementation to create component's groups.
	 * @author eKameleon
	 */
	public class AbstractGroup extends CoreObject 
	{

		/**
		 * Creates a new AbstractGroup instance.
		 */
		public function AbstractGroup()
		{
			groups = initMap() ;
		}
	
		/**
		 * The internal MultiHashSet reference of this manager.
		 */
		public var groups:Map ;
		
		/**
		 * Returns <code class="prettyprint">true</code> if the specified group name exist.
		 * @return <code class="prettyprint">true</code> if the specified group name exist.
		 */
		public function contains( groupName:String ):Boolean
		{
			return 	groups.containsKey(groupName) ;
		}
		
		/**
		 * Returns the current IGroupable object selected with the passed-in group name.
		 * @return the current IGroupable object selected with the passed-in group name.
		 */
		public function get( groupName:String ):IGroupable
		{
			return 	groups.get(groupName) ;
		}
	
		/**
		 * Handles the event.
		 */
		public function handleEvent( e:Event ):void 
		{
			var target:IGroupable = e.target as IGroupable ;
			if ( target != null )
			{
				select( target ) ;
			}
		}
		
		/**
		 * Initialize the internal map of this group manager. This method is used in the constructor of this class.
		 * You can overrides this method.
	 	 */
		public function initMap():Map
		{
			return new HashMap() ;
		}
		
		/**
	 	 * Selects the passed-in IGroupable item.
		 * Overrides this method.
	 	 */	
		public function select( item:IGroupable ):void
		{
			// overrides this method.
		}
			
		/**
	 	 * Returns the <code class="prettyprint">Map</code> representation of the groups.
	 	 * @return the <code class="prettyprint">Map</code> representation of the groups.
	 	 */
		public function toMap():Map
		{
			return groups.clone() ;	
		}
			
		/**
	 	 * Unselect the specified item in argument. 
	 	 * This item can be a IGroupable object or the String representation of the name's group to unselect.
	 	 * Overrides this method.
	 	 */
		public function unSelect( item:* ):void 
		{
			// overrides this method.
		}
		
	}
	
}
