package  {
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	
	public class saveObject {
		
		private var _topLevel:main;
		private var rPath:String = "rhythm-g.file";
		public var blockArray:Array = [
			{
				"block" : 1,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 2,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 3,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 4,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 5,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 6,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 7,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 8,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 9,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 10,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 11,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 12,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 13,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 14,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 15,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 16,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 17,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 18,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 19,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 20,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 21,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 22,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 23,
				"recorded" : false,
				"recordedSound" : null
			},
			{
				"block" : 24,
				"recorded" : false,
				"recordedSound" : null
			}
		];
		
		public function saveObject() {
			// constructor code
			trace('initiated save object');
			
		}
		
		public function runThroughInstance(mainObject:main){
			_topLevel = mainObject;
		}
		
		public function writeObject(){
			var object:Object = new Object();//create new object to store
			object.heldItem = [
			{
				"block": 1
			},
			{
				"block" : 2
			}];
			
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
				trace(object.heldItem[1].block);
			}
		}

	}
	
}
