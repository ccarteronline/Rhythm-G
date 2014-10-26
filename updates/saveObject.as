package  {
	
	public class saveObject {
		
		public var lastTapped:Number = 1;
		private var _topLevel:main;
		
		public function saveObject() {
			// constructor code
			trace('initiated save object');
			
		}
		
		public function runThroughInstance(mainObject:main){
			_topLevel = mainObject;
			trace(_topLevel);
		}

	}
	
}
