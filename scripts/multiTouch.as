﻿var gestureProxy :GestureProxy = new GestureProxy(stage);//define position of the main objects x and y coordinates //so that user can swipe to animate the object latervar mpcStartX = -538;var sStartX =  568.1;var mpcEndX = 538;var sEndX = 1708.4;function multiTouchGestures(gesEnable:Boolean){		//	if(gesEnable == true){//gestures are enabled				gestureProxy.enable();		gestureProxy.addEventListener(GestureProxyEvent.GESTURE_DRAG_LEFT, swipeStage);		gestureProxy.addEventListener(GestureProxyEvent.GESTURE_DRAG_RIGHT, swipeStage);		//Add event listener for the flick arrow so that people can tap it to swipe.		__root.mpcPad.flickArrow.addEventListener(MouseEvent.CLICK, checkToMove);		__root.settingsPad.flickArrow.addEventListener(MouseEvent.CLICK, checkToMove);		__root.sequencePad.flickArrow.addEventListener(MouseEvent.CLICK, checkToMove);			}else if(gesEnable == false){//gestures are disabled		trace("gestures are disabled");		gestureProxy.disable();		//gestureProxy.removeEventListener(GestureProxyEvent.GESTURE_DRAG_LEFT, swipeStage);		//gestureProxy.removeEventListener(GestureProxyEvent.GESTURE_DRAG_RIGHT, swipeStage);	}	}//end function		moveLeftVar = function (stateValLeft){			if(stateValLeft == true){				Tweener.addTween(__root.mpcPad,{x:mpcStartX, time:0.7, delay:0, transition:"easeOutCubic"});				Tweener.addTween(__root.settingsPad,{x:sStartX, time:0.7, delay:0, transition:"easeOutCubic", onComplete:unCover});				__root.mpcPad.flickArrow.gotoAndStop(2);				appCurrentSlide++;//Add a number to the slide to keep track of what slide you are on.				//place a covering over the app so that user cant touch anything while animating				function unCover(){					__root.settingsPad.covering.visible = false;				}							}else if(stateValLeft == false){				//do nothing to fix break				trace("left is false");			}					}		//		 moveRightVar = function (stateValRight){			if(stateValRight == true){				Tweener.addTween(__root.mpcPad,{x:mpcEndX, time:0.7, delay:0, transition:"easeOutCubic"});				Tweener.addTween(__root.settingsPad,{x:sEndX, time:0.7, delay:0, transition:"easeOutCubic", onComplete:cover});				__root.mpcPad.flickArrow.gotoAndStop(1);				appCurrentSlide--;//Subtract a number to the slide to keep track of what slide you are on.				function cover(){					__root.settingsPad.covering.visible = true;					trace("covered");				}			}else if(stateValRight == false){				//do nothing to fix break				trace("right is false");			}					}		function checkToMove(event:MouseEvent){	if(appCurrentSlide == 1){		moveLeftVar(true);		trace("What slide are you on? " + appCurrentSlide);	}else{		moveRightVar(true);		trace("What slide are you on? " + appCurrentSlide);	}}		function swipeStage(event:GestureProxyEvent){	switch (event.type)	{		case GestureProxyEvent.GESTURE_DRAG_LEFT:			// Move something to the left			checkFirstRun();			moveLeftVar(true);			trace("moving left");			break;					case GestureProxyEvent.GESTURE_DRAG_RIGHT:			// Move something to the right			moveRightVar(true);			trace("moving right");			break;					case GestureProxyEvent.GESTURE_DRAG_UP:			// Move something up			break;					case GestureProxyEvent.GESTURE_DRAG_DOWN:			// Move something down			break;	}	}