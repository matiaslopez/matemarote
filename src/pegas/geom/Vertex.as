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
	
	import vegas.util.Serializer;	

	/**
	 * A Vertex is a point which can be represented in differents coordinates (local, world, screen).
	 * @author eKameleon
	 */
	public class Vertex extends Vector3 
	{

		/**
		 * Creates a <code class="prettyprint">new Vertex</code> instance.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
	 	 * @param z the z coordinate.
		 * @param tx (optional) the transformed x position number. If this argument is 'null' or 'undefined' the default value is x.
		 * @param ty (optional) the transformed y position number. If this argument is 'null' or 'undefined' the default value is y.
		 * @param tz (optional) the transformed z position number. If this argument is 'null' or 'undefined' the default value is z. 
		 */
		public function Vertex(x:Number = 0, y:Number = 0, z:Number = 0, tx:Number=NaN , ty:Number=NaN, tz:Number=NaN)
		{
			super( x , y , z );
			
			this.tx = isNaN(tx) ? x : tx ; 
			this.ty = isNaN(ty) ? y : ty ; 
			this.tz = isNaN(tz) ? z : tz ; 
	
			this.wx = tx ; 
			this.wy = ty ; 
			this.wz = tz ;
	
			this.sy = 0 ; 
			this.sx = 0 ;
				
		}
		
		/**
		 * Defines the Vertex object with the x, y, z properties set to zero.
		 */
		public static var ZERO:Vertex = new Vertex(0,0,0) ;
		
		/**
		 * Defined the x coordinates in the screen World.
		 */
		public var sx:Number;
		
		/**	
		 * Defined the y coordinates in the screen World.
		 */
		public var sy:Number;
		
		/**
		 * Defined the x coordinates in the local coordinates.
		 */
		public var tx:Number;
		
		/**
		 * Defined the y coordinates in the local coordinates.
		 */
		public var ty:Number;
		
		/**
		 * Defined the z coordinates in the local coordinates.
		 */
		public var tz:Number;
		
		/**
		 * Defined the x coordinates in the World coordinates.
		 */
		public var wx:Number;
		
		/**
		 * Defined the y coordinates in the World coordinates.
		 */
		public var wy:Number;
		
		/**
		 * Defined the z coordinates in the World coordinates.
		 */
		 public var wz:Number;	
			
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public override function clone():*
		{
			return new Vertex(x, y, z, tx, ty, tz) ;
		}

		/**
		 * Returns a deep copy of this instance.
		 * @return a deep copy of this instance.
		 */
		public override function copy():*
		{
			var v:Vertex = new Vertex(x, y, z, tx, ty, tz) ;
			v.wx = wx ;
			v.wy = wy ;
			v.wz = wz ;
			v.sx = sx ;
			v.sy = sy ;	
			return v ;
		}

		/**
		 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
		 */
		public override function equals( o:* ):Boolean
		{
			if ( o is Vertex)
			{
				var b1:Boolean = (o.x == x) && (o.y == y) && (o.z == z) ;
				var	b2:Boolean = (o.tx == tx) && (o.ty == ty) && (o.tz == tz) ;
				var b3:Boolean = (o.wx == wx) && (o.wy == wy) && (o.wz == wz) ;
				var b4:Boolean = (o.sx == sx) && (o.sy == sy) ;
				return b1 && b2 && b3 && b4 ;
			}
			return false ;	
		}
		
		/**
		 * Returns the <code class="prettyprint">Vector3</code> representation of the transformed coordinate system of this Vertex.
		 * @return the <code class="prettyprint">Vector3</code> representation of the transformed coordinate system of this Vertex.
		 */
		public function getTransformVector3():Vector3
		{
			return new Vector3( tx, ty, tz ) ;	
		}

		/**
		 * Returns the <code class="prettyprint">Vector3</code> representation of this Vertex in the world coordinate.
		 * @return the <code class="prettyprint">Vector3</code> representation of this Vertex in the world coordinate.
		 */
		public function getWorldVector3():Vector3
		{
			return new Vector3( wx, wy, wz );
		}
		
		/**
	 	 * Returns the Object representation of this object.
	 	 * @return the Object representation of this object.
		 */
		public override function toObject():Object 
		{
			return { x:x , y:y , z:z , tx:tx , ty:ty , tz:tz } ;
		}

		/**
		 * Returns a Eden represensation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{	
			return Serializer.getSourceOf(this, [x, y, z, tx, ty, tz]) ;
		}

		/**
		 * Returns the string representation of the object.
		 * @return the string representation of the object.
		 */ 	
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + ":{x:" + x + ",y:" + y + ",z:" + z + ",tx:" + tx + ",ty:" + ty + ",tz:" + tz + "}]" ;
		}

	}

}
