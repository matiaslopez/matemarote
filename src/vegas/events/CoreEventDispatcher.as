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
    
    import system.Reflection;
    
    import vegas.core.CoreObject;
    import vegas.core.ILockable;	

    /**
 	 * This abstract class is used to create concrete <code class="prettyprint">IEventDispatcher</code> implementations. This class used an internal <code class="prettyprint">EventDispatcher</code> object by composition.
 	 * <p>You can overrides the internal <code class="prettyprint">EventDispatcher</code> instance with the <code class="prettyprint">initEventDispatcher</code> or the <code class="prettyprint">setEventDispatcher</code> methods. Used a global singleton reference in this method to register all events in a <code class="prettyprint">FrontController</code> for example.</p>
	 * @author eKameleon
 	 */
	public class CoreEventDispatcher extends CoreObject implements IEventDispatcher, ILockable
    {

		/**
		 * Creates a new CoreEventDispatcher.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
        public function CoreEventDispatcher( bGlobal:Boolean = false , sChannel:String = null ) 
        {
    		setGlobal( bGlobal , sChannel ) ;	
        }
        
        /**
         * Indicates the channel of this dispatcher if this instance is global.
         * #see isGlobal
         * #see setGlobal
         */
        public function get channel():String
        {
            return 	_isGlobal ? _dispatcher.getName() : null ;
        }
       
		/**
		 * (read-only) Returns the value of the isGlobal flag of this model. Use the <code class="prettyprint">setGlobal</code> method to modify this value.
		 * @return <code class="prettyprint">true</code> if the instance use a global EventDispatcher to dispatch this events.
		 */
		public function get isGlobal():Boolean 
		{
			return getIsGlobal() ;
		}
        
		/**
		 * Allows the registration of event listeners on the event target.
		 * @param type A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
		 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <code class="prettyprint">EventListener</code> interface.
	 	 * @param useCapture Determinates if the event flow use capture or not.
		 * @param priority Determines the priority level of the event listener.
		 * @param useWeakReference Indicates if the listener is a weak reference.
		 */
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener( type, listener, useCapture, priority, useWeakReference ) ;
        }

		/**
		 * Dispatches an event into the event flow.
		 * @param event The Event object that is dispatched into the event flow.
		 * @return <code class="prettyprint">true</code> if the Event is dispatched.
		 */
        public function dispatchEvent( event:Event ):Boolean
        {
            return _dispatcher.dispatchEvent( event ) ;
        }
 
	 	/**
		 * Returns the internal <code class="prettyprint">EventDispatcher</code> reference.
		 * @return the internal <code class="prettyprint">EventDispatcher</code> reference.
		 */
     	public function getEventDispatcher():EventDispatcher 
     	{
	    	return _dispatcher ;
	    }
  	
		/**
		 * Returns the value of the isGlobal flag of this model.
		 * @return <code class="prettyprint">true</code> if the instance use a global EventDispatcher to dispatch this events.
	 	 */
		public function getIsGlobal():Boolean 
		{
			return _isGlobal ;
		}
 
 		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
		 */ 
        public function hasEventListener(type:String):Boolean
        {
            return _dispatcher.hasEventListener(type) ;
        }

		/**
		 * Creates and returns the internal <code class="prettyprint">EventDispatcher</code> reference (this method is invoked in the constructor).
		 * You can overrides this method if you wan use a global <code class="prettyprint">EventDispatcher</code> singleton.
		 * @return the internal <code class="prettyprint">EventDispatcher</code> reference.
	 	 */
       	public function initEventDispatcher():EventDispatcher 
       	{
		    return new EventDispatcher( this ) ;
	    }

   		/**
	     * Returns <code class="prettyprint">true</code> if the object is locked.
	     * @return <code class="prettyprint">true</code> if the object is locked.
	     */
    	public function isLocked():Boolean 
    	{
	        return ___isLock___ ;
    	}

	    /**
	     * Locks the object.
	     */
    	public function lock():void 
    	{
	        ___isLock___ = true ;
	    }

		/**
		 * Allows the registration of event listeners on the event target (Function or EventListener).
		 * @param type A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
		 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <code class="prettyprint">EventListener</code> interface.
	 	 * @param useCapture Determinates if the event flow use capture or not.
		 * @param priority Determines the priority level of the event listener.
		 * @param useWeakReference Indicates if the listener is a weak reference.
		 */
        public function registerEventListener(type:String, listener:*, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }

		/** 
		 * Removes a listener from the EventDispatcher object.
		 * If there is no matching listener registered with the <code class="prettyprint">EventDispatcher</code> object, then calling this method has no effect.
		 * @param type Specifies the type of event.
		 * @param the listener object.
		 */
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        } 

		/**
		 * Sets the internal <code class="prettyprint">EventDispatcher</code> reference.
		 */
		public function setEventDispatcher( e:EventDispatcher ):void 
		{
			_dispatcher = e || initEventDispatcher() ;
		}

		/**
		 * Sets if the instance use a global <code class="prettyprint">EventDispatcher</code> to dispatch this events, if the <code class="prettyprint">flag</code> value is <code class="prettyprint">false</code> the instance use a local EventDispatcher.
		 * @param flag the flag to use a global event flow or a local event flow.
		 * @param channel the name of the global event flow if the <code class="prettyprint">flag</code> argument is <code class="prettyprint">true</code>.  
		 */
		public function setGlobal( flag:Boolean=false , channel:String=null ):void 
		{
			_isGlobal = (flag == true) ;
			setEventDispatcher( _isGlobal ? EventDispatcher.getInstance( channel ) : null ) ;
		}

		/**
		 * Returns the string representation the source code of the object.
		 * @return the string representation the source code of the object.
		 */
        public override function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "()" ;
        }

	    /**
	     * Unlocks the display.
	     */
    	public function unlock():void 
    	{
	        ___isLock___ = false ;
	    }

		/** 
		 * Removes a listener (Function or EventListener object) from the EventDispatcher object.
		 * If there is no matching listener registered with the <code class="prettyprint">EventDispatcher</code> object, then calling this method has no effect.
		 * @param type Specifies the type of event.
		 * @param the listener object.
		 */
        public function unregisterEventListener(type:String, listener:*, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        }

		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		 * This method returns <code class="prettyprint">true</code> if an event listener is triggered during any phase of the event flow when an event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
		 * @return A value of <code class="prettyprint">true</code> if a listener of the specified type will be triggered; <code class="prettyprint">false</code> otherwise.
		 */
        public function willTrigger(type:String):Boolean
        {
            return _dispatcher.willTrigger(type) ;
        }

		/**
		 * The internal EventDispatcher reference.
		 */
    	private var _dispatcher:EventDispatcher ;  
    
    	/**
	 	 * The internal flag to indicate if the event flow is global.
		 */
		private var _isGlobal:Boolean ;
    	
    	/**
     	 * The internal flag to indicates if the display is locked or not.
     	 */ 
    	private var ___isLock___:Boolean = false ;
    	
    }
}