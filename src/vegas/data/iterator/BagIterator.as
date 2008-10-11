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
    import vegas.data.bag.AbstractBag;
    import vegas.errors.ConcurrentModificationError;
    import vegas.errors.UnsupportedOperation;
    import vegas.util.Serializer;    

    /**
     * Converts an Bag to an iterator.
     * @author eKameleon
     */
    public class BagIterator extends CoreObject implements Iterator
    {
        
        /**
         * Creates a new BagIterator instance.
         * @param parent the bag (@code AbstractBag) used in this iterator.
         * @param support the iterator to support this iterator.
         */
        public function BagIterator( parent:AbstractBag, support:Iterator  )
        {
            _parent = parent;
            _support = support ;
            _current = null;
            _mods = parent.getModCount() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return _support.hasNext() ;
        }

        /**
         * Unsupported method in all BagIterator.
         * @throws UnsupportedOperation <code class="prettyprint">key</code> method in unsupported.
         */
        public function key():*
        {
            throw new UnsupportedOperation(this + " 'key' method is unsupported.") ;
        }

        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         * @throws ConcurrentModificationError the next method failed with an internal concurrent modification.
         */
        public function next():*
        {
            if (_parent.getModCount() != _mods) 
            {
                throw new ConcurrentModificationError(this + " concurrent modification impossible in 'next' method.");
            }
            _current = _support.next() ;
            return _current;
        }

        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            if (_parent.getModCount() != _mods) 
            {
                throw new ConcurrentModificationError(this + " concurrent modification impossible in 'remove' method.");
            }
            _support.remove() ;
            _parent.removeCopies(_current, 1);
            _mods++ ;
        }
        
        /**
         * Unsupported method in all BagIterator.
         * @throws UnsupportedOperation <code class="prettyprint">reset</code> method in unsupported.
         */
        public function reset():void
        {
            throw new UnsupportedOperation(this + " 'reset' method is unsupported.") ;
        }

        /**
         * Unsupported method in all BagIterator.
         * @throws UnsupportedOperation <code class="prettyprint">seek</code> method in unsupported.
         */
        public function seek(position:*):void
        {
            throw new UnsupportedOperation(this + " 'seek' method is unsupported.") ;
        }

        /**
         * Returns the eden String representation of this object.
         * @return the eden String representation of this object.
         */
        public override function toSource( indent:int = 0 ):String  
        {
            return Serializer.getSourceOf(this, [_parent, _support] ) ;
        }

        private var _parent:AbstractBag = null ;
        private var _support:Iterator = null ;
        private var _current:* = null ;
        private var _mods:uint = 0;

    }
}