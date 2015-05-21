//Default Drums:
package sound_libraries{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class moreDrums{
	
		var myDrum_1 = new mDrum_1();
		var myDrum_2 = new mDrum_2();
		var myDrum_3 = new mDrum_3();
		var myDrum_4 = new mDrum_4();
		var myDrum_5 = new mDrum_5();
		var myDrum_6 = new mDrum_6();
		var myDrum_7 = new mDrum_7();
		var myDrum_8 = new mDrum_8();
		var myDrum_9 = new mDrum_9();
		var myDrum_10 = new mDrum_10();
		var myDrum_11 = new mDrum_11();
		var myDrum_12 = new mDrum_12();
		var myDrum_13 = new mDrum_13();
		var myDrum_14 = new mDrum_14();
		var myDrum_15 = new mDrum_15();
		var myDrum_16 = new mDrum_16();
		var myDrum_17 = new mDrum_17();
		var myDrum_18 = new mDrum_18();
		var myDrum_19 = new mDrum_19();
		var myDrum_20 = new mDrum_20();
		var myDrum_21 = new mDrum_21();
		var myDrum_22 = new mDrum_22();
		var myDrum_23 = new mDrum_23();
		var myDrum_24 = new mDrum_24();
		
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