/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.container 
{
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    
    import lunas.display.container.ListContainer;
    
    import pegas.draw.Direction;    

    /**
     * This container use a matrix layout pattern.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * import flash.filters.* ;
     * 
     * import lunas.core.Direction;
     * import lunas.display.container.MatrixContainer ;
     * 
     * import pegas.colors.Color ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var container:MatrixContainer = new MatrixContainer() ;
     * container.x = 25 ;
     * container.y = 25 ;
     * container.space = 10 ;
     * 
     * container.columns = 10 ;
     * container.lines   = 10 ;
     * container.direction = Direction.HORIZONTAL ;
     * 
     * addChild( container ) ;
     * 
     * var createNewSquare:Function = function()
     * {
     *     var shadow:DropShadowFilter = new DropShadowFilter( 2, 90, 0x000000, 0.7, 10, 10, 1, 2) ;
     *     var s:Square = container.addChild( new Square() )  ;
     *     var c:Color  = new Color( s.background ) ;
     *     c.rgb = Math.random() * 0xFFFFFF ;
     *     s.filters = [ shadow ] ;
     * }
     * 
     * for (var i:uint = 0 ; i<12 ; i++ )
     * {
     *     createNewSquare() ;
     * }
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.UP :
     *         {
     *             container.clear() ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *              container.direction = container.direction == Direction.HORIZONTAL ? Direction.VERTICAL : Direction.HORIZONTAL ;
     *              break ;
     *         }
     *         default :
     *         {
     *             createNewSquare() ;
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     * @author eKameleon
     */
    public class MatrixContainer extends ListContainer 
    {

        /**
         * Creates a new MatrixContainer instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function MatrixContainer(id:* = null, isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name );
        }
        
        /**
         * Determinates the autosize policy of this container.
         */
        public function get autoSize():Boolean 
        {
            return _autoSize ;
        }
                
        /**
         * @private
         */
        public function set autoSize( b:Boolean ):void 
        {
            _autoSize = b ;
            doLater() ;
        }
        
        /**
         * Determinates the number of columns in the matrix layout if the direction of this container is Direction.HORIZONTAL.
         * @see asgard.display.Direction
         */
        public function get columns():int 
        {
            return _columns ;
        }        
        
        /**
         * @private
         */
        public function set columns(n:int):void 
        {
            _columns = (n>1) ? n : 1 ;
            update() ;
        }

        /**
         * Determinates the number of lines in the matrix layout if the direction of this container is Direction.VERTICAL.
         * @see asgard.display.Direction
         */
        public function get lines():int 
        {
            return _lines ;
        }    

        /**
         * @private
         */
        public function set lines(n:int):void 
        {
            _lines = (n>1) ? n : 1 ;
            update() ;
        }
        
        /**
         * Refreshs the childs position in the container.
         */
        public override function changeChildsPosition():void 
        {
            if ( (_columns > 1 && direction == Direction.HORIZONTAL) || (_lines>1 && direction == Direction.VERTICAL) ) 
            {
                var d:DisplayObject ;
                var c:Number ;
                var l:Number ;
                var s:Number = isNaN(space) ? 0 : space ;
                var n:int    = numChildren ;
                var isHorizontal:Boolean = direction == Direction.HORIZONTAL ;
                for (var i:uint = 0 ; i<n ; i++) 
                {
                    c = isHorizontal ? (i%_columns) : Math.floor(i/_lines) ;
                    l = isHorizontal ? Math.floor(i/_columns) : (i%_lines) ;
                    d = getChildAt(i) ;
                    d.x = c * (d.width + s) ; 
                    d.y = l * (d.height + s) ;
                }
            } 
            else 
            {
                super.changeChildsPosition() ;
            }
        }
        
        /**
         * Resize the container.
         */
        public override function resize():void 
        {
            _bound.setEmpty() ;
            if ( ( _lines > 1 && direction == Direction.VERTICAL) || ( _columns > 1 && direction == Direction.HORIZONTAL ) ) 
            {
                if ( autoSize ) 
                {
                    var b:Rectangle = _container.getBounds(this);
                    _bound.x      = b.x ;
                    _bound.y      = b.y ;
                    _bound.width  = b.width ;  
                    _bound.height = b.height ;
                }
                else
                {
                    _bound.width  = w ;
                    _bound.height = h ;
                }
            } 
            else 
            {
                super.resize() ;
            }
        }
        
        /**
         * @private
         */
        private var _autoSize:Boolean = true ;

        /**
         * @private
         */
        private var _lines:int = 3 ;

        /**
         * @private
         */
        private var _columns:int = 3 ; 
        
    }
}

