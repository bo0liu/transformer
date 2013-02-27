package us.sban.transformer.supportClasses {
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class ResizePoint_Bottom extends ResizePointSquareBase {
        
        public function ResizePoint_Bottom(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new scaleCursorVerticalCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.BOTTOM_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void {
            x = transformBox.globalBottomPoint.x;
            y = transformBox.globalBottomPoint.y;
        }
    }
}