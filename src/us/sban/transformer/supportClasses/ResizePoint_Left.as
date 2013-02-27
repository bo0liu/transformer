package us.sban.transformer.supportClasses {
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class ResizePoint_Left extends ResizePointSquareBase {
        
        public function ResizePoint_Left(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new scaleCursorHorizontalCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.LEFT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void {
            x = transformBox.globalLeftPoint.x;
            y = transformBox.globalLeftPoint.y;
        }
    }
}