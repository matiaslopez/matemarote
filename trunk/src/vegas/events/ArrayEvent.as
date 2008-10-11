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
    
    import flash.events.Event ;
    
    /**
     * The <code class="prettyprint">ArrayEvent</code> to dispatch an event with an Array object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var e:Event = new ArrayEvent("change", [2, 3, 4]) ;
     * trace( (e as ArrayEvent).getArray() ) ;
     * </pre>
     * @author eKameleon
     */
	public class ArrayEvent extends BasicEvent 
	{
        
		/**
		 * Creates a new <code class="prettyprint">ArrayEvent</code> instance.
		 * @param type the string type of the instance. 
		 * @param ar the array object of this event. 
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 	 */
		public function ArrayEvent(type : String, ar:Array = null ,target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			super(type, target, context, bubbles, cancelable, time) ;
			_ar = ar ;
		}
        
		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new ArrayEvent( type, getArray(), target, context) ;
		}
		
        /**
    	 * Returns the array instance.
    	 * @return the array instance.
    	 */
    	public function getArray():Array
	    {
    		return _ar ;	
    	}
        
        /**
         * Sets the array instance.
         */
        public function setArray(ar:Array):void
        {
            _ar = ar ;	
        }
        
        /**
         * The internal array instance.
         */
		private var _ar:Array ;	
        
    }
		
}
