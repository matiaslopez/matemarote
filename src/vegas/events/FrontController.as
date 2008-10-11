/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events
{
    import vegas.core.CoreObject;
    import vegas.data.iterator.Iterator;
    import vegas.data.map.ArrayMap;
    import vegas.data.map.HashMap;    

    /**
     * The Front Controller pattern defines a single EventDispatcher that is responsible for processing application requests.
     * <p>A front controller centralizes functions such as view selection, security, and templating, and applies them consistently across all pages or views. Consequently, when the behavior of these functions need to change, only a small part of the application needs to be changed: the controller and its helper classes.</p>
     * @author eKameleon
     */
    public class FrontController extends CoreObject
    {
        
        /**
         * Creates a new FrontController instance.
         * @param channel the channel of this FrontController.
         * @param target the EventDispatcher reference to switch with the default EventDispatcher singleton in the controller.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var controller:FrontController = new FrontController() ;
         * </pre>
         */
        public function FrontController( channel:String=null, target:EventDispatcher=null )
        {
            _map = new ArrayMap() ;
            _dispatcher = target || EventDispatcher.getInstance( channel ) ; 
        }

        /**
         * Removes all entries in the FrontController. 
         */
        public function clear():void
        {
            if ( size() > 0 )
            {
                var it:Iterator = _map.keyIterator() ;
                while(it.hasNext())
                {
                    remove(it.next()) ;    
                }
                _map.clear() ;
            }    
        }

        /**
         * Returns 'true' if the eventName is registered in the FrontController.
         * @param eventName:String
         */
        public function contains( eventName:String ):Boolean 
        {
            return _map.containsKey(eventName) ;    
        }
        
        /**
         * Dispatch an event into the FrontController
         * @param e:Event 
         */
        public function fireEvent( e:* ):void 
        {
            if (e is String)
            {
                _dispatcher.dispatchEvent( new BasicEvent(e) ) ;    
            }
            else
            {
                _dispatcher.dispatchEvent( e ) ;        
            }
              
        }

        /**
         * Flush all global FrontController singletons.
         */
        public static function flush():void 
        {
            FrontController.instances.clear() ;
        }

        /**
         * Returns the internal EventDispatcher singleton reference of this FrontController.
         * @return the internal EventDispatcher singleton reference of this FrontController.
         */
        public function getEventDispatcher():EventDispatcher
        {
            return _dispatcher ;        
        }

        /**
         * Returns a global <code class="prettyprint">FrontController</code> singleton.
         * @param channel The channel of the FrontController (default the EventDispatcher.DEFAULT_SINGLETON_NAME value).
         * @return a global <code class="prettyprint">FrontController</code> singleton.
         */
        public static function getInstance( channel:String = null ):FrontController 
        {
            if (!channel) 
            {
                channel = EventDispatcher.DEFAULT_SINGLETON_NAME ;
            }
            if (!FrontController.instances.containsKey( channel )) 
            {
                FrontController.instances.put( channel , new FrontController( channel ) ) ;
            }
            return FrontController.instances.get(channel) as FrontController ;
        }

        /**
         * Returns a EventListener
         * @usage  myController.get( myEvent:String ) ;    
         * @param  eventName:String
         * @return an EventListener or a event callback Function.
         */
        public function getListener(eventName:String):* 
        {
            return _map.get(eventName) ;
        }
    
        /**
         * Add a new entry into the FrontController.
         * @param eventName:String
         * @param listener:EventListener or listener:Function
         * @throws ArgumentError If the 'eventName' value in argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
         * @throws ArgumentError If the 'listener' object in argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
         */
        public function insert(eventName:String, listener:* ):void 
        {
            if ( eventName == null )
            {
                throw new ArgumentError( this + " insert method failed, the 'eventName' value in argument not must be 'null' or 'undefined'.") ;    
            }
            if ( listener == null )
            {
                throw new ArgumentError( this + " insert method failed with the event type '" + eventName + "' failed, the 'listener' object in argument not must be 'null' or 'undefined'.") ;    
            }
            _map.put.apply( this, arguments ) ;
            _dispatcher.registerEventListener( eventName, listener ) ;
        }
        
        /**
         * Adds a new EventListener into an EventListenerBatch in the FrontController.
         * If this <code class="prettyprint">listener</code> argument is 'null' or 'undefined' and if the <code class="prettyprint">eventName</code> argument isn't register with an EventListenerBatch in the FrontController, 
         * an empty EventListenerBatch is created and register in the FrontController with the specified 'eventName'.
         * @param eventName The name of the event type.
         * @param listener (optional) The <code class="prettyprint">EventListener</code> mapped in the FrontController with the specified event type (This listener is added in an EventListenerBatch). 
         * @throws ArgumentError If the 'eventName' value in argument not must be 'null' or 'undefined'.
         */
        public function insertBatch( eventName:String, listener:EventListener ):void
        {
            if ( eventName == null )
            {
                throw new ArgumentError( this + " insertBatch method failed, the 'eventName' value in argument not must be 'null' or 'undefined'.") ;    
            }
            if ( _map.containsKey(eventName) )
            {
                if ( _map.get( eventName ) is EventListenerBatch && listener != null )
                {
                    ( _map.get( eventName ) as EventListenerBatch ).insert( listener ) ;
                    return ;                
                }
            }
            var batch:EventListenerBatch = new EventListenerBatch() ;
            if ( listener != null )
            {
                batch.insert( listener ) ;
            }
            insert( eventName , batch ) ;
        }
        
        /**
         * Indicates if the specified eventlistener registered with the 'eventName' value in argument is an EventListenerBatch instance.
         * @return <code class="prettyprint">true</code> if the specified eventlistener registered with the 'eventName' value in argument is an EventListenerBatch instance.
         */
        public function isEventListenerBatch( eventName:String ):Boolean
        {
            if ( contains( eventName ) )
            {
            	return getListener( eventName ) is EventListenerBatch ;
            }
            else
            {
            	return false ;
            }
        }
        
        /**
         * Remove an entry into the FrontController.
         * @param eventName The name of the event type.
         */
        public function remove(eventName:String):void
        {
            var listener:* = _map.remove( eventName ) ;
            if (listener) 
            {
                _dispatcher.unregisterEventListener(eventName, listener);
            }
        }
        
        /**
         * Removes a global FrontController singleton.
         * @param channel The channel of the FrontController to remove.
         */
        public static function removeInstance( channel:String ):Boolean 
        {
            if (!FrontController.instances.containsKey(channel)) 
            {
                return FrontController.instances.remove(channel) != null ;
            }
            else 
            {
                return false ;
            }
        }
   
        /**
         * Sets the EventDispatcher reference of this FrontController.
         * @param target The EventDispatcher reference of this FrontController.
         */
        public function setEventDispatcher( target:EventDispatcher ):void
        {
            _dispatcher = target ;
        }      
   
        /**
         * Returns the number of elements in the controller.
         * @return the number of elements in the controller.
         */
        public function size():int
        {
            return _map.size() ;
        }
 
        /**
         * Internal EventDispatcher instance.
         */
        private var _dispatcher:EventDispatcher ;
         
        /**
         * The static internal hashmap to register all global instances in your applications.
         */    
        private static var instances:HashMap = new HashMap() ;

        /**
         * Internal HashMap reference.
         */
        private var _map:ArrayMap ;
        
    }
    
}