/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.draw 
{

    /**
     * The Align enumeration class provides constant values to align displays or components.
     * @author eKameleon
     */
    public class Align 
    {
        
        /**
         * Defines the CENTER value (0).
         */
        public static const CENTER:uint = 0 ;
        
        /**
         * Defines the LEFT value (2).
         */
        public static const LEFT:uint = 2 ;
        
        /**
         * Defines the RIGHT value (4).
         */
        public static const RIGHT:uint = 4 ;
        
        /**
         * Defines the TOP value (8).
         */
        public static const TOP:uint = 8 ;
        
        /**
         * Defines the BOTTOM value (16).
         */
        public static const BOTTOM:uint = 16 ;
    
        /**
         * Defines the REVERSE value (32).
         */
        public static const REVERSE:uint = 32 ;
        
        /**
         * Defines the BOTTOM_LEFT value (18).
         */
        public static const BOTTOM_LEFT:uint = BOTTOM | LEFT ;
    
        /**
         * Defines the BOTTOM_RIGHT value (20).
         */
        public static const BOTTOM_RIGHT:uint = BOTTOM | RIGHT ;
        
        /**
         * Defines the TOP_LEFT value (10).
         */
        public static const TOP_LEFT:uint = TOP | LEFT ;
        
        /**
         * Defines the TOP_RIGHT value (12).
         */
        public static const TOP_RIGHT:uint = TOP | RIGHT ;
        
        /**
         * Defines the LEFT_BOTTOM value (50).
         */
        public static const LEFT_BOTTOM:uint = BOTTOM_LEFT | REVERSE ;
        
        /**
         * Defines the RIGHT_BOTTOM value (52).
         */
        public static const RIGHT_BOTTOM:uint = BOTTOM_RIGHT | REVERSE ;

        /**
          * Defines the LEFT_TOP value (42).
         */
        public static const LEFT_TOP:uint = TOP_LEFT | REVERSE ;
    
        /**
         * Defines the RIGHT_TOP value (44).
         */
        public static const RIGHT_TOP:uint = TOP_RIGHT | REVERSE ;

        /**
         * Converts a string value in this Align value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.draw.Align ;
         * var sAlign:String = "l" ;
         * trace( Align.toNumber("l") == Align.LEFT ) ; // true
         * </pre>
         */
        public static function toNumber( str:String ):uint 
        {
            switch (str.toLowerCase()) 
            {
                case "l" : 
                {    
                    return Align.LEFT ;
                }
                case "r" :
                {
                    return Align.RIGHT ;
                }
                case "t" :
                {
                    return Align.TOP ;
                }
                case "b" :
                {
                    return Align.BOTTOM ;
                }
                case "tl" :
                {
                    return Align.TOP_LEFT ;
                }
                case "tr" :
                {
                    return Align.TOP_RIGHT ;
                }
                case "bl" :
                {
                    return Align.BOTTOM_LEFT ;
                }
                case "br" :
                {
                    return Align.BOTTOM_RIGHT ;
                }
                case "lt" :
                {
                    return Align.LEFT_TOP ;
                }
                case "rt" :
                {
                    return Align.RIGHT_TOP ;
                }
                case "lb" :
                {
                    return Align.LEFT_BOTTOM ;
                }
                case "rb" :
                {
                    return Align.RIGHT_BOTTOM ;
                }    
                default :
                {
                    return Align.CENTER ;
                }
            }
        }

        /**
         * Returns the string representation of the specified Align value passed in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.draw.Align ;
         * trace( Align.toString(Align.LEFT)) ; // "l"
         * trace( Align.toString(Align.TOP_LEFT)) ; // "tl"
         * trace( Align.toString(Align.RIGHT_BOTTOM)) ; // "rb"
         * </pre>
         * @return the string representation of the specified Align value passed in argument.
         */
        public static function toString(n:Number):String 
        {
            switch (n) 
            {
                case Align.LEFT         : return "l" ;
                case Align.RIGHT        : return "r" ;
                case Align.TOP          : return "t" ;
                case Align.BOTTOM       : return "b" ;
                case Align.TOP_LEFT     : return "tl" ; 
                case Align.TOP_RIGHT    : return "tr" ;
                case Align.BOTTOM_LEFT  : return "bl" ;
                case Align.BOTTOM_RIGHT : return "br" ;
                case Align.LEFT_TOP     : return "lt" ; 
                case Align.RIGHT_TOP    : return "rt" ;
                case Align.LEFT_BOTTOM  : return "lb" ;
                case Align.RIGHT_BOTTOM : return "rb" ;
                default                 : return "" ;
            }
        }

        /**
         * Returns <code class="prettyprint">true</code> if the specified Align value in argument is a valid Align value else returns <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</code> if the specified Align value in argument is a valid Align value else returns <code class="prettyprint">false</code>.
          */
        public static function validate( value:uint ):Boolean 
        {
            var a:Array = 
            [ 
                Align.CENTER   , Align.LEFT       , Align.RIGHT        , Align.TOP, Align.BOTTOM , 
                Align.TOP_LEFT , Align.TOP_RIGHT  , Align.BOTTOM_LEFT  , Align.BOTTOM_RIGHT
            ] ;
            return a.indexOf(value) > -1 ;
        }

    }
}
