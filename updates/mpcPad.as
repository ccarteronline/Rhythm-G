package  {
	
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.events.SampleDataEvent;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import sound_libraries.drums;
	
	public class mpcPad extends MovieClip {
		
		public var numObjects:Number = 24;
		public var pfx:String = "block_";
		public var calledToBuildDPad:Boolean = false;
		public var lastTappedNum:Number;
		public var rg_pad:mpcPad;
		public var keptStage:Stage;
		public var mainObj:main;
		public var saveObj = new saveObject();
		//public var sound_1:Sound = new Sound();
		public var mpcChannel:SoundChannel = new SoundChannel();
		//public var heldBytes:ByteArray = new ByteArray();
		
		//Create variables for sound libraries
		var myDrums:drums = new drums();
		
		public var prepBlockArray = [
			{
				"block" : 1,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 2,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 3,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 4,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 5,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 6,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 7,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 8,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 9,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 10,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 11,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 12,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 13,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 14,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 15,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 16,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 17,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 18,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 19,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 20,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 21,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 22,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 23,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			},
			{
				"block" : 24,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "default_1"
			}
		];
		
		
		public function mpcPad(ego:main) {
			//this.cacheAsBitmapMatrix = this.transform.concatenatedMatrix;
			//this.cacheAsBitmap = true;
			detailbuttons();
			this.addEventListener(Event.ENTER_FRAME, tellBlock);
			//heldBytes = saveObj.readObject();
			//heldBytes.position = 0;
			//trace(heldBytes);
			//pass the main object to get its variables
			mainObj = ego;
			
			//trace(saveObj.readObject());
			//heldBytes = saveObj.readObject();
			
			getCurrentPad();
			
		}
		
		public function getCurrentPad(){
			trace('Remember, you must create it if it doesnt exist and then if it does exist, use what is there');
			for(var cnt:Number=1; cnt<= prepBlockArray.length; cnt++){
				if(prepBlockArray[cnt-1].fromOnline){
					trace('load in the specific onlinesound');
					this["block_"+cnt].onlineButton.alpha = 1;
				}else{
					//using pre-installed library
					this["block_"+cnt].libraryCon.alpha = 1;
				}
			}
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
						
			
			
			var gotcha = e.currentTarget.numUnder.text.split(".").join("");
			gotcha = Number(gotcha);
			lastTappedNum = gotcha;
			//setLastTappedButton(gotcha);
			
			mainObj.lastTappedButton = lastTappedNum;
			
			
			//play drums
			trace(mainObj.libraryLoaded);
			
			myDrums.playDrums(lastTappedNum);
		}
		
		public function initPlaySoundObjectUp(e:TouchEvent){
			e.currentTarget.gotoAndStop(1);
			
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
