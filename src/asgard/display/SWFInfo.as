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
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.Endian;    

    /**
     * This tool class can check a swf bytecode and returns the list of all class inside.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.display.SWFInfo ;
     * 
     * import flash.display.Loader ;
     * import flash.net.URLRequest ;
     * import flash.system.LoaderContext ;
     * 
     * var complete:Function = function( e:Event ):void
     * {
     *     trace("-------") ;
     *     
     *     var swf:ByteArray = e.currentTarget.bytes ;
     *     
     *     trace( "SWF complete : " +  swf  ) ;
     *     
     *     var info:SWFInfo  = new SWFInfo( swf ) ;
     *     
     *     trace( "SWF frameCount         : " + info.frameCount ) ;
     *     trace( "SWF frameRate          : " + info.frameRate  ) ;
     *     trace( "SWF length             : " + info.length  ) ;
     *     trace( "SWF version            : " + info.version  ) ;
     *     trace( "SWF symbol class names : " + info.symbolClassNames ) ;
     *     
     *     trace("-------") ;
     * }
     * 
     * var loader:Loader = new Loader() ;
     * 
     * loader.contentLoaderInfo.addEventListener( Event.COMPLETE , complete ) ;
     * 
     * addChild( loader ) ;
     * 
     * var request:URLRequest = new URLRequest( "library.swf"  ) ;
     * 
     * loader.load( request ) ;
     * </pre>
     * @author eKameleon
     */
    public class SWFInfo 
    {
    	
    	/**
    	 * Creates a new SWFInfo instance.
    	 */
    	public function SWFInfo( bytes:ByteArray = null )
    	{
    		if ( bytes != null )
    		{
                loadBytes( bytes ) ;
    		}
    	}
    	
        /**
         * The compressed tag value (0x43)
         */
        public static const COMPRESSED:int = 0x43 ;
        
        /**
         * The "full" tag value (0x3F)
         */        
        public static const FULL:int = 0x3F ;
        
        /**
         * The "not compressed" tag value (0x46)
         */        
        public static const NOT_COMPRESSED:int = 0x46 ;    	
    	
        /**
         * The "symbol class" tag value (0x4C)
         */        
        public static const SYMBOL_CLASS:int = 0x4C ;     	
    	
    	/**
    	 * The ByteArray representation of the SWF.
    	 */
    	public function get bytes():ByteArray
    	{
    		return _bytes ;
    	}
        
        /**
         * @private
         */
        public function set bytes( bytes:ByteArray ):void
        {
            loadBytes( _bytes ) ;
        }        
        
        /**
         * Indicates the compressed byte value the specified SWF.
         */
        public function get compressed():Boolean
        {
           return _compressed ;
        }
        
        /**
         * Indicates the length of entire file in bytes.
         */
        public function get fileLength():int
        {
           return _fileLength ;
        }        
        
        /**
         * Indicates the total number of frames in the file.
         */
        public function get frameCount():int
        {
           return _frameCount ;
        }
    	
        /**
         * Indicates the frame delay in number of frames per second.
         */
        public function get frameRate():int
        {
           return _frameRate ;
        } 
        
        /**
         * Indicates the version value of the specified SWF.
         */
        public function get version():int
        {
           return _version ;
        }

        /**
         * Returns the Array representation of all symbol class defines in the library of the SWF.
         */
        public function get symbolClassNames():Array
        {
           return _symbolClassNames ;
        }
                
        /**
         * Loads the passed-in SWF bytes and launch the mapping of the object.
         */
        public function loadBytes( b:ByteArray ):void
        {
            
            reset() ;
            
            if ( b == null )
            {
                return ;
            }
                       
            _bytes = b ;
            
            _bytes.position = 0 ;
                        
            _compressed = bytes.readUnsignedByte() == COMPRESSED ;
            
            _bytes.position += 2 ;
            
            _version = bytes.readByte() ;
                        
            _bytes.endian = Endian.LITTLE_ENDIAN;

            _fileLength = bytes.readUnsignedInt() ; 
            
            var swf:ByteArray = new ByteArray();
            
            _bytes.readBytes ( swf , 0 );
            
            _bytes.position = 0 ;
            
            if ( _compressed ) 
            {
            	swf.uncompress() ;
            }
            
            swf.endian = Endian.LITTLE_ENDIAN ;
            
            var nBits:int = ( ( ( ( swf.readByte() >> 3 ) & 0x1F ) * 4 ) / 8 ) + 1 ;
            
            // _frameSize        = swf.readByte() ;
            
            swf.position += nBits + 1;
            
            //trace(_frameSize) ;
            
            _frameRate        = swf.readByte()   ; 
            _frameCount       = swf.readShort()  ; 
            
            _symbolClassNames = [] ;
            
            var dictionary:Dictionary  = _browseSymbols( swf ) ; 
            
            if ( dictionary[ SYMBOL_CLASS ] )
            {
            
                swf.position = dictionary[ SYMBOL_CLASS ] ;
                
                var count:int = swf.readUnsignedShort();
                
                var char:int ;
                var name:String;
                
                for ( var i:int ; i < count ; i++ )
                {
                    
                    swf.readUnsignedShort();
                
                    char = swf.readByte() ;
                    name = ""             ;
                    
                    while (char != 0)
                    {
                        name += String.fromCharCode( char ) ;
                        char  = swf.readByte() ;
                    }
                    
                    _symbolClassNames.push ( name ) ;
                    
                }
                
            } 
        }
        
        /**
         * Resets the informations and the bytes reference of this instance.
         */
        public function reset():void
        {
        	_bytes            = null  ;
        	_compressed       = false ;
        	_fileLength       = 0     ;
        	_frameCount       = 0     ;
        	_frameRate        = 0     ;
            _symbolClassNames = null  ;
            _version          = 0     ;
        }
        
        /**
         * @private
         */
        private static function _browseSymbols( bytes:ByteArray ):Dictionary
        {
            
            var currentTag:int;
            var step:int;
            var dictionary:Dictionary = new Dictionary() ;
            
            while ( currentTag = ((bytes.readShort() >> 6) & 0x3FF) )
            {
            
                dictionary[currentTag] = bytes.position;
            
                bytes.position -= 2;
                
                step = bytes.readShort() & 0x3F;
                
                if ( step < FULL )
                {
                    bytes.position += step;
                        
                } 
                else 
                {
                    step = bytes.readUnsignedInt();
                    dictionary[currentTag] = bytes.position;
                    bytes.position += step;
                }
                
            }
            
            return dictionary;
            
        }   
        
        /**
         * @private
         */
        private var _bytes:ByteArray ;        
        
        /**
         * @private
         */        
        private var _compressed:Boolean ;
        
        /**
         * @private
         */
        private var _fileLength:uint ;        
        
        /**
         * @private
         */
        private var _frameCount:int ;
        
        /**
         * @private
         */
        private var _frameRate:int ;     
             
        /**
         * @private
         */
        // TODO : private var _frameSize:* ;              
                
        /**
         * @private
         */
        private var _symbolClassNames:Array ;  
    	
        /**
         * @private
         */
        private var _version:int ;      	
    	
    }
}
