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
	import flash.geom.Point;
	
	import system.Reflection;
	
	import vegas.core.CoreObject;
	import vegas.util.Serializer;	

	/**
	 * Represents a vector in a 2D world with the coordinates x, y.
	 * @author eKameleon
	 */
	public class Vector2 extends CoreObject implements IGeometry
	{

		/**
		 * Creates a new <code class="prettyprint">Vector2</code> instance.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
	 	 */ 	
		public function Vector2( x:Number=0 , y:Number=0 )
		{
			super() ;
			this.x = isNaN(x) ? 0 : x ;
			this.y = isNaN(y) ? 0 : y ;
		}
		
		/**
		 * Defines the Vector2 object with the x and y properties set to zero.
		 */
		public static var ZERO:Vector2 = new Vector2(0,0) ;
				
		/**
		 * Defined the x coordinate.
		 */
		public var x:Number ;
		
		/**
		 * Defined the y coordinate.
	 	 */
		public var y:Number ;
		
        /**
         * Computes the addition of two vectors.
         * @param v the vector object to add.
         */
        public function addition( v:* ):void
        {
             x += v.x ;
             y += v.y ;
        }		
		
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
	 	 */
		public function clone():*
		{
			return new Vector2(x, y) ;	
		}

		/**
		 * Returns a deep copy of this instance.
		 * @return a deep copy of this instance.
	 	*/
		public function copy():*
		{
			return new Vector2(x, y) ;	
		}
	
		/**
	 	 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
		 */
		public function equals( o:* ):Boolean 
		{
			if ( o is Vector2)
			{
				return (o.x == x) && (o.y == y) ;
			}
			else
			{
				return false ;	
			} 	
		}
		
        /**
         * Scales the vector object with the input value.
         * @param value a real number to scale the current vector object.
         */
        public function scale( value:Number ):void
        {
            x *= value ;
            y *= value ;
        }  		

        /**
         * Computes the substraction of the current vector object with an other.
         * @param v the vector to substract.
         */
        public function substraction( v:* ):void
        {
            x -= v.x ;
            y -= v.y ;
        }
        
		/**
		 * Returns a flash.geom.Point reference of this object.
		 * @return a flash.geom.Point reference of this object.
		 */
		public function toFlash():flash.geom.Point
		{
			return new flash.geom.Point( x , y ) ;
		}

		/**
		 * Returns the Object representation of this object.
		 * @return the Object representation of this object.
		 */
		public function toObject():Object 
		{
			return { x:x , y:y } ;
		}

		/**
		 * Returns a Eden represensation of the object.
         * @return a string representing the source code of the object.
	 	 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [x, y]) ;
		}

		/**
		 * Returns the string representation of the object.
		 * @return the string representation of the object.
		 */ 	
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + ":{" + x + "," + y + "}]" ;
		}
		
	}
	
}
