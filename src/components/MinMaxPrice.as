package components 
{
	/**
	 * ...This Class is used to set min max Price 
	 * @author Leonid Trofimchuk
	 */
	public class MinMaxPrice 
	{
		private var _minPrice:Number;
		private var _maxPrice:Number;
		
		public function MinMaxPrice(min:Number = 0, max:Number = 0) 
		{
			_minPrice = min;
			_maxPrice = max;
		}
		
//--------------------------------------------------------------------------
//
//  Getters and Setters
//
//--------------------------------------------------------------------------
		
		public function get minPrice():Number
		{
			return _minPrice;
		}
		
		public function set minPrice(value:Number):void
		{
			_minPrice = value;
		}
		
		public function get maxPrice():Number
		{
			return _maxPrice;
		}
		
		public function set maxPrice(value:Number):void
		{
			_maxPrice = value;
		}
		
	}

}