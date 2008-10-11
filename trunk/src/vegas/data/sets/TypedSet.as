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
    import vegas.data.Set;
    import vegas.data.iterator.Iterator;
    import vegas.util.AbstractTypeable;
    import vegas.util.Serializer;    

    /**
     * TypedSet is a wrapper for Set instances that ensures that only values of a specific type can be added to the wrapped Set.
     * @author eKameleon
     */
	public class TypedSet extends AbstractTypeable implements Set
	{
	
    	/**
    	 * Creates a new TypedSet instance.
    	 */
		public function TypedSet(type:*, s:Set)
		{
			super(type);
			if (s == null) 
			{
				throw new ArgumentError(this + " argument 's' must not be 'null' or 'undefined'.") ;
			}
			if (s.size() > 0) 
			{
				var it:Iterator = s.iterator() ;
				while ( it.hasNext() )
				{
					validate(it.next()) ;
				} 
			}
			_set = s ;
		}

	    /**
	     * Removes all of the elements from this Set (optional operation).
	     */
		public function clear():void 
		{
			_set.clear() ;
		}	

    	/**
    	 * Returns a shallow copy of this Set (optional operation).
    	 * @return a shallow copy of this Set (optional operation).
    	 */
		public function clone():* 
		{
			return new TypedSet(getType(), _set.clone()) ;
		}

    	/**
    	 * Returns <code class="prettyprint">true</code> if this Set contains the specified element.
    	 * @return <code class="prettyprint">true</code> if this Set contains the specified element.
    	 */	
		public function contains(o:*):Boolean 
		{
			return _set.contains(o) ;
	    }

    	/**
    	 * Returns a deep copy of this Set (optional operation).
    	 * @return a deep copy of this Set (optional operation).
    	 */
		public function copy():* 
		{
			return new TypedSet(getType(), _set.copy()) ;
		}

	    /**
	     * Returns an element in the set at the specified position.
	     * @param key the position of the element in the Set.
	     * @return the value of the specified element in the Set.
	     */
		public function get(key:*):*
		{
			return _set.get(key) ;
		}
	
		/**
		 * Returns the position of the passed object in the collection.
		 * @param o the object to search in the collection.
		 * @param fromIndex the index to begin the search in the collection.
		 * @return the index of the object or -1 if the object isn't find in the collection.
		 */
		public function indexOf(o:*, fromIndex:uint=0):int
		{
			return _set.indexOf(o) ;
		}

    	/**
    	 * Adds the specified element to this set if it is not already present.
    	 * @param o the object to insert in the Set.
    	 */
  		public function insert(o:*):Boolean 
  		{
			validate(o) ;
			return _set.insert(o) ;
	    }

    	/**
	     * Returns <code class="prettyprint">true</code> if this set contains no elements.
    	 * @return <code class="prettyprint">true</code> if this set contains no elements.
	     */
		public function isEmpty():Boolean 
		{
			return _set.isEmpty() ;
		}

    	/**
    	 * Returns an iterator over the elements in this set.
    	 * @return an iterator over the elements in this set.
    	 */
		public function iterator():Iterator 
		{
			return _set.iterator() ;
		}

    	/**
    	 * Removes the specified element from this set if it is present.
    	 */
	    public function remove(o:*):*
	    {
			return _set.remove(o);
	    }

    	/**
    	 * Sets the type of the ITypeable object.
    	 * @param type the type Class use to restrict all elements in this Set.
    	 */
		public override function setType(type:*):void
		{
			super.setType(type) ;
			_set.clear() ;
		}

    	/**
	     * Returns the number of elements in this set (its cardinality).
    	 * @return the number of elements in this set (its cardinality).
    	 */
		public function size():uint
		{
			return _set.size() ;
		}
	
    	/**
    	 * Returns the array representation of all the elements of this Set.
    	 * @return the array representation of all the elements of this Set.
    	 */
		public function toArray():Array 
		{
			return _set.toArray() ;
		}

    	/**
    	 * Returns a eden String representation of this object.
    	 * @return a string representation the source code of the object.
    	 */
		public override function toSource( indent:int = 0 ):String  
		{
			return Serializer.getSourceOf(this, [getType() , _set]) ;
		}

    	/**
    	 * Returns the string representation of this instance.
    	 * @return the string representation of this instance
    	 */
		public override function toString():String 
		{
			return (_set as TypedSet).toString() ;
		}
        
        /**
         * @private
         */
		private var _set:Set ;
	}
}

