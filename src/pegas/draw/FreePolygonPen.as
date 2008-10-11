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
    import flash.display.Graphics;
    import flash.geom.Point;
    
    import pegas.draw.Pen;
    import pegas.geom.Vector2;
    
    import vegas.errors.UnsupportedOperation;    

    /**
     * This pen is the tool to draw a free polygon vector shape. This class don't use the 'align' property.
     * @author eKameleon
     */
    dynamic public class FreePolygonPen extends Pen 
    {
        
        /**
         * The Pen class use composition to control a Graphics reference and draw custom free polygon vector graphic shapes.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param ...arguments An array of flash.geom.Point or pegas.geom.Vector2 objects or an argument serie of point objects. 
         * @author eKameleon
         */
        public function FreePolygonPen( graphic:* , ...arguments:Array )
        {
            super( graphic ) ;
            if ( arguments.length > 0 )
            {
                setPen( arguments ) ;
            }
        }

        /**
          * @private
          */
        public override function set align( align:uint ):void 
        {
            throw new UnsupportedOperation( this + " align property can't be use to align this free shape.") ;
        }

        /**
         * The list of all flash.geom.Point or pegas.geom.Vector2 objects to draw the specified polygon.
         */
        public function get points():Array
        {
            return _points ;    
        }
        
        /**
         * @private
         */
        public function set points( ar:Array ):void
        {
            if ( ar == null || ar.length == 0 )
            {
                _points = null ;
            }
            else
            {
                _points = [] ;
                var len:uint = ar.length ;
                for(var i:uint = 0 ; i<len ; i++)
                {
                    var p:* = ar[i] ;
                    if ( p is Point || p is Vector2 )
                    {
                        _points.push( p ) ;                        
                    }
                }
            }
        }
        
        /**
         * Draws the shape.
         * @param ...arguments An array of flash.geom.Point or pegas.geom.Vector2 objects or an argument serie of point objects.
         */
        public override function draw( ...arguments:Array ):void
        {
            if ( arguments.length > 0 )
            {
                setPen.apply( this,  arguments ) ;
            }
            super.draw() ;
        }

        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( _points == null )
            {
                return ;
            }
            var size:uint = _points.length ;
            if ( size > 1 ) 
            {
                graphics.moveTo( _points[0].x, _points[0].y );
                for( var i:int = 1 ; i< size ; i++ )
                {
                    graphics.lineTo( _points[i].x, _points[i].y );
                }
                graphics.lineTo( _points[0].x, _points[0].y );
            }
        }
    
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
          * @param align (optional) The align value of the pen.
         */
        public function setPen( ...args:Array  ):void 
        {
            if ( args.length == 1 && args[0] is Array ) 
            {
                this.points = args[0] ;
            }
            else if ( args.length > 0 )
            {
                this.points = args ;
            }
        }
        
        /**
         * @private
         */
        private var _points:Array = null ;
        
    }

    
}
