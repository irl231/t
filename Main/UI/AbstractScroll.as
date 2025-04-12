// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.AbstractScroll

package Main.UI
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.*;
    import flash.utils.*;
    import Main.*;

    public class AbstractScroll extends MovieClip 
    {

        public var h:Sprite;
        public var b:Sprite;
        public var hit:Sprite;
        public var a1:Sprite;
        public var a2:Sprite;
        private var mouseDown:Boolean = false;
        private var subjectMask:Sprite;
        private var scrollFromBottom:Boolean = false;
        private var subject:Sprite;
        private var hRun:int = 0;
        private var dRun:int = 0;
        private var mbY:int = 0;
        private var mhY:int = 0;
        private var mbD:int = 0;
        private var timeout:int = 0;
        private var oy:Number = -1;

        public function AbstractScroll():void
        {
            this.hit.buttonMode = true;
            this.a1.buttonMode = true;
            this.a2.buttonMode = true;
        }

        public function update():void
        {
            this.hRun = 0;
            this.dRun = 0;
            this.mbY = 0;
            this.mhY = 0;
            this.mbD = 0;
            this.hRun = (this.b.height - this.h.height);
            this.dRun = ((this.subject.height - this.subjectMask.height) + 20);
        }

        public function init(data:Object):void
        {
            this.subjectMask = data.subjectMask;
            this.subject = data.subject;
            this.scrollFromBottom = data.scrollFromBottom;
            this.hRun = (this.b.height - this.h.height);
            this.dRun = ((this.subject.height - this.subjectMask.height) + 20);
            if (((data.reset) || (this.oy == -1)))
            {
                this.oy = this.subject.y;
                if (this.scrollFromBottom)
                {
                    this.h.y = (this.b.height - this.h.height);
                }
                else
                {
                    this.h.y = 0;
                };
            };
            this.removeEvents();
            this.hit.alpha = 0;
            if (this.subject.height > this.subjectMask.height)
            {
                this.h.addEventListener(Event.ENTER_FRAME, this.hEF);
                this.hit.addEventListener(MouseEvent.MOUSE_DOWN, this._onMouseDown);
                this.a1.addEventListener(MouseEvent.CLICK, this._onUpArrowClick);
                this.a2.addEventListener(MouseEvent.CLICK, this._onDnArrowClick);
                this.subject.addEventListener(MouseEvent.MOUSE_DOWN, this._onMouseDownSubject);
                this.subject.addEventListener(MouseEvent.MOUSE_UP, this._onMouseUpSubject);
                this.subject.addEventListener(MouseEvent.MOUSE_WHEEL, this._onMouseWheel);
                transform.colorTransform = MainController.defaultCT;
            }
            else
            {
                transform.colorTransform = MainController.darkCT;
            };
        }

        public function destroy():void
        {
            this.removeEvents();
            stage.removeEventListener(MouseEvent.MOUSE_UP, this._onMouseUp);
            parent.removeChild(this);
        }

        private function removeEvents():void
        {
            this.h.removeEventListener(Event.ENTER_FRAME, this.hEF);
            this.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this._onMouseDown);
            this.a1.removeEventListener(MouseEvent.CLICK, this._onUpArrowClick);
            this.a2.removeEventListener(MouseEvent.CLICK, this._onDnArrowClick);
            this.subject.removeEventListener(MouseEvent.MOUSE_DOWN, this._onMouseDownSubject);
            this.subject.removeEventListener(MouseEvent.MOUSE_UP, this._onMouseUpSubject);
            this.subject.removeEventListener(MouseEvent.MOUSE_WHEEL, this._onMouseWheel);
        }

        private function _onUpArrowClick(_arg1:MouseEvent):void
        {
            this.h.y = (this.h.y - (this.hRun * ((this.subject.height / (this.subject.numChildren - 1)) / this.subject.height)));
            if ((this.h.y + this.h.height) > this.b.height)
            {
                this.h.y = int((this.b.height - this.h.height));
            };
            if (this.h.y < 0)
            {
                this.h.y = 0;
            };
        }

        private function _onDnArrowClick(_arg1:MouseEvent):void
        {
            this.h.y = (this.h.y + Math.ceil((this.hRun * (((1.1 * this.subject.height) / this.subject.numChildren) / this.subject.height))));
            if ((this.h.y + this.h.height) > this.b.height)
            {
                this.h.y = int((this.b.height - this.h.height));
            };
            if (this.h.y < 0)
            {
                this.h.y = 0;
            };
        }

        private function _onMouseDown(_arg1:MouseEvent):void
        {
            if (!this.h.hitTestPoint(mouseX, mouseY))
            {
                this.h.y = (mouseY - int((this.h.height >> 1)));
                if ((this.h.y + this.h.height) > this.b.height)
                {
                    this.h.y = int((this.b.height - this.h.height));
                };
                if (this.h.y < 0)
                {
                    this.h.y = 0;
                };
            };
            this.mbY = int(mouseY);
            this.mhY = int(this.h.y);
            this.mouseDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, this._onMouseUp);
        }

        private function _onMouseUp(_arg1:MouseEvent):void
        {
            this.mouseDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this._onMouseUp);
        }

        private function _onMouseWheel(mouseEvent:MouseEvent):void
        {
            var i:int;
            var wheelDelta:int;
            var delta:int = mouseEvent.delta;
            if (delta > 0)
            {
                wheelDelta = delta;
                i = 0;
                while (i < wheelDelta)
                {
                    this.a1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    i++;
                };
            }
            else
            {
                wheelDelta = (delta * -1);
                i = 0;
                while (i < wheelDelta)
                {
                    this.a2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    i++;
                };
            };
        }

        private function _onMouseUpSubject(e:MouseEvent):void
        {
            this.mouseDown = false;
            clearInterval(this.timeout);
        }

        private function _onMouseDownSubject(_arg1:MouseEvent):void
        {
            this.timeout = setTimeout(function ():void
            {
                if (!h.hitTestPoint(mouseX, mouseY))
                {
                    h.y = (mouseY - int((h.height >> 1)));
                    if ((h.y + h.height) > b.height)
                    {
                        h.y = int((b.height - h.height));
                    };
                    if (h.y < 0)
                    {
                        h.y = 0;
                    };
                };
                mbY = int(mouseY);
                mhY = int(h.y);
                mouseDown = true;
                stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
            }, 250);
        }

        private function hEF(event:Event):void
        {
            if (this.mouseDown)
            {
                if (this.scrollFromBottom)
                {
                    this.mbD = (this.mbY - int(mouseY));
                    this.h.y = (this.mhY - this.mbD);
                }
                else
                {
                    this.mbD = (int(mouseY) - this.mbY);
                    this.h.y = (this.mhY + this.mbD);
                };
                if ((this.h.y + this.h.height) > this.b.height)
                {
                    this.h.y = int((this.b.height - this.h.height));
                };
                if (this.h.y < 0)
                {
                    this.h.y = 0;
                };
            };
            var number:Number = int((((this.scrollFromBottom) ? ((-(this.h.y) / this.hRun) * this.dRun) : ((-(this.h.y) / this.hRun) * this.dRun)) + this.oy));
            this.subject.y = ((Math.abs((number - this.subject.y)) > 0.2) ? (this.subject.y + ((number - this.subject.y) / 1.1)) : number);
        }


    }
}//package Main.UI

