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
    import pegas.geom.Vector3;
    
    import system.Reflection;
    
    import vegas.util.Serializer;    

    /**
	 * Quaternions are hypercomplex numbers used to represent spatial rotations in three dimensions. 
	 * This class encapsulates an Hamiltonian quaternion having the form <code class="prettyprint">xi + yj + zk + w</code>.
	 * @author eKameleon
 	 */
	public class Quaternion extends Vector3 
	{

		/**
		 * Creates a new <code class="prettyprint">Quaternion</code> instance.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 * @param z the z coordinate.
		 * @param w the transform component of the quaternion.
	 	 */ 
		public function Quaternion(x:Number = 0, y:Number = 0, z:Number = 0 , w:Number=0 )
		{
			super( x, y, z );
			this.w = isNaN(w) ? 0 : w ;
		}
		
		/**
		 * Represents the w component of the quaternion.
		 */
		public var w:Number ;
        
        /**
         * Adds the specified Quaternion. 
         */
        public function add(q:Quaternion):void 
        {
            var w2:Number = q.w; 
            var x2:Number = q.x; 
            var y2:Number = q.y; 
            var z2:Number = q.z;
            
            w = w*w2 - x*x2 - y*y2 - z*z2 ;
            x = w*x2 + x*w2 + y*z2 - z*y2 ;
            y = w*y2 + y*w2 + z*x2 - x*z2 ;
            z = w*z2 + z*w2 + x*y2 - y*x2 ;
        }		
		
        /**
         * Change the Quaterion in this conjugate.
         */
        public function conjugate():void
        {
            x = -x ;
            y = -y ;
            z = -z ;
        }		
		
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public override function clone():*
		{
			return new Quaternion(x, y, z, w) ;	
		}
	
		/**
		 * Returns a deep copy of this instance.
		 * @return a deep copy of this instance.
		 */
		public override function copy():*
		{
			return new Quaternion(x, y, z, w) ;	
		}
			
		/**
		 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
	 	 */
		public override function equals( o:* ):Boolean
		{
			if ( o is Quaternion)
			{
				return (o.x == x) && (o.y == y) && (o.z == z) && (o.w == w) ;
			}
			else
			{
				return false ;	
			} 
		}
		
        /**
         * Returns the magnitude of a Quaternion, measured in the Euclidean norm.
         * @return the magnitude of a Quaternion, measured in the Euclidean norm.
         */
        public function getMagnitude():Number
        {
            return Math.sqrt( w*w + x*x + y*y + z*z ) ;
        }	
        

        
        /**
         * Multiply the Quaternion with an other Quaternion.
         * @param q The Quaternion to multiply with the current Quaternion object.
         */
        public function multiply( q:Quaternion ):void
        {
            x = ( w * q.x ) + ( x * q.w ) + ( y * q.z ) - ( z * q.y ) ;
            y = ( w * q.y ) + ( y * q.w ) + ( z * q.x ) - ( x * q.z ) ;
            z = ( w * q.z ) + ( z * q.w ) + ( x * q.y ) - ( y * q.x ) ;
            w = ( w * q.w ) - ( x * q.x ) - ( y * q.y ) - ( z * q.z ) ;
        }
        
        /**
         * Normalizes the Quaternion instance.
         */
        public function normalize():void
        {
            var magnitude:Number = getMagnitude() ;
            w /= magnitude ;
            scale ( 1.0 / magnitude );
        }
        
      
        
		/**
	 	 * Returns the Object representation of this object.
	 	 * @return the Object representation of this object.
	 	 */
		public override function toObject():Object 
		{
			return { x:x , y:y , z:z , w:w } ;
		}
		
		/**
	 	 * Returns a Eden represensation of the object.
	 	 * @return a string representing the source code of the object.
	 	 */
		public override function toSource( indent:int = 0 ):String  
		{
			return Serializer.getSourceOf(this, [x, y, z, w]) ;
		}
		
		/**
		 * Returns the string representation of the object.
	 	 * @return the string representation of the object.
	 	 */ 	
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + ":{" + x + "," + y + "," + z + "," + w + "}]" ;
		}
		
	// Inspired by the MSDN documentation : <http://msdn2.microsoft.com/en-us/library/microsoft.windowsmobile.directx.quaternion_methods.aspx>
	// TODO implements QuaternionUtil class with :
	// TODO dot() : Returns the dot product of two quaternions.
	// TODO exp() : Calculates the exponential of a quaternion.
	// TODO invert() : Conjugates and renormalizes a quaternion.
	// TODO ln() : Calculates the natural logarithm of a quaternion.
	// TODO substraction() : Substracts two quaternions.
	// TODO unaryNegation() : Returns the negation of the specified quaternion.
	// TODO rotationMatrix : Builds a quaternion from a rotation matrix.
	// TODO rotationYawPicthRoll : Builds a quaternion with the given yaw, pitch and roll. ??
	// TODO slerp() : Interpolates between two quaternions, using spherical linear interpolation.
	// TODO size() : Returns the length of a quaternion.
	// TODO sizeSquare() : Returns the square of the length of a quaternion.
	// TODO squad() : Interpolates between quaternions, using spherical quadrangle interpolation.
	// TODO squadSetup() : Sets up control points for spherical quadrange interpolation.
	// TODO static substract() : Substracts two quaternion instances.

	}

}
