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

package vegas.events.dom
{
	import vegas.core.CoreObject;
	import vegas.events.EventListener;
	
	[ExcludeClass]
	
	/**
     * Internal class in the <code class="prettyprint">EventDispatcher</code> class to register in an <code class="prettyprint">EventCollection</code> an <code class="prettyprint">EventListener</code>.
     * @author eKameleon
     * @see EventListenerCollection
     * @see EventListenerComparator
     */
	internal class EventListenerContainer extends CoreObject
	{
		
		/**
	     * Creates a new EventListenerContainer instance.
	     * @param listener an <code class="prettyprint">EventListener</code>
	     */	
		public function EventListenerContainer( listener:EventListener )
		{
			super();
			_listener = listener ;
		}

	    /**
	     * Determinates if the listener use capture flow event or not.
	     */	
		public var useCapture:Boolean ;

	    /**
    	 * Enables the auto remove option in the EventListener.
    	 * @param enable a boolean to indicated if the EventListener is autoRemove at the end of the event flow.
	    */
		public function enableAutoRemove(enable:Boolean):void 
		{
        	_autoRemove = enable;
	    }

	    /**
	     * Returns the priority of the <code class="prettyprint">EventListener</code>. This priority is used in the <code class="prettyprint">EventListenerComparator</code>.
	     * @return the priority of the <code class="prettyprint">EventListener</code>. This priority is used in the <code class="prettyprint">EventListenerComparator</code>.
	     * @see EventListenerComparator
	     */
		public function getPriority():uint 
		{
			return _priority || 0 ;
		}

        /**
         * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">EventListener</code> is auto remove at the end of the event flow.
         * @return <code class="prettyprint">true</code> if the <code class="prettyprint">EventListener</code> is auto remove at the end of the event flow.
         */
	    public function isAutoRemoveEnabled():Boolean 
	    {
     	   return _autoRemove;
	    }

	    /**
	     * Returns the <code class="prettyprint">EventListener</code> reference.
	     * @return the <code class="prettyprint">EventListener</code> reference.
	     */
	    public function getListener():EventListener 
	    {
    	    return _listener ;
	    }
    
        /**
         * Sets the priority of the <code class="prettyprint">EventListener</code>.
         */
		public function setPriority(n:uint=0):void
		{
			_priority = n ;
		}

		private var _autoRemove:Boolean = false ;
	    private var _listener:EventListener = null ;
		private var _priority:uint ;
		
	}
	
}