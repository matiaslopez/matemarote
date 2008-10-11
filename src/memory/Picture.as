package memory
{
	import flash.events.Event;	
	import mx.core.SpriteAsset;
	import mx.core.UIComponent;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Sequence;
	import mx.effects.Zoom;
	import mx.events.FlexEvent;
	import com.adobe.serialization.json.JSON;
	import mx.controls.Alert;
	
	public class Picture extends UIComponent{
		public var level:Level
		public var picId:int
		public var layers:Array
		
		static public var layerValues:Array = [Images.list('marco', 12),
		                                       Images.list('fondo', 13),
		                                       Images.list('sombrilla', 12),
		                                       Images.list('baldes', 2),
		                                       Images.list('estrellas', 10),
		                                       Images.list('personaje', 3),
		                                       Images.list('lentes', 1)]
		
		//Animation
		public var busy:Boolean = false
		public var zoomFade:Parallel
		public var noNoNo:Sequence
		
		public function Picture(newLevel:Level, newId:int, newLayers:Array){
			level = newLevel
			picId = newId
			layers = newLayers
			addEventListener(FlexEvent.CREATION_COMPLETE, init)
			super()
		}
		public function init(e:Event):void{
			/* layers = [marco, fondo, sombrilla, baldes, estrellas, personaje, lentes] */
			
			var bg:SpriteAsset = new Picture.layerValues[1][1]() as SpriteAsset
			var mask_layer:SpriteAsset = new Picture.layerValues[0][layers[0]]() as SpriteAsset
			mask_layer.x = -bg.width/2
			mask_layer.y = -bg.height/2
			mask = mask_layer
			addChild(mask_layer)
			
			for each(var z:int in [1,4,2,5,6,3]){
				//Map the trial description values with the actual spriteasset for each layer.
				if(layers[z] == 0){
					continue
				}
				var layer:SpriteAsset = new Picture.layerValues[z][layers[z]]() as SpriteAsset
				layer.x = -bg.width/2
				layer.y = -bg.height/2
				addChild(layer)
			}
			setupAnimations()
		}
		
		public function setupAnimations():void{
			
			var zoom:Zoom = new Zoom()
			with(zoom){
            	zoomHeightTo = 1.5
            	zoomWidthTo = 1.5
            	duration = 300
   			}
   			var fade:Fade = new Fade()
   			with(fade){
   				alphaTo = 0
   				duration = 300
   			}
   			zoomFade = new Parallel(this)
   			zoomFade.addChild(fade)
   			zoomFade.addChild(zoom)
   			
   			var no1:Move = new Move()
			with(no1){
            	xTo = x+30
            	xBy = 1
            	duration = 100
   			}
   			var no2:Move = new Move()
			with(no2){
            	xTo = x-30
            	xBy = 1
            	duration = 100
   			}
   			var no3:Move = new Move()
			with(no3){
            	xTo = x
            	xBy = 1
            	duration = 100
   			}
   			   			
   			noNoNo = new Sequence(this)
   			with(noNoNo){
            	addChild(no1)
            	addChild(no2)
            	addChild(no3)
   			}
		}
		
		public function reset():void{
			scaleX = 1
			scaleY = 1
			alpha = 1
		}
		
		public function okAnim():void{
			
			if(!zoomFade.isPlaying && !noNoNo.isPlaying){
				if(!parent.getChildIndex(this) < level.pictures.length-1){
					parent.setChildIndex(this, level.pictures.length-1)
				}
				setupAnimations()
				zoomFade.play()
			}
		}
		
		public function errAnim():void{
			if(!zoomFade.isPlaying && !noNoNo.isPlaying){
				setupAnimations()
				noNoNo.play()
			}
		}
		
		public function serialize():Object{
			return {'picId':picId, 'layers':layers}
		}
	}
}