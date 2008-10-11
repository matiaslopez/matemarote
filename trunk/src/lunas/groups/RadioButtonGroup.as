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
	import lunas.core.IButton;
	import lunas.core.IGroupable;	

	/**
	 * This singleton class defined all groups for the different RadioButton in the application.
	 * @author eKameleon
	 */
	public class RadioButtonGroup extends AbstractGroup
	{
		
		/**
		 * Creates a new RadioButtonGroup.
	 	 */
		public function RadioButtonGroup () 
		{
			super() ;
		}
	
		/**
		 * Returns a singleton reference of the RadioButtonGroup class.
		 * @return a singleton reference of the RadioButtonGroup class.
		 */
		public static function getInstance():RadioButtonGroup 
		{
			if ( _instance == null )  
			{
				_instance = new RadioButtonGroup () ;
			}
			return _instance ;
		}
		
		/**
		 * Selects the passed-in IGroupable item.
		 */	
		public override function select( item:IGroupable ):void
		{
				
			var button:IButton = item as IButton ;
				
			if ( button != null && ( button.toggle == false ) ) 
			{
				return ;
			}
			
			var name:String = button.groupName ;
		
			if ( groups.containsKey( name ) )
			{
				var bt:IButton = groups.get(name) as IButton ;
				if ( bt != button )
				{
					bt.setSelected (false, true)  ;
				}
			}
		
			groups.put( name, button ) ;
			
		}
	
		/**
		 * Unselect the specified item in argument. 
		 * This item can be a IGroupable object or the String representation of the name's group to unselect.
		 */
		public override function unSelect( item:* ):void 
		{
			
			var name:String ;
			
			if ( item is String)
			{
				name = item ;
			}
			else if ( item is IGroupable )
			{
				name = (item as IGroupable).groupName ;
			}
			else
			{
				name = null ;	
			}
		
			if ( groups.containsKey( name ) )
			{
				var cur:IButton = groups.get(name) as IButton ;
				if ( cur != null )
				{
					cur.setSelected (false, true)  ;
					groups.remove( name ) ;
				}
			}
		}
	
		private static var _instance:RadioButtonGroup ;	
	
	}
}
