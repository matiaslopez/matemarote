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

package vegas.data.queue
{
    import vegas.core.IComparator;
    import vegas.core.IComparer;
    import vegas.util.Copier;
    
    /**
     * This queue orders elements according to an order specified at construction time, which is specified either according to their natural order or according to a IComparator object.
     * @author eKameleon
     * @see IComparator
     */
    public class PriorityQueue extends LinearQueue implements IComparer
    {
        
        /**
         * Creates a new PriorityQueue instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.queue.PriorityQueue ;
         * import vegas.errors.ClassCastError ;
         * import vegas.util.comparators.NumberComparator ;
         * import vegas.util.comparators.StringComparator ;
         * 
         * var init:Array = [5, 4, 3, 2, 1] ;
         * var q:PriorityQueue = new PriorityQueue( NumberComparator.getInstance() , PriorityQueue.NUMERIC , init )  ;
         * 
         * trace ("queue size : " + q.size()) ;
         * trace("queue " + q) ;
         * 
         * q.options = PriorityQueue.NUMERIC + PriorityQueue.DESCENDING ;
         * trace("queue " + q) ;
         * 
         * try
         * {
         *     trace ("enqueue item4 : " + q.enqueue ("item4")) ;
         * }
         * catch( e:ClassCastError )
         * {
         *     trace( e ) ;
         * }
         * 
         * q.clear() ;
         * 
         * q.comparator = new StringComparator() ;
         * q.options    = PriorityQueue.CASEINSENSITIVE | PriorityQueue.DESCENDING ;
         * 
         * trace ("enqueue item4 : " + q.enqueue ("item4")) ;
         * trace ("enqueue item2 : " + q.enqueue ("item2")) ;
         * trace ("enqueue item3 : " + q.enqueue ("item3")) ;
         * trace ("enqueue item1 : " + q.enqueue ("item1")) ;
         *
         * trace("queue " + q) ;
         * 
         * q.options = PriorityQueue.CASEINSENSITIVE ;
         * trace("queue " + q) ;
         * </pre>
         * @param comp An optional IComparator object used in the PriorityQueue to defined the sort model when enqueue or modify the queue.
         * @param ar An optional Array with values to fill the queue.
         * @see IComparator
         */
        public function PriorityQueue(comp:IComparator=null, options:uint=0, ar:Array=null )
        {
            super(ar) ;
            this.comparator = comp ;
            this.options    = options ;
            if (size() > 0) 
            {
                _sort() ;
            }
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
         * Returns the internal IComparator reference of this object.
         * @return the internal IComparator reference of this object.
         */
        public function get comparator():IComparator 
        {
            return _comparator ;
        }

        /**
         * Sets the internal IComparator reference of this object.
         */
        public function set comparator(comp:IComparator):void 
        {
            _comparator = comp ;
            _sort() ;
        }

        /**
         * (read-write) Returns the options to sort the elements in the list.
         */
        public function get options():uint
        {
            return _options ;
        }

        /**
         * (read-write) Sets the options to sort the elements in the list.
          */
        public function set options( o:uint ):void 
        {
            _options = o ;
            _sort() ;
        }

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():* 
        {
            return new PriorityQueue(comparator, options, toArray());
        }

        /**
         * Returns a deep copy of this object.
         * @return a deep copy of this object.
         */
        public override function copy():* 
        {
            return new PriorityQueue(comparator, Copier.copy(toArray())) ;
        }

        /**
         * Inserts the specified element into this queue, if possible.
         */
        public override function enqueue(o:*):Boolean 
        {
            var isEnqueue:Boolean = super.enqueue(o) ;
            if ( isEnqueue && _comparator != null ) 
            {
                _sort() ;
            }
            return isEnqueue ;
        }
        
        protected var _comparator:IComparator ;

        protected var _options:uint = 0 ;
    
        /**
         * The internal IComparator reference.
         */
        protected function _sort():void 
        {
            if ( size() > 0 && _comparator != null) 
            {
                _a.sort( _comparator.compare, _options ) ;
            }
        }
        
    }
}