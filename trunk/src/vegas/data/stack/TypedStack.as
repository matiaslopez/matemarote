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

package vegas.data.stack
{
    import vegas.data.Stack;
    import vegas.data.iterator.Iterator;
    import vegas.util.AbstractTypeable;
    import vegas.util.Serializer;    

    /**
     * TypedQueue is a wrapper for Stack instances that ensures that only values of a specific type can be added to the wrapped stack.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.data.Stack ;
     * import vegas.data.stack.SimpleStack ;
     * import vegas.data.stack.TypedStack ;
     * 
     * var s:Stack = new SimpleStack() ;
     * s.push("item1") ;
     * s.push("item2") ;
     * s.push("item3") ;
     * 
     * var ts:Stack = new TypedStack(String, s) ;
     * ts.push("item4") ;
     * 
     * trace("stack >> " + ts.size() + " : " + ts) ;
     * trace("stack.toSource : " + ts.toSource()) ;
     * 
     * ts.push(2) ;
     * </pre>
     * @author eKameleon
     */
	public class TypedStack extends AbstractTypeable implements Stack
	{
	
		/**
    	 * Creates a new TypedStack instance.
    	 * @param type the type class of this ITypeable object.
    	 * @param stack the Stack reference protected with this ITypeable object.
    	 * @throws ArgumentError if the <code class="prettyprint">type</code> argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
    	 * @throws ArgumentError if the <code class="prettyprint">stack</code> argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
	     */
		public function TypedStack(type:*, stack:Stack)
		{
			super(type);
			if (stack == null) 
			{
				throw new ArgumentError("TypedStack constructor, argument 'stack' must not be 'null' or 'undefined'.") ;
			}
			this._stack = stack ;
			if (_stack.size() > 0) 
			{
				var it:Iterator = _stack.iterator() ;
				while ( it.hasNext() )
				{
					validate(it.next()) ;
				} 
			}
		}

    	/**
    	 * Removes all of the elements from this Stack (optional operation).
    	 */
		public function clear():void
		{
			_stack.clear() ;
		}

    	/**
    	 * Returns a shallow copy of this Stack (optional operation).
    	 * @return a shallow copy of this Stack (optional operation).
    	 */
		public function clone():*
		{
			return _stack.clone() ;
		}

    	/**
    	 * Returns a deep copy of this Stack (optional operation).
    	 * @return a deep copy of this Stack (optional operation).
    	 */
		public function copy():*
		{
			return _stack.copy() ;
		}

    	/**
    	 * Returns <code class="prettyprint">true</code> if this Stack contains no elements.
    	 * @return <code class="prettyprint">true</code> if this Stack contains no elements.
    	 */
		public function isEmpty():Boolean
		{
			return false;
		}

	    /**
    	 * Returns an iterator over the elements in this Stack.
    	 * @return an iterator over the elements in this Stack.
    	 */
		public function iterator():Iterator
		{
			return _stack.iterator() ;
		}

	    /**
    	 * Looks at the object at the top of this stack without removing it from the stack.
    	 */
		public function peek():*
		{
			return _stack.peek() ;
		}

	    /**
    	 * Removes the object at the top of this stack and returns that object as the value of this function.
    	 */
		public function pop():*
		{
			return _stack.pop() ;
		}

    	/**
    	 * Pushes an item onto the top of this stack.
    	 */
		public function push(o:*):void
		{
			validate(o) ;
			_stack.push(o) ;
		}

	    /**
	     * Returns the 1-based position where an object is on this stack.
	     */
		public function search(o:*):uint
		{
			return _stack.search(o) ;
		}

	    /**
    	 * Sets the type of the ITypeable object.
    	 */
		public override function setType(type:*):void
		{
			super.setType(type) ;
			_stack.clear() ;
		}

    	/**
    	 * Returns the number of elements in this Stack.
    	 * @return the number of elements in this Stack.
    	 */
		public function size():uint
		{
			return _stack.size() ;
		}

        /**
	     * Returns the array representation of all the elements of this Stack.
	     * @return the array representation of all the elements of this Stack.
	     */
		public function toArray():Array
		{
			return _stack.toArray() ;
		}

    	/**
    	 * Returns a eden representation of the object.
    	 * @return a string representation the source code of the object.
    	 */		
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [ getType() , _stack ] ) ;
		}

    	/**
    	 * Returns the string representation of this instance.
    	 * @return the string representation of this instance.
    	 */
		public override function toString():String
		{
			return (_stack as TypedStack).toString() ;
		}

        /**
         * @private
         */
		private var _stack:Stack ;
		
	}
}

