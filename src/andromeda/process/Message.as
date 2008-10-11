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
package andromeda.process
{
    
    /**
     * This <code class="prettyprint">IAction</code> object create a pause in the process.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.events.ActionEvent ;
     * 
     * var handleEvent:Function = function( e:ActionEvent ) :void
     * {
     *     trace( e ) ;
     * }
     * 
     * var m:Message = new Message("hello world", "happy", 10, true) ;
     * m.addEventListener( ActionEvent.START  , handleEvent ) ;
     * m.addEventListener( ActionEvent.FINISH , handleEvent ) ;
     * m.run() ;
     * </pre>
     * @author eKameleon
     */
    public class Message extends Pause
    {
        
        /**
         * Creates a new Message instance.
         * @param message The message to notify when the pause if finished.
         * @param face The optional face value of this message.
         * @param duration the duration of the pause.
         * @param seconds the flag to indicates if the duration is in second or not.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function Message( message:String , face:String = null, duration:Number = 0 , seconds:Boolean = false , to:* = null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super(duration, seconds, bGlobal, sChannel) ;
            this.message = message ;
            this.face    = face    ;
            this.to      = to      ;
        }
        
        /**
         * Determinates a value to send the message in the local application.
         */
        public static const ME:Number = 0 ;
        
        /**
         * Determinates a value to send the message to all users.
         */
        public static const ALL:Number = 1 ;
        
        /**
         * The message value.
         */
        public var message:String ;
        
        /**
         * An optional face value.
         */
        public var face:String ;
        
        /**
         * An optional to value.
         */
        public var to:* ;

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new Message(message, face, duration, useSeconds, to) ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public override function toString():String 
        {
            var txt:String = "[Message duration:" + duration + (useSeconds ? "s" : "ms") ;
            
            if ( message != null && message.length > 0 ) 
            {
                txt += " message:" + message ;
            }
            
            if (face != null && face.length > 0)
            {
                txt += " face:" + face ;
            }
            
            if (this.to != null)
            {
                txt += " to:" + this.to ;
            } 
            
            txt += "]" ;
            return txt ;
            
        }

    }

}