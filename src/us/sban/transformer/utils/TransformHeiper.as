package us.sban.transformer.utils {
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    public class TransformHeiper {
        public static function getLineMirrorPoint(lineP0:Point,lineP1:Point,p0:Point):Point {
            if(lineP0.x == lineP1.x) {
                return new Point(2*lineP0.x-p0.x,p0.y);
            }
            else if(lineP0.y == lineP1.y) {
                return new Point(p0.x,2*lineP0.y-p0.y);
            }
            else {
                var k:Number = (lineP1.y - lineP0.y)/(lineP1.x-lineP0.x);
                var b:Number = lineP0.y - k*lineP0.x;
                
                var x:Number = 2*(p0.x+k*p0.y-k*b)/(k*k+1)-p0.x;
                var y:Number = 2*(k*p0.x+k*k*p0.y+b)/(k*k+1)-p0.y;
                return new Point(x,y);
            }
        }
        
        public static function getRotateWithCenterPoint(centerP:Point,p0:Point,angle:Number):Point {
            var cos:Number = Math.cos(angle);
            var sin:Number = Math.sin(angle);
            
            var xoff:Number = p0.x - centerP.x;
            var yoff:Number = p0.y - centerP.y;
            var x:Number = centerP.x + cos*xoff - sin*yoff;
            var y:Number = centerP.y + cos*yoff + sin*xoff;
            return new Point(x,y);
        }
        
        public static function getTheLinePointX(p0:Point,p1:Point,y:Number):Number {
            return (y-p0.y)*(p1.x-p0.x)/(p1.y-p0.y)+p0.x;
        }
        
        public static function getTheLinePointY(p0:Point,p1:Point,x:Number):Number {
            return (x-p0.x)*(p1.y-p0.y)/(p1.x-p0.x)+p0.y;
        }
        
        public static function getTheFirdPerpendicularPoint(p0:Point,globalCenterPoint:Point,currentMousePoint:Point):Point {
            if(p0.y == globalCenterPoint.y) {
                return new Point(currentMousePoint.x,p0.y);
            }
            else if(p0.x == globalCenterPoint.x) {
                return new Point(p0.x,currentMousePoint.y);
            }
            else {
                var k0:Number = (globalCenterPoint.y-p0.y)/(globalCenterPoint.x-p0.x);
                var b0:Number = p0.y - p0.x*k0;
                var k1:Number = -1/k0;
                k1 = -1/k0;
                var b1:Number = currentMousePoint.y - currentMousePoint.x*k1;
                var x:Number = (b0-b1)/(k1-k0);
                var y:Number = (b1*k0-b0*k1)/(k0-k1);
                return new Point(x,y);
            }
        }
        
        public static function getPointMirrorPoint(centerPoint:Point,p1:Point):Point {
            return new Point(centerPoint.x*2 - p1.x,centerPoint.y*2 - p1.y);      
        }
        
        public static function countRadianByP0AndP1(p0:Point,p1:Point):Number {
            var dx:Number = p1.x - p0.x;
            var dy:Number = p1.y - p0.y;
            var radian:Number = Math.atan2(dy,dx);
			return radian;
        }
        
        private static const MIN_NUMBER:Number = 1.0e-10;
        
        public static function matrixRegulate(m:Matrix):Matrix {
            var result:Matrix = m.clone();
            if(result.b <= MIN_NUMBER) {
                result.b = 0;
            }
            if(result.c <= MIN_NUMBER) {
                result.c = 0;
            }
            return result;
        }
        
        public static function countPositive2NegativeBy4Point(p0:Point,p1:Point,p2:Point):int {
            var p0_p1:Point = p1.subtract(p0);
            var p0_p2:Point = p2.subtract(p0);
            var p0_p3:Point = p0_p1.add(p0_p2);
            var p0_p1Xp0_p3:Number = p0_p1.x*p0_p3.y - p0_p3.x*p0_p1.y;
            return p0_p1Xp0_p3>0?1:(p0_p1Xp0_p3<0?-1:0);
        }
    }
}