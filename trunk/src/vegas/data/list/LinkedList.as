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
    import system.Equatable;
    
    import vegas.core.CoreObject;
    import vegas.data.Collection;
    import vegas.data.List;
    import vegas.data.Queue;
    import vegas.data.collections.CollectionFormat;
    import vegas.data.collections.SimpleCollection;
    import vegas.data.iterator.Iterator;
    import vegas.data.iterator.ListIterator;
    import vegas.errors.NoSuchElementError;
    import vegas.util.Copier;
    import vegas.util.Serializer;    

    /**
     * Linked list implementation of the List and Queue interface. 
     * <p>Implements all optional list operations, and permits all elements (including null).</p>
     * <p>In addition to implementing the List interface, the <code class="prettyprint">LinkedList</code> class provides uniformly named methods to get, remove and insert an element at the beginning and end of the list.</p>
     * <p>These operations allow linked lists to be used as a stack, queue, etc.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.data.Collection ;
     * import vegas.data.collections.SimpleCollection ;
     * import vegas.data.list.LinkedList;
     * import vegas.data.iterator.ListIterator;
     * import vegas.data.map.SortedArrayMap;
     * import vegas.events.*;
     * import vegas.util.comparators.*;
     * 
     * var c1:Collection = new SimpleCollection() ;
     * c1.insert("item0") ;
     * c1.insert("item1") ;
     * c1.insert("item2") ;
     * 
     * trace("c1 : " + c1) ;
     * 
     * var c2:Collection = new SimpleCollection() ;
     * c2.insert("item3") ;
     * c2.insert("item4") ;
     * c2.insert("item5") ;
     * c2.insert("item6") ;
     * 
     * trace("c2 : " + c2) ;
     * 
     * var list:LinkedList = new LinkedList( c1 ) ;
     * trace(list) ;
     * 
     * trace ("-----") ;
     * 
     * trace ("create list : " + list) ;
     * trace ("list toSource : " + list.toSource()) ;
     * 
     * trace ("-----") ;
     * 
     * trace("list.contains('item1') : " + list.contains("item1") ) ;
     * trace("list.contains('item10') : " + list.contains("item10") ) ;
     * 
     * trace ("-----") ;
     * 
     * list.insertAt(2,'test')
     * trace("list.insertAt(2,'test')" + list ) ;
     * 
     * trace ("-----") ;
     * 
     * list.insertAll( c2 ) ;
     * trace("list.insertAll( c2 )" + list ) ;
     * 
     * trace ("-----") ;
     * 
     * list.remove("item2") ;
     * trace ("list.remove('item4') : " + list) ;
     * 
     * list.removeAt(2) ;
     * trace ("list.removeAt(2) : " + list) ;
     * 
     * list.removeFirst() ;
     * trace ("list.removeFirst() : " + list) ;
     * 
     * list.removeLast() ;
     * trace ("list.removeLast() : " + list) ;
     * 
     * trace ("-----") ;
     * 
     * list.removesAt(1, 2) ;
     * trace ("list.removesAt(1,2) : " + list) ;
     * 
     * try
     * {
     *     list.removesAt(10, 1) ;
     * }
     * catch(e:Error)
     * {
     *     trace("list.removesAt(10,1) : " + e) ;
     * }
     * 
     * trace ("-----") ;
     * 
     * list.insert("item6") ;
     * list.insert("item7") ;
     * list.insert("item8") ;
     * list.insert("item9") ;
     * list.insert("item10") ;
     * list.insert("item11") ;
     * 
     * list.removeRange(1, 3) ;
     * trace ("list.removeRange(1,3) : " + list) ;
     * 
     * try
     * {
     *     list.removeRange(4,1) ;
     * }
     * catch(e:Error)
     * {
     *     trace("list.removeRange(4,1) : " + e) ;
     * }
     * 
     * trace ("-----") ;
     * 
     * list.insertAllAt(0, c2) ;
     * trace ("list.insertAllAt(0, c2) : " + list) ;
     * 
     * trace ("--- ListIterator") ;
     * 
     * var it:ListIterator ;
     * 
     * it = list.listIterator() ;
     * var i:uint = 0 ;
     * while (it.hasNext())
     * {
     *     it.next() ;
     *     it.set("element" + i++) ;
     * }
     * trace ("list after set : " + list) ;
     * 
     * trace ("---") ;
     * 
     * it = list.listIterator( list.size() ) ;
     * while(it.hasPrevious())
     * {
     *     trace (it.previous()) ;
     * }
     * 
     * trace ("-----") ;
     * 
     * list.insertFirst("begin") ;
     * trace ("list.insertFirst('begin') : " + list) ;
     *  
     * list.insertLast("end") ;
     * trace ("list.insertLast('end') : " + list) ;
     * 
     * trace ("list.getFirst() : " + list.getFirst()) ;
     * trace ("list.getLast() : " + list.getLast()) ;
     * 
     * list.removeFirst() ;
     * trace ("list.removeFirst() : " + list) ;
     * 
     * list.removeLast() ;
     * trace ("list.removeLast() : " + list) ;
     * 
     * trace ("---- clear") ;
     * 
     * list.clear() ;
     * 
     * trace("list.size() : " + list.size()) ;
     * trace("list.isEmpty : " + list.isEmpty() ) ;
     * </pre>
     * @author eKameleon
     */
    public class LinkedList extends CoreObject implements List, Queue
    {
        
        /**
         * Creates a new LinkedList instance.
         * <p><b>Usage :</b></p>
         * <pre class="prettyprint>
         * var list:LinkedList = new LinkedList() ;
         * </pre>
         * @param c The optional Collection used to fill and initialize this LinkedList instance.
         */
        public function LinkedList( c:Collection = null )
        {
           _header = new LinkedListEntry( null, null, null ) ;
           _header.next = _header.previous = _header ;
           if ( c != null && c.size() > 0 )
           {
                insertAll( c ) ;
           }
        }
        
        /**
         * Removes all of the elements from this queue (optional operation).
         */
        public function clear():void
        {
            var e:LinkedListEntry = _header.next;
            var next:LinkedListEntry ;
            while (e != _header) 
            {
                next = e.next ;
                e.next = e.previous = null ;
                e.element = null ;
                e = next ;
            }
            _header.next = _header.previous = _header ;
            _size = 0 ;
            _modCount++ ;
        }
    
        /**
         * Returns the shallow copy of this LinkedList.
         * @return the shallow copy of this LinkedList.
         */
        public function clone():*
        {
            var list:LinkedList = new LinkedList() ;
            for ( var e:LinkedListEntry = _header.next ; e != _header ; e = e.next )
            {
                list.insert(e.element) ;
            }
            return list ;    
        }

        /**
         * Returns <code class="prettyprint">true</code> if this list contains the specified element.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * trace(list.contains( "item1" ) ; // output : true
         * </pre>
         * @param o element whose presence in this list is to be tested.
         * @return <code class="prettyprint">true</code> if this list contains the specified element.
         */
        public function contains( o:* ):Boolean
        {
            return indexOf(o) != -1 ;
        }

        /**
         * Returns <code class="prettyprint">true</code> if this collection contains the specified element.
         * @return <code class="prettyprint">true</code> if this collection contains the specified element.
         */
        public function containsAll(c : Collection):Boolean 
        {
            var it:Iterator = c.iterator() ;
            while(it.hasNext())
            {
                if ( ! contains( it.next() ) )
                {
                    return false ;    
                }     
            }
            return true ;
        }

        /**
         * Returns the deep copy of this LinkedList.
         * @return the deep copy of this LinkedList.
         */
        public function copy():*
        {
            var list:LinkedList = new LinkedList() ;
            var e:LinkedListEntry ;
            for ( e = _header.next ; e != _header ; e = e.next )
            {
                list.insert( Copier.copy(e.element) ) ;
            }
            return list ;    
        }
    
        /**
         * Retrieves and removes the head of this queue.
         * @return <code class="prettyprint">true</code> if the head of the queue is remove.
         */
        public function dequeue():Boolean 
        {
            if ( _size == 0 )
            {
                return false ;
            }
            return removeFirst() != null ;
        }

        /**
         * Retrieves, but does not remove, the head (first element) of this list.
         * @return the head of this queue.
         * @throws NoSuchElementException if this queue is empty.
         */
        public function element():* 
        {
            return getFirst();
        }
        
        /**
         * Adds the specified element as the tail (last element) of this list.
         * @param o the element to add.
         * @return <code class="prettyprint">true</code> if the element in inserted in the list.
         */
        public function enqueue(o:*):Boolean 
        {
            return insert(o);
        }

        /**
         * Indicates whether some other object is "equal to" this one.
         */
        public function equals( o:* ):Boolean 
        {
            
            if (o == null)
            {
                return false ;
            }
            if ( ! o is LinkedList )
            {
                return false ;
            }
            else
            {
                if ( (o as LinkedList).size() != size())
                {
                    return false ;    
                } 
            
                var i1:Iterator = iterator() ;
                var i2:Iterator = (o as LinkedList).iterator() ;
            
                while( i1.hasNext() )
                {
                    if (i1.next() != i2.next()) 
                    {
                        return false ;
                    }    
                }
                return true ;
            }
        }

        /**
         * Returns the element at the specified position in this list.
         * @param index index of element to return.
         * @return the element at the specified position in this list.  
         * @throws IndexOutOfBoundsException if the specified index is out of range.
         */
        public function get( key :* ) :*
        {
            var i:ListIterator = listIterator( key ) ;
            try 
            {
                return( i.next() ) ;
            } 
            catch( e:NoSuchElementError ) 
            {
                throw new RangeError("LinkedList 'get' method failed, index:" + key ) ;
            }
        }
        
        /**
         * Returns the first element in this list.
         * @return the first element in this list.
         * @throws NoSuchElementException if this list is empty.
         */
        public function getFirst():*
        {
            if (_size == 0)
            {
                throw new NoSuchElementError("LinkedList getFirstList method failed, the list is empty.") ;    
            }
            return _header.next.element ;
        }
        
           /**
         * Returns the header entry of this list.
         * @return the header entry of this list.
         */
        public function getHeader():LinkedListEntry
        {
            return _header ;    
        }

        /**
         * Returns the last element in the list.
         * @return the last element in the list.
         * @throws NoSuchElementException if this list is empty.
         */
        public function getLast():*
        {
            if (_size == 0)
            {
                throw new NoSuchElementError("LinkedList getLast method failed, the list is empty.") ;        
            }
            return _header.previous.element ;
        }
    
        /**
         * This method is used by the <code class="prettyprint">LinkedListIterator</code> class only.
         */
        public function getModCount():uint
        {
            return _modCount ;    
        }
        
           /**
         * Returns the position of the passed object in the collection.
         * @param o the object to search in the collection.
         * @param fromIndex the index to begin the search in the collection.
         * @return the index of the object or -1 if the object isn't find in the collection.
         */
        public function indexOf(o:*, fromIndex:uint=0):int
        {
            var index:int = 0 ;
            var e:LinkedListEntry ;
            if ( o == null ) 
            {
                for ( e = _header.next ; e != _header ; e = e.next) 
                {
                    if ( e.element == null )
                    {
                        return index ;
                    }
                    index++ ;
                }
            } 
            else 
            {
                for ( e = _header.next ; e != _header ; e = e.next ) 
                {
                    if (o is Equatable)
                    {
                        if ( (o as Equatable).equals(e.element))
                        {
                            return index;
                        }
                    }
                    else
                    {
                        if (o == e.element)
                        {
                            return index ;    
                        }
                    }    
                    index++ ;
                }
            }
            return -1 ;
        }
        
        /**
         * Appends the specified element to the end of this list.
         * @param o element to be appended to this list.
         * @return <code class="prettyprint">true</code> (as per the general contract of <code class="prettyprint">Collection.insert</code>).
         */
        public function insert( o:* ):Boolean
        {
            insertBefore( o, _header ) ;
            return true ;
        }
        
        /**
         * Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator.
         * The behavior of this operation is undefined if the specified collection is modified while the operation is in progress.  
         * (This implies that the behavior of this call is undefined if the specified Collection is this list, and this list is nonempty.)
         * @param c the elements to be inserted into this list.
         * @return <code class="prettyprint">true</code> if this list changed as a result of the call.
         * @throws NullPointerException if the specified collection is null.
         */
        public function insertAll( c:Collection ):Boolean
        {
            return insertAllAt( _size , c ) ;    
        }
        
        /**
         * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
         * @param index the index to insert the new elements from the specified Collection.
         * @param c the collection of elements to insert in the List.
         */
        public function insertAllAt( index:uint , c:Collection ):Boolean
        {
            if ( index > _size)
            {
                throw new RangeError("LinkedList insertAllAt method failed, index:"+index+ ", size: " + _size + "." ) ;
            }
            
            if ( c == null )
            {
                return false ;
            }
            
            var a:Array = c.toArray() ;
            
            if ( a == null )
            {
                return false ;
            }
            
            var l:Number = a.length ;
            
            if (l == 0)
            {
                return false;
            }
                    
            _modCount ++ ;
            
            var successor:LinkedListEntry = (index == _size) ? _header : _entry(index) ;
            var predecessor:LinkedListEntry = successor.previous ;
            
            var e:LinkedListEntry ;
            
            for ( var i:Number = 0 ; i < l ; i++) 
            {
                e = new LinkedListEntry( a[i] , successor, predecessor ) ;
                predecessor.next = e ;
                predecessor = e ;
            }
            
            successor.previous = predecessor ;
            
            _size += l ;
            
            return true;
        }
        
        /**
         * Inserts the specified element at the specified position in this list (optional operation).
         * @param id index at which the specified element is to be inserted.
         * @param o element to be inserted.
         */
        public function insertAt( id:uint , o:* ):void 
        {
            var i:ListIterator = listIterator(id) ;
            i.insert(o);
        }
            
        /**
         * Inserts the given element in the list before the given entry.
         * This method is "protected" only the LinkedList and the LinkedListIterator must use this method.
         * @param o the element to be inserted at the beginning of this list.
         * @param e the entry instance to defined where inserted the element.
         * @private
         */
        public function insertBefore( o:* , e:LinkedListEntry ):LinkedListEntry
        {
            var newEntry:LinkedListEntry = new LinkedListEntry( o, e, e.previous ) ;
            newEntry.previous.next = newEntry ;
            newEntry.next.previous = newEntry ;
            _size ++ ;
            _modCount ++ ;
            return newEntry ;
        }        
        
        /**
         * Inserts the given element at the beginning of this list.
         * @param o the element to be inserted at the beginning of this list.
         */
        public function insertFirst( o:* ):void
        {
            insertBefore( o, _header.next ) ;    
        }

        /**
         * Appends the given element to the end of this list.  
         * @param o the element to be inserted at the end of this list.
         */
        public function insertLast( o:* ):void
        {
            insertBefore(o , _header) ;    
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this queue contains no elements.
         * @return <code class="prettyprint">true</code> if this queue is empty else <code class="prettyprint">false</code>.
         */
        public function isEmpty():Boolean 
        {
            return _size == 0 ;    
        }
        
       /**
        * Returns the iterator of this object.
        * @return the iterator of this object.
        */
        public function iterator():Iterator 
        {
            return listIterator(0) ;
        }
        
        /**
         * Returns the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
         * @param o element to search for.
         * @return the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
         */
        public function lastIndexOf( o:* ):int 
        {
            var index:Number = _size ;
            var e:LinkedListEntry ;
            if ( o == null ) 
            {
                for ( e = _header.previous ; e != _header ; e = e.previous) 
                {
                    index--;
                    if ( e.element == null )
                    {
                        return index ;
                    }
                }
            } 
            else 
            {
                for ( e = _header.previous ; e != _header ; e = e.previous ) 
                {
                    index-- ;
                    if (o is Equatable)
                    {
                        if ( (o as Equatable).equals(e.element) )
                        {
                            return index;
                        }
                    }
                    else
                    {
                        if (o == e.element)
                        {
                            return index ;
                        }    
                    }
                }
            }
            return -1 ;
        }
        
        /**
         * Returns a list iterator of the elements in this list (in proper sequence).
         * @return a list iterator of the elements in this list (in proper sequence).
         */
        public function listIterator( position:uint=0 ):ListIterator
        {
            return new LinkedListIterator( position , this ) ;
        }
        
        /**
         * Retrieves, but does not remove, the head (first element) of this list.
         * @return the head of this queue, or <code class="prettyprint">null</code> if this queue is empty.
         */
        public function peek():* 
        {
            if ( _size == 0 )
            {
                return null;
            }
            return getFirst() ;
        }

        /**
         * Retrieves and removes the head (first element) of this list.
         * @return the head of this queue, or <code class="prettyprint">null</code> if this queue is empty.
         */
        public function poll():* 
        {
            if ( _size == 0 )
            {
                return null;
            }
            return removeFirst() ;
        }
        
        /**
         * Removes the first occurrence of the specified element in this list.  
         * If the list does not contain the element, it is unchanged.
         * @param o element to be removed from this list, if present.
         * @return <tt>true</tt> if the list contained the specified element.
         */
        public function remove(o:*):* 
        {
            var e:LinkedListEntry ;
            if ( o == null ) 
            {
                for ( e = _header.next ; e != _header ; e = e.next ) 
                {
                    if ( e.element == null ) 
                    {
                        removeEntry(e) ;
                        return true;
                    }
                }
            } 
            else 
            {
                for ( e = _header.next ; e != _header ; e = e.next ) 
                {
                    if ( o is Equatable )
                    {
                        if ( (o as Equatable).equals( e.element ) ) 
                        {
                            removeEntry(e);
                            return true;
                        }
                    }
                    else 
                    {     
                        if ( o == e.element ) 
                        {
                            removeEntry(e);
                            return true;
                        }
                    }
                }
            }
            return false;
        }
        
        /**
         * Removes all elements defined in the specified Collection in the list.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import vegas.data.collections.SimpleCollection ;
         * import vegas.data.list.LinkedList ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * trace(list.removeAll(new SimpleCollection(["item1"])) ; // true
         * trace(list) ; // {item2}
         * </code>
         * @return <code class="prettyprint">true</code> if all elements are find and remove in the list.
         */
        public function removeAll( c:Collection ):Boolean 
        {
            if (c.size() > 0)
            {
                var b:Boolean ;
                var result:Boolean = true ;
                var i:Iterator = c.iterator() ;
                while( i.hasNext() )
                {
                    b = remove( i.next()) ;
                    if ( b = false )
                    {
                        result = false ;
                    }
                }
                return result ;
            }
            else
            {
                return false ;    
            }
        }

        /**
         * Removes an element at the specified position in this list. 
         * This implementation first gets a list iterator pointing to the indexed element (with <code class="prettyprint">listIterator(index)</code>). 
         * Then, it removes the element with <b>ListIterator</b> remove method.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * trace(list.removeAt(1)) ; // item2
         * trace(list) ; // {item1}
         * </pre>
         * @param id index of the element to be removed from the List.
         * @return the value removed in the list.
         */
        public function removeAt(id:uint):* 
        {
            return removeEntry( _entry(id) ) ;
        }
                
        /**
         * Removes an Entry in the list.
         */
        public function removeEntry( e:LinkedListEntry ):*
        {
            if ( e == _header )
            {
                throw new NoSuchElementError(this + " removeEntry method failed.");
            }
            var result:* = e.element ;
            e.previous.next = e.next;
            e.next.previous = e.previous;
            e.next = e.previous = null ;
            e.element = null ;
            _size-- ;
            _modCount++ ;
            return result ;
        }    
    
        /**
         * Removes and returns the first element from this list.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * list.insert("item3") ;
         * list.insert("item4") ;
         * var result = list.removeFirst() ;
         * trace(result + " : " + list) ; // item1 : {item2,item3,item4}
         * </pre>
         * @return the first element from this list.
         * @throws NoSuchElementException if this list is empty.
         */
        public function removeFirst():*
        {
            return removeEntry( _header.next );
        }
        
        /**
         * Removes and returns the last element from this list.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * list.insert("item3") ;
         * list.insert("item4") ;
         * var result = list.removeLast() ;
         * trace(result + " : " + list) ; // item4 : {item1,item2,item3}
         * </pre>
         * @return the last element from this list.
         * @throws NoSuchElementException if this list is empty.
         */
        public function removeLast():*
        {
            return removeEntry( _header.previous );
        }
        
        /**
         * Removes from this list all the elements that are contained between the specific <code class="prettyprint">from</code> and the specific <code class="prettyprint">to</code> position in this list (optional operation).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * list.insert("item3") ;
         * list.insert("item4") ;
         * list.insert("item5") ;
         * list.removeRange(2, 4) ; 
         * trace(list) ; // {item1,item2,item5}
         * </pre>
         * @throws ArgumentError if the 'from' or 'to' argument is NaN.
         * @throws RangeError if the 'to' > 'from'
         */
        public function removeRange( from:uint, to:uint ):void 
        {
            if ( from >= _size )
            {
                throw new RangeError( this + " removeRange failed with a from value out of bounds, from > size().") ;
            }            
            if ( to < from )
            {
                throw new RangeError( this + " removeRange failed if the to > from value.") ;
            }
            else if (from == to)
            {
                removeAt(from) ;
            } 
            else
            {
                var it:ListIterator = listIterator( from ) ;
                var l:Number = to - from ;
                for (var i:Number = 0 ; i<l ; i++) 
                {
                    it.next() ; 
                    it.remove() ;
                }    
            }
        }
        
        /**
         * Removes the specified count of elements at the specified position in this list.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * list.insert("item3") ;
         * list.insert("item4") ;
         * list.insert("item5") ;
         * var result = list.removesAt(2, 2) ; // {item1,item2,item5}
         * trace(result + " : " + list) ; // item1 : {item2,item3,item4}
         * </pre>
         * @param  id index of the first element to be removed from the List.
         */
        public function removesAt( id:uint , len:uint ):* 
        {
            return removeRange( id , id + len ) ;
        }        
    
        /**
         * Retains only the elements in this list that are contained in the specified collection (optional operation).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.collections.SimpleCollection ;
         * import vegas.data.list.LinkedList ;
         * 
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * list.insert("item3") ;
         * list.insert("item4") ;
         * list.insert("item5") ;
         * var c:SimpleCollection = new SimpleCollection( ["item2", "item4"] ) ;
         * var b:Boolean = list.retainAll( c ) ;
         * trace("list : " + list + ", is retain ? : " + b) ;
         * </pre>
         * @return <code class="prettyprint">true</code> if the retainAll operation is success.
         */
        public function retainAll(c : Collection):Boolean 
        {
            var it:Iterator = iterator() ;
            while(it.hasNext())
            {
                var next:* = it.next() ;
                if ( !c.contains( next ) )
                {
                    it.remove() ;
                } 
            }
            return c.size() == size() ;
        }
        
        /**
         * Replaces the element at the specified position in this list with the specified element.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * var old:* = list.setAt( 1, "ITEM2" ) ;
         * trace("list : " + list + ", old : " + old) ; // list : {item1,ITEM2}, old : item2
         * </pre>
         * @param id index of element to replace.
         * @param o element to be stored at the specified position.
         * @return the element previously at the specified position.
         */
        public function setAt(id:uint, o:*):*
        {
            var i:ListIterator = listIterator(id) ;
            try 
            {
                var old:* = i.next() ;
                i.set(o) ;
                return old ;
            }
            catch( e:NoSuchElementError ) 
            {
                throw new RangeError("LinkedList setAt method failed, index:" + id ) ;
            }
        }
        
        /**
         * Returns the number of elements in this list.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * trace(list.size()) ; // 2
         * </pre>
         * @return the number of elements in this list.
         */
        public function size():uint
        {
            return _size ;    
        }
    
        /**
         * Returns a subList of the LinkedList. The subList is an ArrayList instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * 
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * list.insert("item3") ;
         * list.insert("item4") ;
         * list.insert("item5") ;
         * 
         * trace( list.subList(2, 10) ) ; // {item3,item4,item5}
         * trace( list.subList(2, -1) ) ; // {}
         * trace( list.subList(2, 3) ) ; // {item3}
         * trace( list.subList() ) ; // {item1,item2,item3,item4,item5}
         * </pre>
         * @return a subList of the LinkedList. The subList is an ArrayList instance.
         * @see LinkedList
         */
        public function subList(fromIndex:uint, toIndex:uint) : List 
        {
            if ( isNaN(fromIndex) )
            {
                return clone() ;    
            }
            if (toIndex < fromIndex)
            {
                toIndex = fromIndex ;
            }
            else if (toIndex > size())
            {
                toIndex = size() ;    
            }
            var l:List = new LinkedList() ;
            var it:ListIterator = listIterator(fromIndex) ;
            var d:Number = (toIndex - fromIndex) + 1 ; 
            for (var i:Number = fromIndex ; i<= d ; i++) 
            {
                l.insert( it.next() ) ;
            }
            return l ;
        }
    
       /**
        * Returns an array containing all of the elements in this list in the correct order.
        * <p><b>Example :</b></p>
        * <pre class="prettyprint">
        * import vegas.data.list.LinkedList ;
        * var list:LinkedList = new LinkedList() ;
        * list.insert("item1") ;
        * list.insert("item2") ;
        * list.insert("item3") ;
        * list.insert("item4") ;
        * trace( list.toArray() ) ; // item1,item2,item3,item4
        * </pre>
        * @return an array containing all of the elements in this list in the correct order.
        */
        public function toArray():Array 
        {
            var ar:Array = new Array( _size ) ;
            var i:Number = 0 ;
            var e:LinkedListEntry ;
            for ( e = _header.next ; e != _header ; e = e.next )
            {
                ar[i++] = e.element ;
            }
            return ar ;
        }
    
           /**
         * Returns a eden representation of the object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var list:LinkedList = list.clone() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * var source:String = list.toSource() ; 
         * trace(source) ; // new vegas.data.list.LinkedList(new vegas.data.collections.SimpleCollection(["item1","item2"]))
         * </pre>
         * @return a string representing the source code of the object.
         */
        public override function toSource( indent:int = 0 ):String  
        {
            return Serializer.getSourceOf(this, [ new SimpleCollection(toArray()) ]) ;
        }
    
        /**
         * Returns the String representation of this object
         * @return the String representation of this object
         */
        public override function toString():String
        {
            return (new CollectionFormat()).formatToString(this) ;
        }

        /**
         * Returns the indexed entry.
         * @return the indexed entry.
         */
        private function _entry( index:uint ):LinkedListEntry
        {
            if ( index >= _size)
            {
                throw new RangeError("LinkedList private '_entry' method failed, index:" + index + ", size:" + _size + "." ) ;
            }
            var e:LinkedListEntry = _header ;
            var i:Number ;
            if ( index < (_size >> 1))
            {
                for ( i = 0 ; i<= index ; i++ )
                {
                    e = e.next ;
                }
            }
            else
            {
                for ( i = _size ; i > index ; i-- )
                {
                    e = e.previous ;    
                }
            }
            return e ;
        }
            
        /**
         * The internal header of this list.
         */
        private var _header:LinkedListEntry ;
    
        /**
         * The mod count value used by the LinkedListIterator.
         */
        private var _modCount:uint = 0 ;
    
        /**
         * The internal size of the list.
         */
        private var _size:uint = 0 ;
    }
}

