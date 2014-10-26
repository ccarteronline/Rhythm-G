package  {
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	
	public class saveObject {
		
		private var _topLevel:main;
		private var rPath:String = "rhythm-g.file";
		
		public function saveObject() {
			// constructor code
			trace('initiated save object');
			
		}
		
		public function runThroughInstance(mainObject:main){
			_topLevel = mainObject;
		}
		
		public function writeObject(){
			var object:Object = new Object();//create new object to store
			object.value = "storedString";
			
			var file:File = File.applicationStorageDirectory.resolvePath(rPath);
			if(file.exists){
				file.deleteFile();
			}
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeObject(object);
			fileStream.close();
			
		}
		
		public function readObject(){
			var file:File = File.applicationStorageDirectory.resolvePath(rPath);
			if(!file.exists){
				trace('There is no object saved');
			}else{
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				var object:Object = fileStream.readObject();
				trace(object.value);
			}
		}

	}
	
}
