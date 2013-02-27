package us.sban.transformer.supportClasses {
    import flash.events.Event;
    
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class RotatePoint_BottomRight extends RotatePointSquareBase {
        public function RotatePoint_BottomRight(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new rotateCursorCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.BOTTOM_RIGHT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void 
        {
            x = transformBox.globalBottomRightPoint.x;
            y = transformBox.globalBottomRightPoint.y;
        }
    }
}