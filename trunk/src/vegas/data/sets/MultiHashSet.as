package vegas.data.sets
{
	import vegas.data.Collection;
	import vegas.data.Map;
	import vegas.data.Set;
	import vegas.data.iterator.Iterator;
	import vegas.data.map.MultiHashMap;
	import vegas.data.sets.HashSet;
	import vegas.errors.UnsupportedOperation;
	import vegas.util.Copier;

	/**
	 * The MultiHashSet is a MutliHashMap that contains no duplicate elements in a specified key.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import vegas.data.Collection ;
	 * import vegas.data.collections.SimpleCollection ;
	 * import vegas.data.sets.MultiHashSet ;
	 * 
	 * var s:MultiHashSet = new MultiHashSet() ;
	 * 
	 * trace("----- Test put()") ;
	 * 
	 * trace("insert key1:valueA1 : " + s.put("key1", "valueA1")) ;
	 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2"))
	 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
	 * trace("insert key1:valueA3 : " + s.put("key1", "valueA3")) ;
	 * trace("insert key2:valueA2 : " + s.put("key2", "valueA2")) ;
	 * trace("insert key2:valueB1 : " + s.put("key2", "valueB1")) ;
	 * trace("insert key2:valueB2 : " + s.put("key2", "valueB2")) ;
	 * 
	 * trace("size : " + s.size()) ;
	 * trace("totalSize : " + s.totalSize()) ;
	 * 
	 * trace("---- Test toArray") ;
	 * 
	 * var ar:Array = s.toArray() ;
	 * trace("s.toArray : " + ar) ;
	 * 
	 * trace("----- Test contains") ;
	 * 
	 * trace("contains valueA1 : " + s.contains("valueA1") ) ;
	 * trace("contains valueA1 in key1 : " + s.containsByKey("key1", "valueA1") ) ;
	 * trace("contains valueA1 in key2 : " + s.containsByKey("key2", "valueA1") ) ;
	 * 
	 * trace("---- Test removeBy(key, value)") ;
	 * 
	 * trace("remove key1:valueA2 : " + s.removeByKey("key1", "valueA2")) ;
	 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
	 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
	 * 
	 * trace("---- Test remove(key)") ;
	 * 
	 * trace("remove key2 : " + s.remove("key2")) ;
	 * trace("size : " + s.size()) ;
	 * 
	 * trace("---- Test putCollection(key, co:Collection)") ;
	 * var co:Collection = new SimpleCollection(["valueA1", "valueA4", "valueA1"]) ;
	 * s.putCollection("key1", co) ;
	 * trace("s.toString : " + s) ;
	 * </pre>
	 * @author eKameleon
	 * @see MultiMap
	 */
	public class MultiHashSet extends MultiHashMap implements Set
	{
		
		/**
		 * Creates a new MultiHashSet instance.
		 */
	 	public function MultiHashSet(m:Map=null)
		{
			super(m) ;
			_internalSet = new HashSet() ;
		}
		
		/**
	 	 * This clears each collection in the map, and so may be slow.
		 */
		public override function clear():void
		{
			super.clear() ;
			_internalSet.clear() ;
		}
		
		/**
		 * Returns the shallow copy of this object.
		 * @return the shallow copy of this object.
		 */
		public override function clone():*
		{
			var m:MultiHashSet = new MultiHashSet() ;
			var kItr:Iterator = keyIterator() ;
			var vItr:Iterator = valueIterator() ;
			while (kItr.hasNext()) {
				var key:* = kItr.next() ;
				var value:* = vItr.next() ;
				m.putCollection(key, value) ;
			}
			return m ;
		}
		
		/**
		 * Checks whether the map contains the value specified .
		 * @param o the object to search in this instance.
		 * @return <code class="prettyprint">true</code> if the MultiHashSet container the passed-in object.
		 */
		public function contains(o:*):Boolean
		{
			
			var value:* = o ;
			
			var it:Iterator = __map.iterator() ;
			
			while (it.hasNext()) 
			{
				var cur:Collection = it.next() ;
				if (cur == null) continue ;
				if (cur.contains(value)) 
				{
					return true;
				}
			}
			return false ;
		}
	
		/**
		 * Checks whether the map contains the value specified with the specified key.
		 * @param key the specified key in the MultiHashSet to search the value.
		 * @param value the object to search in this instance.
		 * @return <code class="prettyprint">true</code> if the MultiHashSet container the passed-in object.
	 	 */
		public function containsByKey(key:*, value:*):Boolean
		{
			var s:Set = getSet(key) ;
			if (s == null) 
			{
				return false ;
			}
			else 
			{
				return s.contains( value ) ;
			}
		}

		public override function copy():*
		{
			var m:MultiHashSet = new MultiHashSet() ;
			var vItr:Iterator = valueIterator() ;
			var kItr:Iterator = keyIterator() ;
			while (kItr.hasNext()) 
			{
				var key:*   = Copier.copy(kItr.next()) ;
				var value:* = Copier.copy(vItr.next()) ;
				m.putCollection(key, value) ;
			}
			return m ;
		}

		/**
		 * Creates a new instance of the map value Collection(Set) container.
		 * This method can be overridden to use your own collection type.
		 */
		public override function createCollection():Collection 
		{
			return new HashSet() ;	
		}

		/**
		 * Returns the Set defined in the map with the specified key. 
		 * This method isn't the same in the superclass MultiHashMap. You can use the getSet() method more fast.
	 	 * @param id a key in the MutiHashSet. 
	 	 * @return the Set defined in the map with the specified key.
	 	 */
		public override function get( key:* ):*
		{
			return getSet( key ) ;
		}

		/**
		 * Returns the Set defined in the map with the specified key.
		 * @param key the key in the map 
		 * @return the Set defined in the map with the specified key.
		 */
		public function getSet( key:* ):Set 
		{
			return super.get(key) ;
		}

		/**
		 * This method always throws an <code class="prettyprint">UnsupportedOperation</code> because this method is not supported by this Set.
		 * @throw UnsupportedOperation the MultiHashSet instance does not support the indexOf() method.
		 */		
		public function indexOf(o:*, fromIndex:uint=0):int
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the indexOf() method.") ;
			return 0;
		}
		
		/**
		 * This method always throws an <code class="prettyprint">UnsupportedOperation</code> because this method is not supported by this Set.
		 * @param o an object to insert in the MultiHashSet.
		 * @return nothing (null)
		 * @throw UnsupportedOperation the MultiHashSet instance does not support the insert() method.
		 */		
		public function insert( o:* ):Boolean
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the insert() method.") ;
			return null ;
		}

		/**
		 * Adds the value to the Set associated with the specified key.
		 * @return <code class="prettyprint">true</code> if the value is inserted in the object.
		 */
		public override function put(key:*, value:*):*
		{
			if(_internalSet.contains(value)) 
			{
				return false ;
			}
			if (!containsKey(key)) 
			{
				__map.put(key , createCollection()) ;
			}
			__map.get(key).insert(value) ;
			return _internalSet.insert(value) ;
		}

		/**
		 * Adds a collection of values to the collection associated with the specified key.
		 */
		public override function putCollection(key:*, c:Collection):void 
		{
			if (!containsKey(key)) 
			{
				__map.put(key , createCollection()) ;
			}
			var s:HashSet = __map.get(key) ;
			var it:Iterator = c.iterator() ;
			var value:* ;
			while(it.hasNext()) 
			{
				value = it.next() ;
				if (_internalSet.insert(value)) 
				{
					s.insert(value) ;
				}	
			}
		}

		/**
		 * Removes a specific value from map with a specific key.
		 */
		public override function remove(o:*):*
		{
			var s:Set = __map.get(o) ;
			if (s != null) 
			{
				var it:Iterator = s.iterator() ;
				while(it.hasNext()) 
				{
					_internalSet.remove(it.next()) ;
				}
				__map.remove(o) ;
				return true ;
			}
			else 
			{
				return false ;	
			}
		}
		   
		/**
		 * Removes a specific value from map with the specific passed-in key value.
		 * <p><b>Note :</b> Use Set implementation and not Map implementation !</p>
		 */
		public override function removeByKey( key:*, value:* ):*
		{
			
			var c:Collection = __map.get(key) ;
			if (c == null) return null ;
			if (c.remove(value))
			{
				return _internalSet.remove(value) ;
			}
			else 
			{
				return null ;
			}
			
		}

		/**
		 * Returns an array containing the combination of values from all keys.
	 	 * @return an array containing the combination of values from all keys.
		 */
		public function toArray():Array
		{
			return getValues() ;
		}

		private var _internalSet:HashSet ;

	}
}