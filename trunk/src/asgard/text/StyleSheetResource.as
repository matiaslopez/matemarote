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
    import flash.text.StyleSheet;
    import flash.utils.getDefinitionByName;
    
    import andromeda.ioc.core.ObjectDefinition;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.io.ObjectResourceType;
    import andromeda.process.ActionURLLoader;
    import andromeda.process.CoreActionLoader;
    
    import system.Reflection;    

    /**
     * This resource object contains all information about a stylesheet file to load in the application.
     */
    public class StyleSheetResource extends ObjectResource 
    {
    	
        /**
         * Creates a new StyleSheetResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function StyleSheetResource( init:Object=null )
        {
            super(init) ;
            type = ObjectResourceType.STYLE ;
        }
            	
        /**
         * The root path of all stylesheet resources.
         */
        public static var DEFAULT_PATH:String = "" ;    	
    	
        /**
         * The optional path of the external styleSheet file to load.
         */
    	public var path:String ;

        /**
         * The loader reference use to load the locale resource.
         */
        public var styleSheet:* ;
            	    	
        /**
         * Creates a new CoreActionLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
       	    
       	    try
       	    {
                
                if ( id == null || !(id is String) || id == "" )
                {
                    throw new Error( this + " create failed, the String id value of this resource not must be empty or 'null'" ) ;
                }
                
                var factory:ObjectFactory = owner as ObjectFactory ;
                
                if ( factory == null )
                {            
                    throw new Error( this + " create failed, the factory reference of this resource not must be 'null'." ) ;
                }
                
                if ( factory.containsObjectDefinition( id ) )
                {
                    throw new Error( this + " create failed, the factory already contains the specified id : " + id ) ;
                } 
                
                var ss:StyleSheet ;
                
                if ( styleSheet != null )
                {
                    var clazz:Class ;
                    if ( styleSheet is String )
                    {
                        clazz = getDefinitionByName( styleSheet as String )  as Class ;
                    }                           
                    else if ( styleSheet is Class )
                    {
                        clazz = styleSheet as Class ;   
                    }
                        
                    if ( clazz != null  )
                    {
                        if ( Reflection.getClassInfo(clazz).inheritFrom(StyleSheet) )  
                        {
                            ss = new clazz() as StyleSheet ;
                        }
                    } 
                    else if ( styleSheet is StyleSheet )
                    {
                        ss = styleSheet as StyleSheet ;
                    }                        
                }
                    
                if ( ss == null )
                {
                    ss = new StyleSheet() ; 
                }
                    
                var init:Object = 
                {
                    id           : id  ,
                    type         : "flash.text.StyleSheet" ,
                    singleton    : true ,
                    lazyInit     : true ,
                    factoryValue : ss   
                };
                    
                var definition:ObjectDefinition = ObjectDefinition.create( init ) ;
                    
                factory.addObjectDefinition( definition ) ;

                var path:String  = path || DEFAULT_PATH ;
                   
                var loader:StyleSheetLoader = new StyleSheetLoader( ss ) ;
                var action:ActionURLLoader  = new ActionURLLoader( loader ) ;
                    
                action.request = new URLRequest( path + resource ) ;
                    
                return action ;
                
       	    }
       	    catch( e:Error )
       	    {
                if ( verbose )
                {
                    getLogger().info( e.message ) ;
                }
       	    }
       	    return null ; 
            
        }    	
    	
    }
}
