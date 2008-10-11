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
	import pegas.util.Vector3Util;
	
	import system.Reflection;
	
	import vegas.core.CoreObject;
	import vegas.util.Serializer;	

	/**
	 * This means half of a line, it is infinite in one direction, but ends at a certain point in the other direction.
	 * In Euclidean geometry, a ray (or half-line) given two distinct points A (the origin) and B on the ray, is the set of points C on the line containing points A and B such that A is not strictly between C and B. 
	 * In geometry, a ray starts at one point, then goes on forever in one direction : <code class="prettyprint">(A) -- (B) -- ((C)) -- ></code>
	 * @author eKameleon
	 */
	public class Ray extends CoreObject implements IGeometry
	{

		/**
		 * Creates a new <code class="prettyprint">Ray</code> instance.
		 * <p><b>Example :</b></p>
	 	 * <p>With a Ray object passed in the argument of the constructor :</p>
		 * <pre class="prettyprint">
		 * var r:Ray = new Ray( r:Ray) ;
		 * </pre>
		 * <p>With 2 Vector3 objects passed in the arguments of the constuctor : </p>
		 * <pre class="prettyprint">
	 	 * var r:Ray = new Ray( r:Vector3 , p:Vector3 ) ;
	 	 * </pre>
	 	 */
		public function Ray( ...arguments:Array )
		{
			p = new Vector3() ;
			v = new Vector3() ;
			if ( arguments[0] is Ray )
			{
				var r:Ray = arguments[0] ;
				p = r.p ;
				v = r.v ;
			}
			else if ( arguments.length == 2)
			{
				if (arguments[0] is Vector3 )
				{
					p = arguments[0].clone() ;
				}			
				if (arguments[1] is Vector3 )
				{
					v = arguments[1].clone() ;
				}
			}
			update() ;
		}

		/**
		 * Determinates the p <code class="prettyprint">Vector3</code> of the Ray object.
		 */
		public var p:Vector3 ;
		
		/**
		 * Determinates the q <code class="prettyprint">Vector3</code> of the Ray object.
		 */
		public var q:Vector3 ;	
		
		/**
		 * Determinates the v <code class="prettyprint">Vector3</code> of the Ray object.
		 */	
		public var v:Vector3 ;
		
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public function clone():*
		{
			return new Ray( this ) ;
		}

		/**
	 	 * Returns a deep copy of this instance.
		 * @return a deep copy of this instance.
		 */
		public function copy():*
		{
			var r:Ray = new Ray() ;
			r.p = p.copy() ;
			r.q = q.copy() ;
			r.v = v.copy() ;
			return r ;
		}

		/**
		 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
		 */
		public function equals( o:* ):Boolean 
		{
			if (o is Ray)
			{
				return p.equals(o.p) && v.equals(o.v) && q.equals(o.q) ;  
			}
			else
			{
				return false ;
			}
		}

		/**
		 * Returns a Eden represensation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [p, v]) ;
		}
		
		/**
		 * Returns the string representation of the object.
		 * @return the string representation of the object.
		 */ 	
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + ":" + p + "+t*" + v + "]" ;
		}

		/**
		 * Updates the Ray object.
		 */
		public function update():void
		{
			if (q != null)
			{
				Vector3Util.setByVector3(q, p) ;
				q.addition(v) ;
			}
			else
			{
				q = Vector3Util.getAddition(p, v) ;	
			}
		}
	}
}

