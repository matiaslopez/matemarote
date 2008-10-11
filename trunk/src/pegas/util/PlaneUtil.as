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
	
	import pegas.geom.Plane;
	import pegas.geom.Vector2;	
	
	/**
	 * Static tool class to manipulate and transform <code class="prettyprint">Plane</code> references.
	 * @author eKameleon
	 */
	public class PlaneUtil 
	{
	
	   	// TODO crossPoint see http://gotoandplay.it/_articles/2005/01/ppbr3d.php
	    // TODO project
	    // TODO normal
	    // TODO xpar
	    // TODO ypar
    
	    /**
	     * Returns the Plane reference defines by the specified object with the properties a, b, c and d.
	     * <p><b>Example :</b></p>
	     * <code class="prettyprint">
	     * import pegas.geom.Plane ;
	     * import pegas.util.PlaneUtil ;
     	 * 
	     * var p:Plane = PlaneUtil.getPlaneByObject( { a:10 , b:10 , c:100 , d:100 } ) ;
	     * trace(p) ; // [Plane:{10,10,100,100}]
	     * </code>
	     * @return the Plane reference defines by the specified object with the properties a, b, c and d.
	     */
    	public static function getPlaneByObject( o:Object ):Plane
	    {
        	return new Plane( o.a, o.b, o.c, o.d ) ;
    	} 
    	
	    /**
	     * Returns the Plane reference defines by the specified object with the two vectors in argument.
	     * <p><b>Example :</b></p>
	     * <code class="prettyprint">
	     * import pegas.geom.Plane ;
	     * import pegas.geom.Vector2 ;
	     * import pegas.util.PlaneUtil ;
     	 * 
	     * var v1:Vector2 = new Vector2(10,10) ;
	     * var v2:Vector2 = new Vector2(100,100) ;
	     * var p:Plane = PlaneUtil.getPlaneByVector( v1, v2 ) ;
	     * trace(p) ; // [Plane:{10,10,100,100}]
	     * </code>
     	 * @return the Plane reference defines by the specified object with the two vectors in argument.
	     */
    	public static function getPlaneByVector( v1:Vector2 , v2:Vector2 ):Plane
    	{
	        return new Plane( v1.x, v1.y, v2.x, v2.y ) ;
	    } 
		
	}
	
}
