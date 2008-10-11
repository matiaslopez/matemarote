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
    import pegas.geom.Matrix4;
    import pegas.geom.Quaternion;
    import pegas.geom.Vector3;    

    /**
	 * Static tool class to manipulate and transform <code class="prettyprint">Quaternion</code> references.
	 * @author eKameleon
	 */
	public class QuaternionUtil 
	{
        		
		/**
		 * Returns a new Quaternion conjugate of the specified Quaternion.
		 * @return a new Quaternion conjugate of the specified Quaternion.
		 */
		public static function getConjugate( q:Quaternion ):Quaternion
		{	
			return (q.clone()).conjugate() ;
		}
        		
		/**
		 * Returns the multiplication of two Quaternions.
		 * @return the multiplication of two Quaternions.
		 */
		public static function getMultiply( q1:Quaternion , q2:Quaternion ):Quaternion
		{
			return (q1.clone()).mutiply(q2) ;
		}
		
		/**
	 	 * Returns the multiplication of one Quaternions with a Vector3.
		 * @return the multiplication of one Quaternions with a Vector3.
		 */
		public static function getMultiplyVector3( q:Quaternion , v:Vector3 ):Quaternion
		{
			var x1:Number = q.x ; var y1:Number = q.y ;
			var z1:Number = q.z ; var w1:Number = q.w ;
					
			var x2:Number = v.x ; var y2:Number = v.y ;
			var z2:Number = v.z ; var w2:Number = 0   ;
					
			return new Quaternion
			(
				( w1 * x2 ) + ( x1 * w2 ) + ( y1 * z2 ) - ( z1 * y2 ) ,
				( w1 * y2 ) + ( y1 * w2 ) + ( z1 * x2 ) - ( x1 * z2 ) ,
				( w1 * z2 ) + ( z1 * w2 ) + ( x1 * y2 ) - ( y1 * x2 ) ,
				( w1 * w2 ) - ( x1 * x2 ) - ( y1 * y2 ) - ( z1 * z2 )
			) ;
		}
					
		/**
	 	 * Sets the elements of a Quaternion to represent the rotation around an arbitary axis.
	 	 * @param q the Quaternion to set.
	 	 * @param theta a real number representing angle input.
	 	 * @param axis the <code class="prettyprint">Vector3</code> direction instance.
	 	 */
		public static function rotationAxis( q:Quaternion, theta:Number, axis:Vector3 ):void
		{
			q.w = Math.cos( theta / 2 ) ;
			q.x = axis.x ;
			q.y = axis.y ;
			q.z = axis.z ;
			q.scale( Math.sin(theta / 2) ) ;
		}
					
		/**
	     * Transform a Quaternion to a Matrix4 object. 
	     * Calculates the rotation matrix of the quaternion.
	     * @param q The Quaternion to transform.
	     * @return The rotation matrix of the specified Quaternion.
	     */
    	public function rotationMatrix( q:Quaternion ):Matrix4 
    	{
	        return Matrix4Util.setByQuaternion( Matrix4Util.getIdentity() , q ) ;
	    }
					
	}

}
