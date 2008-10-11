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
    import vegas.core.CoreObject;
    import vegas.errors.UnsupportedOperation;
    import vegas.util.Serializer;    

    /**
     * Protect an iterator. This class protect the remove, reset and seek method.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.data.iterator.StringIterator ;
     * import vegas.data.iterator.ProtectedIterator ;
     * 
     * var it:ProtectedIterator = new ProtectedIterator( new StringIterator( "hello world" ) ) ;
     * while (it.hasNext())
     * {
     *     trace( it.next() ) ;
     * }
     * </pre>
     * @author eKameleon 
     */
    public class ProtectedIterator extends CoreObject implements Iterator
    {
        
        /**
         * Creates a new ProtectedIterator instance.
         * @param iterator the iterator to protected.
         */
        public function ProtectedIterator(i:Iterator)
        {
            _i = i ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return _i.hasNext() ;
        }

        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        public function key():*
        {
            return _i.key() ;
        }

        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():*
        {
            return _i.next() ;
        }

        /**
         * Unsupported method in all ProtectedIterator.
         * @throws UnsupportedOperation the remove method is unsupported in a ProtectedIterator instance.
         */
        public function remove():*
        {
            throw new UnsupportedOperation("This Iterator does not support the remove() method.") ;
        }
 
        /**
         * Unsupported method in all ProtectedIterator.
         * @throws UnsupportedOperation the reset method is unsupported in a ProtectedIterator instance.
         */
        public function reset():void
        {
            throw new UnsupportedOperation("This Iterator does not support the reset() method.") ;
        }

        /**
         * Unsupported method in all ProtectedIterator.
         * @throws UnsupportedOperation the seek method is unsupported in a ProtectedIterator instance.
         */
        public function seek(position:*):void
        {
            throw new UnsupportedOperation("This Iterator does not support the seek() method.") ;
        }
 
        /**
         * Returns the eden String representation of this object.
         * @return the eden String representation of this object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return Serializer.getSourceOf(this, [_i]) ;
        }

        /**
         * Internal iterator.
         */
        private var _i:Iterator ;
        
    }

}