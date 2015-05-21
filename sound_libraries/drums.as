//Default Drums:
package sound_libraries{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class drums{
	
		var myDrum_1 = new bank_1();
		var myDrum_2 = new bank_2();
		var myDrum_3 = new bank_3();
		var myDrum_4 = new bank_4();
		var myDrum_5 = new bank_5();
		var myDrum_6 = new bank_6();
		var myDrum_7 = new bank_7();
		var myDrum_8 = new bank_8();
		var myDrum_9 = new bank_9();
		var myDrum_10 = new bank_10();
		var myDrum_11 = new bank_11();
		var myDrum_12 = new bank_12();
		var myDrum_13 = new bank_13();
		var myDrum_14 = new bank_14();
		var myDrum_15 = new bank_15();
		var myDrum_16 = new bank_16();
		var myDrum_17 = new bank_17();
		var myDrum_18 = new bank_18();
		var myDrum_19 = new bank_19();
		var myDrum_20 = new bank_20();
		var myDrum_21 = new bank_21();
		var myDrum_22 = new bank_22();
		var myDrum_23 = new bank_23();
		var myDrum_24 = new bank_24();
		
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