/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is KRON-os Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package kronos.date 
{

    /**
     * This static enumeration class register all string constants to defined a day.
     */
    public class Day
    {
    
        /**
         * Fully written out string for monday.
         */
        public static var MONDAY:String = "Monday" ;
               
        /**
         * Fully written out string for tuesday.
         */
        public static var TUESDAY:String = "Tuesday" ;
        
        /**
         * Fully written out string for wednesday.
         */
        public static var WEDNESDAY:String = "Wednesday" ;
    
        /**
         * Fully written out string for thursday.
         */
        public static var THURSDAY:String = "Thursday" ;
        
        /**
         * Fully written out string for friday.
         */
        public static var FRIDAY:String = "Friday" ;
        
        /**
         * Fully written out string for saturday.
         */
        public static var SATURDAY:String = "Saturday" ;
                
        /**
         * Fully written out string for sunday.
         */
        public static var SUNDAY:String = "Sunday" ;        
          
        /**
         * Returns the array representation of all days constants.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( "days   : " + Day.getDays() ) ;
         * </pre>
         * @return the array representation of all days constants.
         */
        public static function getDays():Array 
        {
            return [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] ;
        }

    }     

}
