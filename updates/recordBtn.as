package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class recordBtn extends MovieClip {
		
		
		public function recordBtn() {
			// constructor code
			trace('hello');
			this.addEventListener(MouseEvent.MOUSE_DOWN, tapDown);
			this.addEventListener(MouseEvent.MOUSE_UP, tapUp);
		}
		private function tapDown(e:MouseEvent){
			e.target.y = e.target.y+10;
		}
		private function tapUp(e:MouseEvent){
			e.target.y = e.target.y-10;
			animateRecording();
		}
		public function animateRecording(){
			trace('this is where you animate and record');
		}
	}
	
}
