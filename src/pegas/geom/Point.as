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
package pegas.geom 
{
    import pegas.geom.Vector2;
    import pegas.util.Trigo;
    
    import vegas.util.Serializer;    

    /**
	 * The Point class represents a location in a two-dimensional coordinate system, where x represents the horizontal axis and y represents the vertical axis.
	 * <p>The following code creates a point at (0,0) :</p>
	 * <pre class="prettyprint">
	 * var myPoint:Point = new Point() ; 
	 * </pre>
	 * @author eKameleon
	 */
	public class Point extends Vector2 
	{

		/**
		 * Creates a new Point instance. 
		 * <p><b>Parameters</b>
		 * <ul>
		 * <li>If you pass no parameters to this method, a point is created at (0,0).</li>
	 	 * <li>If you pass a Point object the x and y properties define the properties of the new Point.</li>
		 * <li>if you pass two Numbers (x and y) you can define the horizontal and vertical coordinates.</li>
		 * </ul>
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import pegas.geom.Point ;
		 * 
		 * var p1:Point = new Point() ;
		 * trace(p1) ; // [Point:{0,0}]
		 * 
		 * var p2:Point = new Point( new Point(25,30) ) ;
		 * trace(p2) ; // [Point:{25,30}]
		 * 
		 * var p3:Point = new Point( 25,30 ) ;
		 * trace(p3) ; // [Point:{25,30}]
		 * </pre>
		 */
		public function Point( ...arguments:Array )
		{
			x = y = 0 ;
			var size:uint = arguments.length ;
			if ( size > 0 ) 
			{
				if ( arguments[0] is Point )
				{
					x = (arguments[0] as Point).x ;
					y = (arguments[0] as Point).y ;
				}
				else if (size == 2)
				{
					var n1:Number = arguments[0] as Number ;
					var n2:Number = arguments[1] as Number ;
					x = isNaN( n1 ) ? 0 : n1 ;
					y = isNaN( n2 ) ? 0 : n2 ;
				}
			}
		}
		
		/**
		 * Determinates the angle value of this Point object.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(0,10) ;
		 * var p2:Point = new Point(10,10) ;
		 * trace(p1.getAngle()) ; // 90
		 * trace(p2.getAngle()) ; // 45
		 * </pre>
		 * @return the angle value of this Point object.
		 */
		public function get angle():Number 
		{
			return Trigo.atan2D(y, x) ;
		}
		
		/**
		 * @private
		 */
		public function set angle( n:Number ):void 
		{
			var r:Number = getLength() ;
			x = r * Trigo.cosD(n) ;
			y = r * Trigo.sinD(n) ;
		}
	
		/**
		 * Returns the length of the line segment from (0,0) to this point.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(0,5) ;
		 * trace(p.length) ; // 5
		 * </pre>
		 * @return the length of the line segment from (0,0) to this point.
		 */
		public function get length():Number 
		{
			return Math.sqrt(x * x + y * y) ;
		}
	
		/**
	 	 * Sets the length of the line segment from (0,0) to this point.
	     */
		public function set length(n:Number):void 
		{
			var r:Number = length ;
			if (isNaN(r) && r !=0) 
			{
				scale ( n / r ) ;
			}
			else 
			{
				x = r ;
			}
		}

		/**
		 * Transform the coordinates of this point to used absolute value for the x and y properties.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(-10, -20) ;
		 * p.abs() ;
		 * trace(p) ; // [Point:{10,20}]
		 * </pre>
		 */
		public function abs():void 
		{
			x = Math.abs(x) ;
			y = Math.abs(y) ;
		}
		
		/**
		 * Returns a new Point reference with the absolute value of the coordinates of this Point object.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(-10, -20) ;
	 	 * var p2:Point = p1.absNew() ;
		 * trace(p1 + " / " + p2) ; // [Point:{-10,-20}] / [Point:{10,20}]
	 	 * </pre>
		 * @return a new Point reference with the absolute value of the coordinates of this Point object.
		 */
		public function absNew():Point 
		{
			return new Point(Math.abs(x), Math.abs(y))  ;
		}
	
		/**
	 	 * Returns the angle value between this Point object and the specified Point passed in arguments.
	 	 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10, 20) ;
		 * var p2:point = new Point(50, 200) ;
		 * var angle:Number = p1.angleBetween(p2) ;
		 * </pre>
		 * @return the angle value between this Point object and the specified Point passed in arguments.
		 */
		public function angleBetween(p:Point):Number 
		{
			var dp:Number = dot(p) ;
			var a:Number = dp / (getLength() * p.getLength()) ;
			return Trigo.acosD(a) ;
		}
			
		/**
		 * Returns the shallow copy of this object.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
	 	 * var p1:Point = new Point(10, 20) ;
		 * var p2:point = p1.clone() ;
		 * </pre>
	 	 * @return the shallow copy of this object.
		 */
		public override function clone():*
		{
			return new Point(x, y) ;
		}
			
		/**
		 * Returns the deep copy of this object.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10, 20) ;
		 * var p2:point = p1.copy() ;
	 	 * </pre>
		 * @return the deep copy of this object.
		 */
		public override function copy():* 
		{
			return new Point(x, y) ;
		}	
	
		/**
		 * Returns the cross value of the current Point object with the Point passed in argument.
		 * <pre class="prettyprint">
	 	 * var p1:Point = new Point(10,20) ;
		 * var p2:Point = new Point(40,60) ;
		 * trace(p1.cross(p2)) ; // -200
		 * </pre>
		 * @param p The Point object use to calculate the cross value. 
		 * @return The cross value of the current Point object with the Point passed in argument.
		 */
		public function cross(p:Point):Number 
		{
			return ( x * p.y ) - (y * p.x) ;
		}
		
		/**
		 * Returns the distance between <code class="prettyprint">p1</code> and <code class="prettyprint">p2</code> the 2 Points reference passed in argument.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10,20) ;
		 * var p2:Point = new Point(40,60) ;
		 * trace( Point.distance(p1,p2) ) ; // 50
		 * </pre>
	 	 * @param p1 the first Point.
	 	 * @param p2 the second Point.
	     * @return the distance between p1 and p2 the 2 Points reference passed in argument.
		 */
		public static function distance(p1:Point, p2:Point):Number 
		{
			return (p1.subtractNew(p2)).getLength() ;
		}
			
		/**
		 * Returns the dot value of the current Point and the specified Point passed in argument.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10,20) ;
		 * var p2:Point = new Point(40,60) ;
		 * trace(p1.dot(p2)) ; // 1600
		 * </pre>
		 * @param p the Point to calculate the dot value of the current Point.
		 * @return the dot value of the current Point and the specified Point passed in argument.
		 */
		public function dot(p:Point):Number 
		{
			return (x * p.x) + (y * p.y) ;
		}
			
		/**
		 * Compares the specified object with this object for equality.
		 * <p><b>Example :</b></p>
	 	 * <pre class="prettyprint">
		 * var p1:Point = new Point(10,20) ;
	 	 * var p2:Point = new Point(10,20) ;
		 * var p3:Point = new Point(30,40) ;
	 	 * trace(p1.equals(p2)) ; // true
		 * trace(p1.equals(p3)) ; // false
		 * </pre>
	 	 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
	 	 */
		public override function equals( o:* ):Boolean 
		{
			// TODO hack the number compare technik with String(n) to compare the float numbers !!!
			// test in other geom class !
			if ( o is Point )
			{
				return String(o.x) == String(x) && String(o.y) == String(y) ;
			}
			else
			{
				return false ;	
			}
		}
		
		/**
		 * Returns the direction of this Point.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1 : Point = new Point(10,2);
		 * var p2 : Point = p1.getDirection();
		 * trace( p2.getDirection() ) ; 
		 * </pre>
		 * @return the direction of this Point.
	 	 * @see Point.normalize
		 */
		public function getDirection():Point 
		{
			var c:Point = clone() ;
			c.normalize();
			return c ;
		}
	
		/**
		 * Returns the length of the line segment from (0,0) to this point.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(0,5) ;
		 * trace(p.getLength()) ; // 5
		 * </pre>
		 * @return the length of the line segment from (0,0) to this point.
		 */
		public function getLength():Number 
		{
			return Math.sqrt(x * x + y * y) ;
		}

		/**
		 * Returns the middle Point between 2 Points.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10,10) ;
	 	 * var p2:Point = new Point(20,20) ;
		 * var middle:Point = Point.getMiddle(p1,p2) ;
		 * trace(middle) ;
		 * </pre>
		 * @return the middle Point between 2 Points.
		 */
		public static function getMiddle(p1:Point, p2:Point):Point 
		{	
			return new Point( (p1.x + p2.x) / 2 , (p1.y + p2.y) / 2) ;
		}	
	
		/**
		 * Returns the normal value of this Point.
	 	 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(10,10) ;
		 * var n:Point = p.getNormal() ; // [Point:{-10,10}]
		 * trace(n) ;
	 	 * </pre>
	     * @return the normal value of this Point.
	     */
		public function getNormal():Point 
		{
			return new Point(-y , x) ;
		}
	
		/**
		 * Returns the size of the projection of this Point with an other Point.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
	 	 * var p1:Point = new Point(10,10) ;
		 * var p2:Point = new Point(100,200) ;
		 * var size:Number = p1.getProjectionLength(p2) ;
		 * trace(size) ; // 0.06
		 * </pre>
		 * @param p the Point use to calculate the length of the projection.
		 * @return the size of the projection of this Point with an other Point.
	 	 */
		public function getProjectionLength(p:Point):Number 
		{
			var l:Number = p.dot(p) ;
			return (l==0) ? 0 : Math.abs(dot(p)/l) ;
		}

		/**
		 * Determines a point between two specified points. 
		 * The parameter f determines where the new interpolated point is located relative to the two end points specified by parameters <code class="prettyprint">p1</code> and <code class="prettyprint">p2</code>. 
		 * The closer the value of the parameter f is to 1.0, the closer the interpolated point is to the first point (parameter <code class="prettyprint">p1</code>). 
		 * The closer the value of the parameter f is to 0, the closer the interpolated point is to the second point (parameter <code class="prettyprint">p2</code>).
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
	 	 * var p1:Point = new Point(10,10) ;
		 * var p2:Point = new Point(40,40) ;
		 * var p3:Point ;
		 * 
		 * p3 = Point.interpolate( p1 , p2, 0 ) ;
		 * trace(p3) ; // [Point:{40,40}]
		 * 
	 	 * p3 = Point.interpolate( p1 , p2, 1 ) ;
		 * trace(p3) ; // [Point:{10,10}]
		 * 
	 	 * p3 = Point.interpolate( p1 , p2, 0.5 ) ;
		 * trace(p3) ; // [Point:{25,25}]
		 * </pre>
		 * @param p1 The first point.
		 * @param p2 The second Point.
		 * @param f the The level of interpolation between the two points. Indicates where the new point will be, along the line between <code class="prettyprint">p1</code> and <code class="prettyprint">p2</code>. If f=1, pt1 is returned; if f=0, pt2 is returned.
		 * @return The new interpolated point.
		 */
		public static function interpolate(p1:Point, p2:Point, f:Number):Point 
		{
			return new Point( p2.x + f * (p1.x - p2.x) , p2.y + f * (p1.y - p2.y) ) ;
		}
	
		/**
		 * Returns <code class="prettyprint">true</code> if the Point is perpendicular with the passed-in Point.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(0,10) ;
		 * var p2:Point = new Point(10,10) ;
		 * var p3:Point = new Point(10,0) ;
		 * trace(p1.isPerpTo(p2)) ; // false
		 * trace(p1.isPerpTo(p3)) ; // true
		 * </pre>
		 * @param p the Point use to determinate if this Point object is perpendicular.
		 * @return <code class="prettyprint">true</pre> if the Point is perpendicular with the passed-in Point.
		 */
		public function isPerpTo(p:Point):Boolean 
		{	
			return dot(p) == 0 ;
		}	

		/**
		 * Returns the new Point with the maximum horizontal coordinate and the maximum vertical coordinate.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10,100) ;
		 * var p2:Point = new Point(100,10) ;
		 * var p3:Point = p1.max(p2) ;
		 * trace(p3) ; // [Point:{100,100}]
	 	 * </pre>
		 * @param p The Point passed in this method
		 * @return The new Point with the maximum horizontal coordinate and the maximum vertical coordinate.
		 */
	    public function max(p:Point):Point 
    	{	
	        return new Point( Math.max(x, p.x), Math.max(y, p.y) ) ;
	    }

		/**
		 * Returns a new Point with the minimum horizontal coordinate and the minimize vertical coordinate.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10,100) ;
		 * var p2:Point = new Point(100,10) ;
		 * var p3:Point = p1.min(p2) ;
		 * trace(p3) ; // [Point:{10,10}]
		 * </pre>
 	 	 * @param p The Point passed in this method
		 * @return a new Point with the min horizontal coordinate and the minimize vertical coordinate.
		 */
		public function min(p:Point):Point 
		{
        	return new Point( Math.min(x , p.x) , Math.min(y, p.y) ) ;
	    }
		
		/**
		 * Sets this Point with negate coordinates.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(10,20) ;
		 * trace(p) ; // [Point:{10,20}]
		 * p.negate() ;
		 * trace(p) ; // [Point:{-10,-20}]
		 * p.negate() ;
		 * trace(p) ; // [Point:{10,20}]
		 * </pre>
		 */
		public function negate():void 
		{
			x = - x ;
			y = - y ;
		}

		/**
		 * Returns the new negate Point of this Point.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(10,20) ;
		 * var n:Point = p.negateNew() ;
		 * trace(n) ; // [Point:{-10,-20}]
		 * </pre>
		 * @return The new negate Point of this Point.
		 */
		public function negateNew():Point 
		{
			return new Point(-x , -y) ;
		}
	
		/**
		 * Scales the line segment between (0,0) and the current point to a set length.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(0,5) ;
		 * p.normalize() ;
		 * trace(p) ; // [Point:{0,1}]
		 * </pre>
		 * @param thickness The scaling value. For example, if the current point is (0,5), and you normalize it to 1, the point returned is at (0,1).
		 * @see length
		 * @throws ArgumentError if a zero-length vector or a illegal NaN value is calculate in this method.
		 */
		public function normalize( thickness:Number=NaN ):void 
		{
			if ( isNaN(thickness) )
			{
				thickness = 1 ;	
			}
			var l:Number = getLength() ;
			if (l > 0) 
			{
				l = thickness / l ;
				x *= l ;
				y *= l ;
			}
			else
			{
				throw new ArgumentError(this + " normalize method failed with a zero-length vector or a illegal NaN value.") ;
			}
		}
	
		/**
		 * Offsets the Point object by the specified amount. 
		 * The value of dx is added to the original value of x to create the new x value. 
		 * The value of dy is added to the original value of y to create the new y value.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p:Point = new Point(10,10) ;
		 * p.offset(10,10) ;
		 * trace(p) ; // [Point:{20,20}]
		 * </pre>
		 * @param dx The amount by which to offset the horizontal coordinate, x.
		 * @param dy The amount by which to offset the vertical coordinate, y.
		 */
		public function offset(dx:Number, dy:Number):void 
		{
			x += dx ;
			y += dy ;
		}

		/**
		 * Converts a pair of polar coordinates to a Cartesian point coordinate.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var polar:Point = Point.polar( 5, Math.atan(3/4) ) ;
		 * trace(polar) ; // [Point:{4,3}]
		 * </pre>
		 * @param len The length coordinate of the polar pair.
		 * @param angle The angle, in radians, of the polar pair.
		 * @return The new Cartesian point.
	 	 */
		public static function polar(len:Number, angle:Number):Point 
		{
			return new Point( len * Math.cos(angle), len * Math.sin(angle) ) ;
		}
	
		/**
		 * Adds the coordinates of another point to the coordinates of this point.
		 * @param p athe point to be added. You can use an object with the properties x and y.
		 */
		public function plus( p:* ):void 
		{
			x += p.x ;
			y += p.y ;
		}	
	
		/**
		 * Adds the coordinates of another point to the coordinates of this point to create a new point.
		 * @param p athe point to be added. You can use an object with the properties x and y.
		 * @return The new point.
		 */
		public function plusNew( p:* ):Point 
		{
			return new Point (x + p.x, y + p.y) ;
		}
	
		/**
		 * Returns the projection of a Point with the specified Point passed in argument.
		 * @param p the Point to project with this current Point.
		 * @return the new project Point.
		 */
		public function project( p:Point ):Point 
		{
			var l:Number = p.dot(p) ;
			if( l == 0) 
			{
				return clone() as Point ;
			}
			else 
			{
				return scaleNew( dot(p) / l ) ;
			}
		}
	
		/**
		 * Sets the horizontal and vertical coordinates of this Point. 
 	 	 * If the <code class="prettyprint">x</pre> and the <code class="prettyprint">y</pre> parameters are <code class="prettyprint">NaN</pre> or <code class="prettyprint">null</pre> the x value is 0 and y value is 0.
	 	 */
		public function reset(x:Number, y:Number):void 
		{
			this.x = isNaN(x) ? 0 : x ;
			this.y = isNaN(y) ? 0 : y ;
		}
	
		/**
		 * Rotates the Point with the specified angle in argument.
		 * @param angle the Angle to rotate this Point.
	 	 */
		public function rotate( angle:Number ):void 
		{
			var ca:Number = Trigo.cosD (angle) ;
			var sa:Number = Trigo.sinD (angle) ;
			var rx:Number = x * ca - y * sa ;
			var ry:Number = x * ca + y * sa ;
			x = rx ;
			y = ry ;
		}

		/**
		 * Rotates the Point with the specified <code class="prettyprint">angle</pre> in argument and creates a new Point.
		 * @param angle the Angle to rotate this Point.
		 * @return The rotate new Point.
		 */
		public function rotateNew(angle:Number):Point 
		{
			var p:Point = new Point(x, y) ;
			p.rotate (angle) ;
			return p ;
		}
        
		/**
		 * Rotates the Point with the specified <code class="prettyprint">s</pre> value in argument and creates a new Point.
		 * @param n the value to scale this Point.
		 * @return The scale new Point.
		 */
		public function scaleNew( n:Number ):Point 
		{
			return new Point( x * n , y * n ) ;
		}
        
		/**
		 * Subtracts the coordinates of another point from the coordinates of this point to create a new point.
		 * @param p The point to be subtracted.
		 * @return The new Point.
		 */
		public function subtractNew( p:Point ):Point 
		{
			return new Point(x - p.x, y - p.y) ;
		}

		/**
		 * Swap the horizontal and vertical coordinates of two Point objects.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var p1:Point = new Point(10,20) ;
		 * var p2:Point = new Point(30,40) ;
		 * trace(p1 + " / " + p2) ; // [Point:{10,20}] / [Point:{30,40}]
		 * p1.swap(p2) ;
		 * trace(p1 + " / " + p2) ; // [Point:{30,40}] / [Point:{10,20}]
		 * </pre>
		 */
		public function swap(p:Point):void 
		{
			var tx:Number = x ;
			var ty:Number = y ;
			x = p.x ;
			y = p.y ;
			p.x = tx ;
			p.y = ty ;
		}
	
		/**
		 * Returns a Eden represensation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [x,y] ) ;
		}
		
	
	}

}
