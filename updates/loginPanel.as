package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;

	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import com.adobe.serialization.json.JSON;
	import flash.net.URLVariables;
	
	
	public class loginPanel extends MovieClip {
		
		
		public function loginPanel() {
			// constructor code
			trace('loaded panel');
			cancelBtn.btnTitle.text = "CANCEL";
			
			cancelBtn.addEventListener(MouseEvent.CLICK, closeMenu);
			loginBtn.addEventListener(MouseEvent.CLICK, loginAndLoadSounds);
		}
		
		private function closeMenu(e:MouseEvent){
			closeOutMenu();
		}
		
		private function loginAndLoadSounds(e:MouseEvent){
			initLoaderCheck();
		}
		
		public function closeOutMenu(){
			stage.removeChild(MovieClip(parent));
		}
		
		private function initLoaderCheck(){
			
			
			var r:URLRequest = new URLRequest("http://rhythm-g.com/includes/rgService.php?usrname="+usrname.text+"&password="+pwd.text);
	
			r.method = URLRequestMethod.GET;
			 
			var l:URLLoader = new URLLoader();
			l.dataFormat = URLLoaderDataFormat.TEXT;
			
			l.addEventListener(Event.COMPLETE, function(e:Event) {
				trace("success", l.data);
				
				
				
				var stringJSON:String = l.data as String;
				var jsonData:Object = JSON.parse(stringJSON);
				var testmsg = JSON.stringify(jsonData,null,4);
				
				//trace(jsonData.username);
				//trace(jsonData.password);
				
	
			});
			l.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event) {
				trace("failed", e);
			});
			l.load(r);
		}
		

	}
	
}
