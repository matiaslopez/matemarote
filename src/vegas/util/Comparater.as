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
    import system.Equatable;			

    /**
	 * The <code class="prettyprint">Comparater</code> utility class is an all-static class with a method to returns <code class="prettyprint">true</code> if two object are equals.
	 * @author eKameleon
	 */
	public class Comparater 
	{
		
		/**
	 	 * Compares if two objects are equal by value. 
		 * @param o1 the first object to compare.
		 * @param o2 the second object to compare.
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
		 */	
		public static function compare( o1:*, o2:* ):Boolean 
		{
			if (o1 === undefined && o2 === undefined) 
			{
				return true ;
			}
			if (o1 === null && o2 === null)
			{
				return true ;
			}
			if (o1 is Equatable) 
			{
				return Equatable(o1).equals(o2) ;
			}
			else if ( o1 is Array ) 
			{
				return arrayCompare(o1, o2) ;
			}
			else if ( o1 is Boolean ) 
			{
				return booleanCompare(o1, o2);
			}
			else if ( o1 is Date )
			{
				return dateCompare(o1, o2) ;
			}
			else if ( o1 is Error )
			{
				return errorCompare(o1, o2) ;	
			}
			else if ( o1 is Function )
			{
				return functionCompare(o1, o2) ;
			}
			else if ( o1 is Number )
			{
				return numberCompare(o1, o2) ;
			}
			else if ( o1 is String )
			{
				return stringCompare(o1, o2) ;
			}
			else if ( typeof(o1) === "object" )
			{
				return objectCompare(o1, o2) ;
			}
			else
			{
				return o1 == o2 ;
			}
		
		}	
		
		/**
		 * Compares if two Arrays are equal by value. 
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
		 */
		public static function arrayCompare( ar1:*, ar2:* ):Boolean
    	{
			    
		    if(ar1 == null || !(ar1 is Array))
	    	{
		    	return false ;	
	    	}
				    
    		if(ar2 == null || !(ar2 is Array) ) 
        	{
	        	return false ;
        	}
			    
    		if( ar1 == ar2 )
        	{
	        	return true ;
        	}
    		
    		if( (ar1 as Array).length != ( ar2 as Array ).length )
	        {
	        	return false ;
	        }
    
    		var len:uint = ar1.length ;
    		for( var i:uint = 0 ; i < len ; i++ )
        	{
        		if( ar1[i] == null )
	            {
            		if( ar1[i] != ar2[i] )
                	{
	                	return false;
                	}
            		continue ;
            	}
				if( ! compare(ar1[i], ar2[i] ) )
            	{
	            	return false ;
            	}
        	}
			
			return true ;
    	
    	}

		/**
		 * Compares if two Booleans are equal by value. 
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
	 	 */
		public static function booleanCompare( b1:* , b2:* ):Boolean
	    {
    		if( b1 == null || !(b1 is Boolean) )
        	{
	        	return false ;
        	}
    		if( b2 == null || !(b2 is Boolean) )
        	{
	        	return false ;
        	}
    		return b1.valueOf() == b2.valueOf() ;
    	}

		/**
		 * Compares if two Dates are equal by value.
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
		 */
		public static function dateCompare( d1:* , d2:* ):Boolean
		{
    		if(d1 == null || !TypeUtil.typesMatch(d1, Date))
        	{
	        	return false ;
        	}
    		if(d2 == null || !TypeUtil.typesMatch(d2, Date))
        	{
	        	return false ;
        	}
			return d1.toString() == d2.toString() ;
		}
		
		/**
		 * Compares if two Errors are equal by value.
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
		 */
		public static function errorCompare( e1:* , e2:* ):Boolean
		{
	    	if( e1 == null || !(e1 is Error) )
        	{
	        	return false ;
        	}
    		if( e2 == null || !(e2 is Error))
        	{
	        	return false ;
        	}
			return e1.toString() == e2.toString() ;
		}
	
		/**
		 * Compares if two Functions are equal by value.
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
	 	 */
		public static function functionCompare( f1:* , f2:* ):Boolean
		{
    		if( f1 == null || !( f1 is Function ) )
	        {
        		return false ;
        	}
    		if( f2 == null || !( f2 is Function ) )
        	{
	        	return false ;
        	}
			return f1.valueOf() == f2.valueOf() ;
		}
		
		/**
		 * Compares if two Numbers are equal by value.
	 	 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
		 */
		public static function numberCompare( n1:* , n2:* ):Boolean
		{
		    	
	    	if( n1 == null || !(n1 is Number) )
        	{
	        	return false ;
        	}
    		if( n2 == null || !(n2 is Number) )
        	{
	        	return false ;
        	}
			
			if ( n1.valueOf() == n2.valueOf() )
			{
				return true ;
			}

			// Test if the 2 objects are NaN
	        if ( isNaN(n1) && isNaN(n2) )
        	{
	        	return true ;	
        	}
        	
			if ( n1.toString() == n2.toString() ) 
			{
				return true ;	
			}
		
			return false ;
		}
	
		/**
		 * Compares if two Objects are equal by value.
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
		 */
		public static function objectCompare( o1:* , o2:* ):Boolean
		{
			if ( TypeUtil.typesMatch(o2, Function ) )
			{
				return functionCompare( o2, o1 ) ;	
			}
			if ( o1.valueOf() == null && o2 == null )
			{
				return true ;
			}	
			if (o2 == null || !TypeUtil.typesMatch(o2, Object))
			{
				return false ;	
			}
			if ( o1 == o2 )
			{
				return true ;
			}
		
			for (var member:String in o1)
			{
				/* Note: by convention we consider members starting with __
	           		to be internal properties which should not be compared.
        		*/
				if ( member.charAt(0) == "__") 
				{
					continue ;	
				}
				if( !Comparater.compare(o1[member], o2[member] ) )
            	{
	            	return false;
            	}
	        }		
        
			return true ;		
		
		}
		
		/**
	 	 * Compares if two Strings are equal by value.
		 * @return <code class="prettyprint">true</code> if the 2 objects are equals.
		 */
		public static function stringCompare( s1:* , s2:* ):Boolean
    	{
	    
	    	if( (s1 == null) || !( s1 is String ) )
        	{
	        	return false ;
        	}
	        
    		if( (s2 == null) || !( s2 is String ) )
        	{
	        	return false ;
        	}
			    
       		return  s1.toString() == s2.toString() ;
		
		}
		
	}
	
}
