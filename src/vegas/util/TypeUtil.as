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

// TODO need a full refactoring !!!!!

package vegas.util
{
    
    /**
     * The <code class="prettyprint">TypeUtil</code> utility class is an all-static class with methods for checking and working with the type of the object in AS2.
     * @author eKameleon
     */
    public class TypeUtil
    {
        
       	/**
	     * The type of the 'boolean' objects.
	     */
    	public static const BOOLEAN:String = "boolean" ;
    	
    	/**
	     * The type of the 'date' objects.
	     */
    	public static const DATE:String = "date" ;

    	/**
	     * The type of the 'error' objects.
	     */
    	public static const ERROR:String = "error" ;
    	
    	/**
	     * The type of the 'function' objects.
	     */
    	public static const FUNCTION:String = "function" ;
    	
    	/**
	     * The type of the 'int' objects.
	     */
    	public static const INT:String = "int" ;

    	/**
	     * The type of the 'null' objects.
	     */
    	public static const NULL:String = "null" ;
    	
    	/**
	     * The type of the 'number' objects.
	     */
    	public static const NUMBER:String = "number" ;
    	
    	/**
	     * The type of the 'object' objects.
	     */
    	public static const OBJECT:String = "object" ;

    	/**
	     * The type of the 'string' objects.
	     */
    	public static const STRING:String = "string" ;
    	
    	/**
	     * The type of the 'uint' objects.
	     */
    	public static const UINT:String = "uint" ;
    	
    	/**
	     * The type of the 'undefined' objects.
	     */
    	public static const UNDEFINED:String = "undefined" ;
    	
    	/**
	     * The type of the 'xml' objects.
	     */
    	public static const XML:String = "xml" ; 
        
       	/**
	     * Compares the types of two objects.
	     * @return <code class="prettyprint">true</code> if the two objects are the same primitive type.
	     */
        public static function compare(o1:*, o2:*):Boolean 
        {
		    return typeof(o1) == typeof(o2) ;
    	}
    	
        /**
    	 * Checks if the passed-in object is an explicit instance of the passed-in class.
    	 * @return <code class="prettyprint">true</code> if the passed-in object is an explicit instance of the passed-in class.
    	 */
        public static function isExplicitInstanceOf(o:*, c:*):Boolean 
	    {
		    if (TypeUtil.isPrimitive(o)) 
		    {
    			var tof:String = typeof(o) ;
    			if (c == Function(String)) 
    			{
    			  return (tof == STRING) ;  
    			} 
    			else if (c == Function(Number)) 
    			{
    			    return (tof == NUMBER) ;
    			}
    			else if (c == Function(Boolean))
    			{
    			    return (tof == BOOLEAN) ;  
    			} 
    		} 
    		return o is c ;
    	}
    
	    /**
	     * Checks if the passed-in object is a generic object.
    	 * @return <code class="prettyprint">true</code> if the passed-in object is a generic object.
    	 */
	    public static function isGenericObject( o:* ):Boolean
    	{
		    return o.constructor == Object ;
	    }    
    
    	/**
    	 * Checks if the passed-in object is an instance of the passed-in type.
    	 * @return <code class="prettyprint">true</code> if the passed-in object is an instance of the passed-in type.
    	 */
    	public static function isInstanceOf(o:*, type:*):Boolean 
    	{
    		if (type === Function(Object)) return true ;
    		return (o is type) ;
    	}
    	
    	/**
	     * Checks if the passed-in object is a primitive type.
	     * @return <code class="prettyprint">true</code> if the passed-in object is a primitive type.
	     */
    	public static function isPrimitive(o:*):Boolean 
    	{
      		return (o is String || o is Number || o is Boolean) ;
    	}

    	/**
    	 * Checks if the result of an execution of the typeof method on the passed-in object matches the passed-in type.
    	 * @return <code class="prettyprint">true</code> if the result of an execution of the typeof method on the passed-in object matches the passed-in type.
    	 */
    	public static function isTypeOf(o:*, type:String):Boolean 
    	{
	    	return typeof(o) == type ;
	    }

    	/**
    	 * Checks if the type of the passed-in object matches the passed-in type.
    	 * <p><b>Example :</b>
    	 * <code class="prettyprint">
    	 * import vegas.util.TypeUtil ;
    	 * 
    	 * var s1:String = "hello world" ;
    	 * var s2:String = new String("hello world") ;
	     * trace("s1 is string : " + TypeUtil.typesMatch( s1, String )) ; // output : 'true'
    	 * trace("s2 is string : " + TypeUtil.typesMatch( s2, String )) ; // output : 'true'
	     * </code>
    	 * </p>
	     */
	    public static function typesMatch(o:*, type:*):Boolean 
	    {
		   return o is type ;
    	}

    }
}