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
		public var mainObj:main;
		
		public function blockChooser(mc, lastTapped:Number) {
			
			mainObj = mc;
			// constructor code
			selectorBlock.addEventListener(MouseEvent.MOUSE_DOWN, tappedDown);
			selectorBlock.addEventListener(MouseEvent.MOUSE_MOVE, movingMouse);
			selectorBlock.addEventListener(MouseEvent.MOUSE_UP, releasedTap);
			tickMarks.addEventListener(MouseEvent.MOUSE_DOWN, tappedTick);
			
			lastPressedBlock = lastTapped;
			
			//trace("Get current block: "+ saveObj.lastTapped);
			//trace(MovieClip(root).testVar);
			trace('persist! ', lastPressedBlock);
			moveToCurrentBlock(lastPressedBlock);
			//pass to recorder object
			keptBlock = lastPressedBlock;
			
			//Get and set the number that was last selected 
			
		}
		
		public function changeHudText(toText){
			hudText.text = toText;
		}
		
		private function moveToCurrentBlock(numPsdBlk:Number){
			selectorBlock.x = selectorBlock.x + (40 * numPsdBlk);
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
			checkTickMarks(selectorBlock.tickHitter);
			//trace('get the text number value then put it in memory');
			mainObj.blockChooserBlock = keptBlock;
			//Since user is doing manually, reset the kept last tapped button from mpc
			mainObj.lastTappedButton = keptBlock;
			//trace("You animated so still set the block to: ", mainObj.blockChooserBlock);
		}
		
		private function checkTickMarks(obj){			
			for(var f:Number = 1; f<= tickAmnt; f++){
				if(selectorBlock.tickHitter.hitTestObject(tickMarks["tick_"+f])){
					hudText.text = ("SELECTED BLOCK: " + f);
					keptBlock = f;
					//tell Rhythm-G the last selected block from block chooser
					mainObj.blockChooserBlock = f;
					//Since user is doing manually, reset the kept last tapped button from mpc
					mainObj.lastTappedButton = f;
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
			trace('you let go! What is the number? ', keptBlock);
			
			mainObj.blockChooserBlock = keptBlock;
			mainObj.lastTappedButton = keptBlock;
			
			/*if(mainObj.blockChooserBlock == undefined){
				trace('this is null!');
			}else{
				trace("hello: ", mainObj.blockChooserBlock);
			}*/
			
			//trace(mainObj.blockChooserBlock);
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
