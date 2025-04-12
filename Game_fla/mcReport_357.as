// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcReport_357

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;

    public dynamic class mcReport_357 extends MovieClip 
    {

        public var submit:MovieClip;
        public var btnClose:SimpleButton;
        public var tDesc:TextField;
        public var bg:MovieClip;
        public var i0:MovieClip;
        public var i1:MovieClip;
        public var ti:TextField;
        public var i2:MovieClip;
        public var i3:MovieClip;
        public var iSel:*;
        public var mc:*;
        public var defaultDesc:String;
        public var tDetailTemplate:*;
        public var rootClass:Game;

        public function mcReport_357()
        {
            addFrameScript(0, this.frame1, 4, this.frame5, 9, this.frame10, 14, this.frame15, 19, this.frame20);
        }

        public function itemClick(_arg1:MouseEvent):*
        {
            this.iSel = int(MovieClip(_arg1.currentTarget).name.substr(1));
            var _local2:* = 0;
            while (_local2 < 4)
            {
                if (this.mc[("i" + _local2)] != null)
                {
                    this.mc[("i" + _local2)].d.f1.visible = (_local2 == this.iSel);
                };
                _local2++;
            };
            this.mc.submit.visible = true;
            if (((((this.tDetailTemplate.indexOf(this.tDesc.text) > -1) || (this.tDesc.text == this.defaultDesc)) || (this.tDesc.text == " ")) || (this.tDesc.text == "")))
            {
                this.tDesc.text = this.tDetailTemplate[this.iSel];
            };
        }

        public function submitClick(_arg1:MouseEvent):*
        {
            var _local2:* = Game.root;
            var _local3:* = MovieClip(parent);
            var _local4:* = " ";
            if (((this.tDesc.text.length > 3) && (!(this.tDesc.text == this.defaultDesc))))
            {
                _local4 = this.tDesc.text;
            };
            _local2.world.sendReport(["reportlang", _local3.fData.unm, this.iSel, _local4]);
            _local3.onClose(null);
        }

        public function onClose(_arg1:Event=null):void
        {
            if (MovieClip(parent).currentLabel != "Init")
            {
                MovieClip(parent).gotoAndPlay("Init");
            };
        }

        internal function frame1():*
        {
            this.iSel = -1;
            this.mc = MovieClip(this);
            this.defaultDesc = "Type reason for report here.";
            this.tDetailTemplate = [this.defaultDesc, this.defaultDesc, this.defaultDesc, this.defaultDesc];
            this.rootClass = Game.root;
            gotoAndPlay("full");
        }

        internal function frame5():*
        {
            this.i0.addEventListener(MouseEvent.CLICK, this.itemClick, false, 0, true);
            this.i1.addEventListener(MouseEvent.CLICK, this.itemClick, false, 0, true);
            this.i2.addEventListener(MouseEvent.CLICK, this.itemClick, false, 0, true);
            this.i3.addEventListener(MouseEvent.CLICK, this.itemClick, false, 0, true);
            this.submit.addEventListener(MouseEvent.CLICK, this.submitClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            this.i0.buttonMode = true;
            this.i1.buttonMode = true;
            this.i2.buttonMode = true;
            this.i3.buttonMode = true;
            this.submit.buttonMode = true;
            this.i0.d.f1.visible = false;
            this.i1.d.f1.visible = false;
            this.i2.d.f1.visible = false;
            this.i3.d.f1.visible = false;
            this.submit.visible = false;
            this.ti.text = MovieClip(parent).fData.unm;
        }

        internal function frame10():*
        {
            stop();
        }

        internal function frame15():*
        {
            this.i1.addEventListener(MouseEvent.CLICK, this.itemClick, false, 0, true);
            this.submit.addEventListener(MouseEvent.CLICK, this.submitClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            this.i1.buttonMode = true;
            this.submit.buttonMode = true;
            this.i1.d.f1.visible = false;
            this.submit.visible = false;
            this.ti.text = MovieClip(parent).fData.unm;
        }

        internal function frame20():*
        {
            stop();
        }


    }
}//package Game_fla