import vegas.core.CoreObject;
import vegas.data.iterator.ListIterator;
import vegas.data.list.LinkedList;
import vegas.data.list.LinkedListEntry;
import vegas.errors.ClassCastError;
import vegas.errors.ConcurrentModificationError;
import vegas.errors.IllegalStateError;
import vegas.errors.NoSuchElementError;
import vegas.errors.UnsupportedOperation;

/**
 * Converts a <code class="prettyprint">LinkedList</code> to a specific <code class="prettyprint">ListIterator</code>.
 * <p><b>Example :</b></p>
 * <pre class="prettyprint">
 * import vegas.data.iterator.LinkedListIterator ;
 * import vegas.data.list.LinkedList ;
 * 
 * var list:LinkedList = new LinkedList() ;
 * list.insert("item1") ;
 * list.insert("item2") ;
 * list.insert("item3") ;
 * var it:LinkedListIterator = LinkedListIterator( list.listIterator(2) ) ;
 * trace(it.hasPrevious() + " : " + it.previous()) ; // true : item2
 * </pre>
 * @author eKameleon
 */
class LinkedListIterator extends CoreObject implements ListIterator
{

    /**
     * Creates a new LinkedListIterator instance.
     * @param index The position of the internal pointer of this Iterator
     * @param list The owner LinkedList of this iterator.
     */
    function LinkedListIterator( index:int , list:LinkedList )
    {
        this._list = list ;
        seek(index) ;
    }

