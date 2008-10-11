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
    import system.Strings;
    
    import vegas.core.CoreObject;
    import vegas.core.IComparator;
    import vegas.core.ICopyable;	

    /**
	 * This comparator compare String objects.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import vegas.util.comparators.StringComparator ;
	 * 
	 * var comp1:StringComparator = new StringComparator() ;
	 * var comp2:StringComparator = new StringComparator(true) ; // ignore case
	 * 
	 * var s0:String = "HELLO" ;
	 * var s1:String = "hello" ;
	 * var s2:String = "welcome" ;
	 * var s3:String = "world" ;
	 * 
	 * trace( comp1.compare(s1, s2) ) ;  -1
	 * trace( comp1.compare(s2, s1) ) ;   1
	 * trace( comp1.compare(s1, s3) ) ;  -1
	 * trace( comp1.compare(s1, s1) ) ;  0
	 * 
	 * trace( comp1.compare(s1, s0) ) ;  -1
	 * trace( comp2.compare(s1, s0) ) ;  0
	 * </pre>
	 * @author eKameleon
 	 */
	public class StringComparator extends CoreObject implements IComparator, Cloneable, ICopyable
	{
		
		/**
		 * Creates a new StringComparator instance.
		 * @param ignoreCase a boolean to define if the comparator ignore case or not.
	 	 */
		public function StringComparator( ignoreCase:Boolean=false )
		{
			this.ignoreCase = ignoreCase ;
		}

		/**
		 * Allow to take into account the case for comparison.
		 */
		public var ignoreCase:Boolean ;

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */			
		public function clone():* 
		{
			return new StringComparator( ignoreCase ) ;
		}

		/**
		 * Returns an integer value to compare two String objects.
	 	 * @param o1 the first String object to compare.
	 	 * @param o2 the second String object to compare.
		 * @return <p>
		 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
		 * <li> 0 if o1 and o2 are equal.</li>
		 * </p>
		 * @throws ArgumentError if compare(a, b) and 'a' or 'b' aren't String objects.
	 	 */
		public function compare(o1:*, o2:*):int
		{
			return Strings.compare( o1, o2, ignoreCase );
		}
		
		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */	
		public function copy():*
		{
			return new StringComparator( ignoreCase ) ;
		}
		
		/**
		 * Returns the <code class="prettyprint">StringComparator</code> singleton with the a <code class="prettyprint">false</code> ignoreCase property.
		 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple StringComparators may be used in the same application.
	 	 * @return the <code class="prettyprint">StringComparator</code> singleton with the a <code class="prettyprint">false</code> ignoreCase property.
	 	*/
		public static function getStringComparator():IComparator
		{
			if ( _comparator == null )
			{
				_comparator = new StringComparator(false) ;	
			}
			return _comparator ;
		}
		
		/**
		 * Returns the <code class="prettyprint">StringComparator</code> singleton with the a <code class="prettyprint">true</code> ignoreCase property.
	 	 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple StringComparators may be used in the same application.
		 * @return the <code class="prettyprint">StringComparator</code> singleton with the a <code class="prettyprint">true</code> ignoreCase property.
	  	 */
		public static function getIgnoreCaseStringComparator():IComparator
		{
			if ( _ignoreCaseComparator == null )
			{
				_ignoreCaseComparator = new StringComparator(true) ;	
			}
			return _ignoreCaseComparator ;
		}

		/**
		 * Returns a Eden representation of the object.
		 * @return a string representation the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return "new vegas.util.comparators.StringComparator(" + ( (ignoreCase == true) ? "true" : "false") + ")" ;
		}

		/**
	  	 * The internal Case StringComparator.
	 	 */
		private static var _comparator:StringComparator ;

		/**
	 	 * The internal ignoreCase StringComparator.
		 */
		private static var _ignoreCaseComparator:StringComparator ;
		
	}

}