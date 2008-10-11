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

package vegas.data.map
{
	import vegas.core.CoreObject;
	import vegas.data.Collection;
	import vegas.data.Map;
	import vegas.data.MultiMap;
	import vegas.data.collections.SimpleCollection;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterable;
	import vegas.data.iterator.Iterator;
	import vegas.util.Copier;
	import vegas.util.Serializer;	

	/**
 	 * The default implementation of the <code class="prettyprint">MultiMap</code> interface.
 	 * <p><b>Example :</b></p>
	 * <code class="prettyprint">
 	 * import vegas.data.Collection ;
	 * import vegas.data.iterator.Iterator ;
	 * import vegas.data.map.HashMap ;
	 * import vegas.data.Map ;
	 * import vegas.data.MultiMap ;
	 * import vegas.data.map.MultiHashMap ;
 	 * 
	 * var map1:HashMap = new HashMap() ;
	 * map1.put("key1", "valueD1") ;
	 * map1.put("key2", "valueD2") ;
	 * trace ("> map1 : " + map1) ;
	 * trace ("> map1 containsKey 'key1' : " + map1.containsKey("key1")) ;
	 * 
	 * trace ("--- use a map argument in constructor") ;
	 * 
	 * var map:MultiHashMap = new MultiHashMap(map1) ;
	 * map.put("key1", "valueA1") ;
	 * map.put("key1", "valueA2") ;
	 * map.put("key1", "valueA3") ;
	 * map.put("key2", "valueA2") ;
	 * map.put("key2", "valueB1") ;
 	 * map.put("key2", "valueB2") ;
 	 * map.put("key3", "valueC1") ;
 	 * map.put("key3", "valueC2") ;
	 * 
 	 * trace ("init map : " + map) ;
	 * trace ("\r--- toSource MultiMap") ;
	 * 
	 * trace("map toSource : " + map.toSource()) ;
 	 * 
	 * trace ("\r--- put values in MultiMap") ;
	 * 
	 * trace ("key1 >> " + map.get("key1")) ;
	 * 
	 * trace ("key2 >> " + map.get("key2")) ;
	 * 
	 * trace ("key3 >> " + map.get("key3")) ;
	 * 
	 * trace ("\r--- toString MultiMap") ;
	 * 
	 * trace (map) ;
	 * 
	 * map.remove("key1", "valueA2") ;
	 * 
	 * trace ("\r--- remove a value in key1 >> " + map.get("key1")) ;
	 * 
	 * trace ("\r--- use iterator") ;
	 * 
	 * var it:Iterator = map.iterator() ;
	 * while(it.hasNext()) 
	 * {
	 *     trace ("\t :: " + it.next()) ;
	 * }
	 * 
	 * trace ("\r--- use a key iterator : key1") ;
	 * var it:Iterator = map.iterator("key1") ;
	 * while(it.hasNext()) 
	 * {
	 *     trace ("\t :: " + it.next()) ;
	 * }
	 * 
	 * trace ("\r--- putCollection key2 in key1") ;
	 * map.putCollection("key1", map.get("key2")) ;
	 * trace ("key1 >> " + map.get("key1")) ;
	 * 
	 * trace ("\r--- different size") ;
	 * trace ("map size : " + map.size()) ;
	 * trace ("map totalSize : " + map.totalSize()) ;
	 * 
	 * trace ("\r--- clone MultiMap") ;
	 * var clone:MultiMap = map.clone() ;
	 * clone.remove("key1") ;
	 * 
	 * trace("clone : " + clone) ;
	 * trace ("clone size : " + clone.totalSize()) ;
	 * trace ("map size : " + map.totalSize()) ;
	 * 
	 * trace ("\r--- valueIterator") ;
	 * var it:Iterator = map.valueIterator() ;
	 * while(it.hasNext()) 
	 * {
	*      trace("\t> " + it.next()) ;
 	* }
	* </code>
 	* @author eKameleon
 	* @see MultiMap
 	*/
	public class MultiHashMap extends CoreObject implements MultiMap
	{
		
		/**
		 * Creates a new MultiHashMap instance.
		 */
		public function MultiHashMap( m:Map=null )
		{

			__map = new HashMap() ;
			
			if (m == null) 
			{
				return ;
			}
			
			if (m.size() > 0) 
			{
				putAll(m.copy()) ;
			}
			
		}

		/**
		 * Removes all elements in this map.
		 */
		public function clear():void 
		{
			__map.clear() ;
		}

		/**
		 * Returns a shallow copy of this object.
		 * @return a shallow copy of this object.
		 */
		public function clone():* 
		{
			var m:MultiHashMap = new MultiHashMap() ;
			var kItr:Iterator = keyIterator() ;
			var vItr:Iterator = valueIterator() ;
			while (kItr.hasNext()) 
			{
				var key:*   = kItr.next() ;
				var value:* = vItr.next() ;
				m.putCollection(key, value) ;
			}
			return m ;
		}

		/**
		 * Checks whether the map contains the key specified.
		 */
		public function containsKey( key:* ):Boolean 
		{
			return __map.containsKey( key ) ;
		}

		/**
		 * Checks whether the map contains the value specified.
		 * <p><b>Example :</b></p>
		 * <code class="prettyprint">
		 * var b:Boolean = map.containsValue(value) ;
		 * </code>
		 * @return <code class="prettyprint">true</code> if the List contains the specified value.
		 */
		public function containsValue( value:* ):Boolean 
		{
			var it:Iterator = __map.iterator() ;
			while (it.hasNext()) 
			{
				var cur:Collection = it.next() as Collection ;
				if ( cur != null && cur.contains(value) ) 
				{
					return true;
				}
			}
			return false ;
		} 

		/**
		 * Checks whether the map contains the value specified or at the specified key contains the value.
		 * <p><b>Example :</b></p>
		 * {
		 * var b:Boolean = map.containsValue(key, value) ;
		 * }
		 */
		public function containsValueByKey( key:*, value:* ):Boolean 
		{
			return ( get( key ) as Collection ).contains( value ) == true ;
		}

		/**
		 * Returns a deep copy of the map.
		 * @return a deep copy of the map.
		 */
		public function copy():* 
		{
			var m:MultiHashMap = new MultiHashMap() ;
			var vItr:Iterator = valueIterator() ;
			var kItr:Iterator = keyIterator() ;
			while (kItr.hasNext()) 
			{
				var key:* = Copier.copy(kItr.next()) ;
				var value:* = Copier.copy(vItr.next()) ;
				m.putCollection(key, value) ;
			}
			return m ;
		}

		/**
		 * Creates a new instance of the map value Collection container.
		 * This method can be overridden to use your own collection type.
		 */
		public function createCollection():Collection 
		{
			return new SimpleCollection() ;	
		}

		/**
		 * Gets the collection mapped to the specified key. This method is a convenience method to typecast the result of get(key).
		 */
		public function get( key:* ):*
		{
			return __map.get(key) ;
		}

		/**
		 * Checks whether the map contains the key specified .
		 */
		public function getKeys():Array 
		{
			return __map.getKeys() ;
		}
	
		/**
		 * This returns an array containing the combination of values from all keys.
		 */
		public function getValues():Array 
		{
			var result:Array = [] ;
			var values:Array = __map.getValues() ;
			var l:uint = values.length ;
			for (var i:uint = 0 ; i<l ; i++) 
			{
				result = result.concat( values[i].toArray() ) ;
			}
			return result ;
		}

		/**
		 * Returns whether this MultiHashSet contains any mappings.
		 * 
		 * @return <code class="prettyprint">true</code> if this MultiHashSet contains any mappings else <code class="prettyprint">false</code>
		 */
		public function isEmpty():Boolean 
		{
			return __map.isEmpty() ;
		}
	
		/**
		 * Gets an iterator for the MultiHashMap.
		 */
		public function iterator( /*key*/ ):Iterator 
		{
			return __map.iterator() ;
		}

		/**
		 * Gets an iterator for the collection mapped to the specified key.
		 */
		public function iteratorByKey( key:* ):Iterator
		{
			return (__map.get(key) as Iterable).iterator() ;
		}

		/**
		 * Gets an iterator for the map to iterate keys.
		 */
		public function keyIterator():Iterator 
		{
			return __map.keyIterator() ;
		}		
	
		/**
		 * Adds the value to the collection associated with the specified key.
		 */
		public function put(key:*, value:*):*
		{
			if (!containsKey(key)) 
			{
				__map.put( key , createCollection() ) ;
			}
			var co:Collection = __map.get(key) ;
			var b:Boolean = co.insert( value ) ;
			return b ? value : null ;
		}	

		/**
		 * Override superclass to ensure that MultiMap instances are correctly handled.
		 */
		public function putAll(map:Map):void
		{
			var it:Iterator = map.iterator() ;
			while (it.hasNext()) 
			{
				var value:* = it.next() ;
				var key:* = it.key() ;
				if (value is Collection) 
				{
					putCollection(key, value) ;
				}
				else 
				{
					put(key, value) ;
				}
			}
		}

		/**
		 * Adds a collection of values to the collection associated with the specified key.
		 */
	    public function putCollection(key:*, c:Collection):void 
	    {
	    	if (!containsKey(key)) 
	    	{
				__map.put(key , createCollection()) ;
			}
			__map.get(key).insertAll(c) ;
	    }
	    
		/**
		 * Removes a specific value from map with a specific key.
		 * @param o the key to remove in the map.
		 */
		public function remove(o:*):*
		{
			return __map.remove(o) ;
		}
		   
		/**
		 * Removes a specific value from all the map.
		 * @param key the key to remove in the map
		 * @param value (optional) if this value is defined removes a specific value from map else removes all values associated with the specified key.
		 * @return the removed value.
		 */
		public function removeByKey( key:* , value:* ):*
		{
			
			if (key != null && value != null) 
			{
				
				var c:Collection = __map.get(key) ;
				var b:Boolean = c.remove(value) ;
				return (b) ? value : null ;
				
			}
			return null ;
			
		}

		/**
		 * Returns the size of the collection mapped to the specified key.
		 * @return the size of the collection mapped to the specified key.
		 */
		public function size():uint
		{
			return __map.size() ;
		}

		/**
		 * Returns a Eden representation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [__map]) ;
		}

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
		 */
		public override function toString():String 
		{
			return (new MultiMapFormat()).formatToString(this) ;
		}

		/**
	 	 * Returns the total size of the map by counting all the values.
	 	 * @return the total size of the map by counting all the values.
	 	 */
    	public function totalSize():uint 
    	{
    		var result:uint = 0 ;
			var it:Iterator = __map.iterator() ;
			while (it.hasNext()) 
			{
				var co:Collection = it.next() ;
				var s:Number = co.size() ;
				result += isNaN(s) ? 0 : s ;
			}
			return result ;
    	}

		/**
		 * Returns a Collection of all values in the MultiHashMap.
		 * @return a Collection of all values in the MultiHashMap.
	 	 */
    	public function values():Collection 
    	{
			var ar:Array = getValues() ;
			return new SimpleCollection(ar) ;
    	}
	
		/**
		 * Returns the iterator of all values in the MultiHashMap.
		 * @return the iterator of all values in the MultiHashMap.
		 */
	    public function valueIterator():Iterator 
	    {
	    	return new ArrayIterator(__map.getValues()) ;
	    }
			
		/**
		 * The internal Map of this MultiHashMap class.
		 */
		protected var __map:HashMap ;

	}
}