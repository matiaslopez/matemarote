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
package vegas.data.list
{
    import vegas.data.Collection;
    import vegas.data.List;
    import vegas.data.collections.SimpleCollection;
    import vegas.data.iterator.ListIterator;    

    /**
 	 * This class provides a skeletal implementation of the List interface to minimize the effort required to implement this interface.
	 * @author eKameleon
 	 */
	public class AbstractList extends SimpleCollection implements List
	{
		
		/**
	 	 * Creates a new AbstractList instance.
	 	 * @param ar The optional default Array to fill this list.
	 	 */
		public function AbstractList( ar:Array=null )
		{
			super(ar);
		}
		
		/**
		 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
		 */
		public function equals( o:* ):Boolean 
		{
			return false ;
		}

		/**
	 	 * This method is used by the <code class="prettyprint">ListItr</code> class only.
	 	 */
		public function getModCount():Number 
		{
			return _modCount ;
		}
		
		/**
		 * Inserts the specified element at the specified position in this list (optional operation).
	     * @param id index at which the specified element is to be inserted.
	     * @param o element to be inserted.
		 */
		public function insertAt(id:uint, o:*):void 
		{
			if ( id > size() ) 
			{
				throw new RangeError( this + " insertAt method failed, the specified index '" + id + "' is out of bounds.") ;
			}
			_a.splice(id, 0, o) ;
		}

		/**
		 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
		 */
		public function insertAllAt(id:uint, c:Collection):Boolean 
		{
			if (id <0 || id > size()) return false ;
			var aC:Array = c.toArray() ;
			var aB:Array = _a.slice(0, id) ;
			var aE:Array = _a.slice(id) ;
			_a = aB.concat(aC, aE) ;
			return true ;
		}
	
	    /**
	     * Returns the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
	     * @param o element to search for.
	     * @return the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
     	 */
		public function lastIndexOf(o:*):int 
		{
			return _a.lastIndexOf(o) ;
		}

		/**
		 * Returns a list iterator of the elements in this list (in proper sequence).
	 	 * @return a list iterator of the elements in this list (in proper sequence).
		 */
		public function listIterator( position:uint=0 ):ListIterator 
		{
			var li:ListIterator = new ListItr(this) ;
			li.seek(position) ;
			return li ;
		}

	    /**
	     * Removes an element at the specified position in this list.
	     * @param  id index of the element to be removed from the List.
	     */
		public function removeAt(id:uint):* 
		{
			return removesAt(id, 1) ;
		}

		/**
		 * Removes from this list all the elements that are contained between the specific <code class="prettyprint">from</code> and the specific <code class="prettyprint">to</code> position in this list (optional operation).
	 	 */
		public function removeRange(from:uint , to:uint):void 
		{
			if (from == 0) return ;
			var it:ListIterator = listIterator(from) ;
			var l:Number = to - from ;
			for (var i:Number = 0 ; i<l ; i++) 
			{
				it.next() ; 
				it.remove() ;
			}
		}

	    /**
	     * Removes the specified count of elements at the specified position in this list.
	     * @param  id index of the first element to be removed from the List.
	     * @return len the number of elements that was removed from the list.
     	 */
		public function removesAt(id:uint, len:uint):* {
			var d:uint = len - id ;
			var old:* = _a.slice(id, d) ;
			_a.splice(id, len);
			return old ; 
		}
	
	    /**
	     * Replaces the element at the specified position in this list with the specified element.
	     * @param id index of element to replace.
	     * @param o element to be stored at the specified position.
     	 * @return the element previously at the specified position.
	     */
		public function setAt(id:uint, o:*):*
		{
			if (_a[id] === undefined) 
			{
				return null ;
			}
			else
			{
				var old:* = _a[id] ;
				_a[id] = o ;
				return old ;
			}
		}

		/**
		 * Sets the modCount property of this list.
		 */
		public function setModCount(n:uint):void
		{
			_modCount = n ;
		}

		/**
		 * Returns a subList of the LinkedList. The subList is an ArrayList instance.
		 * @return a subList of the LinkedList. The subList is an ArrayList instance.
		 */
		public function subList(begin:uint, end:uint):List 
		{
			var l:List = new AbstractList() ;
			var it:ListIterator = listIterator() ;
			var d:Number = (end - begin) + 1 ; 
			for (var i:Number = begin ; i<= d ; i++) 
			{
				l.insert(it.next()) ;
			}
			return l ;
		}	
		
		private var _modCount:Number = 0 ;
		
	}
}

import system.numeric.Mathematics;

import vegas.core.CoreObject;
import vegas.data.Collection;
import vegas.data.List;
import vegas.data.iterator.ListIterator;
import vegas.data.list.AbstractList;
import vegas.errors.ConcurrentModificationError;
import vegas.errors.IllegalStateError;
import vegas.errors.NoSuchElementError;

