//Default Drums:
package sound_libraries{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class guitar{
	
		var myDrum_1 = new country_1();
		var myDrum_2 = new country_2();
		var myDrum_3 = new country_3();
		var myDrum_4 = new country_4();
		var myDrum_5 = new country_5();
		var myDrum_6 = new country_6();
		var myDrum_7 = new country_7();
		var myDrum_8 = new country_8();
		var myDrum_9 = new country_9();
		var myDrum_10 = new country_10();
		var myDrum_11 = new country_11();
		var myDrum_12 = new country_12();
		var myDrum_13 = new country_13();
		var myDrum_14 = new country_14();
		var myDrum_15 = new country_15();
		var myDrum_16 = new country_16();
		var myDrum_17 = new country_17();
		var myDrum_18 = new country_18();
		var myDrum_19 = new country_19();
		var myDrum_20 = new country_20();
		var myDrum_21 = new country_21();
		var myDrum_22 = new country_22();
		var myDrum_23 = new country_23();
		var myDrum_24 = new country_24();
		
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