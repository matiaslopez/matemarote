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
	import flash.utils.ByteArray;
	
	import system.Arrays;
	
	import vegas.util.Copier;	

	/**
     * The <code class="prettyprint">ObjectUtil</code> utility class is an all-static class with methods for working with object.
     * @author eKameleon
     */
    public class ObjectUtil
    {
        
       	/**
	     * Returns the shallow copy of the object.
    	 * @return the shallow copy of the object.
    	 */
        public static function clone(o:Object):Object 
        {
		    return o ;	
        }
        
    	/**
    	 * Returns the deep copy of the object.
    	 * @return the deep copy of the object.
	     */ 
	    public static function copy(o:*):*
        {
			var obj:Object = {} ;
			var prop:String ;
			for (prop in o) 
			{
				if( ! o.hasOwnProperty( prop ) ) 
				{
				  	continue ;
			  	}
			  	else if ( o[prop] == undefined ) 
			  	{
			  		obj[prop] = undefined ;
			  	} 
			  	else if ( o[prop] == null ) 
			  	{
			  		obj[prop] = null ;
				}
				else 
				{
			  		obj[prop] = Copier.copy(obj[prop]) ; 
			  	}
			}
			return obj ;
        }
        
        /**
         * Copy the primitive object passed-in argument.
         */
        public static function copyPrimitive(o:Object):Object
        {
            var buffer:ByteArray = new ByteArray();
            buffer.writeObject(o);
            buffer.position = 0;
            return buffer.readObject();
        }

    	/**
    	 * Returns <code class="prettyprint">true</code> if the passed object is empty of enumerable property.
    	 * @return <code class="prettyprint">true</code> if the passed object is empty of enumerable property.
    	 */
        public static function isEmpty(o:Object):Boolean 
        {
        	var each:String ;
            for (each in o) 
        	{
        	    return false ;	
            }
            each = undefined ;
        	return true ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified object is a simple object.
         * @return <code class="prettyprint">true</code> if the specified object is a simple object.
         */ 
		public static function isSimple(value:Object):Boolean 
		{
			
			var tof:String = typeof(value);
        	switch (tof)
        	{
            	case "number":
	            case "string":
    	        case "boolean":
        	    {
	           		return true;
            	}
	            case "object":
            	{
    	        	return (value is Date) || (value is Array) ;
    		    }
                default :
				{
	    	        return false ; 
				}            	
        	}

		}
    
    	/**
	     * Creates a shallow copy of the current Object.
    	 */
	    public static function memberwiseClone( o:* ):Object 
    	{
    	    var obj:Object = {} ;
            for( var prop:String in o ) 
        	{
               	obj[prop] = o[prop];
            }
        	return obj;
        }
	
	    /**
    	 * Converts an object to an equivalent Boolean value.
    	 */
        public static function toBoolean(o:*):Boolean 
        {
        	return (new Boolean( o.valueOf() )).valueOf() ;
        }

    	/**
    	 * Converts an object to an equivalent Number value.
    	 */
    	public static function toNumber(o:*):Number 
	    {
            return (new Number( o.valueOf() )).valueOf() ;
    	}

    	/**
	     * Converts an object to an equivalent Object value.
    	 */
   	    public static function toObject(o:*):Object 
        {
      		return o.valueOf() as Object ;
    	}
    
       /**
        * Returns the string representation of the source of the specified object.
        * @return the string representation of the source of the specified object.
        */	
 	   public static function toSource( ...arguments ):String 
 	   {
 	        var o:Object        = arguments[0] ;
 	        var indent:Number   = arguments[1] ;
 	        var indentor:String = arguments[2] ;
    		var source:Array = [] ;
    		if (isNaN(indent)) 
    		{
    			indent ++ ;
    		}
    		for ( var prop:String in o ) 
    		{
    			
    			if ( prop in o ) 
    			{
    				if (o[prop] === undefined) 
    				{
    					source.push( prop + ":" + "undefined") ;
    				}
    				else if (o[prop] === null) 
    				{
    					source.push( prop + ":" + "null") ;
    				}
    				else 
    				{
    					// trace("ObjectUtil.toSource : " + prop + " : " + o[prop] ) ;
    					source.push( prop + ":" + Serializer.toSource( o[prop], indent, indentor) ) ;
    				}
    			}
    		}
    		if (isNaN(indent)) 
    		{
    			return "{" + source.join(",") + "}" ;
    		}
    		if (indentor == null) 
    		{
    			indentor = "    " ;
    		}
    		if(isNaN(indent)) 
    		{
    			indent = 0;
    		}
    		var decal:String = "\n" + Arrays.initialize( indent, indentor ).join( "" ) ;
    		return decal + "{" + decal + source.join( "," + decal ) + decal + "}" ;
        }
        
    }
}