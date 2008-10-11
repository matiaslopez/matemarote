/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.display 
{
    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    
    import vegas.core.CoreObject;
    import vegas.errors.NullPointerError;    

    /**
	 * The TimeLineScript class use composition to register script function over MovieClip timelines.
     * @example
     * <pre class="prettyprint">
     * import asgard.display.TimelineScript ;
     * 
     * var ts:TimelineScript = new TimelineScript( mc , true ) ; // mc a MovieClip in the stage
     * 
     * var start:Function = function()
     * {
     *     trace("start") ;
     * }
     * 
     * var pause:Function = function()
     * {
     *     trace("pause") ;
     *     mc.stop() ;
     *     setTimeout( mc.play , 4000 ) ; // pause 4 s
     * }
     * 
     * var finish:Function = function()
     * {
     *     trace("finish") ;
     *     mc.stop() ;
     * }
     * 
     * ts.put( "begin"   , start ) ;
     * ts.put( "middle"  , pause ) ;
     * ts.put( "finish"  , finish ) ;
     * 
     * var click:Function = function( e:MouseEvent ):void
     * {
     *     mc.play() ;
     *     trace("click") ;
     *     e.target.removeEventListener( MouseEvent.CLICK , click ) ;
     *     mc.buttonMode = false ;
     * }
     * 
     * mc.useHandCursor = true ;
     * mc.buttonMode    = true ;
     * mc.addEventListener( MouseEvent.CLICK , click ) ;
     * </pre>
     * @author eKameleon
     */
    public class TimelineScript extends CoreObject 
    {
        
        /**
         * Creates a new TimelineScript instance.
         * @param target The MovieClip reference of this iterator.
         * @param autoStop This boolean flag indicates if the specified MovieClip target reference is stopped.
         */
        public function TimelineScript( target:MovieClip , autoStop:Boolean=false )
        {
            super();
            if (target == null)
            {
                throw new ArgumentError( this + " can't be instanciate with an empty MovieClip reference in argument of the constructor.") ;    
            }
            this._target = target ;
            if (autoStop)
            {
                this._target.stop() ;    
            }
        }
        
        /**
         * (read-only) Indicates the target reference of this iterator.
         */
        public function get target():MovieClip
        {
            return _target ;    
        }
        
        /**
         * Registers a script function in the frame specified by the label or index value passed-in the first argument of the method.
         * @param index A String label name or a uint frame index value.
         * @param script The Function instruction to register.
         * @return true if the register is success.
         */
        public function put( index:* , script:Function ):Boolean
        {
            try
            {
                var num:uint ;
                if ( index is uint )
                {
                    num = index as uint ;
                }
                else if ( index is String )
                {
                    num = resolve( index as String ) ;
                }
                _target.addFrameScript( num , script ) ;
                return true ;
            }
            catch(e:Error)
            {
                getLogger().error( this + " put failed : " + e.toString() ) ;
                return false ;    
            }
            return false ;
        }
        
        /**
         * Unregisters a script function in the frame specified by the label or index value passed-in argument of the method.
         * @param index A String label name or a uint frame index value.
         */
        public function remove( index:* ):void
        {
            var num:int ;
            if ( index is int )
            {
                num = index as int ;
            }
            else if ( index is String )
            {
                num = resolve( index as String ) ;
            }
            _target.addFrameScript( num , null ) ;
        }        
        
        /**
         * The MovieClip target of this iterator.
         */
        private var _target:MovieClip ;
        
        /**
         * Indicates if the specified passed-in label value is in the MovieClip target.
         */
        protected function resolve( label:String=null ):int 
        {
            if ( label == null || label.length == 0 )
            {
                throw new ArgumentError( this + " resolve label failed with a 'null' or 'undefined' label argument.") ;
            }
            var frame:uint ;
            var currentLabels:Array = _target.currentLabels ;
            for each( var element:FrameLabel in currentLabels )
            {
                if (element.name == label )
                {
                    frame = element.frame - 1 ;
                    return frame > 1 ? frame : 1 ;    
                }
            } ;
            throw new NullPointerError( this + " resolve the label '" + label + "' failed, the specified label don't exist in the internal MovieClip reference." ) ;
        }        
        
    }
}
