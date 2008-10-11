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
package asgard.text 
{
    import flash.events.Event;
    import flash.system.ApplicationDomain;
    import flash.text.Font;
    
    import asgard.display.CoreLoader;
    import asgard.display.SWFInfo;
    import asgard.events.FontEvent;
    
    import system.Reflection;
    
    import vegas.data.iterator.Iterator;
    import vegas.data.sets.HashSet;    

    /**
     * This loader load an external swf who contains embed fonts.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.events.FontEvent ;
     * import asgard.text.CoreTextField ;
     * import asgard.text.FontLoader ;
     * 
     * import flash.events.Event ;
     * import flash.net.URLRequest ;
     * import flash.system.LoaderContext ;
     * import flash.text.TextFormat ;
     * 
     * var field1:CoreTextField = new CoreTextField( null , 150 , 20 ) ;
     * field1.border     = true ;
     * field1.embedFonts = true ;
     * field1.x          = 25 ;
     * field1.y          = 25 ;
     * 
     * var field2:CoreTextField = new CoreTextField( null , 150 , 20 ) ;
     * field2.x      = 25 ;
     * field2.y      = 50 ;
     * field2.border = true ;
     * 
     * field2.textColor = 0x000000 ;
     * field2.embedFonts = true ;
     * 
     * addChild(field1) ;
     * addChild(field2) ;
     * 
     * var addFont:Function = function( e:FontEvent ):void
     * {
     *     trace( e.type + " font:" + e.font ) ;
     * }
     * 
     * var complete:Function = function( e:Event )
     * {
     * 
     *     trace( "fonts : " + Font.enumerateFonts() ) ;
     *     
     *     field1.defaultTextFormat = new TextFormat("Arial Black", 12 , 0xFFFFFF ) ;
     *     field1.text = "hello world" ;
     *     
     *     field2.defaultTextFormat = new TextFormat("Myriad Pro", 12 , 0xFFFFFF ) ;
     *     field2.text = "hello world" ;
     * }
     * 
     * var request:URLRequest = new URLRequest( "fonts/fonts.swf" ) ;
     * 
     * var loader:FontLoader = new FontLoader() ;
     * 
     * loader.context = new LoaderContext( false , ApplicationDomain.currentDomain ) ;
     * 
     * loader.contentLoaderInfo.addEventListener( Event.COMPLETE , complete ) ;
     * loader.addEventListener( FontEvent.ADD_FONT , addFont ) ;
     * 
     * loader.registerFontClassName( "ArialBlack" ) ;
     * loader.registerFontClassName( "MyriadPro" ) ;
     * 
     * // You can use the autoRegister flag, the loader find the Font class in the external library for you
     * // loader.autoRegister = true ;
     * 
     * loader.load( request  ) ;
     * </pre>
     * <p>the external file "font/fonts.swf" contains in this library the two Font symbols.</p>
     * @author eKameleon
     */
    public class FontLoader extends CoreLoader 
    {

        /**
         * Creates a new FontLoader instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function FontLoader( id:* = null, isConfigurable:Boolean = false, name:String = null )
        {
            super( id, isConfigurable, name );
            contentLoaderInfo.addEventListener( Event.COMPLETE, complete , false, 99999 ) ;
        }
        
        /**
         * Indicates if the fonts in the external swf library (symbol class) are auto registered when the external file is loading. 
         */
        public var autoRegister:Boolean ;
        
        /**
         * Registers a new FontClassName in the specified FontLoader.
         */
        public function registerFontClassName( name:String ):Boolean
        {
            return _fontClassNames.insert( name ) ;
        }
        
        /**
         * Register the specified Font with the passed-in font name.
         * @param name The full class name of the font to register. 
         * @param domain The ApplicationDomain use to get the definition of the Font class with the specified name. If this parameter is null the ApplicationDomain.currentDomain is used.
         */
        public function registerFontByName( name:String , domain:ApplicationDomain=null ):void
        {
            if ( domain == null )
            {
                domain = ApplicationDomain.currentDomain ;
            }
            var clazz:Class = domain.getDefinition( name ) as Class ;
            if ( clazz != null )
            {
                if ( Reflection.getClassInfo(clazz).inheritFrom( Font ) )  
                {
                    Font.registerFont( clazz ) ;
                    var font:Font = new clazz() as Font ;
                    dispatchEvent( new FontEvent( FontEvent.ADD_FONT , font , this ) ) ;
                }
            }   
        }        
        
        /**
         * Unregisters a new FontClassName in the specified FontLoader.
         */
        public function unRegisterFontClassName( name:String ):Boolean
        {
            return _fontClassNames.remove(name) ;    
        }
        
        /**
         * Returns the number of embed fonts to load and create with this loader.
         * @return the number of embed fonts to load and create with this loader.
         */
        public function size():uint
        {
            return _fontClassNames.size() ;    
        }
        
        /**
         * Returns the Array representation of the font names.
         * @return the Array representation of the font names.
         */
        public function toArray():Array
        {
            return _fontClassNames.toArray() ;    
        }
        
        /**
         * Invoked when the FontLoader process is complete.
         */
        protected function complete( e:Event ) : void
        {   
        	var domain:ApplicationDomain = contentLoaderInfo.applicationDomain as ApplicationDomain ;
            if ( autoRegister )
            {
                if ( contentLoaderInfo.bytes != null )
                {
                	var info:SWFInfo = new SWFInfo( contentLoaderInfo.bytes ) ;
                	var fonts:Array  = info.symbolClassNames ;
                	if ( fonts != null && fonts.length > 0 )
                	{
                	   var name:String  ;
                	   var size:uint    = fonts.length ;
                	   while( --size > -1 )
                	   {
                            name = fonts[size] as String ;
                            if ( name == null || _fontClassNames.contains(name) )
                            {
                            	continue ;
                            }
                            else
                            {
                            	registerFontByName( name , domain ) ;
                            }
                	   }
                	}
                }
            }
            if ( _fontClassNames.size() > 0 )
            {
                var it:Iterator = _fontClassNames.iterator() ;
                while ( it.hasNext() )
                {
                    registerFontByName( it.next() as String , domain ) ;
                }
            }            

        }
        
        /**
         * The font class name.
         */
        protected var _fontClassNames:HashSet = new HashSet() ;
        
    }
}
