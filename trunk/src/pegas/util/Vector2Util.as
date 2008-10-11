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
    import pegas.geom.Vector2;        		

    /**
	 * Static tool class to manipulate and transform <code class="prettyprint">Vector2</code> references.
	 */
	public class Vector2Util 
	{
		
		/**
		 * Computes the addition of two Vector2 and returns the first vector.
		 * @param v1 the first Vector2.
		 * @param v2 the second Vector2.
		 */
		public static function addition( v1:Vector2, v2:Vector2 ):void
		{
		 	v1.x += v2.x ;
		 	v1.y += v2.y ;
		}
		
		/**
		 * Computes the addition of two Vector2.
		 * @param v1 a Vector2 to concat.
		 * @param v2 a Vector2 to concat.
		 * @return the addition result of two Vector2.
		 */
		public static function getAddition( v1:Vector2, v2:Vector2 ):Vector2
		{
		return new Vector2( (v1.x + v2.x) , (v1.y + v2.y) ) ;	
		}
	
		/**
	 	 * Returns the distance between the 2 vectors in argument.
		 * @param v1 the first vector.
		 * @param v2 the second vector.
		 * @return the distance between the 2 vectors in argument.
	 	 */
		public static function getDistance( v1:Vector2, v2:Vector2 ):Number
		{
			return Math.sqrt( Vector2Util.getSquaredDistance( v1, v2 ) ) ;
		}
		
		/**
		 * Returns the length of the vector.
		 * @param v the vector.
		 * @return the length of the vector.
		 */
		public static function getLength( v:Vector2 ):Number
		{
			return Math.sqrt( (v.x * v.x) + (v.y * v.y) ) ;
		}
		
		/**
	 	 * Returns the middle Vector2 between 2 Points.
		 * <p><b>Example :</b></p>
		 * <code class="prettyprint">
		 * var p1:Vector2 = new Vector2(10,10) ;
		 * var p2:Vector2 = new Vector2(20,20) ;
		 * var middle:Vector2 = Vector2Util.getMiddle(p1,p2) ;
		 * trace(middle) ;
		 * </code>
	 	 * @return the middle Point between 2 Points.
		 */
		public static function getMiddle(p1:Vector2, p2:Vector2):Vector2 
		{
			return new Vector2( (p1.x + p2.x) / 2 , (p1.y + p2.y) / 2) ;
		}
		
		/**
		 * Normalizes the Vector2 instance passed in argument and returns a new Vector2 representation.
		 * @param v the Vector2 to normalize.
		 * @return a normalized Vector2, with length 1.
		 */
		public static function getNormalize( v:Vector2 ):Vector2
		{
			var len:Number = 1 / Vector2Util.getLength(v) ;
			return Vector2Util.getScale( v , len ) ;
		}
		
		/**
		 * Computes the power of the specified Vector2.
		 * @param v the Vector2 reference.
		 * @param value the value of the pow..
		 * @return A new Vector2 powered by the method.
		 */
		public static function getPow( v:Vector2, value:Number ):Vector2
		{
			return new Vector2( Math.pow( v.x, value ) , Math.pow( v.y, value ) ) ;
		}
		
		/**
		 * Scales the specified Vector2 with the input value.
		 * @param vector the Vector2 reference to transform.
		 * @param value a real number to scale the current Vector2.
		 * @return A new Vector2 scaled by the value passed in second argument in this method.
		 */
		public static function getScale( v:Vector2, value:Number ):Vector2
		{
			return new Vector2 ( v.x * value , v.y * value ) ;
		}
		
		/**
		 * Returns the squared distance between 2 vectors.
		 * @param v1 the first vector.
		 * @param v2 the second vector.
		 * @return the squared distance between 2 vectors.
		 */
		public static function getSquaredDistance( v1:Vector2, v2:Vector2 ):Number
		{
			var dx:Number= v2.x - v1.x ;
			var dy:Number= v2.y - v1.y ; 
			return (dx * dx) + (dy * dy) ;
		}
			
		/**
		 * Returns the squared length of this vector.
	 	 * @param v the vector.
		 * @return the squared length of this vector.
		 */
		public static function getSquaredLength( v:Vector2 ):Number
		{
			return (v.x * v.x) + (v.y * v.y) ;
		}
		
		/**
		 * Computes the substraction of two Vector2.
		 * @param v1 a Vector2 to substract.
	 	 * @param v2 a Vector2 to substract.
		 * @return the substraction result of two Vector2.
		 */
		public static function getSubstraction( v1:Vector2 , v2:Vector2 ):Vector2
		{
			return new Vector2( (v1.x - v2.x) , (v1.y - v2.y) ) ;
		}
		
        /**
         * Determines a point between two specified points. 
         * The parameter f determines where the new interpolated point is located relative to the two end points specified by parameters {@code p1} and {@code p2}. 
         * The closer the value of the parameter f is to 1.0, the closer the interpolated point is to the first point (parameter {@code p1}). 
         * The closer the value of the parameter f is to 0, the closer the interpolated point is to the second point (parameter {@code p2}).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Vector2 ;
         * import pegas.util.Vector2Util ;
         * 
         * var v1:Vector2 = new Vector2(10,10) ;
         * var v2:Vector2 = new Vector2(40,40) ;
         * var v3:Vector2 ;
         * 
         * v3 = Vector2Util.interpolate( v1 , v2, 0 ) ;
         * trace(v3) ; // [Vector2:{40,40}]
         * 
         * v3 = Vector2Util.interpolate( v1 , v2, 1 ) ;
         * trace(v3) ; // [Vector2:{10,10}]
         * 
         * v3 = Vector2Util.interpolate( v1 , v2, 0.5 ) ;
         * trace(v3) ; // [Vector2:{25,25}]
         * </pre>
         * @param p1 The first point.
         * @param p2 The second Point.
         * @param f the The level of interpolation between the two points. Indicates where the new point will be, along the line between {@code p1} and {@code p2}. If f=1, pt1 is returned; if f=0, pt2 is returned.
         * @return The new interpolated Vector2 object.
         */
        public static function interpolate(v1:Vector2, v2:Vector2, f:Number):Vector2 
        {
            return new Vector2( v2.x + f * (v1.x - v2.x) , v2.y + f * (v1.y - v2.y) ) ;
        }		
		
        /**
         * Scales the line segment between (0,0) and the current point to a set length.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Vector2 ;
         * import pegas.util.Vector2Util ;
         * 
         * var v:Vector2 = new Vector2(0,5) ;
         * 
         * Vector2Util.normalize(v) ;
         * 
         * trace(v) ; // [Point:{0,1}]
         * </pre>
         * @param thickness The scaling value. For example, if the current point is (0,5), and you normalize it to 1, the point returned is at (0,1).
         * @throws Error if a zero-length vector or a illegal NaN value is calculate in this method.
         */
        public static function normalize( v:Vector2, thickness:Number=1 ):void 
        {
            if ( isNaN(thickness) )
            {
                thickness = 1 ; 
            }
            var l:Number = getLength(v) ;
            if (l > 0) 
            {
                l = thickness / l ;
                v.x *= l ;
                v.y *= l ;
            }
            else
            {
                throw new Error( "Vector2Util.normalize method failed with a zero-length vector or a illegal NaN value." ) ;
            }
        }	
        
        /**
         * Rotates the Vector2 object with the specified angle passed-in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Vector2 ;
         * import pegas.util.Vector2Util ;
         * 
         * var v:Vector2 = new Vector2(100,100) ;
         * Vector2Util.rotate(v, Math.PI) ;
         * trace(v) ;
         * </pre> 
         * @param angle the Angle to rotate the specified Vector2 object.
         */
        public static function rotate( v:Vector2 , angle:Number ):void 
        {
            var ca:Number = Trigo.cosD (angle) ;
            var sa:Number = Trigo.sinD (angle) ;
            var rx:Number = v.x * ca - v.y * sa ;
            var ry:Number = v.x * ca + v.y * sa ;
            v.x = rx ;
            v.y = ry ;
        }
        
        /**
         * Scales the Vector2 with the specified <code class="prettyprint">n</pre> value in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Vector2 ;
         * import pegas.util.Vector2Util ;
         * 
         * var v:Vector2 = new Vector2(0,2) ;
         * Vector2Util.scale(v,2) ;
         * trace(v) ; // [Point:{0,4}]
         * </pre>
         * @param n the value to scale this Point.
         */
        public static function scale( v:Vector2 , n:Number ):void 
        {
            v.x *= n ;
            v.y *= n ;
        }        
        
		/**
	 	 * Sets the specified <code class="prettyprint">Vector2</code> object with the second <code class="prettyprint">Vector2</code> object passed in argument.
		 * @param v1 the first <code class="prettyprint">Vector2</code>.
		 * @param v2 the second <code class="prettyprint">Vector2</code>.
		 */
		public static function setByVector2( v1:Vector2, v2:Vector2):void
		{
			v1.x = v2.x ;
			v1.y = v2.y ;
		}
				
		/**
		 * Computes the substraction of two Vector2.
		 * @param v1 the first Vector2.
	 	 * @param v2 the second Vector2.
		 */
		public static function substraction( v1:Vector2 , v2:Vector2 ):void
		{
		 	v1.x -= v2.x ;
			v1.y -= v2.y ;
		}
		
	}

}
