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
	 * The Regular class defines three easing functions to implement motion with ActionScript animations. 
	 * @author eKameleon
	 */
	public class Regular
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
			return -c/2 * ( (--t) * ( t-2 ) - 1 ) + b;
		}

		public static function easeOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return -c * ( t/=d ) * ( t-2 ) + b ;
		}		
		
	}
}
