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
    import flash.geom.Point;
    
    import pegas.draw.Pen;
    import pegas.geom.Line;
    import pegas.geom.Vector2;
    import pegas.util.LineUtil;    

    /**
     * This pen is the basic tool to draw a line.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.CapsStyle ;
     * import flash.display.JointStyle ;
     * import flash.display.LineScaleMode ;
     * 
     * import pegas.draw.LinePen ;
     * import pegas.draw.LineStyle ;
     * 
     * import pegas.geom.Vector2 ;
     * 
     * var shape:Shape = new Shape() ;
     * 
     * var start:Vector2 = new Vector2(0,0) ;
     * var end:Vector2   = new Vector2(100,100) ;
     * 
     * var pen:LinePen = new LinePen( shape.graphics , start , end ) ;
     * pen.lineStyle  = new LineStyle( 2, 0xFFFFFF , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
     * pen.draw() ;
     * 
     * addChild( shape ) ;
     * </pre>
     */
   	dynamic public class LinePen extends Pen 
    {

        /**
         * Creates a new LinePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param start The default start Vector object.
         * @param end The default end Vector object.
         */
        public function LinePen( graphic:* , start:* = null , end:* = null )
        {
            super( graphic );
            setPen( end , start ) ;
        }

        /**
         * @private
         */
        public override function set align( align:uint ):void 
        {
            throw new Error( this + " align property can't be use to align this free shape.") ;
        }

        /**
         * The end vector object of this line pen.
         */
        public var end:Vector2 = new Vector2() ;

        /**
         * The start vector object of this line pen.
         */
        public var start:Vector2 = new Vector2() ; 

        /**
         * Draws the shape.
         * @param end (optional) The end vector value (flash.geom.Point or pegas.geom.Vector2)
         * @param start (optional) The start vector value (flash.geom.Point or pegas.geom.Vector2)
         */
        public override function draw( ...args:Array):void 
        {
            if ( args.length > 0 ) 
            {
                setPen.apply( this , args ) ;
            }
            super.draw() ;
        }
            
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
        	if ( start.equals(end) == false )
        	{
                graphics.moveTo( start.x, start.y ) ;
                graphics.lineTo( end.x, end.y ) ;
        	}
        }

        /**
         * Returns the Line reference of this pen.
         * @return the Line reference of this pen.
         */
        public function getLine():Line 
        {
            return LineUtil.getLine( start , end ) ;    
        }

        /**
         * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
         * @param end (optional) The end vector value (flash.geom.Point or pegas.geom.Vector2)
         * @param start (optional) The start vector value (flash.geom.Point or pegas.geom.Vector2)
         */
        public function setPen( ...args:Array  ):void 
        {
            if ( args[0] != null && ( args[0] is Vector2 || args[0] is Point ) )
            {
                end.x = args[0].x ;
                end.y = args[0].y ;
            }
            if ( args[1] != null && ( args[1] is Vector2 || args[1] is Point ) )
            {
                start.x = args[1].x ;
                start.y = args[1].y ;
            }
        }    
        
    }
}

