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
	
	import flash.geom.Rectangle ;
	
	import pegas.geom.Dimension;
	
	import vegas.errors.ClassCastError;												

	/**
	 * The <code class="prettyprint">Rectangle</code> class is used to create and modify Rectangle objects. 
	 * <p>A Rectangle object is an area defined by its position, as indicated by its top-left corner point (x, y), and by its width and its height.</p>
	 * <p>The x, y, width, and height properties of the Rectangle class are independent of each other; changing the value of one property has no effect on the others.</p>
	 * <p>To used this class with a FP8 and > with flash.display.BitmapData class and other flash.* classes you can use the method toFlash() to return a compatible reference of this object.</p> 
	 * @author eKameleon
	 */
	public class Rectangle extends Dimension 
	{
		
		/**
		 * Creates a new Rectangle instance whose top-left corner is specified by the x and y parameters.
		 * If not arguments are passed-in the constructor an empty rectangle is created.
		 * @example
		 * <pre class="prettyprint">
	 	 * import pegas.geom.Rectangle;
	 	 * var rec:Rectangle = new Rectangle(5, 10, 50, 100);
	 	 * trace( "output : " + rec.toString() ); // output : (x:5,y:10,width:50,height:100)
	 	 * </pre>
	 	 * @param x The <code class="prettyprint">x</code> coordinate of the top-left corner of the rectangle.
	 	 * @param y The <code class="prettyprint">y</code> coordinate of the top-left corner of the rectangle.
	 	 * @param w The width of the rectangle in pixels.
	 	 * @param h The height of the rectangle in pixels.
	 	 */
		public function Rectangle( ...arguments:Array )
		{
			if (arguments.length > 0) 
			{
				x = isNaN(arguments[0]) ? 0 : arguments[0] ;
				y = isNaN(arguments[1]) ? 0 : arguments[1] ;
				super( arguments[2] , arguments[3] ) ; 
			}
			else 
			{
				empty() ;
			}
		}

		/**
		 * Returns the sum of the y and height properties.
		 * @return the sum of the y and height properties.
		 */
		public function get bottom():Number 
		{
			return y + height ;
		}	

		/**
		 * Sets the sum of the y and height properties.
		 */
		public function set bottom( n:Number ):void 
		{
			height = n - y ;
		}	
		
		/**
		 * Returns the location of the Rectangle object's bottom-left corner, determined by the values of the x and y properties.
		 * @return the location of the Rectangle object's bottom-left corner, determined by the values of the x and y properties.
		 */
		public function get bottomLeft():Vector2 
		{
			return new Point(x, y + height) ;
		}

		/**
		 * Sets the location of the Rectangle object's bottom-left corner, determined by the values of the x and y properties.
		 */
		public function set bottomLeft( vector:Vector2 ):void 
		{
			width  = width + (x - vector.x) ;
			height = vector.y - y ;
			x      = vector.x ;
		}	
	
		/**
	 	 * Returns the location of the Rectangle object's bottom-right corner, determined by the values of the x and y properties.
	 	 * @return the location of the Rectangle object's bottom-right corner, determined by the values of the x and y properties.
	 	 */
		public function get bottomRight():Vector2 
		{
			return new Vector2(x + width, y + height) ;
		}

		/**
	 	 * Sets the location of the Rectangle object's bottom-right corner, determined by the values of the x and y properties.
	 	 */
		public function set bottomRight( vector:Vector2 ):void 
		{
			width  = vector.x - x;
			height = vector.y - y;
		}	

		/**
		 * Returns the location of the Rectangle object's center, determined by the values of the x and y properties.
		 * @return the location of the Rectangle object's center, determined by the values of the x and y properties.
	 	 */
		public function get center():Vector2 
		{
			return new Vector2(x + width/2, y + height/2);
		}
		
		/**
	 	 * Sets the x and y coordinates of the top-left corner of the rectangle if the specified value in argument is the middle of the Rectangle.
	 	 */
		public function set center( vector:Vector2 ):void 
		{
			x = vector.x - ( width / 2 )  ;
			y = vector.y - ( height / 2 ) ;
		}

		/**
	 	 * Returns the x coordinate of the top-left corner of the rectangle.
	 	 * @return the x coordinate of the top-left corner of the rectangle.
	  	 */
		public function get left():Number 
		{
			return x ;
		}
	
		/**
		 * Sets the x coordinate of the top-left corner of the rectangle.
		 */
		public function set left( n:Number ):void 
		{
			width = width + (x - n) ;
			x = n ;
		}
	
		/**
		 * Returns the sum of the x and width properties.
		 * @return the sum of the x and width properties.
		 */
		public function get right():Number 
		{
			return x + width ;
		}
		
		/**
		 * Sets the sum of the x and width properties.
		 */
		public function setRight( n:Number ):void 
		{
			width = n - x ;
		}
		
		/**
		 * Returns the size of the Rectangle object, expressed as a Vector2 object with the values of the width and height properties.
		 * @return the size of the Rectangle object, expressed as a Vector2 object with the values of the width and height properties.
	 	 */
		public function get size():Vector2 
		{
			return new Vector2(width, height) ;
		}
		
		/**
		 * Sets the size of this Rectangle object with a Vector2 object..
		 */
		public function set size( vector:Vector2 ):void 
		{
			width  = vector.x ;
			height = vector.y ;
		}
	
		/**
		 * Returns the y coordinate of the top-left corner of the rectangle.
		 * @return the y coordinate of the top-left corner of the rectangle.
		 */
		public function get top():Number 
		{
			return y ;
		}	

		/**
		 * Sets the y coordinate of the top-left corner of the rectangle.
		 */
		public function set top( n:Number ):void
		{
			height = height + (y - n);
			y = n ;
		}

		/**
		 * Returns the location of the Rectangle object's top-left corner determined by the x and y values of the point.
		 * @return the location of the Rectangle object's top-left corner determined by the x and y values of the point.
		 */
		public function get topLeft():Vector2 
		{
			return new Vector2(x, y) ;
		}
		
		/**
		 * Sets the location of the Rectangle object's top-left corner determined by the x and y values of the point.
		 */
		public function set topLeft( vector:Vector2 ):void 
		{
			width = width + (x - vector.x) ;
			height = height + (y - vector.y) ;
			x = vector.x ;
			y = vector.y ;
		}

		/**
		 * Returns the location of the Rectangle object's top-right corner determined by the x and y values of the point.
		 * @return the location of the Rectangle object's top-right corner determined by the x and y values of the point.
		 */
		public function get topRight():Vector2 
		{
			return new Vector2(x + width, y) ;
		}

		/**
		 * Sets the location of the Rectangle object's top-right corner determined by the x and y values of the point.
		 */
		public function set topRight( vector:Vector2 ):void 
		{
			width  = vector.x - x ;
			height = height + ( y - vector.y ) ;
			y      = vector.y ;
		}
	
		/**
		 * The x coordinate of the top-left corner of the rectangle.
		 */
		public var x:Number ;
	
		/**
		 * The y coordinate of the top-left corner of the rectangle.
		 */
		public var y:Number ;
		
		/**
		 * Returns a new Rectangle object with the same values for the x, y, width, and height properties as the original Rectangle object.
		 * @return a new Rectangle object with the same values for the x, y, width, and height properties as the original Rectangle object.
		 */
		public override function clone():* 
		{
			return new pegas.geom.Rectangle( x, y, width, height ) ;
		}

		/**
		 * Determines whether the specified point is contained within the rectangular region defined by this Rectangle object.
		 * @param x The x coordinate to check.
		 * @param y The y coordinate to check.
		 * @return <code class="prettyprint">true</code> if the specified point is contained within the rectangular region defined by this Rectangle object.
		 */
		public function containsCoordinate( x:Number , y:Number ):Boolean 
		{
			return ( ( x >= this.x ) && x < ( this.x + width ) && ( y >= this.y ) && ( y < this.y + height ) );
		}

		/**
		 * Determines whether the specified point is contained within the rectangular region defined by this Rectangle object.
		 * @param vector The Vector2 to check.
		 * @return <code class="prettyprint">true</code> if the specified point is contained within the rectangular region defined by this Rectangle object.
		 */
		public function containsVector( vector:Vector2 ):Boolean 
		{
			return containsCoordinate( vector.x , vector.y ) ;
		}
	
		/**
		 * Determines whether the Rectangle object specified by the rect parameter is contained within this Rectangle object.
		 * @return <code class="prettyprint">true</code> if the specified Rectangle is contained within this Rectangle object. 
	 	 */
		public function containsRectangle( rec:pegas.geom.Rectangle ):Boolean 
		{
			var a:Number = rec.x + rec.width ;
			var b:Number = rec.y + rec.height ;
			var c:Number = x + width ;
			var d:Number = y + height ;
			return (rec.x >= x && rec.x < c && rec.y >= y && rec.y < d && a > this.x && a <= c && b > y && b <= d) ;
		}

		/**
		 * Compares its two arguments for order.
		 * @param o1 the first object to compare.
		 * @param o2 the second object to compare.
	 	 * @return <p>
		 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
		 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
		 * <li> 0 if o1 and o2 are equal.</li>
		 * </p>
		 * @throws ClassCastError the arguments of the method must be Rectangle reference.
		 */
		public static function compare(o1:*, o2:*):Number 
		{
			
			var r1:pegas.geom.Rectangle = o1 as pegas.geom.Rectangle ;
			var r2:pegas.geom.Rectangle = o2 as pegas.geom.Rectangle ;
			
			if ( r1 == null || r1 == null )
			{
				throw new ClassCastError( "Rectangle.compare failed, the arguments of the method must be Rectangle reference.") ;
			}
			
			var s1:Vector2 = r1.size ;
			var s2:Vector2 = r2.size ;
			var a1:Number  = s1.x * s1.y ;
			var a2:Number  = s2.x * s2.y ;
			if (a1 == a2) 
			{
				return 0 ;
			}
			else if(a1 > a2) 
			{
				return 1 ;
			}
			else 
			{
				return -1 ;
			}
		}
	
		/**
		 * Returns a new Rectangle object with the same values for the x, y, width, and height properties as the original Rectangle object.
		 * @return a new Rectangle object with the same values for the x, y, width, and height properties as the original Rectangle object.
		 */
		public override function copy():* 
		{
			return new pegas.geom.Rectangle(x, y, width, height) ;
		}

		/**
		 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
		 */
		public override function equals( o:* ):Boolean 
		{
			if ( o is pegas.geom.Rectangle ) 
			{
				return (o.x == x) && (o.y == y) && (o.width == width) && (o.height == height) ;
			}
			else
			{
				return false ;	
			}
		}
		
		/**
		 * Sets all of the Rectangle object's properties to 0.
		 */
		public function empty():void 
		{
			x = y = width = height = 0 ;
		}

		/**
		 * Increases the size of the Rectangle object by the specified amounts.
		 */
		public function inflate(dx:Number, dy:Number):void 
		{
			x      -= dx     ;
			width  += 2 * dx ;
			y      -= dy     ;
			height += 2 * dy ;
		}

		/**
		 * Increases the size of the Rectangle object.
		 */
		public function inflatePoint( vector:Vector2 ):void 
		{
			height += 2 * vector.y;
			width  += 2 * vector.x;
			x      -= vector.x;
			y      -= vector.y;
		}

		/**
		 * If the Rectangle object specified in the toIntersect parameter intersects with this Rectangle object, 
		 * the intersection() method returns the area of intersection as a Rectangle object.
		 */
		public function intersection(toIntersect:pegas.geom.Rectangle):pegas.geom.Rectangle 
		{
			var rec:pegas.geom.Rectangle = new pegas.geom.Rectangle() ;
			if (isEmpty() || toIntersect.isEmpty()) 
			{
				rec.empty();
				return rec ;
			}
			rec.x = Math.max(x, toIntersect.x);
			rec.y = Math.max(y, toIntersect.y);
			rec.width = Math.min( x + width, toIntersect.x + toIntersect.width) - rec.x ;
			rec.height = Math.min(y + height, toIntersect.y + toIntersect.height) - rec.y ;
			if ( rec.width <= 0 || rec.height <= 0 ) 
			{
				rec.empty();
			}
			return rec ;
		}

		/**
		 * Determines whether or not this Rectangle object is empty.
		 * @return <code class="prettyprint">true</code> if the width and the height of the rectangle are empty (0).
		 */
		public function isEmpty():Boolean 
		{
			return !(width > 0 || height > 0) ;
		}	
		
		/**
		 * Adjusts the location of the Rectangle object, as determined by its top-left corner, by the specified amounts.
		 */
		public function offset(dx:Number, dy:Number):void 
		{
			x += dx ;
			y += dy ;
		}

		/**
		 * Adjusts the location of the Rectangle object using a Point object as a parameter.
		 */
		public function offsetPoint( vector:Vector2 ):void 
		{
			x += vector.x ;
			y += vector.y ;
		}

    	/**
		 * Returns the Object representation of this object.
	 	 * @return the Object representation of this object.
		 */
		public override function toObject():Object 
		{
			return { x:x , y:y , width:width , height:height } ;
		}

		/**
		 * Returns a <code class="prettyprint">flash.geom.Rectangle</code> reference of this Rectangle object.
		 * @return a <code class="prettyprint">flash.geom.Rectangle</code> reference of this Rectangle object.
		 */
		public function toFlash():flash.geom.Rectangle
		{
			if (flash.geom.Rectangle != null)
			{
				return new flash.geom.Rectangle(x, y, width, height) ;
			}
			else
			{
				return null ;	
			}
		}

		/**
		 * Returns a <b>eden</b> represensation of the object.
		 * @return a string representing the source code of the object.
	 	 */
		public override function toSource( indent:int = 0 ):String 
		{
			return "new pegas.geom.Rectangle(" + x + "," + y + "," + width + "," + height + ")" ;
		}
		
		/**
		 * Returns the string representation of the object.
		 * @return the string representation of the object.
	 	 */ 
		public override function toString():String 
		{
			return "[Rectangle {x:" + (x||0) + ",y:" + (y||0) + ",width:" + (width||0) + ",height:" + (height||0) + "}]" ;
		}
	
		/**
		 * Adds two rectangles together to create a new Rectangle object, by filling in the horizontal and vertical space between the two rectangles.
		 */
		public function union( toUnion:pegas.geom.Rectangle ):pegas.geom.Rectangle 
		{
			if ( isEmpty() ) 
			{
				return toUnion.clone() ;
			}
			else if (toUnion.isEmpty()) 
			{
				return clone() ;
			}
			else 
			{
				var rec:pegas.geom.Rectangle = new pegas.geom.Rectangle();
				rec.x      = Math.min(x, toUnion.x);
				rec.y      = Math.min(y, toUnion.y);
				rec.width  = Math.max(x + width, toUnion.x + toUnion.width) - rec.x;
				rec.height = Math.max(y + height, toUnion.y + toUnion.height) - rec.y;
				return rec ;
			}
		}
		
	}
	
}
