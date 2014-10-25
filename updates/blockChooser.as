package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	
	
	public class blockChooser extends MovieClip {
		
		private var keptMouseX:Number;
		private var isDown:Boolean;
		public var btnTopBound:Number = 136;
		public var btnBottomBound:Number = 192;
		public var leftBound:Number = -480;
		public var rightBound:Number = 460;
		public var tickAmnt:Number = 24;
		public var blkHudText = hudText;
		public var keptBlock:Number;
		
		public function blockChooser() {
			// constructor code
			selectorBlock.addEventListener(MouseEvent.MOUSE_DOWN, tappedDown);
			selectorBlock.addEventListener(MouseEvent.MOUSE_MOVE, movingMouse);
			selectorBlock.addEventListener(MouseEvent.MOUSE_UP, releasedTap);
			tickMarks.addEventListener(MouseEvent.MOUSE_DOWN, tappedTick);
		}
		
		private function tappedTick(e:MouseEvent){
			selectorBlock.addEventListener(Event.ENTER_FRAME, isAnimating);
			Tweener.addTween(selectorBlock, {x:this.mouseX, time:0.5, delay:0, transition:"easeOutCubic", onComplete:stopInPlace});
		}
		private function isAnimating(e:Event){
			checkTickMarks(selectorBlock.tickHitter);
		}
		private function stopInPlace(){
			//selectorBlock.removeEventListener(Event.ENTER_FRAME, holdYPosition);
		}
		
		private function checkTickMarks(obj){			
			for(var f:Number = 1; f<= tickAmnt; f++){
				if(selectorBlock.tickHitter.hitTestObject(tickMarks["tick_"+f])){
					hudText.text = ("SELECTED BLOCK: " + f);
					keptBlock = f;
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
				
				checkAndCorrectBounds(e.target);
			}
			
		}
		private function checkAndCorrectBounds(obj){
			if(obj < leftBound){

				obj = leftBound-2;
				isDown = false;
				
			}else if(obj > rightBound){
				
				obj = rightBound-2;
				isDown = false;
			}
		}
		
	}
	
}
