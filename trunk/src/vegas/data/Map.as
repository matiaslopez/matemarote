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

package vegas.data
{
    import system.Cloneable;
    import system.Serializable;
    
    import vegas.core.ICopyable;
    import vegas.core.IHashable;
    import vegas.data.iterator.Iterable;
    import vegas.data.iterator.Iterator;    

    /**
	 * An object that maps keys to values. A map cannot contain duplicate keys. Each key can map to at most one value.
	 * @author eKameleon
	 */
    public interface Map extends Cloneable, ICopyable, IHashable, Serializable, Iterable
    {
     
		/**
		 * Removes all mappings from this map (optional operation).
		 */
     	function clear():void ;

		/**
		 * Returns <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
		 * @return <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
		 */
        function containsKey( key:* ):Boolean ;
	
		/**
		 * Returns <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
		 * @return <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
		 */
    	function containsValue( value:* ):Boolean ;

		/**
		 * Returns the value to which this map maps the specified key.
		 * @return the value to which this map maps the specified key.
		 */
	    function get(key:*):* ;
	
		/**
		 * Returns an array of all the keys in the map.
		 * @return an array of all the keys in the map.
		 */
    	function getKeys():Array ;

		/**
		 * Returns an array of all the values in the map.
		 * @return an array of all the values in the map.
		 */
    	function getValues():Array ;

		/**
		 * Returns <code class="prettyprint">true</code> if this map contains no key-value mappings.
		 * @return <code class="prettyprint">true</code> if this map contains no key-value mappings.
		 */
	    function isEmpty():Boolean ;
	
		/**
		 * Returns the keys iterator of this map.
		 * @return the keys iterator of this map.
		 */
        function keyIterator():Iterator ;

		/**
		 * Associates the specified value with the specified key in this map (optional operation).
		 */
    	function put(key:*, value:*):*  ;
	
		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 */	
    	function putAll(m:Map):void ;
    	
		/**
		 * Removes the mapping for this key from this map if it is present (optional operation).
		 */
    	function remove(o:*):*  ;
	
		/**
		 * Returns the number of key-value mappings in this map.
		 * @return the number of key-value mappings in this map.
		 */
    	function size():uint ;

    }

}