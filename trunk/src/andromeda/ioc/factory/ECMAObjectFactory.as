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
package andromeda.ioc.factory 
{
    import andromeda.ioc.core.ObjectDefinition;
    import andromeda.ioc.factory.ObjectFactory;
    
    import vegas.data.map.HashMap;
    import vegas.data.sets.HashSet;
    import vegas.errors.NullPointerError;    

    /**
     * This IoC factory use an ECMAScript collection of generic objects to create and initialize all object definitions used in the application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.ioc.factory.ECMAObjectFactory ;
     * 
     * var objects:Array =
     * [
     *     {
     *         id        : "my_format" ,
     *         type      : "flash.text.TextFormat" ,
     *         arguments : [ { value:"arial" } , { value:24 } , { value:0xFEF292 } , { value:true } ]
     *     }
     *     ,
     *     {
     *         id         : "my_field" ,
     *         type       : "flash.text.TextField"  ,
     *         properties :
     *         [
     *             { name : "autoSize"          , value  : "left"            } ,
     *             { name : "defaultTextFormat" , ref    : "my_format"       } ,
     *             { name : "text"              , value  : "HELLO WORLD"     } ,
     *             { name : "x"                 , value  : 10                } ,
     *             { name : "y"                 , value  : 10                }
     *         ]
     *     }
     *     ,
     *     {
     *         id               : "root" ,
     *         type             : "flash.display.MovieClip"  ,
     *         factoryReference : "#root" ,
     *         singleton        : true ,
     *         properties       :
     *         [
     *             { name : "addChild" , arguments  : [ { ref:"my_field" } ] }
     *         ]
     *     }
     * ] ;
     * 
     * var factory:ECMAObjectFactory = ECMAObjectFactory.getInstance() ;
     * 
     * factory.config.root = this ;
     * 
     * factory.create( objects ) ; 
     * </pre>
     * @author eKameleon
     */
    public class ECMAObjectFactory extends ObjectFactory
    {
        
        /**
         * Creates a new ECMAObjectFactory instance.
         * @param id The id of this factory.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function ECMAObjectFactory( id:*=null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( id , bGlobal, sChannel ) ;
            _setDefinitions = new HashSet() ;
        }
        
        /**
         * Determinates the default singleton name.
         */
        public static const DEFAULT_SINGLETON_NAME:String = "__default__" ;        
                
        /**
         * This array contains objects to fill this factory with the run or create method.
         */
        public var objects:Array ;
        
        /**
         * Indicates if the specified singleton reference is register.
         * @return <code class="prettyprint">true</code> If the specified singleton reference is register.
         */
        public static function containsInstance( id:String ):Boolean
        {
            return _instances.containsKey( id ) ;
        }        
                
        /**
         * Clear all globals ECMAObjectFactory singleton references.
         */
        public static function flushInstance():void 
        {
            _instances.clear() ;
        }        
        
        /**
         * Returns the singleton reference of this class.
         * @param id The index of the singleton reference to return or create (If this value is Null, the DEFAULT_SINGLETON_NAME static value is used).
         * @return the singleton reference of this class.
         */
        public static function getInstance( id:String = null ):ECMAObjectFactory
        {
            if ( id == null || id.length == 0 ) 
            {
                id = DEFAULT_SINGLETON_NAME ;
            }
            if ( ! _instances.containsKey(id) ) 
            {
                _instances.put( id , new ECMAObjectFactory( id ) ) ;
            }
            return _instances.get( id ) as  ECMAObjectFactory ;
        }

        /**
         * Removes a singleton reference of this class with the specified id.
         * @param id The index of the singleton reference to remove (If this value is Null, the DEFAULT_SINGLETON_NAME static value is used).
         * @return <code class="prettyprint">true</code> If the specified singleton reference is removed.
         */
        public static function removeInstance( id:String = null ):Boolean 
        {
            if ( id == null || id.length == 0 ) 
            {
                id = DEFAULT_SINGLETON_NAME ;
            }
            if ( _instances.containsKey(id) ) 
            {
                return _instances.remove( id ) != null ;
            }
            else 
            {
                return false ;
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
            
            notifyStarted() ;
            
            setRunning( true ) ;
            
            _setDefinitions.clear() ;
            
            if ( arguments[0] is Array )
            {
                objects = arguments[0] ;
            }
            
            if ( objects == null )
            {
                throw new NullPointerError(this + " run failed if the 'objects' Array property not must be 'null' or 'undefined'.") ;
            }    
            
            if ( objects.length > 0)
            {
                while ( objects.length > 0 )
                {
                    _createNewObjectDefinition( objects.shift() ) ;
                }
            }
            
            _flushInitSingletonDefinitions() ;
            
            setRunning( false ) ;
            
            notifyFinished() ;    
            
        }
        
        /**
         * @private
         */    
        private static var _instances:HashMap = new HashMap() ;
                
        /**
         * @private
         */
        private var _setDefinitions:HashSet ;
                
        /**
         * Returns and creates a new IObjectDefinition instance.
         * @return and creates a new IObjectDefinition instance.
         */
        private function _createNewObjectDefinition( o:Object ):void
        {
            if ( o != null )
            {
                var definition:ObjectDefinition = ObjectDefinition.create(o) ;
                addObjectDefinition( definition ) ;
                _initDefinition( definition ) ;        
            }
            else
            {
                warn( this + " create new object definition failed with a 'null' or 'undefined' object." ) ;
            }
        }
        
        /**
         * @private
         */
        private function _flushInitSingletonDefinitions():void
        {
            if ( _setDefinitions.isEmpty() == false )
            {
                var ar:Array  = _setDefinitions.toArray() ;
                var size:int = ar.length ;
                for ( var i:int ; i < size ; i++ )
                {
                    getObject( ar[i] as String ) ;
                } 
                _setDefinitions.clear() ;
            }
        }
                
        /**
         * @private
         */
        private function _initDefinition( definition:ObjectDefinition ):void
        {
            if ( definition.isSingleton() && ( definition.isLazyInit() == false ) )
            {
                if ( containsObject( definition.id ) )
                {
                    _setDefinitions.insert( definition.id ) ;
                }
            }
        }
        
    }
}