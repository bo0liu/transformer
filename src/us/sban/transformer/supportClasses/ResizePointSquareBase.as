package us.sban.transformer.supportClasses {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import us.sban.transformer.events.TransformerEvent;
	import us.sban.transformer.Transformer;
	
	internal class ResizePointSquareBase extends Sprite 
	{
		public static const SQUARE_FILL_COLOR :uint = 0xffffff;
		public static const SQUARE_LINE_COLOR :uint = 0x3989d3;
		public static const MOUSE_CURSOR_OFF:Number = 10;
		
		[Embed(source="us/sban/transformer/assets/rotate_cursor.png")]
		protected var rotateCursorCls:Class;
		
		[Embed(source="us/sban/transformer/assets/scale_cursor_se_no.png")]
        protected var scaleCursorCls:Class;
        
        [Embed(source="us/sban/transformer/assets/scale_cursor_so_ne.png")]
        protected var scaleCursorCls2:Class;
        
        [Embed(source="us/sban/transformer/assets/scale_cursor_vertical.png")]
        protected var scaleCursorVerticalCls:Class;
        
        [Embed(source="us/sban/transformer/assets/scale_cursor_horizontal.png")]
        protected var scaleCursorHorizontalCls:Class;
        
        [Embed(source="us/sban/transformer/assets/move_cursor.png")]
        protected var moveCursorCls:Class;
		
		protected var transformBox:Transformer;
		private var interactionMethod:Function;
		
		public var cursorSkin:DisplayObject;
		
		public function ResizePointSquareBase(transformBox:Transformer,interactionMethod:Function = null) {
			this.transformBox = transformBox;
			this.interactionMethod = interactionMethod;
			
			addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			
			transformBox.addEventListener(TransformerEvent.NEW_TARGET,newTargetHandler);
			initPointsListeners();
		}
		
		protected function getPointsListeners():Array 
		{
			return [];
		}
		
		private function initPointsListeners():void 
		{
			var ps:Array = getPointsListeners();
			var n:uint = ps.length;
			for(var i:uint=0;i<n;i++) 
			{
				transformBox.addEventListener(ps[i],validateMeasure);
			}
		}
		
		protected function draw():void 
		{
			graphics.clear();
            graphics.lineStyle(1,SQUARE_LINE_COLOR);
            graphics.beginFill(SQUARE_FILL_COLOR,1);
            graphics.drawCircle(0,0,3);
            graphics.endFill();
		}
		
		protected function validateMeasure(e:Event=null):void {
		}
		
		private static var  currentControl:ResizePointSquareBase;
		private var isRollOut:Boolean = true;
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			transformBox.dispatchEvent(new TransformerEvent(TransformerEvent.CONTROL_START,e));
			if(stage) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE,stageMouseMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP,stageMouseUpHandler);
			}
			currentControl = this;
		}
		
		private function mouseMoveHandler(e:MouseEvent):void 
		{
			updateCursorPoistion(e);
		}
		
		private function stageMouseMoveHandler(e:MouseEvent):void 
		{
			updateCursorPoistion(e);
			callbackTransformBoxmethod(e);
		}
		
		private function stageMouseUpHandler(e:MouseEvent):void 
		{
			if(isRollOut) {
				hiddenMouseCursor();
			}
			callbackTransformBoxmethod(e);
			transformBox.dispatchEvent(new TransformerEvent(TransformerEvent.CONTROL_END,e));
			currentControl = null;
			if(stage) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,stageMouseMoveHandler);
				stage.removeEventListener(MouseEvent.MOUSE_UP,stageMouseUpHandler);
			}
			
		}
		
		private function callbackTransformBoxmethod(e:MouseEvent):void {
			if(interactionMethod != null) {
				interactionMethod(e);
			}
		}
		
		private function showMouseCursor():void {
			if(cursorSkin) {
				stage.addChild(cursorSkin);
			}
		}
		
		private function hiddenMouseCursor():void {
			if(cursorSkin && stage.contains(cursorSkin)) {
				stage.removeChild(cursorSkin);
			}
		}
		
		private function updateCursorPoistion(e:MouseEvent):void {
			if(cursorSkin) {
				cursorSkin.x = e.stageX + MOUSE_CURSOR_OFF;
				cursorSkin.y = e.stageY + MOUSE_CURSOR_OFF;
				
				if (transformBox.target)
				{
					cursorSkin.rotation = transformBox.target.rotation;
				}
			}
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			isRollOut = false;
			if(!currentControl) {
				showMouseCursor();
				updateCursorPoistion(e);
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			isRollOut = true;
			if(!currentControl) {
				hiddenMouseCursor();
			}
		}
		
		private function newTargetHandler(e:TransformerEvent):void {
			draw();
			validateMeasure();
		}
	}
}