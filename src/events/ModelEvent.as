package events 
{
	import flash.events.Event;
    /**
	 * Custom event for notification of changes in the model
	 * 
	 * @author Leonid Trofimchuk
	 */
	public class ModelEvent extends Event 
	{
		
		static public const MODEL_GHANGED:String = "ModelGhanged";
		
		public var result:Array;
		
		public function ModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, result:Array = null) 
		{
			super(type, bubbles, cancelable);
			
			this.result = result;
		}
		
		public override function clone():Event 
		{ 
			return new ModelEvent(type, bubbles, cancelable, result);
		} 
		
		public override function toString():String
		{ 
			return formatToString("ModelEvent", "bubbles", "cancelable", "eventPhase", "result");
		} 
		
	}

}