    /**
     * This method check the comodification of the LinkedList and test if the iterator is valid and can continue to process.
     */
    public function checkForComodification():void 
    {
        if ( this._list.getModCount() != this._expectedModCount )
        {
            throw new ConcurrentModificationError(this + " check for comodification failed with a LinkedList." ) ;
        }
    }

    /**
     * Returns <code class="prettyprint">true</code> if the iteration has more elements.
     * @return <code class="prettyprint">true</code> if the iteration has more elements.
     */    
    public function hasNext():Boolean 
    {
        return this._nextIndex != this._list.size() ;
    }

    /**
     * Checks to see if there is a previous element that can be iterated to.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var list:LinkedList = new LinkedList() ;
     * list.insert("item1") ;
     * list.insert("item2") ;
     * list.insert("item3") ;
     * var it:ListIterator = list.listIterator(2) ;
     * trace( it.hasPrevious() ) ;
     * </pre>
     */
    public function hasPrevious():Boolean 
    {
         return this._nextIndex != 0 ;
    }

    /**
     * Inserts the specified element into the list (optional operation).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var list:LinkedList = new LinkedList() ;
     * list.insert("item1") ;
     * list.insert("item2") ;
     * list.insert("item3") ;
     * 
     * var it:ListIterator = list.listIterator(1) ;
     * it.insert("item0") ;
     * 
     * trace(list) ;
     * </pre>
     * <p><b>Attention :</b> Dont' use this method in a loop with hasPrevious() and previous() method.</p> 
     */
    public function insert( o:* ):void 
    {
        this.checkForComodification();
        this._lastReturned = this._list.getHeader() ;
        this._list.insertBefore(o, this._next) ;
        this._nextIndex ++ ;
        this._expectedModCount ++ ;
    }

