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
package andromeda.events
{
    import flash.events.Event;
    
    import andromeda.i18n.Lang;
    import andromeda.i18n.Localization;
    
    import vegas.events.BasicEvent;    

    /**
     * The LocalizationEvent is used in the Localization singleton to notify a change.
     * @author eKameleon
     */
    public class LocalizationEvent extends BasicEvent
    {
        
        /**
         * Creates a new LocalizationEvent instance.
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function LocalizationEvent( type:String , target:Localization = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super( type, target, context, bubbles, cancelable, time );
        }
    
        /**
         * The name of the event when the localization is changed.
         * @eventType change
         */  
        public static var CHANGE:String = Event.CHANGE  ;
        
        /**
         * The default singleton name of the Localization singletons.
         */
        public static var DEFAULT_ID:String = "" ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new LocalizationEvent( type , target as Localization, context ) ;
        }
    
        /**
         * Indicates the current Lang value of the internal Localization.
         */
        public function get current():Lang
        {
            var localization:Localization = target as Localization ;
            return ( localization != null ) ? ( target as Localization ).current : null ;
        }

        /**
         * Returns the current <code class="prettyprint">Local</code> reference or the internal value of the Local property passed in argument with the string in argument.
         * @return the current <code class="prettyprint">Local</code> reference or the internal value of the Local property passed in argument with the string in argument.
         */
        public function getLocale( id:String=null ):*
        {
            var localization:Localization = target as Localization ;
            return ( localization != null ) ? localization.getLocale( id ) : null ;
        }
    
        /**
         * Apply the current localization over the specified object.
         * @param o The object to fill with the current localization in the application.
         * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object. 
         * @param callback (optional) The optional method to launch after the initialization over the specified object. 
         */
        public function init( o:Object , sID:String=null , callback:Function=null ):void
        {
            (target as Localization).init( o , sID , callback ) ;
        }
    }
}


