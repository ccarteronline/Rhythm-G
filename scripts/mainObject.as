﻿package  {	import flash.display.MovieClip;	import flash.media.Microphone;	import flash.media.SoundMixer;	import flash.events.MouseEvent;	import flash.utils.ByteArray;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.events.SampleDataEvent;	import flash.media.AudioPlaybackMode;	import flash.events.Event;	import flash.display.MovieClip;	import flash.ui.Multitouch;	import flash.ui.MultitouchInputMode; 	import caurina.transitions.Tweener;	import Gestures.GestureProxy;	import Gestures.GestureProxyEvent;	import flash.media.SoundChannel;	import sound_libraries.drums;	import sound_libraries.misc;	import sound_libraries.synth_1;	import sound_libraries.synth_2;	//record sequence class	import recordSequence;				public class mainObject extends MovieClip {		//possibly move these sounds to a different location		var onlineSound_1:Sound = new Sound();		var onlineSound_2:Sound = new Sound();		var onlineSound_3:Sound = new Sound();		var onlineSound_4:Sound = new Sound();		var onlineSound_5:Sound = new Sound();		var onlineSound_6:Sound = new Sound();		var onlineSound_7:Sound = new Sound();		var onlineSound_8:Sound = new Sound();		var onlineSound_9:Sound = new Sound();		var onlineSound_10:Sound = new Sound();		var onlineSound_11:Sound = new Sound();		var onlineSound_12:Sound = new Sound();		var onlineSound_13:Sound = new Sound();		var onlineSound_14:Sound = new Sound();		var onlineSound_15:Sound = new Sound();		var onlineSound_16:Sound = new Sound();		var onlineSound_17:Sound = new Sound();		var onlineSound_18:Sound = new Sound();		var onlineSound_19:Sound = new Sound();		var onlineSound_20:Sound = new Sound();		var onlineSound_21:Sound = new Sound();		var onlineSound_22:Sound = new Sound();		var onlineSound_23:Sound = new Sound();		var onlineSound_24:Sound = new Sound();								var onlineChannel:SoundChannel = new SoundChannel();				//default variables.		var __root = MovieClip(root);		var prefix= "block_";				var moveLeftVar;//move left multiGesture		var moveRightVar;//move right multiGesture		var currentBlock:Number = 1;		var nowRecording:Boolean = false;		var nowPlaying:Boolean = false;						var customLib_1:Boolean = true;//The default libary that is set on load is the first one.		var customLib_2:Boolean;		var customLib_3:Boolean;		var customLib_4:Boolean;				var shortSoundState:Boolean = false;				var tapRecordState:Boolean = false;		var myRecorder:recorder = new recorder(currentBlock);				var myDrums:drums = new drums();		var mySynth_1:synth_1 = new synth_1();		var mySynth_2:synth_2 = new synth_2();		var miscSounds:misc = new misc();						var dialBoundaryState_1:Boolean = false;		var dialBoundaryState_2:Boolean = false;		var appCurrentSlide:Number = 1;		var sequenceGod:recordSequence = new recordSequence();		public function mainObject() {			// constructor code			include "buttonControl.as";			include "multiTouch.as";			include "settingsPad.as";									Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;//allow touch																			buttonControl(true);			multiTouchGestures(true);			settingsPad(true);		}//end function									}//end class	}//end package