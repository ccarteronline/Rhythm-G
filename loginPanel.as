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
	import flash.net.SharedObject;
	
	
	public class loginPanel extends MovieClip {
		public var numIcons:Number = 24;
		public var mainTab:controlTab;
		public var connectSave:SharedObject = SharedObject.getLocal("connectObject");
		public var rememberChecked:Boolean = false;
		
		public function loginPanel() {
			
			initButtonsAndBeginings();
		}
		
		private function initButtonsAndBeginings(){
			cancelBtn.btnTitle.text = "CANCEL";
			cancelBtn.addEventListener(MouseEvent.CLICK, closeMenu);
			loginBtn.addEventListener(MouseEvent.CLICK, loginAndLoadSounds);
			remember.addEventListener(MouseEvent.CLICK, toggleRemember);
			
			trace(connectSave.data.username);
			
			if(connectSave.data.username != undefined){
				//trace(connectSave.data.username);
				rememberChecked = true;
				remember.gotoAndStop(2);
				usrname.text = connectSave.data.username;
				pwd.text = connectSave.data.password;
				pwd.displayAsPassword  = true;
				
				//usrname.text = connectSave.data.username;
				//pwd.text = connectSave.data.password;
				
			}else{
				//resetSavedValues();
			}
			
		}
		
		private function toggleRemember(e:MouseEvent){
			
			if(rememberChecked == false){
				e.currentTarget.gotoAndStop(2);
				rememberChecked = true;

				
			}else{
				rememberChecked = false;
				e.currentTarget.gotoAndStop(1);
			}
		}
		
		private function closeMenu(e:MouseEvent){
			closeOutMenu();
		}
		
		private function loginAndLoadSounds(e:MouseEvent){
			initLoaderCheck(usrname.text, pwd.text);
		}
		
		public function closeOutMenu(){
			stage.removeChild(MovieClip(parent));
		}
		
		private function initLoaderCheck(usr:String, pass:String){
			
			var r:URLRequest = new URLRequest("http://rhythm-g.com/includes/rgService.php?usrname="+usr+"&password="+pass);
			
			r.method = URLRequestMethod.GET;
			
			var l:URLLoader = new URLLoader();
			l.dataFormat = URLLoaderDataFormat.TEXT;
			
			l.addEventListener(Event.COMPLETE, function(e:Event) {
								
				var stringJSON:String = l.data as String;
				var jsonData:Object = JSON.parse(stringJSON);
				
				//trace(jsonData.length);
				
				if(jsonData[0] == false){
					trace('Wrong Credentials');
					MovieClip(parent).panel.gotoAndStop(2);
					MovieClip(parent).panel.okBtn.btnTitle.text = "OK";
					MovieClip(parent).panel.okBtn.addEventListener(MouseEvent.CLICK, goBack);
					resetSavedValues();
					
				}else{
					
					connectSave.data.username = usrname.text;
					connectSave.data.password = pwd.text;
					connectSave.data.isRemember = true;

					connectSave.data.onlineArray = jsonData;
					
					connectSave.flush();
					closeOutMenu();
					
				}
	
			});
			l.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event) {
				trace("failed", e);
				MovieClip(parent).panel.gotoAndStop(2);
				MovieClip(parent).panel.okBtn.btnTitle.text = "OK";
				MovieClip(parent).panel.okBtn.addEventListener(MouseEvent.CLICK, goBack);
			});
			l.load(r);
		}
		
		private function goBack(e:MouseEvent){
			MovieClip(parent).panel.gotoAndStop(1);
			initButtonsAndBeginings();
			
		}
		
		public function resetSavedValues(){
			connectSave.data.username = undefined;
			connectSave.data.password = undefined; 
			connectSave.data.onlineArray = undefined;
			connectSave.data.isRemember = undefined;
			
			connectSave.data.flush();
		}
		
		
	}
	
}
