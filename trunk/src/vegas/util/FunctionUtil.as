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
     * The <code class="prettyprint">FunctionUtil</code> utility class is an all-static class with methods for working with function.
     * @author eKameleon
     */
    public class FunctionUtil
    {
    
	    /**
    	 * Returns a copy by value of this function.
    	 * Attention : we can not copy by reference a function , if you want to do that use apply or call method to make a kind of delegate.
    	 */
    	public static function clone(f:Function):Function 
    	{
    		return f ;
    	}
    
    	/**
    	 * Returns a copy by value of this object.
    	 */
    	public static function copy(f:Function):Function 
    	{
    		return f ;
    	}
    
    	/**
    	 * Compares if two Functions are equal by reference.
     	 */
    	public static function equals( f1:Function, f2:Function ):Boolean 
    	{
    		if ( f2 == null  ) 
    		{
    		    return false ;
    		}
    		return f1 == f2 ;
        }

        /**
         * Should returns a string representing the source code of the function, 
         * but instead the choice has been made to only return the string “(function)”.
         */
    	public static function toSource( f:Function ):String 
    	{
	    	return '(function)' ;
        }

    }
    
}