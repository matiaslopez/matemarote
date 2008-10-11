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
    
    import system.Reflection;
    
    import vegas.util.Serializer;    

    /**
	 * Represents a vector in a 3D world with the coordinates x, y and z.
	 * @author eKameleon
	 */
	public class Vector3 extends Vector2 
	{
	
		/**
		 * Creates a new <code class="prettyprint">Vector3</code> instance.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 * @param z the z coordinate.
		 */ 
		public function Vector3( x:Number = 0, y:Number = 0 ,  z:Number = 0 )
		{
			super( x , y ) ;
			this.z = isNaN( z ) ? 0 : z ;
		}
		
        /**
         * Computes the addition of two vectors.
         * @param v the vector object to add.
         */
        public override function addition( v:* ):void
        {
             super.addition( v ) ;
             z += v.z ;
        }		
		
		/**
		 * Defines the Vector3 object with the x, y and z properties set to zero.
		 */
		public static var ZERO:Vector3 = new Vector3(0,0,0) ;
		
		/**
		 * Defined the z coordinate.
		 */
		public var z:Number;
		
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public override function clone():*
		{
			return new Vector3(x, y, z) ;	
		}
	
		/**
	 	 * Returns a deep copy of this instance.
	 	 * @return a deep copy of this instance.
	 	 */
		public override function copy():*
		{
			return new Vector3( x, y, z ) ;	
		}
		
		/**
	 	 * Compares the specified object with this object for equality.
	 	 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
	 	 */
		public override function equals( o:* ):Boolean 
		{
			if ( o is Vector3 )
			{
				return (o.x == x) && (o.y == y) && (o.z == z) ;
			}
			return false ;
		}
		
        /**
         * Calculates and returns the perspective ratio needed to scale an object correctly.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(50,20,40);
         * var p:Number  = v.getPerspective();
         * trace(p) ;
         * </code>
         * @param distance The viewing distance of the projection.
         * @return the perspective ratio needed to scale an object correctly.
         */
        public function getPerspective( distance:Number=NaN ):Number 
        {
            distance = isNaN(distance) ? 300 : distance ;
            return distance / (z + distance) ;
        }		
        
        /**
         * Performs a perspective projection on a 3d point. It converts (x, y, z) coordinates to a 2d location (x, y) on the screen.
         * @param v the Vector3 reference.
         * @param perspective The perspective ratio. If no value is specified, it is calculated automatically by calling the getPerspective() method.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(50,20,40) ;
         * v.project(v);
         * trace(v) ;
         * </code>
         */
        public function project( perspective:Number ):void 
        {
            perspective = isNaN(perspective) ? getPerspective() : perspective ;
            x *= perspective ;
            y *= perspective ;
            z  = 0 ;
        }          
        
        /**
         * Scales the vector object with the input value.
         * @param value a real number to scale the current vector object.
         */
        public override function scale( value:Number ):void
        {
            super.scale( value ) ;
            z *= value ;
        }        
        
        /**
         * Computes the substraction of the current vector object with an other.
         * @param v the vector to substract.
         */
        public override function substraction( v:* ):void
        {
            super.substraction(v) ;
            z -= v.z ;
        }        
        
		/**
		 * Returns the Object representation of this object.
		 * @return the Object representation of this object.
		 */
		public override function toObject():Object 
		{
			return { x:x , y:y , z:z } ;
		}
		
		/**
		 * Returns an eden represensation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [x, y, z]) ;
		}
	
		/**
	  	 * Returns the string representation of the object.
	 	 * @return the string representation of the object.
	 	 */ 	
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + ":{" + x + "," + y + "," + z + "}]" ;
		}
		
	}
}


