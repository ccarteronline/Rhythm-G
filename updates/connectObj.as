package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class connectObj extends MovieClip {
		
		public var loginDia:loginObj;
		
		public function connectObj() {
			// constructor code
			trace('login', loginBtn);
			loginBtn.addEventListener(MouseEvent.CLICK, bringUpLogin);
		}
		
		private function bringUpLogin(e:MouseEvent){
			loginDia = new loginObj();
			stage.addChild(loginDia);
			loginDia.x = 568;
			loginDia.y = 386;
		}
	}
	
}
