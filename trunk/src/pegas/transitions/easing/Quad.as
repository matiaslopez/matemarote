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
	 * The Quad class defines three easing functions to implement motion with ActionScript animations.
	 * The word quadratic refers to the fact that the equation for this motion is based on a squared variable, in this case, 
	 * t² : p(t) = t² 
	 * @author eKameleon
	 */
	public class Quad
	{

		public static function easeIn ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return c * (t/=d) * t + b ;
		}
	
		public static function easeInOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			if ((t/=d/2) < 1) 
			{
				return c/2 * t * t + b ;
			}
			return -c/2 * ((--t)*(t-2) - 1) + b ;
		}

		public static function easeOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return -c * (t/=d) * ( t - 2 ) + b ;
		}		
		
	}
}
