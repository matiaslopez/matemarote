/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.core
{
	import lunas.core.IStyle;
	
	import vegas.data.map.HashMap;
	import vegas.errors.Warning;	

	/**
     * This collector use a Map to register all Displays in the application.
     * @author eKameleon
     */
	public class StyleCollector
	{
	
		/**
		 * Removes all elements in the StyleCollector.
		 */
		public static function clear():void 
		{
			_map.clear() ;	
		}
	
		/**
		 * Returns <code class="prettyprint">true</code> if the StyleCollector contains the specified id.
		 * @return <code class="prettyprint">true</code> if the StyleCollector contains the specified id.
		 */	
		public static function contains( id:* ):Boolean 
		{
			return _map.containsKey( id ) ;	
		}

		/**
		 * Returns the IStyle object register in the collector with the id passed-in argument.
		 * @return the IStyle object register in the collector with the id passed-in argument.
		 */	
		public static function get( id:* ):IStyle 
		{
			try 
			{
				if ( !contains( id ) ) 
				{
					throw new Warning("[StyleCollector].get('" + id + "'). Can't find IStyle instance." ) ;
				} ;
			}
			catch (e:Warning) 
			{
				e.toString() ;
			}
		
			return _map.get( id ) as IStyle ;	
		}
	
		/**
		 * Insert a IStyle with an unique id into the StyleCollector.
		 * @param id the Id of the IStyle to register
		 * @param style The IStyle object to insert in the collector.
		 * @throws Warning if the specified 'id' is already register in the collector. 
		 */
		public static function insert( id:*, style:IStyle ):Boolean 
		{
			if ( contains(id) )
			{ 
				throw new Warning("[StyleCollector] insert method failed. An IStyle instance is already registered with '" + id + "' id." ) ;
			}
			return _map.put(id, style) == null  ;	
		}
	
		/**
		 * Returns 'true' if the StyleCollector is 'empty'.
		 * @return 'true' if the StyleCollector is 'empty'.
		 */
		public static function isEmpty():Boolean 
		{
			return _map.isEmpty() ;	
		}
	
		/**
		 * Removes the specified IStyle object with the passed-in id value into the StyleCollector.
		 */
		public static function remove( id:* ):void 	
		{
			_map.remove( id ) ;
		}

		/**
		 * Returns the size of the StyleCollector.
		 * @return the size of the StyleCollector.
		 */
		public static function size():uint 	
		{
			return _map.size() ;
		}
	
		/**
		 * @private
		 */
		private static var _map:HashMap = new HashMap() ;
		
	}
}