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
package system.numeric
    {
    import system.Equatable;
    import system.Serializable;
    import system.numeric.Mathematics;    

    /**
     * Represents an immutable range of values.
     * <pre class="prettyprint">
     * import system.numeric.Range ;
     * 
     * var r1:Range = new Range(10, 120) ;
     * var r2:Range = new Range(100, 150) ;
     * 
     * trace ("r1 : " + r1) ; // r1 : [Range<10,120>]
     * trace ("r2 : " + r2) ; // r2 : [Range<100,150>]
     * 
     * trace ("r2.toSource()     : " + r2.toSource()      ) ; // r2.toSource() : new system.numeric.Range(100,150)
     * trace ("r1 contains 50    : " + r1.contains(50)    ) ; // r1 contains 50 : true
     * trace ("r1 isOutOfRange 5 : " + r1.isOutOfRange(5) ) ; // r1 isOutOfRange 5 : true
     * trace ("r1 overlap r2     : " + r1.overlap(r2)     ) ; // r1 overlap r2 : true
     * trace ("r1 clamp 5        : " + r1.clamp(5)        ) ; // r1 clamp 5 : 10
     * trace ("r1 clamp 121      : " + r1.clamp(121)      ) ; // r1 clamp 121 : 120
     * </pre>
     * @author eKameleon
     */
    public class Range implements Equatable, Serializable
        {
        
        /**
         * Creates a new Range instance.
         * <p><b>Usage :</b></p>
         * <pre class="prettyprint">var r:Range = new Range( min:Number, max:Number) ;</pre>
         */ 
        public function Range( min:Number, max:Number)
            {
            if ( max < min)
                {
                throw new RangeError("Range constructor : 'max' argument is < of 'min' argument") ;
                }
            this.min = min ;
            this.max = max ;
            }
        
        /**
         * Range reference between 0 and 360.
         */
        public static const DEGREE_RANGE:Range = new Range(0, 360) ;
        
        /**
         * Range reference between 0 and 100.
         */
        public static const PERCENT_RANGE:Range = new Range(0, 100) ;
    
        /**
         * Range reference between -255 and 255.
         */
        public static const COLOR_RANGE:Range = new Range(-255, 255) ;

        /**
         * Range reference between 0 and 1.
         */
        public static const UNITY_RANGE:Range = new Range(0, 1) ;

        /**
         * The max value of the range.
         */    
        public var max:Number ;
    
        /**
         * The min value of the range.
         */
        public var min:Number ;
        
        /**
         * Clamp a value in the current range.
         */    
        public function clamp(value:Number):Number 
            {
            return Mathematics.clamp(value, min, max) ;
            }

        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public function clone():*
            {
            return new Range(min, max) ;
            }

        /**
         * Creates a new range by combining two existing ranges.
         * <li>either range can be <code class="prettyprint">null</code>, in which case the other range is returned.</li>
         * <li>if both ranges are <code class="prettyprint">null</code> the return value is <code class="prettyprint">null</code>.</li>
         * @param range1 the first range, <code class="prettyprint">null</code> permitted.
         * @param range2 the second range, <code class="prettyprint">null</code> permitted.
         */
        public static function combine( range1:Range, range2:Range ):Range
            {
            if (range1 == null)
                {
                return range2 ;    
                }
            else
                {
                if (range2 == null)
                    {
                    return range1 ;    
                    }
                else
                    {
                    var lower:Number = Math.min( range1.min , range2.min ) ;
                    var upper:Number = Math.max( range1.max , range2.max ) ;
                    return new Range(lower, upper) ;    
                    }
                }
            }

        /**
         * Returns <code class="prettyprint">true</code> if the Range instance contains the value passed in argument.
         * @return <code class="prettyprint">true</code> if the Range instance contains the value passed in argument.
         */
        public function contains(value:Number):Boolean 
            {
            return !isOutOfRange(value) ;
            }
                
        /**
         * Indicates whether some other object is "equal to" this one.
         */
        public function equals(o:*):Boolean
            {
            if (o is Range) 
                {
                return ((o as Range).min == min) && ((o as Range).max == max) ;
                }
            else
                {
                return false ;
                }
            }
        
        /**
         * Creates a new range by adding margins to an existing range.
         * @param range the range <code class="prettyprint">null</code> not permitted.
         * @param lowerMargin the lower margin (expressed as a percentage of the range length).
         * @param upperMargin the upper margin (expressed as a percentage of the range length).
         * @return The expanded range.
         * @throws Error if the range argument is <code class="prettyprint">null</code>
         */
        public static function expand(range:Range, lowerMargin:Number=1, upperMargin:Number=1):Range
            {
            if (range == null)
                {
                throw new Error("Range.expand method failed, the range argument not must be 'null' or 'undefined'.");  
                }
            var size:Number = range.size() ;
            var lower:Number = size * lowerMargin ;
            var upper:Number = size * upperMargin ;
            return new Range( range.min - lower , range.max + upper ) ;
            }
    	
    	/**
    	 * Filters the passed-in Number value, if the value is NaN the return value is the default value in second argument.
    	 * @param value The Number value to filter, if this value is NaN the value is changed.
    	 * @param defaultValue The default value to apply over the specified value if this value is NaN (default 0).
    	 * @return The filter Number value.
    	 */    
		public static function filterNaNValue( value:Number, defaultValue:Number=0 ):Number
		  {
			return isNaN( value ) ? defaultValue : value ;	
		  }        
        
        /**
         * Returns the central value for the range.
         * @return The central value.
         */
        public function getCentralValue():Number
            {
            return (min + max) / 2 ;
            }
        
        /**
         * Returns a random floating-point number between two numbers.
         * @param r The Range object to limit the result of the function.
         * @return a random floating-point number between two numbers.
         */
        public static function getRandomFloat( r:Range ):Number
            {
            return Math.random() * ( r.max - r.min ) + r.min ;    
            }
        
        /**
         * Returns a random integer number between two numbers.
         * @param r The Range object to limit the result of the function.
         * @return a random integer number between two numbers.
         */
        public static function getRandomInteger( r:Range ):Number
            {
            return Math.floor( getRandomFloat(r) ) ;
            }
    
        /**
         * Returns <code class="prettyprint">true</code> if the value is out of the range.
         * @return <code class="prettyprint">true</code> if the value is out of the range.
         */
        public function isOutOfRange(value:Number):Boolean 
            {
            return (value > max ) || (value < min) ;
            }
    
        /**
         * Returns <code class="prettyprint">true</code> if the range in argument overlap the current range.
         * @return <code class="prettyprint">true</code> if the range in argument overlap the current range.
         */
        public function overlap(r:Range):Boolean 
            {
            return max >= r.min && r.max >= min ;
            }
        
        /**
         * Returns the length of the range.
         * @return the length of the range.
         */
        public function size():Number
            {
            return max - min ;    
            }
   
        /**
         * Returns the Eden representation of the object.
         * @return the string representing the source code of the object.
         */
        public function toSource( indent:int = 0 ):String  
            {
            return "new system.numeric.Range(" + min + "," + max + ")";
            }

        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
            {
            return "[Range<" + min + "," + max + ">]";
            }
        
        }
    
    }