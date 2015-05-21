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
	import flash.net.SharedObject;
	import fingerBot;
	import flash.media.Sound;
	
	
	public class main extends MovieClip {
			
		public var mpcButtonObj:mpcPad;
		public var footer:footerObj
		public var fBot:fingerBot;
		public var tut:tutorial = new tutorial();
		public var numDPadButtons:Number = 24;
		public var dpadDisplayed:Boolean = false;
		public var dPadIsOpen:Boolean = false;
		public var lastTappedButton:Number;
		public var blockChooserBlock:Number;//This is the block that was selected in the block chooser
		public var ego = this;
		
		public var onlSound_1:Sound = new Sound();
		public var onlSound_2:Sound = new Sound();
		public var onlSound_3:Sound = new Sound();
		public var onlSound_4:Sound = new Sound();
		public var onlSound_5:Sound = new Sound();
		public var onlSound_6:Sound = new Sound();
		public var onlSound_7:Sound = new Sound();
		public var onlSound_8:Sound = new Sound();
		public var onlSound_9:Sound = new Sound();
		public var onlSound_10:Sound = new Sound();
		public var onlSound_11:Sound = new Sound();
		public var onlSound_12:Sound = new Sound();
		public var onlSound_13:Sound = new Sound();
		public var onlSound_14:Sound = new Sound();
		public var onlSound_15:Sound = new Sound();
		public var onlSound_16:Sound = new Sound();
		public var onlSound_17:Sound = new Sound();
		public var onlSound_18:Sound = new Sound();
		public var onlSound_19:Sound = new Sound();
		public var onlSound_20:Sound = new Sound();
		public var onlSound_21:Sound = new Sound();
		public var onlSound_22:Sound = new Sound();
		public var onlSound_23:Sound = new Sound();
		public var onlSound_24:Sound = new Sound();
		
		public var onlineSoundLoaded_1:Boolean = false;
		public var onlineSoundLoaded_2:Boolean = false;
		public var onlineSoundLoaded_3:Boolean = false;
		public var onlineSoundLoaded_4:Boolean = false;
		public var onlineSoundLoaded_5:Boolean = false;
		public var onlineSoundLoaded_6:Boolean = false;
		public var onlineSoundLoaded_7:Boolean = false;
		public var onlineSoundLoaded_8:Boolean = false;
		public var onlineSoundLoaded_9:Boolean = false;
		public var onlineSoundLoaded_10:Boolean = false;
		public var onlineSoundLoaded_11:Boolean = false;
		public var onlineSoundLoaded_12:Boolean = false;
		public var onlineSoundLoaded_13:Boolean = false;
		public var onlineSoundLoaded_14:Boolean = false;
		public var onlineSoundLoaded_15:Boolean = false;
		public var onlineSoundLoaded_16:Boolean = false;
		public var onlineSoundLoaded_17:Boolean = false;
		public var onlineSoundLoaded_18:Boolean = false;
		public var onlineSoundLoaded_19:Boolean = false;
		public var onlineSoundLoaded_20:Boolean = false;
		public var onlineSoundLoaded_21:Boolean = false;
		public var onlineSoundLoaded_22:Boolean = false;
		public var onlineSoundLoaded_23:Boolean = false;
		public var onlineSoundLoaded_24:Boolean = false;
		
		public var toRemoveRepeatObject:Boolean = false;		
	
		//public var saveObj = new saveObject;
		
		public var connectSave:SharedObject = SharedObject.getLocal("connectObject");
		public var tutorialState:SharedObject = SharedObject.getLocal("tutorialState");
				
		public function main() {
			
			//set the frame rate
			this.stage.frameRate = 90;
			
			////////Reset stored values///////////////////////
			//comment out mpcPad line 41 getCurrentPad() method
			//then uncomment the three lines below
			////////Reset stored values///////////////////////
			
			//trace(connectSave.data.prepBlockArray);
			//connectSave.flush();
			//connectSave.data.prepBlockArray = undefined;
			//
			
			if(connectSave.data.prepBlockArray == undefined){
				
				trace('first launch, creating new array');
				fBot = new fingerBot(ego);
				fBot.initDefaultSet();
				
				//stage.addChildAt(tut, 10);
				
			}else{
				fBot = new fingerBot(ego);
				connectSave.data.prepBlockArray = fBot.getStoredMPCArray();
				
			}
			
			stage.addChild(tut);
			tut.x = 568.05;
			tut.y = 386.05;
			tut.alpha = 0;
			if(tutorialState.data.isComplete){
				trace("already ran tutorial");
				tut.visible = false;
			}else{
				Tweener.addTween(tut, {alpha: 1, delay:1.5, transition:"linear", time:1.2});
			}
			
			//stage.setChildIndex(tut, 3);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;//allow multitouch
			trace('Welcome to RhythmG');
			scaleTheStage();
			
			Tweener.addTween(this,{alpha:1, time:0, delay:0.8, transition:"linear", onComplete:showDPadButtons});
			Tweener.addTween(this,{alpha:1, time:0, delay:0.8, transition:"linear", onComplete:buildFooter});			
			
		}
		
		public function clearMPCStoredValues(){
			
			connectSave.data.prepBlockArray = [];
			connectSave.flush();
			
			mpcButtonObj.getCurrentPad();
			//
			fBot = new fingerBot(ego);
			fBot.initDefaultSet();
			
			
		}
		
		
		public function scaleTheStage(){
			var swfStage:Stage = this.stage; 
			swfStage.scaleMode = StageScaleMode.EXACT_FIT; //For Android, test with SHOW_ALL, For iOS use EXACT_FIT
			swfStage.align = StageAlign.TOP; 
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
			
			stage.setChildIndex(tut, 3);
			
		}
		
		public function appLoop(e:Event){
			//navigation routes to show and remove views to user
			if(footer.userNavPassage){
				footer.userNavPassage = false;
				
				dPadIsOpen = false;
				footer.calledToBuildDPad = false;
				
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
		
		}
	
	}
	
}
