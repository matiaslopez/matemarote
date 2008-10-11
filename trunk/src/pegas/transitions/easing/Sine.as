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
	 * The Sine class defines three easing functions to implement motion with ActionScript animations.
	 * A sinusoidal equation is based on a sine or cosine function. 
	 * Either one produces a sine wave—a periodic oscillation of a specific shape. 
	 * This is the equation on which I based the easing curve : p(t) = sin( t * Math.PI / 2 ) 
	 * @author eKameleon
	 */
	public class Sine
	{

		public static function easeIn ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return -c * Math.cos(t/d * (Math.PI/2)) + c + b ;
		}
	
		public static function easeInOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b ;
		}

		public static function easeOut ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return c * Math.sin(t/d * (Math.PI/2)) + b ;
		}		
		
	}
}
