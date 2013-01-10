package mvc 
{
	import components.MinMaxPrice;
	import events.ModelEvent;
    import flash.events.EventDispatcher;
	 /**
     * ...Model component of MVC
     * @author Leonid Trofimchuk
     */
    public class Model extends EventDispatcher 
	{
		private var _list: Array;					//Data List
		private var _result: Array;					//Current Data For Data Grid
		
		private var _minMaxPrice:MinMaxPrice;		//Min Max Price Values for Slider
		
		private var _currentPrice:Number;			//Current Slider Price
		
		private var _description:String;			//Current Description for Selected Row
		
		private var _genres:Array;					//All Genres
		
		public function Model(list:Array = null) 
		{
			this._list = list;
			_result = _list;
			
			setGenres();
			setMinMaxPrice();
			setDefaultDescription();
        }
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		private function setGenres():void 
		{
			_genres = new Array();
			
			var allGenres:String = "All Genres";
			_genres.push(allGenres);
			
			for (var i:int = 0 ; i < _list.length; i++)
			{
				var data:Object = _list[i];
				var genre:String = data["genre"];
				if (_genres.indexOf(genre) == -1)
				_genres.push(genre);
			}
		}
		
		private function setMinMaxPrice():void 
		{
			_minMaxPrice = getMinMaxPrice(_list);
			_currentPrice = _minMaxPrice.minPrice;
		}
		
		private function setDefaultDescription():void
		{
			_description = "display description for the selected row...";
			
			dispatchEvent(new ModelEvent(ModelEvent.DESCRIPTION_GHANGED));
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Filter
//
//-------------------------------------------------------------------------------------------------
		
		public function filterDataGrid(filterTitle:String = "", filterGenre:String = "All Genres", sliderValue:Number = 0):void
		{
			_currentPrice = _minMaxPrice.minPrice + sliderValue * (_minMaxPrice.maxPrice - _minMaxPrice.minPrice);
			_currentPrice = Number(_currentPrice.toFixed(2));
			
			var rawResult:Array = new Array();;
			
			for (var i:int = 0 ; i < _list.length; i++)
			{
				var data:Object = _list[i];
				var title:String = data["title"];
				var genre:String = data["genre"];
				var price:Number = data["price"];
				
				if(((title.indexOf(filterTitle) != -1) || (filterTitle == "")) && ((filterGenre == "All Genres") || (genre == filterGenre)) && ((price >=  _minMaxPrice.minPrice) && (price <= _currentPrice)))
					rawResult.push(data);
			}
			
			_result = rawResult;
			
			dispatchEvent(new ModelEvent(ModelEvent.RESULT_GHANGED, false, false, _result));
			
			setDefaultDescription();
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Utils
//
//-------------------------------------------------------------------------------------------------
		
		/**
		 * Search Min and Max Price From Data Array
		 * @param	array
		 * @return MinMaxPrice Object
		 */
		public function getMinMaxPrice(array:Array):MinMaxPrice
		{
			var priceList:Array = new Array();
			
			for (var i:int = 0; i < array.length; i++)
			{
				var data:Object = array[i];
				var price:Number = data["price"];
				priceList.push(price);
			}
			
			var min:Number;
			var max:Number;
			min = priceList[0];
			max = priceList[0];
			
			for (var j:int = 0; j < priceList.length; j++)
			{
				if (min > priceList[j])
					min = priceList[j];
					
				if (max < priceList[j])
					max = priceList[j];
			}
			
			var minMax:MinMaxPrice = new MinMaxPrice(min, max);
			return minMax;
		}
		
		/**
		 * Get Decription for Selected Item
		 * @param	index - index of Item
		 */
		public function getDescription(index:int):void
		{
			var data:Object = _result[index];
			_description = data["description"];
			
			dispatchEvent(new ModelEvent(ModelEvent.DESCRIPTION_GHANGED));
		}
		
//--------------------------------------------------------------------------
//
//  Getters and Setters
//
//--------------------------------------------------------------------------
		
		public function get result():Array
		{
			return _result;
		}
		
		public function set result(value:Array):void
		{
			_result = value;
		}
		
		public function get genres():Array
		{
			return _genres;
		}
		
		public function set genres(value:Array):void
		{
			_genres = value;
		}	
		
		public function get minMaxPrice():MinMaxPrice
		{
			return _minMaxPrice;
		}
		
		public function set minMaxPrice(value:MinMaxPrice):void
		{
			_minMaxPrice = value;
		}
		
		public function get currentPrice():Number
		{
			return _currentPrice;
		}
		
		public function set currentPrice(value:Number):void
		{
			_currentPrice = value;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		public function set description(value:String):void
		{
			_description = value;
		}
    }

}