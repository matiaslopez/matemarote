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
package asgard.media 
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.media.ID3Info;
    import flash.media.Sound;
    import flash.media.SoundLoaderContext;
    
    import andromeda.process.CoreActionLoader;
    
    import asgard.media.CoreSound;    

    /**
	 * This action process is an helper who launch the load of a CoreSound object.
	 * @example
	 * <pre class="prettyprint">
	 * import andromeda.events.ActionEvent ;
	 * 
	 * import asgard.media.CoreSound ;
	 * import asgard.media.SoundLoader ;
	 * 
	 * import flash.net.URLRequest ;
	 * 
	 * var start:Function = function( e:Event ):void
	 * {
	 *     trace(e) ;
	 * }
	 * 
	 * var progress:Function = function( e:Event ):void
	 * {
	 *     var target:SoundLoader = e.target as SoundLoader ;
	 *     trace( target.bytesLoaded + " : " + target.bytesTotal) ;
	 * }
	 * 
	 * var finish:Function = function( e:Event ):void
	 * {
	 *     trace(e) ;
	 *     sound.play() ;
	 * }
	 * 
	 * var url:String = "mp3/test.mp3" ;
	 * var sound:CoreSound = new CoreSound() ;
	 * 
	 * var process:SoundLoader = new SoundLoader( sound ) ;
	 * 
	 * process.addEventListener(ActionEvent.START     , start ) ;
	 * process.addEventListener(ActionEvent.PROGRESS  , progress ) ;
	 * process.addEventListener(ActionEvent.FINISH    , finish ) ;
	 * 
	 * process.request = new URLRequest( url ) ;
	 * 
	 * process.run() ;
	 * </pre>
	 * @author eKameleon
	 */
	public class SoundLoader extends CoreActionLoader 
	{

		/**
		 * Creates a new ActionSoundLoader instance.
		 * @param sound The Sound object to load.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function SoundLoader( sound:CoreSound, bGlobal:Boolean = false, sChannel:String = null )
		{
			super( bGlobal, sChannel );
			if ( sound != null )
			{
				this.loader = sound ;	
			}
		}
		
        /**
         * (read-only) Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public override function get bytesLoaded():uint
    	{
    		return (_loader as CoreSound).bytesLoaded ;	
    	}
        
        /**
         * (read-write) Indicates the total number of bytes in the downloaded data.
         */
        public override function get bytesTotal():uint
    	{
    		return (_loader as CoreSound).bytesTotal ;	
    	}
		
		/**
		 * Minimum number of milliseconds of MP3 data to hold in the Sound object's buffer. The Sound object waits until it has at least this much data before beginning playback and before resuming playback after a network stall. The default value is 1000 (one second).  
		 */
		public function get context():SoundLoaderContext
		{
			return _context || null ;
		}
		
		/**
		 * @private
		 */
		public function set context( context:SoundLoaderContext ):void
		{
			_context = context ;	
		}
		
       /**
         * (read-only) Provides access to the metadata that is part of an MP3 file. 
         */
        public function get id3():ID3Info
		{
    		return (_loader as CoreSound).id3 ;	
    	} 
    	
        /**
         * (read-only) Returns the buffering state of external MP3 files. If the value is true, any playback is currently suspended while the object waits for more data. 
         */
        public function get isBuffering():Boolean
		{
    		return (_loader as CoreSound).isBuffering ;	
    	} 
    	
        /**
         * (read-only) The length of the current sound in milliseconds. 
         */
        public function get length():Number
		{
    		return (_loader as CoreSound).length ;	
    	}     	
    	
		/**
		 * Indicates the loader object of this process.
		 */
		public override function get loader():*
		{
			return _loader as CoreSound ;	
		}
 		
		/**
		 * The current position of the playhead within the sound. 
		 * If the value is NaN, the internal SoundChannel is 'null'.
		 */
		public function get position():Number
		{
			return (_loader as CoreSound).position ;
		}
 		
        /**
         * (read-only) The URL from which this sound was loaded. 
         * This property is applicable only to Sound objects that were loaded using the Sound.load() method. 
         * For Sound objects that are associated with a sound asset from a SWF's library, the value of the url property is null. 
         */
        public function get url():String
		{
    		return (_loader as CoreSound).url ;	
    	}   
 
		/**
		 * Cancels a load() method operation that is currently in progress for the Loader instance.
		 */
		public override function close():void
		{
			(_loader as CoreSound).close() ;
			notifyFinished() ;
		} 
		
		/**
		 * Register the loader object.
		 */
		public override function register( dispatcher:IEventDispatcher ):void
		{
			if ( dispatcher != null )
			{
				super.register(dispatcher) ;
				dispatcher.addEventListener( Event.ID3, _id3, false, 0, true ) ;
			}
		}

		/**
		 * Unregister the loader object.
		 */
		public override function unregister( dispatcher:IEventDispatcher ):void
		{
			if ( dispatcher != null )
			{			
				super.unregister(dispatcher) ;
				dispatcher.removeEventListener( Event.ID3 , _id3 ) ;
			}
		}
		
		/**
		 * Invoked when the Event.ID3 event is fired.
		 */
		protected function _id3( e:Event ):void
		{
			dispatchEvent( e ) ;
		}
		
		/**
		 * This protected method contains the invokation of the load method of the current loader of this process.
		 */
		protected override function _run():void
		{
			(_loader as CoreSound).load( request , context ) ;
		}

		/**
		 * @private
		 */
		private var _context:SoundLoaderContext ;
		
	}
	
}
