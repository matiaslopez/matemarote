﻿/*

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
	 * Coordinate system for bitmaps. It represents the position of a vertex in the Bitmap.
	 * @author eKameleon
 	 */
	public class UVCoordinate extends CoreObject implements IGeometry
	{

		/**
		 * Creates a new UVCoordinate instance.
		 * @param u	The horizontal coordinate value. The default value is zero.
		 * @param v	The vertical coordinate value. The default value is zero.
		 */
		public function UVCoordinate( u:Number=0 , v:Number=0  )
		{
			this.u = isNaN(u) ? 0 : u ;
			this.v = isNaN(v) ? 0 : v ;
		}
		
		/**
		 * Defines the UVCoordinate object with the u and v properties set to zero.
		 */
		public static var ZERO:UVCoordinate = new UVCoordinate(0,0) ;
		
		/**
		 * Defined the u horizontal coordinate value.
		 */
		public var u:Number ;
			
		/**
		 * Defined the v vertical coordinate value.
		 */
		public var v:Number ;
		
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public function clone():*
		{
			return new UVCoordinate(u,v) ;	
		}
		
		/**
		 * Returns a deep copy of this instance.
	 	 * @return a deep copy of this instance.
		 */
		public function copy():*
		{
			return new UVCoordinate(u,v) ;	
		}
			
		/**	
	 	 * Compares the specified object with this object for equality.
	 	 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
	 	 */
		public function equals( o:* ):Boolean 
		{
			if ( o is UVCoordinate)
			{
				return (o.u == u) && (o.v == v) ;
			}
			else
			{
				return false ;	
			} 	
		}
		
		/**
	 	 * Returns the Object representation of this object.
	 	 * @return the Object representation of this object.
	 	 */
		public function toObject():Object 
		{
			return { u:u , v:v } ;
		}
		
		/**
	 	 * Returns a Eden represensation of the object.
	     * @return a string representing the source code of the object.
	 	 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [u, v]) ;
		}
	
		/**
	 	 * Returns the string representation of the object.
	 	 * @return the string representation of the object.
	 	 */ 	
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + ":{" + u + "," + v + "}]" ;
		}
		
	}
}
