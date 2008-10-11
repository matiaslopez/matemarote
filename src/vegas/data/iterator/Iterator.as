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

package vegas.data.iterator
{

    /**
     * This interface defines the iterator pattern over a collection. 
     * @author eKameleon
     */
    public interface Iterator
    {

        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        function hasNext():Boolean ;

        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        function key():* ;

        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        function next():* ;

        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        function remove():* ;

        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        function reset():void ;

        /**
         * Change the position of the internal pointer of the iterator (optional operation).
         */
        function seek( position:* ):void ;
        
    }
    
}