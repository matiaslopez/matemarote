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
    import vegas.data.iterator.Iterator;
    import vegas.util.AbstractTypeable;
    import vegas.util.Serializer;    

    /**
     * TypedQueue is a wrapper for Queue instances that ensures that only values of a specific type can be added to the wrapped queue.
     * @author eKameleon
     */
    public class TypedQueue extends AbstractTypeable implements Queue
    {
        
        /**
         * Creates a new TypedQueue instance.
         * @param type The type of all elements insert in the Queue.
         * @param queue The Queue to be wrapped. 
         */
        public function TypedQueue(type:*, queue:Queue=null)
        {
            super(type);
            if (queue == null) 
            {
                throw new ArgumentError(this + " argument 'queue' must not be 'null' or 'undefined'.") ;
            }
            if (queue.size() > 0) 
            {
                var it:Iterator = queue.iterator() ;
                while ( it.hasNext() )
                {
                    validate(it.next()) ;
                } 
            }
            _queue = queue ;
        }

        /**
         * Removes all elements in this typed queue.
         */
        public function clear():void
        {
            _queue.clear() ;
        }

        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public function clone():* 
        {
            return new TypedQueue(getType(), _queue) ;
        }

		/**
		 * Returns <code class="prettyprint">true</code> if the queue contains value.
		 * @return <code class="prettyprint">true</code> if the queue contains value.
		 */
        public function contains(o:*):Boolean
        {
            return _queue.contains(o) ;
        }

        /**
         * Returns the deep copy of this object.
         * @return the deep copy of this object.
         */
        public function copy():*
        {
            return new TypedQueue(getType(), _queue.clone()) ;
        }

        /**
         * Removes the head of this queue and return true if removes.
         * @return <code class="prettyprint">true</code> if the Queue is dequeue.
         */
        public function dequeue():Boolean
        {
            return _queue.dequeue() ;
        }
        
        /**
         * Retrieves, but does not remove, the head of this queue.
         */
        public function element():*
        {
            return _queue.element() ;
        }

        /**
         * Inserts the specified element into this queue, if possible and return true.
         */
        public function enqueue(o:*):Boolean
        {
            validate(o) ;
            return _queue.enqueue(o) ;  
        }

        /**
         * Returns <code class="prettyprint">true</code> if this queue is empty.
         * @return <code class="prettyprint">true</code> if this queue is empty.
         */
        public function isEmpty():Boolean
        {
            return _queue.isEmpty()  ;
        }

    	/**
	     * Returns the iterator representation of the object.
	     * @return the iterator representation of the object.
    	 */
        public function iterator():Iterator
        {
            return _queue.iterator() ;
        }

	    /**
    	 * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
    	 */
        public function peek():*
        {
            return _queue.peek() ;
        }    

    	/**
	     * Retrieves and removes the head of this queue.
    	 */
        public function poll():*
        {
            return _queue.poll() ;
        }

	    /**
	     * Sets the type of this ITypeable object.
	     */
        public override function setType(type:*):void
        {
            super.setType(type) ;
            _queue.clear() ;
        }

	    /**
	     * Returns the size of this Queue.
	     * @return the size of this Queue.
	     */
        public function size():uint
        {
            return _queue.size() ;
        }

    	/**
    	 * Returns an array representation of this queue.
    	 * @return an array representation of this queue.
    	 */
        public function toArray():Array
        {
            return _queue.toArray() ;
        }

    	/**
    	 * Returns the eden representation of the object.
    	 * @return the string representing the source code of the object.
    	 */
        public override function toSource( indent:int = 0 ):String 
        {
        	return Serializer.getSourceOf(this, [getType(), _queue] ) ;
        }

    	/**
    	 * Returns the string representation of this instance.
    	 * @return the string representation of this instance
    	 */
        public override function toString():String
        {
            return (_queue as TypedQueue).toString() ;
        }
   
        /**
         * @private
         */
        private var _queue:Queue ;
	}
}

