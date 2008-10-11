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
	import vegas.core.IComparator;
	import vegas.core.IComparer;
	import vegas.data.Collection;
	import vegas.util.Copier;
	import vegas.util.Serializer;    

	/**
     * A SortedArrayList stores is elements in order with a IComparator object.
     * @author eKameleon
     */
	public class SortedArrayList extends ArrayList implements IComparer
	{

    	/**
    	 * Creates a new SortedArrayList instance. 
    	 */
		public function SortedArrayList(init:* = null , comp:IComparator=null, opt:uint=0)
		{
			super(init);
			comparator = comp ;
			options = opt ;
		}

    	/**
    	 * (read-only) The IComparator instance of this object.
    	 */
		public function get comparator():IComparator 
		{
			return _comparator ;
		}
		
		/**
    	 * (read-only) The IComparator instance of this object.
    	 */
		public function set comparator(comp:IComparator):void 
		{
			_comparator = comp ;
			_sort() ;
		}

    	/**
    	 * (read-only) Returns the options to sort the elements in the list.
    	 */
		public function get options():uint 
		{
			return _options ;
		}

    	/**
    	 * (read-only) Sets the options to sort the elements in the list.
    	 */
		public function set options(o:*):void
		{
			_options = o ;
			_sort() ;
		}

    	/**
    	 * Returns a shallow copy of the instance.
    	 * @return a shallow copy of the instance.
    	 */
		public override function clone():*
		{
			return new SortedArrayList(toArray(), comparator, options) ;
		}

    	/**
    	 * Returns a deep copy of the instance.
    	 * @return a deep copy of the instance.
    	 */
		public override function copy():*
		{
			return new SortedArrayList(Copier.copy(toArray()), Copier.copy(comparator), Copier.copy(options)) ;
		}

        /**
         * Appends the specified element to the end of this list.
         * @param o element to be appended to this list.
         * @return <code class="prettyprint">true</code> (as per the general contract of <code class="prettyprint">Collection.insert</code>).
         */
		public override function insert(o:*):Boolean 
		{
			var b:Boolean = super.insert(o) ;
			_sort() ;
			return b ;
		}	

        /**
         * Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator.
         * @param c the elements to be inserted into this list.
         * @return <code class="prettyprint">true</code> if this list changed as a result of the call.
         */
		public override function insertAll(c:Collection):Boolean 
		{
			var b:Boolean = super.insertAll(c) ;
			_sort() ;
			return b ;
		}
		
    	/**
    	 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
    	 * @param index the index to insert the new elements from the specified Collection.
    	 * @param c the collection of elements to insert in the List.
    	 */
		public override function insertAllAt(id:uint, c:Collection):Boolean 
		{
			var b:Boolean = super.insertAllAt(id, c) ;
			_sort() ;
			return b ;
		}		

        /**
	     * Inserts the specified element at the specified position in this list (optional operation).
         * @param id index at which the specified element is to be inserted.
         * @param o element to be inserted.
	     */
		public override function insertAt(id:uint, o:*):void
		{
			insertAt(id, o) ;
			_sort() ;
		}

    	/**
    	 * Sorts the elements in the list.
    	 */
		public function sort( compare:* = null , opts:uint = 0 ):Array  
		{
			if ( compare == null) return null ;
			var f:Function ;
			if (compare is IComparator) 
			{
				f = (compare as IComparator).compare ;
			}
			else if (compare is Function)
			{
				f = compare ;
			}
			else
			{
				return null ;
			}
			return _a.sort(f , opts) ;
		}

    	/**
    	 * Sorts the elements in the list according to one or more fields in the array.
    	 * @param fieldName A string that identifies a field to be used as the sort value, or an array in which the first element represents the primary sort field, the second represents the secondary sort field, and so on.
    	 * @param options One or more numbers or names of defined constants, separated by the bitwise OR (|) operator, that change the sorting behavior. The following values are acceptable for the options parameter:
    	 * <p><li>Array.CASEINSENSITIVE or 1</li><li>Array.DESCENDING or 2</li><li>Array.UNIQUESORT or 4</li><li>Array.RETURNINDEXEDARRAY or 8</li><li>Array.NUMERIC or 16</li></p>
         * @return The return value depends on whether you pass any parameters : <p><li>If you specify a value of 4 or Array.UNIQUESORT for the options parameter, and two or more elements being sorted have identical sort fields, a value of 0 is returned and the array is not modified.</li><li>If you specify a value of 8 or Array.RETURNINDEXEDARRAY for the options parameter, an array is returned that reflects the results of the sort and the array is not modified.</li><li>Otherwise, nothing is returned and the array is modified to reflect the sort order.</li></p>
         */
		public function sortOn( fieldName:*, opts:* = null ):Array  
		{
			return _a.sortOn(fieldName, opts) ;
		}
	
	    /**
	     * Returns a eden representation of the object.
	     * @return a string representation the source code of the object.
	     */
		public override function toSource( indent:int = 0 ):String  
		{
			return Serializer.getSourceOf(this, [toArray(), comparator, options] ) ;
		}
		
		/**
		 * @private
		 */
		private var _comparator:IComparator ;
		
		/**
		 * @private
		 */
		private var _options:* ;

		/**
		 * @private
		 */
		private function _sort():void 
		{
			sort( _comparator.compare , _options) ;
		}

	}
}