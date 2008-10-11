package utils{
	import mx.core.UIComponent;
    import mx.managers.PopUpManager;
	import flash.utils.setTimeout;
	import mx.containers.TitleWindow;
	import mx.controls.Text;
    	
	public class MessageManager extends Object{
		static public function show(parent:UIComponent, text:String, time:int=0, onComplete:Function=null):TitleWindow{			            
			var container:UIComponent = new UIComponent()
        	var txt:Text = new Text()
        	txt.text = text
        	txt.setStyle('fontSize', 23)
        	txt.setStyle('textAlign', 'center')
            var msg:TitleWindow = new TitleWindow()
			with(msg){
				title = "Mate Marote"
		        showCloseButton = false
		        addChild(txt)
				setStyle('backgroundAlpha', 10.0)
				setStyle('verticalAlign', 'middle')
				setStyle('horizontalAlign', 'center')
			}
            PopUpManager.addPopUp(msg, parent, true)
            PopUpManager.centerPopUp(msg)
            if(time){
	            setTimeout(function():void{
					PopUpManager.removePopUp(msg)
		            onComplete && onComplete()
				}, time)
            }
			return msg;
        }
		static public function remove(msg:TitleWindow):void{
			PopUpManager.removePopUp(msg)
		}
	}
}