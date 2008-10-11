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
	import vegas.core.CoreObject;
	import vegas.data.Collection;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterator;
	import vegas.util.Serializer;	

	/**
	 * This class provides a skeletal implementation of the <code class="prettyprint">Collection</code> interface, to minimize the effort required to implement this interface.
 	 * @author eKameleon
	 */
	public class AbstractCollection extends CoreObject implements Collection
	{
		
		/**
		 * Creates a new AbstractCollection.
	 	 * @param ar (optional) an array to fill the collection.
		 */
		public function AbstractCollection( ar:Array=null )
		{

			if  ( ar as Array != null) 
			{	
				_a = ar.slice() ;	
			}
			else 
			{
				_a = new Array() ;
			}
			
		}
		
		/**
    	 * Clear the queue object.
    	 */
		public function clear():void
		{
			_a.splice(0) ;
		}	

		/**
		 * Returns a shallow copy of this collection (optional operation).
		 * <p>Overrides this method in the concrete class.</p>
		 */
		public function clone():*
		{
			return null ;
		}
		
		/**
		 * Returns a deep copy of this collection (optional operation).
		 * <p>Overrides this method in the concrete class.</p>
		 */
		public function copy():*
		{
			return null;
		}
		
		/**
		 * Returns <code class="prettyprint">true</code> if this collection contains the specified element.
		 * @return <code class="prettyprint">true</code> if this collection contains the specified element.
	 	 */
		public function contains(o:*):Boolean
		{
			return _a.indexOf(o) >- 1  ;
		}

		/**
		 * Returns the element from this collection at the passed index.
		 * @return the element from this collection at the passed index.
		 */
    	public function get(key:*):* 
    	{
    		return _a[key] ;	
    	}

		/**
		 * Returns the index of an element in the collection.
	 	 * @return the index of an element in the collection.
	 	 */
		public function indexOf(o:*, fromIndex:uint=0):int
		{
			return _a.indexOf(o, fromIndex) ;
		}

		/**
		 * Inserts an element in the collection.
		 */
		public function insert(o:*):Boolean
		{
			if (o == undefined) return false ;
			_a.push(o);
			return true ;
		}
		
		/**
		 * Returns <code class="prettyprint">true</code> if this collection contains no elements.
		 * @return <code class="prettyprint">true</code> if this collection contains no elements.
	 	 */
		public function isEmpty():Boolean
		{
			return _a.length == 0 ;
		}

		/**
		 * Returns an iterator over the elements in this collection.
		 * @return an Iterator over the elements in this collection.
		 * @see Iterator
		 * @see Iterable
		 */	
		public function iterator():Iterator
		{
			return new ArrayIterator(toArray()) ;
		}
		
		/**
		 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
		 */
		public function remove(o:*):*
		{
			var it:Iterator = iterator() ;
			if (o == null) 
			{
				while(it.hasNext()) 
				{
					if (it.next() == null) 
					{
						it.remove() ;
						return true ;
					}
					
				}	
				
			}
 			else {
 				
				while (it.hasNext()) 
				{
					var v:* = it.next() ;
					if (o == v) 
					{
						it.remove() ;
						return true ;
					}
				}
			}
			return false ;
			
		}
		
		/**
		 * Returns the number of elements in this collection.
		 * @return the number of elements in this collection.
		 */
		public function size():uint
		{
			return _a.length ;
		}
	
		/**
		 * Returns an array containing all of the elements in this collection.
		 * @return an array containing all of the elements in this collection.
		 */
		public function toArray():Array
		{
			return _a ;
		}

		/**
		 * Returns the eden representation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [toArray()]) ;
		}
		
		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public override function toString():String
		{
			return (new CollectionFormat()).formatToString(this) ;
		}
		
		protected var _a:Array ;
		
	}
}