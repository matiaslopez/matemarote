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

/**
 * Allows an object to control its own serialization with the eden representation.
 * Thanks : Zwetan Core2 framework inspired by Mozilla SpiderMonkey.
 * @author eKameleon
 */
package vegas.util
{
    import system.Reflection;
    import system.Serializable;    	

    /**
	 * The eden serializer of the VEGAS implementation.
	 */
	public class Serializer
    {
        
 	    /**
	     * Returns the string source representation of the specified object and serialize the array of arguments to pass in the constructor of the class.
	     * @return the string source representation of the specified object and serialize the array of arguments to pass in the constructor of the class.
	     */
		public static function getSourceOf(o:*=null, params:Array=null):String 
		{
			if ( o == null )
			{
				return "null" ;
			}
		    var path:String   = Reflection.getClassPath(o) ;
    		var source:String = "new " + path + "(" ;
    		if ( params != null )
    		{
    			var l:uint = params.length ;
    			if (l > 0) 
	    		{
    				var i:uint = 0 ;
    				while (i < l) 
    				{
	    				source += Serializer.toSource( params[i] ) ;
    					i++ ;
    					if (i<l) 
    					{
	    					source += "," ;
    					}
    				}
    			}
    		}
    		source += ")" ;
    		return source ;
	    }
	
		/**
		 * Returns the eden string representation of the specified object.
		 * @return the eden string representation of the specified object.
		 */
	    public static function toSource( ...arguments ):String 
	    {
		    
		    var o:* = arguments[0] ;
		    
		    if (o === undefined)
		    {
		        return "undefined" ;
		    }
    		if (o === null) 
    		{
    			return "null" ;
    		}
    		if (o is Serializable) 
    		{
    		    return o.toSource.apply(o, arguments.slice(1)) ;
    		}
    		else if (o is Class)
    		{
    			return Reflection.getClassPath(o) ;	
    		}
    		else if (o is Array) 
    		{
    		    return ArrayUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		else if (o is Boolean) 
    		{
    		    return BooleanUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		else if (o is Date)
    		{
    		    return DateUtil.toSource(o) ;
    		}
    		else if (o is Error) 
    		{
    			return ErrorUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		else if (o is Function) 
    		{
    			return FunctionUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		//else if (o as uint) 
    		//{
    		//	return ("new uint(" + o + ")") ;
    		//}
    		//else if (o as int) 
    		//{
    		//	return ("new int(" + o + ")") ;
    		//}
    		else if (o is Number) 
    		{
    			return NumberUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		else if (o is String) 
    		{
    			return StringUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		else if (o is Object) 
    		{
    			return ObjectUtil.toSource.apply(o, arguments.slice()) ;
    		}
	    	else 
	    	{
	    		return "undefined" ;
	    	}
	    	
	    }    
  
    }
}


