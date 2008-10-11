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
     * The <code class="prettyprint">DateEvent</code> to dispatch an event with a Date object.
     * <pre class="prettyprint">
     * var e:Event = new DateEvent("change", new Date()) ;
     * trace( (e as DateEvent).getDate() ) ;
     * </pre>
     * @author eKameleon
     */
	public class DateEvent extends BasicEvent 
	{
        
		/**
		 * Creates a new <code class="prettyprint">DateEvent</code> instance.
		 * 
		 * @param type the string type of the instance. 
		 * @param date the Date object of this event. 
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 	 */
		public function DateEvent(type : String, date:Date = null ,target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			super(type, target, context, bubbles, cancelable, time) ;
			_date = date ;
		}
        
		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new DateEvent(type, getDate(), target, context) ;
		}
		
        /**
    	 * Returns the Date value.
    	 * @return the Date value.
    	 */
    	public function getDate():Date
	    {
    		return _date ;	
    	}
        
        /**
         * Sets the Date value.
         */
        public function setDate(date:Date):void
        {
            _date = date || null ;	
        }
        
        /**
         * The internal Date value.
         */
		private var _date:Date ;	
        
    }
		
}
