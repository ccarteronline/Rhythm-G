package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	
	
	public class recordBtn extends MovieClip {
		
		public var orngOvly;
		public var recorderObject:recorder;
		public var keptBlockValNum:Number;
		
		
		public function recordBtn(heldTapObj:Number) {
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
			startRecorder();
		}
		
		private function startRecorder(){
			recorderObject = new recorder(MovieClip(parent).blkCsr.keptBlock);
			recorderObject.manageRecord(MovieClip(parent).blkCsr.keptBlock);
		}
		private function stopRecorder(){
			recorderObject.stopRecording();
		}
		
		public function animateRecording(){
			keptBlockValNum = MovieClip(parent).blkCsr.keptBlock;
			MovieClip(parent).blkCsr.hudText.text = ("RECORDING ON: "+keptBlockValNum);
			//trace(MovieClip(parent).blkCsr.keptBlock);
			orngOvly = new recOrangeOverlay();
			orngOvly.x = 569.15;
			orngOvly.y = 386.1;
			orngOvly.alpha = 0;
			stage.addChild(orngOvly);
			
			orngOvly.addEventListener(MouseEvent.MOUSE_DOWN, stopRecording);
			//begin animation
			animin();
		
		}
		private function animOut(){
			Tweener.addTween(orngOvly, {alpha:.5, time:2, delay:0, transition:"linear", onComplete:animin});
		}
		private function animin(){
			Tweener.addTween(orngOvly, {alpha:1, time:2, delay:0, transition:"linear", onComplete:animOut});
		}
		
		private function stopRecording(e:MouseEvent){
			Tweener.addTween(orngOvly, {alpha:0, time:1, delay:0, transition:"easeOutCubic", onComplete:removeObj});
			orngOvly.removeEventListener(MouseEvent.MOUSE_DOWN, stopRecording);
			
			recorderObject.manageRecord(MovieClip(parent).blkCsr.keptBlock);
			recorderObject.playAudio(MovieClip(parent).blkCsr.keptBlock);
		}
		private function removeObj(){
			stage.removeChild(orngOvly);
		}
	}
	
}
