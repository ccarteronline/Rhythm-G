package
{
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class GestureProxy extends EventDispatcher
	{
		// -------------------- PROPERTIES ------------------------

		public static var dragReactionThreshold		:Number = 40;
		
		private var _stage :DisplayObject;
		
		private var _pressPoint :Point;
		private var _pressPointGestureStart :Point;
		private var _pressPointGestureEnd :Point;
		
		private var _verticalGestureEnabled :Boolean = true;
		private var _horizontalGestureEnabled :Boolean = true;

		// -------------------- CONSTRUCTOR -----------------------

		public function GestureProxy(stage :DisplayObject) 
		{
			_stage = stage;
		}

		// -------------------- GET/SET METHODS -------------------
		
		public function set verticalGestureEnabled(b :Boolean) :void { _verticalGestureEnabled = b; }
		public function get verticalGestureEnabled() :Boolean { return _verticalGestureEnabled; }
		
		public function set horizontalGestureEnabled(b :Boolean) :void { _horizontalGestureEnabled = b; }
		public function get horizontalGestureEnabled() :Boolean { return _horizontalGestureEnabled; }
		
		// -------------------- PUBLIC METHODS --------------------

		public function enable() :void        
		{            
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onScreenPressed);        
		}
		
		public function disable() :void        
		{
			_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onScreenReleased);
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, onScreenPressed);
		}

		// -------------------- PRIVATE METHODS -------------------
		
		private function onScreenPressed(e :MouseEvent) :void
		{
			_pressPoint = new Point(_stage.mouseX, _stage.mouseY);
			_pressPointGestureStart = new Point(_stage.mouseX, _stage.mouseY);
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);            
			_stage.addEventListener(MouseEvent.MOUSE_UP, onScreenReleased);        
		}         
		
		private function onScreenReleased(e :MouseEvent) :void        
		{
			_pressPointGestureEnd = new Point(_stage.mouseX, _stage.mouseY);
			_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onScreenReleased);
			completedGestureData();
		}
		
		/**
		 * Not currently used or doing anything beyond displaying info.
		 * DO NOT DELETE! 
		 */		
		private function completedGestureData():void
		{
			// Logic for determining rotation and distance of gesture movement
			// distance is flaky since this is enter frame...need to separate this out
			var dy:Number = _pressPointGestureEnd.y - _pressPointGestureStart.y;
			var dx:Number = _pressPointGestureEnd.x - _pressPointGestureStart.x;
			var rotationDegrees:Number = Math.atan2(dy, dx)/(Math.PI/180);
			var distance:Number = Point.distance(_pressPointGestureStart, _pressPointGestureEnd);
			
			if (distance > 0)
			{
				//trace("COMPLETE GESTURE: ROTATION ANGLE: " + rotationDegrees + " MOVE DISTANCE: " + distance);
			}
		}
		
		private function onEnterFrame(e :Event) :void
		{
			var currentMouse :Point = new Point(_stage.mouseX, _stage.mouseY);
			var dragDistance :Number = Point.distance(_pressPoint, currentMouse);
			
			// If we've dragged enough, react.
			
			if ( dragDistance > dragReactionThreshold)
			{
				_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				
				var dy:Number = currentMouse.y - _pressPoint.y;
				var dx:Number = currentMouse.x - _pressPoint.x;
				var rotationDegrees:Number = Math.atan2(dy, dx)/(Math.PI/180);
				var distance:Number = Math.sqrt(dx*dx + dy*dy);
				//trace("INCREMENTAL GESTURE: ROTATION ANGLE: " + rotationDegrees + " MOVE DISTANCE: " + distance);
				
				var draggingLeft 	:Boolean = currentMouse.x < _pressPoint.x;
				var draggingUp 		:Boolean = currentMouse.y < _pressPoint.y;
				
				var leftRightDistance :Number = Math.abs(currentMouse.x - _pressPoint.x);
				var upDownDistance :Number = Math.abs(currentMouse.y - _pressPoint.y);
				
				// If the drag was not perfectly horizontal or perfectly vertical, figure out which direction take precedence.
				if (_verticalGestureEnabled && _horizontalGestureEnabled)
				{
					if (leftRightDistance > upDownDistance)
					{
						dragLeftRight(draggingLeft, rotationDegrees, distance, currentMouse);
					}
					else
					{
						dragUpDown(draggingUp, rotationDegrees, distance, currentMouse);
					}
				}
				// We're only dragging up or down
				else if (_verticalGestureEnabled)
				{
					dragUpDown(draggingUp, rotationDegrees, distance, currentMouse);
				}
				// We're only dragging left or right
				else if (_horizontalGestureEnabled)
				{
					dragLeftRight(draggingLeft, rotationDegrees, distance, currentMouse);
				}
				// No dragging is enabled
				else
				{
					return;
				}
			}
			
			_pressPoint = currentMouse;
		}

		private function dragUpDown(draggingUp :Boolean, angle :Number, distance :Number, mousePoint :Point) :void 
		{
			if (draggingUp)
			{
				dispatchEvent(new GestureProxyEvent( GestureProxyEvent.GESTURE_DRAG_UP, angle, distance, _pressPoint, mousePoint));	
			}
			else
			{
				dispatchEvent(new GestureProxyEvent( GestureProxyEvent.GESTURE_DRAG_DOWN, angle, distance, _pressPoint, mousePoint));
			}
		}

		private function dragLeftRight(draggingLeft :Boolean, angle :Number, distance :Number, mousePoint :Point) :void 
		{
			if (draggingLeft)
			{
				dispatchEvent(new GestureProxyEvent( GestureProxyEvent.GESTURE_DRAG_LEFT, angle, distance, _pressPoint, mousePoint));	
			}
			else
			{
				dispatchEvent(new GestureProxyEvent( GestureProxyEvent.GESTURE_DRAG_RIGHT, angle, distance, _pressPoint, mousePoint));
			}
		}
	}
}