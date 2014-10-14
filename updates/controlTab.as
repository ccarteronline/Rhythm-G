package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import caurina.transitions.Tweener;
	
	
	public class controlTab extends MovieClip {
		
		public var blkCsr:blockChooser;
		public var rcdBtn:recordBtn;
		public var tickAmnt:Number = 24;
		public var selectedBlock:Number;
		private var heldY:Number;
		private var leftBound:Number = -480;
		private var rightBound:Number = 460;
		
		public function controlTab() {
			// constructor code
			//trace('a control tab was loaded in...');
			
		}
		
		public function populateObject(objStr:Number){

			if(objStr == 0){

				showChooser("SELECT A BLOCK");


				rcdBtn = new recordBtn();
				this.addChild(rcdBtn);
				rcdBtn.scaleX = 0.8;
				rcdBtn.scaleY = 0.8;
				rcdBtn.x = -2;
				rcdBtn.y = 135;
			}
		}

		private function showChooser(bTitle:String){
			//add the block chooser
			blkCsr = new blockChooser();
			this.addChild(blkCsr);
			blkCsr.x = 12;
			blkCsr.y = -247;
			blkCsr.hudText.text = bTitle;
			
			//add the drag functionality
			heldY = blkCsr.selectorBlock.y;
			blkCsr.selectorBlock.addEventListener(MouseEvent.MOUSE_DOWN, tapSelectorBlock);
			blkCsr.selectorBlock.addEventListener(MouseEvent.MOUSE_UP, doneSelect);
			blkCsr.selectorBlock.addEventListener(MouseEvent.MOUSE_OUT, stopAll);
			blkCsr.tickMarks.addEventListener(MouseEvent.MOUSE_DOWN, moveButtonToPosition);
			
		}
		private function tapSelectorBlock(e:MouseEvent){
			e.target.addEventListener(Event.ENTER_FRAME, holdYPosition);
			e.target.startDrag();
		}
		private function doneSelect(e:MouseEvent){
			e.target.removeEventListener(Event.ENTER_FRAME, holdYPosition);
			e.target.stopDrag();
		}
		private function holdYPosition(e:Event){
			//snap y
			if(e.target.y != heldY) e.target.y = heldY;
			
			//keep left and right bounds
			if(e.target.x < leftBound){
				e.target.stopDrag();
				e.target.removeEventListener(Event.ENTER_FRAME, holdYPosition);
				e.target.x = leftBound;
			}else if(e.target.x > rightBound){
				e.target.stopDrag();
				e.target.removeEventListener(Event.ENTER_FRAME, holdYPosition);
				e.target.x = rightBound;
			}
			
			//check to see where the number of each tick mark is.
			blkCsr.hudText.text = ("SELECTED BLOCK: " + checkTickMarks(e.target));
		}
		private function stopAll(e:MouseEvent){
			e.target.stopDrag();
			e.target.removeEventListener(Event.ENTER_FRAME, holdYPosition);
		}
		
		private function checkTickMarks(obj){
			for(var f:Number = 1; f<= tickAmnt; f++){
				if(obj.hitTestObject(blkCsr.tickMarks["tick_"+f])){
					return f;
				}
			}
		}
		private function moveButtonToPosition(e:MouseEvent){
			blkCsr.selectorBlock.addEventListener(Event.ENTER_FRAME, holdYPosition);
			Tweener.addTween(blkCsr.selectorBlock, {x:this.mouseX, time:0.5, delay:0, transition:"easeOutCubic", onComplete:stopInPlace});
		}
		private function stopInPlace(){
			blkCsr.selectorBlock.removeEventListener(Event.ENTER_FRAME, holdYPosition);
		}
	}
	
}
