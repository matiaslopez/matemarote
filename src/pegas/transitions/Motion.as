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

package pegas.transitions 
{
    import flash.events.IEventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    
    import andromeda.process.Action;
    import andromeda.process.IStoppable;    

    /**
	 * The Motion class.
	 * @author eKameleon
 	 */
	public class Motion extends Action implements IStoppable
	{

		/**
		 * Creates a new Motion instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function Motion(bGlobal:Boolean = false, sChannel:String = null)
		{
			super( bGlobal, sChannel ) ;
		}
		
		/**
		 * Returns the duration of the tweened animation in frames or seconds.
		 * @return the duration of the tweened animation in frames or seconds.
	 	 */
		public function get duration():Number 
		{
			return _duration ;
		}
			
		/**
		 * Sets the duration of the tweened animation in frames or seconds.
		 */
		public function set duration( n:Number ):void 
		{
			_duration = (isNaN(n) || n <= 0 ) ? Infinity : n ;
		}
		
		/**
		 * Returns the number of frames per second of the tweened animation.
		 * @return the number of frames per second of the tweened animation.
		 */
		public function get fps():Number 
		{
			return _fps;
		}	
		
		/**
		 * Sets the number of frames per second of the tweened animation.
		 */
		public function set fps( n:Number ):void 
		{
			var tmp:Boolean = running ;
			_timer.stop() ;
			_fps = n ;
			if (tmp) 
			{
				_timer.start() ;
			}
		}

		/**
		 * Defined the internal prevTime value.
		 */
		public var prevTime:Number ;
		
		/**
		 * Indicates the target reference of the object contrains by the Motion effect.
		 */
		public var target:* ;

		/**
		 * (read-only) Returns the current time within the duration of the animation.
		 */
		public function get time():Number 
		{ 
			return _time ;
		}
		
		/**
		 * Defined if the Motion used seconds or not.
		 */
		public var useSeconds:Boolean ;

		/**
		 * Returns a shallow copy of this object.
		 * @return a shallow copy of this object.
		 */
		public override function clone():* 
		{
			return new Motion() ;
		}
		
		/**
		 * Forwards the tweened animation to the next frame.
		 */
		public function nextFrame( e:TimerEvent ):void 
		{ 
			setTime( (useSeconds) ? ( ( getTimer() - _startTime ) / 1000 ) : ( _time + 1 ) ) ;
		}

		/**
		 * Directs the tweened animation to the frame previous to the current frame.
		 */
		public function prevFrame():void 
		{
			if (!useSeconds) 
			{
				setTime (_time - 1)  ;
			}
		}
	
		/**
		 * Resumes a tweened animation from its stopped point in the animation.
	 	 */
		public function resume():Boolean 
		{
			if ( _stopping == true && _time != duration) 
			{
				fixTime() ;
				startInterval() ;
				notifyResumed() ;
				return true ;
			}
			else 
			{
				return false ;
			}
		}
	
		/**
		 * Rewinds a tweened animation to the beginning of the tweened animation.
		 */
		public function rewind( t:Number=0 ):void 
		{
			_time = t > 0 ? t : 0 ;
			fixTime() ;
			update() ;
		}
			
		/**
	 	 * Runs the object.
		 */
		public override function run( ...arguments:Array ):void 
		{
			notifyStarted() ;
			rewind() ;
			startInterval() ;
		}

		/**
	 	 * Sets the current time within the duration of the animation.
		 */
		public function setTime(t:Number):void 
		{
			prevTime = _time ;
			if (t > _duration) 
			{
				t = _duration ;
				if (looping) 
				{
					rewind (t - _duration);
					update();
					notifyLooped() ;
				}
				else 
				{
					if (useSeconds) 
					{
						_time = _duration ;
						update() ;
					}
					this.stop() ;
					notifyFinished() ;
				}
			} 
			else if (t<0) 
			{
				rewind() ;
				update() ;
			}
			else 
			{
				_time = t ;
				update() ;
			}
		}
		
		/**
	 	 * Sets the internal timer of the tweened animation.
	 	 */
		public function setTimer( timer:ITimer ):void 
		{
			if (_timer) 
			{
				_timer.stop();
				IEventDispatcher(_timer).removeEventListener(TimerEvent.TIMER, nextFrame) ;
				_timer = null ;
			}
			_timer = timer ;
			IEventDispatcher(_timer).addEventListener(TimerEvent.TIMER, nextFrame ) ;
		}

		/**
		 * Starts the tweened animation from the beginning.
		 */
		public function start():void 
		{
			_stopping = false ; 
			run() ;
		}
	
		/**
		 * Starts the intenral interval of the tweened animation.
		 */
		public function startInterval():void 
		{
			if (_fps) 
			{
				setTimer(new Timer(1000 / _fps)) ;
			}
			else 
			{
				setTimer(new FrameTimer()) ;
			}
			_timer.start() ; 
			setRunning(true) ;
		}
	
		/**
		 * Stops the tweened animation at its current position.
		 */
		public function stop( ...args:Array ):*
		{
            stopInterval() ;
            _stopping = true ;
			notifyStopped() ;
			return true ;
		}
		
		/**
		 * Stops the intenral interval of the tweened animation.
		 */
		public function stopInterval():void 
		{
			_timer.stop() ;
			setRunning( false ) ;
		}
	
		/**
	 	 * Update the current object.
	 	 */
		public function update():void 
		{
			//
		}
	
	    /**
         * @private
         */
		protected var _duration:Number ;
		
		/**
         * @private
         */
		protected var _time:Number ;
		
		/**
		 * @private
		 */
		private   var _fps:Number ;
		
		/**
         * @private
         */
		private   var _startTime:Number ;
		
		/**
         * @private
         */
		private   var _stopping:Boolean ;
		
		/**
         * @private
         */
		private   var _timer:ITimer ;
	
		/**
		 * @protected
		 */
		protected function fixTime():void 
		{
			if ( useSeconds)
			{
				_startTime = getTimer() - _time * 1000 ;
			}
		}

	}
}
