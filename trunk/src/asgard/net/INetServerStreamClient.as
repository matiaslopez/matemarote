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

	/**
     * This interface provides all callback methods invoked in a NetStream object.
     * @author eKameleon
     */
    public interface INetServerStreamClient 
    {
      	
    	/**
	     * Invoked when an embedded cue point is reached while playing an FLV file.
	     * This method can be overrides easily.
	     */    	
	    function onCuePoint( info:Object ):void ;
      	
      	/**
      	 * Dispatched when Flash Player receives image data as a byte array embedded in a media file that is playing. 
      	 * The image data can produce either JPEG, PNG or GIF content. 
      	 * Use the flash.display.Loader.loadBytes() method to load the byte array into a display object.
      	 */
      	function onImageData( imageData:Object ):void ;
      	
	    /**
	     * Dispatched when the application receives descriptive information embedded in the video being played. 
	     * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.
     	 */
    	function onMetaData(info:Object):void ; 
			    
	    /**
	     * Dispatched when the application receives descriptive information embedded in the video being played. 
	     * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.
	     * @see NetStreamStatus.PLAY_COMPLETE
	     * @see NetStreamStatus.PLAY_SWITCH
     	 */
    	function onPlayStatus(info:Object):void ; 
			    
	    /**
	     * Dispatched when Flash Player receives text data embedded in a media file that is playing. 
	     * The text data is in UTF-8 format and can contain information about formatting based on the 3GP timed text specification. 
	     * This special event is intended for use with Flash Media Server; 
	     * for more information, see the class description. You cannot use the addEventListener() method, or any other EventDispatcher methods, to listen for, or process, this event. 
	     * Rather, you must define a single callback function and attach it directly to the textData object.
	     * <p>This event is triggered after a call to the NetStream.play() method, but before the video playhead has advanced.</p>
	     * <p>The onTextData event object contains one property for each piece of text data.</p>
     	 */
    	function onTextData(textData:Object):void ;	
    	
    }
}
