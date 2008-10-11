/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process 
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.system.LoaderContext;	

    /**
	 * This action process launch the load of a Loader object.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import andromeda.events.ActionEvent ;
	 * import andromeda.process.ActionLoader ;
	 * 
	 * import flash.display.Loader ;
	 * import flash.net.URLRequest ;
	 * 
	 * var url:String = "library/picture.jpg" ;
	 * 
	 * var loader:Loader = new Loader() ;
	 * 
	 * loader.x = 50 ;
	 * loader.y = 50 ;
	 * 
	 * addChild( loader ) ;
	 * 
	 * var debug:Function = function( e:Event ):void
	 * {
	 *     trace(e) ;
	 * }
	 * 
	 * function initHandler(event:Event):void
	 * {
	 *     trace("init currentTarget:" + event.currentTarget + " target:" + event.target ) ;
	 * }
	 * 
	 * var process:ActionLoader = new ActionLoader( loader ) ;
	 * 
	 * process.addEventListener( ActionEvent.START  , debug ) ;
	 * process.addEventListener( ActionEvent.FINISH , debug ) ;
	 * 
	 * process.addEventListener(Event.INIT, initHandler);
	 * 
	 * process.request = new URLRequest( url ) ;
	 * 
	 * process.run() ;
	 * </pre>
	 * @author eKameleon
	 */
	public class ActionLoader extends CoreActionLoader 
	{

		/**
		 * Creates a new ActionLoader instance.
		 * @param loader The Loader object to load.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function ActionLoader( loader:Loader=null , bGlobal:Boolean = false, sChannel:String = null)
		{
			super( bGlobal, sChannel ) ;
			if ( loader != null )
			{
				this.loader = loader ;	
			}
		}
	
        /**
         * (read-only) Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public override function get bytesLoaded():uint
    	{
    		return (_loader as Loader).contentLoaderInfo.bytesLoaded ;	
    	}
        
        /**
         * (read-write) Indicates the total number of bytes in the downloaded data.
         */
        public override function get bytesTotal():uint
    	{
    		return (_loader as Loader).contentLoaderInfo.bytesTotal ;	
    	}

    	/**
    	 * (Read-only) Contains the root display object of the SWF file or image (JPG, PNG, or GIF) file that was loaded by using the load() or loadBytes() methods. 
    	 */
    	public function get content():DisplayObject
    	{
    		return (_loader as Loader).content ;	
    	} 
  
    	/**
    	 * (Read-only) Returns a LoaderInfo object corresponding to the object being loaded. 
    	 * LoaderInfo objects are shared between the Loader object and the loaded content object. 
    	 * The LoaderInfo object supplies loading progress information and statistics about the loaded file. 
    	 */
    	public function get contentLoaderInfo():LoaderInfo
    	{
    		return (_loader as Loader).contentLoaderInfo ;	
    	}

		/**
		 * The LoaderContext class provides options for loading SWF files and other media by using the Loader class. 
		 * The LoaderContext class is used as the context parameter in the load() and loadBytes() methods of the Loader class. 
		 */
		public function get context():LoaderContext
		{
			return _context || null ;
		}
		
		/**
		 * @private
		 */
		public function set context( context:LoaderContext ):void
		{
			_context = context ;	
		}

		/**
		 * Indicates the loader object of this process.
		 */
		public override function get loader():*
		{
			return _loader as Loader ;	
		}
		
		/**
		 * Cancels a load() method operation that is currently in progress for the Loader instance.
		 */
		public override function close():void
		{
			(_loader as Loader).close() ;
			notifyFinished() ;
		}

		/**
		 * Register the loader object.
		 */
		public override function register( dispatcher:IEventDispatcher ):void
		{
			if ( _loader != null )
			{
				super.register( contentLoaderInfo ) ;
				contentLoaderInfo.addEventListener( Event.INIT, _init, false, 0, true ) ;
			}
		}

		/**
		 * Unregister the loader object.
		 */
		public override function unregister( dispatcher:IEventDispatcher ):void
		{
			if ( _loader != null )
			{			
				super.unregister(contentLoaderInfo) ;
				contentLoaderInfo.removeEventListener( Event.INIT , _init ) ;
			}
		}

		/**
		 * Invoked when the Event.INIT event is fired.
		 */
		protected function _init( e:Event ):void
		{
			dispatchEvent( e ) ;
		}

		/**
		 * This protected method contains the invokation of the load method of the current loader of this process.
		 */
		protected override function _run():void
		{
			(_loader as Loader).load( request , context ) ;
		}
		
		/**
		 * @private
		 */
		private var _context:LoaderContext ;
	}
}


