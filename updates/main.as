package  {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import caurina.transitions.Tweener;
	import saveObject;
	import flash.media.Sound;
	
	
	public class main extends MovieClip {
			
		public var mpcButtonObj:mpcPad;
		public var footer:footerObj
		public var numDPadButtons:Number = 24;
		public var dpadDisplayed:Boolean = false;
		public var dPadIsOpen:Boolean = false;
		public var lastTappedButton:Number;
		public var ego = this;
		
		public var sound_1:Sound = new Sound();
		public var sound_2:Sound = new Sound();
		public var sound_3:Sound = new Sound();
		public var sound_4:Sound = new Sound();
		public var sound_5:Sound = new Sound();
		public var sound_6:Sound = new Sound();
		public var sound_7:Sound = new Sound();
		public var sound_8:Sound = new Sound();
		public var sound_9:Sound = new Sound();
		public var sound_10:Sound = new Sound();
		public var sound_11:Sound = new Sound();
		public var sound_12:Sound = new Sound();
		public var sound_13:Sound = new Sound();
		public var sound_14:Sound = new Sound();
		public var sound_15:Sound = new Sound();
		public var sound_16:Sound = new Sound();
		public var sound_17:Sound = new Sound();
		public var sound_18:Sound = new Sound();
		public var sound_19:Sound = new Sound();
		public var sound_20:Sound = new Sound();
		public var sound_21:Sound = new Sound();
		public var sound_22:Sound = new Sound();
		public var sound_23:Sound = new Sound();
		public var sound_24:Sound = new Sound();
				
		public function main() {
			//create instace of save object
			//saveObj.runThroughInstance(ego);
			
			//saveObj.readObject();
			//saveObj.writeObject();
			//trace(saveObj.readObject());

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
			footer = new footerObj(ego);
			footer.x = 636.95;
			footer.y = 740.25;
			stage.addChild(footer);
			footer.alpha = 0;
			Tweener.addTween(footer,{alpha:1, time:1, delay:0, transition:"linear"});
			
			//
			stage.addEventListener(Event.ENTER_FRAME, appLoop);
			
			//
			//footer.setCurrentTapped(1);
			
		}
		
		public function appLoop(e:Event){
			//navigation routes to show and remove views to user
			if(footer.userNavPassage){
				footer.userNavPassage = false;
				
				dPadIsOpen = false;
				footer.calledToBuildDPad = false;
				
				//footer.setCurrentTapped(mpcButtonObj.getLastTappedButton());
				//trace('setting the button:', mpcButtonObj.getLastTappedButton());
				
				mpcButtonObj.removeItself();
				
				
			}
			
			if(footer.calledToBuildDPad == true && dPadIsOpen == false){
				footer.calledToBuildDPad = false;
				showDPadButtons();
			}
			
			if(dPadIsOpen){
				//trace(mpcButtonObj.getLastTappedButton());
				if(!lastTappedButton){
					footer.setCurrentTapped(1);
				}else{
					footer.setCurrentTapped(lastTappedButton);
				}
				
			}
		}
		public function showDPadButtons(){
			
			mpcButtonObj = new mpcPad(ego);
			mpcButtonObj.buildItself(stage);
			
			dPadIsOpen = true;
			//mpcButtonObj.setLastTappedButton(1);
			//lastTappedButton = 
			//trace(mpcButtonObj.getLastTappedButton());
			
			//footer.setCurrentTapped(mpcButtonObj.getLastTappedButton());
			
		}
	}
	
}
