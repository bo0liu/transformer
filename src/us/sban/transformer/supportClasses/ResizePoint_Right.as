package us.sban.transformer.supportClasses {
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class ResizePoint_Right extends ResizePointSquareBase {
        
        public function ResizePoint_Right(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new scaleCursorHorizontalCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.RIGHT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void {
            x = transformBox.globalRightPoint.x;
            y = transformBox.globalRightPoint.y;
        }
    }
}