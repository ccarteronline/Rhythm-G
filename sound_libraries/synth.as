//Default Drums:
package sound_libraries{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class synth{
	
		var myDrum_1 = new mSynth_1();
		var myDrum_2 = new mSynth_2();
		var myDrum_3 = new mSynth_3();
		var myDrum_4 = new mSynth_4();
		var myDrum_5 = new mSynth_5();
		var myDrum_6 = new mSynth_6();
		var myDrum_7 = new mSynth_7();
		var myDrum_8 = new mSynth_8();
		var myDrum_9 = new mSynth_9();
		var myDrum_10 = new mSynth_10();
		var myDrum_11 = new mSynth_11();
		var myDrum_12 = new mSynth_12();
		var myDrum_13 = new mSynth_13();
		var myDrum_14 = new mSynth_14();
		var myDrum_15 = new mSynth_15();
		var myDrum_16 = new mSynth_16();
		var myDrum_17 = new mSynth_17();
		var myDrum_18 = new mSynth_18();
		var myDrum_19 = new mSynth_19();
		var myDrum_20 = new mSynth_20();
		var myDrum_21 = new mSynth_21();
		var myDrum_22 = new mSynth_22();
		var myDrum_23 = new mSynth_23();
		var myDrum_24 = new mSynth_24();
		
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