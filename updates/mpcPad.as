package  {
	
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.display.Stage;
	
	public class mpcPad extends MovieClip {
		public var numObjects:Number = 24;
		public var pfx:String = "block_";
		public var calledToBuildDPad:Boolean = false;
		public var rg_pad:mpcPad;
		public var keptStage:Stage;
		
		public function mpcPad() {
			//this.cacheAsBitmapMatrix = this.transform.concatenatedMatrix;
			//this.cacheAsBitmap = true;
			
			detailbuttons();
			
		}
		
		public function removeItself(){
			Tweener.addTween(rg_pad,{x:550, y:350, scaleX:0, scaleY:0, alpha:0, time:0.5, delay:0, transition:"easeInBack", onComplete:garabageDump});
			
		}
		public function buildItself(elStage:Stage){
			rg_pad = new mpcPad();
			rg_pad.alpha = 1;
			elStage.addChild(rg_pad);
			keptStage = elStage;
			rg_pad.scaleX = 0;
			rg_pad.scaleY = 0;
			rg_pad.x = 550;
			rg_pad.y = 350;
			
			Tweener.addTween(rg_pad,{x:-55, y:-30, scaleX:1, scaleY:1, alpha:1, time:0.5, delay:.2, transition:"easeOutBack"});
		}
		public function garabageDump(){
			trace('stage: ', keptStage);
			trace('Object', rg_pad);
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
			trace('asdfsf');
			e.currentTarget.gotoAndStop(2);
		}
		public function initPlaySoundObjectUp(e:TouchEvent){
			trace('asdasdfsfsfsff');
			e.currentTarget.gotoAndStop(1);
		}
	}
	
}
