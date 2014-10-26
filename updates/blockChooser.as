package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	import saveObject;
	import flash.net.SharedObject;
	
	
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
		public var sharedObj:SharedObject = SharedObject.getLocal('blockchooser');
		public var lastPressedBlock:Number;
		public var tickXMarks:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23];
		
		public function blockChooser(lastTapped:Number) {
			// constructor code
			selectorBlock.addEventListener(MouseEvent.MOUSE_DOWN, tappedDown);
			selectorBlock.addEventListener(MouseEvent.MOUSE_MOVE, movingMouse);
			selectorBlock.addEventListener(MouseEvent.MOUSE_UP, releasedTap);
			tickMarks.addEventListener(MouseEvent.MOUSE_DOWN, tappedTick);
			
			lastPressedBlock = lastTapped;
			trace("length:", tickXMarks.length);
			
			//trace("Get current block: "+ saveObj.lastTapped);
			//trace(MovieClip(root).testVar);
			trace('persist! ', lastPressedBlock);
			moveToCurrentBlock(lastPressedBlock);
		}
		
		private function moveToCurrentBlock(numPsdBlk:Number){
			trace('adsfs');
			selectorBlock.x = selectorBlock.x + (35 * numPsdBlk);
		}
		
		private function tappedTick(e:MouseEvent){
			selectorBlock.addEventListener(Event.ENTER_FRAME, isAnimating);
			Tweener.addTween(selectorBlock, {x:this.mouseX, time:0.5, delay:0, transition:"easeOutCubic", onComplete:stopInPlace});
		}
		private function isAnimating(e:Event){
			checkTickMarks(selectorBlock.tickHitter);
		}
		private function stopInPlace(){
			selectorBlock.removeEventListener(Event.ENTER_FRAME, isAnimating);
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
			trace('mouse x is: ', this.mouseX);
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
