/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package vegas.util
{
    import system.serializers.eden.BuiltinSerializer;                

    /**
     * Array static tool class.
     * @author eKameleon
     */
    public class ArrayUtil 
    {
                
        /**
         * Creates the shallow copy of the Array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.ArrayUtil ;
         * 
         * var ar1:Array = [ [2, 3, 4] , [5, 6, 7] ] ;
         * var ar2:Array = ArrayUtil.clone(ar1) ;
         * 
         * trace( 'clone : ' + ar1 + " : " + ar2 ) ; // 2,3,4,5,6,7
         * trace( 'ar1 == ar2 : ' + ( ar1 == ar2 ) ) ; // false
         * trace( 'ar1[0] == ar2[0] : ' + ( ar1[0] == ar2[0] ) ) ; // true
         * </pre>
         * @return the shallow copy of the Array.
         */
        public static function clone(ar:Array):Array 
        {
              return ar.slice() ;
        }
    
        /**
         * Creates the deep copy of the Array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.ArrayUtil ;
         * 
         * var ar1:Array = [ [2, 3, 4] , [5, 6, 7] ] ;
         * var ar2:Array = ArrayUtil.copy(ar1) ;
         * 
         * trace( 'copy : ' + ar1 + " : " + ar2 ) ; // 2,3,4,5,6,7
         * trace( 'ar1 == ar2 : ' + ( ar1 == ar2 ) ) ; // false
         * trace( 'ar1[0] == ar2[0] : ' + ( ar1[0] == ar2[0] ) ) ; // false
         * </pre>
         * @return the deep copy of the Array.
         */
        public static function copy(ar:Array):Array 
        {
            var a:Array = [] ;
            var l:uint = ar.length ;
            for (var i:uint = 0 ; i < l ; i++) 
            {
                if( ar[i] === undefined ) 
                {
                    a[i] = undefined ;
                }
                else if( ar[i] === null ) 
                {
                    a[i] = null ;
                }
                else 
                {
                    a[i] = Copier.copy(ar[i]) ;
                }
            }
            return a ;
        }
        
        /**
         * Splices an array (removes an element) and returns either the entire array or the removed element.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.ArrayUtil ;
         * 
         * var ar:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
         * trace("+ " + ar);
         * trace( "ArrayUtil.pierce( ar, 1 ) : " + ArrayUtil.pierce( ar, 1 ) ) ;
         * trace("+ " + ar) ;
         * }
         * </pre>
         * @param ar the array.
         * @param index the index of the array element to remove from the array.
         * @param flag a boolean {@code true} to return a new spliced array of false to return the removed element.
         * @return The newly spliced array or the removed element in function of the flag parameter.
         */
        public static function pierce(ar:Array, index:Number, flag:Boolean ):*
        {
            var item:* = ar[index] ;
            ar.splice(index, 1) ;
            return (flag) ? ar : item ;
        }
    
        /**
         * Shuffles an array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.ArrayUtil ;
         * var ar = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
         * trace("+ " + ar);
         * ArrayUtil.shuffle(ar);
         * trace("+ " + ar) ;
         * }
         * </pre>
         * @return the shuffled array.
         * @see #pierce method.
         */
        public static function shuffle( ar:Array ):Array 
        {
            var tmp:Array = [] ;
            var len:int   = ar.length;
            var index:int = len - 1 ;
            for (var i:int = 0; i < len; i++) 
            {
                tmp.push( ArrayUtil.pierce( ar, Math.round(Math.random() * index), false) );
                index-- ;
            }
            while(--len > -1) 
            {
                ar[len] = tmp[len] ;
            }
            return ar ;
        }        
        
        /**
         * Returns a string representing the source code of the array.
         * @return a string representing the source code of the array.
         */
        public static function toSource( ar:Array , ...rest:Array ):String 
        {
            return BuiltinSerializer.emitArray(ar) ;
        }

    }    
    
}

