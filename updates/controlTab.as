package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class controlTab extends MovieClip {
		
		public var blkCsr:blockChooser;
		private var heldY:Number;
		private var leftBound:Number = -464.35;
		private var rightBound:Number = 460.65;
		
		public function controlTab() {
			// constructor code
			trace('a control tab was loaded in...');
			
		}
		
		public function populateObject(objStr:Number){

			if(objStr == 0){

				showChooser("SELECT A BLOCK");


				var rcdBtn:recordBtn = new recordBtn();
				//this.addChild(rcdBtn);
				
				//rcdBtn.x = 0;
				//rcdBtn.y = 150;

				
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
		}
	}
	
}
