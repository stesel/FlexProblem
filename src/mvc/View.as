package mvc 
{
	import com.greensock.TweenMax;
	import events.ModelEvent;
	import fl.controls.ComboBox;
	import fl.controls.DataGrid;
	import fl.controls.List;
	import fl.controls.Slider;
	import fl.data.DataProvider;
	import flash.display.Sprite;
    import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
    /**
	 * ... View component of MVC
	 * @author Leonid Trofimchuk
	 */
	public class View extends Sprite 
	{
		
		private var _model:Model;           						// Model
		private var _controller:Controller;         				// Controller
		
		//////////GUI//////////
		private var filtersLabel:TextField;
		private var titleLabel:TextField;
		private var titleInput:TextField;
		private var comboBoxLabel:TextField;
		private var comboBox:ComboBox;
		private var sliderLabel:TextField;
		private var slider:Slider;
		private var minSlider:TextField; 
		private var maxSlider:TextField; 
		private var dataGrid:DataGrid;
		private var descriptionLadel:TextField;
		private var descriptionText:TextField;
		
		private var format:TextFormat;
		
		
		
		
        public function View(model:Model, controller:Controller)
		{
			this._model = model;									// Reference to the model
			this._controller = controller;							// Reference to the model
			
			if (!stage)
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			else
				addedToStage();
		}
		
		private function addedToStage(e:Event = null):void 
		{
			if(hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
				
			initGUI();
			initTitleFilter();
			initGenreFilter();
			initPriceFilter();
			initDataGrid();
			initDescription();
			
			initListeners();
		}
		
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		private function initGUI():void 
		{
			/////////
			this.graphics.clear();
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.drawRect(20, 30, stage.stageWidth - 40, 110);
			
			/////////Text Format
			format = new TextFormat();
			format.size = 15;
			format.font = "Arial";
			format.color = 0xffffff;
			format.align = "center";
			format.bold = true;
			
			/////////
			filtersLabel = new TextField();
			filtersLabel.defaultTextFormat = format;
			filtersLabel.selectable = false;
			filtersLabel.antiAliasType = AntiAliasType.ADVANCED;
			filtersLabel.background = true;
			filtersLabel.backgroundColor = 0x7d7d7d;
			filtersLabel.text = "Filters";
			filtersLabel.width = filtersLabel.textWidth + 60;
			filtersLabel.height = filtersLabel.textHeight + 5;
			filtersLabel.x = 60;
			filtersLabel.y = 30 - filtersLabel.height / 2;
			addChild(filtersLabel);
			
		}
		
		private function initTitleFilter():void 
		{
			//////////
			format.color = 0x000000;
			format.size = 14;
			format.bold = false;
			format.align = "left";
			
			//////////
			titleLabel = new TextField();
			titleLabel.defaultTextFormat = format;
			titleLabel.antiAliasType = AntiAliasType.ADVANCED;
			titleLabel.autoSize = TextFieldAutoSize.LEFT;
			titleLabel.selectable = false;
			titleLabel.text = "Title:";
			titleLabel.x = 50;
			titleLabel.y = 70;
			addChild(titleLabel);
			
			//////////
			titleInput = new TextField();
			titleInput.defaultTextFormat = format;
			titleInput.antiAliasType = AntiAliasType.ADVANCED;
			titleInput.type = TextFieldType.INPUT;
			titleInput.border = true;
			titleInput.background = true;
			titleInput.backgroundColor = 0xffffff;
			titleInput.text = "...";
			titleInput.width = 150;
			titleInput.height = titleLabel.textHeight + 3;
			titleInput.x = 90;
			titleInput.y = 70;
			addChild(titleInput);
		}
		
		private function initGenreFilter():void 
		{
			///////////
			comboBoxLabel = new TextField();
			comboBoxLabel.defaultTextFormat = format;
			comboBoxLabel.antiAliasType = AntiAliasType.ADVANCED;
			comboBoxLabel.autoSize = TextFieldAutoSize.LEFT;
			comboBoxLabel.selectable = false;
			comboBoxLabel.text = "Genre:";
			comboBoxLabel.x = 290;
			comboBoxLabel.y = 70;
			addChild(comboBoxLabel);
			
			var genres:Array = _model.genres;
			///////////
			comboBox = new ComboBox();
			comboBox.x = 345;
			comboBox.y = 69;
			comboBox.width = 150;
			
			for (var i:int = 0 ; i < genres.length; i++)
			{
				var genre:String = genres[i];
				comboBox.addItem({label: genre});
			}
			
			addChild(comboBox);
		}
		
		private function initPriceFilter():void 
		{
			////////////
			format.size = 12;
			////////////
			minSlider = new TextField();
			minSlider.defaultTextFormat = format;
			minSlider.antiAliasType = AntiAliasType.ADVANCED;
			minSlider.autoSize = TextFieldAutoSize.LEFT;
			minSlider.selectable = false;
			minSlider.text = "$20";
			minSlider.x = 600;
			minSlider.y = 88;
			addChild(minSlider);
			
			////////////
			maxSlider = new TextField();
			maxSlider.defaultTextFormat = format;
			maxSlider.antiAliasType = AntiAliasType.ADVANCED;
			maxSlider.autoSize = TextFieldAutoSize.LEFT;
			maxSlider.selectable = false;
			maxSlider.text = "$100";
			maxSlider.x = 720;
			maxSlider.y = 88;
			addChild(maxSlider);
			
			/////////////
			slider = new Slider();
			slider.liveDragging = true;
			slider.minimum = 0;
			slider.maximum = 20;
			slider.width = 120;
			slider.x = 620;
			slider.y = 77;
			addChild(slider);
			
			////////////
			sliderLabel = new TextField();
			sliderLabel.defaultTextFormat = format;
			sliderLabel.antiAliasType = AntiAliasType.ADVANCED;
			sliderLabel.autoSize = TextFieldAutoSize.LEFT;
			sliderLabel.selectable = false;
			sliderLabel.text = "Price:";
			sliderLabel.x = 550;
			sliderLabel.y = 70;
			addChild(sliderLabel);
		}
			
		private function initDataGrid():void 
		{
			/////////////
			dataGrid = new DataGrid();
			dataGrid.x = 20;
			dataGrid.y = 160;
			dataGrid.width = stage.stageWidth - 40;
			dataGrid.height = 200;
			dataGrid.rowHeight = 33;
			
			dataGrid.columns = ["ID", "Author", "Title", "Genre", "Price", "Publish Date"];
			
			var list:Array = _model.result;
			
			for (var i:int = 0; i < list.length; i++)
			{
				var data:Object = list[i];
				
				var items:Object = { };
				items["ID"] = data["id"];
				items["Author"] = data["author"];
				items["Title"] = data["title"];
				items["Genre"] = data["genre"];
				items["Price"] = data["price"];
				items["Publish Date"] = data["publish_date"];
				
				dataGrid.addItem(items);
			}
			addChild(dataGrid);
		}
		
		private function initDescription():void 
		{
			/////////////
			descriptionLadel = new TextField();
			descriptionLadel.defaultTextFormat = format;
			descriptionLadel.antiAliasType = AntiAliasType.ADVANCED;
			descriptionLadel.autoSize = TextFieldAutoSize.LEFT;
			descriptionLadel.selectable = false;
			descriptionLadel.text = "Description:";
			descriptionLadel.x = 20;
			descriptionLadel.y = 372;
			addChild(descriptionLadel);
			
			//////////////
			descriptionText = new TextField();
			descriptionText.defaultTextFormat = format;
			descriptionText.antiAliasType = AntiAliasType.ADVANCED;
			descriptionText.border = true;
			descriptionText.background = true;
			descriptionText.backgroundColor = 0xffffff;
			descriptionText.text = "display description for the selected row...";
			descriptionText.width = stage.stageWidth - 40;
			descriptionText.height = 80;
			descriptionText.x = 20;
			descriptionText.y = 398;
			addChild(descriptionText);
		}
		
		
		//
		public function initListeners():void 
		{
			_model.addEventListener(ModelEvent.MODEL_GHANGED, model_modelGhanged);
		}
		
		
//--------------------------------------------------------------------------
//
//  Event handlers
//
//--------------------------------------------------------------------------
		
		private function model_modelGhanged(e:ModelEvent):void 
		{
			
		}
		
    }

}