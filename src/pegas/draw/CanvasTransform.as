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
package pegas.draw 
{
    import pegas.geom.Rectangle;    

    /**
     * This tool class transform a <code class="prettyprint">Canvas</code> object with static methods.
     * @author eKameleon
     * Thanks : Peter Hall <www.peterjoel.com> ASVDrawing Class v1.0
     */
    public class CanvasTransform 
    {
        
    
        /**
         * Creates a free form effect over a <code class="prettyprint">Canvas</code> object}.
         * @return the method to be used to creates a free form effect over a <code class="prettyprint">Canvas</code> object}.
         */
        public static function createFreeform 
        (
            area:* , x0:Number, y0:Number, x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number ):Function  
        {
            
            var $r:Rectangle = new Rectangle( area.x , area.y , area.width, area.height) ;
            var $x:Number = $r.x ;
            var $y:Number = $r.y ;
            var $w:Number = $r.width ;
            var $h:Number = $r.height ;
            return function(x:Number, y:Number):Object
            {
                var gx:Number = ( x - $x ) / $w ;
                var gy:Number = ( y - $y ) / $h ;
                var bx:Number = x0 + gy * (x3-x0) ;
                var by:Number = y0 + gy * (y3-y0) ;
                var o:Object = {} ;
                o.x = ( bx + gx * ( ( x1 + gy * ( x2 - x1 ) ) - bx ) ) ; 
                o.y = ( by + gx * ( ( y1 + gy * ( y2 - y1 ) ) - by ) ) ;
                return o ;
            } ;
        }
        
        /**
          * Creates a pinch effect over a <code class="prettyprint">Canvas</code> object}.
          * @return the method to be used to creates a pinch effect over a <code class="prettyprint">Canvas</code> object}.
          */
        public static function createPinch( area:* , xAmount:Number, yAmount:Number):Function 
        {
            
            var r:Rectangle = new Rectangle( area.x , area.y , area.width, area.height) ;
            
            var w:Number = r.width ;
            var h:Number = r.height ;
            
            var h2:Number = h / 2 ;
            var w2:Number = w / 2 ;
            
            var ax:Number = xAmount * w / 200 ;
            var ay:Number = yAmount * h / 200 ;
            
            return function( x:Number ,y:Number ):Object 
            {
                
                var newX:Number ;
                var newY:Number ;
                
                if( ! r.containsCoordinate(x, y) ) 
                {
                    return { x:x,y:y } ;
                }
                                
                if(!isNaN(xAmount)) 
                {
                    var y2:Number = (y - area.y )/h2-1;
                    var gx:Number = (1-y2*y2)*ax;
                    newX = area.x + gx + ( x - area.x )*( w - 2 * gx ) / w ;
                }
                else 
                {
                    newX = x;
                }
                if(!isNaN(yAmount)) 
                {
                    var x2:Number = (x-area.x)/w2-1;
                    var gy:Number = (1-x2*x2)*ay;
                    newY = area.y + gy + ( y - area.y ) * ( h - 2 * gy ) / h ;
                }
                else 
                {
                    newY = y;
                }
                
                return { x : newX ,  y : newY } ;
            } ;
        }
    
        /**
          * Creates a waves effect over a <code class="prettyprint">Canvas</code> object}.
          * @return the method to be used to creates a waves effect over a <code class="prettyprint">Canvas</code> object}.
          */
        public static function createWaves
        ( 
            area:* , xAmount:Number, yAmount:Number, xCount:Number, yCount:Number, xOffset:Number, yOffset:Number):Function 
        {
            
            var r:Rectangle = new Rectangle( area.x , area.y , area.width, area.height) ;
            
            var w:Number = r.width ;
            var h:Number = r.height ;
            var jx:Number = Math.PI * xCount / h ;
            var jy:Number = Math.PI * yCount / w ;
            
            xOffset *= Math.PI/180 ;
            yOffset *= Math.PI/180 ;
            
            return function(x:Number,y:Number):Object 
            {
                if( ! r.containsCoordinate(x, y) ) 
                {
                    return { x:x ,y:y } ;
                }
                var newX:Number = xAmount ? x + xAmount * Math.sin( jx * y + xOffset ) : x ;
                var newY:Number = yAmount ? y + yAmount * Math.sin( jy * x + yOffset ) : y ;
                return { x:newX ,  y:newY } ;
            } ;
        }
    
        /**
          * Creates a Whirl effect over a <code class="prettyprint">Canvas</code> object}.
          * @return the method to be used to creates a Whirl effect over a <code class="prettyprint">Canvas</code> object}.
          */
        public static function createWhirl( centerX:Number, centerY:Number, radius:Number, amount:Number):Function 
        {
            var radius2:Number = radius * radius ;
            var rotate:Number  = amount*Math.PI/180 ;
            return function ( x:Number ,y:Number ):Object 
            {
                var x2:Number = x - centerX ;
                var y2:Number = y - centerY ;
                var r2:Number = x2*x2 + y2*y2 ;
                if( r2 > radius2 ) 
                {
                    return {x:x,y:y} ;
                }
                var th:Number = Math.cos(Math.PI/2 + Math.PI*Math.sqrt(r2)/radius)*rotate ;
                var cosTh:Number = Math.cos(th);
                var sinTh:Number = Math.sin(th);
                var o:Object = {} ;
                o.x = ( x2 * cosTh + y2 * sinTh + centerX ) ; 
                o.y = ( y2 * cosTh - x2 * sinTh +centerY ) ;
                return o ;
            } ;
        }
            
    }
}

