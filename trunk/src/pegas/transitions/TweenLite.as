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
	import pegas.transitions.Motion;	

	/**
	 * The TweenLite class lets you use ActionScript to move, resize, and fade movie clips easily on the Stage by specifying a property of the target movie clip to be tween animated over a number of frames or seconds.
	 * The TweenLite class also lets you specify a variety of easing methods.
	 * <p>Easing refers to gradual acceleration or deceleration during an animation, which helps your animations appear more realistic.</p>
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import pegas.process.ActionEvent ;
	 * import pegas.transitions.TweenLite ;
	 * import pegas.transitions.easing.Back ;
	 * 
	 * var debug:Function = function( ev:ActionEvent ):void
	 * {
	 *     trace (":: debug -> " + ev.type + " : " + ev.target ) ;
	 * }
	 * 
	 * var tw:TweenLite = new TweenLite (mc, "x", Back.easeOut, mc.x, 400, 2, true, true) ;
	 * tw.looping = true ;
	 * tw.addEventListener( ActionEvent.START    , debug ) ;
	 * tw.addEventListener( ActionEvent.PROGRESS , debug ) ;
	 * tw.addEventListener( ActionEvent.FINISH   , debug ) ;
	 * tw.addEventListener( ActionEvent.LOOP     , debug ) ;
	 * </pre>
 	 * @author eKameleon
	 */
	public class TweenLite extends Motion 
	{

		/**
		 * Creates a new Motion instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function TweenLite( obj:*=null , prop:String=null , easing:Function=null , begin:Number=NaN  , finish:Number=NaN , duration:Number=0 , useSeconds:Boolean=false , auto:Boolean=false , bGlobal:Boolean = false, sChannel:String = null )
		{
			super( bGlobal, sChannel );
			this.target     = obj        ;
			this.duration   = duration   ;
			this.useSeconds = useSeconds ;
			this.setTweenEntry( prop , easing, begin, finish ) ;
			if ( auto == true ) 
			{
				run() ;
			}
		}
		
		/**
		 * (read-write) The TweenEntry reference of this tween.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import pegas.transitions.TweenEntry ;
		 * import pegas.transitions.TweenLite ;
		 * import pegas.transitions.easing.Bounce ;
		 * 
		 * var tw:TweenLite = new TweenLite( mc ) ;
		 * tw.duration   = 1 ;
		 * tw.useSeconds = true ;
		 * 
		 * tw.tweenEntry = new TweenEntry( "x" , Bounce.easeOut, mc.x , 500 ) ;
		 * tw.start() ;
		 * </pre>
		 */
		public function get tweenEntry():TweenEntry 
		{
			return _entry ;
		}
		
		/**
		 * @private
		 */
		public function set tweenEntry( entry:TweenEntry ):void 
		{
			_entry = entry || new TweenEntry() ;
		}

		/**
		 * Returns a shallow copy of this Tween object.
		 * @return a shallow copy of this Tween object.
		 */
		public override function clone():* 
		{
			var t:TweenLite = new TweenLite(target) ;
			t.duration   = duration   ;
			t.useSeconds = useSeconds ;
			t.tweenEntry = tweenEntry.clone() ;
			return t ;
		}
	
		/**
		 * Instructs the tweened animation to continue tweening from its current animation point to a new finish and duration point.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import pegas.events.ActionEvent ;
		 * import pegas.transitions.TweenLite ;
		 * import pegas.transitions.easing.Bounce ;
		 * 
		 * var continueTo:Function = function( e:ActionEvent ):void
		 * {
		 *     tw.removeEventListener( ActionEvent.FINISH , continueTo ) ;
		 *     var target:TweenLite = e.target as TweenLite ;
		 *     trace(e + " continueTo(100,2)" ) ;
		 *     target.continueTo( 100 , 3 ) ;
		 * }
		 * 
		 * var tw:TweenLite = new TweenLite( mc, "x", Bounce.easeOut, mc.x, 550, 1, true ) ;
		 * tw.addEventListener( ActionEvent.FINISH , continueTo ) ;
		 * tw.run() ;
		 * </pre>
		 * @param finish A number indicating the ending value of the target object property that is to be tweened.
	 	 * @param duration A number indicating the length of time or number of frames for the tween motion.
	 	 * @param noRestart This optional flag is used to fix the restart process of the tween.
	 	 */
		public function continueTo(finish:Number, duration:Number=NaN, noRestart:Boolean=false ):void 
		{
			_entry.begin  = target[_entry.prop] ;
			_entry.finish = finish ;
			if ( !isNaN(duration) )
			{
				this.duration = duration;
			}
			if ( noRestart == true  )
			{
				return ;
			}
			if ( running == false )
			{
				this.run();
			}
		}

		/**
		 * Set the TweenEntry property of this TweenLite object.
		 * @param prop the property name of the object to change.
	 	 * @param easing the easing function of the tween entry.
	 	 * @param begin the begin value.
	 	 * @param finish the finish value. 
	 	 */
		public function setTweenEntry( prop:String, easing:Function , begin:Number , finish:Number ):void
		{
			if ( _entry == null )
			{
				_entry = new TweenEntry() ;
			}
			_entry.prop   = prop   ;
			_entry.easing = easing ; 	
			_entry.begin  = begin  ;
			_entry.finish = finish ;
		}
		
		/**
	 	 * Update the current Tween in the time.
		 */
		public override function update():void 
		{
			target[ _entry.prop ] = _entry.setPosition( _entry.getPosition( _time, _duration ) ) ;
			notifyChanged() ;
		}
		
		/**
		 * Instructs the tweened animation to play in reverse from its last direction of tweened property increments. 
	 	 * If this method is called before a Tween object's animation is complete, the animation abruptly jumps to the end of its play and then plays in a reverse direction from that point.
	 	 * <p><b>Example :</b></p>
	 	 * <pre class="prettyprint">
	 	 * import pegas.events.ActionEvent ;
	 	 * import pegas.transitions.TweenLite ;
	 	 * import pegas.transitions.easing.Bounce ;
	 	 * 
	 	 * var yoyo:Function = function( e:ActionEvent ):void
	 	 * {
	 	 *     var target:TweenLite = e.target as TweenLite ;
	 	 *     trace(e + " yoyo()" ) ;
	 	 *     target.yoyo() ;
	 	 * }
	 	 * 
	 	 * var tw:TweenLite = new TweenLite( mc, "x", Bounce.easeOut, mc.x, 550, 2, true ) ;
	 	 * tw.addEventListener( ActionEvent.FINISH , yoyo ) ;
	 	 * tw.run() ;
	 	 * </pre>
	 	 */
		public function yoyo():void 
		{
			continueTo( _entry.begin, time );
		}
		
		/**
		 * @private
		 */
		private var _entry:TweenEntry ;
		
	}
	
}
