/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
     - Zwetan Kjukov <zwetan@gmail.com>
*/

package system.formatters
    {
    
    /**
     * Interface implemented by classes that can format a value in a specific string expression.
     */
    public interface Formattable
        {
        
        /**
         * Formats the specified value.
         * @return the string representation of the formatted value. 
         */
        function format( value:* = null ):String;
        
        }
    
    }

