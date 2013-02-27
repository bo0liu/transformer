package us.sban.transformer.supportClasses {
    import flash.events.Event;
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.Transformer;
    
    public class RotatePoint_TopRight extends RotatePointSquareBase 
    {
        public function RotatePoint_TopRight(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new rotateCursorCls();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.TOP_RIGHT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void {
            x = transformBox.globalTopRightPoint.x;
            y = transformBox.globalTopRightPoint.y;
        }
    }
}