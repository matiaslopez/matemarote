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

package vegas.data.bag
{
    import vegas.core.CoreObject;
    import vegas.data.Bag;
    import vegas.data.Collection;
    import vegas.data.List;
    import vegas.data.Map;
    import vegas.data.Set;
    import vegas.data.bag.BagFormat;
    import vegas.data.bag.HashBag;
    import vegas.data.iterator.BagIterator;
    import vegas.data.iterator.Iterator;
    import vegas.data.list.ArrayList;
    import vegas.data.map.MapUtil;
    import vegas.data.sets.HashSet;
    import vegas.errors.UnsupportedOperation;
    import vegas.util.Serializer;	

    /**
	 * This class provides a skeletal implementation of the <code class="prettyprint">Bag</code> interface, to minimize the effort required to implement this interface.
	 * <p>To implement a bag, the programmer needs only to extend this class and provide implementations for the cursor, insert and size methods. For supporting the removal of elements, the cursor returned by the cursor method must additionally implement its remove method.</p>
	 * @author eKameleon
	 */
	public class AbstractBag extends CoreObject implements Bag
	{
		
		/**
	 	 * Creates a new AbstractBag instance.
	 	 * @param m a Map reference.
	 	 */
		public function AbstractBag( m:Map )
		{
			if (m != null) 
			{
				_setMap(m) ;
			}
		}
		
		/**
		 * Removes all of the elements from this bag.
		 */
		public function clear():void 
		{
			_mods ++ ;
			_map.clear() ;
			_total = 0 ;
		}
	 
		/**
		 * Returns the shallow copy of this bag.
		 * @return the shallow copy of this bag.
		 */
		public function clone():*
		{
			return null ;
		}

		/**
		 * Returns <code class="prettyprint">true</code> if this bag contains the object passed in argument.
		 * @return <code class="prettyprint">true</code> if this bag contains the object passed in argument.
		 */
		public function contains(o:*):Boolean 
		{
			return _map.containsKey(o);
		}
     
		/**
		 * Returns <code class="prettyprint">true</code> if thie bag contains all object in the passed collection in argument.
		 * @return <code class="prettyprint">true</code> if thie bag contains all object in the passed collection in argument.
		 */
	    public function containsAll(c:Collection):Boolean 
	    {
	    	return containsAllInBag(new HashBag(c)) ;
	    }

		/**
		 * Returns <code class="prettyprint">true</code> if thie bag contains all object in the passed bag in argument.
		 * @return <code class="prettyprint">true</code> if thie bag contains all object in the passed bag in argument.
		 */     
		public function containsAllInBag(b:Bag):Boolean 
		{
			var result:Boolean = true ;
			var i:Iterator = b.uniqueSet().iterator() ;
	        while (i.hasNext()) 
	        {
				var current:* = i.next();
	            var contains:Boolean = getCount(current) >= b.getCount(current) ;
	            result = result && contains ;
	        }
	        return result;
		}

		/**
		 * Returns the deep copy of this bag.
		 * @return the deep copy of this bag.
		 */
		public function copy():*
		{
			return null ;
		}
	
		/**
		 * Unsupported by bag objects.
		 * @throws UnsupportedOperation the 'get' method is unsupported with a bag object.
		 */	
		public function get(key:*):*
		{
			throw new UnsupportedOperation(this + " 'get' method is unsupported.") ;
		}

		/**
		 * Returns the count of the specified object passed in argument.
		 * @return the count of the specified object passed in argument.
	 	 */
		public function getCount(o:*):uint
		{
        	var result:uint = 0;
	        var count:uint = MapUtil.getNumber(_map, o);
	        if (! isNaN(count))
	        {
	            result = count ;
	        }
	        return result;
		}

		/**
		 * This method is used in the BagIterator class.
		 */
		public function getModCount():uint
		{
			return _mods ;
		}

		/**
		 * Unsupported by bag objects.
		 * @throws UnsupportedOperation the 'indexOf' method is unsupported with a bag object.
		 */	
		public function indexOf(o:*, fromIndex:uint=0):int
		{
			throw new UnsupportedOperation(this + " 'indexOf' method is unsupported.") ;
		}

		/**
		 * Add 1 copy of the given object to the bag and keep a count. 
		 */	
		public function insert(o:*):Boolean 
		{
		
			return insertCopies(o, 1) ;
		}

		/**
		 * Insert all elements represented in the given collection.
		 */			
    	public function insertAll(c:Collection):Boolean 
    	{
    		var changed:Boolean = false;
	        var i:Iterator = c.iterator() ;
			var added:Boolean ;
	        while (i.hasNext()) {
				added = insert(i.next());
	            changed = changed || added ;
	        }
	        return changed;
    	}

		/**
		 * Add n copies of the given object to the bag and keep a count. 
		 */
    	public function insertCopies(o:*, nCopies:uint):Boolean 
    	{
    		_mods++ ;
	        if (nCopies > 0) 
	        {
    	        var count:uint = nCopies + getCount(o) ;
	            _map.put(o, count);
	            _total += nCopies;
	            return count == nCopies ;
	        }
	        else 
	        {
	            return false;
	        }
    	}

		/**
		 * Returns <code class="prettyprint">true</code> if the bag is empty.
		 * @return <code class="prettyprint">true</code> if the bag is empty.
		 */
		public function isEmpty():Boolean 
		{
			return _map.isEmpty() ;
    	}

		/**
	 	 * Returns the bag iterator.
		 * @return the bag iterator.
	 	 */
		public function iterator():Iterator 
		{
			return new BagIterator(this, _extractList().iterator()) ;
		}

		/**
		 * Removes the object in argument in the bag.
	 	 */
		public function remove(o:*):* 
		{
			return removeCopies(o, getCount(o));
		}

		/**
		 * (Violation) Removes all elements represented in the given collection, respecting cardinality.
		 */
    	public function removeAll(c:Collection):Boolean 
    	{
        	var result:Boolean = false ;
	        if (c != null) {
	            var i:Iterator = c.iterator() ;
    	        while (i.hasNext()) 
    	        {
					var next:* = i.next() ;
	                var changed:Boolean = removeCopies(next, 1) ;
	                result = result || changed ;
	            }
	        }
    	    return result ;
    	}

		/**
		 * Removes the given number of occurrences from the bag.
		 */
    	public function removeCopies(o:*, nCopies:uint):Boolean 
    	{
			_mods++;
	        var result:Boolean = false;
	        var count:uint = getCount(o) ;
	        if (nCopies <= 0) result = false;
	        else if (count > nCopies) 
	        {
	            _map.put( o, new int(count - nCopies)) ;
	            result = true ;
	            _total -= nCopies ;
	        }
	        else
	        { // count > 0 && count <= i  
	            result = (_map.remove(o) != null) ; // need to remove all
	            _total -= count ;
	        }
    	    return result;
    	} 

		/**
		 * (Violation) Removes any members of the bag that are not in the given collection, respecting cardinality.
		 */
    	public function retainAll(c:Collection):Boolean 
    	{
    		return retainAllInBag(new HashBag(c));
    	}

		/**
		 * (Violation) Removes any members of the bag that are not in the given bag.
		 */
		public function retainAllInBag(b:Bag):Boolean 
		{
	    	var result:Boolean = false ;
	        var excess:Bag = new HashBag() ;
	        var i:Iterator = uniqueSet().iterator() ;
	        while (i.hasNext()) 
	        {
	            var cur:* = i.next() ;
	            var count1:uint = getCount(cur) ;
	            var count2:uint = b.getCount(cur) ;
	            if ( 1 <= count2 && count2 <= count1) 
	            {
	                excess.insertCopies(cur, count1 - count2) ;
	            }
	            else 
	            {
	                excess.insertCopies(cur, count1) ;
	            }
	        }
	        if (!excess.isEmpty()) 
	        {
	        	result = removeAll(excess) ;
	        }
	        return result;
	    }
	
		/**
		 * Returns the number of elements in this bag (its cardinality).
		 * @return the number of elements in this bag (its cardinality).
		 */
		public function size():uint
		{
			return _total ;
		}
	
		/**
		 * Returns the array representation of the bag.
		 * @return the array representation of the bag.
	 	 */
		public function toArray():Array 
		{
			return _extractList().toArray();
		}

		/**
	 	 * Returns the Eden representation of the object.
	 	 * @return a string representation the source code of the object.
	 	 */
		public override function toSource( indent:int = 0 ):String  
		{
			return Serializer.getSourceOf(this, [_map]) ;
		}
	
		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public override function toString():String 
		{
			return (new BagFormat()).formatToString(this) ;
		}
		
		/**
		 * Returns the Set of unique members that represent all members in the bag.
		 * @return the Set of unique members that represent all members in the bag.
		 */
    	public function uniqueSet():Set 
    	{
    		return new HashSet(_map.getKeys()) ;
    	}

		/**
		 * @private
		 */
		protected function _calcTotalSize():uint
		{
    	    _total = _extractList().size() ;
	        return _total ;
	    }

		/**
		 * @private
		 */
		protected function _extractList():List 
		{
        	var result:List = new ArrayList() ;
	        var i:Iterator  = uniqueSet().iterator();
	        while (i.hasNext()) 
	        {
	            var current:* = i.next() ;
				var l:uint = getCount(current) ;
	            while (--l > -1) 
	            {
	            	result.insert(current);
	            }
	        }
	        return result ;
	    }

		/**
		 * @private
		 */
		protected function _getMap():Map 
		{
			return _map ;
		}

		/**
		 * @private
		 */	
		protected function _setMap(m:Map):void
		{
			if (m == null || m.isEmpty() == false) 
			{
	            throw new ArgumentError(this + ", the map must be non-null and empty.") ;
	        }
	        _map = m ;
		}

		/**
		 * @private
		 */
		private var _map:Map = null ;	
		
		/**
		 * @private
		 */		
		private var _mods:uint = 0 ;
		
		/**
		 * @private
		 */		
		private var _total:uint = 0 ;

	}
}