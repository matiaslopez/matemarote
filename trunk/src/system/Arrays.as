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
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Marc Alcaraz <ekameleon@gmail.com>

*/
package system
    {
    
    /**
     * A static class for Array utilities.
     */
	public class Arrays
		{
        
        /**
         * Returns whether the Array contains a particular item.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * 
         * var ar:Array = [2, 3, 4] ;
         * 
         * trace( Arrays.contains(ar, 3) ) ; // true
         * trace( Arrays.contains(ar, 5) ) ; // false
         * </pre>
         * @param ar The search Array.
         * @param value The value to search.
         * @return whether the Array contains a particular item.
         */
        public static function contains( ar:Array , value:Object):Boolean 
            {
            return ar.indexOf(value) > -1 ;
            }
        
		/**
		 * Initializes a new Array with an arbitrary number of elements (index), 
		 * with every element containing the passed parameter value or by default the null value.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var test:Array  = Arrays.initialize( 3 ); //define [null,null,null]
		 * var test1:Array = Arrays.initialize( 3, 0 ); //define [0,0,0]
		 * var test2:Array = Arrays.initialize( 3, true ); //define [true,true,true]
		 * var test3:Array = Arrays.initialize( 3, "" ); //define ["","",""]
		 * </pre>
		 * @return a new Array with an arbitrary number of elements (index), 
		 * with every element containing the passed parameter value or by default the null value.
		 */
        public static function initialize( elements:uint = 0, value:* = null ):Array
            {
            var arr:Array = [];
            
            for( var i:int = 0; i<elements; i++ )
                {
                arr.push( value );
                }
            
            return arr;
            }
        
        /**
         * Apply a function simultaneously against two values of the array (from left-to-right) as to reduce it to a single value.
         * <p>The <code class="prettyprint">reduce</code> method executes the callback function once for each element present in the array, excluding holes in the array, receiving four arguments: the initial value (or value from the previous callback call), the value of the current element, the current index, and the array over which iteration is occurring.</p> 
         * <p>This method reduce is an extension to the ECMA-262 standard; (see Javascript 1.8 new implementation) as such it may not be present in other implementations of the standard.</p> 
         * <p>The call to the reduce callback would look something like this:</p>
         * <pre class="prettyprint">
         * function callback( previousValue:* , currentValue:* , index:uint , array:Array ):*
         * {
         *     // ...
         * }
         * </pre>
         * <p>The first time the function is called, the <code class="prettyprint">previousValue</code> and <code class="prettyprint">currentValue</code> can be one of two values. 
         * If an <code class="prettyprint">initialValue</code> was provided in the call to reduce, then <code class="prettyprint">previousValue</code> will be equal to <code class="prettyprint">initialValue</code> and <code class="prettyprint">currentValue</code> will be equal to the first value in the array. 
         * If no initialValue was provided, then <code class="prettyprint">previousValue</code> will be equal to the first value in the array and <code class="prettyprint">currentValue</code> will be equal to the second.</p>
         * <p><b>Basic example : </b></p> 
         * <p><b>Example : </b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * 
         * var ar:Array ;
         * var result:* ;
         * var callback:Function ;
         * 
         * ////// only to debug in the the Array trace message
         * Array.prototype.toString = function():String
         * {
         *     return "[" + this.join(",") + "]" ;
         * }
         * //////
         *  
         * ar = [0,1,2,3,4] ;
         * 
         * callback = function( previousValue:* , currentValue:* , index:int, array:Array ):*
         * {
         *     trace( "previousValue = " + previousValue + ", currentValue = " + currentValue + ", index = " + index ) ;
         *     return previousValue + currentValue ;
         * } ;
         * 
         * ////
         * 
         * result = Arrays.reduce( ar , callback ) ;
         *  
         * // previousValue = 0, currentValue = 1, index = 1 // First call
         * // previousValue = 1, currentValue = 2, index = 2 // Second call
         * // previousValue = 3, currentValue = 3, index = 3 // Third call
         * // previousValue = 6, currentValue = 4, index = 4 // Fourth call
         *  
         * trace( "value : " + result ) ;  // value : 10
         * 
         * ////
         * 
         * result = Arrays.reduce( ar , callback , 10 ) ;
         *  
         * // previousValue = 10, currentValue = 0, index = 0
         * // previousValue = 10, currentValue = 1, index = 1
         * // previousValue = 11, currentValue = 2, index = 2
         * // previousValue = 13, currentValue = 3, index = 3
         * // previousValue = 16, currentValue = 4, index = 4
         * 
         * trace( "value : " + result ) ;  // value : 20
         * 
         * ////
         * 
         * // array is always the object [0,1,2,3,4] upon which reduce was called
         * trace( "ar : " + ar ) ; // ar : 0,1,2,3,4
         * 
         * trace("--- Example: Sum up all values within an array") ;
         * 
         * ar = [0, 1, 2, 3] ;
         * 
         * callback = function( a:uint , b:uint , ...args:Array ):*
         * {
         *     return a + b ; 
         * }
         * 
         * result = Arrays.reduce( ar , callback );
         * trace("total : " + result ) ; // total == 6
         * 
         * trace("--- Example: Flatten an array of arrays") ;
         * 
         * ar = [[0,1], [2,3], [4,5]] ;
         * callback = function( a:Array , b:Array , ...args:Array ):*
         * {
         *     return a.concat( b ) ;
         * }
         * 
         * result = Arrays.reduce( ar , callback , [] ) ;
         * trace("flattened is " + result ) ; // flattened is [0, 1, 2, 3, 4, 5]
         * </pre>
         * @param callback Function to execute on each value in the Array.
         * @param initialValue The object to use as the first argument to the first call of the callback. 
         */
        public static function reduce( ar:Array , callback:Function, initialValue :* = undefined ):*
            {
            var size:int = ar.length ;
            
            if ( callback == null )
                {
                throw new ArgumentError( "Arrays.reduce failed, the callback method not must be 'null' or 'undefined'." ) ;	
                }
            
            if ( size == 0 )
                {
                throw new Error( "Arrays.reduce failed, the array contains no values." ) ;
                }
            
            var i:int ;
            var r:*   ;
             
            if ( initialValue != undefined )
                {
            	r = initialValue ;
                }
            else
                {
                do
                    {
                    if ( i in ar )
                        {
                        r = ar[i++] ;
                        break ;
                        }
                    
                    if ( ++ i > size )
                        {
                        throw new Error( "Array.reduce failed, if array contains no values, no initial value to return." ) ;	
                        }
                    
                    }
                while( true ) ;
                }
            
            for ( ; i < size ; i++ )
                {
                if (i in ar)
                    {
                    r = callback.call(null, r, ar[i], i , ar );
                    }
                }

            return r;
            }        
        
        /**
         * Apply a function simultaneously against two values of the array (from right-to-left) as to reduce it to a single value.
         * <p>The <code class="prettyprint">reduceRight</code> method executes the callback function once for each element present 
         * in the array, excluding holes in the array, receiving four arguments: the initial value 
         * (or value from the previous callback call), the value of the current element, the current index, and 
         * the array over which iteration is occurring.</p>
         * <p>The call to the <code class="prettyprint">reduceRight</code> callback would look something like this :</p>
         * <pre class="prettyprint">
         * function callback( previousValue:* , currentValue:* , index:uint , array:Array ):*
         * {
         *     // ...
         * }
         * </pre>
         * <p>The first time the function is called, the <code class="prettyprint">previousValue</code> and <code class="prettyprint">currentValue</code> can be one of two values.  
         * If an <code class="prettyprint">initialValue</code> was provided in the call to <code class="prettyprint">reduceRight</code>, 
         * then <code class="prettyprint">previousValue</code> will be equal to <code class="prettyprint">initialValue</code> 
         * and <code class="prettyprint">currentValue</code> will be equal to the last value in the array. 
         * If no <code class="prettyprint">initialValue</code> was provided, then <code class="prettyprint">previousValue</code> 
         * will be equal to the last value in the array and currentValue will be equal to the second-to-last value.</p> 
         * <p><b>Example : </b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * 
         * var ar:Array ;
         * var result:* ;
         * var callback:Function ;
         * 
         * ////// only to debug in the the Array trace message
         * Array.prototype.toString = function():String
         * {
         *     return "[" + this.join(",") + "]" ;
         * }
         * //////
         * 
         * ar = [0,1,2,3,4] ;
         * 
         * callback = function( previousValue:* , currentValue:* , index:int, array:Array ):*
         * {
         *     trace( "previousValue = " + previousValue + ", currentValue = " + currentValue + ", index = " + index ) ;
         *     return previousValue + currentValue ;
         * } ;
         * 
         * result = Arrays.reduceRight( ar , callback ) ;
         * // previousValue = 4, currentValue = 3, index = 3 // First call
         * // previousValue = 7, currentValue = 2, index = 2 // Second call
         * // previousValue = 9, currentValue = 1, index = 1 // Third call
         * // previousValue = 10, currentValue = 0, index = 0 // Fourth call
         * trace( "value : " + result ) ;  // value : 10
         * 
         * result = Arrays.reduceRight( ar , callback , 10 ) ;
         * // previousValue = 10, currentValue = 4, index = 4
         * // previousValue = 14, currentValue = 3, index = 3
         * // previousValue = 17, currentValue = 2, index = 2
         * // previousValue = 19, currentValue = 1, index = 1
         * // previousValue = 20, currentValue = 0, index = 0
         * trace( "value : " + result ) ;  // value : 20
         * 
         * // array is always the object [0,1,2,3,4] upon which reduce was called
         * 
         * trace( "ar : " + ar ) ; // ar : [0,1,2,3,4]
         * 
         * trace("--- Example: Sum up all values within an array") ;
         * 
         * ar = [0, 1, 2, 3] ;
         * 
         * callback = function( a:uint , b:uint , ...args:Array ):*
         * { 
         *     return a + b ;
         * }
         * 
         * result = Arrays.reduceRight( ar , callback );
         * trace("total : " + result ) ; // total == 6
         * 
         * trace("--- Example: Flatten an array of arrays") ;
         * 
         * ar = [[0,1], [2,3], [4,5]] ;
         * 
         * callback = function( a:Array , b:Array , ...args:Array ):*
         * {
         *     return a.concat( b ) ;
         * }
         * 
         * result = Arrays.reduceRight( ar , callback , [] ) ;
         * trace("flattened is " + result ) ; // flattened is [4, 5, 2, 3, 0, 1]
         * </pre>
         * @param callback Function to execute on each value in the Array.
         * @param initialValue The object to use as the first argument to the first call of the callback. 
         */
        public static function reduceRight( ar:Array , callback:Function, initialValue :* = undefined ):*
            {
            var size:int = ar.length ;
            
            if ( callback == null )
                {
                throw new ArgumentError( "Arrays.reduceRight failed, the callback method not must be 'null' or 'undefined'." ) ; 
                }
            
            if ( size == 0 )
                {
                throw new Error( "Arrays.reduceRight failed, the array contains no values." ) ;
                }
            
            var i:int = size - 1;
            var r:*   ;
             
            if ( initialValue != undefined )
                {
                r = initialValue ;
                }
            else
                {
                do
                    {
                    if ( i in ar )
                        {
                        r = ar[i--] ;
                        break ;
                        }
                    
                    if ( -- i < 0 )
                        {
                        throw new Error( "Array.reduce failed, if array contains no values, no initial value to return." ) ;    
                        }
                    
                    }
                while( true ) ;
                }
            
            for ( ; i >= 0 ; i-- )
                {
                if (i in ar)
                    {
                    r = callback.call(null, r, ar[i], i , ar );
                    }
                }

            return r;
            }         
        
        /**
         * Returns a new Array who contains the specified Array elements repeated count times.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * 
         * var ar:Array = [2, 3, 4] ;
         * 
         * trace( Arrays.repeat(ar, 0) ) ; // 2,3,4
         * trace( Arrays.repeat(ar, 3) ) ; // 2,3,4,2,3,4,2,3,4
         * </pre>
         * @return a new Array who contains the specified Array elements repeated count times.
         */
        public static function repeat( ar:Array , count:uint=0 ):Array
            {
            var result:Array = [] ;
            if ( count > 0 )
                {
                for( var i:uint = 0 ; i<count ; i++)
                    {
                    result = result.concat(ar) ;
                    }
                }
            else
                {
                result = [].concat(ar) ;    
                }
            return  result ;
            }
        
		/** 
		 * Splice one array into another.
		 * Like the python 
		 * <pre class="prettyprint">
  		 * container[containerPosition:containerPosition + countReplaced] = inserted
  		 * </pre>
  		 * @example
		 * <pre class="prettyprint">
  		 * import system.Arrays ;
  		 * 
  		 * var inserted:Array  ;
  		 * var container:Array ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * trace( "inserted  : " + inserted  ) ;
  		 * trace( "container : " + container ) ;
  		 * 
  		 * trace("---") ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 0 ) : " + container ) ; // 1,2,3,4,5,6,7,8
  		 * 
  		 * trace("---") ;
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container, 0 , 4 ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4
  		 * 
  		 * trace("---") ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container, 0 , 2 ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4,7,8
  		 * </pre>
  		 * @param inserted The Array of char inserted in the Array container.
  		 * @param container The container modified in place.
  		 * @param containerPosition The position in the container to inserted the Array of chars.
  		 * @param countReplaced The count value to replaced values.
  		 */
		public static function spliceInto( inserted:Array, container:Array, containerPosition:Number=0 , countReplaced:Number=0 ):void
			{
  			inserted.unshift( containerPosition, isNaN( countReplaced ) ? 0 : countReplaced );
  			
  			try 
  				{
    			container.splice.apply( container, inserted ) ;
  				} 
  			finally 
  				{
    			inserted.splice(0, 2) ;
  				}
			}

        }
    
    }

