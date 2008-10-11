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
	 * Boolean tools class.
	 * @author eKameleon
	 */    
    public class BooleanUtil
    {
        
        /**
         * Returns a copy by reference of this boolean.
         * @return a copy by reference of this boolean.
         */
        public static function clone(b:Boolean):Boolean 
        {
		    return b ;
    	}

        /**
         * Returns a copy by value of this object.
         * @return a copy by value of this object.
         */
    	public static function copy(b:Boolean):Boolean 
    	{
	    	return b.valueOf() ;
    	}

        /**
         * Compares if two Booleans are equal by value.
         */
	    public static function equals( b1:Boolean, b2:Boolean ):Boolean 
	    {
    		if ( !b2 ) 
    		{
	    		return false ;
    		}
    		return b1.valueOf() == b2.valueOf() ;
        }
	    
	    /**
	     * Converts to an equivalent Boolean value.
	     */
    	public static function toBoolean(b:Boolean):Boolean 
    	{
    		return b.valueOf() ;
    	}
	
	    /**
 	     * Converts to an equivalent Number value.
 	     */
    	public static function toNumber(b:Boolean):Number 
    	{
    		return  b.valueOf() == true ? 1 : 0 ;
        }
	
	    /**
	     * Converts to an equivalent Object value.
	     */
    	public static function toObject(b:Boolean):Object 
    	{
    		return new Boolean( b.valueOf() ) ;
        }
        
        /**
         * Returns a string representation of the source code of the boolean.
         * @return a string representation of the source code of the boolean.
         */
        public static function toSource( b:Boolean , ...rest:Array ):String 
        {
		    return BooleanUtil.equals( b , true ) ? "true" : "false" ;
        }
        
    }
}