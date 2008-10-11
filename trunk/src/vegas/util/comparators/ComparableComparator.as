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
    import system.Cloneable;
    
    import vegas.core.CoreObject;
    import vegas.core.IComparable;
    import vegas.core.IComparator;
    import vegas.core.ICopyable;
    import vegas.errors.ClassCastError;
    import vegas.errors.NullPointerError;	

    /**
 	 * A Comparator that compares IComparable objects.
	 * @author eKameleon
 	 */
	public class ComparableComparator extends CoreObject implements IComparator, Cloneable, ICopyable
	{
		
		/**
		 * Creates a new ComparableComparator instance.
	 	 * This constructor whose use should be avoided.
		 */
		public function ComparableComparator()
		{
			super();
		}

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */			
		public function clone():* 
		{
			return new ComparableComparator() ;
		}

		/**
		 * Returns an integer value to compare two objects in parameters.
		 * @param o1 the first object to compare.
	 	 * @param o2 the second object to compare.
		 * @return <p>
		 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
		 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 	 * <li> 0 if o1 and o2 are equal.</li>
	  	 * </p>
		 * @throws NullPointerError when the <code class="prettyprint">o1</code> object is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
		 * @throws ClassCastError it the <code class="prettyprint">o1</code> object is not a <code class="prettyprint">IComparable</code> object.
		 */
		public function compare(o1:*, o2:*):int
		{
			if (o1 == null)
			{
				throw new NullPointerError(this + " compare method failed, the o1 object is 'null' or 'undefined'.") ;	
			}
			if ( o1 is IComparable )
			{
				return (o1 as IComparable).compareTo(o2) ;	
			}
			else
			{
				throw new ClassCastError(this + " compare method failed, the o1 object is not a IComparable object : " + o1) ; 	
			}
		}
		
		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */	
		public function copy():*
		{
			return new ComparableComparator() ;
		}

		/**
		 * Returns the singleton instance of a ComparableComparator.
		 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 	 * @return the singleton instance of a ComparableComparator.
		 */
		public static function getInstance():ComparableComparator
		{
			if (_instance == null)
			{
				_instance = new ComparableComparator() ;
			}
			return _instance ;	
		}

		/**
	  	 * The internal static singleton of this class.
	 	 */
		private static var _instance:ComparableComparator ;

	}
}