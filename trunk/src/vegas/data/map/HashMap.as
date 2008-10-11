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
    import flash.utils.Dictionary;
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    
    import vegas.core.HashCode;
    import vegas.data.Map;
    import vegas.data.iterator.ArrayIterator;
    import vegas.data.iterator.Iterator;
    import vegas.data.iterator.MapIterator;
    import vegas.data.map.MapFormat;
    import vegas.util.Copier;
    import vegas.util.Serializer;    

    /**
     * This class is not the same AS2 vegas.data.map.HashMap, see ArrayMap to compare AS2 and AS3 class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package 
     * {
     *         
     *    import flash.display.Sprite;
     *    import flash.utils.* 
     *    
     *    import vegas.data.Map ;
     *    import vegas.data.map.HashMap;
     *    import vegas.data.iterator.Iterator;
     *    
     *    public class TestHashMap extends Sprite
     *    {
     *    
     *        public function TestHashMap() 
     *        {
     *              
     *          var map:Map = new HashMap() ;
     *          trace("> put key1 -> value0 : " + map.put("key1", "value0") ) ;
     *          trace("> put key1 -> value1 : " + map.put("key1", "value1") ) ;            
     *          trace("> put key2 -> value2 : " + map.put("key2", "value2") ) ;
     *                        
     *          trace("> map : " + map) ;
     *          trace("> map toSource : " + map.toSource()) ;
     * 
     *          trace("> iterator") ;
     *          var it:Iterator = map.iterator() ;
     *          while(it.hasNext()) 
     *          {
     *              var v:* = it.next() ;
     *              var k:* = it.key() ;
     *              trace( "   -> " + k + " : " + v ) ;
     *          }
     *                        
     *          trace("> remove key1 : " + map.remove("key1")) ;
     *          trace("> size : " + map.size()) ;      
     *                        
     *          map.clear() ;  
     *                        
     *          trace("> isEmpty : " + map.isEmpty()) ;      
     *                        
     *       }
     *    }
     * </pre>
     * @author eKameleon
     */
    public dynamic class HashMap extends Proxy implements Map
    {
        
        /**
         * Creates a new HashMap instance.
         */
        public function HashMap( ...arguments:Array )
        {
            
            clear() ;
            
            var k:Array = (arguments[0] as Array) ;
            var v:Array = (arguments[1] as Array) ;
            
            if ( k != null && v != null )
            {
                if (k.length > 0 && k.length == v.length)
                {
                    var count:uint = k.length ;
                    for(var i:uint = 0 ; i<count ; i++) 
                    {
                        put(k[i], v[i]) ;
                    }
                }
            }
            
        }
        
       /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty( methodName:*  , ...rest:Array ):* 
        {
            return undefined ;
        }
        
        /**
         * Removes all mappings from this map.
         */  
        public function clear():void
        {
			_keys   = new Dictionary(true) ;
            _values = new Dictionary(true) ;
            _size = 0 ;
        }
        
        /**
         * Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         * @return a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         */
        public function clone():*
        {
            var m:HashMap = new HashMap() ;
            m.putAll(this) ;
            return m ;
        }

        /**
         * Returns a deep copy ot this HashMap instance.
         * @return a deep copy ot this HashMap instance.
         */
        public function copy():*
        {
            return new HashMap( Copier.copy( getKeys() ) , Copier.copy( getValues() ) ) ;
        }

        /**
         * Returns true if this map contains a mapping for the specified key.
         * @return true if this map contains a mapping for the specified key.
         */
        public function containsKey(key:*):Boolean
        {
            return _keys[ key ] != null ;
        }
  
        /**
         * Returns true if this map maps one or more keys to the specified value.
         * @return true if this map maps one or more keys to the specified value.
         */
        public function containsValue(value:*):Boolean
        {
            return _values[ value ] != null ;
        }
        
        /**
         * Invoked when a property is deleted in the hashmap.
         * <pre class="prettyprint">
         * import vegas.data.map.HashMap;
         * 
         * var map:HashMap = new HashMap() ;
         * 
         * trace("> put key1 -> value1 : " + map.put("key1", "value1") ) ;
         * trace("> put key2 -> value2 : " + map.put("key2", "value2") ) ;
         * 
         * trace("> map : " + map) ;
         * 
         * var isDeleted:Boolean = delete map["key1"] ;
         * 
         * trace("> remove key1 : " + isDeleted ) ;
         * 
         * trace("> map : " + map) ;
         * </pre>
         * @return <code class="prettyprint">true</code> if the key is removed.
         */
        flash_proxy override function deleteProperty(name:*):Boolean 
        {
            return remove(name) != null ;
        }

        /**
         * Returns the value to which this map maps the specified key.
         * @return the value to which this map maps the specified key.
         */
        public function get(key:*):* 
        {
            return _keys[key] ;
        }

        /**
         * Returns an array representation of all keys in the map.
         * @return an array representation of all keys in the map.
         */
        public function getKeys():Array
        {
            var ar:Array = [] ;
            for (var key:* in _keys) 
            {
                ar.push(key) ;
            }
            return ar ;
        }
        
		/**
         * If the property can't be found, the method returns undefined. 
         * For more information on this behavior, see the ECMA-262 Language Specification, 3rd Edition. 
         */
        flash_proxy override function getProperty( name:* ):* 
        {
            return _keys[name] ;
        }

        /**
         * Returns an array representation of all values in the map.
         * @return an array representation of all values in the map.
         */
        public function getValues():Array
        {
            var ar:Array = [] ;
            for each (var value:* in _keys) 
            {
                ar.push(value) ;
            }
            return ar ;
        }

		/**
		 * Returns a hashcode value for the object.
		 * @return a hashcode value for the object.
		 */
		public function hashCode():uint 
		{
			if ( isNaN( __hashcode__ ) ) 
			{
				__hashcode__ = HashCode.next() ;
			}
			return __hashcode__ ;
		}

        /**
         * Returns true if this map contains no key-value mappings.
         * @return true if this map contains no key-value mappings.
         */
        public function isEmpty():Boolean
        {
            return _size == 0 ;
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
            return new ArrayIterator(getKeys()) ;
        }

        /**
         * Associates the specified value with the specified key in this map.
         */
        public function put(key:*, value:*):*
        {
            var r:* = null ;
            if ( containsKey( key ) )
            {
                r = _keys[ key ] ;
                remove( key );
            }
            var count:uint = _values[ value ] ;
            _values[ value ] = (count > 0) ? count+1 : 1 ;
            _size++ ;
            _keys[ key ] = value ;
            return r ;
        }
 
        /**
         * Copies all of the mappings from the specified map to this one.
         */
        public function putAll(m:Map):void
        {
            var aV:Array = m.getValues() ;
            var aK:Array = m.getKeys() ;
            var l:uint = aK.length ;
            for (var i:uint = 0 ; i<l ; i = i - (-1) ) 
            {
                put(aK[i], aV[i]) ;
            }
        }
 
        /**
         * Removes the mapping for this key from this map if present.
         */
        public function remove(o:*):*
        {
            var key:* = o ;
            var value:* ;
            if ( containsKey( key ) ) 
            {
                _size -- ;
                value = _keys[ key ];
                var count:uint = _values[ value ];
                if (count > 1)
                {
                    _values[ value ] = count - 1;
                } 
                else
                {
                    delete _values[ value ];
                }
                delete _keys[ key ] ;
                return value ;
            }
            else 
            {
                return null ;
            }
        }

        /**
         * If the property can't be found, this method creates a property with the specified name and value.
         * @param name The name of the property to modify.
         * @param value The value to set the property to.
         */
        flash_proxy override function setProperty( name:* , value:* ):void 
        {
            put(name, value) ;
        }

        /**
         * Returns the number of key-value mappings in this map.
         * @return the number of key-value mappings in this map.
         */
        public function size():uint
        {
            return _size ;
        }

        /**
         * Returns the eden String representation of this map.
         * @return the eden String representation of this map.
         */        
        public function toSource( indent:int = 0 ):String 
        {
            return Serializer.getSourceOf(this, [getKeys(), getValues()]) ;
        }
 
        /**
         * Returns the String representation of this map.
         * @return the String representation of this map.
         */
        public function toString():String
        {
            return new MapFormat().formatToString( this ) ;
        }

		/**
		 * @private
		 * The hashcode value of this object.
		 */
		private var __hashcode__:Number = NaN ;
		
        /**
         * The keys collection.
         */
        private var _keys:* ;

        /**
         * The size of this map.
         */
        private var _size:uint ;
        
        /**
         * The values collection.
         */
        private var _values:* ;

    }
}
