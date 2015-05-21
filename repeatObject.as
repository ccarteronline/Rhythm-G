package  {
	
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.display.Stage;
	import flash.net.SharedObject;
	
	
	public class repeatObject extends MovieClip {
		
		public var heldX:Number = -529.55;
		public var endTickerX:Number = 540;
		public var numOfBlocks:Number = 160;
		public var blocksPerMeasure:Number = 16;
		public var tickerSpeed:Number = 16;
		public var maxIncreaseNum:Number = 24;
		public var minDecreaseNum:Number = 4;
		public var savedNotes:SharedObject = SharedObject.getLocal('savedNotes');	
		public var tempArray = [];	
		public var mpcButtonObj:mpcPad;
		public var mainObj:main;
		
		public function repeatObject(ego) {
			// constructor code
		
			
			mainObj = ego;
			mpcButtonObj = new mpcPad(ego);
			//mainObj.dPadIsOpen = true;
			
			////////////////////////////////////////////////////////////////////////////////////////////
			
			//Set ticker speed
			initTickerSpeedAdjust();
			
			startBtn.addEventListener(MouseEvent.CLICK, function(e){
				
				//allow next on tutorial
				mainObj.tut.showNext();
				
				if(e.currentTarget.currentFrame == 1){
					e.currentTarget.gotoAndStop(2);
					startTickerAnimation();
				}else{
					e.currentTarget.gotoAndStop(1);
					forceStop();
				}
				
			});
			
			//assign onclick events for squares
			squareTapInit();
			
			//place the row number inside each block so that ticker will know what sound to play
			buildRows();
			
			getStoredBlockValues();
			
		}
		
		public function setStoredBlockValues(blockHitted:Number, blockState:Number){
			
			trace("go, set ye this block: ", blockHitted);
			tempArray[blockHitted-1] = blockState; 
			savedNotes.data.noteSwitchArray = tempArray;
			savedNotes.flush();

		}
		public function getStoredBlockValues(){
			//trace(savedNotes.data.noteSwitchArray);
			
			//savedNotes.data.noteSwitchArray = undefined;
			//savedNotes.flush();
			
			if(!savedNotes.data.noteSwitchArray){
				
				savedNotes.data.noteSwitchArray = [];
				
				tempArray = savedNotes.data.noteSwitchArray;
				//
				for(var t:Number = 1; t<= numOfBlocks; t++){
					if(t == 113  || t == 117 || t == 121 || t == 125){
						tempArray.push(2);
					}else{
						tempArray.push(this["note_"+t].currentFrame);
					}
					
					this["note_"+t].gotoAndStop(tempArray[t-1]);
					
				}	
				//
				savedNotes.data.noteSwitchArray = tempArray;
				savedNotes.flush();
				
				trace(savedNotes.data.noteSwitchArray);				
			}else{
				tempArray = savedNotes.data.noteSwitchArray;
				trace(tempArray);
				
				for(var wj:Number = 1; wj<=tempArray.length; wj++){
					
					//trace(tempArray[wj-1]);
					
					this["note_"+wj].gotoAndStop(tempArray[wj-1]);
				}
				
				//
				
			}
			
			
		}
		
		public function initTickerSpeedAdjust(){
			speedText.text = tickerSpeed.toString();	
			
			increaseTime.addEventListener(MouseEvent.CLICK, function(e){
				
				if(tickerSpeed != maxIncreaseNum){
					
					tickerSpeed+= .1;
					speedText.text = tickerSpeed.toString();
					done();//restart the ticker to the beginning
					startBtn.gotoAndStop(2);//move the start button to the new frame
				}
				
			});	
			
			decreaseTime.addEventListener(MouseEvent.CLICK, function(){
				
				if(tickerSpeed != minDecreaseNum){
					
					tickerSpeed-= .1;
					speedText.text = tickerSpeed.toString();
					done();//restart the ticker to the beginning
					startBtn.gotoAndStop(2);//move the start button to the new frame
				}
				
			});
		}
		
		public function buildRows(){
			var rowCounter:Number = 1;
			var noteRowNum:Number = 1;
			
			for(var toot:Number = 1; toot<= numOfBlocks; toot++){
				this["note_"+toot].alpha = .8;
				//place the number within the block
				this["note_"+ toot].soundRow = noteRowNum;
				//show the number within the block
				this["note_"+ toot].blockRowNum.text = noteRowNum.toString();
				//
				if(rowCounter == blocksPerMeasure){
					rowCounter = 1;
					noteRowNum ++;
				}else{
					rowCounter++;
				}
			}
		}
		
		public function squareTapInit(){
			
			for(var toot:Number = 1; toot<= numOfBlocks; toot++){
				
				this["note_"+ toot].addEventListener(MouseEvent.CLICK, function(e){
					
					//trace(e.currentTarget.name.substr(5));
					if(e.currentTarget.currentFrame == 1){
						e.currentTarget.gotoAndStop(2);
						
						playSpecificSound(e.currentTarget.soundRow);
						//drumChannel = this["myDrum_"+e.target.soundRow].play();
						
					}else{
						e.currentTarget.gotoAndStop(1);
					}
					
					setStoredBlockValues(e.currentTarget.name.substr(5), e.currentTarget.currentFrame);
					
				});
			}
		}
		
		public function startTickerAnimation(){
			createListeners(numOfBlocks);
			Tweener.addTween(ticker,{x:endTickerX, time:tickerSpeed, delay:0, transition:"linear", onComplete:done});
		}
		
		private function done(){
			ticker.x = heldX;
			removeListeners();
			startTickerAnimation();
			
		}
		
		private function forceStop(){
			Tweener.removeTweens(ticker);
			ticker.x = heldX;
			
			removeListeners();
		}
		
		private function createListeners(numOfBlocks){
			for(var toot:Number = 1; toot<= numOfBlocks; toot++){
				
				this["note_"+ toot].addEventListener(Event.ENTER_FRAME, checkHit);
				this["note_"+ toot].isPlayed = false;
				
			}
		}
		private function removeListeners(){
			
			for(var toot:Number = 1; toot<= numOfBlocks; toot++){
				
				this["note_"+ toot].removeEventListener(Event.ENTER_FRAME, checkHit);
				this["note_"+ toot].isPlayed = false;
			}
		}
		
		private function checkHit(e:Event){
			if(e.target.hitTestObject(ticker)){
				
				if(!e.target.isPlayed && e.target.currentFrame == 2){
					
					//e.target.name.substring(5);
					
					//drumChannel = this["myDrum_"+e.target.soundRow].play();
					playSpecificSound(e.target.soundRow);
					
					e.target.isPlayed = true;
					
				}
			}
			
			if(mainObj.toRemoveRepeatObject){
				trace('DELETE!');
				forceStop();
			}
			
		}
		
		private function playSpecificSound(blockNum:Number){
			//drumChannel = this["myDrum_"+blockNum].play();
			trace('init play on this sound: ', blockNum);
			
			mpcButtonObj.globalPlayControl(blockNum);
		}
	}
	
}
