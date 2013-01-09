package mvc 
{
	import events.ModelEvent;
    import flash.events.EventDispatcher;
	 /**
     * ...Model component of MVC
     * @author Leonid Trofimchuk
     */
    public class Model extends EventDispatcher 
	{
		private var _list: Array;					//Game Scores
		
		private var _genres:Array;
		
		public function Model(list:Array = null) 
		{
			this._list = list;
			
			_genres = new Array();
			for (var i:int = 0 ; i < _list.length; i++)
			{
				var data:Object = _list[i];
				var genre:String = data["genre"];
				if (_genres.indexOf(genre) == -1)
				_genres.push(genre);
			}
			
            init();
        }
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		private function init():void 
		{
			dispatchEvent(new ModelEvent(ModelEvent.MODEL_GHANGED, false, false, _list));
		}
		
		
		public function onBallMissed(title:String):void 
		{
			//switch (title)
			//{
				//case GameEvent.PLAYER_MISS:
					//_result["cpu"] ++;
					//break;
				//case GameEvent.CPU_MISS:
					//_result["player"] ++;
					//break;
			//}
			//
			//dispatchEvent(new ModelEvent(ModelEvent.SCORE_GHANGED, false, false, result));
		}
		
//--------------------------------------------------------------------------
//
//  Getters and Setters
//
//--------------------------------------------------------------------------
		
		public function get result():Array
		{
			return _list;
		}
		
		public function set result(value:Array):void
		{
			_list = value;
		}
		
		public function get genres():Array
		{
			return _genres;
		}
		
		public function set genres(value:Array):void
		{
			_genres = value;
		}
    }

}