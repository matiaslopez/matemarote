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

package vegas.data.sets
{
    import system.Equatable;
    
    import vegas.data.Collection;
    import vegas.data.Set;
    import vegas.data.collections.SimpleCollection;	

    /**
     * This class provides a skeletal implementation of the Set interface to minimize the effort required to implement this interface.
     * A collection that contains no duplicate elements.
     * @author eKameleon
     */
	internal class AbstractSet extends SimpleCollection implements Equatable, Set
	{
		
		/**
	     * Creates a new AbstractSet instance.
	     */
		public function AbstractSet( ar:Array )
		{
			super(ar) ;		
		}
		
		/**
	     * Compares the specified object with this object for equality.
	     * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
	     */
		public function equals(o:*):Boolean 
		{
			
			if (o == this) 
			{
				return true ;
			}
			if ( ! (o is Set) ) 
			{
				return false ;
			}
			var c:Collection = Collection(o) ;
			if (c.size() != size()) 
			{
				return false ;
			}		
			
			return this.containsAll(c) ;
			
		}
		
	}
	
	
	


}
