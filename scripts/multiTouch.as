﻿var gestureProxy :GestureProxy = new GestureProxy(stage);//define position of the main objects x and y coordinates //so that user can swipe to animate the object latervar mpcStartX = -538;var sStartX =  568.1;var mpcEndX = 538;var sEndX = 1708.4;function multiTouchGestures(gesEnable:Boolean){		//	if(gesEnable == true){//gestures are enabled				//gestureProxy.enable();		//disable the gestures at the moment to just enable tapping the triangle		//gestureProxy.addEventListener(GestureProxyEvent.GESTURE_DRAG_LEFT, swipeStage);		//gestureProxy.addEventListener(GestureProxyEvent.GESTURE_DRAG_RIGHT, swipeStage);		//Add event listener for the flick arrow so that people can tap it to swipe.		__root.mpcPad.flickArrow.addEventListener(MouseEvent.CLICK, moveToSlide2);		__root.settingsPad.flickArrow.addEventListener(MouseEvent.CLICK, moveToSlide1);		__root.settingsPad.flickArrow_2.addEventListener(MouseEvent.CLICK, moveToSlide3);		__root.sequencePad.flickArrow.addEventListener(MouseEvent.CLICK, moveToSlide2);			}else if(gesEnable == false){//gestures are disabled		trace("gestures are disabled");		//gestureProxy.disable();		//gestureProxy.removeEventListener(GestureProxyEvent.GESTURE_DRAG_LEFT, swipeStage);		//gestureProxy.removeEventListener(GestureProxyEvent.GESTURE_DRAG_RIGHT, swipeStage);	}	}//end function	function moveToSlide1(e:MouseEvent){		//stage.quality = StageQuality.LOW;		//cover();		__root.mpcPad.x=mpcEndX;		__root.settingsPad.x=sEndX;		__root.sequencePad.x=2890.45;		__root.mpcPad.visible = true;		__root.settingsPad.visible = false;		__root.sequencePad.visible = false;		//Tweener.addTween(__root.mpcPad,{x:mpcEndX, time:0.3, delay:0, transition:"easeOutCubic", onComplete:unCover});		//Tweener.addTween(__root.settingsPad,{x:sEndX, time:0.3, delay:0, transition:"easeOutCubic"});		//Tweener.addTween(__root.sequencePad,{x:2890.45, time:0.3, delay:0, transition:"easeOutCubic"});		appCurrentSlide = 1;		trace("What slide and number are you suppose to be on? "+ appCurrentSlide);	}	function moveToSlide2(e:MouseEvent){		//stage.quality = StageQuality.LOW;		//cover();		__root.mpcPad.x=mpcStartX;		__root.settingsPad.x = sStartX;		__root.sequencePad.x =2890.45;		__root.mpcPad.visible = false;		__root.settingsPad.visible = true;		__root.sequencePad.visible = false;		//Tweener.addTween(__root.mpcPad,{x:mpcStartX, time:0.3, delay:0, transition:"easeOutCubic"});		//Tweener.addTween(__root.settingsPad,{x:sStartX, time:0.3, delay:0, transition:"easeOutCubic", onComplete:unCover});		//Tweener.addTween(__root.sequencePad,{x:2890.45, time:0.3, delay:0, transition:"easeOutCubic"});		appCurrentSlide = 2;		trace("What slide and number are you suppose to be on? "+ appCurrentSlide);	}	function moveToSlide3(e:MouseEvent){		//stage.quality = StageQuality.LOW;		//cover();		__root.mpcPad.x=-1788.5;		__root.settingsPad.x = -592.05;		__root.sequencePad.x= 567.95;		__root.mpcPad.visible = false;		__root.settingsPad.visible = false;		__root.sequencePad.visible = true;		//Tweener.addTween(__root.mpcPad,{x:-1788.5, time:0.3, delay:0, transition:"easeOutCubic"});		//Tweener.addTween(__root.settingsPad,{x:-592.05, time:0.3, delay:0, transition:"easeOutCubic"});		//Tweener.addTween(__root.sequencePad,{x:567.95, time:0.3, delay:0, transition:"easeOutCubic", onComplete:unCover});		appCurrentSlide = 3;		trace("What slide and number are you suppose to be on? "+ appCurrentSlide);	}	function unCover(){		stage.quality = StageQuality.HIGH;		__root.mpcPad.covering.visible = false;		__root.settingsPad.covering.visible = false;		__root.sequencePad.covering.visible = false;	}	function cover(){		__root.mpcPad.covering.visible = true;		__root.settingsPad.covering.visible = true;		__root.sequencePad.covering.visible = true;	}		/*moveLeftVar = function (stateValLeft){			if(stateValLeft == true){				Tweener.addTween(__root.mpcPad,{x:mpcStartX, time:0.7, delay:0, transition:"easeOutCubic"});				Tweener.addTween(__root.sequencePad,{x:2890.45, time:0.7, delay:0, transition:"easeOutCubic"});				Tweener.addTween(__root.settingsPad,{x:sStartX, time:0.7, delay:0, transition:"easeOutCubic", onComplete:unCover});				__root.mpcPad.flickArrow.gotoAndStop(2);				appCurrentSlide++;//Add a number to the slide to keep track of what slide you are on.				//place a covering over the app so that user cant touch anything while animating				function unCover(){					__root.settingsPad.covering.visible = false;				}							}else if(stateValLeft == false){				//do nothing to fix break				trace("left is false");			}					}		//		 moveRightVar = function (stateValRight){			if(stateValRight == true){				Tweener.addTween(__root.mpcPad,{x:mpcEndX, time:0.7, delay:0, transition:"easeOutCubic"});				Tweener.addTween(__root.settingsPad,{x:sEndX, time:0.7, delay:0, transition:"easeOutCubic", onComplete:cover});				__root.mpcPad.flickArrow.gotoAndStop(1);				appCurrentSlide--;//Subtract a number to the slide to keep track of what slide you are on.				function cover(){					__root.settingsPad.covering.visible = true;					trace("covered");				}			}else if(stateValRight == false){				//do nothing to fix break				trace("right is false");			}					}		function checkToMove(event:MouseEvent){	if(appCurrentSlide == 1){//The user is on the first slide, move them the only direction they can go, right...		moveLeftVar(true);		trace("What slide are you on? " + appCurrentSlide);	}else if(event.target.name == "flickArrow_2"){		trace("Move to third slide?" + appCurrentSlide);		Tweener.addTween(__root.mpcPad,{x:-1788.5, time:0.7, delay:0, transition:"easeOutCubic"});		Tweener.addTween(__root.settingsPad,{x:-592.05, time:0.7, delay:0, transition:"easeOutCubic"});		Tweener.addTween(__root.sequencePad,{x:567.95, time:0.7, delay:0, transition:"easeOutCubic"});		appCurrentSlide++;		trace("What is the slide number you are on? " + appCurrentSlide);	}else if(appCurrentSlide == 3){//user is on the last slide, move them back.		moveLeftVar(true);		trace("What slide are you on? " + appCurrentSlide);	}else{		moveRightVar(true);		trace("What slide are you on? " + appCurrentSlide);			}}*/		function swipeStage(event:GestureProxyEvent){	switch (event.type)	{		case GestureProxyEvent.GESTURE_DRAG_LEFT:			// Move something to the left			checkFirstRun();			moveLeftVar(true);			trace("moving left");			break;					case GestureProxyEvent.GESTURE_DRAG_RIGHT:			// Move something to the right			moveRightVar(true);			trace("moving right");			break;					case GestureProxyEvent.GESTURE_DRAG_UP:			// Move something up			break;					case GestureProxyEvent.GESTURE_DRAG_DOWN:			// Move something down			break;	}	}