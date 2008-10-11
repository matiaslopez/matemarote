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
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    
    import asgard.display.CoreLoader;    

    /**
     * This AVM2Loader loads both of AVM1 and AVM2 swf as AVM2.
     * @example
     * <pre class="prettyprint">
     * import asgard.display.AVM2Loader ;
     * 
     * import flash.net.URLRequest ;
     * import flash.system.LoaderContext ;
     * 
     * var movie:MovieClip ;
     * 
     * var stopIt:Function = function()
     * {
     *    trace("stop movie.") ;
     *    if ( movie != null )
     *    {
     *        movie.stop() ;
     *    }
     * }
     * 
     * var init:Function = function( e:Event ):void
     * {
     *     trace(e) ;
     *     
     *     var content:MovieClip = loader.content as MovieClip ;
     *     movie = content.mc ;
     *     
     *     // movie.addFrameScript( 1 , stopIt ) ;    stop the movie in the first frame
     *     movie.addFrameScript( movie.totalFrames - 1 , stopIt ) ; // stop the movie in the last frame
     * }
     * 
     * var loader:AVM2Loader = new AVM2Loader() ;
     * loader.context = new LoaderContext( false , ApplicationDomain.currentDomain ) ;
     * loader.contentLoaderInfo.addEventListener( Event.INIT , init ) ;
     * loader.x = 25 ;
     * loader.y = 25 ;
     * 
     * addChild( loader ) ;
     * 
     * var request:URLRequest = new URLRequest( "avm1.swf"  ) ; // The swf is compiled with the FP8 publish settings.
     * loader.load( request ) ;
     * </pre>
     * @author eKameleon
     */
    public class AVM2Loader extends CoreLoader 
    {
        
        /**
         * Creates a new AVM2Loader instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function AVM2Loader( id:* = null, isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name );
        }

        /**
         * Loads both of AVM1 and AVM2 movie as AVM2 movie.
         */
        public override function load( request:URLRequest, context:LoaderContext=null ):void
        {
            
            if ( context != null )
            {
                this.context = context ;
            }
            
            _urlLoader            = new URLLoader() ;
            _urlLoader.dataFormat = URLLoaderDataFormat.BINARY ;
            
            _urlLoader.addEventListener( Event.COMPLETE                    , _binaryLoaded , false, 0, true ) ;
            _urlLoader.addEventListener( IOErrorEvent.IO_ERROR             , _fireEvent    , false, 0, true ) ;
            _urlLoader.addEventListener( ProgressEvent.PROGRESS            , _fireEvent    , false, 0, true ) ;
            _urlLoader.addEventListener( Event.OPEN                        , _fireEvent    , false, 0, true ) ;
            _urlLoader.addEventListener( HTTPStatusEvent.HTTP_STATUS       , _fireEvent    , false, 0, true ) ;
            _urlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _fireEvent    , false, 0, true ) ;
            
            _urlLoader.load( request ) ;
            
        }

        /**
         * loads both of AVM1 and AVM2 movie as AVM2 movie.
         */
        public override function loadBytes( bytes:ByteArray , context:LoaderContext=null ):void
        {
        	
        	// uncompress if compressed
           
            bytes.endian = Endian.LITTLE_ENDIAN ;
           
            if( bytes[0] == 0x43 )
            {
                // many thanks for be-interactive.org
                
                var compressedBytes:ByteArray = new ByteArray();
                
                compressedBytes.writeBytes(bytes, 8);
                compressedBytes.uncompress();
                
                bytes.length   = 8;
                bytes.position = 8;
                bytes.writeBytes(compressedBytes) ;
                
                compressedBytes.length = 0 ;
                
                // flag uncompressed
                
                bytes[0] = 0x46 ;
                
            }
            hackBytes(bytes);
            super.loadBytes(bytes, context);
        }

        /**
         * @private
         */
        private function _binaryLoaded(e:Event):void
        {
            loadBytes( ByteArray(_urlLoader.data), context ) ;
            _urlLoader = null ;
        }
        
        /**
         * @private
         */
        private function _fireEvent(e:Event):void
        {
            dispatchEvent(e);
        }

        /**
         * If the loaded swf is a AVM1 movie hack it.
         * @private
         */
        private function hackBytes(bytes:ByteArray):void
        {
            if( bytes[4] < 0x09 )
            {
                bytes[4] = 0x09 ;  
            }
            var imax:int = Math.min( bytes.length, 100 ) ;
            for( var i:int=23; i<imax; i++ )
            {
                if( bytes[i-2] == 0x44 && bytes[i-1] == 0x11 )
                {
                    bytes[i] = bytes[i] | 0x08 ;
                    return ;
                }
            }
        }

        /**
         * @private
         */
        private var _urlLoader:URLLoader;
        
    }
}
