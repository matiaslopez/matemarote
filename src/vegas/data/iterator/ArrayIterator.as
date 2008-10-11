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
    import system.Reflection;
    
    import vegas.core.CoreObject;
    import vegas.util.Serializer;    

    /**
     * Converts an <code class="prettyprint">Array</code> to an iterator.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.data.iterator.ArrayIterator ;
     * import vegas.data.iterator.Iterator ;
     * 
     * var ar:Array = ["item1", "item2", "item3", "item4"] ;
     * var it:Iterator = new ArrayIterator(ar) ;
     * 
     * while (it.hasNext())
     * {
     *     trace (it.next()) ;
     * }
     * 
     * trace ("--- it reset") ;
     * 
     * it.reset() ;
     * while (it.hasNext()) 
     * {
     *     trace (it.next() + " : " + it.key()) ;
     * }
     * 
     * trace ("--- it seek 2") ;
     * 
     * it.seek(2) ;
     * while (it.hasNext())
     * {
     *     trace (it.next()) ;
     * }
     * 
     * trace ("---") ;
     * </pre>
     * @author eKameleon
     */
    public class ArrayIterator extends CoreObject implements Iterator
    {
        
        /**
         * Creates a new ArrayIterator instance.
         * @param a the array to enumerate with the iterator.
         */
        public function ArrayIterator( a:Array )
        {
            _a = a ;
           _k = -1 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return (_k < _a.length - 1);
        }
        
        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        public function key():*
        {
            return _k ;
        }
        
        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():*
        {
           return _a[++_k] ;
        }
        
        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            return _a.splice( _k-- , 1 );
        }
        
        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void
        {
            _k = -1 ;
        }        

        /**
         * Change the position of the internal pointer of the iterator (optional operation).
         */        
        public function seek(position:*):void
        {
            _k = Mathematics.clamp((position-1), -1, _a.length) ;
        }

        /**
         * Returns the eden String representation of this object.
         * @return the eden String representation of this object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "(" + Serializer.toSource(_a) + ")" ;
        }

        /**
         * current array
         */
        protected var _a:Array ; 

        /**
         *  current key
         */
        protected var _k:Number ;

    }
}