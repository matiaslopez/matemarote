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

package vegas.util.comparators
{
    import vegas.core.CoreObject;
    import vegas.core.IComparator;
    import vegas.errors.NullPointerError;

    /**
	 * This comparator compare two Objects by field.
	 * <p><b>Example :</b></p>
 	 * <pre class="prettyprint">
 	 * 
 	 * import vegas.events.Delegate ;
 	 * import vegas.util.comparators.GenericComparator ;
 	 * import vegas.util.comparators.StringComparator ; 
 	 * 
 	 * var write:Function = function( ar:Array ):void
 	 * {
 	 *     var result:Array = [] ;
 	 *     var size:uint = ar.length ;
 	 *     for (var i:uint = 0 ; i<size ; i++)
 	 *     {
 	 *         result[i] = ar[i].label ;
 	 *     }
 	 *     trace( result.join('|') ) ;
 	 * }
 	 * 
 	 * var ar:Array = 
 	 * [
 	 *     { id : 0 , label : "Paris" } ,
 	 *     { id : 0 , label : "Marseille" } ,
 	 *     { id : 0 , label : "Lyon" } ,
 	 *     { id : 0 , label : "Bordeaux" }
 	 * ] ;
 	 * 
 	 * var c:GenericComparator = new GenericComparator( "label", StringComparator.getIgnoreCaseStringComparator() ) ;
 	 * 
 	 * ar.sort( Delegate.create( c , c.compare ) , Array.CASEINSENSITIVE ) ;
  	 * write(ar , "label") ; // Bordeaux|Lyon|Marseille|Paris
 	 * 
 	 * ar.sort( Delegate.create( c , c.compare ) , Array.CASEINSENSITIVE | Array.DESCENDING ) ;
 	 * write(ar , "label") ; // Paris|Marseille|Lyon|Bordeaux
 	 * </pre>
 	 * @author eKameleon
 	 */
	public class GenericComparator extends CoreObject implements IComparator
	{
		
		/**
		 * Creates a new GenericComparator instance.
	 	 * @param sortBy A String who represents a property name to compare the two objects.
	 	 * @param comparator An IComparator use to compare the two objects with the specified property names. 
	 	 * @throws NullPointerError If the 'sortBy' argument is 'null' or 'undefined'.
	 	 * @throws NullPointerError If the 'comparator' argument is 'null' or 'undefined'.		 
	 	 */
		public function GenericComparator( sortBy:String , comparator:IComparator )
		{
			if ( sortBy != null  )
			{
				this.sortBy = sortBy ;
			}
			else
			{
				throw new NullPointerError(this + " constructor failed, the 'sortBy' argument not must be 'null' or 'undefined'.") ;
			}
			
			if ( comparator != null )
			{
				this.comparator = comparator ;
			}
			else
			{
				throw new NullPointerError( this + " constructor failed, the 'comparator' argument not must be 'null' or 'undefined'.") ;	
			}
		}

		/**
		 * The IComparator used by this IComparator to compare two objects with this specified field.
		 */
		public var comparator:IComparator ;
		
		/**
	 	 * A String who represents a property name to compare the two objects.
	 	 */
		public var sortBy:String;
		
		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */			
		public function clone():* 
		{
			return new GenericComparator( sortBy, comparator ) ;
		}

		/**
		 * Returns an integer value to compare two objects.
		 * @param o1 the first Number object to compare.
		 * @param o2 the second Number object to compare.
	 	 * @return <p>
	 	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 	 * <li> 0 if o1 and o2 are equal.</li>
	 	 * </p>
	 	 * @throws NullPointerError
	 	 */
		public function compare(o1:*, o2:*):int
		{
			if ( o1 != null && o2 != null ) 
			{
				if ( comparator == null )
				{
					throw new NullPointerError( "GenericComparator failed, the 'comparator' argument not must be 'null' or 'undefined'.") ;
				}
				else
				{
					return comparator.compare( o1[sortBy] , o2[sortBy] ) ;
				}
			}
			else 
			{
				throw new NullPointerError( "GenericComparator compare method failed, The two arguments not must be null.") ;
			}
		}

		
	}
}