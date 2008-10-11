/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.config
{
    import vegas.data.iterator.Iterator;
    import vegas.data.sets.HashSet;    

    /**
     * The ConfigCollector class is a static collection to register all IConfigurable objects.
     * @author eKameleon
     */
    public class ConfigCollector
    {
        
	    /**
	     * Returns <code class="prettyprint">true</code> if the collector contains the specified <code class="prettyprint">IConfigurable</code> object.
	     * @return <code class="prettyprint">true</code> if the collector contains the specified <code class="prettyprint">IConfigurable</code> object.
	     */	
	    public static function contains( conf:IConfigurable ):Boolean 
    	{
	    	return _set.contains( conf ) ;	
    	}

    	/**
    	 * Inserts an IConfigurable object in the collector.
    	 */
	    public static function insert( conf:IConfigurable ):Boolean 
    	{
    		return _set.insert( conf ) ;
    	}
   
 	   /**
	    * Returns the <code class="prettyprint">Iterator</code> of this collector.
	    * @return the <code class="prettyprint">Iterator</code> of this collector.
	    */
    	public static function iterator() :Iterator
    	{
    		return _set.iterator() ;	
    	}

    	/**
    	 * Removes the specified <code class="prettyprint">IConfigurable</code> object in the collector.
    	 */
    	public static function remove( conf:IConfigurable ):*
    	{
    		return _set.remove( conf ) ;
    	}

    	/**
    	 * Run the <code class="prettyprint">ConfigCollector</code> command to invoked the <code class="prettyprint">setup()</code> method of all <code class="prettyprint">IConfigurable</code> object registered in the collector.
	     */
    	public static function run():void
    	{
    		if (size() > 0)
    		{
    		    var ar:Array = _set.toArray() ;
    		    var l:uint = ar.length ;
    		    while(--l > -1)
    		    {
    		    	if ( ar[l] is IConfigurable)
    		    	{
    					(ar[l] as IConfigurable).setup() ;
    		    	}	
    			}
    		}	
    	}

    	/**
    	 * Returns the number of elements in the collector.
	     * @return the number of elements in the collector.
    	 */
    	public static function size():Number
    	{
    		return _set.size() ;
    	}

    	/**
    	 * The internal Set of this collector.
    	 */
   	    private static var _set:HashSet = new HashSet() ;
        
    }
}