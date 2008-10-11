/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.text 
{
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.text.Font;
    
    import andromeda.ioc.factory.ObjectConfig;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.io.ObjectResourceType;
    import andromeda.process.ActionLoader;
    import andromeda.process.CoreActionLoader;
    
    import asgard.events.FontEvent;    

    /**
     * This resource object contains all information about an external library (swf) to embed fonts in the application.
     */
    public class FontResource extends ObjectResource 
    {
    	
        /**
         * Creates a new StyleSheetResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function FontResource( init:Object=null )
        {
            super(init) ;
            type = ObjectResourceType.FONT ;
        }
            	
        /**
         * The root path of all stylesheet resources.
         */
        public static var DEFAULT_PATH:String = "" ;    	
    	
        /**
         * Indicates if the fonts in the external swf library (symbol class) are auto registered when the external file is loading. 
         */   	
        public var autoRegister:Boolean ;
            	
        /**
         * Indicates if the assembly must check a policy file in the server of the external library to load.
         */
        public var checkPolicyFile:Boolean ;    	

        /**
         * The Array representation of all full class name of all embed fonts to load and register in the external library.
         */
        public var fonts:Array ;    	
    	
        /**
         * The optional path of the external font library to load.
         */
    	public var path:String ;
        
        /**
         * Creates a new CoreActionLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
       	    var action:ActionLoader ;
       	    var isRegistered:Boolean = ( fonts != null && fonts.length > 0 ) ;
       	    if ( autoRegister || isRegistered  )
       	    {
       	    	var name:String ;
       	    	var path:String       = path || DEFAULT_PATH ;
       	        var loader:FontLoader = new FontLoader() ;
       	        
       	        loader.addEventListener( FontEvent.ADD_FONT , _addFont ) ;
       	        
                loader.autoRegister   = autoRegister ;
                if ( isRegistered )
                {
                     
       	            var size:int          = fonts.length ;
       	            for ( var i:int ; i<size ; i++ )
       	            {
           	        	name = fonts[i] as String ;
       	        	   if (name != null && name.length > 0 )
       	        	   {
           	        	   loader.registerFontClassName(name) ;
       	        	   }
       	            }
                }
       	        action          = new ActionLoader( loader ) ;
       	        action.context  = new LoaderContext( checkPolicyFile , ApplicationDomain.currentDomain ) ; 
                action.request  = new URLRequest( path + resource ) ;
       	    }
            return action ;
        }    	
    	
    	/**
    	 * @private
    	 */
    	private function _addFont( e:FontEvent ):void
    	{
    		if ( verbose )
    		{
    			var font:Font = e.font ;
    			if ( font != null )
    			{
    				var message:String = this + " register a new font : [ name:" + font.fontName + ", type:" + font.fontType + ", style:" + font.fontStyle + "]" ;
    				var factory:ObjectFactory = owner as ObjectFactory ;
    				if ( factory != null )
    				{
    					if ( factory.config.useLogger )
    					{
    						getLogger().info( message ) ;
    						return ;
    					}
    				}
    				trace( message ) ;
    			}
    		}
    	}
    	
    }
}
