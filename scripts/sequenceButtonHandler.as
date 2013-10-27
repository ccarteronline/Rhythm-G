var prefix:String = "newSequence_";
var itemAmt:Number = 4;

var soundStorage_1:Array = new Array();
var soundStorage_2:Array = new Array();
var soundStorage_3:Array = new Array();
var soundStorage_4:Array = new Array();
//var sequencePlay_1 = soundStorage_1.addEventListener(Event.ENTER_FRAME, playArray);
var myNewNum:Number;
var isPlayingSequence:Boolean = false;
var counterNum = 0;
var sequencerNum;

function initiateSequenceListeners(){
	for(var i:Number = 1; i<=itemAmt; i++){
		
		//add event listners to the button interactions of in each sequence
		this[prefix+i].deleteSequence.addEventListener(MouseEvent.CLICK, deleteSequence);
		this[prefix+i].playSequence.addEventListener(MouseEvent.CLICK, playSequence);
		this[prefix+i].loopSequence.addEventListener(MouseEvent.CLICK, loopSequence);
	}	
}



function deleteSequence(e:MouseEvent){
	trace("You want to delete a sequence");
}

function playSequence(e:MouseEvent){
	//trace("Play the sequence for the user" + e.currentTarget.name);
	if(isPlayingSequence){
		isPlayingSequence = false;
		this.removeEventListener(Event.ENTER_FRAME,playArray);
		e.currentTarget.gotoAndStop(1);
		trace("I have stopped playing the sequence");
		counterNum = 0;//put the array positon back into first position.
	}else{
		isPlayingSequence = true;//start playing
		this.addEventListener(Event.ENTER_FRAME, playArray);
		var _parentObjSequence = MovieClip(e.currentTarget.parent).name;
		var whatSequencerToGet = _parentObjSequence.charAt(12);
		sequencerNum = whatSequencerToGet;
		trace("Get the parent objects number! " + whatSequencerToGet);

		e.currentTarget.gotoAndStop(2);
	}
	
	
}
function playArray(Event){
	//MovieClip(root).manageSoundPlay(myBlock:Number);
	if(this["soundStorage_"+sequencerNum][counterNum] == "Silence"){
		//do nothing, this is silence
		trace("Silence");
	}else if(this["soundStorage_"+sequencerNum][counterNum] == undefined){
		trace("There are no more items in the array");
		//removeEventListener(Event.ENTER_FRAME, playArray);
		counterNum = -1;//reset the counter to -1 so the array plays again
	}else{
		MovieClip(root).manageSoundPlay(this["soundStorage_"+sequencerNum][counterNum]);
		trace("I played a sound ");
	}
	counterNum++;//increment the counter
}

function loopSequence(e:MouseEvent){
	trace("Loop the sequence for that user");
}

var listenForUserInput = function(obj){
	this.addEventListener(Event.ENTER_FRAME, pushSilenceToArray);
	myNewNum = obj;
	trace("Im listening..");
}
function pushSilenceToArray(Event){
	this["soundStorage_"+ myNewNum].push("Silence");
	trace("pushing to array");
}

function addNewBlockToArray(blockNumber:Number){
	this["soundStorage_"+ myNewNum].push(blockNumber);
}
function stopListening(){
	this.removeEventListener(Event.ENTER_FRAME, pushSilenceToArray);
	trace("I have stopped listening");
	editTheArray();//Remove the silence from once the user tapped something.
}
function editTheArray(){
	var myCustomStoredSequence = this["soundStorage_" + myNewNum];
	//clear the beginning silence
	for(var ct:Number=0; ct<= myCustomStoredSequence.length; ct++){

		if(myCustomStoredSequence[0] == "Silence"){
			trace("Clearing silence from the Array");
			myCustomStoredSequence.shift();//REmove the first item of the array
		}else{
			trace("Done, initiate Clear the End");
			clearTheEnd(myCustomStoredSequence);
			break;
		}
	}

}
function clearTheEnd(arrayItem){
	//clear the end silence
	for(var i:Number = arrayItem.length-1; i>= 0; i--){
		if(arrayItem[i] == "Silence"){
			trace("Found Silence Here.."+ arrayItem[i] +" Array Length:"+ arrayItem.length);
			arrayItem.pop();//REmove the last item of the array
		}else{
			trace("Silence has been stripped from the array");
			MovieClip(root).letUserKnowSequencesAreReady();
			break;
		}
	}	
}