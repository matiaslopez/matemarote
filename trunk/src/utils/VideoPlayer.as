package utils{
	import mx.core.UIComponent;
	import flash.events.*;
	import flash.errors.IOError;
    import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
    import flash.display.MovieClip;
    import flash.media.SoundMixer;
    import mx.managers.PopUpManager;
	import mx.controls.Button;
	import mx.controls.ProgressBar;
	import mx.events.FlexEvent;
	
	import asgard.display.AVM2Loader;
    	
	public class VideoPlayer extends Object{
		static public function play(parent:UIComponent, url:String, onComplete:Function=null, w:int=0, h:int=0):void{			            
			var container:UIComponent = new UIComponent()
			var video:AVM2Loader = new AVM2Loader()
			var request:URLRequest = new URLRequest(url)

			var loaded:Boolean = false;
            var bar:ProgressBar = new ProgressBar()
            var skip:Button = new Button();
            
			function stopVideo():void{
				try{
					var vid:MovieClip = MovieClip(video.content)
					vid.removeEventListener(Event.ENTER_FRAME, listenVideoEnd)
					vid.stop()
					video.unload()
				}catch(e:Error){}
				PopUpManager.removePopUp(container)
	            onComplete && onComplete()
			}
			function listenVideoEnd(e:Event):void{
				var vid:MovieClip = MovieClip(video.content)
				if(vid.currentFrame == vid.totalFrames){
					stopVideo()
				}
			}
			
            function onLoad(e:Event):void{
            	loaded = true
                container.addChild(video)
                container.removeChild(bar)
            	if(w){ video.content.width = w }
            	if(h){ video.content.height = h }
            	video.x = -video.width/2
            	video.y = -video.height/2
            	video.content.addEventListener(Event.ENTER_FRAME, listenVideoEnd)
            }
            
            function onProgress(e:ProgressEvent):void{
            	bar.setProgress(e.bytesLoaded, e.bytesTotal)
            }
            video.contentLoaderInfo.addEventListener(Event.INIT, onLoad);
            video.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
            video.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event):void{ stopVideo()});
            
            with(bar){
            	label = 'Cargando video...'
            	width = 200	
            	height = 40
            	x = -100
            	y = -20
            }
            with(skip){//Warning: positioned for an 800x600 display
            	label = "Saltar Video"
            		height = 20
            		width = 100
            		x = 280
            		y = 270
            		addEventListener(FlexEvent.BUTTON_DOWN, function():void{stopVideo()})
            }
            container.addChild(skip)
            container.addChild(bar)
            PopUpManager.addPopUp(container, parent, true)
            PopUpManager.centerPopUp(container)
            video.load(request)
        }		
	}
}