package us.sban.transformer {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    import mx.core.IVisualElement;
    import mx.core.IVisualElementContainer;
    import mx.core.UIComponent;
    
    import us.sban.transformer.events.TransformerEvent;
    import us.sban.transformer.supportClasses.*;
    import us.sban.transformer.utils.TransformHeiper;
    
	/**
	 * 
	 * @author sban
	 * 
	 */	
    public class Transformer extends UIComponent 
    {
        private var _globalTopLeftPoint:Point;
        public function set globalTopLeftPoint(value:Point):void {
            _globalTopLeftPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.TOP_LEFT_CHANGED));
        }
        public function get globalTopLeftPoint():Point {
            return _globalTopLeftPoint.clone();
        }
        
        private var _globalTopPoint:Point;
        public function set globalTopPoint(value:Point):void {
            _globalTopPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.TOP_CHANGED));
        }
        public function get globalTopPoint():Point {
            return _globalTopPoint.clone();
        }
        
        private var _globalTopRightPoint:Point;
        public function set globalTopRightPoint(value:Point):void {
            _globalTopRightPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.TOP_RIGHT_CHANGED));
        }
        public function get globalTopRightPoint():Point {
            return _globalTopRightPoint.clone();
        }
        
        private var _globalLeftPoint:Point;
        public function set globalLeftPoint(value:Point):void {
            _globalLeftPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.LEFT_CHANGED));
        }
        public function get globalLeftPoint():Point {
            return _globalLeftPoint.clone();
        }
        
        private var _globalCenterPoint:Point;
        public function set globalCenterPoint(value:Point):void {
            _globalCenterPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.CENTER_CHANGED));
        }
        public function get globalCenterPoint():Point {
            return _globalCenterPoint.clone();
        }
        
        private var _globalRightPoint:Point;
        public function set globalRightPoint(value:Point):void {
            _globalRightPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.RIGHT_CHANGED));
        }
        public function get globalRightPoint():Point {
            return _globalRightPoint.clone();
        }
        
        private var _globalBottomLeftPoint:Point;
        public function set globalBottomLeftPoint(value:Point):void {
            _globalBottomLeftPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.BOTTOM_LEFT_CHANGED));
        }
        public function get globalBottomLeftPoint():Point {
            return _globalBottomLeftPoint.clone();
        }
        
        private var _globalBottomPoint:Point;
        public function set globalBottomPoint(value:Point):void {
            _globalBottomPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.BOTTOM_CHANGED));
        }
        public function get globalBottomPoint():Point {
            return _globalBottomPoint.clone();
        }
        
        private var _globalBottomRightPoint:Point;
        public function set globalBottomRightPoint(value:Point):void {
            _globalBottomRightPoint = value;
            
            dispatchEvent(new TransformerEvent(TransformerEvent.BOTTOM_RIGHT_CHANGED));
        }
        public function get globalBottomRightPoint():Point {
            return _globalBottomRightPoint.clone();
        }
        
        private var _rotateEnable:Boolean = true;
        public function set rotateEnable(value:Boolean):void {
            if(_rotateEnable != value) {
                _rotateEnable = value;
                
                updateControlsEnabled();
            }
        }
        
        public function get rotateEnable():Boolean {
            return _rotateEnable;
        }
        
        private var _moveEnabled:Boolean = true;
		public function set moveEnabled(value:Boolean):void {
			if (_moveEnabled != value) {
				_moveEnabled = value;
				updateControlsEnabled();
			}
		}
		
		public function get moveEnabled():Boolean {
			return _moveEnabled;
		}
		
		private var _sizeEnable:Boolean = true;
		public function set sizeEnable(value:Boolean):void {
		    if(_sizeEnable != value) {
		        _sizeEnable = value;
		        
		        updateControlsEnabled();
		    } 
		}
		
		private var _centerEnable:Boolean = true;
		public function centerEnable(value:Boolean):void {
		    if(_centerEnable != value) {
		        _centerEnable = value;
		        
		        updateControlsEnabled();
		    }
		}
		
		private var  _isScaleWidthHeight:Boolean = true;
		public function set isScaleWidthHeight(value:Boolean):void {
		    _isScaleWidthHeight = value;
		}
		
		public function get isScaleWidthHeight():Boolean {
		    return _isScaleWidthHeight;
		}
		
		private var _reverseScaleXEnable:Boolean = false;
		public function set reverseScaleXEnable(value:Boolean):void {
		    _reverseScaleXEnable = value;
		}
		
		public function get reverseScaleXEnable():Boolean {
		    return _reverseScaleXEnable;
		}
		
		private var _reverseScaleYEnable:Boolean = true;
		public function set reverseScaleYEnable(value:Boolean):void {
		    _reverseScaleYEnable = value;
		}
		
		public function get reverseScaleYEnable():Boolean {
		    return _reverseScaleYEnable;
		}
        		
        private var _target: Object;
        private var targetChangedFlag:Boolean = false;
        
        public function set target(v: Object):void 
        {
	        if (v == this 
	        	|| ((v is DisplayObject) && contains(v as DisplayObject)) 
	        	|| (v is DisplayObjectContainer && (v as DisplayObjectContainer).contains(this))
	        	) 
	        	return;
        
            if(v is IVisualElement)
            {
            	v.owner.setElementIndex(v, v.owner.numElements-1);
            }else if (v is DisplayObject)
            {
            	if ((v as DisplayObject).parent)
            	{
            		v.parent.setChildIndex((v as DisplayObject),v.parent.numChildren-1);
            	}
            }else{
            	throw new Error("invalid target")
            }
            
            if (parent is IVisualElementContainer)
            {
            	(this.owner as IVisualElementContainer).setElementIndex(this,(this.owner as IVisualElementContainer).numElements-1);
            }else{
            	 this.parent.setChildIndex(this, this.parent.numChildren-1);
            }
            
             _target = v;
            targetChangedFlag = true;
            invalidateProperties();
        }
        
        public function get target(): Object {
            return _target;
        }
        
        public function Transformer() {
            super();
            
            addEventListener(TransformerEvent.CONTROL_START,controlStartHandler);
            addEventListener(TransformerEvent.CONTROL_END,controlEndHandler);
            
            addEventListener(TransformerEvent.TOP_LEFT_CHANGED,updateTargetTransform);
            addEventListener(TransformerEvent.TOP_RIGHT_CHANGED,updateTargetTransform);
            addEventListener(TransformerEvent.BOTTOM_LEFT_CHANGED,updateTargetTransform);
            addEventListener(TransformerEvent.BOTTOM_RIGHT_CHANGED,updateTargetTransform);
        }
        
        override protected function createChildren():void {
            createControls();
        }
        
        override protected function commitProperties():void {
            if(targetChangedFlag) {
                updatedTarget();
                targetChangedFlag = false;
            }
        }
        
        private function updateTargetTransform(e:TransformerEvent):void {
            if(_target) {
                var nowM:Matrix = new Matrix();
                nowM.a = (globalTopRightPoint.x - globalTopLeftPoint.x)/_target.width;
                nowM.b = (globalTopRightPoint.y - globalTopLeftPoint.y)/_target.width;
                nowM.c = (globalBottomLeftPoint.x - globalTopLeftPoint.x)/_target.height;
                nowM.d = (globalBottomLeftPoint.y - globalTopLeftPoint.y)/_target.height;
                nowM.tx = globalTopLeftPoint.x;
                nowM.ty = globalTopLeftPoint.y;
                
                _target.width = Point.distance(globalTopRightPoint,globalTopLeftPoint);
                _target.height = Point.distance(globalBottomLeftPoint,globalTopLeftPoint);
                
                var m:Matrix = _target.parent.transform.concatenatedMatrix;
                m.invert();
                nowM.concat(m);
                
                _target.transform.matrix = nowM;
            }
        }
        
        private function updateControlsEnabled():void {
            centerControl.visible = _centerEnable;
            
            topLeftRotateControl.visible = topRightRotateControl.visible = 
            bottomLeftRotateControl.visible = bottomRightRotateControl.visible = _rotateEnable;
            
            moveControl.visible = _moveEnabled;
            centerControl.visible = _moveEnabled;
            
            topLeftSizeControl.visible = topRighttSizeControl.visible = 
            bottomLeftSizeControl.visible = bottomRightSizeControl.visible = _sizeEnable;
        }
        
        public function updateToolInvertMatrix():void {
            var m:Matrix = transform.concatenatedMatrix;
            m.invert();
            m.concat(transform.matrix);
            transform.matrix = m;
        }
        
        private var recordeTargetWidth:Number;
        private var recordeTargetHeight:Number;
        
        public function updatedTarget():void {
            visible = Boolean(_target);
            if(_target) {
                recordeTargetWidth = _target.width;
                recordeTargetHeight = _target.height;
                
                updatePoint();
                updateControlsEnabled();
                updateToolInvertMatrix();
            }
            dispatchEvent(new TransformerEvent(TransformerEvent.NEW_TARGET));  
        }
        
        private function updatePoint():void {
            if(_target) {
                _globalTopLeftPoint     = _target.localToGlobal(new Point(0,0));
                _globalTopPoint         = _target.localToGlobal(new Point(_target.width/2,0));
                _globalTopRightPoint    = _target.localToGlobal(new Point(_target.width,0));
                
                _globalLeftPoint        = _target.localToGlobal(new Point(0,_target.height/2));
                _globalCenterPoint      = _target.localToGlobal(new Point(_target.width/2,_target.height/2));
                _globalRightPoint       = _target.localToGlobal(new Point(_target.width,_target.height/2));
                
                _globalBottomLeftPoint  = _target.localToGlobal(new Point(0,_target.height));
                _globalBottomPoint      = _target.localToGlobal(new Point(_target.width/2,_target.height));        
                _globalBottomRightPoint = _target.localToGlobal(new Point(_target.width,_target.height));
            }
        }
        
        private var moveControl:TransformerRectangle;
        
        private var topLeftSizeControl:ResizePoint_TopLeft;
        private var toptSizeControl:ResizePoint_Top;
        private var topRighttSizeControl:ResizePoint_TopRight;
        
        private var leftSizeControl:ResizePoint_Left;
        private var centerControl:TransformerCenterPoint;
        private var rightSizeControl:ResizePoint_Right;
        
        private var bottomLeftSizeControl:ResizePoint_BottomLeft;
        private var bottomSizeControl:ResizePoint_Bottom;
        private var bottomRightSizeControl:ResizePoint_BottomRight;
        
        private var topLeftRotateControl:RotatePoint_TopLeft;
        private var topRightRotateControl:RotatePoint_TopRight;
        private var bottomLeftRotateControl:RotatePoint_BottomLeft
        private var bottomRightRotateControl:RotatePoint_BottomRight
        
        private function createControls():void {
            topLeftRotateControl = new RotatePoint_TopLeft(this,rotateControlInteractionMethod);
            addChild(topLeftRotateControl);
            
            topRightRotateControl = new RotatePoint_TopRight(this,rotateControlInteractionMethod);
            addChild(topRightRotateControl);
            
            bottomLeftRotateControl = new RotatePoint_BottomLeft(this,rotateControlInteractionMethod);
            addChild(bottomLeftRotateControl);
            
            bottomRightRotateControl = new RotatePoint_BottomRight(this,rotateControlInteractionMethod);
            addChild(bottomRightRotateControl);
            
            moveControl = new TransformerRectangle(this);
            addChild(moveControl);
            topLeftSizeControl = new ResizePoint_TopLeft(this,topLeftSizeControlInteractionMethod);
            addChild(topLeftSizeControl);
            
            toptSizeControl = new ResizePoint_Top(this,topSizeControlInteractionMethod);
            addChild(toptSizeControl);
            
            topRighttSizeControl = new ResizePoint_TopRight(this,topRighttSizeControlInteractionMethod);
            addChild(topRighttSizeControl);

            leftSizeControl = new ResizePoint_Left(this,leftSizeControlInteractionMethod);
            addChild(leftSizeControl);
            
            centerControl = new TransformerCenterPoint(this,moveControlInteractionMethod);
            addChild(centerControl);
            
            rightSizeControl = new ResizePoint_Right(this,rightSizeControlInteractionMethod);
            addChild(rightSizeControl);

            bottomLeftSizeControl = new ResizePoint_BottomLeft(this,bottomLeftSizeControlInteractionMethod);
            addChild(bottomLeftSizeControl);
            
            bottomSizeControl = new ResizePoint_Bottom(this,bottomSizeControlInteractionMethod);
            addChild(bottomSizeControl);
            
            bottomRightSizeControl = new ResizePoint_BottomRight(this,bottomRightSizeControlInteractionMethod);
            addChild(bottomRightSizeControl);
        }
        
        private var startMousePoint:Point;
        private var recordeTopLeftP:Point;
        private var recordeTopP:Point;
        private var recordeTopRightP:Point;
        
        private var recordeLeftP:Point;
        private var recordeCenterP:Point;
        private var recordeRightP:Point;
        
        private var recordeBottomLeftP:Point;
        private var recordeBottomP:Point;
        private var recordeBottomRightP:Point;
        
        private var recordeAngle:Number = 0;
        
        private function controlStartHandler(e:TransformerEvent):void {
            startMousePoint = new Point(e.mouseEvent.stageX,e.mouseEvent.stageY);
            recordeTopLeftP = globalTopLeftPoint;
            recordeTopP = globalTopPoint;
            recordeTopRightP = globalTopRightPoint;
            
            recordeLeftP = globalLeftPoint;
            recordeCenterP = globalCenterPoint;
            recordeRightP = globalRightPoint;
            
            recordeBottomLeftP = globalBottomLeftPoint;
            recordeBottomP = globalBottomPoint;
            recordeBottomRightP = globalBottomRightPoint;
            
            recordeAngle = Math.atan2(startMousePoint.y - globalCenterPoint.y,startMousePoint.x - globalCenterPoint.x);
        }
        
        private function controlEndHandler(e:TransformerEvent):void {
            startMousePoint = null;
        }
        
        private function moveControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            var xoff:Number = currentMousePoint.x - startMousePoint.x;
            var yoff:Number = currentMousePoint.y - startMousePoint.y;
            
            globalTopLeftPoint = new Point(recordeTopLeftP.x + xoff, recordeTopLeftP.y + yoff);
            globalTopPoint = new Point(recordeTopP.x + xoff, recordeTopP.y + yoff);
            globalTopRightPoint = new Point(recordeTopRightP.x + xoff, recordeTopRightP.y + yoff);
            globalLeftPoint = new Point(recordeLeftP.x + xoff, recordeLeftP.y + yoff);
            globalCenterPoint = new Point(recordeCenterP.x + xoff, recordeCenterP.y + yoff);
            globalRightPoint = new Point(recordeRightP.x + xoff, recordeRightP.y + yoff);
            globalBottomLeftPoint = new Point(recordeBottomLeftP.x + xoff, recordeBottomLeftP.y + yoff);
            globalBottomPoint = new Point(recordeBottomP.x + xoff, recordeBottomP.y + yoff);
            globalBottomRightPoint = new Point(recordeBottomRightP.x + xoff, recordeBottomRightP.y + yoff);                                                           
        }
        
        private function leftSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            var recordl:Point = globalLeftPoint.clone();
            globalLeftPoint = TransformHeiper.getTheFirdPerpendicularPoint(recordeLeftP,
                                        globalCenterPoint,currentMousePoint);
                                        
            var recordr:Point = globalRightPoint.clone();                     
            globalRightPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalLeftPoint);
            
            var offLeftX:Number = globalLeftPoint.x - recordl.x;
            var offLeftY:Number = globalLeftPoint.y - recordl.y;
            globalTopLeftPoint = new Point(globalTopLeftPoint.x + offLeftX,
                                        globalTopLeftPoint.y + offLeftY);
            globalBottomLeftPoint = new Point(globalBottomLeftPoint.x + offLeftX,
                                        globalBottomLeftPoint.y + offLeftY);
            var offRightX:Number = globalRightPoint.x -  recordr.x;
            var offRightY:Number = globalRightPoint.y -  recordr.y;
            
            globalTopRightPoint =  new Point(globalTopRightPoint.x + offRightX,
                                        globalTopRightPoint.y + offRightY);
            globalBottomRightPoint =  new Point(globalBottomRightPoint.x + offRightX,
                                        globalBottomRightPoint.y + offRightY);                                                                 
        }
        
        private function rightSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            var recordr:Point = globalRightPoint.clone();
            globalRightPoint = TransformHeiper.getTheFirdPerpendicularPoint(recordeRightP,
                                        globalCenterPoint,currentMousePoint);
                                        
            var recordl:Point = globalLeftPoint.clone();                     
            globalLeftPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalRightPoint);
            
            var offRightX:Number = globalRightPoint.x -  recordr.x;
            var offRightY:Number = globalRightPoint.y -  recordr.y;
            
            globalTopRightPoint =  new Point(globalTopRightPoint.x + offRightX,
                                        globalTopRightPoint.y + offRightY);
            globalBottomRightPoint =  new Point(globalBottomRightPoint.x + offRightX,
                                        globalBottomRightPoint.y + offRightY); 
                                        
            var offLeftX:Number = globalLeftPoint.x - recordl.x;
            var offLeftY:Number = globalLeftPoint.y - recordl.y;
            globalTopLeftPoint = new Point(globalTopLeftPoint.x + offLeftX,
                                        globalTopLeftPoint.y + offLeftY);
            globalBottomLeftPoint = new Point(globalBottomLeftPoint.x + offLeftX,
                                        globalBottomLeftPoint.y + offLeftY);
        }
        
        private function topSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            var recordt:Point = globalTopPoint.clone();
            globalTopPoint = TransformHeiper.getTheFirdPerpendicularPoint(recordt,
                                        globalCenterPoint,currentMousePoint);
                                      
            var recordb:Point = globalBottomPoint.clone();
            globalBottomPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalTopPoint);
                                        
            var offTopX:Number = globalTopPoint.x - recordt.x;
            var offTopY:Number = globalTopPoint.y - recordt.y;
            globalTopLeftPoint = new Point(globalTopLeftPoint.x + offTopX,
                                        globalTopLeftPoint.y + offTopY);
            globalTopRightPoint = new Point(globalTopRightPoint.x + offTopX,
                                        globalTopRightPoint.y + offTopY);
                                                              
            var offBottomX:Number = globalBottomPoint.x - recordb.x;
            var offBottomY:Number = globalBottomPoint.y - recordb.y;
            globalBottomLeftPoint = new Point(globalBottomLeftPoint.x + offBottomX,
                                        globalBottomLeftPoint.y + offBottomY);
            globalBottomRightPoint = new Point(globalBottomRightPoint.x + offBottomX,
                                        globalBottomRightPoint.y + offBottomY);                                                
        }
        
        private function bottomSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            var recordb:Point = globalBottomPoint.clone();
            globalBottomPoint = TransformHeiper.getTheFirdPerpendicularPoint(recordb,
                                        globalCenterPoint,currentMousePoint);
            var offBottomX:Number = globalBottomPoint.x - recordb.x;
            var offBottomY:Number = globalBottomPoint.y - recordb.y;
            globalBottomLeftPoint = new Point(globalBottomLeftPoint.x + offBottomX,
                                        globalBottomLeftPoint.y + offBottomY);
            globalBottomRightPoint = new Point(globalBottomRightPoint.x + offBottomX,
                                        globalBottomRightPoint.y + offBottomY);
            var recordt:Point = globalTopPoint.clone();
            globalTopPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalBottomPoint)
            var offTopX:Number = globalTopPoint.x - recordt.x;
            var offTopY:Number = globalTopPoint.y - recordt.y;
            globalTopLeftPoint = new Point(globalTopLeftPoint.x + offTopX,
                                        globalTopLeftPoint.y + offTopY);
            globalTopRightPoint = new Point(globalTopRightPoint.x + offTopX,
                                        globalTopRightPoint.y + offTopY);                                                
        }
        
        private function topLeftSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            globalTopLeftPoint = currentMousePoint;
            globalBottomRightPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalTopLeftPoint);
            globalTopRightPoint = TransformHeiper.getLineMirrorPoint(globalCenterPoint,globalTopPoint,globalTopLeftPoint);
            globalBottomLeftPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalTopRightPoint);
            
            globalTopPoint = Point.interpolate(globalTopLeftPoint,globalTopRightPoint,0.5);
            globalBottomPoint = Point.interpolate(globalBottomLeftPoint,globalBottomRightPoint,0.5);
            globalRightPoint = Point.interpolate(globalTopRightPoint,globalBottomRightPoint,0.5);
            globalLeftPoint = Point.interpolate(globalTopLeftPoint,globalBottomLeftPoint,0.5);
        }
        
        private function topRighttSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            globalTopRightPoint = currentMousePoint;
            globalBottomLeftPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalTopRightPoint);
            globalTopLeftPoint = TransformHeiper.getLineMirrorPoint(globalCenterPoint,globalTopPoint,globalTopRightPoint);
            globalBottomRightPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalTopLeftPoint);
            
            globalTopPoint = Point.interpolate(globalTopLeftPoint,globalTopRightPoint,0.5);
            globalBottomPoint = Point.interpolate(globalBottomLeftPoint,globalBottomRightPoint,0.5);
            globalRightPoint = Point.interpolate(globalTopRightPoint,globalBottomRightPoint,0.5);
            globalLeftPoint = Point.interpolate(globalTopLeftPoint,globalBottomLeftPoint,0.5);
        }
        
        private function bottomLeftSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            globalBottomLeftPoint = currentMousePoint;
            globalTopRightPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalBottomLeftPoint);
            globalBottomRightPoint = TransformHeiper.getLineMirrorPoint(globalCenterPoint,globalBottomPoint,globalBottomLeftPoint);
            globalTopLeftPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalBottomRightPoint);
            
            globalTopPoint = Point.interpolate(globalTopLeftPoint,globalTopRightPoint,0.5);
            globalBottomPoint = Point.interpolate(globalBottomLeftPoint,globalBottomRightPoint,0.5);
            globalRightPoint = Point.interpolate(globalTopRightPoint,globalBottomRightPoint,0.5);
            globalLeftPoint = Point.interpolate(globalTopLeftPoint,globalBottomLeftPoint,0.5);
        }
        
        private function bottomRightSizeControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            
            globalBottomRightPoint = currentMousePoint;
            globalTopLeftPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalBottomRightPoint);
            globalBottomLeftPoint = TransformHeiper.getLineMirrorPoint(globalCenterPoint,globalBottomPoint,globalBottomRightPoint);
            globalTopRightPoint = TransformHeiper.getPointMirrorPoint(globalCenterPoint,globalBottomLeftPoint);
            
            globalTopPoint = Point.interpolate(globalTopLeftPoint,globalTopRightPoint,0.5);
            globalBottomPoint = Point.interpolate(globalBottomLeftPoint,globalBottomRightPoint,0.5);
            globalRightPoint = Point.interpolate(globalTopRightPoint,globalBottomRightPoint,0.5);
            globalLeftPoint = Point.interpolate(globalTopLeftPoint,globalBottomLeftPoint,0.5);
        }
        
        private function rotateControlInteractionMethod(e:MouseEvent):void {
            var currentMousePoint:Point = new Point(e.stageX,e.stageY);
            var angle:Number = Math.atan2(currentMousePoint.y - globalCenterPoint.y,currentMousePoint.x - globalCenterPoint.x);
            angle -= recordeAngle;
            
            globalTopLeftPoint =  TransformHeiper.getRotateWithCenterPoint(globalCenterPoint,recordeTopLeftP,angle);
            globalBottomRightPoint = TransformHeiper.getRotateWithCenterPoint(globalCenterPoint,recordeBottomRightP,angle);
            globalBottomLeftPoint = TransformHeiper.getRotateWithCenterPoint(globalCenterPoint,recordeBottomLeftP,angle);
            globalTopRightPoint = TransformHeiper.getRotateWithCenterPoint(globalCenterPoint,recordeTopRightP,angle);
            
            globalTopPoint = Point.interpolate(globalTopLeftPoint,globalTopRightPoint,0.5);
            globalBottomPoint = Point.interpolate(globalBottomLeftPoint,globalBottomRightPoint,0.5);
            globalRightPoint = Point.interpolate(globalTopRightPoint,globalBottomRightPoint,0.5);
            globalLeftPoint = Point.interpolate(globalTopLeftPoint,globalBottomLeftPoint,0.5);
        }
    }
}