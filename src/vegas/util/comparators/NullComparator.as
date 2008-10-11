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
    import vegas.core.IComparator;
    import vegas.core.ICopyable;    

    /**
	 * This comparator compare Null objects.
 	 * When comparing two non-null objects, the ComparableComparator is used if the nonNullComparator isnt' define.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import vegas.util.comparators.NullComparator;
	 * 
	 * var comp1:NullComparator = new NullComparator(null, true) ;
	 * var comp2:NullComparator = new NullComparator(null, false) ;
	 * 
	 * var n = null ;
 	 * var o = {} ;
	 * 
	 * trace( comp1.compare(n, n) ) ; // 0
	 * trace( comp1.compare(n, o) ) ; // 1
	 * trace( comp1.compare(o, n) ) ; // -1
	 * 
 	 * trace("----") ;
 	 * 
	 * trace( comp2.compare(n, n) ) ; // 0
	 * trace( comp2.compare(n, o) ) ; // -1
	 * trace( comp2.compare(o, n) ) ; // 1
 	 * </pre>
  	 * @author eKameleon
	 */
	public class NullComparator extends CoreObject implements IComparator, Cloneable, ICopyable
	{
		
		/**
		 * Creates a new NullComparator instance.
		 * @param nonNullComparator the comparator to use when comparing two non-null objects.
		 * @param nullsAreHigh a <code class="prettyprint">true</code> value indicates that null should be compared as higher than a non-null object. A <code class="prettyprint">false</code> value indicates that null should be compared as lower than a non-null object. 
		 */
		public function NullComparator( nonNullComparator:IComparator = null , nullsAreHigh:Boolean = false )
		{
			this.nonNullComparator = nonNullComparator ;
			this.nullsAreHigh = nullsAreHigh ;
		}

		/**
		 * Defines the comparator to use when comparing two non-null objects.
		 */
		public var nonNullComparator:IComparator = null ;

		/**
		 * Defines that null should be compared as higher than a non-null object. 
		 */
		public var nullsAreHigh:Boolean = false ;

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */			
		public function clone():* 
		{
			return new NullComparator( nonNullComparator, nullsAreHigh ) ;
		}

		/**
		 * Perform a comparison between two objects. 
		 * If both objects are null, a 0 value is returned. 
		 * If one object is null and the other is not, the result is determined on whether the Comparator was constructed to have nulls as higher or lower than other objects.
		 * If neither object is null, an underlying comparator specified in the constructor (or the default) is used to compare the non-null objects.
		 * The default IComparator used to compare two non-null objects is the ComparableComparator.
		 * @param o1 the first 'null' object to compare.
		 * @param o2 the second 'null' object to compare.
		 * @return <p>
		 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
		 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
		 * <li> 0 if o1 and o2 are equal.</li>
		 * </p>
	 	 * @see ComparableComparator
		 */
		public function compare(o1:*, o2:*):int
		{
			if (o1 == null && o2 == null)
			{
				return 0 ;
			}			
			else if (o1 == null && o2 != null)
			{
				return nullsAreHigh ? 1 : -1 ;
			}
			else if (o1 != null && o2 == null)
			{
				return nullsAreHigh ? -1 : 1 ;
			}
			else
			{
				if ( nonNullComparator != null )
				{
					return nonNullComparator.compare(o1, o2) ;	
				}
				else
				{
					return ComparableComparator.getInstance().compare(o1, o2) ;
				}
			}
		}
		
		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */	
		public function copy():*
		{
			return new NullComparator( nonNullComparator, nullsAreHigh) ;
		}

		/**
		 * Returns the singleton instance of a ReverseComparator.
		 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 	 * @return the singleton instance of a ReverseComparator.
		 */
		public static function getInstance():NullComparator
		{
			if (_instance == null)
			{
				_instance = new NullComparator() ;
			}
			return _instance ;	
		}

		/**
	  	 * The internal static singleton of this class.
	 	 */
		private static var _instance:NullComparator ;

		
	}
}