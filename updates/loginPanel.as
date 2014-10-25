package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class loginPanel extends MovieClip {
		
		
		public function loginPanel() {
			// constructor code
			trace('loaded panel');
			cancelBtn.btnTitle.text = "CANCEL";
			
			cancelBtn.addEventListener(MouseEvent.CLICK, closeMenu);
		}
		
		private function closeMenu(e:MouseEvent){
			closeOutMenu();
		}
		
		public function closeOutMenu(){
			stage.removeChild(MovieClip(parent));
		}
	}
	
}
