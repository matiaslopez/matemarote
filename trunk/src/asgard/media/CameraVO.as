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
package asgard.media 
{
    import flash.media.Camera;
    import flash.net.registerClassAlias;
    
    import andromeda.vo.SimpleValueObject;    

    /**
     * This value object contains all values to set a Camera object.
     * @author eKameleon
     */
    public class CameraVO extends SimpleValueObject 
    {
	
		/**
		 * Creates a new CameraVO instance.
		 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
		 */
        public function CameraVO( init:Object=null )
		{
            super( init );
        }
        
        /**
         * An integer that specifies the maximum amount of bandwidth the current outgoing video feed can use, in bytes.
         */
        public var bandwidth:int ;
        
        /**
         * Specifies whether to manipulate the width, height, and frame rate if the camera does not have a native mode that meets the specified requirements. 
         * The default value is true, which means that maintaining capture size is favored; 
         * using this parameter selects the mode that most closely matches width and height values, even if doing so adversely affects performance by reducing the frame rate. 
         * To maximize frame rate at the expense of camera height and width, pass false for the favorArea parameter.
         */
        public var favorarea:Boolean = true ;
        
        /**
         * The maximum rate at which you want the camera to capture data, in frames per second.
         */
        public var fps:Number ;
        
        /**
         * The current capture height, in pixels.
         */
        public var height:int ;
        
		/**
		 * A numeric value that specifies the amount of motion required to invoke the activity event.
		 */
        public var level:int ;         
        
        /**
         * An integer specifying the required level of picture quality, as determined by the amount of compression being applied to each video frame.
         */
        public var quality:int ;
		
		/**
		 * A numeric value that specifies the amount of motion required to invoke the activity event.
		 */
        public var motionLevel:int ; 
		 
		 /**
		  * The number of milliseconds between the time the camera stops detecting motion and the time the activity event is invoked.
		  */
    	public var motionTimeout:int ;
    	
    	/**
    	 * The current capture width, in pixels.
    	 */
    	public var width:int ;
     	
     	/**
     	 * Apply this value object in the specified Camera reference.
     	 */
     	public function apply( camera:Camera ):void
     	{
			camera.setQuality( bandwidth , quality ) ;
			camera.setMode( width, height, fps, favorarea ) ;
            camera.setMotionLevel( motionLevel, motionTimeout ) ;     		
     	}
     	
    	/**
	     * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
	     */
    	public static function register( aliasName:String="CameraVO" ):void
    	{
	        registerClassAlias( aliasName , CameraVO ) ;
	    }
	        
    }
}
