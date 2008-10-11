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
package andromeda.ioc.net 
{
    import andromeda.events.ActionEvent;
    import andromeda.ioc.core.ObjectAttribute;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.io.ContextResource;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.io.ObjectResourceBuilder;
    import andromeda.process.ActionURLLoader;
    import andromeda.process.CoreActionLoader;
    import andromeda.process.Sequencer;
    import andromeda.process.SimpleAction;
    
    import vegas.core.IFactory;
    import vegas.data.map.HashMap;    

    /**
     * This loader object load an external IoC context and this dependencies and fill the IoC container.
     */
    public class ObjectFactoryLoader extends SimpleAction implements IFactory
    {
        
        /**
         * Creates a new ObjectFactoryLoader instance.
         * @param context The uri of the context external eden file (default "application.eden").
         * @param path The optional path of the external context file (default "").
         * @param factory The optional ECMAObjectFactory reference of this loader. By default the loader use the ECMAObjectFactory.getInstance() reference. 
         */
        public function ObjectFactoryLoader( context:String=null , path:String="" , factory:ObjectFactory = null )
        {
            
            this.context  = context ;
            this.factory  = factory ;
            this.path     = path    ;
            
            _resources    = new HashMap() ; 
            
            sequencer     = new Sequencer() ;            
            
            sequencer.addEventListener( ActionEvent.FINISH   , _finishSequencer   , false, 0 , true ) ;
            sequencer.addEventListener( ActionEvent.PROGRESS , _progressSequencer , false, 0 , true ) ;
            sequencer.addEventListener( ActionEvent.START    , _startSequencer    , false, 0 , true ) ;
            
        }
        
        /**
         * The default context file uri value.
         */
        public var context:String ;
        
        /**
         * The IoC factory reference.
         */
        public function get factory():ObjectFactory
        {
            return _factory ;	
        }
        
        /**
         * @private
         */
        public function set factory( value:ObjectFactory ):void
        {
        	_factory = value ;
		}
  		      
        /**
         * The default path of the external context file.
         */
        public function get path():String
        {
        	return ContextResource.DEFAULT_PATH ;	
        }
        
        /**
         * @private
         */
        public function set path( value:String ):void
        {
        	ContextResource.DEFAULT_PATH = value || "" ;	
        }        
        
        /**
         * Switch the verbose mode of this loader.
         */
        public var verbose:Boolean = false ;
        
        /**
         * Clear all the resources in the loader and reset it.
         */
        public function clear():void
        {
        	objects  = [] ;
            _first   = true ;
            _resources.clear() ;
            sequencer.clear() ;
        }
        
        /**
         * Creates the objects.
         * @param ...arguments An Array who contains all the object definitions to fill the IoC container. 
         */
        public function create( ...arguments:Array ):void         
        {
            if ( objects.length > 0 )
            {    
                factory.create( objects ) ;
            }
            else
            {
            	if ( verbose && factory.sizeObjectDefinition() == 0 )
            	{
                    getLogger().warn( this + " the factory is empty, no object definition are found." ) ;
            	} 
                complete() ;
            }    
        }

        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            
            if ( running )
            {
            	return ;
            }
            
            clear() ;
            
            if ( arguments.length > 0 && arguments[0] is String )
            {
                context = arguments[0] as String ;
            }
            
            addResource( new ContextResource( { resource:context } ) ) ;
            
            setRunning(true) ;
            
            notifyStarted() ;
            
            sequencer.run() ;
            
        }        
        
        /**
         * Register the current factory referenceof this loader. 
         */
        public function registerFactory():void
        {
        	if ( _factory != null && _isRegister == false )
            {
                _isRegister = true ;
                _factory.addEventListener( ActionEvent.FINISH , complete ) ;
            }
        }

        /**
         * Unregister the current factory referenceof this loader. 
         */
        public function unregisterFactory():void
        {
            if ( _factory != null && _isRegister )
            {
            	_isRegister = false  ;
                _factory.removeEventListener( ActionEvent.FINISH , complete ) ;
            }
        }
        
        ///////// protected   
                
        /**
         * The array representation of the object definitions to insert in the IOC factory container.
         */
        protected var objects:Array ;        
        
        /**
         * The internal sequencer of the factory loader. (Use it to load multiple context files).
         */
        protected var sequencer:Sequencer ;        
        
        /**
         * This method is the strategy to insert a new ObjectResource in the sequencer. 
         * You must defines and overrides this method in your concrete ObjectFactoryLoader class.
         */
        protected function addResource( resource:ObjectResource ):Boolean
        {
            if ( resource != null && resource.type != null )
            {
            	var loader:CoreActionLoader = resource.create() as CoreActionLoader ;
            	
            	_resources.put( loader , resource ) ;
            	
                return sequencer.addAction( loader ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Invoked when the factory is complete.
         */
        protected function complete( e:ActionEvent = null ):void
        {
            if ( verbose )
            {
                getLogger().debug( this + " complete(" + e + ")" ) ;
            }
            unregisterFactory() ;
            notifyFinished() ;
        }        
        
        ///////// private        
           
        /**
         * @private
         */
        private var _factory:ObjectFactory ;
        
        /**
         * @private
         */
        private var _first:Boolean = true ;
        
        /**
         * @private
         */
        private var _imports:Array ;
                
        /**
         * @private
         */
        private var _isRegister:Boolean ;
            
        /**
         * @private
         */
        private var _resources:HashMap ;
        
        /**
         * @private
         */
        private function _checkContext( o:* ):void
        {

            // trace( this + " progress data : " + eden.serialize( data )) ;
                
            // configuration 
                
            if ( _first )
            {
                _first = false ;    
                var config:Object = o[ ObjectAttribute.CONFIGURATION  ] ;
                if ( config != null )
                {
                    factory.config.initialize( config ) ;    
                }
            }
            
            var a:Array ;
                
            // objects : the current object definitions
                
            a = o[ ObjectAttribute.OBJECTS ] as Array ;
            if ( a != null && a.length > 0 )
            {
                objects.unshift.apply( objects , a ) ;
            }                     
                          
            // imports
                
            var size:int ;
            var resource:ObjectResource ;
                    
            a = o[ ObjectAttribute.IMPORTS ] as Array ;
                                
            if ( a != null && a.length > 0 )
            {
                size = a.length ;
                while ( --size > -1 )
                {
                    resource = ObjectResourceBuilder.get( a[size] ) ;
                    if ( resource != null )
                    {
                        resource.owner = factory ;
                        _imports.push( resource ) ;
                    }
                }
            }
        }
                    
        /**
         * @private
         */
        private function _finishSequencer( e:ActionEvent ):void
        {
        	
            if ( verbose )
            {
                getLogger().debug(this + " finish sequencer : " + e) ;
            }
            
            // imports
            
            if ( _imports != null && _imports.length > 0 )
            {
            	var i:int ;
            	var size:int = _imports.length ;
                for ( ; i<size ; i++ )
                {
                	addResource( _imports[i] as ObjectResource ) ;
                }
                _imports = [] ;
            }
            
            // next
            
            if ( sequencer.size() > 0 )
            {
            	sequencer.run() ;
            }
            else
            {
                create() ;
            }
        }
        
        /**
         * @private
         */
        private function _initResource( resource:ObjectResource , action:CoreActionLoader ):void
        {
            // trace(this + " progress :: + " + action.request.url ) ;
            if ( resource != null  )
            {
                try
                {
                    if ( resource is ContextResource )
                    {
                        _checkContext( ( action as ActionURLLoader ).data ) ;
                    }
                    else
                    {
                        resource.initialize() ;	
                    }
                }
                catch( e:Error )
                {
                    if ( verbose )
                    {
                        getLogger().error( this + " init resource failed : " + resource ) ;
                    }
                }
            }        	
        }
             
        /**
         * @private
         */
        private function _progressSequencer( e:ActionEvent ):void
        {
            
            if ( verbose )
            {
                getLogger().debug(this + " progress sequencer : " + e) ;
            }
            
            var action:CoreActionLoader = sequencer.getCurrent() as CoreActionLoader ;
            var resource:ObjectResource = _resources.remove( action ) as ObjectResource ;
            
            // trace(this + " progress :: + " + resource + " :: " + _resources.size() ) ;
            
            _initResource( resource , action ) ;
            
        }
        
        /**
         * @private
         */
        private function _startSequencer( e:ActionEvent ):void
        {
            if ( verbose )
            {
                getLogger().debug(this + " start sequencer : " + e) ;
            }
            _imports = [] ;
            registerFactory() ;
        }

    }
}