package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class blockChooser extends MovieClip {
		
		private var keptMouseX:Number;
		private var isDown:Boolean;
		private var selectorHeight:Number;
		private var btnTopBound:Number = 136;
		
		public function blockChooser() {
			// constructor code
			trace('Running Block chooser');
			selectorBlock.addEventListener(MouseEvent.MOUSE_DOWN, tappedDown);
			selectorBlock.addEventListener(MouseEvent.MOUSE_MOVE, movingMouse);
			selectorBlock.addEventListener(MouseEvent.MOUSE_UP, releasedTap);
		}
		
		private function tappedDown(e:MouseEvent){
			trace('Moused Down.');
			e.currentTarget.x = keptMouseX;
			
			isDown = true;
		}
		private function releasedTap(e:MouseEvent){
			trace('working for those places is no more chrti');
			isDown = false;
		}
		private function movingMouse(e:MouseEvent){
			
			keptMouseX = this.mouseX;
			
			if(isDown){
				e.currentTarget.x = keptMouseX;
				selectorHeight = e.currentTarget.height;
				
			}
			
		}
		
	}
	
}
