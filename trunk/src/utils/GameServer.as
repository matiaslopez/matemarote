package utils
{
	import com.adobe.serialization.json.JSON;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.http.HTTPService;
	
	public class GameServer extends Object
	{
		public function GameServer(){
			super();
		}
		
		static public function call(url:String, success:Function=null, fail:Function=null, data:Object=null):void{
			var service:HTTPService = new HTTPService()
            service.url = url
            service.method = 'POST'
            service.resultFormat = 'text'
            service.send(data)
            if(success != null){
			    function onSuccess(e:ResultEvent):void{
			    	success(JSON.decode(e.result as String))
			    }
	            service.addEventListener(ResultEvent.RESULT, onSuccess)
			}
			if(fail != null){
				function onFail(e:FaultEvent):void{
					fail({})
				}
				service.addEventListener(FaultEvent.FAULT, onFail)
			}
        }
	}
}