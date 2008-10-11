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
package asgard.net 
{
    import flash.media.SoundTransform;
    import flash.net.NetStream;
    
    import asgard.events.SoundEvent;
    
    import system.Reflection;
    import system.Serializable;
    import system.numeric.Mathematics;
    
    import vegas.core.HashCode;
    import vegas.core.IHashable;
    import vegas.core.ILockable;    

    /**
     * The NetServerStream class opens a one-way streaming connection between Flash Player and RTMP server through 
     * a connection made available by a flash.net.NetConnection object or asgard.net.NetServerConnectio object.
 	 * A Stream object is like a channel inside a NetConnection object; this channel can either publish audio and/or video data, 
 	 * using NetStream.publish(), or subscribe to a published stream and receive data, using NetServerStream.play(). 
	 * You can publish or play live (real-time) data and previously recorded data.
     * @author eKameleon
     */
    public class NetServerStream extends NetStream implements IHashable, ILockable, Serializable
    {

		/**
		 * Creates the NetServerStream singleton.
		 * @param connection the NetConnection or NetServerConnection reference of this NetServerStream Object.
		 */
        public function NetServerStream( connection:* )
        {
            super( ( connection is NetServerConnection ) ? ( connection as NetServerConnection ).getNetConnection() : connection ) ;
            this.client = new NetServerStreamClient(this) ;
        }
        
		/**
		 * Returns the percentage of the buffer that is filled.
		 * @return the percentage of the buffer that is filled.
		 */
		public function get bufferPercent():Number
		{
			var p:Number = Mathematics.percentage( bufferLength , bufferTime ) ;
			return isNaN(p) ? 0 : p ;
		}
		
		/**
		 * (read-only) Indicates the duration of the media.
		 * This feature work only if the client property is NetServerStream and the metadaData object is initialize with the duration value, else return 0.
		 */
		public function get duration():Number 
		{
			return _duration ;
		}

		/**
		 * The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). 
		 * A value of 0 represents no panning (balanced center between right and left). 
		 */
		public function get pan():Number
		{
			return soundTransform.pan ;
		}
		
		/**
		 * @private
		 */
		public function set pan( value:Number ):void
		{
            _pan = isNaN(value) ? 0 : value ;
			soundTransform = new SoundTransform( _volume , _pan ) ; 
			_fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
		}		
		
		/**
		 * Returns the percentage progress value of the stream. Using duration and time properties.
		 * @return the percentage progress value of the stream.
		 */
		public function get progress():Number
		{
			var p:Number = Mathematics.percentage( this.time , duration ) ;
            return isNaN(p) ? 0 : p ;
		}
		
		/**
		 * The volume, ranging from 0 (silent) to 1 (full volume). 
		 */
		public function get volume():Number
		{
			return soundTransform.volume ;
		}
		
		/**
		 * @private
		 */
		public function set volume( value:Number ):void
		{
			_volume = Mathematics.clamp( isNaN(value) ? 0 : value , 0, 1) ;
            soundTransform = new SoundTransform( _volume , _pan ) ; 
			_fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
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
		 * Sets the duration of the stream video.
		 */
		public function setDuration( duration:Number ):void
		{
			_duration = duration > 0 ? duration : 0 ; 	
		}	
    
        /**
         * Returns the eden String representation of this object.
         * @return the eden String representation of this object.
         */
        public function toSource( indent:int = 0 ):String 
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
		 * @private
		 */
		private var _duration:Number = 0 ;
		
		/**
		 * @private
		 */
		private var __hashcode__:Number ;		
        		
	    /**
	     * The internal flag to indicates if the display is locked or not.
	     * @private
	     */ 
	    private var ___isLock___:Boolean = false ;
		
        /**
         * @private
         */
        private var _pan:Number =  0 ;		
		
		/**
		 * @private
		 */
		private var _volume:Number = 1 ;
		
		/**
		 * @private
		 */
		private function _fireSoundEvent( type:String ):void
		{
			if ( isLocked() )
			{
				return ;	
			}
			dispatchEvent( new SoundEvent( type, this , soundTransform ) ) ; 
		}		
    }
}

