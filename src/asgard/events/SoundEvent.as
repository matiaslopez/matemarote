/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.events
{
    import flash.events.Event;
    import flash.media.SoundTransform;
    
    import asgard.media.CoreSound;
    
    import vegas.events.BasicEvent;    

    /**
     * Flash® Player dispatches a SoundEvent object when the user changes the sound by either moving the handle of the volumeBar control or setting the volume or soundTransform property. 
     * @author eKameleon
     */
    public class SoundEvent extends BasicEvent
    {
        
        /**
          * Creates a new SoundEvent instance.
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param soundTransform Indicates new values for volume and panning.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function SoundEvent( type:String , target:*=null , soundTransform:SoundTransform=null , context:*=null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super( type, target, context, bubbles, cancelable, time );
            _soundTransform = soundTransform ;
        }
    
        /**
         * The name of the event when the localization is changed.
         */
        public static var SOUND_UPDATE:String = "soundUpdate"  ;
        
        /**
         * Defines the value of the type property of a soundUpdate event object.
         */
        public function get soundTransform():SoundTransform
        {
            if ( _soundTransform != null )
            {
                return _soundTransform ;    
            }
            else if ( target is CoreSound )
            {
                if ( target.channel != null )
                {
                    return target.channel.soundTransform ;
                }
            }
            return null ;
        } 

        /**
          * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new SoundEvent( type , target , soundTransform, context ) ;
        }
        
        /**
         * @private
         */
        private var _soundTransform:SoundTransform ;

    }

}