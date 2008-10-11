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
package andromeda.ioc.core 
{
    import system.eden;                                                

    /**
     * This object defines a listener definition in an object definition.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.ioc.core.ObjectListener ;
     * 
     * var init:Array = 
     * [
     *     { dispatcher:"dispatcher1" , type:"change" , method:"handleEvent" } ,
     *     { dispatcher:"dispatcher2" , type:"change" , method:"handleEvent" } 
     * ] ;
     * 
     * var listeners:Array = ObjectListener.create( init ) ;
     * 
     * trace( listeners ) ; 
     * </pre>
     * Usage, in the IoC factory we can use the "listeners" attribute in the object definition to defines the object like a listener.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var context:Object =
     * [
     *     { 
     *         id        : "dispatcher1" ,
     *         type      : "flash.events.EventDispatcher" ,
     *         singleton : true
     *     }
     *     ,
     *     { 
     *         id        : "dispatcher2" ,
     *         type      : "flash.events.EventDispatcher" ,
     *         singleton : true
     *     }
     *     ,    
     *     { 
     *         id        : "listener"   ,
     *         type      : "test.Listener" ,
     *         singleton : true ,
     *         listeners :
     *         [
     *             { dispatcher:"dispatcher1" , type:"change" , method:"handleEvent" , useCapture:false, priority:0 , useWeakReference:true } ,  
     *             { dispatcher:"dispatcher2" , type:"change" } 
     *         ]
     *     }    
     * ] ;
     * 
     * var factory:ECMAObjectFactory = ECMAObjectFactory.getInstance() ;
     * 
     * factory.create( context ) ; 
     * 
     * // 1 - target the callback "handleEvent" method in the listener object (all objects with methods can be a listener)
     * 
     * var dispatcher1:EventDispatcher = factory.getObject("dispatcher1") ;
     * 
     * dispatcher1.dispatchEvent( new Event( "change" ) ) ; // [object Listener] handleEvent [Event type="change" bubbles=false cancelable=false eventPhase=2]
     * 
     * // 2 - target the listener object if implements the vegas.events.EventListener interface.
     * 
     * var dispatcher2:EventDispatcher = factory.getObject("dispatcher2") ;
     * 
     * dispatcher2.dispatchEvent( new Event( "change" ) ) ; // [object Listener] handleEvent [Event type="change" bubbles=false cancelable=false eventPhase=2]
     * </pre>
     * In the previous example we implement the test.Listener class :* 
     * <pre class="prettyprint">
     * package test
     * {
     *     import flash.events.Event;
     *     
     *     import vegas.events.EventListener;    
     * 
     *     public class Listener implements EventListener
     *     {
     *         
     *         public function Listener()
     *         {
     *              // constructor
     *         }
     *         
     *         public function handleEvent( e:Event ):void
     *         {
     *             trace( this + " handleEvent " + e ) ;
     *         }
     *         
     *     }
     * }
     * </pre>
     */
    public class ObjectListener
    {

        /**
         * Creates a new ObjectListener instance.
         * @param dispatcher The dispatcher expression reference of the listener.
         * @param type type name of the event dispatched by the dispatcher of this listener.
         * @param method The name of the method to invoke when the event is handle.
         * @param useCapture Determinates if the event flow use capture or not.
         * @param priority Determines the priority level of the event listener.
         * @param useWeakReference Indicates if the listener is a weak reference.
         */
        public function ObjectListener( dispatcher:String , type:String , method:String=null , useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false )
        {
            this.dispatcher       = dispatcher ;
            this.method           = method ;
            this.type             = type ;
            this.priority         = priority ;
            this.useCapture       = useCapture ;
            this.useWeakReference = useWeakReference ;
        }
        
        /**
         * Defines the "dispatcher" attribute in a listener object definition.
         */      
        public static const DISPATCHER:String = "dispatcher" ;         

        /**
         * Defines the "method" attribute in a listener object definition.
         */
        public static const METHOD:String = "method" ;          
        
        /**
         * Defines the "priority" attribute in a listener object definition.
         */
        public static const PRIORITY:String = "priority" ;     
        
        /**
         * Defines the "useCapture" attribute in a listener object definition.
         */
        public static const USE_CAPTURE:String = "useCapture" ;           
        
        /**
         * Defines the "useWeakReference" attribute in a listener object definition.
         */
        public static const USE_WEAK_REFERENCE:String = "useWeakReference" ;   
        
        /**
         * Defines the "type" attribute in a listener object definition.
         */
        public static const TYPE:String = "type" ;          
        
        /**
         * The dispatcher expression reference of the listener.
         */
        public var dispatcher:String ;
        
        /**
         * The name of the method to invoke when the event is handle.
         */
        public var method:String ;
        
        /**
         * Determines the priority level of the event listener.
         */
        public var priority:int ;
        
        /**
         * The type name of the event dispatched by the dispatcher.
         */
        public var type:String ;     
        
        /**
         * Determinates if the event flow use capture or not.
         */
        public var useCapture:Boolean ;
        
        /**
         * Indicates if the listener is a weak reference.
         */
        public var useWeakReference:Boolean ;
        
        /**
         * Creates the Array definition of all listeners defines in the passed-in array.
         * @return the Array definition of all listeners defines in the passed-in array.
         */
        public static function create( a:Array = null ):Array
        {
            
            if ( a == null || a.length == 0 )
            {
                return null ;
            }
                        
            var def:Object ;
            var listeners:Array = [] ;

            var len:int = a.length ;
            
            var dispatcher:String ;
            var type:String ;
            
            for ( var i:int ; i<len ; i++)
            {
                    
                def  = a[i] as Object ;
                
                if ( def != null && ( DISPATCHER in def ) && ( TYPE in def ) )
                { 
                
                	dispatcher  = def[ DISPATCHER ] as String ;
                                    
	                if ( dispatcher == null || dispatcher.length == 0 )
    	            {
                    	continue ;
                	}
                	
                    type  = def[ TYPE ] as String ;          	

                    if ( type == null || type.length == 0 )
                    {
                        continue ;
                    }                	
                    
                	listeners.push
                	( 
                        new ObjectListener
                        ( 
                            dispatcher                                          , 
                            type                                                , 
                            def[ METHOD ] as String                             , 
                            def[ USE_CAPTURE ] == true                          , 
                            def[ PRIORITY ] is int ? def[ PRIORITY ] as int : 0 , 
                            def[ USE_WEAK_REFERENCE ] == true 
                        ) 
                    ) ;
                
                }
                else
                {
                	trace( "ObjectListener.create failed, a property definition is invalid at {" + i + "} with the value : " + eden.serialize(def) ) ; // FIXME logs ?	
                }			    
            }
            return ( listeners.length > 0 ) ? listeners : null ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
        	var s:String = "[ObjectListener" ;
        	if ( dispatcher )
        	{
        	   s += " dispatcher:\"" + dispatcher + "\"" ;	
        	}
        	if ( type )
            {
               s += " type:\"" + type + "\"" ;   
            }
            if ( method )
            {
               s += " method:\"" + method + "\"" ;  
            }
        	s += "]" ;
        	return s ;
        } 
    }
}
