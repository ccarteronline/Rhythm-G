package  {
	
	import flash.display.MovieClip;
	import flash.media.Microphone;
	import flash.utils.ByteArray;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.SoundMixer;
	import flash.media.AudioPlaybackMode;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class main extends MovieClip {
		const DELAY_LENGTH:int = 4000; 
		
		public var mic:Microphone;
		public var nowRecording:Boolean = false;
		public var nowPlaying:Boolean = false;
		public var recordedBytes:ByteArray = new ByteArray();
		public var s:Sound = new Sound();
		public var sc:SoundChannel;
		public var timer:Timer = new Timer(DELAY_LENGTH);
		
		public function main() {
			mic = Microphone.getMicrophone();
			mic.setSilenceLevel(0, DELAY_LENGTH);
			mic.gain = 100;
			mic.rate = 44;
			
			SoundMixer.useSpeakerphoneForVoice = true;
			SoundMixer.audioPlaybackMode = AudioPlaybackMode.MEDIA;
			
			btn1.addEventListener(MouseEvent.CLICK, onRec);
			btn2.addEventListener(MouseEvent.CLICK, onPlay);
		}
		
		public function onRec(e:MouseEvent) {
			if (!nowRecording) {
				trace("recording");
				recordedBytes.position = 0;
				recordedBytes.length = 0;
				mic.addEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
				nowRecording = true;
				
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
				timer.start();
			} else {
				trace('stop, you have already recorded');
			}
		}
		
		public function timerHandler(e:TimerEvent){
			mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, getMicAudio);
			timer.stop();
			recordedBytes.position = 0;
			s.addEventListener(SampleDataEvent.SAMPLE_DATA, playAudio);
			sc = s.play();
			sc.addEventListener(Event.SOUND_COMPLETE, playbackComplete); 
			
		}
		
		public function onPlay(e:MouseEvent) {
			if (nowPlaying) {
				trace("stopped");
				sc.stop();
				s.removeEventListener(SampleDataEvent.SAMPLE_DATA, playAudio);
				nowPlaying = false;
				
			} else {
				trace("playing");
				recordedBytes.position = 0;
				s.addEventListener(SampleDataEvent.SAMPLE_DATA, playAudio);
				sc = s.play();
				//sc.addEventListener(Event.SOUND_COMPLETE, onComplete,false,0,true);
				nowPlaying = true;
			}
		}
		
		public function onComplete(e:Event) {
			trace("stopped");
			s.removeEventListener(SampleDataEvent.SAMPLE_DATA, playAudio);
			nowPlaying = false;
		}
		
		public function getMicAudio(e:SampleDataEvent) {
			//recordedBytes.writeBytes(e.data);
			
			while(e.data.bytesAvailable){
				var sample:Number = e.data.readFloat();
				recordedBytes.writeFloat(sample);
			}
		}
		
		public function playAudio(e:SampleDataEvent) {
			for (var i:int = 0; i < 8192 && recordedBytes.bytesAvailable > 0; i++) {
				trace(sample);
				var sample:Number = recordedBytes.readFloat();
				e.data.writeFloat(sample);
				e.data.writeFloat(sample);
			}
		}
		
		public function playbackComplete(e:Event ):void 
		{ 
			trace( "Playback finished."); 
		}
		
		
	}
	
}
