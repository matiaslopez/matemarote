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

package vegas.events.dom
{
    import vegas.core.CoreObject;
    import vegas.core.IComparator;	

    [ExcludeClass]

    /**
     * This comparator is used in the <code class="prettyprint">EventDispatcher</code> class to ordered all <code class="prettyprint">EventLister</code> with a priority value.
     * @author eKameleon
     */
	internal class EventListenerComparator extends CoreObject implements IComparator
	{

	    /**
	     * Creates the EventListenerComparator instance.
	     */
		public function EventListenerComparator()
		{
			super();
		}
		
		/**
		 * Returns a shallow copy of this object.
		 * @return a shallow copy of this object.
		 */
		public function clone():* 
		{
			return new EventListenerComparator() ;
		}

		/**
		 * Returns a deep copy of this object.
		 * @return a deep copy of this object.
		 */
		public function copy():*
		{
			return new EventListenerComparator() ;
		}

	    /**
	     * Compares its two arguments for order.
	     * @return -1 if o1 is "lower" than o2, 1 if o1 is "higher" than o2 and 0 if o1 and o2 are equal.
	     */
		public function compare(o1:*, o2:*):int
		{
			if ( o1 is EventListenerContainer && o2 is EventListenerContainer ) 
			{
				var p1:uint = (o1 as EventListenerContainer).getPriority() ;
				var p2:uint = (o2 as EventListenerContainer).getPriority() ;
				if( p1 < p2 )
				{
					return 1 ;
				}
				else if( p1 > p2 )
				{
				 	return -1 ;
				}
				else 
				{
					return 0 ;
				}
			}
			else 
			{
				throw new ArgumentError(this + ".compare(" + o1 + "," + o2 + "), arguments must be EventListenerContainer.") ;
			}
		}
	
		/**
		 * Returns the singleton instance of this class.
		 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 	 * @return the singleton instance of this class.
		 */
		public static function getInstance():EventListenerComparator
		{
			if (_instance == null)
			{
				_instance = new EventListenerComparator() ;
			}
			return _instance ;	
		}

		/**
	  	 * The internal static singleton of this class.
	 	 */
		private static var _instance:EventListenerComparator ;
		
	}
}