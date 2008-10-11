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
	 * The Bounce class defines three easing functions to implement bouncing motion with ActionScript animation, 
	 * similar to a ball falling and bouncing on a floor with several decaying rebounds.
	 * @author eKameleon
	 */
	public class Bounce 
	{

		/**
		 * The <code class="prettyprint">easeIn()</code> method starts the bounce motion slowly and then accelerates motion as it executes. 
		 * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * @return The value of the interpolated property at the specified time.
		 */
		public static function easeIn ( t:Number, b:Number, c:Number, d:Number ):Number 
		{
			return c - easeOut( d - t , 0 , c , d ) + b;
		}
		
		/**
		 * The <code class="prettyprint">easeInOut()</code> method combines the motion of the <code class="prettyprint">easeIn()</code> and <code class="prettyprint">easeOut()</code> methods 
		 * to start the motion by backtracking, then reversing direction and moving toward the target, overshooting the target slightly, 
		 * reversing direction again, and then moving back toward the target.
		 * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * @return The value of the interpolated property at the specified time.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number 
		{
			return (t < d/2) ? easeIn(t * 2, 0, c, d) * 0.5 + b : easeOut(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b ;
		}
		
		/**
		 * The <code class="prettyprint">easeOut()</code> method starts the bounce motion fast and then decelerates motion as it executes.
		 * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * @return The value of the interpolated property at the specified time.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number ):Number 
		{
			if ((t /= d) < (1 / 2.75))
			{
				return c * (7.5625 * t * t) + b;
			}
			else if (t < (2 / 2.75))
			{
				return c * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75) + b ;
			}
			else if (t < (2.5 / 2.75))
			{
				return c * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375) + b ;
			}
			else
			{
				return c * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375) + b ;
			}
		}
		
	}
}