    /**
     * Unsupported operation in this iterator, uses nextIndex() and previousIndex() method.
     * @throws UnsupportedOperation if the user call this method, this method is unsupported.
     */
    public function key():* 
    {
        throw new UnsupportedOperation(this + " 'key' method is unsupported.") ;
        return null ;
    }

    /**
     * Returns the next element in the iteration.
     * @return the next element in the iteration.
     */
    public function next():*
    {
        this.checkForComodification();
        
        if ( this._nextIndex == this._list.size() )
        {
            throw new NoSuchElementError(this + " 'next' method failed.");
        }

        this._lastReturned = this._next ;
        this. _next = this._next.next ;
        this._nextIndex ++ ;
        
        return this._lastReturned.element ;
    }

    /**
     * Returns the index of the element that would be returned by a subsequent call to next.
     * @return the index of the element that would be returned by a subsequent call to next.
     */
    public function nextIndex():uint 
    {
        return this._nextIndex ; 
    }

    /**
     * Returns the previous element in the collection.
     * @return the previous element in the collection.
     */
    public function previous():* 
    {
        if (this._nextIndex == 0)
        {
            throw new NoSuchElementError(this + " 'previous' method failed.");
        }

           this._lastReturned = this._next = this._next.previous ;
        this._nextIndex-- ;
        this.checkForComodification();
        return this._lastReturned.element ;
    }

