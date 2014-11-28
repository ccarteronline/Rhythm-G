package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	public class LibraryObject extends MovieClip {
		
		private var mainObj:main;
		private var blkCsr:blockChooser;
		public var listedLibrarys:Array = ["Drum Kit 1", "Drum Kit 2", "Synth 1", "Synth 2"];
		public var libIcons:Number = listedLibrarys.length;
		public var btnPrx:String = "libIcon_";
		
		public function LibraryObject(ego:main, blkSelector:blockChooser) {
			//pass in the root object
			mainObj = ego;
			
			//pass in the block chooser
			blkCsr = blkSelector;
			
			initLibraryButtons()
		}
		
		private function initLibraryButtons(){
			for(var t:Number = 1; t<= libIcons; t++){
				this[btnPrx + t].addEventListener(MouseEvent.CLICK, loadLibrary);
				var hldVar = (t-1);
				this[btnPrx + t].libTxt.text = listedLibrarys[hldVar];
			}
		}
		
		private function loadLibrary(e:MouseEvent){
			trace(e.currentTarget.name);
			
			mainObj.libraryLoaded = "held";
			trace(blkCsr.keptBlock);
			
			closeObj();
		}
		
		private function closeObj(){
			mainObj.footer.removeTabWindow();
			mainObj.showDPadButtons();
		}
	}
	
}
