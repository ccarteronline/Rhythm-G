﻿package sound_libraries{
			synthChannel = this["mySynth_b_"+passNum].play();
		//end function
		public function loopSynth(passNum:Number){
			synthChannel = this["mySynth_b_"+passNum].play(0,9999);
		}
		