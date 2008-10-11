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
    import flash.display.MovieClip;
    
    import system.numeric.Mathematics;
    
    import vegas.core.CoreObject;
    import vegas.data.iterator.OrderedIterator;
    import vegas.errors.UnsupportedOperation;    

    /**
     * This iterator control the timeline in a MovieClip target.
     * @example With <b>container</b> a MovieClip reference added in the stage of the application, this MovieClip contains 10 frames</p>
     * <pre class="prettyprint">
     * import asgard.display.TimelineIterator ;
     * 
     * var it:TimelineIterator = new TimelineIterator( container , 2 ) ;
     * 
     * trace( "timeline current frame : " + it.currentFrame ) ;
     * trace( "timeline total frames  : " + it.totalFrames ) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch(code)
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             if ( it.hasPrevious() )
     *             {
     *                 it.previous() ;
     *             }
     *             else
     *             {
     *                 it.last() ;
     *             }
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             if ( it.hasNext() )
     *             {
     *                 it.next() ;
     *             }
     *             else
     *             {
     *                 it.reset() ;
     *             }
     *             break ;
     *         }
     *     }
     *     trace( "timeline : " + it.currentFrame + " | " + it.totalFrames + " | frame label : " + it.currentLabel ) ;
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     * @author eKameleon
     */
    public class TimelineIterator extends CoreObject implements OrderedIterator  
    {

        /**
         * Creates a new TimelineIterator instance.
         * @param target The MovieClip reference of this iterator.
         * @param framePosition the default framePosition of the specified MovieClip target (default frame 1).
         * @param stepSize (optional) the step between two frames returns by the iterator (default 1).
         * @throws ArgumentError if the <code class="prettyprint">target</code> argument of this constructor is empty.
         */
        public function TimelineIterator( target:MovieClip , framePosition:Number=NaN, stepSize:uint=1 )
        {
            super();
        
            if (target == null)
            {
                throw new ArgumentError( this + " can't be instanciate with an empty MovieClip reference in the first argument of the constructor.") ;    
            }
            
            this._target = target ;
            this._step = (DEFAULT_STEP > 1) ? stepSize : DEFAULT_STEP ; 

            if ( !isNaN(framePosition) )
            {
                this.seek(framePosition) ;    
            }
            
        }
    
        /**
         * The default step value in all the PageByPageIterators.
         */
        public static const DEFAULT_STEP:Number = 1 ;

        /**
         * (read-only) The current label in which the playhead is located in the timeline of the MovieClip instance.
         */
        public function get currentLabel():String
        {
            return _target.currentLabel ;    
        }

        /**
         * (read-only) The current frame of the iterator.
         */
        public function get currentFrame():int
        {
            return _target.currentFrame ;    
        }

        /**
         * (read-only) Returns the target reference of this iterator.
         */
        public function get target():MovieClip
        {
            return _target ;    
        }

        /**
          * (read-only) The current frame of the iterator.
         */
        public function get totalFrames():Number
        {
            return _target.totalFrames ;    
        }
    
        /**
         * Returns the step size of this PageByPageIterator.
         * @return the step size of this PageByPageIterator.
          */
        public function getStepSize():Number
        {
            return _step ;    
        }

        /**
         * Checks to see if there is a previous element that can be iterated to.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasPrevious() : Boolean 
        {
            return _target.currentFrame > 1 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasNext() : Boolean 
        {
            return _target.currentFrame < _target.totalFrames ;
        }

        /**
         * Returns the current page number.
         * @return the current page number.
         */
        public function key():*
        {
            return _target.currentFrame ;
        }
        
        /**
         * Seek the key pointer of the iterator over the last frame of the timeline.
         */
        public function last():void 
        {
            _target.gotoAndStop(_target.totalFrames) ;
        }
        
        /**
         * Returns the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         * @return the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         */
        public function next():* 
        {
            var k:uint = _target.currentFrame ;
            k += _step ;
            k = (k < _target.totalFrames) ? k : _target.totalFrames ;
            _target.gotoAndStop(k) ;
            return k ;
        }
        
        /**
          * Returns the previous Array page of elements or the previous element in the Array if the getStepSize() value is 1.
         * @return the previous element from the collection.
         */
        public function previous():*
        {
            var k:uint = _target.currentFrame ;
            k -= _step ;
            k = (k > 1) ? k : 1 ;
            _target.gotoAndStop(k) ;
            return k ;
        }
        
        /**
         * Unsupported operation in this iterator.
         * @throws UnsupportedOperation the method remove() in this iterator is unsupported. 
         */
        public function remove():*
        {
            throw new UnsupportedOperation(this + " remove method is unsupported by this instance.") ;
        }

        /**
         * Resets the key pointer of the iterator.
         */
        public function reset():void 
        {
            _target.gotoAndStop(1) ;
        }

        /**
         * Seek the key pointer of the iterator.
         */
        public function seek( position:* ):void 
        {
            _target.gotoAndStop(Mathematics.clamp( position, 1, _target.totalFrames )) ;
        }
    
        /**
         * The numbers of frame to step with the iterator.
         */
        private var _step:uint ;
    
        /**
         * The MovieClip target of this iterator.
         */
        private var _target:MovieClip ;

    }

}