package  
{
	import components.InfoText;
	import components.ReadXML;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import mvc.Controller;
	import mvc.Model;
	import mvc.View;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Application extends Sprite 
	{
		private var controller:Controller;
		private var model:Model;
		private var view:View;
		
		private var _list:Array;
		private var _result:Object;
		
		private var readXML:ReadXML;
		
		private var info:InfoText;
		
		
		public function Application() 
		{
			
			if (!stage)
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			else
				addedToStage();
		}
		
		private function addedToStage(e:Event = null):void 
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
				
			loadData();	
		}
		
		private function loadData():void 
		{
			info = new InfoText(18, 0x00ff00);
			info.text = "Load Data...";
			addChild(info);
			
			readXML = new ReadXML("Catalog.xml");
			readXML.addEventListener(ReadXML.LIST_LOADED, readXML_listLoaded);
		}
		
		private function readXML_listLoaded(e:Event):void 
		{
			readXML.removeEventListener(ReadXML.LIST_LOADED, readXML_listLoaded);
			
			setTimeout(parseData, 1000);
		}
		
		private function parseData():void 
		{
			removeChild(info);
			info = null;
			
			var xmlList:XMLList = readXML.getList();
			
			_list = new Array();
			
			for (var i:int = 0; i < xmlList.length(); i++)
			{
				var data:Object = { };
				data["id"] = String(xmlList[i].attribute("id"));
				data["author"] = String(xmlList[i].author);
				data["title"] = String(xmlList[i].title);
				data["genre"] = String(xmlList[i].genre);
				data["price"] = String(xmlList[i].price);
				data["publish_date"] = String(xmlList[i].publish_date);
				data["description"] = String(xmlList[i].description);
				
				_list.push(data);
			}
			
			initMVC();
		}
		private function initMVC():void 
		{
			model = new Model(_list);
			controller = new Controller(model);
			view = new View(model, controller);
			addChild(view);
		}
		
	}

}