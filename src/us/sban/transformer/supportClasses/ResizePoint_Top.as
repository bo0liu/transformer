package us.sban.transformer.supportClasses {
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class ResizePoint_Top extends ResizePointSquareBase {
        
        public function ResizePoint_Top(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new scaleCursorVerticalCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.TOP_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void {
            x = transformBox.globalTopPoint.x;
            y = transformBox.globalTopPoint.y;
        }
    }
}