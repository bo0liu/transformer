package us.sban.transformer.supportClasses {
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class ResizePoint_BottomRight extends ResizePointSquareBase {
        
        public function ResizePoint_BottomRight(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new scaleCursorCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.BOTTOM_RIGHT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void {
            x = transformBox.globalBottomRightPoint.x;
            y = transformBox.globalBottomRightPoint.y;
        }
    }
}