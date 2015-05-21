package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	
	public class connectObj extends MovieClip {
		
		public var loginDia:loginObj;
		public var numIcons:Number = 24;
		public var controlTabObj:controlTab;
		public var connectSave:SharedObject = SharedObject.getLocal("connectObject");
		public var blkcsr:SharedObject = SharedObject.getLocal('blockchooser');
		public var mainObj:main;
		
		public function connectObj(prtObj:controlTab, ego:main) {
			
			mainObj = ego;
			// constructor code
			controlTabObj = prtObj;
			loginBtn.addEventListener(MouseEvent.CLICK, bringUpLogin);
			
			hideIcons();
			
			this.addEventListener(Event.ENTER_FRAME, checkIfRight);
			
			//connectSave.data.isRemember = false;
			//
			
			for(var sui:Number =1; sui <= connectSave.data.prepBlockArray.length; sui++){
				//Mouse Down
				this["onlineSound_"+ sui].addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent){
					
					//Go to next button object
					e.currentTarget.gotoAndStop(2);
					
					//create specific vars for functions
					var heldNum = e.currentTarget.name.substr(-1);
					var onlineString = "http://rhythm-g.com/mpcUsers/"+connectSave.data.username+"/"+connectSave.data.password+"/"+connectSave.data.onlineArray[heldNum-1];
					
					
					//If the person used shortcut, the last tapped button exists, otherwise, use the manual way
					if(!mainObj.lastTappedButton){
						//at first launch and the user doesnt select a number, it will be undefined, so set 1 to default
						if(!mainObj.blockChooserBlock){
							mainObj.blockChooserBlock = 1;
						}
						//turn the object to online
						connectSave.data.prepBlockArray[mainObj.blockChooserBlock-1].fromOnline = true;
						//set the location of the sound
						connectSave.data.prepBlockArray[mainObj.blockChooserBlock-1].onlineLocation = onlineString;
						
						//set the last tapped button to undefined or else it will constantly load the last tapped item 
						mainObj.lastTappedButton = undefined;
						//force the item into the saved object using flush
						connectSave.flush();
						
						
					}else{
						//turn the object to online
						connectSave.data.prepBlockArray[mainObj.lastTappedButton-1].fromOnline = true;
						//set the location of the sound
						connectSave.data.prepBlockArray[mainObj.lastTappedButton-1].onlineLocation = onlineString;
						//force the item into the saved object using flush
						connectSave.flush();
						
					}
					
					
					//change the block to false as it is a new sound to be loaded
					mainObj["onlineSoundLoaded_" + mainObj.lastTappedButton] = false;
					

				});
				
				//Mouse Up
				this["onlineSound_"+ sui].addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent){
					e.currentTarget.gotoAndStop(1);
					closeObj();
					
				});
			}
			
		}
		
		private function closeObj(){
			mainObj.footer.removeTabWindow();
			mainObj.showDPadButtons();
		}
		
		private function checkIfRight(e:Event){
			
			if(connectSave.data.onlineArray == undefined){
				
				//trace('dont display, information is wrong');
				hideIcons();
				
			}else if(connectSave.data.isRemember == false && connectSave.data.onlineArray != undefined){
				this.removeEventListener(Event.ENTER_FRAME, checkIfRight);
				hideIcons();
				showIcons();
				
				connectSave.data.onlineArray = undefined;
				connectSave.flush();
				
			}else if(connectSave.data.isRemember == true && connectSave.data.onlineArray != undefined){
				hideIcons();
				showIcons();
				
			}
			
		}
		
		private function bringUpLogin(e:MouseEvent){
			loginDia = new loginObj();
			stage.addChild(loginDia);
			loginDia.x = 568;
			loginDia.y = 386;
			this.addEventListener(Event.ENTER_FRAME, checkIfRight);
		
		}

		
		public function hideIcons(){
			for(var ct:Number = 1; ct<= numIcons; ct++){
				this["onlineSound_"+ct].visible = false;
			}
			
		}
		
		private function showIcons(){
			for(var to:Number =1; to<=connectSave.data.onlineArray.length; to++){
				this["onlineSound_"+to].visible = true;
				this["onlineSound_"+to].song.text = connectSave.data.onlineArray[to-1];
			}
		}
		
	}
	
}
