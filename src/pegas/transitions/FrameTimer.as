
package pegas.transitions 
{
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    
    import andromeda.process.SimpleAction;    

    /**
	 * Constructs a <code class="prettyprint">new FrameTimer</code> object with the specified delay and repeat state. 
	 * This timer use the frames by second of the animation. 
	 * The timer does not start automatically, you much call the <code class="prettyprint">start()</code> method to start it.
	 * @author eKameleon
	 */
	public class FrameTimer extends SimpleAction implements ITimer 
	{

		/**
		 * Creates a new FrameTimer instance.
		 * The timer does not start automatically; you must call the start() method to start it.
    	 * @param delay The delay between timer events, in milliseconds.
    	 * @param repeatCount Specifies the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops. 
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function FrameTimer(delay:Number = 0, repeatCount:int = 0, bGlobal:Boolean = false, sChannel:String = null)
		{
			
			super( bGlobal , sChannel ) ;
			
			_engine = new FrameEngine() ;
			_engine.addEventListener( Event.ENTER_FRAME , enterFrame ) ;

			this.delay       = delay ;
			this.repeatCount = repeatCount ; 			

		}

		/**
		 * The total number of times the timer has fired since it started at zero.
		 */
		public function get currentCount():int 
		{
			return _count ;	
		}
		
		/**
		 * The delay, in milliseconds, between timer events.
		 * @throws Error Throws an exception if the delay specified is negative or not a finite number. 
		 */
		public function get delay():Number 
		{
			return _delay ;
		}
		
		/**
		 * @private
		 */
		public function set delay( time:Number ):void 
		{
			if ( time < 0 || !isFinite(time) )
			{
				throw new Error( this + " the delay specified is negative or not a finite number." ) ;
			} ;
			_delay = (time > 0) ? time : 0 ;
		}
		
		/**
		 * The total number of times the timer is set to run. 
		 * If the repeat count is set to 0, the timer continues forever or until the stop() method is invoked or the program stops. 
		 */
		public function get repeatCount():int
		{
			return _repeatCount ;	
		}		

		/**
		 * @private
		 */
		public function set repeatCount( count:int ):void
		{
			_repeatCount = count ;
		}

        /**
         * (read-only) Indicates <code class="prettyprint">true</code> if the process is in progress.
         */
        public override function get running():Boolean 
        {
            return _engine.running ;    
        }
        		
		/**
		 * Stops the timer, if it is running, and sets the currentCount property back to 0, like the reset button of a stopwatch.
		 */
		public function reset():void
		{
			if ( _engine.running )
			{
				this.stop() ;
			}
			_count = 0 ;
		}
	
		/**
		 * Run the timer.
	 	 */
		public override function run( ...arguments:Array ):void 
		{
			start() ;
		}
        		
		/**
		 * Starts the timer, if it is not already running.
		 */
		public function start():void
		{
			_engine.start() ;
		}
		
		/**
		 * Stops the timer.
		 */
		public function stop():void
		{
			_engine.stop() ;
		}

		/**
		 * The internal counter of the timer.
		 */
		protected var _count:int ;
		
		/**
		 * The internal delay of the timer.
		 */
		protected var _delay:Number ;
		
		/**
		 * The internal FrameEngine reference of this timer.
		 */
		private var _engine:FrameEngine ;

		/**
		 * The internal 
		 */
		protected var _lastTime:uint ;

		/**
		 * The next value.
		 */
		protected var _next:Number = 0 ;

		/**
		 * The internal repeat counter of the timer.
		 */
		protected var _repeatCount:int ;
		
		/**
		 * Invoked when the frame engine is in progress.
		 */		
		protected function enterFrame( e:Event ):void
		{
			_next     += getTimer() - _lastTime ;
			_lastTime  = getTimer() ;
			if ( _next >= _delay ) 
			{
				_count ++ ;
				dispatchEvent( new TimerEvent( TimerEvent.TIMER ) ) ;
				_next = 0 ;
			}
			if ( _repeatCount != 0 && _count >= _repeatCount ) 
			{
				dispatchEvent( new TimerEvent( TimerEvent.TIMER_COMPLETE ) ) ;
				this.reset() ;
			}
		}
		
	}
}
