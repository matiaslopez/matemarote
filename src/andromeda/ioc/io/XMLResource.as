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
    import flash.net.URLRequest;
    
    import andromeda.ioc.core.ObjectDefinition;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.factory.strategy.ObjectFactoryValue;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.net.XMLLoader;
    import andromeda.process.ActionURLLoader;
    import andromeda.process.CoreActionLoader;    

    /**
     * This value object contains all information to load an external XML file and create a new object definition in a IoC factory.
     */
    public class XMLResource extends ObjectResource 
    {
		
		/**
		 * Creates a new XMLResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function XMLResource( init:Object = null )
        {
            super( init ) ;
            _loader = new XMLLoader() ;
        }
        
        /**
         * The root path of all xml files.
         */
        public static var DEFAULT_PATH:String = "" ;        
                
        /**
         * Indicates the definition object to initialize the ObjectDefinition of the current assembly.
         * Use this attribute only if the 'id' of the assembly resource is not 'null' or 'undefined'.
         */
        public var definition:Object ;
                
        /**
         * The optional root path of the xml file.
         */
        public var path:String ;
        
        /**
         * Indicates if the object definition of this resource must be a singleton.
         */
        public var singleton:Boolean ;  
        
        /**
         * Creates a new ActionURLLoader object with the resource.
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
                                 
                var init:Object = 
                { 
                    id        : id    , 
                    type      : "XML" , 
                    singleton : singleton 
                } ;
                
                if ( definition != null )
                {
                 	for (var prop:String in definition )
               	    {
                   	    init[prop] = definition[prop] ;	
              	    }
                }
                                
                _definition = ObjectDefinition.create( init ) ;
                
                factory.addObjectDefinition( _definition ) ;
                                
                var uri:String = (path || DEFAULT_PATH) + resource ;
                                
                var action:ActionURLLoader = new ActionURLLoader( _loader  )   ;
                action.request             = new URLRequest( uri ) ;
                                               
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
        
        /**
         * The optional method invoked when the resource is loading.
         * @throws Error if the resource can be initialize.
         */
        public override function initialize( ...args:Array ):void
        {
            if ( _definition != null )
            {
                _definition.setFactoryStrategy( new ObjectFactoryValue( _loader.data ) ) ;
            }
            else
            {
                throw new Error( this + " initialize resource failed." ) ;
            }
        }        
        
        /**
         * @private
         */
        private var _definition:ObjectDefinition ;
        
        /**
         * @private
         */
        private var _loader:XMLLoader ;        
        
    }
}
