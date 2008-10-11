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
package andromeda.ioc.io 
{
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.getDefinitionByName;
    
    import andromeda.ioc.core.ObjectDefinition;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.factory.strategy.ObjectFactoryValue;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.net.ParserLoader;
    import andromeda.process.ActionLoader;
    import andromeda.process.CoreActionLoader;
    
    import system.Reflection;    

    /**
     * This value object contains all information about a dll to load in the application. 
     */
    public class AssemblyResource extends ObjectResource 
    {
		
		/**
		 * Creates a new AssemblyResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function AssemblyResource(init:Object = null)
        {
            super(init);
        }
        
        /**
         * The default class name of the object definition if the id of the assembly is not 'null' or 'undefined'.
         */
        public static var DEFAULT_CLASS_NAME:String = "flash.display.DisplayObject" ;
        
        /**
         * The default Loader class use in all AssemblyResource to create a new resource process.
         */
        public static var DEFAULT_LOADER:Class = Loader ;        
        
        /**
         * The root path of all assembly resources.
         */
        public static var DEFAULT_PATH:String = "" ;        
        
        /**
         * Indicates if the assembly must check a policy file in the server of the external library to load.
         */
        public var checkPolicyFile:Boolean ;
        
        /**
         * Indicates the definition object to initialize the ObjectDefinition of the current assembly.
         * Use this attribute only if the 'id' of the assembly resource is not 'null' or 'undefined'.
         */
        public var definition:Object ;
        
        /**
         * The loader to use to load the assembly.
         */
        public var loader:* ;        
        
        /**
         * The optional root path of the assembly.
         */
        public var path:String ;        
        
        /**
         * Creates a new ActionURLLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
        	
        	_action     = null ;
        	_definition = null ;
        	        	
            var path:String  = path || DEFAULT_PATH ;        	
        	
            var currentLoader:Loader ;
            
            if ( loader != null )
            {
                
                var clazz:Class ;
                
                if (loader is String)
                {
                    clazz = getDefinitionByName( loader as String )  as Class ;
                }
                else if ( loader is Class )
                {
                    clazz = loader as Class ;   
                }
                
                if ( clazz != null  )
                {
                    if ( Reflection.getClassInfo(clazz).inheritFrom(Loader) ) 
                    {
                        currentLoader = new clazz() as Loader ;
                    }
                } 
                else if ( loader is ParserLoader )
                {
                    currentLoader = loader as Loader ;
                }
                
            }        	
        	
        	var factory:ObjectFactory = owner as ObjectFactory ;
            
            if ( id != null && id is String && factory != null && factory.containsObjectDefinition( id ) == false )
            {
                var init:Object = 
                {
                    id        : id  ,
                    type      : DEFAULT_CLASS_NAME 
                };
                if ( definition != null )
                {
                	for (var prop:String in definition )
                	{
                	   init[prop] = definition[prop] ;	
                	}
                }
                _definition = ObjectDefinition.create( init ) ;
                
                factory.addObjectDefinition( _definition  ) ;
            }
        	
            _action = new ActionLoader( currentLoader || new DEFAULT_LOADER() ) ;
			
			_action.request = new URLRequest( path + resource ) ;
			_action.context = new LoaderContext( checkPolicyFile , ApplicationDomain.currentDomain ) ;
            
            return _action ;
            
        } 
        
        /**
         * The optional method invoked when the resource is loading.
         */
        public override function initialize( ...args:Array ):void
        {
            if ( _definition != null && _action != null )
            {
                _definition.setFactoryStrategy( new ObjectFactoryValue( _action.content ) ) ;
            }
            else
            {
                throw new Error( this + " initialize resource failed." ) ;
            }
        }          
        
        /**
         * @private
         */
        private var _action:ActionLoader ;
        
        /**
         * @private
         */
        private var _definition:ObjectDefinition ;
        
    }
}
