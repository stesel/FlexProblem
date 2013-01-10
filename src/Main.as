package 
{
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width = "800", height = "510", frameRate = "30", backgroundColor = "#F0F0F0")]
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Main extends Sprite 
	{
		private var window:NativeWindow;
		private var application:Application
		
		public function Main():void 
		{
			if (!stage)
				addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			else
				addedToStage();
		}
		
		private function addedToStage(e:Event = null):void 
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
				
			//Init Window	
			window = stage.nativeWindow;
			window.x = 0;
			window.y = 0;
			window.title = "Flex Problem";
			
			application = new Application();
			addChild(application);
		}
		
		
	}
	
}