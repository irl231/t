// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcQFrame_523

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.geom.*;

    public dynamic class mcQFrame_523 extends MovieClip 
    {

        public var tl3:MovieClip;
        public var bl1:MovieClip;
        public var btnClose:SimpleButton;
        public var bg:MovieClip;
        public var tr1:MovieClip;
        public var fx:MovieClip;
        public var tr2:MovieClip;
        public var tl1:MovieClip;
        public var tr3:MovieClip;
        public var br1:MovieClip;
        public var tl2:MovieClip;

        public function mcQFrame_523()
        {
            addFrameScript(0, this.frame1);
        }

        public function buildBounds():void
        {
            var _local5:int;
            this.boundsOK = true;
            var _local1:Array = (this.tl = [{
                "mc":this.tl1,
                "dx":0,
                "dy":0
            }, {
                "mc":this.tl2,
                "dx":0,
                "dy":0
            }, {
                "mc":this.tl3,
                "dx":0,
                "dy":0
            }]);
            var _local2:Array = (this.tr = [{
                "mc":this.tl1,
                "dx":0,
                "dy":0
            }, {
                "mc":this.tr2,
                "dx":0,
                "dy":0
            }, {
                "mc":this.tr3,
                "dx":0,
                "dy":0
            }, {
                "mc":this.btnClose,
                "dx":0,
                "dy":0
            }]);
            var _local3:Array = (this.bl = [{
                "mc":this.bl1,
                "dx":0,
                "dy":0
            }]);
            var _local4:Array = (this.br = [{
                "mc":this.br1,
                "dx":0,
                "dy":0
            }]);
            var _local6:Object = {};
            var _local7:Point = new Point();
            var _local8:Point = new Point();
            var _local9:Rectangle = (this.bgA = this.bg.getBounds(this));
            _local5 = 0;
            while (_local5 < _local1.length)
            {
                _local6 = _local1[_local5];
                _local7 = _local9.topLeft;
                _local6.dx = (_local7.x - _local6.mc.x);
                _local6.dy = (_local7.y - _local6.mc.y);
                _local5++;
            };
            _local5 = 0;
            while (_local5 < _local2.length)
            {
                _local6 = _local2[_local5];
                _local7 = new Point(_local9.right, _local9.top);
                _local6.dx = (_local7.x - _local6.mc.x);
                _local6.dy = (_local7.y - _local6.mc.y);
                _local5++;
            };
            _local5 = 0;
            while (_local5 < _local3.length)
            {
                _local6 = _local3[_local5];
                _local7 = new Point(_local9.left, _local9.bottom);
                _local6.dx = (_local7.x - _local6.mc.x);
                _local6.dy = (_local7.y - _local6.mc.y);
                _local5++;
            };
            _local5 = 0;
            while (_local5 < _local4.length)
            {
                _local6 = _local4[_local5];
                _local7 = new Point(_local9.right, _local9.bottom);
                _local6.dx = (_local7.x - _local6.mc.x);
                _local6.dy = (_local7.y - _local6.mc.y);
                _local5++;
            };
        }

        public function resizeTo(_arg1:int, _arg2:int, _arg3:int=0):void
        {
            var _local8:int;
            if (!("boundsOK" in this))
            {
                this.buildBounds();
            };
            var _local4:Array = this.tl;
            var _local5:Array = this.tr;
            var _local6:Array = this.bl;
            var _local7:Array = this.br;
            var _local9:Object = {};
            var _local10:Point = new Point();
            var _local11:Point = new Point();
            var _local12:Rectangle = this.bgA;
            this.bg.width = _arg1;
            this.bg.height = _arg2;
            this.bg.x = (_local12.topLeft.x + Math.round((this.bg.width / 2)));
            this.bg.y = (_local12.topLeft.y + Math.round((this.bg.height / 2)));
            var _local13:Rectangle = this.bg.getBounds(this);
            _local8 = 0;
            while (_local8 < _local4.length)
            {
                _local9 = _local4[_local8];
                _local11 = _local13.topLeft;
                _local9.mc.x = (_local11.x - _local9.dx);
                _local9.mc.y = (_local11.y - _local9.dy);
                _local8++;
            };
            _local8 = 0;
            while (_local8 < _local5.length)
            {
                _local9 = _local5[_local8];
                _local11 = new Point(_local13.right, _local13.top);
                _local9.mc.x = (_local11.x - _local9.dx);
                _local9.mc.y = (_local11.y - _local9.dy);
                _local8++;
            };
            _local8 = 0;
            while (_local8 < _local6.length)
            {
                _local9 = _local6[_local8];
                _local11 = new Point(_local13.left, _local13.bottom);
                _local9.mc.x = (_local11.x - _local9.dx);
                _local9.mc.y = (_local11.y - _local9.dy);
                _local8++;
            };
            _local8 = 0;
            while (_local8 < _local7.length)
            {
                _local9 = _local7[_local8];
                _local11 = new Point(_local13.right, _local13.bottom);
                _local9.mc.x = (_local11.x - _local9.dx);
                _local9.mc.y = (_local11.y - _local9.dy);
                _local8++;
            };
            this.fx.y = 110;
        }

        internal function frame1():*
        {
        }


    }
}//package Game_fla

