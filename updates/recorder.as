package  {
    import flash.media.Microphone;
    import flash.events.SampleDataEvent;
    import flash.utils.ByteArray;
    import flash.events.Event;
    import flash.media.SoundMixer;
    import flash.media.AudioPlaybackMode;
    import flash.media.Sound;
    import flash.media.SoundChannel;
	import saveObject;
    
    public class recorder {
        public var mic:Microphone;//device microphone
        public var nowRecording:Boolean = false;
        public var nowPlaying:Boolean;
        public var heldBlockNum:Number;
		public var mainObj:main;
        
        public var recordedBytes_1:ByteArray; //= new ByteArray();
        public var sc_1:SoundChannel;
        public var sound_1:Sound;
        public var recordedSoundState_1:Boolean = false;
		
		public var recordedBytes_2:ByteArray; //= new ByteArray();
        public var sc_2:SoundChannel;
        public var sound_2:Sound;
        public var recordedSoundState_2:Boolean = false;
		
		public var recordedBytes_3:ByteArray; //= new ByteArray();
        public var sc_3:SoundChannel;
        public var sound_3:Sound;
        public var recordedSoundState_3:Boolean = false;
		
		public var recordedBytes_4:ByteArray; //= new ByteArray();
        public var sc_4:SoundChannel;
        public var sound_4:Sound;
        public var recordedSoundState_4:Boolean = false;
		
		public var recordedBytes_5:ByteArray; //= new ByteArray();
        public var sc_5:SoundChannel;
        public var sound_5:Sound;
        public var recordedSoundState_5:Boolean = false;
		
		public var recordedBytes_6:ByteArray; //= new ByteArray();
        public var sc_6:SoundChannel;
        public var sound_6:Sound;
        public var recordedSoundState_6:Boolean = false;
		
		public var recordedBytes_7:ByteArray; //= new ByteArray();
        public var sc_7:SoundChannel;
        public var sound_7:Sound;
        public var recordedSoundState_7:Boolean = false;
		
		public var recordedBytes_8:ByteArray; //= new ByteArray();
        public var sc_8:SoundChannel;
        public var sound_8:Sound;
        public var recordedSoundState_8:Boolean = false;
		
		public var recordedBytes_9:ByteArray; //= new ByteArray();
        public var sc_9:SoundChannel;
        public var sound_9:Sound;
        public var recordedSoundState_9:Boolean = false;
		
		public var recordedBytes_10:ByteArray; //= new ByteArray();
        public var sc_10:SoundChannel;
        public var sound_10:Sound;
        public var recordedSoundState_10:Boolean = false;
		
		public var recordedBytes_11:ByteArray; //= new ByteArray();
        public var sc_11:SoundChannel;
        public var sound_11:Sound;
        public var recordedSoundState_11:Boolean = false;
		
		public var recordedBytes_12:ByteArray; //= new ByteArray();
        public var sc_12:SoundChannel;
        public var sound_12:Sound;
        public var recordedSoundState_12:Boolean = false;
		
		public var recordedBytes_13:ByteArray; //= new ByteArray();
        public var sc_13:SoundChannel;
        public var sound_13:Sound;
        public var recordedSoundState_13:Boolean = false;
		
		public var recordedBytes_14:ByteArray; //= new ByteArray();
        public var sc_14:SoundChannel;
        public var sound_14:Sound;
        public var recordedSoundState_14:Boolean = false;
		
		public var recordedBytes_15:ByteArray; //= new ByteArray();
        public var sc_15:SoundChannel;
        public var sound_15:Sound;
        public var recordedSoundState_15:Boolean = false;
		
		public var recordedBytes_16:ByteArray; //= new ByteArray();
        public var sc_16:SoundChannel;
        public var sound_16:Sound;
        public var recordedSoundState_16:Boolean = false;
		
		public var recordedBytes_17:ByteArray; //= new ByteArray();
        public var sc_17:SoundChannel;
        public var sound_17:Sound;
        public var recordedSoundState_17:Boolean = false;
		
		public var recordedBytes_18:ByteArray; //= new ByteArray();
        public var sc_18:SoundChannel;
        public var sound_18:Sound;
        public var recordedSoundState_18:Boolean = false;
		
		public var recordedBytes_19:ByteArray; //= new ByteArray();
        public var sc_19:SoundChannel;
        public var sound_19:Sound;
        public var recordedSoundState_19:Boolean = false;
		
		public var recordedBytes_20:ByteArray; //= new ByteArray();
        public var sc_20:SoundChannel;
        public var sound_20:Sound;
        public var recordedSoundState_20:Boolean = false;
		
		public var recordedBytes_21:ByteArray; //= new ByteArray();
        public var sc_21:SoundChannel;
        public var sound_21:Sound;
        public var recordedSoundState_21:Boolean = false;
		
		public var recordedBytes_22:ByteArray; //= new ByteArray();
        public var sc_22:SoundChannel;
        public var sound_22:Sound;
        public var recordedSoundState_22:Boolean = false;
		
		public var recordedBytes_23:ByteArray; //= new ByteArray();
        public var sc_23:SoundChannel;
        public var sound_23:Sound;
        public var recordedSoundState_23:Boolean = false;
		
		public var recordedBytes_24:ByteArray; //= new ByteArray();
        public var sc_24:SoundChannel;
        public var sound_24:Sound;
        public var recordedSoundState_24:Boolean = false;
		
		public var storedObj:saveObject = new saveObject();
		
		public var isTimeToRemove:Boolean = false;
        
        public function recorder(ego:main, onNumBlock:Number) {
			mainObj = ego;
            // constructor code
            trace("init Recorder", onNumBlock);
            
            heldBlockNum = onNumBlock;
            
            SoundMixer.audioPlaybackMode = AudioPlaybackMode.MEDIA;
    
            mic = Microphone.getMicrophone();
            SoundMixer.useSpeakerphoneForVoice = true;
            
            mic.gain = 50;
            mic.setSilenceLevel(5);
            mic.rate = 44;
			
        }
        
        
        public function resetSoundVar(s:Number){
            this["recordedBytes_" + s] = null;
            this["sc_"+ s] = null;
            this["sound_" +s] = null;
            
            this["recordedBytes_" + s] = new ByteArray();
            this["sc_"+ s] = new SoundChannel();
            this["sound_" +s] = new Sound();
            
        }
        
        public function recordSound(myBlockNumb:Number){
			heldBlockNum = myBlockNumb;
			
            if(nowRecording){
                //Stop Recording here
                mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
                this.nowRecording= false;
                this["recordedBytes_" + myBlockNumb].position = 0;
                this["recordedSoundState_" + myBlockNumb] = true;
                this["sound_" + myBlockNumb].addEventListener(SampleDataEvent.SAMPLE_DATA, arrangeAudio);
		
                playAudio(myBlockNumb);
                
                    
            }else{
				//Start Recording here.
                resetSoundVar(myBlockNumb);
                //var myFunction = this["playAudio_" + myBlockNumb];
               // this["sound_" + myBlockNumb].removeEventListener(SampleDataEvent.SAMPLE_DATA, arrangeAudio);
                
                this["recordedBytes_" + myBlockNumb].position = 0;
                this['recordedBytes_' + myBlockNumb].clear();
                
                mic.addEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
                
                
                
                this.nowRecording = true;
                
            }
        }
        
        public function getMicAudio(e:SampleDataEvent){
            //write the data using the passThisNumber to its specific bank
            this["recordedBytes_" + heldBlockNum].writeBytes(e.data);
			
			//store the sound
			//storedObj.writeObject(this["recordedBytes_" + heldBlockNum]);
        }
        
        public function onComplete(e:Event= null){
            trace("stopped");
            this["sound_" + heldBlockNum].removeEventListener(SampleDataEvent.SAMPLE_DATA, this["playAudio_"+ heldBlockNum]);
            
            nowPlaying = false;
            trace("what is the number?" + heldBlockNum);
        }
        
        
        
        public function arrangeAudio(e:SampleDataEvent){
            for(var i:int = 0; i< 8192 && this["recordedBytes_" +heldBlockNum].bytesAvailable > 0; i++){
                var sample:Number = this["recordedBytes_" +heldBlockNum].readFloat();
                e.data.writeFloat(sample);
                e.data.writeFloat(sample);
                /*remove one to make faster sound ? */
            }
        }
        
        public function stopRecording(){
            this["sc_" + heldBlockNum].stop();
            this["recordedBytes_" + heldBlockNum].position = 0;
        }
        
        public function playAudio(soundNum:Number){
            //
			this["sound_" + soundNum].addEventListener(SampleDataEvent.SAMPLE_DATA, arrangeAudio);
            this["sc_" + soundNum].stop();
            this["recordedBytes_" + soundNum].position = 0;
            this["sc_" + soundNum] = this["sound_" + soundNum].play();
			//trace("main object: ", mainObj.sound_1);
			//mainObj.sound_1 = this["sound_" + soundNum];
			this["sc_" + soundNum].addEventListener(Event.SOUND_COMPLETE, removeThisObject, false, 0, true);
        }
		
		public function removeThisObject(e:Event){
			trace('delete itself');
			
			isTimeToRemove = true;
		}
    }
    
}
