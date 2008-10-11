// ActionScript file
package memory {
	public class Utils extends Object{
		static public function shuffled(orig:Array):Array{
			var copy:Array = []
			for each(var o:Object in orig){
				copy.push(o)
			}
			copy.sort(function():int{ return Math.random() < 0.5 ? -1 : 1})
			return copy
		}
		
		static public function dirtyRandom(orig:Array):void{
			//makes sure all pieces changed place
			var copy:Array = []
			for each(var o:Object in orig){
				copy.push(o)
			}
			
			for(var i:int = 0; i < orig.length; i++){
				var last_idx:int = copy.length - 1 // ej: 4
				var next:int = Math.floor( Math.random()*last_idx ) // ej: rand 0 - 3
				if(copy[next] == orig[i]){
					if(copy.length == 1){ //we only have 1 item and its repeating its position, switch with previous
						var tmp:Object = orig[i-1]
						orig[i-1] = copy[0]
						orig[i] = tmp
						break
					}else{
						next = last_idx
					}
				}
				orig[i] = copy.splice(next,1)[0]
			}
		}
		static public function chooseNumber(lessThan:int, except:Object=null):int{
			var num:int = Math.floor( Math.random()* lessThan)
			if(except != null && num == except){
				if(num == lessThan - 1){
					return 0
				}else{
					return num+1
				}
			}else{
				return num
			}
		}
		
		static public function randomBool():Boolean{
			return new Boolean(Math.round(Math.random()));
		}
		
	}
}