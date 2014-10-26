package  {
	
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class mpcPad extends MovieClip {
		public var numObjects:Number = 24;
		public var pfx:String = "block_";
		public var calledToBuildDPad:Boolean = false;
		public var lastTappedNum:Number;
		public var rg_pad:mpcPad;
		public var keptStage:Stage;
		public var mainObj:main;
		
		public function mpcPad(ego:main) {
			//this.cacheAsBitmapMatrix = this.transform.concatenatedMatrix;
			//this.cacheAsBitmap = true;
			
			detailbuttons();
			this.addEventListener(Event.ENTER_FRAME, tellBlock);
			
			//pass the main object to get its variables
			mainObj = ego;
		}
		
		public function tellBlock(e:Event){
			//update the last tapped button
			lastTappedNum = getLastTappedButton();
			
		}
		
		public function removeItself(){
			Tweener.addTween(rg_pad,{x:550, y:350, scaleX:0, scaleY:0, alpha:0, time:0.3, delay:0, transition:"easeInOutBack", onComplete:garabageDump});
			
		}
		public function buildItself(elStage:Stage){
			rg_pad = new mpcPad(mainObj);
			rg_pad.alpha = 0;
			elStage.addChild(rg_pad);
			keptStage = elStage;
			rg_pad.scaleX = 0;
			rg_pad.scaleY = 0;
			rg_pad.x = 550;
			rg_pad.y = 350;
			
			Tweener.addTween(rg_pad,{x:-55, y:-30, scaleX:1, scaleY:1, alpha:1, time:1.2, delay:0, transition:"easeInOutBack"});
		}
		public function garabageDump(){
			keptStage.removeChild(rg_pad);
		}
		public function detailbuttons(){

			for(var twit:Number = 1; twit<=numObjects; twit++){
				this[pfx+twit].numUnder.text = (twit+".");
				this[pfx+twit].addEventListener(TouchEvent.TOUCH_BEGIN, initPlaySoundObjectDown);
				this[pfx+twit].addEventListener(TouchEvent.TOUCH_END, initPlaySoundObjectUp);
				this[pfx+twit].addEventListener(TouchEvent.TOUCH_ROLL_OUT, initPlaySoundObjectUp);
			}
		
		}
		
		public function initPlaySoundObjectDown(e:TouchEvent){
			e.currentTarget.gotoAndStop(2);
		}
		
		public function initPlaySoundObjectUp(e:TouchEvent){
			e.currentTarget.gotoAndStop(1);
			var gotcha = e.currentTarget.numUnder.text.split(".").join("");
			gotcha = Number(gotcha);
			lastTappedNum = gotcha;
			//setLastTappedButton(gotcha);
			
			mainObj.lastTappedButton = lastTappedNum;
		}
		
		public function getLastTappedButton(){
			if(!lastTappedNum){
				return 1;
			}else{
				return lastTappedNum;
			}
		}
		public function setLastTappedButton(numBtn:Number){
			lastTappedNum = numBtn;
		}
	}
	
}
