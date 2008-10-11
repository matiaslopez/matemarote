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

package vegas.data.collections
{
    import vegas.data.Collection;
    import vegas.data.iterator.Iterator;
    import vegas.util.AbstractTypeable;
    import vegas.util.Serializer;    

    /**
	 * TypedCollection is a wrapper for Collection instances that ensures that only values of a specific type can be added to the wrapped collection.
	 * @author eKameleon
	 */	
	public class TypedCollection extends AbstractTypeable implements Collection
	{
		
		/**
		 * Creates a new TypedCollection.
		 * @throws ArgumentError if the specified collection in argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code> 
	 	 */
		public function TypedCollection(type:*, co:Collection=null)
		{
			super(type);
			if (co == null) 
			{
				throw new ArgumentError("Argument 'co' must not be 'null' or 'undefined'.") ;
			}
			if (co.size() > 0) 
			{
				var it:Iterator = co.iterator() ;
				while ( it.hasNext() ) 
				{
					validate(it.next()) ;
				}
			}
			_co = co ;
		}
		
		/**
		 * Removes all of the elements from this collection (optional operation).
	 	 */
		public function clear():void 
		{
			_co.clear() ;
		}
		
		/**
		 * Returns a shallow copy of this collection.
	 	 * @return a shallow copy of this collection.
	 	 */
		public function clone():* 
		{
			return new TypedCollection(getType(), _co) ;
		}
		
		/**
		 * Returns a deep copy of this collection.
	 	 * @return a deep copy of this collection.
	 	 */
		public function copy():*
		{
			return new TypedCollection(getType(), _co.clone()) ;
		}

		/**
		 * Returns <code class="prettyprint">true</code> if this collection contains the specified element.
		 * @return <code class="prettyprint">true</code> if this collection contains the specified element.
	 	 */
		public function contains(o:*):Boolean
		{
			return _co.contains(o) ;
		}

		/**
		 * Returns the element from this collection at the passed index.
		 * @return the element from this collection at the passed index.
		 */
    	public function get(key:*):*
    	{
    		return _co.get(key) ;	
    	}
    	
		/**
		 * Returns the index of an element in the collection.
	 	 * @return the index of an element in the collection.
	 	 */
		public function indexOf(o:*, fromIndex:uint=0):int
		{
			return _co.indexOf(o, fromIndex) ;
		}

		/**
		 * Inserts an elements into the Collection.
		 */
		public function insert(o:*):Boolean
		{
			return _co.insert(o) ;
		}
	
		/**
		 * Returns <code class="prettyprint">true</code> if this collection contains no elements.
		 * @return <code class="prettyprint">true</code> if the collection is empty else <code class="prettyprint">false</code>.
		 */
		public function isEmpty():Boolean
		{
			return _co.isEmpty();
		}

		/**
		 * Returns an iterator over the elements in this collection.
		 * @return an iterator over the elements in this collection.
		 */
		public function iterator():Iterator
		{
			return _co.iterator() ;
		}

		/**
		 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
	 	 */
		public function remove(o:*):*
		{
			return _co.remove(o) ;
		}

		/**
		 * Sets the type of the ITypeable object.
		 */
		public override function setType(type:*):void
		{
			super.setType(type) ;
			_co.clear() ;
		}
		
		/**
		 * Returns the number of elements in this collection.
		 * @return the number of elements in this collection.
		 */
		public function size():uint
		{
			return _co.size() ;
		}
		
		/**
	 	 * Returns an array containing all of the elements in this collection.
		 * @return an array representation of all the elements in this wrapped collection.
		 */
		public function toArray():Array
		{
			return _co.toArray() ;
		}

		/**
		 * Returns the Eden representation of the object.
		 * @return a string representing the source code of the object.
	 	 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf( this, [ getType() ,  _co ] ) ;
		}
		
		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public override function toString():String
		{
			return (_co as TypedCollection).toString() ;
		}
        
        /**
         * @private
         */
		protected var _co:Collection ;
	}
}

