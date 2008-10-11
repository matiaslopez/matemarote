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
package pegas.util 
{

    /**
     * Implements the static behaviours of the trigometric manipulations.
     * <p>Thanks : <b>Robert Penner</b>, Robert Penner's Programming Macromedia Flash MX
     * <ul>
     * <li><a href="http://www.robertpenner.com/profmx">http://www.robertpenner.com/profmx</a></li>
     * <li><a href="http://www.amazon.com/exec/obidos/ASIN/0072223561/robertpennerc-20">http://www.amazon.com/exec/obidos/ASIN/0072223561/robertpennerc-20</a></li>
     * </ul>
     * </p>
     */
    public class Trigo 
    {
        
        /**
         * This constant change degrees to radians : <b>Math.PI/180</b>.
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.DEG2RAD * 180) ;
         * </code>
         */
        public static const DEG2RAD:Number = 0.0174532925199433;
        
        /**
         * This constant change radians to degrees : <b>180/Math.PI</b>.
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.RAD2DEG * Math.PI) ;
         * </code>
         */
        public static const RAD2DEG:Number = 57.2957795130823;
        
        /**
         * This constant is the golden mean (phi) : <b>( 1 + Math.sqrt(5) ) / 2</b>.
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.PHI) ;
         * </code>
         */
        public static const PHI:Number = 1.61803398874989;
        
        /**
         * This constant is the Euler-Mascheroni constant (lambda or C) :
         * <p>
         * <code class="prettyprint">
         * ( n )
         * lim( sigma 1/k - ln(n) )
         * n->oo    ( k=1 )
         * </code>
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.LAMBDA) ;
         * </code>
         */
        public static const LAMBDA:Number = 0.57721566490143;
        
        /**
         * Returns the inverse cosine of a slope ratio and returns its angle in degrees.
         * @param ratio a value between -1 and 1 inclusive.
         * @return the inverse cosine of a slope ratio and returns its angle in degrees.
         */
        public static function acosD (ratio:Number) : Number 
        {
            return Math.acos(ratio) * RAD2DEG ;
        }
        
        /**
         * Returns the angle in degrees between 2 points with this coordinates passed in argument.
         * @param x1 the x coordinate of the first point.
         * @param y1 the y coordinate of the first point.
         * @param x2 the x coordinate of the second point.
         * @param y2 the y coordinate of the second point.
         * @return the angle in degrees between 2 points with this coordinates passed in argument.
         */
        public static function angleOfLine (x1:Number, y1:Number, x2:Number, y2:Number):Number 
        {
            return Trigo.atan2D (y2 - y1, x2 - x1) ;
        }
        
        /**
         * Calculates the arcsine of the passed angle.
         * @param ratio a value between -1 and 1 inclusive.
         * @return the arcsine of the passeds angle in degrees.
         */
        public static function asinD (ratio:Number) : Number 
        {
            return Math.asin(ratio) * RAD2DEG ;
        }
    
        /**
         * Calculates the arctangent of the passed angle.
         * @param n a real number
         * @return the arctangent of the passed angle, a number between -Math.PI/2 and Math.PI/2 inclusive.
         */
        public static function atanD( angle:Number ):Number 
        {
            return Math.atan( angle ) * RAD2DEG ;
        }
    
        /**
         * Calculates the arctangent2 of the passed angle.
         * @param y a value representing y-axis of angle vector.
         * @param x a value representing x-axis of angle vector.
         * @return the arctangent2 of the passed angle.
         */
        public static function atan2D( y:Number , x:Number ):Number 
        {
            return Math.atan2(y, x) * RAD2DEG ;
        }
            
        /**
         * Converts a vector in cartesian in a polar vector.
         * @return a vector in cartesian in a polar vector.
         */
        public static function cartesianToPolar( p:* ):Object 
        {
            return ( { r : Math.sqrt (p.x * p.x + p.y * p.y) , t : Trigo.atan2D (p.y , p.x) } ) ;
        }    
    
        /**
         * Calculates the cosine of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the cosine of the passed angle, a number between -1 and 1 inclusive.
         */
        public static function cosD(angle:Number):Number 
        {
            return Math.cos( angle * DEG2RAD ) ;
        }
        
        /**
         * Converts an angle in degrees in radians
         * @return an angle in degrees in radians.
         */
        public static function degreesToRadians (angle:Number) : Number 
        {
            return angle * DEG2RAD ;
        }
        
        /**
         * Returns the distance between 2 points with the coordinates of the 2 points.
         * @param x1 the x coordinate of the first point.
         * @param y1 the y coordinate of the first point.
         * @param x2 the x coordinate of the second point.
         * @param y2 the y coordinate of the second point.
         * @return the length between 2 points.
         */
        public static function distance (x1:Number, y1:Number, x2:Number, y2:Number):Number 
        {
            var dx:Number = x2 - x1 ;
            var dy:Number = y2 - y1 ;
            return Math.sqrt (dx * dx + dy * dy ) ;
        }
        
        /**
         * Returns the distance between 2 points with the coordinates of the 2 points.
         * @param p1 the first point to determinate the distance.
         * @param p2 the second point to determinate the distance.
         * @return the length between 2 points.
         */
        public static function distanceP( p1:* , p2:* ) : Number 
        {
            return distance(p1.x, p1.y, p2.x, p2.y) ;
        }
        
        /**
         * Fixs an angle in degrees between 0 and 360 degrees.
         * @param angle the passed angle value in degrees.
         * @return an angle in degrees between 0 and 360 degrees. 
         */
        public static function fixAngle (angle:Number):Number 
        {
            if ( isNaN(angle) ) 
            {    
                angle = 0 ;
            }
            angle %= 360 ;
            return (angle < 0) ? angle + 360 : angle ;
        }
        
        /**
         * Converts an angle in radians in degrees.
         * @return an angle in radians in degrees.
         */
        public static function radiansToDegrees (angle:Number) : Number 
        {
            return angle * RAD2DEG ;
        }
            
        /**
         * Converts a vector in polar in a cartesian vector.
         * @return a vector in polar in a cartesian vector.
         */
        public static function polarToCartesian (p:Object) : Object 
        {
            return ( { x : p.r * Trigo.cosD (p.t) , y : p.r * Trigo.sinD (p.t) } ) ;
        }
        
        /**
         * Calculates the sine of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the sine of the passed angle, a number between -1 and 1 inclusive.
         */
        public static function sinD(angle:Number):Number 
        {
            return Math.sin( angle * DEG2RAD ) ;
        }
        
        /**
         * Calculates the tangent of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the tangent of the passed angle.
         */
        public static function tanD(angle:Number):Number 
        {
            return Math.tan( angle * DEG2RAD ) ;
        }
        
    }
}
