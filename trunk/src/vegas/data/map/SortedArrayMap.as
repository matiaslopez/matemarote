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

	import vegas.core.IComparator;
	import vegas.core.IComparer;
    
	/**
	 * This ArrayMap can be sorted with an IComparator object.
	 * @author eKameleon
	 */
    public class SortedArrayMap extends ArrayMap implements IComparer
    {
        
		/**
		 * Creates a new SortedArrayMap instance.
		 */	     
        public function SortedArrayMap( ...arguments:Array )
        {
            super( arguments[0] , arguments[1] ) ;
			sortBy = SortedArrayMap.KEY ;
        }

	    /**
	     * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
		 * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
		 * <p>The value of this constant is 1.</p>
		 */
		public static const CASEINSENSITIVE:uint = 1;
	
		/**
	     * Specifies descending sorting for the Array class sorting methods. 
	 	 * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code>
	 	 * or <code class="prettyprint">sortOn()</code> method. 
 	 	 * <p>The value of this constant is 2.</p>
		 */
		public static const DESCENDING:uint = 2;

		/**
		 * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "key".
		 */
		public static const KEY:String = "key" ;
		
		/**
		 * Specifies the default numeric sorting value for the Array class sorting methods.
		 * <p>The value of this constant is 0.</p>
		 */
		public static const NONE:uint = 0;

		/**
	     * Specifies numeric (instead of character-string) sorting for the Array class sorting methods. 
	     * Including this constant in the <code class="prettyprint">options</code>
	 	 * parameter causes the <code class="prettyprint">sort()</code> and <code class="prettyprint">sortOn()</code> methods 
	 	 * to sort numbers as numeric values, not as strings of numeric characters.  
	     * Without the <code class="prettyprint">NUMERIC</code> constant, sorting treats each array element as a 
	 	 * character string and produces the results in Unicode order. 
	 	 *
     	 * <p>For example, given the array of values <code class="prettyprint">[2005, 7, 35]</code>, if the <code class="prettyprint">NUMERIC</code> 
	 	 * constant is <strong>not</strong> included in the <code class="prettyprint">options</code> parameter, the 
     	 * sorted array is <code class="prettyprint">[2005, 35, 7]</code>, but if the <code class="prettyprint">NUMERIC</code> constant <strong>is</strong> included, 
     	 * the sorted array is <code class="prettyprint">[7, 35, 2005]</code>. </p>
 	 	 * 
 	 	 * <p>This constant applies only to numbers in the array; it does 
     	 * not apply to strings that contain numeric data such as <code class="prettyprint">["23", "5"]</code>.</p>
 	 	 * 
 	 	 * <p>The value of this constant is 16.</p>
	 	 */
		public static const NUMERIC:uint = 16;
		
		/**
	 	 * Specifies that a sort returns an array that consists of array indices as a result of calling
 	 	 * the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. You can use this constant
	 	 * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> 
	 	 * method, so you have access to multiple views on the array elements while the original array is unmodified. 
	 	 * <p>The value of this constant is 8.</p>
	 	*/
		public static const RETURNINDEXEDARRAY:uint = 8;

		/**
     	 * Specifies the unique sorting requirement for the Array class sorting methods. 
	     * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
	     * The unique sorting option terminates the sort if any two elements or fields being sorted have identical values. 
		 * <p>The value of this constant is 4.</p>
		 */
		public static const UNIQUESORT:uint = 4;

		/**
		 * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "value".
		 */
		public static const VALUE:String = "value" ;
        
  		/**
		 * (read-write) Returns the IComparator instance.
		 */
		public function get comparator():IComparator 
		{
			return getComparator() ;
		}
	
		/**
		 * (read-write) Sets the IComparator instance.
		 */
		public function set comparator(comp:IComparator):void 
		{
			setComparator(comp) ;
		}
	
		/**
		 * (read-write) Returns the options to sort the elements in the list.
		 */
		public function get options():uint
		{
			return getOptions() ;
		}

		/**
		 * (read-write) Sets the options to sort the elements in the list.
	 	 */
		public function set options( o:uint ):void 
		{
			setOptions(o) ;
		}
	
		/**
		 * (read-write) Returns the options to sort the elements in the list.
		 * Returns the expression who defines if the map is sorted by "key" or "value".
		 */
		public function get sortBy():String
		{
			return _sortBy ;
		}

		/**
		 * (read-write) Sets the options to sort the elements in the list.
	 	*/
		public function set sortBy( str:String ):void 
		{
			_sortBy = ( str == SortedArrayMap.VALUE ) ? SortedArrayMap.VALUE : SortedArrayMap.KEY ;
		}

		/**
	 	 * Returns the IComparator instance.
	 	 * @return the IComparator instance.
		 */
		public function getComparator():IComparator 
		{
			return _comparator ;
		}

		/**
	 	 * Returns the options to sort the elements in the list.
	 	 * @return the options to sort the elements in the list.
	 	 */
		public function getOptions():* 
		{
			return _options ;
		}
	
		/**
	 	 * Sets the IComparator instance.
		 */
		public function setComparator(comp:IComparator):void 
		{
			_comparator = comp ;
		}

		/**
		 * Sets the options to sort the elements in the list.
		 */
		public function setOptions( o:uint=0 ):void 
		{
			_options = o ;
		}
	
		/**
		 * Sorts the elements in Map by key or value with the IComparator of this ArrayMap.
		 * <p><b>Example :</b></p>
		 * <code class="prettyprint">
		 * var map:SortedArrayMap = new SortedArrayMap() ;
	 	 * 
	 	 * map.put( "key1", "value4" ) ;
		 * map.put( "key3", "value2" ) ;
	 	 * map.put( "key4", "value3" ) ;
		 * map.put( "key2", "value1" ) ;
		 * 
		 * trace(map) ; // {key1:value4,key3:value2,key4:value3,key2:value1}
		 * 
	 	 * map.comparator = StringComparator.getStringComparator() ;
		 * 
		 * map.options = SortedArrayMap.DESCENDING ;
		 * map.sort() ;
		 * 
		 * trace(map) ; // {key4:value3,key3:value2,key2:value1,key1:value4}
		 * 
	 	 * map.options = SortedArrayMap.NONE ;
		 * map.sort() ;
		 * 
	 	 * trace(map) ; // {key1:value4,key2:value1,key3:value2,key4:value3}
	 	 * 
		 * map.sortBy = SortedArrayMap.VALUE ;
		 * 
		 * map.options = SortedArrayMap.DESCENDING ;
		 * map.sort() ;
		 * 
	 	 * trace(map) ; // {key1:value4,key4:value3,key3:value2,key2:value1}
		 * 
	 	 * map.options = SortedArrayMap.NONE ;
	 	 * map.sort() ;
	 	 * 
		 * trace(map) ; // {key2:value1,key3:value2,key4:value3,key1:value4}
		 * </code>
	 	 * @see SortedArrayMap#sortBy
	 	 */
		public function sort():void  
		{
		
			var compare:Function = _comparator.compare ;
			var max:Number = size() ;
			
			if (compare == null && !(max > 0) )
			{
				return ;	
			}

			var result:Array ;
			var clone:Array ;
			
			if ( sortBy == KEY )
			{
				result = _keys.sort( compare , _options | Array.RETURNINDEXEDARRAY ) ;
				_keys.sort( compare , _options ) ;
				clone = getValues() ;
				while ( --max > -1 )
				{
					_values[max] = clone[ result[max] ] ;
				}
			}
			else
			{
				result = _values.sort( compare , _options | Array.RETURNINDEXEDARRAY ) ;
				_values.sort( compare , _options ) ;
				clone = getKeys() ;
				while ( --max > -1 )
				{
					_keys[max] = clone[ result[max] ] ;
				}
			}
		}
	
		/**
	 	 * Sorts the elements in the list according to one or more fields in the array.
	 	 * <p><b>Example :</b></p>
	 	 * <code class="prettyprint">
	 	 * import vegas.data.iterator.Iterator ;
	 	 * import vegas.data.Map ;
	 	 * import vegas.data.map.SortedArrayMap ;
	 	 * 
	 	 * var map:SortedArrayMap = new SortedArrayMap() ;
	 	 * 
	 	 * map.put( { id:5 } , { name:'name4' } ) ;
	 	 * map.put( { id:1 } , { name:'name1' } ) ;
	 	 * map.put( { id:3 } , { name:'name5' } ) ;
	 	 * map.put( { id:2 } , { name:'name2' } ) ;
	 	 * map.put( { id:4 } , { name:'name3' } ) ;
	 	 * 
	 	 * var debug:Function = function( map:Map ):void
	 	 * {
	 	 * 
	 	 *     var vit:Iterator = map.iterator() ;
	 	 *     var kit:Iterator = map.keyIterator() ;
	 	 *     var str:String = "{" ;
	 	 * 
	 	 *     while( vit.hasNext() )
	 	 *     {
	 	 *         var value = vit.next() ;
	 	 *         var key   = kit.next() ;
	 	 *         str += key.id + ":" + value.name ;
	 	 *         if (vit.hasNext())
	 	 *         {
	 	 *             str += "," ;
	 	 *         }
	 	 *     }
	 	 *     str += "}" ;
	 	 *     trace(str) ;
	 	 * }
	 	 * 
	 	 * trace("----- original Map") ;
	 	 * 
	 	 * debug( map ) ; // {5:name4,1:name1,3:name5,2:name2,4:name3}
	 	 * 
	 	 * trace("----- sort by key with sort() method") ;
	 	 * 
	 	 * map.sortBy = SortedArrayMap.KEY ; // default
	 	 * map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
	 	 * map.sortOn("id") ;
	 	 * debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
	 	 * 
	 	 * map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
	 	 * map.sortOn("id") ;
	 	 * debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
	 	 * 
	 	 * trace("----- sort by value with sort() method") ;
	 	 * 
	 	 * map.sortBy = SortedArrayMap.VALUE ;
	 	 * map.options = SortedArrayMap.DESCENDING ;
	 	 * map.sortOn("name") ;
	 	 * debug( map ) ; // {3:name5,5:name4,4:name3,2:name2,1:name1}
	 	 * 
	 	 * map.options = SortedArrayMap.NONE ;
	 	 * map.sortOn("name") ;
	 	 * debug( map ) ; // {1:name1,2:name2,4:name3,5:name4,3:name5}
	 	 * </code>
		 * @param fieldName A string that identifies a field to be used as the sort value.
		 * @param opts (optional) The option number value to use to sort this map.
		 * @see SortedArrayMap#sortBy 
	     */
		public function sortOn( fieldName:* , opts:Number=NaN ):void 
		{
		
			var max:Number = size() ;
		
			if (fieldName == null && !(max > 0) )
			{
				return ;	
			}	
		
			if ( !isNaN(opts) )
			{
				_options = opts ;	
			}
		
			var result:Array ;
			var clone:Array ;
			
			if ( sortBy == KEY )
			{
				result = _keys.sortOn( fieldName , _options | Array.RETURNINDEXEDARRAY ) ;
				_keys.sortOn( fieldName , _options ) ;
				clone = getValues() ;
				while ( --max > -1 )
				{
					setValueAt( max , clone[ result[max] ] ) ;
				}
			}
			else
			{
				result = _values.sortOn( fieldName , _options | Array.RETURNINDEXEDARRAY ) ;
				_values.sortOn( fieldName  , _options ) ;
				clone = getKeys() ;
				while ( --max > -1 )
				{
					_keys[max] = clone[ result[max] ] ;
				}
			}
		}

		protected var _comparator:IComparator ;

		protected var _options:uint = 0 ;
	
		private var _sortBy:String ;
    	
    }
}