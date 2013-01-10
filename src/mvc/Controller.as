package mvc 
{
	import components.MinMaxPrice;
	import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
	import flash.display.Sprite;
    /**
	 * ...Controller component of MVC
	 * @author Leonid Trofimchuk
	 */
	public class Controller extends EventDispatcher 
	{
		private var _model:Model;
		
		public function Controller(model:Model = null) 
		{
			this._model = model;
		}
		
//-------------------------------------------------------------------------------------------------
//
// 	Public Methods
//
//-------------------------------------------------------------------------------------------------
		
			
		public function changeDataGridItem(index:int):void 
		{
			_model.getDescription(index);
		}
		
		public function filtersChanged(title:String, genre:String, sliderValue:Number):void 
		{
			_model.filterDataGrid(title, genre, sliderValue);
		}
		
    }
 
}