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
	import sound_libraries.moreDrums;
	import sound_libraries.synth;
	import sound_libraries.guitar;
	import flash.net.URLRequest;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	
	public class mpcPad extends MovieClip {
		
		public var numObjects:Number = 24;
		public var pfx:String = "block_";
		public var calledToBuildDPad:Boolean = false;
		public var lastTappedNum:Number;
		public var rg_pad:mpcPad;
		public var keptStage:Stage;
		public var mainObj:main;
		public var mpcChannel:SoundChannel = new SoundChannel();
		public var connectSave:SharedObject = SharedObject.getLocal("connectObject");
		public var storedSoundArray = [""]
		
	
		
		//Create variables for sound libraries
		var myDrums:drums = new drums();
		var otherDrums:moreDrums = new moreDrums();
		var synthLib:synth = new synth();
		var countryLib:guitar = new guitar();
		
		public var prepBlockArray = [];
		
		
		public function mpcPad(ego:main) {
	
			detailbuttons();
			this.addEventListener(Event.ENTER_FRAME, tellBlock);
		
			mainObj = ego;
			
			//You must reset this line to reset the saved Pad variable below
			getCurrentPad();
			
		
			
			
		}
		
	
		public function refreshPadFromClear(){
			//garabageDump();
			getCurrentPad();
			Tweener.addTween(rg_pad,{alpha:0, delay:0, time:1, transition:"easeInOutBack", onComplete:fadeIn});
		}
		private function fadeIn(){
			Tweener.addTween(rg_pad,{alpha:1, delay:0, time:1, transition:"easeInOutBack"});
		}
		
		public function getCurrentPad(){
			prepBlockArray = mainObj.connectSave.data.prepBlockArray;
			mainObj.connectSave.flush();
			
			for(var cnt:Number=1; cnt<= prepBlockArray.length; cnt++){
				if(prepBlockArray[cnt-1].fromOnline){
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
			Tweener.addTween(rg_pad,{x:550, y:350, scaleX:0, scaleY:0, alpha:0, time:0.3, delay:0, transition:"linear", onComplete:garabageDump});
			
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
			
			Tweener.addTween(rg_pad,{x:-55, y:-30, scaleX:1, scaleY:1, alpha:1, time:.5, delay:0, transition:"easeOutCubic"});

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
			//Init tutorial next
			mainObj.tut.showNext();
			e.currentTarget.gotoAndStop(2);
			
			var gotcha = e.currentTarget.numUnder.text.split(".").join("");
			gotcha = Number(gotcha);
			lastTappedNum = gotcha;
			//setLastTappedButton(gotcha);
			
			mainObj.lastTappedButton = lastTappedNum;
			
			
			//play drums


			if(e.currentTarget.onlineButton.alpha == 1){
				playOnlinePart(connectSave.data.prepBlockArray[lastTappedNum-1].onlineLocation);
				
			}else{
				shiftThroughLibs(lastTappedNum);
				
			}
		}
		
		public function shiftThroughLibs(lastTappedNum){
			if(connectSave.data.prepBlockArray[lastTappedNum-1].libraryPrefix == "libIcon_1"){
					
					myDrums.playDrums(lastTappedNum);
					
			}else if(connectSave.data.prepBlockArray[lastTappedNum-1].libraryPrefix == "libIcon_2"){
				
					otherDrums.playDrums(lastTappedNum);
				
			}else if(connectSave.data.prepBlockArray[lastTappedNum-1].libraryPrefix == "libIcon_3"){
				
					synthLib.playDrums(lastTappedNum);
				
			}else if(connectSave.data.prepBlockArray[lastTappedNum-1].libraryPrefix == "libIcon_4"){
					countryLib.playDrums(lastTappedNum);

				
			}
		}
		
		public function globalPlayControl(svdNum:Number){
			
			trace('hello you selected', svdNum);
			lastTappedNum = svdNum;
			
			if(this[pfx+svdNum].onlineButton.alpha == 1){
				trace('is visible show me');
				playOnlinePart(connectSave.data.prepBlockArray[lastTappedNum-1].onlineLocation);
				
			}else{
				shiftThroughLibs(lastTappedNum);
			}
			
		}
		
		
		public function playOnlinePart(songLocation:String){
			//
			//trace(songLocation);
			//if sound has already been loaded, play it otherwise load it and play
			if(mainObj["onlineSoundLoaded_" + lastTappedNum] == true){
				
				mainObj["onlSound_" + lastTappedNum].play();
				
			}else{
				var req:URLRequest = new URLRequest(songLocation);
			
				//trace(lastTappedNum);
				mainObj["onlSound_" + lastTappedNum] = new Sound();
				
				try {
					mainObj["onlSound_" + lastTappedNum].load(req);            
					
				}
					catch (err:Error) {
					trace(err.message);
				}
				
				mainObj["onlSound_" + lastTappedNum].addEventListener(Event.COMPLETE, function(e){
					trace(e);
					trace("Loaded sound");
					//store this in 
					mainObj["onlineSoundLoaded_" + lastTappedNum] = true;
				});
	
				
				mainObj["onlSound_" + lastTappedNum].play();
			}
			
			
			
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
