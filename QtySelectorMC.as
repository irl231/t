// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//QtySelectorMC

package 
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;

    public class QtySelectorMC extends Sprite 
    {

        public var t1:TextField;
        public var t2:TextField;
        public var handle:MovieClip;
        public var bar:MovieClip;
        private var _min:int = 1;
        private var _max:int = 1;
        private var _callback:Function = null;
        private var isMouseDown:Boolean = false;
        private var p:Point = new Point();
        private var n:Number = 0;
        private var w:int = 0;
        private var dx:int = 0;
        private var modalMC:MovieClip;
        private var _val:int = 1;

        public function QtySelectorMC(modalMC:ModalMC=null, min:int=0, max:int=0):void
        {
            if (modalMC != null)
            {
                this.modalMC = modalMC;
                this._min = min;
                this._max = max;
                this._val = min;
                this.w = (this.bar.width - this.handle.width);
                this.t2.htmlText = (("<font color='#FFFFFF'>" + this._max) + "</font>");
                addEventListener(Event.ENTER_FRAME, this.onEF, false, 0, true);
                this.handle.addEventListener(MouseEvent.MOUSE_DOWN, this.onDn, false, 0, true);
                this.modalMC.addEventListener(MouseEvent.MOUSE_UP, this.onUp, false, 0, true);
                this.t1.addEventListener(KeyboardEvent.KEY_DOWN, this.onKey);
                this.t1.restrict = "0123456789";
                this.handle.buttonMode = true;
                this.updateHandle();
                this.update();
            };
        }

        public function setMovieClip(movieClip:MovieClip, val:int=0, min:int=0, max:int=0, callback:Function=null):void
        {
            this.modalMC = movieClip;
            this._min = min;
            this._max = max;
            this._callback = callback;
            this._val = val;
            this.w = (this.bar.width - this.handle.width);
            this.t2.htmlText = (("<font color='#FFFFFF'>" + this._max) + "</font>");
            addEventListener(Event.ENTER_FRAME, this.onEF, false, 0, true);
            this.handle.addEventListener(MouseEvent.MOUSE_DOWN, this.onDn, false, 0, true);
            this.modalMC.addEventListener(MouseEvent.MOUSE_UP, this.onUp, false, 0, true);
            this.t1.addEventListener(KeyboardEvent.KEY_DOWN, this.onKey);
            this.t1.restrict = "0123456789";
            this.handle.buttonMode = true;
            this.updateHandle();
            this.update();
        }

        public function get val():int
        {
            if (this._val != int(this.t1.text))
            {
                this._val = int(this.t1.text);
            };
            this._val = Math.max(Math.min(this._val, this._max), this._min);
            return (this._val);
        }

        public function set val(value:int):void
        {
            this._val = Math.max(Math.min(value, this._max), this._min);
        }

        public function killButtons():void
        {
            removeEventListener(Event.ENTER_FRAME, this.onEF);
            this.handle.removeEventListener(MouseEvent.MOUSE_UP, this.onDn);
            this.modalMC.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
        }

        public function fClose():void
        {
            this.killButtons();
            parent.removeChild(this);
        }

        private function update():void
        {
            this.t1.htmlText = ((this._val == this._max) ? (("<font color='#FFFFFF'>" + this._val) + "</font>") : (("<font color='#999999'>" + this._val) + "</font>"));
            if (this._callback != null)
            {
                this._callback();
            };
        }

        private function updateHandle():void
        {
            this.handle.x = Math.round((this.bar.x + (this.w * (this._val / this._max))));
        }

        private function onEF(event:Event):void
        {
            if (this.isMouseDown)
            {
                if (stage == null)
                {
                    return;
                };
                this.p.x = stage.mouseX;
                this.p.y = stage.mouseY;
                this.p = globalToLocal(this.p);
                this.p.x = (this.p.x - this.dx);
                this.handle.x = (this.n = Math.max(Math.min(this.p.x, (this.bar.x + this.w)), this.bar.x));
                this.n = (this.n - this.bar.x);
                this.n = (this.n / this.w);
                this.val = (Math.round((this.n * (this._max - 1))) + 1);
                this.update();
            };
        }

        private function onDn(mouseEvent:MouseEvent):void
        {
            this.isMouseDown = true;
            this.p.x = stage.mouseX;
            this.p.y = stage.mouseY;
            this.p = globalToLocal(this.p);
            this.dx = (this.p.x - this.handle.x);
        }

        private function onUp(mouseEvent:MouseEvent):void
        {
            this.isMouseDown = false;
        }

        private function onKey(keyboardEvent:KeyboardEvent):void
        {
            if (((keyboardEvent.charCode == Keyboard.ENTER) || (keyboardEvent.charCode == Keyboard.ESCAPE)))
            {
                this.val;
                this.update();
                this.updateHandle();
                Game.root.stage.focus = null;
            };
        }


    }
}//package 

