package  {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import caurina.transitions.Tweener;
	
	
	public class main extends MovieClip {
			
		public var mpcButtonObj:mpcPad;
		public var footer:footerObj
		public var numDPadButtons:Number = 24;
		public var dpadDisplayed:Boolean = false;
		public var dPadIsOpen:Boolean = false;
		
		
		
		public function main() {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;//allow multitouch
			trace('Welcome to RhythmG');
			scaleTheStage();
			
			Tweener.addTween(this,{alpha:1, time:0, delay:0.8, transition:"linear", onComplete:showDPadButtons});
			Tweener.addTween(this,{alpha:1, time:0, delay:0.8, transition:"linear", onComplete:buildFooter});			
			
		}
		public function scaleTheStage(){
			var swfStage:Stage = this.stage; 
			swfStage.scaleMode = StageScaleMode.EXACT_FIT; 
			swfStage.align = StageAlign.TOP_LEFT; 
		}
		
		public function buildFooter(){
			footer = new footerObj();
			footer.x = 636.95;
			footer.y = 740.25;
			stage.addChild(footer);
			footer.alpha = 0;
			Tweener.addTween(footer,{alpha:1, time:1, delay:0, transition:"linear"});
			
			//
			stage.addEventListener(Event.ENTER_FRAME, appLoop);
		}
		
		public function appLoop(e:Event){
			//navigation routes to show and remove views to user
			if(footer.userNavPassage){
				footer.userNavPassage = false;
				mpcButtonObj.removeItself();
				dPadIsOpen = false;
				footer.calledToBuildDPad = false;
			}
			
			if(footer.calledToBuildDPad == true && dPadIsOpen == false){
				footer.calledToBuildDPad = false;
				showDPadButtons();
			}
		}
		public function showDPadButtons(){
			
			mpcButtonObj = new mpcPad();
			mpcButtonObj.buildItself(stage);
			
			dPadIsOpen = true;
			
		}
	}
	
}
