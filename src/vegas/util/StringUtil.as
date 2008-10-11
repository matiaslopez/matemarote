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
	 * The <code class="prettyprint">StringUtil</code> utility class is an extended String class with methods for working with string.
	 * This class complete the system.Strings static class.
	 * @author eKameleon
	 */
    public class StringUtil
    {
        
        /**
  		 * Represents the empty string.
  		 * This property should be read-only.
		 */
        public static const EMPTY:String = "" ;
        
        /**
         * Represents the space string value.
         */ 
        public static const SPC:String = " " ; // SPACE
		
		/**
         * Returns a shallow copy of the specified string.
         * @return a shallow copy of the specified string.
         */
        public static function clone( s:String ):String 
        {
		    return s ;	
    	}
  		
        /**
         * Returns a copy by value of this object.
         * @return a copy by value of this object.
         */
        public static function copy(str:String):String 
        {
		    return str.valueOf() ;
	    }
        
        /**
         * Determines whether the start of this instance matches the specified String.
         */
    	public static function firstChar( str:String ):String 
    	{
  			return str.charAt(0) ;
    	}
 	
		/**
		 * Returns <code class="prettyprint">true</code> if this string is empty.
         * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import vegas.util.StringUtil ;
		 * var b1:Boolean = StringUtil.isEmpty("") ; // true
		 * var b2:Boolean = StringUtil.isEmpty("hello world") ; // false
		 * </pre>
		 * @param str the string object.
		 * @return <code class="prettyprint">true</code> if this string is empty.
	 	 */
	    public static function isEmpty(str:String):Boolean 
	    {
		    return str.length == 0 ;
    	}
 
 		/**
		 * Returns the last char of the string. 
         * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import vegas.util.StringUtil ;
		 * trace( StringUtil.lastChar("hello world") ; // d
		 * </pre>
		 * @param str the string object.
		 * @return the last char of the string.
	 	 */
 	    public static function lastChar(str:String):String 
 	    {
    		return str.charAt(str.length - 1) ;
	    }

		/**
		 * Reports the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
	 	 * @return the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
	 	 */
    	public static function lastIndexOfAny(str:String, ar:Array):int 
    	{
    		var index:int = -1 ;
    		var l:uint = ar.length ;
    		for (var i:Number = 0 ; i<l ; i++) 
    		{
    			index = str.lastIndexOf(ar[i]) ;
    			if (index > -1) 
    			{
    				return index ;
    			}
    		}
    		return index ;
	    }
	
		/**
		 * Returns a new String value who contains the specified String characters repeated count times.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.StringUtil ;
         * 
         * trace(StringUtil.repeat("hello", 0)) ; // hello
         * trace(StringUtil.repeat("hello", 3)) ; // hellohellohello
         * </pre>
		 * @return a new String value who contains the specified String characters repeated count times.
		 */
		public static function repeat( str:String="" , count:uint=0 ):String
		{
			var result:String = "" ;
			if ( count > 0 )
			{
				for( var i:uint = 0 ; i<count ; i++)
				{
					result = result.concat(str) ;
				}
			}
			else
			{
				result = str ;	
			}
			return  result ;
		}	
	
	 	/**
		 * Replaces the 'search' string with the 'replace' String.
         * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * vegas.util.StringUtil.replace("hello world", "hello", "hi") ; // "hello world" -> "hi world"
		 * </pre>
		 * @param the string to transform.
		 * @return the new string transform with this method.
		 */
		public static function replace(str:String, search:String, replace:String):String 
 	   	{
		    return str.split(search).join(replace) ;
	    }
	
		/**
	 	 * Reverses the current instance.
         * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var reverse:String = vegas.util.StringUtil.reverse("hello") ; // "olleh"
		 * </pre>
	 	 * @return the reverse string of the specified string passed-in argument.
		 */
		public static function reverse(str:String):String 
	    {  
		    var ar:Array = str.split("") ;
    		ar.reverse() ;
	    	return ar.join("") ;
	    }

		/**
		 * Adds and removes elements in the string.
		 * @example
		 * <pre class="prettyprint">
		 * import vegas.util.StringUtil ;
		 * 
		 * var result:String ;
		 * 
		 * result = StringUtil.splice("hello world", 0, 1, "H") ;
		 * trace(result) ; // Hello world
		 * 
		 * result = StringUtil.splice("hello world", 6, 0, "life") ;
		 * trace(result) ; // hello lifeworld
		 * 
		 * result = StringUtil.splice("hello world", 6, 5, "life") ;
		 * trace(result) ; // hello life
		 * </pre>
		 * @param startIndex Index at which to start changing the string.
	 	 * @param deleteCount Indicating the number of old character elements to remove.
		 * @param value The elements to add to the string. If you don't specify any elements, splice simply removes elements from the string.
	 	 */	
	    public static function splice(str:String, startIndex:uint, deleteCount:uint=0, value:* = null ):String 
	    {
			var a:Array = StringUtil.toArray(str) ;
			a.splice(startIndex, deleteCount, value) ;
			return a.join("") ;
	    }

		/**
		 * Returns an array representation of this instance.
         * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import vegas.util.StringUtil ;
		 * trace( StringUtil.toArray("hello world" )) ; // h,e,l,l,o, ,w,o,r,l,d
		 * </pre>
		 * @return an array representation of this instance.
	 	 */
	    public static function toArray(str:String, separator:String="" ):Array 
	    {
		    return str.split(separator) ;
	    }

		/**
		 * Returns the eden representation of the object.
		 * @example
		 * <pre class="prettyprint">
		 * import vegas.util.StringUtil ;
		 * var source:String = StringUtil.toSource("hello world") ;
	 	 * trace(source) ; // "hello world"
		 * </pre>
	 	 * @return a string representing the source code of the object.
		 */
	    public static function toSource( str:String , ...rest:Array ):String 
	    {
            return BuiltinSerializer.emitString(str) ;
	    }
	    
		/**
		 * Returns the value of this specified string with the first character in uppercase.
         * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import vegas.util.StringUtil ;
		 * trace( StringUtil.ucFirst("hello world" )) ; // Hello world
		 * </pre>
		 * @return the value of this string with the first character in uppercase.
	 	 */
	 	public static function ucFirst(str:String):String 
	    {
		    return str.charAt(0).toUpperCase() + str.substring(1) ;
	    }

		/**
		 * Uppercases the first character of each word in a string.
         * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import vegas.util.StringUtil ;
	 	 * trace( StringUtil.ucWords("hello world" )) ; // Hello World
		 * </pre>
		 * @return the string value with the first character in uppercase of each word in a string.
		 */	
	    public static function ucWords(str:String):String 
	    {
		    var ar:Array = str.split(" ") ;
		    var l:uint = ar.length ;
		    while(--l > -1) 
		    {
		        ar[l] = StringUtil.ucFirst(ar[l]) ;
		    }
		    return ar.join(" ") ;
	    }
 
    }

}