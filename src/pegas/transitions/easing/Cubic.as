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
	 * The Cubic class defines three easing functions to implement motion with ActionScript animations. 
	 * A cubic equation is based on the power of three : p(t) = t * t * t
	 * @author eKameleon
	 */
	public class Cubic
	{

		public static function easeIn ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return c * (t/=d) * t * t + b ;
		}
	
		public static function easeInOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			if ((t/=d/2) < 1) 
			{
				return c/2 * t* t* t + b ;
			}
			return c/2 * ( (t-=2) * t * t + 2 ) + b ;
		}

		public static function easeOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return c * ( ( t = t/d-1 ) * t * t + 1 ) + b;
		}		
		
	}
}
