// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//ModalMC

package 
{
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;

    public class ModalMC extends MovieClip 
    {

        public var cnt:MovieClip;
        public var isOpen:Boolean = false;
        public var greedy:Boolean = false;
        private var rootClass:Game;
        private var fData:Object = null;
        private var callback:Function = null;
        private var qtySel:QtySelectorMC;
        private var heightOffset:int = 42;
        private var glowColors:Object = {
            "white":0xFFFFFF,
            "red":0xFF0000,
            "green":0xFF00,
            "blue":0xFF,
            "gold":16750899
        };
        private var glowSizes:Object = {"medium":3};

        public function ModalMC():void
        {
            addFrameScript(3, this.frame4, 11, this.frame12);
        }

        private static function setCT(movieClip:MovieClip, color:uint):void
        {
            var colorTransform:ColorTransform = movieClip.transform.colorTransform;
            colorTransform.color = color;
            movieClip.transform.colorTransform = colorTransform;
        }

        private static function yMouseOver(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0x222222);
        }

        private static function yMouseOut(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0);
        }

        private static function nMouseOver(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0x222222);
        }

        private static function nMouseOut(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0);
        }


        public function init(object:Object):void
        {
            var _local2:String;
            var _local3:String;
            this.fData = object;
            this.callback = object.callback;
            if (object.greedy != null)
            {
                this.greedy = object.greedy;
            };
            this.rootClass = Game.root;
            this.cnt.strBody.autoSize = "center";
            this.cnt.strBody.htmlText = this.fData.strBody;
            if (((object.btns == null) || (object.btns == "dual")))
            {
                this.cnt.btns.dual.ybtn.buttonMode = true;
                this.cnt.btns.dual.nbtn.buttonMode = true;
                this.cnt.btns.dual.ybtn.addEventListener(MouseEvent.CLICK, this.yClick, false, 0, true);
                this.cnt.btns.dual.ybtn.addEventListener(MouseEvent.MOUSE_OVER, yMouseOver, false, 0, true);
                this.cnt.btns.dual.ybtn.addEventListener(MouseEvent.MOUSE_OUT, yMouseOut, false, 0, true);
                this.cnt.btns.dual.nbtn.addEventListener(MouseEvent.CLICK, this.nClick, false, 0, true);
                this.cnt.btns.dual.nbtn.addEventListener(MouseEvent.MOUSE_OVER, nMouseOver, false, 0, true);
                this.cnt.btns.dual.nbtn.addEventListener(MouseEvent.MOUSE_OUT, nMouseOut, false, 0, true);
                this.cnt.btns.mono.visible = false;
            }
            else
            {
                this.cnt.btns.mono.buttonMode = true;
                this.cnt.btns.mono.addEventListener(MouseEvent.CLICK, this.mClick, false, 0, true);
                this.cnt.btns.mono.addEventListener(MouseEvent.MOUSE_OVER, yMouseOver, false, 0, true);
                this.cnt.btns.mono.addEventListener(MouseEvent.MOUSE_OUT, yMouseOut, false, 0, true);
                this.cnt.btns.dual.visible = false;
            };
            if (((!(object.qtySel == null)) && (object.qtySel.max > 1)))
            {
                this.qtySel = QtySelectorMC(addChild(new QtySelectorMC(this, object.qtySel.min, object.qtySel.max)));
                this.qtySel.y = Math.round(((this.cnt.strBody.y + this.cnt.strBody.textHeight) + 10));
                this.qtySel.x = Math.round(((this.width >> 1) - (this.qtySel.width >> 1)));
                this.heightOffset = ((this.heightOffset + this.qtySel.height) + 16);
            };
            this.cnt.bg.height = Math.ceil((this.cnt.strBody.textHeight + this.heightOffset));
            this.cnt.btns.y = this.cnt.bg.height;
            this.x = ((960 >> 1) - (this.width >> 1));
            this.y = ((550 >> 1) - (this.height >> 1));
            if (object.glow != null)
            {
                _local2 = object.glow.split(",")[0];
                _local3 = object.glow.split(",")[1];
                this.filters = [new GlowFilter(this.glowColors[_local2], 1, this.glowSizes[_local3], this.glowSizes[_local3], 64, 1)];
            };
        }

        public function fClose():void
        {
            this.callback = null;
            if (this.qtySel != null)
            {
                this.qtySel.fClose();
            };
            this.killButtons();
            this.parent.removeChild(this);
        }

        private function frame4():void
        {
            stop();
        }

        private function frame12():void
        {
            if (this.stage != null)
            {
                this.fClose();
            };
        }

        private function killButtons():void
        {
            this.cnt.btns.dual.ybtn.removeEventListener(MouseEvent.CLICK, this.yClick);
            this.cnt.btns.dual.ybtn.removeEventListener(MouseEvent.MOUSE_OVER, yMouseOver);
            this.cnt.btns.dual.ybtn.removeEventListener(MouseEvent.MOUSE_OUT, yMouseOut);
            this.cnt.btns.dual.nbtn.removeEventListener(MouseEvent.CLICK, this.nClick);
            this.cnt.btns.dual.nbtn.removeEventListener(MouseEvent.MOUSE_OVER, nMouseOver);
            this.cnt.btns.dual.nbtn.removeEventListener(MouseEvent.MOUSE_OUT, nMouseOut);
            this.cnt.btns.mono.removeEventListener(MouseEvent.CLICK, this.mClick);
            this.cnt.btns.mono.removeEventListener(MouseEvent.MOUSE_OVER, yMouseOver);
            this.cnt.btns.mono.removeEventListener(MouseEvent.MOUSE_OUT, yMouseOut);
            if (this.qtySel != null)
            {
                this.qtySel.killButtons();
            };
        }

        private function yClick(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 43775);
            this.fData.params.accept = true;
            this.mouseChildren = false;
            if (this.qtySel != null)
            {
                this.fData.params.iQty = this.qtySel.val;
            };
            this.callback(this.fData.params);
            this.killButtons();
            this.gotoAndPlay("out");
        }

        private function nClick(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0xFF0000);
            var _local3:MovieClip = MovieClip(this);
            this.fData.params.accept = false;
            _local3.mouseChildren = false;
            _local3.callback(this.fData.params);
            this.killButtons();
            _local3.gotoAndPlay("out");
        }

        private function mClick(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0xFF0000);
            var _local3:MovieClip = MovieClip(this);
            _local3.mouseChildren = false;
            if (_local3.callback != null)
            {
                _local3.callback(this.fData.params);
            };
            this.killButtons();
            _local3.gotoAndPlay("out");
        }


    }
}//package 

