package us.sban.transformer.supportClasses {
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class ResizePoint_TopLeft extends ResizePointSquareBase {
        
        public function ResizePoint_TopLeft(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new scaleCursorCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.TOP_LEFT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void {
            x = transformBox.globalTopLeftPoint.x;
            y = transformBox.globalTopLeftPoint.y;
        }
    }
}