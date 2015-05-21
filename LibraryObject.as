package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.net.SharedObject;
	
	public class LibraryObject extends MovieClip {
		
		private var mainObj:main;
		private var blkCsr:blockChooser;
		public var listedLibrarys:Array = ["Basic Drums", "More Drums", "Synth", "Western/Funk"];
		public var libIcons:Number = listedLibrarys.length;
		public var btnPrx:String = "libIcon_";
		public var connectSave:SharedObject = SharedObject.getLocal("connectObject"); 
		public var tutorialState:SharedObject = SharedObject.getLocal("tutorialState");
		public var isApplyAll:Boolean = false;
		public var numBlocks:Number = 24;
		
		public function LibraryObject(ego:main, blkSelector:blockChooser) {
			//pass in the root object
			mainObj = ego;
			
			//pass in the block chooser
			blkCsr = blkSelector;
			
			initLibraryButtons();
			
			applyAll.addEventListener(MouseEvent.CLICK, function(){
				
				blkCsr.changeHudText("WILL APPLY TO ALL");
				isApplyAll = true;
				//
			});
		}
		
		private function initLibraryButtons(){
			for(var t:Number = 1; t<= libIcons; t++){
				this[btnPrx + t].addEventListener(MouseEvent.CLICK, loadLibrary);
				var hldVar = (t-1);
				this[btnPrx + t].libTxt.text = listedLibrarys[hldVar];
			}
		}
		
		private function loadLibrary(e:MouseEvent){
			
			mainObj.tut.visible = false;
			tutorialState.data.isComplete = true;
			tutorialState.flush();
			
			if(isApplyAll){
				
				for(var holder:Number = 1; holder<=numBlocks; holder++){
					
					connectSave.data.prepBlockArray[holder-1].fromOnline = false;
					//set the location of the sound
					connectSave.data.prepBlockArray[holder-1].onlineLocation = null;
					connectSave.data.prepBlockArray[holder-1].libraryPrefix = e.currentTarget.name;
				}
				
			}else{

				//Manipulate and change the data then flush
				connectSave.data.prepBlockArray[blkCsr.keptBlock-1].fromOnline = false;
				//set the location of the sound
				connectSave.data.prepBlockArray[blkCsr.keptBlock-1].onlineLocation = null;
				connectSave.data.prepBlockArray[blkCsr.keptBlock-1].libraryPrefix = e.currentTarget.name;
				
			}
			connectSave.flush();
			closeObj();
			
			
			//
			
			//stage.setChildIndex(mainObj.tut, 6);
		}
		
		private function closeObj(){
			mainObj.footer.removeTabWindow();
			mainObj.showDPadButtons();
		}
	}
	
}
