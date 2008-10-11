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
	 * Reverse an IComparator object. For example if the comparator must return 1 the reverse comparator return -1.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import vegas.util.comparators.ReverseComparator ;
	 * import vegas.util.comparators.StringComparator ;
	 * 
	 * var c:StringComparator = new StringComparator() ;
	 * var s:ReverseComparator = new ReverseComparator( c ) ;
	 * 
	 * trace( c.compare( "hello", "world" ) ) ; // -1
	 * trace( s.compare( "hello", "world" ) ) ; // 1
	 * </pre>
	 * @author eKameleon
	 */
	public class ReverseComparator extends CoreObject implements IComparator, Cloneable, ICopyable
	{
		
		/**
		 * Creates a new ReverseComparator instance.
	 	 * @param comp the <code class="prettyprint">IComparator</code> to be reverse.
	 	 */
	 	public function ReverseComparator( comp:IComparator=null )
		{
			comparator = comp ;
		}

		/**
		 * The <code class="prettyprint">IComparator</code> instance to reverse.
		 */	
		public var comparator:IComparator ;

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */	
		public function clone():* 
		{
			return new ReverseComparator( comparator ) ;
		}

		/**
		 * Returns an integer value to compare two objects (reverse the value).
		 * @param o1 the first object to compare.
		 * @param o2 the second object to compare.
		 * @return <p>
		 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
		 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
		 * <li> 0 if o1 and o2 are equal.</li>
		 * </p>
		 */
		public function compare(o1:*, o2:*):int
		{
			return comparator.compare(o2, o1) ;
		}

		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */
		public function copy():*
		{
			return new ReverseComparator( comparator ) ;
		}

		/**
		 * Returns the singleton instance of a ReverseComparator.
		 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 	 * @return the singleton instance of a ReverseComparator.
		 */
		public static function getInstance():ReverseComparator
		{
			if (_instance == null)
			{
				_instance = new ReverseComparator() ;
			}
			return _instance ;	
		}

		/**
	  	 * The internal static singleton of this class.
	 	 */
		private static var _instance:ReverseComparator ;

	}
}