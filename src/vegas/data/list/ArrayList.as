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

package vegas.data.list
{
	import vegas.data.Collection;
	import vegas.data.iterator.Iterator;
	import vegas.util.Copier;

	/**
	 * Resizable-array implementation of the List interface.
	 * Implements all optional list operations, and permits all elements, including null.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import vegas.data.list.ArrayList ;
	 * import vegas.data.List ;
	 * import vegas.data.iterator.ListIterator ;
	 * 
	 * import vegas.util.ConstructorUtil ;
	 * 
	 * var a:Array = ["item0", "item1", "item2", "item3", "item4"] ;
	 * 
	 * var list:ArrayList = new ArrayList(a) ;
	 * trace("constructor :: " + ConstructorUtil.getPath(list)) ;
	 * trace ("list : " + list.size() + " >> " + list) ;
	 * trace ("list.toSource : " + list.toSource()) ;
	 * trace ("----") ;
	 * 
	 * var it:ListIterator = list.listIterator(2) ;
	 * while(it.hasNext())
	 * {
	 *     trace(">> " + it.next() + " : " + it.key()) ;
	 *     it.remove() ;
	 * }
	 * trace ("next : " + list) ;
	 * 
	 * trace ("---- ListIterator hasPrevious") ;
	 * 
	 * var cpt = list.size() ;
	 * while(it.hasPrevious())
 	 * {
	 *     it.previous() ;
	 *     it.set("changeItem" +  cpt--) ;
 	 * }
	 * trace ("list : " + list) ;
	 * </pre>
	 * @author eKameleon
 	 */
	public class ArrayList extends AbstractList
	{
		
		/**
		 * Creates a new ArrayList instance.
		 * <p><b>Usage </b></p>
		 * <pre class="prettyprint">
		 * 	new ArrayList() ;
		 * 	new ArrayList(ar:Array) ;
		 * 	new ArrayList(co:Collection) ;
		 *  new ArrayList( capacity:uint ) ;
		 * </pre>
		 */
		public function ArrayList( init:* = null )
		{
			
			var ar:Array ;			
			
			if ( init is Array )
			{
				ar = init ;
			}
			else if (init is Collection)
			{
				ar = [] ;
				var it:Iterator = (init as Collection).iterator() ;
				while (it.hasNext()) {
					insert(it.next()) ;
				}
			}
			else if (init is uint)
			{
				ar = new Array(init) ;
			}
			else 
			{
				ar = [] ;
			}
			
			super(ar) ;
			
		}
	
		/**
		 * Creates and returns a shallow copy of the object.
	 	 * @return A new object that is a shallow copy of this instance.
		 */		
		public override function clone():* 
		{
			return new ArrayList(toArray()) ;
		}
		
		/**
		 * Returns the deep copy of the object.
		 * @return the deep copy of the object.
		 */
		public override function copy():*
		{
			return new ArrayList( Copier.copy(toArray())) ;
		}

		/**
		 * Increases the capacity of this ArrayList instance, if necessary, to ensure that it can hold at least the number of elements specified by the minimum capacity argument.
		 */
		public function ensureCapacity( capacity:uint ):void 
		{
			_a.length = capacity ;
		}
		
	}
}