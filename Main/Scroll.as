// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Scroll

package Main
{
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class Scroll 
    {

        private var scroll:MovieClip;
        private var list:DisplayObject;
        private var listMask:DisplayObject;
        private var scrollHit:DisplayObject;
        private var scrollBar:DisplayObject;
        private var scrollBarBack:DisplayObject;
        private var hRun:int = 0;
        private var mhY:int = 0;
        private var mbY:int = 0;
        private var dRun:int = 0;
        private var oy:int = 0;
        private var mouseDown:Boolean = false;

        public function Scroll(scroll:MovieClip, list:DisplayObject, mask:DisplayObject, hit:DisplayObject, h:DisplayObject, b:DisplayObject, isResize:Boolean=true)
        {
            this.scroll = scroll;
            this.list = list;
            this.listMask = mask;
            this.scrollHit = hit;
            this.scrollBar = h;
            this.scrollBarBack = b;
            this.scrollHit.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownScrollHit);
            this.scroll.visible = false;
            this.scrollHit.alpha = 0;
            this.scrollBar.y = 0;
            if (this.list.height > this.scrollBarBack.height)
            {
                if (isResize)
                {
                    this.scrollBar.height = int(((this.scrollBarBack.height / this.list.height) * this.scrollBarBack.height));
                };
                this.hRun = (this.scrollBarBack.height - this.scrollBar.height);
                this.dRun = ((this.list.height - this.scrollBarBack.height) + 10);
                this.oy = (this.list.y = this.listMask.y);
                this.scroll.visible = true;
                this.scrollHit.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownScrollHit);
            };
        }

        private function onEnterFrame(e:Event):void
        {
            var hP:Number = (-(this.scrollBar.y) / this.hRun);
            var tY:Number = (int((hP * this.dRun)) + this.oy);
            if (Math.abs((tY - this.list.y)) > 0.2)
            {
                this.list.y = (this.list.y + ((tY - this.list.y) >> 2));
            }
            else
            {
                this.list.y = tY;
            };
        }

        private function onMouseDownScrollHit(mouseEvent:MouseEvent):void
        {
            this.mbY = int(Game.root.mouseY);
            this.mhY = this.scrollBar.y;
            this.onMouseUp(null);
            this.mouseDown = true;
            this.list.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            Game.root.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            Game.root.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveScrollBar);
        }

        private function onMouseUp(mouseEvent:MouseEvent):void
        {
            this.mouseDown = false;
            this.list.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            Game.root.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            Game.root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveScrollBar);
        }

        private function onMouseMoveScrollBar(mouseEvent:MouseEvent):void
        {
            this.scrollBar.y = (this.mhY + (int(Game.root.mouseY) - this.mbY));
            if ((this.scrollBar.y + this.scrollBar.height) > this.scrollBarBack.height)
            {
                this.scrollBar.y = int((this.scrollBarBack.height - this.scrollBar.height));
            };
            if (this.scrollBar.y < 0)
            {
                this.scrollBar.y = 0;
            };
        }


    }
}//package Main

