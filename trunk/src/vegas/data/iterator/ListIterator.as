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
     * Defines an iterator that operates over an ordered list. This iterator allows both forward and reverse iteration through the list.
     * @author eKameleon
     */
    public interface ListIterator extends OrderedIterator
    {
        
        /**
         * Inserts the specified element into the list (optional operation).
         */
        function insert(o:*):void ;

        /**
          * Returns the index of the element that would be returned by a subsequent call to next.
         * @return the index of the element that would be returned by a subsequent call to next.
         */
        function nextIndex():uint ;    

        /**
          * Returns the index of the element that would be returned by a subsequent call to previous.
         * @return the index of the element that would be returned by a subsequent call to previous.
         */
        function previousIndex():int ;
    
        /**
         * Replaces the last element returned by next or previous with the specified element (optional operation).
         */
        function set(o:*):void ;
        
    }
}