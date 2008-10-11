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

package vegas.data.sets
{
	import vegas.data.Collection;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterator;
	import vegas.data.map.ArrayMap;
	import vegas.util.Copier;
	import vegas.util.Serializer;	

	/**
	 * Hash Set based implementation of the Set interface. 
	 * @author eKameleon
 	*/
	public class HashSet extends AbstractSet
	{
		
		/**
		 * Creates a new HashSet instance.
		 * <p>You can use an optional parameter in this constructor with different type : an Array or a Collection instance to fill the Set object.</p>
		 */
		public function HashSet( init:* = undefined )
		{
			
			super(null) ;
			
			_map = new ArrayMap() ;
			
			if (init == null) return ;
			
			var it:Iterator = null ;
			
			if (init is Array) 
			{
				it = new ArrayIterator(init) ;
			}
			else if (init is Collection) 
			{
				it = (init as Collection).iterator() ;
			}
			
			if (it != null) 
			{
				
				while (it.hasNext())
				{
					insert(it.next()) ;
				} 
				
			}
			
		}
		
		/**
		 * Removes all of the elements from this Set (optional operation).
		 */
		public override function clear():void
		{
			_map.clear() ;
		}

		/**
		 * Returns a shallow copy of this Set (optional operation).
		 * @return a shallow copy of this Set (optional operation).
		 */
		public override function clone():*
		{
			return new HashSet(toArray()) ;
		}
	
		/**
		 * Returns <code class="prettyprint">true</code> if this Set contains the specified element.
	 	 * @return <code class="prettyprint">true</code> if this Set contains the specified element.
		 */	
		public override function contains(o:*):Boolean 
		{
			return _map.containsKey(o) ;
	    }

		/**
		 * Returns a deep copy of this Set (optional operation).
		 * @return a deep copy of this Set (optional operation).
		 */
		public override function copy():*
		{
			return new HashSet( Copier.copy(toArray())) ;
		}

		/**
		 * Adds the specified element to this set if it is not already present.
		 */
		public override function insert(o:*):Boolean 
		{
			return _map.put(o, PRESENT) == null ;
    	}

		/**
		 * Returns true if this set contains no elements.
		 * @return true if this set contains no elements.
		 */
		public override function isEmpty():Boolean 
		{
			return _map.isEmpty() ;
		}

		/**
		 * Returns an iterator over the elements in this Set.
		 * @return an iterator over the elements in this Set.
		 */
		public override function iterator():Iterator 
		{
			return _map.keyIterator() ;
		}

		/**
		 * Removes the specified element from this set if it is present.
		 */
    	public override function remove(o:*):* 
    	{
			return _map.remove(o) == PRESENT ;
    	}

		/**
	 	 * Returns the number of elements in this set (its cardinality).
		 * @return the number of elements in this set (its cardinality).
		 */
		public override function size():uint 
		{
			return _map.size() ;
		}
	
		/**
		 * Returns the array representation of all the elements of this Set.
		 * @return the array representation of all the elements of this Set.
		 */
		public override function toArray():Array 
		{
			return _map.getKeys() ;
		}

		/**
		 * Returns the eden String representation of this object.
		 * @return the eden String representation the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String  
		{
			return Serializer.getSourceOf(this, [toArray()]) ;
		}
		
		private var _map:ArrayMap ;
		
		private static const PRESENT:Object = new Object() ;
		
	}
}