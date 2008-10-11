/*
	LICENCE
	
		Easing Equations v2.0
		September 1, 2003
		(c) 2003 Robert Penner, all rights reserved. 
		This work is subject to the terms in http://www.robertpenner.com/easing_terms_of_use.html.
		
*/	

package pegas.transitions.easing 
{

	/**
	 * The Expo class defines three easing functions to implement motion with ActionScript animations.
	 * I based my exponential functions on the number 2 raised to a multiple of 10 : p(t) = 2^10(t-1)
	 * @author eKameleon
	 */
	public class Expo
	{

		public static function easeIn ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b ;
		}
	
		public static function easeInOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			if (t==0) 
			{
				return b ;
			}
			if ( t==d )
			{
				return b+c;
			}
			if ((t/=d/2) < 1) 
			{
				return c/2 * Math.pow(2, 10 * (t - 1)) + b;
			}
			return c/2 * (-Math.pow(2, -10 * --t) + 2) + b ;
		}

		public static function easeOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return (t==d) ? ( b + c ) : ( c * (-Math.pow(2, -10 * t/d) + 1) + b ) ;
		}		
		
	}
}
