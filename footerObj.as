package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import caurina.transitions.Tweener;
	import flash.events.TouchEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.Event;
	import flash.media.SoundMixer;
	
	public class footerObj extends MovieClip {
		public var userNavPassage:Boolean = false;
		public var calledToBuildDPad:Boolean = false;
		public var isTabbedWindowOpen:Boolean;
		public var ctrlTabObj:controlTab;
		public var lastTappedButton:Number;
		public var mainObj:main;
		
		public function footerObj(ego:main) {			
			trace("hello: ", ego);
			mainObj = ego;
			buildNavButtons("navbtn_", ["CLEAR", "CONNECT", "LOOP", "LIBRARY", "STOP"]);
			homeBtn.addEventListener(MouseEvent.CLICK, goToDPad);
			
			
		}
		public function setCurrentTapped(num:Number){
			lastTappedButton = num;
		}
		
		public function buildNavButtons(pfx:String, btnNav:Array){
			//
			var numbtns:Number = btnNav.length;
			for(var ret:Number = 1; ret<=numbtns; ret++){
				this[pfx+ret].btnText.text = btnNav[ret-1];
				this[pfx+ret].buttonMode = true;
				//this[pfx+ret].addEventListener(MouseEvent.CLICK, navBtnClickedUp);
				this[pfx+ret].addEventListener(MouseEvent.MOUSE_DOWN, navBtnClickedDown);
				this[pfx+ret].addEventListener(MouseEvent.MOUSE_UP, navBtnClickedUp);
			}
		}
		public function navBtnClickedDown(e:MouseEvent){
			e.currentTarget.alpha = 0.2;
		}
		public function navBtnClickedUp(e:MouseEvent){
			e.currentTarget.alpha = 1;
			//
			if(isTabbedWindowOpen == false){
				if(e.currentTarget.btnText.text == "STOP"){
					trace("stop all sounds");
					SoundMixer.stopAll();
				}else if(e.currentTarget.btnText.text == "CLEAR"){
					
					
					mainObj.clearMPCStoredValues();
					var clearDia = new clearDialog();
					stage.addChild(clearDia);
					clearDia.x = 571.15;
					clearDia.y = 397.1;
					
				}else{
					createTabWindow(e.currentTarget.btnText.text);
					//Tell the dPad to dissappear by passing this nav val to true
					//it will animate out set a time delay to animate the called 
					//object box current below
					userNavPassage = true;
					//Create a new tab for important features items to be housed in.
				}
				
				
			}else{
				if(e.currentTarget.btnText.text == "STOP"){
					trace("stop all sounds");
					SoundMixer.stopAll();
				}else{
					removeTabWindow();
					createTabWindow(e.currentTarget.btnText.text);
				}
				
				
				
			}
			
			
		}
		
		public function createTabWindow(tabName:String){
			
			if(tabName == "CLEAR"){
				mainObj.clearMPCStoredValues();
				var clearDia = new clearDialog();
				stage.addChild(clearDia);
				clearDia.x = 571.15;
				clearDia.y = 397.1;
				
			}else if(tabName == "CONNECT"){
				manifestTab();
				trace('Display Connect');
				ctrlTabObj.populateObject(1);
				mainObj.tut.showNext();
				mainObj.toRemoveRepeatObject = true;
				
				
			}else if(tabName == "LOOP"){
				manifestTab();
				trace("Display Repeat");
				ctrlTabObj.populateObject(2);
				mainObj.toRemoveRepeatObject = false;
				mainObj.tut.showNext();
				
			}else if(tabName == "LIBRARY"){
				mainObj.tut.showNext();
				manifestTab();
				trace("Display Library");
				ctrlTabObj.populateObject(3);
				mainObj.toRemoveRepeatObject = false;
				
			}else if(tabName == "STOP"){
			
				mainObj.toRemoveRepeatObject = true;
			}
		}
		
		
		private function manifestTab(){
			ctrlTabObj = new controlTab(mainObj, lastTappedButton);
			stage.addChildAt(ctrlTabObj,1);
			ctrlTabObj.alpha = 0;
			ctrlTabObj.scaleX = 0;
			ctrlTabObj.scaleY = 0;
			ctrlTabObj.x = 550;
			ctrlTabObj.y = 350;
			Tweener.addTween(ctrlTabObj, {scaleX:1, scaleY:1, alpha:1, x:568.45, y:378, time:0.3, delay:0.5, transition:"linear"});
			isTabbedWindowOpen = true;
		}
		
		public function removeTabWindow(){
			trace('removed');
			
			stage.removeChild(ctrlTabObj);
			ctrlTabObj = null;
			isTabbedWindowOpen = false;
		}
		
		public function goToDPad(e:MouseEvent){
			
			buildNewDPad();
			
		}
		
		public function destroyControlTab(){
			stage.removeChild(ctrlTabObj);
		}
		
		public function buildNewDPad(){
			//Create a variable that is now true, it is chekced
			//If true, it will open a new dpad object instance in the main class
			calledToBuildDPad = true;
			
			//mainObj.toRemoveRepeatObject = true;
			
			//If we are opening the dpad, we need to delete the other open tab
			if(isTabbedWindowOpen){
				removeTabWindow();
				isTabbedWindowOpen = false;
			}
		}
	}
	
}
