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

package pegas.util 
{
	import pegas.geom.Line;
	import pegas.geom.Vector2;	

	/**
	 * Static tool class to creates and manipulates Bezier curves.
	 * <p><b>Thanks :</b>
	 * <ul> 
	 * <li>Robert Penner : <a href="http://www.robertpenner.com">http://www.robertpenner.com</a></li>
	 * <li>Timothee Groleau : <a href="http://timotheegroleau.com/Flash/articles/cubic_bezier/bezier_lib.as">http://timotheegroleau.com/Flash/articles/cubic_bezier/bezier_lib.as</a></li>
	 * </ul>
	 * </p>
	 * <p>In AS2 this class is the pegas.geom.Bezier class.</p>
	 */
	public class BezierUtil 
	{
		
		/**
		 * Calculates an array representation of Point elements to create a quadratic Bezier curve looped or not in n-points.
		 * @return an array representation of Point elements to create a quadratic Bezier curve looped or not in n-points.
		 */
		public static function createBezier(step:Number ,points:Array ,precision:Number=0, loop:Boolean=true):Array 
		{
			
			precision= isNaN(precision) ? 0 : precision ;
			
			var pts:Array = [];
			var nbp:Number = points.length ;
			
			var i:Number=0 ;
			
			var lastpoint:Vector2 ;
			
			var _p0:* ;
			var _p1:* ;
			var _p2:* ;
			
			var t:Number ;
			
			var c1:Number ;
			var c2:Number ;
			var c3:Number ;
			var nx:Number ;
			var ny:Number ;
			var u1:Number ;
			var npoint:Vector2 ;

			while (i<nbp)
			{
				_p0 = points[i] ;
				_p1 = loop ? points[(i+1)%nbp] : (points[(i+1)]) ? points[(i+1)] : _p0 ;
				_p2 = loop ? points[(i+2)%nbp] : (points[(i+2)]) ? points[(i+2)] : _p1 ;
				t = 0 ;
				while (t<=1)
				{
	
					var p0:Vector2 = new Vector2((_p0.x+_p1.x)/2,(_p0.y+_p1.y)/2);
					var p1:Vector2 = new Vector2(_p1.x,_p1.y);
					var p2:Vector2 = new Vector2((_p2.x+_p1.x)/2,(_p2.y+_p1.y)/2);
						
					u1 = 1 - t ;
					c1 = u1 * u1 ;
					c2 = 2 * t * u1 ;
					c3 = t * t ;
				
					nx = c1 * p0.x + c2 * p1.x + c3 * p2.x ;
					ny = c1 * p0.y + c2 * p1.y + c3 * p2.y ;
					
					npoint = new Vector2(nx,ny);
				
					if ( lastpoint != null ) 
					{
						if ( Vector2Util.getDistance(lastpoint,npoint) > precision )
						{
							lastpoint=npoint;
							pts.push(npoint);
						}
					} 
					else 
					{
						lastpoint = npoint ;
						pts.push(npoint) ;
					}
	
					t+=step ;
				}

				i++ ;
			}
			return pts ;
		}

		/**
		 * Returns the baryCenter of a collection of points.
		 * @return the baryCenter of a collection of points.
		 */
		public static function getBaryCenter(pts:Array):Vector2 
		{
			var nbp:Number = pts.length ;
			var x:Number=0;
			var y:Number=0;
			while (--nbp>=0)
			{
				x += pts[nbp].x ;
				y += pts[nbp].y ;
			}
			return new Vector2(x/pts.length,y/pts.length) ;
		}
	
		/**
		 * Split 4 Vector2 reference and return an Object.
		 */
		public static function split(p0:Vector2, p1:Vector2, p2:Vector2, p3:Vector2):Object
		{
			var p0_1:Vector2 = LineUtil.getMiddle(p0, p1) ;
			var p1_2:Vector2 = LineUtil.getMiddle(p1, p2);
			var p2_3:Vector2 = LineUtil.getMiddle(p2, p3);
			var p0_2:Vector2 = LineUtil.getMiddle(p0_1, p1_2);
			var p1_3:Vector2 = LineUtil.getMiddle(p1_2, p2_3);
			var p0_3:Vector2 = LineUtil.getMiddle(p0_2, p1_3);
			var o:Object = 
			{
				b0 : { a:p0  , b:p0_1 , c:p0_2 , d:p0_3 } ,
				b1 : { a:p0_3 , b:p1_3 , c:p2_3 , d:p3 }  
			} ;
			return o ; 
		}
	
		/**
		 * Returns the cubic tangente object of the specified vectors.
		 * @return the cubic tangente object of the specified vectors.
		 */
		public static function getCubicTgt(p0:Vector2, p1:Vector2, p2:Vector2, p3:Vector2, t:Number):Object 
		{
			var p:Vector2 = new Vector2() ;
			p.x = getCubicPt(p0.x, p1.x, p2.x, p3.x, t);
			p.y = getCubicPt(p0.y, p1.y, p2.y, p3.y, t);
			var v:Vector2 = new Vector2() ;
			v.x = getCubicDerivative(p0.x, p1.x, p2.x, p3.x, t);
			v.y = getCubicDerivative(p0.y, p1.y, p2.y, p3.y, t);
			var l:Line = LineUtil.getVectorLine(p, v);
			return { p : p , l : l } ;
		}
		
		/**
		 * @private
		 */
		private static function getCubicDerivative(c0:Number, c1:Number, c2:Number, c3:Number, t:Number):Number 
		{
			var g:Number = 3 * (c1 - c0) ;
			var b:Number = (3 * (c2 - c1)) - g ;
			var a:Number = c3 - c0 - b - g ;
			return ( 3*a*t*t + 2*b*t + g ) ;
		}
		
		/**
		 * @private
		 */
		private static function getCubicPt(c0:Number, c1:Number, c2:Number, c3:Number, t:Number):Number 
		{
			var ts:Number = t*t ;
			var g:Number = 3 * (c1 - c0);
			var b:Number = (3 * (c2 - c1)) - g;
			var a:Number = c3 - c0 - b - g;
			return ( a*ts*t + b*ts + g*t + c0 ) ;
		}

	}

}
