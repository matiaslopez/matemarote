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
    
    import vegas.data.Queue;
    import vegas.data.collections.SimpleCollection;
    import vegas.util.Copier;

    /**
     * LinearQueue stores values in a 'first-in, first-out' manner.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.data.queue.LinearQueue ;
     * 
     * var q:LinearQueue = new LinearQueue(["item0", "item1"])  ;
     * trace ("queue size : " + q.size()) ;
     * trace ("enqueue item2 : " + q.enqueue ("item2")) ;
     * trace ("enqueue item3 : " + q.enqueue ("item3")) ;
     * trace ("enqueue item4 : " + q.enqueue ("item4")) ;
     * 
     * trace ("------- element") ;
     * trace ("element : " + q.element()) ;
     * trace ("peek : " + q.peek()) ;
     * 
     * trace ("------- dequeue") ;
     * trace ("dequeue : " + q.dequeue()) ;
     * 
     * trace ("------- iterator") ;
     * var it = q.iterator() ;
     * while (it.hasNext()) 
     * {
     *     trace (it.next()) ;
     * }
     * 
     * trace ("queue size : " + q.size() ) ;
     * trace ("queue toSource : " + q.toSource()) ;
     * </pre>
     * @author eKameleon
     */
    public class LinearQueue extends SimpleCollection implements Queue
    {
        
        /**
         * Creates a new LinearQueue instance.
         * @param ar an optional array to fill the collection.
         */
        public function LinearQueue( ar:Array=null )
        {
            super(ar);
        }
        
        /**
         * Returns a shallow copy of this collection (optional operation).
         * @return a shallow copy of this collection.
         */
        public override function clone():*
        {
            return new LinearQueue(toArray()) ;
        }

        /**
         * Returns a deep copy of this collection (optional operation).
         * @return a deep copy of this collection.
         */
        public override function copy():*
        {
            return new LinearQueue(Copier.copy(toArray())) ;
        }
    
        /**
         * Retrieves and removes the head of this queue.
         */
        public function dequeue():Boolean 
        {
            return poll() != null  ;
        }

        /**
         * Retrieves, but does not remove, the head of this queue.
         */
        public function element():* 
        {
            return _a[0] ;
        }
        
        /**
         * Inserts the specified element into this queue, if possible.
         */
        public function enqueue(o:*):Boolean 
        {
            if (o == null) return false ;
            _a.push(o) ;
            return true ;
        }

        /**
         * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
         */
        public function peek():* 
        {
            if (isEmpty()) return null ;
            return _a[0] ;
        }
    
        /**
         * Retrieves and removes the head of this queue.
         */
        public function poll():*
        {
            if (isEmpty()) return null ;
            return _a.shift() ;    
        }
    
        
    }
}