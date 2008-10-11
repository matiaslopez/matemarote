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
    import pegas.geom.IGeometry;
    import pegas.util.Matrix4Util;
    
    import system.Reflection;
    import system.numeric.Mathematics;
    
    import vegas.core.CoreObject;
    import vegas.util.Comparater;
    import vegas.util.Serializer;	

    /**
     * Matrix with 4 rows and 4 columns.
     * @example
     * <pre class="prettyprint">
     * import pegas.geom.Matrix4 ;
     * var m:Matrix4 = new Matrix4() ;
     * // 1 0 0 0
     * // 0 1 0 0
     * // 0 0 1 0
     * // 0 0 0 1
     * </pre>
     * @author eKameleon
     */
    public class Matrix4 extends CoreObject implements IGeometry 
    {
            
        /**
         * Creates a new <code class="prettyprint">Matrix4</code> instance.
         * <p>If 16 arguments are passed to the constructor, it will create a <code class="prettyprint">Matrix4</code> with the values.</p> 
         * <p>In the other case, a identity <code class="prettyprint">Matrix4</code> is created.</p>
         * <p><b>Example 1 - <code class="prettyprint">Matrix4</code> identity :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix4 ;
         * var m:Matrix4 = new Matrix4() ;
         * // 1 0 0 0
         * // 0 1 0 0
         * // 0 0 1 0
         * // 0 0 0 1
         * </pre>
         * <p><b>Example 2 - <code class="prettyprint">Matrix4</code> with 16 arguments :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix4 ;
         * var m:Matrix4 = new Matrix4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16) ;
         * //  1  2  3  4
         * //  5  6  7  8
         * //  9 10 11 12
         * // 13 14 15 16
         * </pre>
         */
        public function Matrix4( ...arguments:Array )
        {
            if (arguments.length == 16)
            {
                n11 = arguments[0]  ; n12 = arguments[1]  ; n13 = arguments[2]  ; n14 = arguments[3] ;
                n21 = arguments[4]  ; n22 = arguments[5]  ; n23 = arguments[6]  ; n24 = arguments[7] ;
                n31 = arguments[8]  ; n32 = arguments[9]  ; n33 = arguments[10] ; n34 = arguments[11];
                n41 = arguments[12] ; n42 = arguments[13] ; n43 = arguments[14] ; n44 = arguments[15];
            }
            else if (arguments[0] is Matrix4)
            {
                Matrix4Util.setByMatrix(this, arguments[0]) ;    
            }
            else if (arguments[0] is Quaternion)
            {
                Matrix4Util.setByQuaternion(this, arguments[0]) ;
            }
            else
            {
                identity() ;
            }
        }
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 1 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0 
         * </pre>
         */
        public var n11:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 1 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n12:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 1 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre>
         */
        public var n13:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 1
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n14:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 1 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n21:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 1 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n22:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 1 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n23:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <code class="prettyprint">
         * 0 0 0 0
         * 0 0 0 1
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n24:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 1 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n31:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 1 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n32:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 1 0
         * 0 0 0 0
         * </pre> 
         */
        public var n33:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 1
           * 0 0 0 0
         * </pre> 
          */
        public var n34:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 1 0 0 0
         * </pre> 
         */
        public var n41:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 1 0 0
         * </pre> 
         */
        public var n42:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 1 0
         * </pre> 
         */
        public var n43:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 1
         * </pre> 
         */
        public var n44:Number;

        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */    
        public function clone():*
        {
            return new Matrix4( this ) ;
        }
        
        /**
         * Returns a deep copy of this instance.
         * @return a deep copy of this instance.
         */
        public function copy():*
        {
            return new Matrix4( this ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals(o:*):Boolean
        {
            if (o is Matrix4)
            {
                return Comparater.arrayCompare( Matrix4(o).toArray(), toArray() ) ;
            }
            else
            {
                return false ;    
            }
        }
        
        /**
         * Returns the matrix[x][y] value.
         * @return the matrix[x][y] value.
         */
        public function getEntry( x:Number, y:Number ):*
        {
            var m:Array = toArray() ;
            return m[x][y] ;
        }

        /**
         * Sets matrix[x][y] with the specified value.
         */
        public function setEntry( x:Number , y:Number , value:* ):void
        {
            x = Mathematics.clamp(x, 0, 3) ;
            y = Mathematics.clamp(y, 0, 3) ;
            var m:Array = toArray() ;
            m[x][y] = value ;
        }

        /**
         * Transforms the specified Matrix4 in argument in the identity Matrix4.
         */
        public function identity():void
        {
            n11 = 1 ; n12 = 0 ; n13 = 0 ; n14 = 0 ;
            n21 = 0 ; n22 = 1 ; n23 = 0 ; n24 = 0 ;
            n31 = 0 ; n32 = 0 ; n33 = 1 ; n34 = 0 ;
            n41 = 0 ; n42 = 0 ; n43 = 0 ; n44 = 1 ;
        }

        /**
         * Returns the Array representation of this instance.
         * @return the Array representation of this instance.
         */
        public function toArray():Array
        {
            var m:Array = 
            [
                [n11, n12, n13, n14] ,
                [n21, n22, n23, n24] ,
                [n31, n32, n33, n34] ,
                [n41, n42, n43, n44]
            ] ;
            return m ;
        }

        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            var o:Object = {} ;
            o.n11 = this.n11 ; o.n12 = this.n12 ; o.n13 = this.n13 ; o.n14 = this.n14 ;
            o.n21 = this.n21 ; o.n22 = this.n22 ; o.n23 = this.n23 ; o.n24 = this.n24 ;
            o.n31 = this.n31 ; o.n32 = this.n32 ; o.n33 = this.n33 ; o.n34 = this.n34 ;
            o.n41 = this.n41 ; o.n42 = this.n42 ; o.n43 = this.n43 ; o.n44 = this.n44 ;
            return o ;
        }
        
        /**
         * Returns a Eden represensation of the object.
         * @return a string representing the source code of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            var params:Array = [n11,n12,n13,n14,n21,n22,n23,n24,n31,n32,n33,n34,n41,n42,n43,n44] ;
            return Serializer.getSourceOf(this, params) ;
        }

        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public override function toString():String
        {
            var s:String = "[" + Reflection.getClassName(this) + ":" ;
            s += "[" + n11 + "," + n12 + "," + n13 + "," + n14 + "]" ;
            s += "," ;
            s += "[" + n21 + "," + n22 + "," + n23 + "," + n24 + "]" ;
            s += "," ;
            s += "[" + n31 + "," + n32 + "," + n33 + "," + n34 + "]" ;
            s += "," ;
            s += "[" + n41 + "," + n42 + "," + n43 + "," + n44 + "]" ;
            s += "]" ;
            return s ;
        }
    
    }

}

