package
{
	import flash.geom.Point;
	import flash.events.Event;

	public class GestureProxyEvent extends Event 
	{		
		public static const ENABLE_GESTURE				:String = "enableGesture";
		public static const DISABLE_GESTURE				:String = "disableGesture";
		
		public static const GESTURE_DRAG_LEFT			:String = "GestureDragLeft";
		public static const GESTURE_DRAG_RIGHT			:String = "GestureDragRight";
		public static const GESTURE_DRAG_UP				:String = "GestureDragUp";
		public static const GESTURE_DRAG_DOWN			:String = "GestureDragDown";
		
		private var _angle :Number;
		private var _distance :Number;
		private var _startGesture :Point;
		private var _endGesture : Point;

		public function GestureProxyEvent(type :String, angle :Number = NaN, distance :Number = NaN, startGesture :Point = null, endGesture :Point = null)
		{
			super(type);
			
			_angle = angle;
			_distance = distance;
			_endGesture = endGesture;
			_startGesture = startGesture;
		}
		
		public function get angle() :Number
		{
			return _angle;
		}
		
		public function get distance() :Number
		{
			return _distance;
		}

		public function get startGesture() :Point
		{
			return _startGesture;
		}

		public function get endGesture() :Point
		{
			return _endGesture;
		}
	}
}
