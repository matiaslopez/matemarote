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
    import pegas.draw.LinePen;
    import pegas.geom.Line;
    import pegas.geom.Vector2;
    import pegas.util.LineUtil;
    import pegas.util.Vector2Util;
    
    import system.Reflection;    

    /**
     * This pen is the basic tool to draw an arrow shape.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.CapsStyle ;
     * import flash.display.JointStyle ;
     * import flash.display.LineScaleMode ;
     * import flash.display.Sprite ;
     * 
     * import pegas.draw.ArrowPen ;
     * import pegas.draw.FillStyle ;
     * import pegas.draw.LineStyle ;
     * 
     * import pegas.geom.Vector2 ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.align = "" ;
     * 
     * var shape:Sprite = new Sprite() ;
     * 
     * var start : Vector2  = new Vector2( 740 / 2, 420 / 2) ;
     * var end   : Vector2  = new Vector2( start.x + 100, start.y + 100) ;
     * 
     * var pen:ArrowPen = new ArrowPen( shape , start , end ) ;
     * 
     * pen.fill = new FillStyle( 0xFAFA74 ) ;
     * pen.line = new LineStyle( 2, 0xFAFA74 , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
     * 
     * pen.setPen( null, null, { headSize:20 , headWidth:8 } ) ; // initialize
     * 
     * pen.draw() ;
     * 
     * addChild( shape ) ;
     * 
     * var refresh:Function = function( e:MouseEvent )
     * {
     *     pen.end.x = e.localX ;
     *     pen.end.y = e.localY ;
     *     pen.draw() ;
     * }
     * 
     * stage.addEventListener( MouseEvent.MOUSE_MOVE , refresh ) ;
     * </pre>
     */
    public class ArrowPen extends LinePen 
    {

        /**
         * Creates a new ArrowPen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param start The default start Vector object.
         * @param end The default end Vector object.
         * @param init This optional object is used to initialize all properties of the pen.
         */
        public function ArrowPen(graphic:*, start:* = null, end:* = null , init:Object = null )
        {
            super( graphic, start, end ) ;
            if ( init != null )
            {
                for (var prop:String in init)
                {
                    this[prop] = init[prop] ;	
                }	
            }
        }
        
        /**
         * The edge control position.
         */
        public var edgeControlPosition:Number = .5 ;
        
        /**
         * The edge control size.
         */
        public var edgeControlSize:Number = .5 ;        
        
        /**
         * Indicates the relative width of arrow head.
         */
        public var headSize:Number = 10 ;
        
        /**
         * Indicates the pixel Length of arrow head.
         */
        public var headWidth:Number = -1 ;        
                
        /**
         * The shaft position value.
         */
        public var shaftPosition:Number = 0 ;
        
        /**
         * The shaft thickness value.
         */
        public var shaftThickness:Number = 0.5 ;      
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            
            if ( start.equals(end) == false )
            {
                
                graphics.moveTo( start.x, start.y ) ;
                graphics.lineTo( end.x, end.y ) ;
                
                var full:Vector2 = Vector2Util.getSubstraction(end, start) ;
                
                var halfWidth:Number = (headWidth > -1) ? ( headWidth / 2 ) : ( headSize / 2 ) ;
                
                // phase 1

                var sNorm:Vector2 = new Vector2(full.y , -full.x ) ;
                
                Vector2Util.normalize( sNorm, shaftThickness / 2 ) ;
                
                var s1:Vector2 = Vector2Util.getAddition(start , sNorm) ;
                var s2:Vector2 = Vector2Util.getSubstraction( start , sNorm ) ;
                
                var e1:Vector2 = Vector2Util.getAddition(end , sNorm) ;
                var e2:Vector2 = Vector2Util.getSubstraction( end , sNorm ) ;
                
                // phase 2
                
                var head:Vector2 = full.clone();
                
                Vector2Util.normalize( head ,  Vector2Util.getLength( head ) - headSize ) ;
                
                Vector2Util.addition( head , start ) ;
                
                // phase 3
                
                var headNorm:Vector2 = sNorm.clone();
                
                Vector2Util.normalize( headNorm, halfWidth ) ;
                
                var edge1:Vector2 = Vector2Util.getAddition( head , headNorm ) ;
                var edge2:Vector2 = Vector2Util.getSubstraction( head , headNorm ) ;
                
                // phase 4
                
                var l1:Line ;
                var l2:Line ;
                
                var inter1:Vector2 ;
                var inter2:Vector2 ;
                
                var shaftCenter:Vector2 = Vector2Util.interpolate( end ,head , shaftPosition ) ;
                
                l1     = LineUtil.getLine( s1 , e1) ;
                l2     = LineUtil.getLine( shaftCenter , edge1 ) ;
                inter1 = LineUtil.getLineCross( l1 , l2 ) ;
                
                l1     = LineUtil.getLine( s2 , e2) ;
                l2     = LineUtil.getLine( shaftCenter , edge2) ;
                inter2 = LineUtil.getLineCross( l1 , l2 ) ;      
                
                // phase 5
                
                var edgeCenter:Vector2 = Vector2Util.interpolate( end ,head , edgeControlPosition ) ;                
                
                var edgeNorm:Vector2   = sNorm.clone();
                
                Vector2Util.normalize( edgeNorm , halfWidth * edgeControlSize ) ;                
                
                var edgeCtrl1:Vector2 = Vector2Util.getAddition( edgeCenter , edgeNorm ) ;
                var edgeCtrl2:Vector2 = Vector2Util.getSubstraction( edgeCenter , edgeNorm ) ;                
                
                // phase 6 : draw
                
                graphics.moveTo  ( s1.x        , s1.y     ) ;
                graphics.lineTo  ( inter1.x    , inter1.y ) ;
                graphics.lineTo  ( edge1.x     , edge1.y  ) ;
                
                graphics.curveTo ( edgeCtrl1.x , edgeCtrl1.y , end.x   , end.y   ) ;
                graphics.curveTo ( edgeCtrl2.x , edgeCtrl2.y , edge2.x , edge2.y ) ;
                
                graphics.lineTo  ( inter2.x    , inter2.y ) ;
                graphics.lineTo  ( s2.x        , s2.y     ) ;
                graphics.lineTo  ( s1.x        , s1.y     ) ;                
                
            }
        }
        
        /**
         * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
         * @param end (optional) The end vector value (flash.geom.Point or pegas.geom.Vector2)
         * @param start (optional) The start vector value (flash.geom.Point or pegas.geom.Vector2)
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen.call( this, args[0] , args[1] ) ;
            if ( args[2] != null && Reflection.getClassInfo(args[2]).isDynamic() )
            {
            	var init:Object = args[2] as Object ;
            	for (var prop:String in init )
            	{
            	   this[prop] = init[prop] ;	
            	}
            }
        } 
         
    }
}

