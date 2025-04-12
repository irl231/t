// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.MixerManagerMC

package FoM
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.ui.*;

    public class MixerManagerMC extends Sprite 
    {

        public var t1:TextField;
        public var t2:TextField;
        public var handle:MovieClip;
        public var bar:MovieClip;
        private var _min:int = 1;
        private var _max:Number = 100;
        private var _val:Number = 100;
        private var isMouseDown:Boolean = false;
        private var p:Point = new Point();
        private var n:Number = 0;
        private var w:int = 0;
        private var dx:int = 0;
        public var rootClass:MovieClip;
        public var soundValue:Number;
        private var _parent:MovieClip;

        public function MixerManagerMC():void
        {
            this.rootClass = Game.root;
            try
            {
                if (this.rootClass.userPreference.data.iSoundStrength == null)
                {
                    this._val = 1;
                }
                else
                {
                    this._val = this.rootClass.userPreference.data.iSoundStrength;
                };
            }
            catch(error:Error)
            {
            };
            this._parent = MovieClip(parent);
            this.w = (this.bar.width - this.handle.width);
            this.updateHandle();
            this.update();
            this.addEventListener(Event.ENTER_FRAME, this.onEF, false, 0, true);
            this.handle.addEventListener(MouseEvent.MOUSE_DOWN, this.onDn, false, 0, true);
            this._parent.addEventListener(MouseEvent.MOUSE_UP, this.onUp, false, 0, true);
            this.handle.t1.addEventListener(KeyboardEvent.KEY_DOWN, this.onKey);
            this.handle.t1.restrict = "0123456789";
            this.handle.t1.maxChars = 3;
            this.handle.buttonMode = true;
        }

        private function update():void
        {
            if (this._val == this._max)
            {
                this.handle.t1.htmlText = (("<font color='#FFFFFF'>" + this._val) + "</font>");
            }
            else
            {
                this.handle.t1.htmlText = (("<font color='#999999'>" + this._val) + "</font>");
            };
        }

        private function adjustSound():void
        {
            this.rootClass.world.BGMTransform.volume = (this._val / 100);
            SoundMixer.soundTransform = this.rootClass.world.BGMTransform;
            this.savePreference();
        }

        private function updateHandle():void
        {
            this.handle.x = Math.round((this.bar.x + (this.w * (this._val / this._max))));
        }

        private function onEF(_arg_1:Event):void
        {
            if (this.isMouseDown)
            {
                this.p.x = stage.mouseX;
                this.p.y = stage.mouseY;
                this.p = globalToLocal(this.p);
                this.p.x = (this.p.x - this.dx);
                this.handle.x = (this.n = Math.max(Math.min(this.p.x, (this.bar.x + this.w)), this.bar.x));
                this.n = (this.n - this.bar.x);
                this.n = (this.n / this.w);
                this._val = (Math.round((this.n * (this._max - 1))) + 1);
                this.update();
                this.adjustSound();
            };
        }

        private function onDn(_arg_1:MouseEvent):void
        {
            this.p.x = stage.mouseX;
            this.p.y = stage.mouseY;
            this.p = globalToLocal(this.p);
            this.dx = (this.p.x - this.handle.x);
            if (!this.rootClass.mixer.bSoundOn)
            {
                this.rootClass.MsgBox.notify("You need to enable Sound to use this featue.");
            }
            else
            {
                this.isMouseDown = true;
            };
        }

        private function onUp(_arg_1:MouseEvent):void
        {
            this.isMouseDown = false;
        }

        private function savePreference():void
        {
            this.rootClass.userPreference.data.iSoundStrength = this._val;
            this.rootClass.userPreference.flush();
        }

        private function onKey(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.charCode == Keyboard.ENTER) || (_arg_1.charCode == Keyboard.ESCAPE)))
            {
                this._val;
                this.update();
                this.updateHandle();
                this.rootClass.stage.focus = null;
                this.adjustSound();
                this.savePreference();
            };
        }

        public function killButtons():void
        {
            removeEventListener(Event.ENTER_FRAME, this.onEF);
            this.handle.removeEventListener(MouseEvent.MOUSE_UP, this.onDn);
            this._parent.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
        }

        public function fClose():void
        {
            this.killButtons();
        }

        public function get val():int
        {
            if (this._val != int(this.handle.t1.text))
            {
                this._val = int(this.handle.t1.text);
            };
            this._val = Math.max(Math.min(this._val, this._max), this._min);
            return (this._val);
        }

        public function set val(_arg_1:int):void
        {
            this._val = Math.max(Math.min(_arg_1, this._max), this._min);
        }


    }
}//package FoM

