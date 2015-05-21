package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	
	public class clearDialog extends MovieClip {
		
		public function clearDialog() {
			// constructor code
			
			okBtn.addEventListener(MouseEvent.CLICK, function(){ 
				trace("you clicked");
				panel.visible = false;
				okBtn.visible = false;
				dimmer.visible = false;
			});
		}
	}
	
}
