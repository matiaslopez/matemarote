package planning
{
	import com.adobe.serialization.json.JSON;
	
	import memory.Utils;
	
	public class PlanningLevels extends Object{
		public var houses:Array
		public var positions:Array = ['tl','tr','br','bl']
		
		public function PlanningLevels(newHouses:Array){
			houses = newHouses
		}
		
		public function makeLevel(moves:int, permute:Boolean):Object{
			if(moves == 7){
				permute = true // there's no 7 move rotation 
			}
			var i:int = 0
			var should_permute:Boolean = permute			
			var houseWalker:LayoutsWalker = new LayoutsWalker(Utils.shuffled(houses), true)
			
			if(moves == 1 && permute && !houseWalker.isOpen()){
				houseWalker.rotate()
			}
			
			var charsWalker:LayoutsWalker = new LayoutsWalker(houseWalker.items.slice(), Utils.randomBool())
			
			for(i=0; i<moves; i++){
				if(charsWalker.isOpen() && should_permute){
					charsWalker.permute()
					should_permute = false
				}else{
					charsWalker.rotate()
				}				
			}

			var char_house:Object = {}
			for(i=0; i<charsWalker.items.length; i++){
				if(!charsWalker.items[i].ownerCharacter){
					continue
				}
				var char_nick:String = charsWalker.items[i].ownerCharacter.nick
				var house_nick:String = houseWalker.items[i].nick
				char_house[char_nick] = house_nick
			}
			
			var house_pos:Object = {}
			for(i=0; i<positions.length; i++){
				house_pos[houseWalker.items[i].nick] = positions[i]
			}
			
			var lvl:Object = {'char_house': char_house, 'house_pos': house_pos,
							  'moves': moves, 'permute': permute}
			return lvl
		}
		
	}
}

class LayoutsWalker extends Object{
	public var items:Array
	public var walkDirection:int
	
	public function LayoutsWalker(newItems:Array, walkDir:Boolean){
		items = newItems
		walkDirection = walkDir ? 1 : -1
	}
	
	public function rotate():void{
		var empty:int = emptyIndex()
		
		var switchTo:int = empty + walkDirection
		if(switchTo >= items.length){
			switchTo = 0
		}else if(switchTo < 0){
			switchTo = items.length-1
		}
		
		var x:Object = items[empty], y:Object = items[switchTo]
		items[switchTo] = x
		items[empty] = y
	}
	
	public function permute():void{
		var x:Object = items[2], y:Object = items[0]
		items[0] = x
		items[2] = y
		//After a permutation we should change the walking direction to avoid going in circles.
		walkDirection *= -1
	}
	
	public function isOpen():Boolean{
		return items[0].ownerCharacter == null || items[2].ownerCharacter == null
	}
	
	public function emptyIndex():int{
		for(var i:int = 0; i<items.length; i++){
			if(items[i].ownerCharacter == null){
				return i
			}
		}
		return 0
	}
}