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
	 * The Back class defines three easing functions to implement motion with ActionScript animations. 
	 * @author eKameleon
	 */
	public class Back 
	{
		
		/**
		 * The <code class="prettyprint">easeIn()</code> method starts the motion by backtracking and then reversing direction and moving toward the target.
		 * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * @param s Specifies the amount of overshoot, where the higher the value, the greater the overshoot.
		 * @return The value of the interpolated property at the specified time.
		 */
		public static function easeIn ( t:Number, b:Number, c:Number, d:Number, s:Number=0 ):Number 
		{
			if ( !s ) 
			{
				s = 1.70158;
			}
			return c * (t/=d) * t * ( (s+1) * t -  s) + b ;
		}
		
		/**
		 * The <code class="prettyprint">easeInOut()</code> method combines the motion of the <code class="prettyprint">easeIn()</code> and <code class="prettyprint">easeOut()</code> methods 
		 * to start the motion by backtracking, then reversing direction and moving toward the target, overshooting the target slightly, 
		 * reversing direction again, and then moving back toward the target.
		 * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * @param s Specifies the amount of overshoot, where the higher the value, the greater the overshoot.
		 * @return The value of the interpolated property at the specified time.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number, s:Number=0 ):Number 
		{
			if ( !s ) 
			{
				s = 1.70158;
			} 
			if ((t/=d/2) < 1) 
			{
				return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			}
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		}
		
		/**
		 * The <code class="prettyprint">easeOut()</code> method starts the motion by moving towards the target, overshooting it slightly, 
		 * and then reversing direction back toward the target.
		 * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * @param s Specifies the amount of overshoot, where the higher the value, the greater the overshoot.
		 * @return The value of the interpolated property at the specified time.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number, s:Number=0 ):Number 
		{
			if ( !s ) 
			{
				s = 1.70158;
			}
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
		
	}
}
