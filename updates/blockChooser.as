package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class blockChooser extends MovieClip {
		
		private var keptMouseX:Number;
		private var isDown:Boolean;
		public var btnTopBound:Number = 136;
		public var btnBottomBound:Number = 192;
		public var leftBound:Number = -480;
		public var rightBound:Number = 460;
		public var tickAmnt:Number = 24;
		
		public function blockChooser() {
			// constructor code
			selectorBlock.addEventListener(MouseEvent.MOUSE_DOWN, tappedDown);
			selectorBlock.addEventListener(MouseEvent.MOUSE_MOVE, movingMouse);
			selectorBlock.addEventListener(MouseEvent.MOUSE_UP, releasedTap);
			tickMarks.addEventListener(MouseEvent.MOUSE_DOWN, tappedTick);
		}
		private function tappedTick(e:MouseEvent){
			trace('tapped tick');
		}
		
		private function checkTickMarks(obj){			
			for(var f:Number = 1; f<= tickAmnt; f++){
				if(obj.hitTestObject(tickMarks["tick_"+f])){
					hudText.text = ("SELECTED BLOCK: " + f);
					//return f;
				}
			}
		}
		
		
		private function tappedDown(e:MouseEvent){
			e.currentTarget.x = keptMouseX;
			
			isDown = true;
		}
		private function releasedTap(e:MouseEvent){
			isDown = false;
		}
		private function movingMouse(e:MouseEvent){
			
			keptMouseX = this.mouseX;
			
			if(isDown){
				
				e.currentTarget.x = keptMouseX;
				
				checkTickMarks(e.target);
				
				if(this.mouseY < btnTopBound || this.mouseY > btnBottomBound){
					isDown = false;
				}
				
				if(e.target.x < leftBound){
					
					e.target.x = leftBound-2;
					isDown = false;
					
				}else if(e.target.x > rightBound){
					
					e.target.x = rightBound-2;
					isDown = false;
				}
			}
			
		}
		
	}
	
}
