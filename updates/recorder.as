package  {
	import flash.media.Microphone;
	import flash.events.SampleDataEvent;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.AudioPlaybackMode;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class recorder {
		public var mic:Microphone;//device microphone
		public var nowRecording:Boolean = false;
		public var nowPlaying:Boolean;
		public var heldBlockNum:Number;
		
		public var recordedBytes_1:ByteArray = new ByteArray();
		public var recordedSoundState_1:Boolean = false;
		public var sc_1:SoundChannel = new SoundChannel;
		public var sound_1:Sound = new Sound();
		
		public function recorder(onNumBlock:Number) {
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
		
		public function manageRecord(myBlockNumb:Number){
			if(nowRecording){
				trace('stop recording');
				mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
				this.nowRecording= false;
				this["recordedBytes_" + myBlockNumb].position = 0;
				this["recordedSoundState_" + myBlockNumb] = true;
				var myFunction = this["playAudio_" + myBlockNumb];
				this["sound_" + myBlockNumb].addEventListener(SampleDataEvent.SAMPLE_DATA, myFunction);
				
				//if recording, STOP, then move the position of the audio back to its place
					/*trace('Stopped');
					mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
					this.nowRecording= false;
					this["recordedBytes_" + myBlockNumb].position = 0;
					//user has recorded a sound let the program know it
					this["recordedSoundState_" + myBlockNumb] = true;
					///// create the sampledata event listener after a successful recording to avoid memory leak?
					var myFunction = this["playAudio_" + myBlockNumb];
					this["sound_" + myBlockNumb].addEventListener(SampleDataEvent.SAMPLE_DATA, myFunction);*/
					
			}else{
				trace('start recording');
				this['recordedBytes_' + myBlockNumb].clear();
				mic.addEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
				this.nowRecording = true;
				
					/*trace("Recording... for block:" + myBlockNumb  );
					this['recordedBytes_' + myBlockNumb].clear();
					mic.addEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
					this.nowRecording = true;*/
			}
		}
		
		public function getMicAudio(e:SampleDataEvent){
			//write the data using the passThisNumber to its specific bank
			this["recordedBytes_" + 1].writeBytes(e.data);
		}
		
		
		public function playAudio_1(e:SampleDataEvent){
			for(var i:int = 0; i< 8192 && recordedBytes_1.bytesAvailable > 0; i++){
				var sample:Number = recordedBytes_1.readFloat();
				e.data.writeFloat(sample);
				e.data.writeFloat(sample);
			}
		}
		
		public function stopRecording(){
			this["sc_" + 1].stop();
			this["recordedBytes_" + 1].position = 0;
		}
		
		public function playAudio(soundNum:Number){
			//
			trace(soundNum);
			this["recordedBytes_" + soundNum].position = 0;
			this["sc_" + soundNum] = this["sound_" + soundNum].play();
		}
	}
	
}
