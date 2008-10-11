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
    import vegas.data.map.ArrayMap;        						

    /**
    * Stores the listeners object an notifies them with the DOM Events level 2/3 of the W3C.
    * The EventDispatcher class implements the IEventDispatcher interface. 
    * This object allows any object to be an <code class="prettyprint">EventTarget</code>.
    * <p><b>Thanks</b>:</p>
    * <p><code class="prettyprint">EventDispatcher</code> is an AS2 port of the <b>Java.schst.net EventDispatcher</b>. Inspired by the NotificationCenter of Apple's Cocoa-Framework.
    * <li>EventDispatcher JAVA : Stephan Schmid - http://schst.net/</li><li>Cocoa-Framework : http://developer.apple.com/cocoa/</li><li>Notification center : http://developer.apple.com/documentation/Cocoa/Conceptual/Notifications/index.html</li>
    * </p>
    * @author eKameleon
    */
    public class EventDispatcher extends AbstractEventDispatcher implements IEventDispatcher
    {
        
        /**
         * Aggregates an instance of the EventDispatcher class.
         */
        public function EventDispatcher( target:IEventDispatcher = null )
        {
            super( target );
        }
 
        /**
         * Determinates the default singleton name.
         */
        public static const DEFAULT_SINGLETON_NAME:String = "__default__" ;
        
        /**
         * Registers an <code class="prettyprint">EventListener</code> object with an EventDispatcher object so that the listener receives notification of an event.
         */
        VEGAS function addEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {    
            registerEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }
        
        /**
         * Indicates if the specified singleton reference is register.
         * @return <code class="prettyprint">true</code> If the specified singleton reference is register.
         */
        public static function containsInstance( name:String ):Boolean
        {
        	return instances.containsKey( name ) ;
        }
        
        /**
         * Clear all globals EventDispatcher instances.
         */
        public static function flush():void 
        {
            instances.clear() ;
        }

        /**
         * Creates and returns a singleton EventDispatcher reference specified by the passed-in name identifier.
         * @param name The name of the singleton reference to return or create (If this value is Null, the DEFAULT_SINGLETON_NAME static value is used).
         * @return The singleton EventDispatcher reference specified by the passed-in name identifier.
         */
        public static function getInstance( name:String=null ):vegas.events.EventDispatcher
        {
            
            if (name == null) 
            {
                name = DEFAULT_SINGLETON_NAME ;
            }
            
            if (! instances.containsKey(name)) 
            {
            	var dispatcher:vegas.events.EventDispatcher = new vegas.events.EventDispatcher( null ) ;
            	dispatcher.setName(name) ;
                instances.put(name, dispatcher ) ;
            }

            return vegas.events.EventDispatcher(instances.get(name)) ;
            
        }
 
        /**
         * Returns the name of the display.
         * @return the name of the display.
         */
        public function getName():String
        {
            return _sName || null ;
        }

        /**
         * Registers an <code class="prettyprint">EventListener</code> object with an EventDispatcher object so that the listener receives notification of an event.
         */
        VEGAS function removeEventListener( type:String, listener:*, useCapture:Boolean = false ):void
        {    
            unregisterEventListener( type, listener, useCapture ) ;
        }

        /**
         * Removes a global EventDispatcher instance.
         */
        public static function removeInstance(name:String=null):Boolean 
        {
            if (name == null) name = vegas.events.EventDispatcher.DEFAULT_SINGLETON_NAME ;
            if ( instances.containsKey(name) ) 
            {
                return instances.remove(name) != null ;
            }
            else 
            {
                return false ;
            }
        }
        
		/**
		 * Internal method to sets the name of the instance.
	 	 */
		public function setName( name:String ):void 
		{
			_sName = name ;
		}
        
        /**
         * @private
         */    
        private static var instances:ArrayMap = new ArrayMap() ;

        /**
         * @private
         */ 
        private var _sName:String = null ;

    }
    
}