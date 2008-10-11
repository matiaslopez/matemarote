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
	import vegas.data.collections.AbstractCollection;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterator;
	import vegas.data.iterator.ProtectedIterator;
	import vegas.data.Stack;
	import vegas.util.Copier ;
    
    /**
     * The based implementation of the Stack interface.
     * The Stack interface represents a last-in-first-out (LIFO) stack of objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var stack:Stack = new SimpleStack(["item1", "item2"]) ;
     * trace("push : " + stack.push("item3")) ;
     * trace("toSource : " + stack.toSource()) ;
     * trace("pop : " + stack.pop()) ;
     * trace("stack : " + stack) ;
     * </pre>
     * @author eKameleon
     */		
	public class SimpleStack extends AbstractCollection implements Stack
	{

    	/**
    	 * Creates a new SimpleStack instance.
    	 * @param ar an array to fill the Stack
    	 */
		public function SimpleStack(ar:Array=null)
		{
			super(ar);
		}
		
		/**
	     * Returns a shallow copy of this object.
	     * @return a shallow copy of this object.
	     */
		public override function clone():* 
		{
			return new SimpleStack(toArray()) ;
		}

		/**
	     * Returns a deep copy of this object.
	     * @return a deep copy of this object.
	     */
		public override function copy():*
		{
			return new SimpleStack(Copier.copy(toArray())) ;
		}

    	/**
    	 * Returns an element but if id = 0, it's the last element in the stack.
    	 * @return an element but if id = 0, it's the last element in the stack.
    	 */
		public override function get(key:*):*
		{ 
			var a:Array = toArray() ;
			return a[key] ;
		}
    	
    	/**
	     * Returns an iterator over the elements in this Stack.
	     * @return an iterator over the elements in this Stack.
	     */
		public override function iterator():Iterator 
		{
			return (new ProtectedIterator(new ArrayIterator(toArray()))) ;
		}

    	/**
    	 * Looks at the object at the top of this stack without removing it from the stack.
	     */
		public function peek():*
		{
			return _a[_a.length - 1] ;
		}

    	/**
    	 * Removes the object at the top of this stack and returns that object as the value of this function.
    	 * @return the removed object value.
    	 */
		public function pop():*
		{
			return isEmpty() ? null : _a.pop() ;
		}

    	/**
    	 * Pushes an item into the top of this stack.
    	 */
		public function push(o:*):void
		{
			_a.push(o) ;
		}

    	/**
    	 * Returns the index of an element in the Stack.
    	 * @return the index of an element in the Stack.
    	 */
		public function search(o:*):uint
		{
			return indexOf(o) ;
		}

    	/**
    	 * Returns the array representation of all the elements of this Stack.
    	 * @return the array representation of all the elements of this Stack.
    	 */
		public override function toArray():Array 
		{
			var aReverse:Array = _a.slice() ;
			aReverse.reverse() ;
			return aReverse ;
		}
		
	}
}