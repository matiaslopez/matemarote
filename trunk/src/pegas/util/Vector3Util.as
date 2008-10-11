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
    import pegas.geom.Vector3;                    

    /**
     * Static tool class to manipulate and transform <code class="prettyprint">Vector3</code> references.
     * @author eKameleon
     */
    public class Vector3Util 
    {
                
        /**
         * Computes the addition of two Vector3.
         * @param v1 a Vector3 to concat.
         * @param v2 a Vector3 to concat.
         * @return the addition result of two Vector3.
         */
        public static function getAddition( v1:Vector3, v2:Vector3 ):Vector3
        {
            return new Vector3( (v1.x + v2.x) , (v1.y + v2.y) , (v1.z + v2.z) ) ;    
        }
    
        /**
         * Returns the angle in radian between the two 3D vectors. The formula used here is very simple.
         * It comes from the definition of the dot product between two vectors.
         * @param v1    Vector3 The first Vector3.
         * @param v2    Vector3 The second Vector3.
         * @return the angle in radian between the two vectors.
         */
        public static function getAngle ( v1:Vector3, v2:Vector3 ):Number
        {
            var ncos:Number = ( Vector3Util.getDot( v1, v2 ) ) / ( getNorm(v1) * getNorm(v2) );
            var sin2:Number = 1 - (ncos * ncos) ;
            if (sin2<0)
            {
                // trace(" wrong "+ ncos ) ;
                sin2 = 0 ;
            }
            // I took long time to find this bug. Who can guess that (1-cos*cos) is negative ? !
            // sqrt returns a NaN for a negative value !
            return  Math.atan2( Math.sqrt(sin2), ncos );
        }
    
        /**
         * Computes the cross product of the two Vector3s.
         * @param v1 a <code class="prettyprint">Vector3</code>.
         * @param v2 a <code class="prettyprint">Vector3</code>.
         * @return the <code class="prettyprint">Vector3</code> resulting of the cross product.
         */
        public static function getCross( v1:Vector3, v2:Vector3 ):Vector3
        {
            return new Vector3
            (     
                (v2.y * v1.z) - (v2.z * v1.y) ,
                (v2.z * v1.x) - (v2.x * v1.z) ,
                (v2.x * v1.y) - (v2.y * v1.x)
            );
        }
    
        /**
         * Computes the dot product of the two Vector3s.
         * @param v1 a <code class="prettyprint">Vector3</code>.
         * @param v2 a <code class="prettyprint">Vector3</code>.
         * @return the dot product of the 2 Vector3.
         */
        public static function getDot( v1:Vector3, v2:Vector3 ):Number
        {
            return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z) ;    
        }
        
        /**
         * Returns the length of the vector.
         * @param v the vector.
         * @return the length of the vector.
         */
        public static function getLength( v:Vector3 ):Number
        {
            return Math.sqrt( (v.x * v.x) + (v.y * v.y) + (v.z * v.z) ) ;
        }
        
        /**
         * Computes the oposite Vector3 of the <code class="prettyprint">Vector3</code>.
         * @param v the Vector3 reference to negate.
         * @return a new negate <code class="prettyprint">Vector3</code> reference.
         */
        public static function getNegate( v:Vector3 ):Vector3
        {
            return new Vector3( - v.x, - v.y, - v.z );
        }    
        
        /**
         * Computes the norm of the <code class="prettyprint">Vector3</code>.
         * @param v a Vector3 reference.
         * @return the norm of the specified <code class="prettyprint">Vector3</code>.
         */
        public static function getNorm( v:Vector3 ):Number
        {
            return Math.sqrt( (v.x * v.x) + (v.y * v.y) + (v.z * v.z) );
        }
                
        /**
         * Computes the power of the specified Vector3.
         * @param v the Vector3 reference.
         * @param value the value of the pow..
         * @return A new Vector3 powered by the method.
         */
        public static function getPow( v:Vector3, value:Number ):Vector3
        {
            return new Vector3( Math.pow( v.x, value ) , Math.pow( v.y, value ) ,  Math.pow( v.z, value ) ) ;
        }
    
        /**
         * Scales the specified Vector3 with the input value.
         * @param vector the Vector3 reference to transform.
         * @param value a real number to scale the current Vector3.
         * @return A new Vector3 scaled by the value passed in second argument in this method.
         */
        public static function getScale( v:Vector3, value:Number ):Vector3
        {
            return new Vector3 ( v.x * value , v.y * value , v.z * value ) ;
        }
        
        /**
         * Returns the squared length of this vector.
         * @param v the vector.
         * @return the squared length of this vector.
         */
        public static function getSquaredLength( v:Vector3 ):Number
        {
            return (v.x * v.x) + (v.y * v.y) + (v.z * v.z) ;
        }
        
        /**
         * Computes the substraction of two Vector3.
         * @param v1 a Vector3 to substract.
         * @param v2 a Vector3 to substract.
         * @return the substraction result of two Vector3.
         */
        public static function getSubstraction( v1:Vector3 , v2:Vector3 ):Vector3
        {
            return new Vector3( (v1.x - v2.x) , (v1.y - v2.y) , (v1.z - v2.z) ) ;
        }
        
        /**
         * Computes the negation of two Vector3 and returns the first vector.
         * @param v1 the first Vector3.
         * @param v2 the second Vector3.
         * @return the negation result of two Vector3.
         */
        public static function negate( v1:Vector3, v2:Vector3 ):Vector3
        {
             v1.x -= v2.x ;
             v1.y -= v2.y ;
             v1.z -= v2.z ;
             return v1 ;    
        }
    
        /**
         * Normalize the specified <code class="prettyprint">Vector3</code> in parameter.
         * @param v a Vector3 reference.
         * @return <code class="prettyprint">true</code> of the normalize method is success else false for mistake.
         */    
        public static function normalize( v:Vector3 ):Boolean
        {
            var norm:Number = getNorm( v );
            if( norm == 0 || norm == 1) 
            {
                return false ;
            }    
            v.x /= norm ;
            v.y /= norm ;
            v.z /= norm ;
            return true ;
        }
        

        
        /**
         * Performs a perspective projection on a 3d point. It converts (x, y, z) coordinates to a 2d location (x, y) on the screen.
         * @param v the Vector3 reference.
         * @param perspective The perspective ratio. If no value is specified, it is calculated automatically by calling the getPerspective() method.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(50,20,40) ;
         * Vector3Util.project(v);
         * trace(v) ;
         * </code>
         */
        public static function projectNew( v:Vector3, perspective:Number ):Vector3
        {
            var c:Vector3 = v.clone() ;
            c.project( perspective ) ;
            return c ;
        }
        
        /**
         * Rotates the current vector object around the x-axis by a certain amount of degrees.
         * @param v The Vector3 reference.
         * @param angle    The amount of degrees that the current vector object will be rotated by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(1,4,7) ;
         * Vector3Util.rotateX(v, 180);
         * trace( v ) ;
         * </code>
         */
        public static function rotateX( v:Vector3 , angle:Number ):void 
        {
            rotateXTrig(v, Trigo.cosD( angle ), Trigo.sinD( angle ));
        }
            
        /**
         * Rotates the current vector object around the x-axis by the cosine and sine of an angle.
         * @param v The Vector3 reference.
         * @param ca The cosine of the angle to rotate the current vector object by.
         * @param sa The sine of the angle to rotate the current vector object by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3       = new Vector3(1,4,7);
         * var cosAngle:Number = Trigo.cosD(180);
         * var sinAngle:Number = Trigo.sinD(180);
         * Vector3.rotateXTrig(v, cosAngle, sinAngle);
         * trace (v);
         * </code>
         */
        public static function rotateXTrig ( v:Vector3, ca:Number, sa:Number ):void 
        {
            v.y = v.y * ca - v.z * sa ;
            v.z = v.y * sa + v.z * ca ;
        }
            
        /**
         * Rotates the current vector object around the y-axis by a certain amount of degrees.
         * @param v The Vector3 reference.
         * @param angle    The amount of degrees that the current vector object will be rotated by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(1,4,7);
         * Vector3Util.rotateY(v,180);
         * trace(v);
         * </code>
         */
        public static function rotateY ( v:Vector3, angle:Number ):void 
        {
            rotateYTrig( v, Trigo.cosD(angle), Trigo.sinD(angle)) ;
        }
        
        /**
         * Rotates the current vector object around the y-axis by the cosine and sine of an angle.
         * @param v The Vector3 reference.
         * @param ca The cosine of the angle to rotate the current vector object by.
         * @param sa The sine of the angle to rotate the current vector object by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3       = new Vector3(3,-8,5);
         * var cosAngle:Number = Trigo.cosD(90);
         * var sinAngle:Number = Trigo.sinD(90);
         * Vector3Util.rotateYTrig(v, cosAngle, sinAngle) ;
         * trace(v) ;
         * </code>
         */
        public static function rotateYTrig ( v:Vector3 , ca:Number, sa:Number ):void 
        {
            v.x = v.x * ca  + v.z * sa;
            v.z = v.x * -sa + v.z * ca ;
        }
            
        /**
         * Rotates the current vector object around the z-axis by a certain amount of degrees.
         * @param v The Vector3 reference.
         * @param angle    The amount of degrees that the current vector object will be rotated by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(1,4,7) ;
         * Vector3Util.rotateZ(v,180) ;
         * trace(v);
         * </code>
         */
        public static function rotateZ( v:Vector3 , angle:Number ):void 
        {
            rotateZTrig(v, Trigo.cosD(angle), Trigo.sinD(angle));
        }
            
        /**
         * Rotates the current vector object around the z-axis by the cosine and sine of an angle.
         * @param v The Vector3 reference.
         * @param ca The cosine of the angle to rotate the current vector object by.
         * @param sa The sine of the angle to rotate the current vector object by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(6,1,4);
         * var cosAngle:Number = Trigo.cosD(45);
         * var sinAngle:Number = Trigo.sinD(45);
         * Vector3Util.rotateZTrig(v, cosAngle, sinAngle);
         * trace(v);
         * </code>
         */
        public static function rotateZTrig ( v:Vector3 , ca:Number, sa:Number):void 
        {
            v.x = v.x * ca - v.y * sa ;
            v.y = v.x * sa + v.y * ca ;
        }
        
        /**
         * Rotates the current vector object around the x and y axes by a certain amount of degrees.
         * @param v The Vector3 reference.
         * @param a The amount of degrees that the current vector object will be rotated around the x-axis by.
         * @param b The amount of degrees that the current vector object will be rotated around the y-axis by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(8,0,0) ;
         * Vector3Util.rotateXY(v,45,45) ;
         * trace(v) ;
         * </code>
         */
        public static function rotateXY (  v:Vector3, a:Number, b:Number):void 
        {
            rotateXYTrig( v, Trigo.cosD(a), Trigo.sinD(a), Trigo.cosD(b), Trigo.sinD(b));
        }
            
        /**
         * Rotates the current vector object around the x and y axes by the cosine and sine of an angle.
         * @param v The Vector3 reference.
         * @param ca The cosine of the angle to rotate the current vector object around the x-axis by.
         * @param sa The sine of the angle to rotate the current vector object around the x-axis by.
         * @param cb The cosine of the angle to rotate the current vector object around the y-axis by.
         * @param sb The sine of the angle to rotate the current vector object around the y-axis by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(6,1,4) ;
         * var cosAngleA:Number = Trigo.cosD(45) ;
         * var sinAngleA:Number = Trigo.sinD(45) ;
         * var cosAngleB:Number = Trigo.cosD(90) ;
         * var sinAngleB:Number = Trigo.sinD(90) ;
         * Vector3Util.rotateXYTrig(v, cosAngleA, sinAngleA, cosAngleB, sinAngleB) ;
         * trace(v) ;
         * </code>
         */
        public static function rotateXYTrig( v:Vector3, ca:Number, sa:Number, cb:Number, sb:Number):void 
        {
            // x-axis rotation
            var rz:Number = v.y * sa + v.z * ca;
            v.y = v.y * ca - v.z * sa ;
            // y-axis rotation
            v.z = v.x * -sb + rz * cb ;
            v.x = v.x * cb + rz * sb  ;
        }
        
        /**
         * Rotates the current vector object around the x, y and z axes by a certain amount of degrees.
         * @param v The Vector3 reference.
         * @param a The amount of degrees that the current vector object will be rotated around the x-axis by.
         * @param b    The amount of degrees that the current vector object will be rotated around the y-axis by.
         * @param c    The amount of degrees that the current vector object will be rotated around the z-axis by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(8,0,0);
         * Vector3Util.rotateXYZ(v,45,45,45);
         * trace (v);
         * </code>
         */
        public static function rotateXYZ ( v:Vector3, a:Number, b:Number, c:Number):void 
        {
            rotateXYZTrig( v, Trigo.cosD(a), Trigo.sinD(a), Trigo.cosD(b), Trigo.sinD(b), Trigo.cosD(c), Trigo.sinD(c));
        }
            
        /**
         * Rotates the current vector object around the x, y and z axes by the cosine and sine of an angle.
         * @param v The Vector3 reference.
         * @param ca The cosine of the angle to rotate the current vector object around the x-axis by.
         * @param sa The sine of the angle to rotate the current vector object around the x-axis by.
         * @param cb The cosine of the angle to rotate the current vector object around the y-axis by.
         * @param sb The sine of the angle to rotate the current vector object around the y-axis by.
         * @param cc The cosine of the angle to rotate the current vector object around the z-axis by.
         * @param sc The sine of the angle to rotate the current vector object around the z-axis by.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var v:Vector3 = new Vector3(6,1,4) ;
         * var cosAngleA:Number = Trigo.cosD(45) ;
         * var sinAngleA:Number = Trigo.sinD(45) ;
         * var cosAngleB:Number = Trigo.cosD(90) ;
         * var sinAngleB:Number = Trigo.sinD(90) ;
         * var cosAngleC:Number = Trigo.cosD(135) ;
         * var sinAngleC:Number = Trigo.sinD(135) ;
         * Vector3Util.rotateXYZTrig(v, cosAngleA, sinAngleA, cosAngleB, sinAngleB, cosAngleC, sinAngleC) ;
         * trace(v) ;
         * </code>
         */
        public static function rotateXYZTrig ( v:Vector3, ca:Number, sa:Number, cb:Number, sb:Number, cc:Number, sc:Number):void 
        {
            // x-axis rotation
            var ry:Number = v.y * ca - v.z * sa ;
            var rz:Number = v.y * sa + v.z * ca ;
            // y-axis rotation
            var rx:Number = v.x * cb + rz * sb ;
            v.z = v.x * -sb + rz * cb ;
            // z-axis rotation
            v.x = rx * cc - ry * sc ;
            v.y = rx * sc + ry * cc ;
        }
        
        /**
         * Sets the specified <code class="prettyprint">Vector3</code> object with the second <code class="prettyprint">Vector3</code> object passed in argument.
         * @param v1 the first <code class="prettyprint">Vector3</code>.
         * @param v2 the second <code class="prettyprint">Vector3</code>.
         * @return the first <code class="prettyprint">Vector3</code> transformed.
         */
        public static function setByVector3( v1:Vector3, v2:Vector3):Vector3
        {
            v1.x = v2.x ;
            v1.y = v2.y ;
            v1.z = v2.z ;
            return v1 ;
        }
        
    
    }

}
