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
	import system.Reflection;
	
	import vegas.core.CoreObject;
	import vegas.util.Serializer;	

	/**
     * The <code class="prettyprint">Dimension</code> class encapsulates the width and height of an object.
     * @author eKameleon
     */
    public class Dimension extends CoreObject implements IGeometry		
	{

		/**
    	 * Creates a new <code class="prettyprint">Dimension</code> instance.
    	 */
        public function Dimension( ...arguments:Array )
        {
			width  = 0 ;
			height = 0 ;
			var size:Number = arguments.length ;
            if ( size > 0 )
    		{
    			if ( ( size == 1 ) && ( arguments[0] is Dimension ) )
    			{
    			    var d:Dimension = arguments[0] as Dimension ;
    				width  = d.width  ;
    				height = d.height ;
    			}
    			else if ( ( size == 2 ) && (arguments[0] is Number) && (arguments[1] is Number) )
    			{
    				width  = arguments[0] ;
    				height = arguments[1] ;
    			}
    		}
        }


		/**
		 * Defines the Dimension object with the width and height properties set to zero.
		 */
		public static var ZERO:Dimension = new Dimension() ;

    	/**
    	 * Determinates the height value of this instance.
    	 */
    	public var height:Number ;
    	
    	/**
	     * Determinates the width value of this instance.
    	 */
    	public var width:Number ;

    	/**
    	 * Returns a shallow copy of this instance.
    	 * @return a shallow copy of this instance.
    	 */
    	public function clone():*
    	{
    		return new Dimension(width, height) ;	
    	}
    
    	/**
    	 * Returns a deep copy of this instance.
    	 * @return a deep copy of this instance.
    	 */
    	public function copy():*
    	{
    		return new Dimension(width, height) ;	
    	}
    
    	/**
    	 * Decreases the size by s and return its self(this).
    	 * @param s an other Dimension reference to decreases the current Dimension.
    	 * @return the current reference of this object.
    	 */
    	public function decreaseSize( s:Dimension ):Dimension
    	{
    		width  -= s.width ;
    		height -= s.height ;
    		return this ;	
    	}
    
    	/**
    	 * Compares the specified object with this object for equality.
    	 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
    	 */
    	public function equals( o:* ):Boolean
    	{
    		if ( o is Dimension )
    		{
    			return (o as Dimension).width == width && (o as Dimension).height ;
    		}
    		else
    		{
    			return false ;
    		}	 
    	}
    	
    	/**
    	 * Returns a new bounds with this size with a pos.
    	 * @return a new bounds with this size with a pos.
    	 */
    	public function getBounds(x:Number, y:Number):Rectangle
    	{
    		x = isNaN(x) ? 0 : x ;
    		y = isNaN(y) ? 0 : y ;
    		return new Rectangle(x, y, width, height) ;	
    	}
    	
    	/**
    	 * Increases the size by s and return its self(this).
    	 * @param s an other Dimension reference to increase the current Dimension.
    	 * @return the current reference of this object.
    	 */
    	public function increaseSize( s:Dimension ):Dimension
    	{
    		width  += s.width ;
    		height += s.height ;
    		return this ;	
    	}
    	
    	/**
    	 * Sets the size of this instance.
    	 */
    	public function setSize( w:Number, h:Number ):void
    	{
    		width  = w ;
    		height = h ;
    	}
    	
    	/**
		 * Returns the Object representation of this object.
	 	 * @return the Object representation of this object.
		 */
		public function toObject():Object 
		{
			return { width:width , height:height } ;
		}
    	
    	/**
    	 * Returns a Eden representation of the object.
    	 * @return a string representing the source code of the object.
    	 */
    	public override function toSource( indent:int = 0 ):String  
    	{
    		return Serializer.getSourceOf(this, [width, height]) ;
    	}
    	
    	/**
    	 * Returns the string representation of this instance.
    	 * @return the string representation of this instance.
    	 */
    	public override function toString():String 
    	{
    		return "[" + Reflection.getClassName(this) + " width:" + width + ",height:" + height + "]" ;
    	}
    
    }

}