    /**
     * Returns the index of the element that would be returned by a subsequent call to previous.
     * @return the index of the element that would be returned by a subsequent call to previous.
     */
    public function previousIndex():int 
    {
        return this._nextIndex - 1 ;
    }

    /**
     * Removes from the underlying collection the last element returned by the iterator (optional operation).
     */
    public function remove():* 
    {
        this.checkForComodification() ;
        var lastNext:LinkedListEntry = this._lastReturned.next;
        try 
        {
           this._list.removeEntry( this._lastReturned ) ;
        }
        catch ( e:NoSuchElementError ) 
        {
            throw new IllegalStateError( this + " 'remove' method failed.") ;
        }
        if ( this._next == this._lastReturned)
        {
            this._next = lastNext ;
        }
        else
        {
            this._nextIndex-- ;
        }
        this._lastReturned = this._list.getHeader() ;
        this._expectedModCount++;
    }

    /**
     * Reset the internal pointer of the iterator (optional operation).
     */
    public function reset():void 
    {
        seek(0) ;
    }

    /**
     * Change the position of the internal pointer of the iterator (optional operation).
     */
    public function seek( position:* ):void 
    {

        this._lastReturned = this._list.getHeader() ;
        
        this._expectedModCount = this._list.getModCount() ;

        var size:Number = _list.size() ;
        
        if ( !( position is Number) )
        {
            throw new ClassCastError(this + " seek failed with a not uint position argument.") ;
        } 
        
        if (position < 0 || position > size)
        {
            throw new RangeError( this + " seek failed, index:" + position + ", size:" + size + "." ) ;
        }
        
        if ( position < ( size >> 1 ) ) 
        {
            
            _next = _list.getHeader().next ;
            
            for ( _nextIndex = 0 ; _nextIndex < position ; _nextIndex ++ )
            {
                _next = _next.next ;
            }
        } 
        else 
        {
            _next = _list.getHeader()  ;
            for ( _nextIndex = size ; _nextIndex > position ; _nextIndex-- )
            {
                _next = _next.previous ;
            }
        }
    }

    /**
     * Replaces the last element returned by next or previous with the specified element (optional operation).
     */
    public function set( o:* ):void 
    {
        
        if (_lastReturned == _list.getHeader())
        {
            throw new IllegalStateError(this + " 'set' method failed.");
        }
        
        this.checkForComodification();
        this._lastReturned.element = o ;
        
    }

    /**
     * The last list entry returned.
     */
    private var _lastReturned:LinkedListEntry = null ;
    
    /**
     * The list reference of this iterator.
     */
    private var _list:LinkedList = null ;
    
    /**
     * The next entry.
     */
    private var _next:LinkedListEntry = null ;
    
    /**
     * The next index in the iterator.
     */
    private var _nextIndex:Number ;
    
    /**
     * The internal expected mod count value.
     */
    private var _expectedModCount:uint ;

}