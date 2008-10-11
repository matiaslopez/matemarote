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
     * This static enumeration class register all string constants to defined a month.
     */
    public class Month
    {

        /**
         * Fully written out string for january.
         */
        public static var JANUARY:String = "January" ;
            
        /**
         * Fully written out string for february.
         */
        public static var FEBRUARY:String = "February" ;
               
        /**
         * Fully written out string for march.
         */
        public static var MARCH:String = "March" ;
        
        /**
         * Fully written out string for april.
         */
        public static var APRIL:String = "April" ;
                    
        /**
         * Fully written out string for may.
         */
        public static var MAY:String = "May" ;
        
        /**
         * Fully written out string for june.
         */
        public static var JUNE:String = "June" ;
        
        /**
         * Fully written out string for july.
         */
        public static var JULY:String = "July" ;
        
        /**
         * Fully written out string for august.
         */
        public static var AUGUST:String = "August" ;
        
        /**
         * Fully written out string for september.
         */
        public static var SEPTEMBER:String = "September" ;
        
        /**
         * Fully written out string for october.
         */
        public static var OCTOBER:String = "October" ;
            
        /**
         * Fully written out string for november.
         */
        public static var NOVEMBER:String = "November" ;
        
        /**
         * Fully written out string for december.
         */
        public static var DECEMBER:String = "December" ;
                
        /**
         * Returns the array representation of all months constants.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( "days   : " + Month.getMonths() ) ;
         * </pre>
         * @return the array representation of all months constants.
         */
        public static function getMonths():Array 
        {
            return [ JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER ] ;
        }        
        
    }
}
