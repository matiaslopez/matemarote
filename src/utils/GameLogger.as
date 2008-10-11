package utils {
	import com.adobe.serialization.json.JSON;
	
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import mx.controls.Alert;
    import mx.events.CloseEvent;
	
	public class GameLogger extends Object{
		public var events:Array = []
		public var saveUrl:String
		public var createUrl:String
		public var save_interval:int
		public var closed:Boolean = false
		public var game_id:int
		static public var event_order:Number = 0
		public var flushes:int = 0
		
		public function GameLogger(newCreateUrl:String, newSaveUrl:String, interval:int){
			createUrl = newCreateUrl
			saveUrl = newSaveUrl
			save_interval = interval
			createGame()
		}
	
		public function askRetry(text:String, title:String, onYes:Function=null, onNo:Function=null):void{
			function clickHandler(event:CloseEvent):void {
                if (event.detail==Alert.YES){
                    onYes && onYes()
                }else{
    				onNo && onNo()
                }
            }
			Alert.yesLabel = "Si";
            Alert.noLabel = "No";
            Alert.show(text, title, Alert.YES|Alert.NO, null, clickHandler);
			Alert.yesLabel = "Yes";
            Alert.noLabel = "No";
		}

		public function createGame():void{
			function createError():void{
				askRetry('No se pudo crear el juego, reintentar?', 'Error al crear juego', createGame)
			}
			function createOk(json:Object):void{
				if(json['status'] == 200){
					game_id = json['game_id']
					flushTimeout()
				}else{
					createError()
				}
			}
			GameServer.call(createUrl, createOk, createError)
		}
		public function flushTimeout():void{
			if(!closed){
				setTimeout(function():void{ flush(flushTimeout) }, save_interval)
			}
		}
		
		public function log(kind:String, data:Object=null):void{
			logEvent(new SerializableEvent(kind, data))
		}
		public function logEvent(ev:SerializableEvent):void{
			ev.order = GameLogger.event_order++
			if(!closed){
				events.push(ev)
			}
		}
		
		public function logMouse(e:MouseEvent):void{
			logEvent(new SerializableEvent(e.type, {'local_x':e.localX, 'local_y':e.localY, 'stage_x':e.stageX, 'stage_y':e.stageY}))
		}
		
		public function flush(onFlush:Function=null, onError:Function=null):void{
			if(events.length == 0){
				onFlush && onFlush()
				return
			}
			
			var entries:Array = events.splice(0)
			var log_data:String = ''
			for each(var ev:SerializableEvent in entries){
				GameLogger.event_order++
				log_data += JSON.encode({'time':ev.time, 'type':ev.type,
										 'data':ev.event_data, 'order':ev.order})+'\n'
			}
			function logOk(json:Object):void{
				if(json['status'] == 200){
					onFlush && onFlush()
				}else{
					onError && onError()
					events.splice(0,0,entries)
				}
			}
			function logError(json:Object):void{
				events.splice(0,0,entries)
				onError && onError()
			}
			GameServer.call(saveUrl, logOk, logError, {'game_id': game_id, 'log':log_data})
		}
		
		public function close(onClose:Function=null):void{
			//Flush the log until its empty, call onClose once it is
			closed = true
			function flushOk():void{
				onClose && onClose()
			}
			function flushError():void{
				askRetry("Error inesperado al guardar, reintentar?",
						 "Error al guardar el juego",
						 function():void{ flush(flushOk, flushError) },
						 onClose)
			}
			flush(flushOk, flushError)
		}
	}
}