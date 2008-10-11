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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import system.Reflection;
	
	import vegas.core.HashCode;
	import vegas.logging.ILogable;
	import vegas.logging.ILogger;
	import vegas.logging.Log;
	import vegas.util.Serializer;	

	/**
	 * This abstract class provides all basic methods of the EventDispatcher implementation of VEGAS.
	 * @author eKameleon
	 */
	public class AbstractEventDispatcher extends flash.events.EventDispatcher implements IEventDispatcher, ILogable
	{
		
		/**
		 * Creates a new AbstractEventDispatcher instance.
		 */
		public function AbstractEventDispatcher(target:IEventDispatcher = null)
		{
			super( target );
            setLogger() ;
            this.target = (target == null) ? this : target ;
		}

        /**
         * Indicates the optional target reference of the instance.
         */
        public var target:IEventDispatcher ;		
 		
 		/**
 		 * Dispatches an event into the event flow.
		 * @param event The Event object that is dispatched into the event flow (a String or an Event object).
		 * @param target the target of the event.
		 * @param context the context of the event.
 		 */
 		public function fireEvent( event:* , target:*=null, context:*=null , bubbles:Boolean=false ):Boolean
 		{
 			if ( event is String )
 			{
				return super.dispatchEvent( new BasicEvent( event as String, target, context ) ); 				
 			}
 			else if ( event is Event )
 			{
 				if ( event is BasicEvent )
 				{
 					if ( target != null )
 					{
 						event.target = target ;
 					}
 					if ( context != null )
 					{
 						event.context = context ;	
 					}
 				}
 				return super.dispatchEvent( event ) ;
 			}
 			else
 			{
 				return false ;	
 			}
 		}
 
        /**
         * Returns the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
         * @return the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
         */
        public function getLogger():ILogger
        {
            return _logger ;     
        }
 		
		/**
		 * Returns a hashcode value for the object.
		 * @return a hashcode value for the object.
		 */
		public function hashCode():uint 
		{
			if ( isNaN( __hashcode__ ) ) 
			{
				__hashcode__ = HashCode.next() ;
			}
			return __hashcode__ ;
		}
		
        /**
         * Registers an <code class="prettyprint">EventListener</code> object with an EventDispatcher object so that the listener receives notification of an event.
         */
        public function registerEventListener( type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
        {    
            var func:Function ;
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = EventListener(listener).handleEvent ;
            }
            super.addEventListener(type, func, useCapture, priority, useWeakReference) ;
        }

        /**
         * Sets the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
         */
        public function setLogger( log:ILogger=null ):void 
        {
            _logger = ( log == null ) ? Log.getLogger( Reflection.getClassPath(this) ) : log ;
        }
        
        /**
         * Returns a string representing the source code of the EventDispatcher object.
         */
        public function toSource( indent:int = 0 ):String  
        {
        	var args:Array = [] ;
        	if ( target != null )
        	{
        		args.push( target ) ;
        	}
            return Serializer.getSourceOf( this , args ) ; 
        }        

        /**
         * Returns a string representing the specified EventDispatcher object (ECMA-262).
         * @return a string representing the specified EventDispatcher object (ECMA-262).
         */
        public override function toString():String 
        {
            return "[" + Reflection.getClassName(this) + "]" ;
        }
        
        /**
         * Removes an <code class="prettyprint">EventListener</code> from the EventDispatcher object.
         */
        public function unregisterEventListener(type:String, listener:*, useCapture:Boolean = false):void 
        {
            var func:Function ;
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = (listener as EventListener).handleEvent ;
            }
            super.removeEventListener(type, func, useCapture) ;
        }        

		/**
		 * @private
		 */
		private var __hashcode__:Number = NaN ;

        /**
         * The internal ILogger reference of this object.
         */
        private var _logger:ILogger ;
		
	}
}
