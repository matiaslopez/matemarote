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
	import flash.events.Event;
	
	import system.Reflection;
	
	import vegas.core.CoreObject;
	import vegas.data.iterator.Iterable;
	import vegas.data.iterator.Iterator;
	import vegas.data.list.SortedArrayList;
	import vegas.events.EventListener;    
    
    [ExcludeClass]
    
	/**
     * Internal class used in the EventDispatcher to collect <code class="prettyprint">EventListener</code> for a specific event type.  
     * @author eKameleon
     */
	internal class EventListenerCollection extends CoreObject implements Iterable
	{
		
	    /**
	     * Creates a new EventListenerCollection instance.
	     */
		public function EventListenerCollection( )
		{
			_list = new SortedArrayList() ;
			_list.comparator = EventListenerComparator.getInstance() ;
			_list.options = Array.NUMERIC ;
		}
		
	    /**
	     * Adds an <code class="prettyprint">EventListener</code> in the collection 
	     * @param listener the EventListener in the collection
	     * @param autoRemove this EventListener is autoRemove when the event flow is finished.
	     * @param priority the priority value of the EventListener.
	     * @return The new size of the collection.
	     */
        public function addListener( listener:EventListener, autoRemove:Boolean, priority:uint ):uint 
		{
			var container:EventListenerContainer = new EventListenerContainer(listener) ;
			container.enableAutoRemove(autoRemove) ;
			container.setPriority(priority) ;
			_list.insert(container) ;
			return _list.size() ;
		}

	    /**
	     * Returns the iterator of this collection.
	     * @return the iterator of this collection.
	     */
		public function iterator():Iterator
		{
			return _list.iterator() ;
		}
	
	    /**
	     * Propagates an event in the event flow of all <code class="prettyprint">EventListener</code> in this collection.
	     */
		public function propagate( e:DomEvent ):Event 
		{
			var remove:Array = new Array() ;
			var l:uint = _list.size() ;
			for (var i:Number = 0 ; i<l ; i++) 
			{
				
				if (e["stop"] == EventPhase.STOP_IMMEDIATE) 
				{
				    break ;
				}
				
				var container:EventListenerContainer = _list.get(i) ;
			
				// handle the event to Eventlistener !!
				container.getListener().handleEvent(e) ;
				
				if (container.isAutoRemoveEnabled()) 
				{
					remove.push(container.getListener()) ;
				}
			
				if (e.isCancelled()) 
				{
					break ;
				}
			
			}
			// remove all autoRemove listeners
			l = remove.length ;
			if (l > 0)
			{
				 while (--l > -1) 
				 {
				 	removeListener(remove[l]) ;
				 }
			}
			return e ;
		}

	    /**
	     * Removes an <code class="prettyprint">EventListener</code> in the collection.
	     * @return the EventListenerContainer of the listener removes in the collection.
	     */
		public function removeListener( listener:* ):EventListenerContainer 
		{
			var it:Iterator ;
			var container : EventListenerContainer ;
            if ( listener is EventListener ) 
			{
				it = _list.iterator() ;
				while(it.hasNext()) 
				{
					container = it.next() ;
					if (container.getListener() == listener) 
					{
						_list.remove(container) ;
						return container ;
					}
				}
			}
			else if ( listener is uint ) 
			{
			
				return _list.removeAt( listener ) ;
			
			} 
			else if ( listener is String)  // constructorName
			{
				it = _list.iterator() ;
				var constructorName:String ;
				while(it.hasNext()) 
				{
					container = it.next() ;
					constructorName = Reflection.getClassName(container) ;
					if (constructorName == listener) 
					{
						_list.remove(container) ;
						return container ;
					}
				}
			
			}
			return null ;
		}

		/**
	     * Returns the number of <code class="prettyprint">EventListener</code> in this collection.
	     * @return the number of <code class="prettyprint">EventListener</code> in this collection.
	     */
		public function size():uint 
		{
			return _list.size() ;
		}

	    private var _list:SortedArrayList  ;

	}	
	
}