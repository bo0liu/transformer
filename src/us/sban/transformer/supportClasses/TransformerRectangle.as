package us.sban.transformer.supportClasses {
    import flash.display.BlendMode;
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class TransformerRectangle extends ResizePointSquareBase {
        
        public function TransformerRectangle(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
        }
        
        override protected function draw():void 
        {
            validateMeasure();
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
        	graphics.clear();
    		graphics.lineStyle(1,SQUARE_LINE_COLOR);
    		graphics.moveTo(transformBox.globalTopLeftPoint.x,transformBox.globalTopLeftPoint.y);
    		graphics.lineTo(transformBox.globalTopRightPoint.x,transformBox.globalTopRightPoint.y);
    		graphics.lineTo(transformBox.globalBottomRightPoint.x,transformBox.globalBottomRightPoint.y);
    		graphics.lineTo(transformBox.globalBottomLeftPoint.x,transformBox.globalBottomLeftPoint.y);
    		graphics.lineTo(transformBox.globalTopLeftPoint.x,transformBox.globalTopLeftPoint.y);
        }
    }
}