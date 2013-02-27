package us.sban.transformer.supportClasses {
    import flash.events.Event;
    
    import us.sban.transformer.Transformer;
    import us.sban.transformer.events.TransformerEvent;
    
    public class RotatePoint_BottomLeft extends RotatePointSquareBase {
        public function RotatePoint_BottomLeft(transformBox:Transformer,interactionMethod:Function = null) {
            super(transformBox,interactionMethod);
            
            cursorSkin = new scaleCursorCls2();
        }
        
        override protected function getPointsListeners():Array {
            return [
                TransformerEvent.BOTTOM_LEFT_CHANGED
            ];
        }
        
        override protected function validateMeasure(e:Event=null):void 
        {
            x = transformBox.globalBottomLeftPoint.x;
            y = transformBox.globalBottomLeftPoint.y;
        }
    }
}