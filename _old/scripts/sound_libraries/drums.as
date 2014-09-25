//Default Drums:package sound_libraries{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class drums{
	
		var myDrum_1 = new drum_1();
		var myDrum_2 = new drum_2();
		var myDrum_3 = new drum_3();
		var myDrum_4 = new drum_4();
		var myDrum_5 = new drum_5();
		var myDrum_6 = new drum_6();
		var myDrum_7 = new drum_7();
		var myDrum_8 = new drum_8();
		var myDrum_9 = new drum_9();
		var myDrum_10 = new drum_10();
		var myDrum_11 = new drum_11();
		var myDrum_12 = new drum_12();
		var myDrum_13 = new drum_13();
		var myDrum_14 = new drum_14();
		var myDrum_15 = new drum_15();
		var myDrum_16 = new drum_16();
		var myDrum_17 = new drum_17();
		var myDrum_18 = new drum_18();
		var myDrum_19 = new drum_19();
		var myDrum_20 = new drum_20();
		var myDrum_21 = new drum_21();
		var myDrum_22 = new drum_22();
		var myDrum_23 = new drum_23();
		var myDrum_24 = new drum_24();
		
		var drumChannel:SoundChannel = new SoundChannel();

		//
		public function playDrums(myNum:Number){
			drumChannel = this["myDrum_" + myNum].play();
		}//end play drums
		public function loopDrums(myNum:Number){
			drumChannel = this["myDrum" + myNum].play(0,9999);			
		}
		public function stopDrums(){
			drumChannel.stop();
		}
	}
}