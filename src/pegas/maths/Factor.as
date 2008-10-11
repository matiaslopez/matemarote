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

package pegas.maths 
{

    /**
	 * Implements the static behaviours of the Factor Class.
	 * @author eKameleon
 	 */
	public class Factor 
	{
		
		/**
		 * Returns the factorial of a positive integer.
		 * @param n The value to use to calculate the factorial product.
		 * @return the factorial of a positive integer.
		 */
		public static function factorial( n:uint ):uint 
		{
			if ( n == 0 ) 
			{
				return 1 ;
			}
			else 
			{
				n -= n%1 ; // no decimal number
				var result:Number = n ;
				while (--n > 1)
				{
					result *= n ;
					if ( result == Number.POSITIVE_INFINITY ) // optimization AS2 the Infinity value is return with a value >= 171
					{
						return Infinity ;
					}
				}
				return result;
			}
    	}

		/**
		 * Uses the Gamma function to approximate factorial - very fast.
		 */
		public static function factorialApprox( n:Number ):Number 
		{
        	return Math.round( Factor.gammaApprox(n+1) ) ;
    	}
		
		/**
		 * Calculates total fibonacci levels in 'n'.
	 	 */
		public static function fibonacci( n:Number ):Number 
		{
        	return Math.round((Math.pow((1+Math.sqrt(5))/2,n)-Math.pow((1-Math.sqrt(5))/2,n))/Math.sqrt(5));
    	}

		/**
		 * Extends the domain of the factorial function by calculating the factorial of decimal numbers.
		 */
		public static function gammaApprox(n:Number):Number 
		{
        	var x:Number = n - 1 ;
        	return Math.sqrt( (2*x+1/3) * Math.PI ) * Math.pow(x,x) * Math.exp(-x) ;
    	}
		
		/**
		 * Defines the inverse of a number.
		 */
	    public static function inverse(n:Number):Number 
    	{
	        return 1/n ;
	    }
		
		/**
		 * Defines the logarithm with base 'a' of 'n'.
		 */
	    public static function ln(n:Number):Number 
	    {
        	return Math.log(n) ;
    	}
		
		/**
		 * Defines the logarithm with base 'a' of 'n'.
		 * @param a :Number a real number for 'log base'.
	 	 * @param n :Number a real number.
		 * @return returns the logarithm with base 'a' of 'n'.
		 */
	    public static function logA(a:Number, n:Number):Number 
    	{
    	    return Math.log(n) / Math.log(a) ;
    	}

		/**
		 * Defines the nth root of a number.
		 */
	    public static function nRoot( a:Number , n:Number ):Number 
    	{
	        return Factor.pow(a, 1/n) ;
    	}

		/**
		 * Solves the negative value input bug.
		 */
		public static function pow( a:Number , n:Number ):Number 
		{
	        return a==0 ? 0 : (a>0 ? Math.pow(a,n) : Math.pow(a*-1,n)*-1) ;
	    }

		/**
		 * Calculates the product of factors of 'n'.
		 */
		public static function productFactors( n:Number ):Number 
		{
	        var k:Number = 1 ;
        	for (var i:Number=3; i<=n; i+=2) 
        	{
	        	if (Prime.isPrime(i)) 
        		{
	        		k *= i ;
        		}
        	}
        	if (n>2) 
        	{
	        	k *= 2;
        	}
        	return k;
    	}

		/**
		 * Defines the square value of a number.
		 */
	    public static function square(n:Number):Number 
    	{	
	        return n*n ;
	    }

		/**
		 * Defines the sum of all the numbers between 1 and 'n' raised to the 'x' power.
		 */
		public static function summation(n:Number, x:Number):Number 
		{	
    	    var sum:Number = 0 ;
			for (var i:Number = 1; i<=n; i++) 
			{
				sum += Math.pow(i, x) ;
			}
        	return sum ;
    	}
		
	}

}
