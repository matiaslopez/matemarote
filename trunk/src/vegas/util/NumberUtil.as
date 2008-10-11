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
   
    /**
     * The <code class="prettyPrint">NumberUtil</code> utility class is an all-static class with methods for working with number.
     * @author eKameleon
     */
    public class NumberUtil
    {
        
    	/**
    	 * Returns a copy by reference of this Number.
    	 * @return a copy by reference of this Number.
    	 */
    	public static function clone(n:Number=NaN):Number 
    	{
    		return n ;
    	}

	    /**
    	 * Returns a copy by value of this Number.
    	 * @return a copy by value of this Number.
    	 */
    	public static function copy(n:Number=NaN):Number 
    	{
    		return Number(n.valueOf()) ;
    	}

    	/**
     	 * Compares if two Numbers are equal by value
     	 * @return <code class="prettyprint">true</code> if the two passed-in values are the sames.
     	 */
    	public static function equals( n1:Number=NaN, n2:Number=NaN ):Boolean 
    	{
       		if ( n1.toString() == n2.toString() )
    		{
    		    return true ;
    		}
    		if(n1.valueOf() == n2.valueOf()) 
    		{
    		    return true ;
    		}
    		return false ;
        }
    	
    	/**
    	 * Converts to an equivalent Boolean value.
    	 */
    	public static function toBoolean(n:Number=NaN):Boolean 
    	{
    		if (isNaN(n) || n.valueOf() == 0) return false ;
    		return true ;
    	}
    	
    	/**
	     * Returns the hexadecimal string representation of the specified number value.
		 * @example
		 * <pre class="prettyprint">
     	 * import vegas.util.NumberUtil ;
	     *
	     * for (var i:uint =0 ; i<256 ; i++)
	     * {
	     *     trace( NumberUtil.toHex( i ) ) ; // without optional prefix argument (default "0x")
	     * }
	     *
	     * trace("---") ; 
	     * 
	     * for (var i:Number =0 ; i<256 ; i++)
     	 * {
	     *     trace( NumberUtil.toHex( i , "#" ) ) ; // with optional prefix argument
	     * }
     	 * </pre>
     	 * @param n the number to format.
     	 * @param prefix Optional string represention of the prefix of the return format string. If this argument is undefined the prefix is "0x".
     	 * @return the hexadecimal string representation of the specified number value.
     	 */
    	public static function toHex( n:Number, prefix:String ):String
    	{
	        if ( prefix == null )
        	{
	            prefix = "0x" ;    
        	}
        	var temp:String = n.toString(16) ;
        	if(n < 16) 
        	{
	            temp = "0" + temp ;
        	}
        	return (prefix || "") + temp ;
    	}
    	
        /**
         * Returns a string representation of the specified number.
         * @return a string representation of the specified number.
         */
    	public static function toSource( n:Number , ...rest:Array ):String 
    	{
		    return n.toString() ;
        }
        
    }

}