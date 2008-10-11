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
	
	import vegas.data.collections.SimpleCollection;
	import vegas.data.collections.TypedCollection;
	import vegas.data.iterator.Iterator;
	import vegas.util.Copier;
	
	/**
 	 * It handles several <code class="prettyprint">EventListener</code> as one <code class="prettyprint">EventListener</code>.
	 * <p><b>Example : </b></p>
	 * <code class="prettyprint">
	 * 	
	 * import vegas.events.* ;
	 * 
	 * var EVENT_TYPE:String = "onTest" ;
	 * 
	 * var action1:Function = function (e:Event):Void 
	 * {
	 *    trace ( "action1 : " + e.type ) ;
	 * }
	 * 
	 * var action2:Function = function (e:Event):Void 
	 * {
	 *     trace ( "action2 : " + e.type ) ;
	 * }
	 * 
 	 * var oListener1:EventListener = new Delegate(this, action1) ;
	 * var oListener2:EventListener = new Delegate(this, action2) ;
	 * 
	 * var batch:EventListenerBatch = new EventListenerBatch() ;
	 * batch.insert(oListener1) ;
	 * batch.insert(oListener2) ;
	 * 	
	 * var e:Event = new BasicEvent( EVENT_TYPE , this ) ;
	 * 	
	 * EventDispatcher.getInstance().registerEventListener(EVENT_TYPE, batch) ;
	 * EventDispatcher.getInstance().dispatchEvent( e ) ;
	 * </code>
	 */
	public class EventListenerBatch extends TypedCollection implements EventListener
	{
		
		/**
		 * Creates a new EventListenerBatch instance.
	 	 */
		public function EventListenerBatch()
		{
			super(EventListener, new SimpleCollection());
		}

		/**
	 	 * Returns a shallow copy of this instance.
	 	 * @return a shallow copy of this instance.
	 	 */	
		public override function clone():* 
		{
			var b:EventListenerBatch = new EventListenerBatch() ;
			var it:Iterator = iterator() ;
			while (it.hasNext()) 
			{
				b.insert(it.next()) ;
			}
			return b ;
		}

		/**
	 	 * Returns a deep copy of this instance.
	 	 * @return a deep copy of this instance.
	 	 */	
		public override function copy():* 
		{
			var b:EventListenerBatch = new EventListenerBatch() ;
			var it:Iterator = iterator() ;
			while (it.hasNext()) 
			{
				b.insert( Copier.copy(it.next())) ;
			}
			return b ;
		}
		
		/**
		 * Handles the event.
	 	 */
		public function handleEvent(e:Event):void
		{
			var ar:Array = toArray() ;
			var i:int = -1 ;
			var l:uint = ar.length ;
			if (l>0)
			{
				while (++i < l) 
				{ 
					ar[i].handleEvent.call(ar[i], e) ; 
				}
			}
			return ;
		}
		
	}
}