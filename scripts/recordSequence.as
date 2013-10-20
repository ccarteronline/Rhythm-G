//Record Sequence Class

package{
	import flash.events.Event;
	import flash.display.MovieClip;


	public class recordSequence extends MovieClip{
		public var sequenceCount:Number = 0;//Create a variable to count how many sequences there are
		public var isRecording:Boolean = false;//by default, the user isnt recording
		private var sequenceAdder:Boolean = false;//by defualt the user hasnt enabled the sequencer adder
		
		public function recordSequence(){
			trace("Welcome create a new sequence");
		}
		public function create(){
			sequenceAdder = true;
			isRecording = true;
			sequenceCount++;
			listenForUserEvents(sequenceCount);
			trace("I have created a new sequence" +sequenceCount);
			
			return sequenceCount;
		}
		private function listenForUserEvents(sequenceCount:Number){
			trace("Listen for users input on my sequence: " + sequenceCount);
			return sequenceCount;
			
			/*var mySomething = new sequenceItem();
			mySomething.x = 0;
			mySomething.y = 0;
			addChild(mySomething);*/
			//trace(MovieClip(root).sequencePad);
			//-376.8	
			/*var mySequenceArray = new Array;
			var myCustMovieClip = new MovieClip();
			myCustMovieClip.name = ["mySeqeunce_" + sequenceCount]
			trace("what is the movieclip? " + myCustMovieClip.name);
			myCustMovieClip.addEventListener(Event.ENTER_FRAME, listenForButtons);
			function listenForButtons(){
				mySequenceArray.push("Silence");
				trace("I am listening for when the user taps something");
			}*/
		}
		public function pushIntoSequence(whichBlock){
			if(sequenceAdder){
				trace('im adding new sequncer on block: ' + whichBlock);
			}else{
				trace("sequencer is false, user hasnt enabled it");
			}
		}
	}

}