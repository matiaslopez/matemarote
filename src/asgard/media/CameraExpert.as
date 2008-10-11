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
    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    import flash.media.Camera;
    
    import andromeda.model.AbstractModel;
    
    import asgard.events.CameraExpertEvent;
    
    import vegas.data.map.HashMap;    

    /**
     * This expert manage all Camera reference in the application.
     * @author eKameleon
     */
    public class CameraExpert extends AbstractModel 
    {

		/**
		 * Creates a new CameraExpert instance.
		 * @param id the id of the model.
		 * @param name Specifies which camera to get, as determined from the array returned by the names property. For most applications, get the default camera by omitting this parameter.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
        public function CameraExpert( id:* = null , name:String=null , bGlobal:Boolean = false, sChannel:String = null )
        {
            
            super( id , bGlobal, sChannel );
            
            _camera = Camera.getCamera(name) ;
            _camera.addEventListener( ActivityEvent.ACTIVITY , _onCameraActivity ) ;
            _camera.addEventListener( StatusEvent.STATUS     , _onCameraStatus ) ;
        
        }
	
		/**
	 	 * The default camera mode favor area value.
		 */
		public static var DEFAULT_CAMERA_MODE_FAVOR_AREA:Boolean = true ;
			
		/**
		 * The default camera mode fps value.
		 */
		public static var DEFAULT_CAMERA_MODE_FPS:Number = 24 ;
			
		/**
		 * The default camera mode height value.
		 */
		public static var DEFAULT_CAMERA_MODE_HEIGHT:Number = 120 ;
		
		/**
		 * The default camera mode width value.
	 	 */
		public static var DEFAULT_CAMERA_MODE_WIDTH:Number = 160 ;
			
		/**
		 * The default camera motion level.
		 */
		public static var DEFAULT_CAMERA_MOTION_LEVEL:Number = 50 ;
		
		/**
		 * The default camera motion timeout.
		 */
		public static var DEFAULT_CAMERA_MOTION_TIMEOUT:Number = 2000 ;
		
		/**
		 * The default camera quality bandwidth.
		 */
		public static var DEFAULT_CAMERA_QUALITY_BANDWIDTH:Number = 16384 ;
		
		/**
		 * The default camera quality level.
		 */
		public static var DEFAULT_CAMERA_QUALITY_LEVEL:Number = 0 ;        
     
		/**
		 * Returns {@code true} if the CameraExpert contains the specified camera id.
		 * @return {@code true} if the CameraExpert contains the specified camera id.
	 	 */
		public static function contains( id:*  ):Boolean
		{
			return _map.containsKey( id ) ;	
		}     
    	 
		/**
		 * Returns the Camera client reference.
		 * @return the Camera client reference.
	 	*/
		public function get camera():Camera
		{
			return _camera ;
		}
		
		/**
		 * Indicates if the expert use verbose debug mode or not.
		 */
		public var verbose:Boolean = true ;

		/**
		 * Returns and creates a CameraExpert singleton.
		 * @param id the id of the CameraExpert singleton to creates or returns.
		 * @param name (optional) this String defines the name of the Camera to use in the specified expert.
		 * This argument is used only the first time when the specifiec CameraExpert is created. To get the default camera (which is recommended for most applications), omit this parameter.
		 * @return a CameraExpert singleton or null .
		 */
		public static function getInstance( id:*=null , name:String=null ):CameraExpert
		{
			if ( id == null )
			{
				throw new ArgumentError( "CameraExpert.getInstance() failed, the 'id' passed-in argument not must be 'null' or 'undefined'.") ;
            }
			if ( _map == null)
			{
				_map = new HashMap() ;	
			}
			if ( !_map.containsKey( id ) )
			{
				_map.put( id , new CameraExpert( id , name ) ) ;
			}
			return _map.get( id ) as CameraExpert ;
		}

		/**
		 * This method is invoked in the constructor of the class to initialize all event types.
		 */
		public function initEvent():void
		{
			_sTypeActivity = ActivityEvent.ACTIVITY ;	
			_sTypeMuted    = CameraExpertEvent.MUTED ;
			_sTypeUnmuted  = CameraExpertEvent.UNMUTED ;
		}
		
		/**
		 * Release the specified singleton CameraExpert instance.
		 * @param id The id of the CameraExpert to remove.
		 */
		public static function releaseInstance( id:* ):CameraExpert
		{
			if ( _map.containsKey( id ) )
			{
				return _map.remove( id ) ;
			}
			else
			{
				return null ;
			}
		}		

		/**
		 * Sets the event name when the Camera activity change.
		 */
		public function setEventTypeACTIVITY(type:String ):void
		{
			_sTypeActivity = type || ActivityEvent.ACTIVITY ;		
		}

		/**
		 * Sets the event name when the Camera is muted.
		 */
		public function setEventTypeMUTED( type:String ):void
		{
			_sTypeMuted = type || CameraExpertEvent.MUTED ;		
        }
	
		/**
		 * Sets the event name when the Camera is unmuted.
		 */
		public function setEventTypeUNMUTED( type:String ):void
		{
			_sTypeUnmuted = type || CameraExpertEvent.UNMUTED ;	
		}
		
		/**
		 * Sets the camera capture mode to the native mode that best meets the specified requirements. 
		 * If the camera does not have a native mode that matches all the parameters you pass, Flash selects a capture mode that most closely synthesizes the requested mode. 
		 * This manipulation may involve cropping the image and dropping frames.
		 * <p>By default, Flash drops frames as needed to maintain image size. To minimize the number of dropped frames, even if this means reducing the size of the image, pass false  for the favorArea parameter.</p>
		 * @param width The requested capture width, in pixels. The default value is 160.
		 * @param height The requested capture height, in pixels. The default value is 120.
		 * @param fps The requested rate at which the camera should capture data, in frames per second. The default value is 15.
		 * @param favorArea Specifies whether to manipulate the width, height, and frame rate if the camera does not have a native mode that meets the specified requirements. The default value is true, which means that maintaining capture size is favored; using this parameter selects the mode that most closely matches width and height values, even if doing so adversely affects performance by reducing the frame rate. To maximize frame rate at the expense of camera height and width, pass false for the favorArea parameter.
		 */
		public function setMode( width:int=160, height:int=120 , fps:Number=24 , favorArea:Boolean=true ):void
		{
			if ( verbose )
			{
				getLogger().info( this + " setMotionLevel({0},{1},{2},{3})" , width, height, fps, favorArea ) ;
			}
			_camera.setMode( width , height, fps, favorArea ) ;		
		}
		
		/**
		 * Specifies how much motion is required to dispatch the activity event. 
		 * Optionally sets the number of milliseconds that must elapse without activity before Flash considers motion to have stopped and dispatches the event.
		 * @param motionLevel Specifies the amount of motion required to dispatch the activity event. Acceptable values range from 0 to 100. The default value is 50.
		 * @param timeout Specifies how many milliseconds must elapse without activity before Flash considers activity to have stopped and dispatches the activity event. The default value is 2000 milliseconds (2 seconds).
		 */
		public function setMotionLevel( motionLevel:int=50 , timeout:int = 2000 ):void
		{
			if ( verbose )
			{
				getLogger().info( this + " setMotionLevel({0},{1})" , motionLevel, timeout ) ;
			}
			_camera.setMotionLevel( motionLevel , timeout ) ;	
		}
		
		/**
		 * Sets the maximum amount of bandwidth per second or the required picture quality of the current outgoing video feed.
		 * This method is generally applicable only if you are transmitting video using Flash Media Server.
		 * @param bandwidth Specifies the maximum amount of bandwidth that the current outgoing video feed can use, in bytes per second. To specify that Flash video can use as much bandwidth as needed to maintain the value of quality, pass 0 for bandwidth. The default value is 16384.
		 * @param quality An integer that specifies the required level of picture quality, as determined by the amount of compression being applied to each video frame. Acceptable values range from 1 (lowest quality, maximum compression) to 100 (highest quality, no compression). To specify that picture quality can vary as needed to avoid exceeding bandwidth, pass 0 for quality.
		 */
		public function setQuality( bandwidth:int=16384 , quality:int=0 ):void
		{
			if ( verbose )
			{
				getLogger().info( this + " setQuality({0},{1})" , bandwidth, quality ) ;
			}
			_camera.setQuality( bandwidth , quality ) ;
		}
		
		/**
		 * Updates the Camera setting.
		 */
		public function updateCamera( vo:CameraVO = null ):void
		{
			if ( vo == null )
			{
				vo = new CameraVO() ;	
			}
			vo.apply( camera ) ;
        }		

		/**
		 * @private
		 */
		private var _camera:Camera ;
		
		/**
		 * @private
		 */
		private static var _map:HashMap  ;     
        
		/**
		 * @private
		 */		
		private var _sTypeActivity:String ;
	
		/**
		 * @private
		 */
		private var _sTypeMuted:String ;
		
		/**
		 * @private
		 */
		private var _sTypeUnmuted:String ;        
     
		/**
		 * Invoked when the camera starts or stops detecting sound.
		 */
		public function _onCameraActivity( e:ActivityEvent ):void
		{
			if ( verbose )
			{
				getLogger().info( this + " activity:"  + e.activating ) ;
			}
            var ev:CameraExpertEvent = new CameraExpertEvent(_sTypeActivity , this ) ;
            ev.activating = e.activating ;
            dispatchEvent( ev ) ;
        }

		/**
		 * Invoked when the camera status change.
		 */
		private function _onCameraStatus( e:StatusEvent ):void
		{
			var code:String = e.code ;
			if ( verbose )
			{
				getLogger().info( this + " camera status, code:" + code + " level:" + e.level ) ;
			}
			switch( code )
			{
				case CameraStatus.MUTED :
				{
					dispatchEvent( new CameraExpertEvent( _sTypeMuted, this ) ) ;
                    break ;
				}	
				case CameraStatus.UNMUTED :
				{
					dispatchEvent( new CameraExpertEvent( _sTypeUnmuted, this ) ) ;
					break ;	
				}
			}
		}     
        
    }
}
