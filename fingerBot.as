package  {
	import flash.net.SharedObject;
	
	public class fingerBot {
		public var connectSave:SharedObject = SharedObject.getLocal("connectObject");
		public var mainObj:main;
		public var prepBlockArray = [
			{
				"block" : 1,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 2,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 3,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 4,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 5,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 6,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 7,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 8,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 9,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 10,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 11,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 12,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 13,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 14,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 15,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 16,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 17,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 18,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 19,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 20,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 21,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 22,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 23,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			},
			{
				"block" : 24,
				"fromOnline" : false,
				"onlineLocation" : null,
				"libraryPrefix" : "libIcon_1"
			}
		];
			
			
		public function fingerBot(ego:main) {
			// constructor code
			//trace(prepBlockArray);
			mainObj = ego;
			
		}
		
		public function initDefaultSet(){
			connectSave.data.prepBlockArray = prepBlockArray;
			connectSave.flush();
			//trace(connectSave.data.prepBlockArray);
		}
		
		public function getStoredMPCArray(){
			return connectSave.data.prepBlockArray;
		}
		
		public function saveKeyToArray(num:Number, yhgr:String, objValue){
			
			prepBlockArray[num-1].yhgr = objValue;
			//trace(prepBlockArray[num-1].yhgr);
			//trace(prepBlockArray[num-1]);
			
			connectSave.data.prepBlockArray[num-1].yhgr = objValue;
			connectSave.flush();
			//
			mainObj.connectSave.data.prepBlockArray[num-1].yhgr = objValue;
			mainObj.connectSave.flush();
		}

	}
	
}