/**
 * The basic implementation of the list iterators.
 */
class ListItr extends CoreObject implements ListIterator 
{

	/**
	 * Creates a new ListItr instance.
	 * @param li The owner List reference of this iterator.
	 */
	function ListItr( li:List ) 
	{
		if (!li) 
		{
			throw new ArgumentError(this + " constructor, 'list' must not be 'null' nor 'undefined'.") ;
		}
		_list = li ;
		_key = 0 ;
		_listast = -1 ;
		_expectedModCount = AbstractList(_list).getModCount() ;
	}
	
	/**
	 * Invoked to check for comodification.
	 */
	public function checkForComodification():void 
	{
		var l:AbstractList = AbstractList(_list) ;
	   	if (l.getModCount() != _expectedModCount) 
   		{
	    	throw new ConcurrentModificationError(this + " modification impossible.") ;
    	}
	}
	
    /**
     * Returns <code class="prettyprint">true</code> if the iteration has more elements.
     * @return <code class="prettyprint">true</code> if the iteration has more elements.
     */ 
	public function hasNext():Boolean 
	{
		return _key < _list.size() ;
	}

    /**
     * Checks to see if there is a previous element that can be iterated to.
     */
	public function hasPrevious():Boolean 
	{ 
		return _key != 0 ;
	}
    
    /**
     * Inserts an object in the list during the iteration process.
     */
	public function insert(o:*):void 
	{
		checkForComodification() ;
		try 
		{
			_list.insertAt(_key++, o) ;
			_listast = -1 ;
			_expectedModCount = AbstractList(_list).getModCount() ;
		} 
		catch (e:ConcurrentModificationError) 
		{
			throw e ;
		}	
	}

    /**
     * Returns the current key of the internal pointer of the iterator (optional operation).
     * @return the current key of the internal pointer of the iterator (optional operation).
     */
	public function key():*
	{
		return _key ;
	}

    /**
     * Returns the next element in the iteration.
     * @return the next element in the iteration.
     */
	public function next():* 
	{
		if (hasNext()) 
		{
			var next:* = _list.get(_key) ;
			_listast = _key ;
			_key++ ;
			return next ;
		}
		else 
		{	
			throw new NoSuchElementError(this + " next method failed.") ;
		}
	}
	
    /**
     * Returns the next index value of the iterator.
     * @return the next index value of the iterator.
     */
	public function nextIndex():uint 
	{
		return _key ;
	}

    /**
     * Returns the previous element in the collection.
     * @return the previous element in the collection.
     */
	public function previous():*
	{
		checkForComodification() ;
		try 
		{
			var i:Number = _key - 1 ;
			var prev:* = _list.get(i) ;
			_listast = _key  = i ;
			return prev ;
		}
		catch( e:RangeError ) 
		{
			checkForComodification();
			throw new NoSuchElementError(this + " previous method failed.") ;
		}
	}

    /**
     * Returns the previous index value of the iterator.
     * @return the previous index value of the iterator.
     */
	public function previousIndex():int 
	{
		return _key - 1 ;
	}

    /**
     * Removes from the underlying collection the last element returned by the iterator (optional operation).
     */
	public function remove():*
	{
		if (_listast == -1) throw new IllegalStateError() ;
		checkForComodification() ;
		try {
			_list.removeAt(_listast) ;
			if (_listast < _key) _key -- ;
			_listast = -1 ;
			_expectedModCount = AbstractList(_list).getModCount() ;
		} 
		catch (e:ConcurrentModificationError) 
		{
			throw new ConcurrentModificationError( this + " remove method failed.") ;
		}
	}	

    /**
     * Reset the internal pointer of the iterator (optional operation).
     */
	public function reset():void 
	{
		_key = 0 ;
	}

    /**
     * Change the position of the internal pointer of the iterator (optional operation).
     */
	public function seek(position:*):void 
	{
		_key = Mathematics.clamp(position, 0, _list.size()) ;
		_listast = _key - 1 ;
	}
    
    /**
     * Sets the last element returned by the iterator.
     */
	public function set(o:*):void
	{
		if (_listast == -1) throw new IllegalStateError() ;
		checkForComodification() ;
		try 
		{
			_list.setAt(_listast, o) ;
			_expectedModCount = AbstractList(_list).getModCount() ;
		}
		catch (e:ConcurrentModificationError) 
		{
			throw e ;
		}
	}
	
    /**
     * @private
     */
    private var _expectedModCount:Number ;	

    /**
     * @private
     */
    private var _key:uint ;
    
    /**
     * @private
     */
	private var _list:List ;

    /**
     * @private
     */
	private var _listast:int ;


}