﻿package sound_libraries{
			synthChannel = this["mySynth_a_"+passedNum].play();
		
		public function loopSynth(passedNum:Number){
			synthChannel = this["mySynth_a_" +passedNum].play(0,9999);			
		}