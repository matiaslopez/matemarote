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
	import vegas.data.Map;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterator;
	import vegas.data.iterator.MapIterator;
	import vegas.util.Copier;
	import vegas.util.Serializer;    

	/**
	 * ArrayMap is an Map implementation based on two arrays to defines the collections of the keys and the values.
	 * This implementation sort all elements in the map with the natural order of the keys and values arrays. 
	 * @author eKameleon
 	*/
    public class ArrayMap extends CoreObject implements Map
    {
        
		/**
		 * Creates a new ArrayMap instance.
		 * @param keys An optional Array of all keys to fill in this Map.
		 * @param values An optional Array of all values to fill in this Map. This Array must have the same size like the 'keys' argument.
		 */        
        public function ArrayMap( ...arguments:Array )
        {
            
            var k:Array = arguments[0] as Array ;
    		var v:Array = arguments[1] as Array ;
    		
    		if (k == null ||  v == null) 
    		{
        		_keys = [] ;
    	    	_values = [] ;
    		}
    		else 
            {
    		    var b:Boolean =  ( k.length > 0 && k.length == v.length ) ;
    		    _keys   = b ? [].concat(k) : [] ;
        		_values = b ? [].concat(v) : [] ;
            }
        }
        
    	/**
    	 * This clears all in the map.
    	 */  
        public function clear():void
        {
            _keys = [] ;
    		_values = [] ;
        }
        
    	/**
    	 * Returns the shallow copy of this map.
    	 * @return the shallow copy of this map.
    	 */
        public function clone():*
        {
            var m:ArrayMap = new ArrayMap() ;
            m.putAll(this) ;
            return m ;
        }

		/**
		 * Returns <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
		 * @return <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
		 */
        public function containsKey(key:*):Boolean
        {
            return indexOfKey(key) > -1 ;
        }

		/**
		 * Returns <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
		 * @return <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
		 */
        public function containsValue(value:*):Boolean
        {
    		return indexOfValue(value) > -1 ;
        }

		/**
		 * Returns a deep copy of the map.
	 	 * @return a deep copy of the map.
		 */
		public function copy():*
		{
			return new ArrayMap( Copier.copy(getKeys()) , Copier.copy(getValues()) ) ;
		}

		/**
		 * Returns the value to which this map maps the specified key.
		 * @return the value to which this map maps the specified key.
	 	 */
        public function get(key:*):* 
        {
            return _values[indexOfKey(key)] ;
        }
        
		/**
		 * Returns an array of all the keys in the map.
		 * @return an array of all the keys in the map.
	 	 */
        public function getKeys():Array
        {
            return _keys.slice() ;
        }

		/**
		 * Returns an array of all the values in the map.
		 * @return an array of all the values in the map.
		 */
        public function getValues():Array
        {
            return _values.slice() ;
        }
		
		/**
		 * Returns the index position in the ArrayMap of the specified key.
		 * @return the index position in the ArrayMap of the specified key.
		 */
	    public function indexOfKey(key:*):int 
	    {
            return _keys.indexOf(key) ;
	    }

		/**
		 * Returns the index position in the ArrayMap of the specified value.
		 * @return the index position in the ArrayMap of the specified value.
		 */
    	public function indexOfValue(value:*):int
    	{
    		return _values.indexOf(value) ;
	    }

		/**
	 	 * Returns <code class="prettyprint">true</code> if this map contains no key-value mappings.
		 * @return <code class="prettyprint">true</code> if this map contains no key-value mappings.
	 	 */
        public function isEmpty():Boolean
        {
	        return (size() < 1) ;
        }

		/**
	 	 * Returns the values iterator of this map.
		 * @return the values iterator of this map.
	 	 */
        public function iterator():Iterator
        {
            return new MapIterator(this) ;
        }

		/**
	 	 * Returns the keys iterator of this map.
		 * @return the keys iterator of this map.
	 	 */
        public function keyIterator():Iterator
        {
            return new ArrayIterator(_keys) ;
        }

        /**
    	 * Associates the specified value with the specified key in this map.
    	 * @param key the key to register the value.
    	 * @param value the value to be mapped in the map.
    	 */
        public function put(key:*, value:*):*
        {
		    var r:* ;
    		var i:int = indexOfKey(key) ;
		    if (i<0) 
		    {
			    _keys.push(key) ;
    			_values.push(value) ;
    			return null ;
    		}
    		else 
    		{
    			r = _values[i] ;
    			_values[i] = value ;
    			return r ;
    		}
        }

		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 */
        public function putAll(m:Map):void
        {
		    var aV:Array = m.getValues() ;
    		var aK:Array = m.getKeys() ;
    		var l:uint = aK.length ;
    		for (var i:uint = 0 ; i<l ; i = i - (-1) ) {
	    		put(aK[i], aV[i]) ;
    		}
        }
        
		/**
		 * Removes the mapping for this key from this map if it is present (optional operation).
		 */
        public function remove(o:*):*
        {
		    var r:* = null ;
    		var i:int = indexOfKey(o) ;
    		if (i > -1) {
    			r = _values[i] ;
    			_values.splice(i, 1) ;
    			_keys.splice(i, 1) ;
    		}
    		return r ;
        }
        
		/**
		 * Sets the value of the "key" in the HashMap (ArrayMap) with the specified index.
		 * @return the old 'key' value in the map if exist.
		 */
		public function setKeyAt( index:uint, key:* ):* 
		{
			var old:* = _keys[index] ;
			if (old === undefined)
			{
				return null ;	
			}
			_keys[index] = key ;
			return old ;
		}
		
		/**
		 * Sets the value of the "value" in the HashMap (ArrayMap) with the specified index.
		 * @return the old value in the map if exist.
		 */
		public function setValueAt( index:Number, value:* ):* 
		{
			var old:* = _values[index] ;
			if (old === undefined)
			{
				return null ;	
			}
			_values[index] = value ;
			return old ;
		}

		/**
		 * Returns the number of key-value mappings in this map.
		 * @return the number of key-value mappings in this map.
		 */
        public function size():uint
        {
            return _keys.length ;
        }
        
		/**
		 * Returns a eden representation of the object.
		 * @return a string representing the source code of the object.
	 	 */
        public override function toSource( indent:int = 0 ):String 
        {
    		return Serializer.getSourceOf(this, [_keys, _values]) ;
        }

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
		 */
        public override function toString():String
        {
		    return new MapFormat().formatToString(this) ;
        }

	    protected var _keys:Array ;

    	protected var _values:Array ;
    	
    }
}