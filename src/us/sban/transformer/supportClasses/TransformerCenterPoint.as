package us.sban.transformer.supportClasses
{
	import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
	
	public class TransformerCenterPoint extends ResizePointSquareBase
	{
		public function TransformerCenterPoint(transformBox:Transformer, interactionMethod:Function=null)
		{
			super(transformBox, interactionMethod);
			
			cursorSkin = new moveCursorCls();
		}
		
		override protected function getPointsListeners():Array {
            return [
                TransformerEvent.TOP_LEFT_CHANGED,
                TransformerEvent.TOP_RIGHT_CHANGED,
                TransformerEvent.BOTTOM_LEFT_CHANGED,
                TransformerEvent.BOTTOM_RIGHT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void 
        {
		    x = transformBox.globalCenterPoint.x;
            y = transformBox.globalCenterPoint.y;
        }
	}
}