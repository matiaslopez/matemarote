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
	 * Represents a vector in a 3D world with the coordinates x, y, z and w.
	 * @author eKameleon
	 */
	public class Vector4 extends Vector3 
	{

		/**
		 * Creates a new <code class="prettyprint">Vector4</code> instance.
	 	 * @param x the x coordinate.
		 * @param y the y coordinate.
		 * @param z the z coordinate.
		 * @param w the w coordinate.
	 	 */ 	
		public function Vector4(x:Number = 0, y:Number = 0, z:Number = 0 , w:Number = 0 )
		{
			super( x, y, z );
			this.w = isNaN(w) ? 0 : w ;
		}
		
		/**
		 * Defines the Vector4 object with the x, y, z and w properties set to zero.
		 */
		public static var ZERO:Vector4 = new Vector4(0,0,0,0) ;
		
		/**
		 * Defined the w coordinate.
		 */
		public var w:Number;
	
        /**
         * Computes the addition of two Vector4 object.
         * @param v the vector object to add.
         */
        public override function addition( v:* ):void
        {
             super.addition(v) ;
             w = v.w ;
        }
	
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public override function clone():*
		{
			return new Vector4(x, y, z, w) ;	
		}
		
		/**
		 * Returns a deep copy of this instance.
	 	 * @return a deep copy of this instance.
		 */
		public override function copy():*
		{
			return new Vector4(x, y, z, w) ;	
		}
		
		/**
		 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
		 */
		public override function equals( o:* ):Boolean 
		{
			if ( o is Vector4)
			{
				return (o.x == x) && (o.y == y) && (o.z == z) && (o.w == w) ;
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
        public override function scale( value:Number ):void
        {
            super.scale( value ) ;
            w *= value ;
        }    		
		
        /**
         * Computes the substraction of the current Vector3 object with an other.
         * @param v the vector to substract.
         */
        public override function substraction( v:* ):void
        {
            super.substraction(v) ;
            w -= v.w ;
        } 		
		
		/**
	 	 * Returns the Object representation of this object.
	 	 * @return the Object representation of this object.
	 	 */
		public override function toObject():Object 
		{
			return { x:x , y:y , y:y , w:w } ;
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
	
	}
	
}

