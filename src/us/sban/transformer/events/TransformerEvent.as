/**
 * author:	sban <http://sban.com.cn/>
 * 2009/9/17
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 */
package us.sban.transformer.events 
{
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class TransformerEvent extends Event 
    {
        public static const CONTROL_START:String = "controlStart";
        public static const CONTROL_END:String = "controlEnd";
        
        public static const TOP_LEFT_CHANGED:String = "topLeftChanged";
        public static const TOP_CHANGED:String = "topChanged";
        public static const TOP_RIGHT_CHANGED:String = "topRightChanged";
        
        public static const LEFT_CHANGED:String = "leftChanged";
        public static const CENTER_CHANGED:String = "centerChanged";
        public static const RIGHT_CHANGED:String = "rightChanged";
        
        public static const BOTTOM_LEFT_CHANGED:String = "bottomLeftChanged";
        public static const BOTTOM_CHANGED:String = "bottomChanged";
        public static const BOTTOM_RIGHT_CHANGED:String = "bottomRightChanged";
        
        public static const CONTROL_INTERACTION:String = "controlInteraction";
        public static const NEW_TARGET:String = "newTaregt";
        
        public var mouseEvent:MouseEvent;
        
        public function TransformerEvent(type:String,mouseEvent:MouseEvent=null) 
        {
            super(type,false,false);
            this.mouseEvent = mouseEvent;
        }
    }
}