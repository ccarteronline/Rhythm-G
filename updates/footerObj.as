﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import caurina.transitions.Tweener;
	import flash.events.TouchEvent;
	
	public class footerObj extends MovieClip {
		public var userNavPassage:Boolean = false;
		public var calledToBuildDPad:Boolean = false;
		public var isTabbedWindowOpen:Boolean;
		public var ctrlTabObj:controlTab;
		
		public function footerObj() {
			// constructor code
			
			//this.cacheAsBitmapMatrix = this.transform.concatenatedMatrix;
			//this.cacheAsBitmap = true;
						
			buildNavButtons("navbtn_", ["RECORD", "CONNECT", "REPEAT", "LIBRARY", "STOP"]);
			homeBtn.addEventListener(MouseEvent.CLICK, goToDPad);
			
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
			
			if(!isTabbedWindowOpen){
				createTabWindow(e.currentTarget.btnText.text);
				//Tell the dPad to dissappear by passing this nav val to true
				//it will animate out set a time delay to animate the called 
				//object box current below
				userNavPassage = true;
				//Create a new tab for important features items to be housed in.
			}else{
				if(e.currentTarget.btnText.text == "RECORD"){
					trace('build out recorder');
				}
			}
			
		}
		
		public function createTabWindow(tabName:String){
			
			ctrlTabObj = new controlTab();
			stage.addChildAt(ctrlTabObj,1);
			ctrlTabObj.alpha = 0;
			ctrlTabObj.scaleX = 0;
			ctrlTabObj.scaleY = 0;
			ctrlTabObj.x = 550;
			ctrlTabObj.y = 350;
			Tweener.addTween(ctrlTabObj, {scaleX:1, scaleY:1, alpha:1, x:568.45, y:378, time:0.3, delay:0.5, transition:"linear"});
			isTabbedWindowOpen = true;
			
			if(tabName == "RECORD"){
				trace('display record panel and populate it here');
				ctrlTabObj.populateObject(0);
				
			}
		}
		
		public function removeTabWindow(){
			
			stage.removeChild(ctrlTabObj);
		}
		
		public function goToDPad(e:MouseEvent){
			//Create a variable that is now true, it is chekced
			//If true, it will open a new dpad object instance in the main class
			calledToBuildDPad = true;
			
			//If we are opening the dpad, we need to delete the other open tab
			if(isTabbedWindowOpen){
				removeTabWindow();
				isTabbedWindowOpen = false;
			}
			
		}
	}
	
}