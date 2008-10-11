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
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    
    import system.numeric.Range;    

    /**
	 * This action process launch the load of a URLLoader object.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import andromeda.events.ActionEvent ;
	 * import andromeda.process.ActionURLLoader ;
	 * 
	 * import system.eden ;
	 * 
	 * import flash.net.URLLoader ;
	 * import flash.net.URLRequest ;
	 * 
	 * var url:String = "data/config.eden" ;
	 * 
	 * var loader:URLLoader = new URLLoader() ;
	 * 
	 * var start:Function = function( e:Event ):void
	 * {
	 *    trace(e) ;
	 * }
	 * 
	 * var finish:Function = function( e:Event ):void
	 * {
	 *     
	 *     trace(e) ;
	 *     
	 *     var target:ActionURLLoader = e.target as ActionURLLoader ;
	 *     var data:*                 = eden.deserialize( target.data ) ;
	 *     
	 *     for (var prop:String in data)
	 *     {
	 *         trace("  > " + prop + " : " + data[prop]) ;
	 *     }
	 * }
	 * 
	 * var process:ActionURLLoader = new ActionURLLoader( loader ) ;
	 * 
	 * process.addEventListener( ActionEvent.START  , start ) ;
	 * process.addEventListener( ActionEvent.FINISH , finish ) ;
	 * 
	 * process.request = new URLRequest( url ) ;
	 * 
	 * process.run() ;
 	 * </pre>
	 * @author eKameleon
	 */
	public class ActionURLLoader extends CoreActionLoader 
	{

		/**
		 * Creates a new ActionURLLoader instance.
		 * @param loader The URLLoader object to load.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function ActionURLLoader( loader:URLLoader=null , bGlobal:Boolean = false, sChannel:String = null )
		{
			super( bGlobal, sChannel );
			if ( loader != null )
			{
				this.loader = loader ;	
			}
		}

		/**
		 * The range of the max depth value.
		 */
		public static var MAX_DEPTH_RANGE:Range = new Range(1, 100) ;

		/**
		 * The space string use to format the debugs.
		 */
		public static var SPACE:String = "   " ;

        /**
         * (read-only) Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public override function get bytesLoaded():uint
    	{
    		return (_loader as URLLoader).bytesLoaded ;	
    	}
        
        /**
         * (read-write) Indicates the total number of bytes in the downloaded data.
         */
        public override function get bytesTotal():uint
    	{
    		return (_loader as URLLoader).bytesTotal ;	
    	}

       /**
         * (read-write) Indicates the data received from the load operation. 
         */
        public function get data():*
    	{
    		return _loader.data ;	
    	}
    	
    	/**
    	 * @private
    	 */
        public function set data( value:* ):void
    	{
    		_loader.data = value ;
    	}
        
        /**
         * (read-write) Controls whether the downloaded data is received as 
         *   - text (URLLoaderDataFormat.TEXT),
         *   - raw binary data (URLLoaderDataFormat.BINARY)
         *   - URL-encoded variables (URLLoaderDataFormat.VARIABLES).
         */
        public function get dataFormat():String
    	{
    		return _dataFormat ;	
    	}
    	
    	/**
    	 * @private
    	 */
        public function set dataFormat( value:String ):void
    	{
    		_dataFormat = value ;	
    	}

		/**
		 * Indicated if the console use collapse property or not.
		 */
	    public var isCollapse:Boolean ;

		/**
		 * (read-only) Returns the max depth to collaspe the structure of an object in the console.
		 */
	    public function get maxDepth():uint
	    {
	        return _maxDepth ;
	    }

		/**
		 * (read-only) Sets the max depth to collaspe the structure of an object in the console.
		 */
        public function set maxDepth( value:uint ):void
        {
    		_maxDepth = MAX_DEPTH_RANGE.clamp(value) ;
    	}

        /**
         * (read-write) Activate or disactivate parsing (Use this with XML, EDEN, JSON...). 
         */
        public function get parsing():Boolean
    	{
    		return _isParsing ;	
    	}
    	
    	/**
    	 * @private
    	 */
        public function set parsing( b:Boolean ):void
    	{
    	    _isParsing = b ;	
    	}

		/**
		 * Indicates the flag of the verbose mode.
		 */
		public var verbose:Boolean ;

		/**
		 * Cancels a load() method operation that is currently in progress for the Loader instance.
		 */
		public override function close():void
		{
			(_loader as URLLoader).close() ;
			notifyFinished() ;
		}
		
		/**
		 * Enumerates the specified object.
		 */
		public function enumerate( o:Object ):void
		{
			getLogger().debug( this + " enumerate." ) ;			
			_enumerate(o) ;
		}

        /**
         * Override this method. Parse your datas when loading is complete.
         */
        public function parse():void
        {
            // override this method.
        }

        /**
         * Dispatch Event.COMPLETE event after all the received data is decoded and placed in the data property. 
         */
        protected override function complete( e : Event ) : void
		{
		    if (_isParsing) 
		    {
		        this.parse() ;
		    }
			if ( verbose )
			{
				enumerate( data ) ;	
			}
            super.complete(e) ;
        }	
        
		/**
		 * This protected method contains the invokation of the load method of the current loader of this process.
		 */
		protected override function _run():void
		{
			(_loader as URLLoader).load( request ) ;
		}

    	/**
    	 * @private
    	 */
		private var _dataFormat:String = URLLoaderDataFormat.TEXT ;
		
		/**
		 * @private
		 */
  		private var _isParsing:Boolean ;
        
		/**
		 * @private
		 */
		private var _maxDepth:uint ;
		
		/**
		 * @private
		 */
		private function _enumerate( o:Object , depth:uint = 1 ):void
		{
			for ( var prop:String in o ) 
			{
				var value:* = o[prop] ;
				getLogger().info( _getSpace( depth-1 ) + " + " + prop + " : " + value ) ;
				if ( value is Object && (isCollapse == true) && (depth <= maxDepth) )
				{
					_enumerate( value , depth + 1 ) ;
				}
			}
		}
		
		/**
		 * @private
		 */
		private function _getSpace( depth:uint=0 ):String
		{
			var s:String = "" ;
			if ( isNaN(depth) || depth == 0 )
			{
				return "" ;
			}
			while( --depth > -1 )
			{
				s += SPACE ;	
			}
			return s ;	
		}

	}

}
