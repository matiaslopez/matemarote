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

package vegas.data.iterator
{
    import system.numeric.Mathematics;
    
    import vegas.core.CoreObject;
    import vegas.errors.UnsupportedOperation;    

    /**
     * An iterator page by page over an array who return an new array of elements.
     * If the step size value is <code class="prettyprint">1</code> the next and previous methods returns the single value element in the data array.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.data.iterator.PageByPageIterator;
     * 
     * var ar:Array = [1, 2, 3, 4, 5, 6, 7, 8] ;
     * 
     * var it:PageByPageIterator = new PageByPageIterator(2, ar) ;
     * 
     * var next:Function = function():void
     * {
     *     if (!it.hasNext())
     *     {
     *         it.reset() ;
     *     }
     *     var next:* = it.next()
     *     trace( "> " + next + " : " + it.currentPage() ) ;
     * }
     * 
     * var prev:Function = function():void
     * {
     *     if ( !it.hasPrevious())
     *     {
     *         it.lastPage() ;
     *     }
     *     var prev:* = it.previous() ;
     *     trace( "> " + prev + " : " + it.currentPage() ) ;
     * }
     * 
     * next() ; // > 1,2 : 1
     * next() ; // > 3,4 : 2
     * next() ; // > 5,6 : 3
     * next() ; // > 7,8 : 4
     * next() ; // > 1,2 : 1
     * prev() ; // > 7,8 : 4
     * </pre>
     * @author eKameleon
     */
    public class PageByPageIterator extends CoreObject implements OrderedIterator
    {
        
        /**
         * Creates a new PageByPageIterator.
         * @param stepSize the step size value.
         * @param data the array to enumerate.
         * @throws UnsupportedOperation if the data array is empty.
         */
        public function PageByPageIterator( stepSize:uint = 1 , data:Array = null )
        {
            super();
            if (data == null)
            {
                throw new UnsupportedOperation(this + " constructor failed, the array passed-in argument not must be empty or 'null'.") ;
            }
            var len:Number = data.length ;
            if (len > 0)
            {
                _data = data ;
                _key = 0 ;
                _currentPage = 0 ;
                _step = (stepSize > 1) ? stepSize : PageByPageIterator.DEFAULT_STEP ; 
                _pageCount =  Math.ceil(len / _step) ;
            }
            else
            {
                throw new UnsupportedOperation(this + " constructor failed, data length not must be empty") ;
            }
        }
        
        /**
         * The default step value in all the PageByPageIterators.
         */
        public static var DEFAULT_STEP:Number = 1 ;
 
        /**
         * Returns the current page value.
         * @return the number of the current page.
         */
        public function currentPage():Number
        {
            return _currentPage ;
        }

        /**
         * Returns the step size of this PageByPageIterator.
         * @return the step size of this PageByPageIterator.
         */
        public function getStepSize():Number
        {
            return _step ;    
        }    

        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasNext():Boolean
        {
            return _key < _pageCount ;
        }

        /**
         * Checks to see if there is a previous element that can be iterated to.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasPrevious():Boolean
        {
            return _key > 1 ;
        }
        
        /**
         * Returns the current page number.
         * @return the current page number.
         */
        public function key():*
        {
            return _currentPage ;
        }
    
        /**
         * Seek the iterator in the last page of this object.
         */
        public function lastPage():void
        {
            seek( _pageCount + 1 ) ;
        }
        /**
         * Returns the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         * @return the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         */
        public function next():*
        {
            var index:Number = _step * _key++ ;
            _currentPage = _key ;
            if (_step > 1)
            {
                return _data.slice(index, index + _step) ;
            }
            else
            {
                return _data[index] ;
            }
        }

        /**
         * Returns the numbers of page of this iterator.
         * @return the numbers of page of this iterator.
         */
        public function pageCount():Number
        {
            return _pageCount ;    
        }

        /**
         * Returns the previous Array page of elements or the previous element in the Array if the getStepSize() value is 1.
         * @return the previous element from the collection.
         */
        public function previous():*
        {
            _currentPage -- ;
            _key -- ;
            var index:Number = _step * (_key-1) ;
            if (_step > 1)
            {
                return _data.slice(index, index + _step) ;
            }
            else
            {
                return _data[index] ;    
            }
        }

        /**
         * Unsupported operation in a PageByPageIterator.
         * @throws UnsupportedOperation the method remove() in this iterator is unsupported. 
         */
        public function remove():*
        {
            throw new UnsupportedOperation(this + " remove method is unsupported by this instance.") ;
        }
        
        /**
         * Resets the key pointer of the iterator.
         */
        public function reset():void
        {
            _key = 0 ;
            _currentPage = 0 ;
        }

        /**
         * Seek the key pointer of the iterator.
         */
        public function seek(position:*):void
        {
            _key = Mathematics.clamp( position++, 0, _pageCount+1 ) ;
            _currentPage = _key ;
        }
        
        /**
         * The currentPage value.
         */
        private var _currentPage:Number ;

        /**
         * The data to iterate.
         */
        private var _data:Array ;

        /**
         * The current key of the iterator. 
         */
        private var _key:int ;
    
        /**
         * Count of pages.
         */
        private var _pageCount:Number ;
        
        /**
         * The numbers of lines in a page.
         */
        private var _step:Number ;
        
    }
}