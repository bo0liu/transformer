package us.sban.transformer.supportClasses
{
	import us.sban.transformer.Transformer;
	
	internal class RotatePointSquareBase extends ResizePointSquareBase
	{
		public function RotatePointSquareBase(transformBox:Transformer, interactionMethod:Function=null)
		{
			super(transformBox, interactionMethod);
		}
		
		override protected function draw():void 
		{
            graphics.clear();
            graphics.beginFill(SQUARE_FILL_COLOR,0);
            graphics.drawCircle(-10,-10,20);
            graphics.endFill();
        }
	}
}