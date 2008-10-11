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
    import vegas.data.Map;
    import vegas.data.iterator.Iterator;
    import vegas.util.AbstractTypeable;
    import vegas.util.Serializer;    

    /**
	 * TypedMap is a wrapper for Map instances that ensures that only values of a specific type can be added to the wrapped Map.
	 * @author eKameleon
	 */
	public class TypedMap extends AbstractTypeable implements Map
	{
		
		/**
	 	 * Creates a new TypedMap instance.
		 * @param fType the type of all values in this TypedMap.
		 * @param m the map to wrapp.
		 * @throws ArgumentError if the specified map in argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
		 */
		public function TypedMap(type:*, map:Map)
		{
			super(type) ;
			if (!map) 
			{
				throw new ArgumentError(this + " constructor, argument 'map' must not be 'null' or 'undefined'.") ;
			}
			if (map.size() > 0) {
				var it:Iterator = map.iterator() ;
				while ( it.hasNext() ) 
				{
					validate(it.next()) ;
				}
			}
			_map = map ;
		}

		/**
	 	 * Removes all mappings from this map (optional operation).
	 	 */
		public function clear():void
		{
			_map.clear() ;
		}

		/**
		 * Returns a shallow copy of the map.
	 	 * @return a shallow copy of the map.
		 */
		public function clone():*
		{
			return new TypedMap(getType(), _map.clone()) ;
		}

		/**
		 * Returns <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
		 * @return <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
		 */
		public function containsKey(key:*):Boolean
		{
			return _map.containsKey(key) ;
		}

		/**
		 * Returns <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
		 * @return <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
		 */
		public function containsValue(value:*):Boolean
		{
			return _map.containsValue(value) ;
			return false;
		}

		/**
		 * Returns a deep copy of the map.
	 	 * @return a deep copy of the map.
		 */
		public function copy():*
		{
			return new TypedMap(getType(), _map.copy()) ;
		}
		
		/**
		 * Returns the value to which this map maps the specified key.
		 * @return the value to which this map maps the specified key.
	 	 */
		public function get(key:*):*
		{
			return _map.get(key) ;
		}

		/**
		 * Returns an array of all the keys in the map.
		 * @return an array of all the keys in the map.
	 	 */
		public function getKeys():Array
		{
			return _map.getKeys() ;
		}

		/**
		 * Returns an array of all the values in the map.
		 * @return an array of all the values in the map.
		 */
		public function getValues():Array
		{
			return _map.getValues() ;
		}

		/**
	 	 * Returns <code class="prettyprint">true</code> if this map contains no key-value mappings.
		 * @return <code class="prettyprint">true</code> if this map contains no key-value mappings.
	 	 */
		public function isEmpty():Boolean
		{
			return _map.isEmpty() ;
		}

		/**
	 	 * Returns the values iterator of this map.
		 * @return the values iterator of this map.
	 	 */
		public function iterator():Iterator
		{
			return _map.iterator() ;
		}

		/**
	 	 * Returns the keys iterator of this map.
		 * @return the keys iterator of this map.
	 	 */
		public function keyIterator():Iterator
		{
			return _map.keyIterator() ;
		}		

		/**
		 * Associates the specified value with the specified key in this map (optional operation).
		 */
		public function put(key:*, value:*):*
		{
			validate(value) ;
			return _map.put(key, value) ;
		}
		
		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 */
		public function putAll(m:Map):void
		{
			var it:Iterator = m.iterator() ;
			while(it.hasNext()) {
				validate(it.next()) ;
			}
			_map.putAll(m) ;
		}

		/**
		 * Removes the mapping for this key from this map if it is present (optional operation).
		 */
		public function remove(key:*):*
		{
			return _map.remove(key) ;
		}

		/**
	 	 * Sets the type of the ITypeable object.
		 */
		public override function setType(type:*):void 
		{
			super.setType(type) ;
			_map.clear() ;
		}

		/**
		 * Returns the number of key-value mappings in this map.
		 * @return the number of key-value mappings in this map.
		 */
		public function size():uint
		{
			return _map.size() ;
		}

		/**
		 * Returns a Eden representation of the object.
		 * @return a string representing the source code of the object.
	 	 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf( this, [ getType() , _map ] ) ;
		}

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
		 */
		public override function toString():String
		{
			return (_map as TypedMap).toString() ;
		}

		private var _map:Map ;
	}
}

