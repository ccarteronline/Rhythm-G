package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import caurina.transitions.Tweener;
	
	
	public class controlTab extends MovieClip {
		public var libObj = LibraryObject;
		public var blkCsr:blockChooser;
		public var rcdBtn:recordBtn;
		public var cntObj:connectObj;
		public var looper:repeatObject;
		public var tickAmnt:Number = 24;
		public var selectedBlock:Number;
		private var heldY:Number;
		private var leftBound:Number = -480;
		private var rightBound:Number = 460;
		public var heldTap:Number;
		public var mainObj:main;
		
		
		public function controlTab(ego:main, lastTapedPad:Number) {
			mainObj = ego;
			heldTap = lastTapedPad;
			// constructor code
			//trace('a control tab was loaded in...');
			//trace(MovieClip(parent));
		}
		
		public function populateObject(objStr:Number){

			if(objStr == 1){
				
				showChooser("SELECT BLOCK: "+heldTap);
				//
				cntObj = new connectObj(this, mainObj);
				this.addChild(cntObj);
				cntObj.x = -445;
				cntObj.loginBtn.btnText.text = "LOGIN";
				trace("what is looper? ", looper);

				
			}else if(objStr == 2){
				
				looper = new repeatObject(mainObj);
				this.addChild(looper);
				looper.y = looper.y-20;

				trace("what is looper? ", looper);
				
			}else if(objStr == 3){
				showChooser("SELECT BLOCK: "+heldTap);
				libObj = new LibraryObject(mainObj, blkCsr);
				this.addChild(libObj);
				libObj.y = libObj.y+128;
				libObj.x = libObj.x+30;
				trace("what is looper? ", looper);
			}
		}

		private function showChooser(bTitle:String){
			//add the block chooser
			blkCsr = new blockChooser(mainObj, heldTap);
			this.addChild(blkCsr);
			blkCsr.x = 12;
			blkCsr.y = -247;
			blkCsr.hudText.text = bTitle;
			
						
			
			
		}
		
		
		
		
	}
	
}
