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
    import vegas.errors.ClassCastError;	

    /**
	 * This comparator compare two Number objects.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import vegas.util.comparators.NumberComparator ;
	 * 
	 * var c:NumberComparator = new NumberComparator() ;
 	 * 
 	 * trace( c.compare(0,0) ) ; // 0
	 * trace( c.compare(1,1) ) ; // 0
	 * trace( c.compare(-1,-1) ) ; // 0
	 * trace( c.compare(0.1,0.1) ) ; // 0
	 * trace( c.compare( Number(Math.cos(25)) , 0.9912028118634736 ) ) ; // 0
	 * trace( c.compare(1, 0) ) ; // 1
	 * trace( c.compare(0, 1) ) ; // -1
	 * </pre>
	 * @author eKameleon
 	 */
	public class NumberComparator extends CoreObject implements IComparator, Cloneable, ICopyable
	{
		
		/**
		 * Creates a new NumberComparator instance.
		 */
		public function NumberComparator() 
		{
			//
		}

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */			
		public function clone():* 
		{
			return new NumberComparator() ;
		}

		/**
	 	 * Returns an integer value to compare two Number objects.
		 * @param o1 the first Number object to compare.
		 * @param o2 the second Number object to compare.
		 * @return <p>
		 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
		 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
		 * <li> 0 if o1 and o2 are equal.</li>
		 * </p>
		 * @throws ClassCastError if compare(a, b) and 'a' and 'b' must be Number objects.
		 */
		public function compare(o1:*, o2:*):int
		{
			if ( (o1 is Number) && (o2 is Number ) ) 
			{
				// fix float bug with Math methods and float number operations.
				o1 = (o1 as Number).toString() ; 
				o2 = (o2 as Number).toString() ;
				if( o1 < o2 )
				{
					return -1;
				}
				else if( o1 > o2 )
				{
					return 1;
				}
				else 
				{
					return 0 ;
				}
			}
			else 
			{
				throw new ClassCastError(this + " compare method failed, Arguments number expected") ;
			}	
		}
		
		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */	
		public function copy():*
		{
			return new NumberComparator() ;
		}
		
		/**
		 * Returns the singleton instance of a NumberComparator.
		 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 	 * @return the singleton instance of a NumberComparator.
		 */
		public static function getInstance():NumberComparator
		{
			if (_instance == null)
			{
				_instance = new NumberComparator() ;
			}
			return _instance ;	
		}

		/**
	  	 * The internal static singleton of this class.
	 	 */
		private static var _instance:NumberComparator ;
		
	}
}