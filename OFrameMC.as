// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//OFrameMC

package 
{
    import flash.display.MovieClip;
    import Game_fla.mcQFrame_523;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class OFrameMC extends MovieClip 
    {

        public var t1:MovieClip;
        public var cntMask:MovieClip;
        public var bg:mcQFrame_523;
        public var fData:Object = null;
        private var rootClass:Game = Game.root;
        internal var uli:int;
        internal var isOpen:Boolean = false;
        internal var tcnt:MovieClip;
        internal var mDown:Boolean = false;
        internal var hRun:int = 0;
        internal var dRun:int = 0;
        internal var mbY:int = 0;
        internal var mhY:int = 0;
        internal var mbD:int = 0;

        public function OFrameMC()
        {
            addFrameScript(0, this.frame1, 5, this.frame6, 9, this.frame10);
        }

        public function fOpenWith(_arg1:Object):void
        {
            this.fData = _arg1;
            this.isOpen = true;
            this.clearCnt();
            if (currentLabel != "Idle")
            {
                gotoAndPlay("Open");
            }
            else
            {
                this.update();
            };
        }

        public function fClose():void
        {
            this.isOpen = false;
            this.fData = {};
            this.clearCnt();
            if (currentLabel != "Init")
            {
                if (currentLabel == "Idle")
                {
                    gotoAndPlay("Close");
                }
                else
                {
                    gotoAndStop("Init");
                };
            };
        }

        public function update():void
        {
            var o:Object;
            var _local8:String;
            var _scr:MovieClip;
            var _cntMask:MovieClip;
            var _cnt:MovieClip;
            var _local6:int;
            var _local7:int;
            var listA1:mcUListA;
            var listA2:mcUListA;
            var listA3:mcUListA;
            var listB1:mcUListB;
            this.clearCnt();
            switch (this.fData.typ)
            {
                case "userListA":
                    listA1 = (addChild(new mcUListA()) as mcUListA);
                    listA1.name = "cnt";
                    listA1.y = ((this.t1.y + this.t1.height) + 4);
                    listA1.mask = this.cntMask;
                    listA1.scr.buttonMode = true;
                    this.t1.txtTitle.text = "Users in your area";
                    this.t1.txtSubTitle.text = "/who";
                    _local6 = 0;
                    this.tcnt = MovieClip(getChildByName("cnt"));
                    this.tcnt.strMeta.text = "Class";
                    for (_local8 in this.fData.ul)
                    {
                        o = this.tcnt.cnt.addChild(new mcUListAItem());
                        o.ID = this.fData.ul[_local8].ID;
                        o.txtName.text = this.fData.ul[_local8].sName;
                        o.txtMeta.htmlText = this.fData.ul[_local8].sClass;
                        o.txtLevel.text = this.fData.ul[_local8].iLvl;
                        o.addEventListener(MouseEvent.CLICK, this.uNameClick, false, 0, true);
                        o.buttonMode = true;
                        o.y = (_local6 * 20);
                        _local6++;
                    };
                    _scr = this.tcnt.scr;
                    if (this.tcnt.cnt.height < this.tcnt.cntMask.height)
                    {
                        _scr.visible = false;
                    }
                    else
                    {
                        _cntMask = this.tcnt.cntMask;
                        _cnt = this.tcnt.cnt;
                        _scr.visible = true;
                        _scr.h.height = int(((_cntMask.height / _cnt.height) * _scr.b.height));
                        this.hRun = (_scr.b.height - _scr.h.height);
                        this.dRun = ((_cnt.height - _cntMask.height) + 5);
                        _scr.h.y = 0;
                        _cnt.oy = (_cnt.y = _scr.y);
                        _scr.visible = false;
                        _scr.hit.alpha = 0;
                        this.mDown = false;
                        if (_cnt.height > _scr.b.height)
                        {
                            _scr.visible = true;
                            _scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                            _scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                            _cnt.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
                        };
                    };
                    this.tcnt.cnt.iproto.visible = false;
                    break;
                case "userListFriends":
                    listA2 = (addChild(new mcUListA()) as mcUListA);
                    listA2.name = "cnt";
                    listA2.y = ((this.t1.y + this.t1.height) + 4);
                    listA2.mask = this.cntMask;
                    listA2.scr.buttonMode = true;
                    this.t1.txtTitle.text = "Friends List";
                    this.t1.txtSubTitle.text = "/friends";
                    _local6 = 0;
                    this.tcnt = MovieClip(getChildByName("cnt"));
                    this.tcnt.strMeta.text = "Server";
                    _local7 = 0;
                    while (_local7 < this.fData.ul.length)
                    {
                        o = this.tcnt.cnt.addChild(new mcUListAItem());
                        o.ID = this.fData.ul[_local7].ID;
                        o.txtName.text = this.fData.ul[_local7].sName;
                        o.txtMeta.text = this.fData.ul[_local7].sServer;
                        o.txtLevel.text = this.fData.ul[_local7].iLvl;
                        o.addEventListener(MouseEvent.CLICK, this.uNameClick, false, 0, true);
                        o.buttonMode = true;
                        o.y = (_local6 * 20);
                        _local6++;
                        if (this.fData.ul[_local7].sServer == "Offline")
                        {
                            o.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -100, -100, -100, 0);
                        };
                        _local7++;
                    };
                    _scr = this.tcnt.scr;
                    if (this.tcnt.cnt.height < this.tcnt.cntMask.height)
                    {
                        _scr.visible = false;
                    }
                    else
                    {
                        _cntMask = this.tcnt.cntMask;
                        _cnt = this.tcnt.cnt;
                        _scr.visible = true;
                        _scr.h.height = int(((_cntMask.height / _cnt.height) * _scr.b.height));
                        this.hRun = (_scr.b.height - _scr.h.height);
                        this.dRun = ((_cnt.height - _cntMask.height) + 5);
                        _scr.h.y = 0;
                        _cnt.oy = (_cnt.y = _scr.y);
                        _scr.visible = false;
                        _scr.hit.alpha = 0;
                        this.mDown = false;
                        if (_cnt.height > _scr.b.height)
                        {
                            _scr.visible = true;
                            _scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                            _scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                            _cnt.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
                        };
                    };
                    this.tcnt.cnt.iproto.visible = false;
                    break;
                case "userListGuild":
                    listA3 = (addChild(new mcUListA()) as mcUListA);
                    listA3.name = "cnt";
                    listA3.y = ((this.t1.y + this.t1.height) + 4);
                    listA3.mask = this.cntMask;
                    listA3.scr.buttonMode = true;
                    this.t1.txtTitle.text = "Guild Members";
                    this.t1.txtSubTitle.text = "/guild";
                    _local6 = 0;
                    this.tcnt = MovieClip(getChildByName("cnt"));
                    this.tcnt.strMeta.text = "Server";
                    _local7 = 0;
                    while (_local7 < this.fData.ul.length)
                    {
                        o = this.tcnt.cnt.addChild(new mcUListAItem());
                        o.ID = this.fData.ul[_local7].ID;
                        o.txtName.text = this.fData.ul[_local7].userName;
                        o.txtMeta.text = this.fData.ul[_local7].Server;
                        o.txtLevel.text = this.fData.ul[_local7].Level;
                        o.addEventListener(MouseEvent.CLICK, this.uNameClick, false, 0, true);
                        o.buttonMode = true;
                        o.y = (_local6 * 20);
                        _local6++;
                        if (this.fData.ul[_local7].sServer == "Offline")
                        {
                            o.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -100, -100, -100, 0);
                        };
                        _local7++;
                    };
                    _scr = this.tcnt.scr;
                    if (this.tcnt.cnt.height < this.tcnt.cntMask.height)
                    {
                        _scr.visible = false;
                    }
                    else
                    {
                        _cntMask = this.tcnt.cntMask;
                        _cnt = this.tcnt.cnt;
                        _scr.visible = true;
                        _scr.h.height = int(((_cntMask.height / _cnt.height) * _scr.b.height));
                        this.hRun = (_scr.b.height - _scr.h.height);
                        this.dRun = ((_cnt.height - _cntMask.height) + 5);
                        _scr.h.y = 0;
                        _cnt.oy = (_cnt.y = _scr.y);
                        _scr.visible = false;
                        _scr.hit.alpha = 0;
                        this.mDown = false;
                        if (_cnt.height > _scr.b.height)
                        {
                            _scr.visible = true;
                            _scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                            _scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                            _cnt.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
                        };
                    };
                    this.tcnt.cnt.iproto.visible = false;
                    break;
                case "userListIgnore":
                    listB1 = (addChild(new mcUListB()) as mcUListB);
                    listB1.name = "cnt";
                    listB1.y = ((this.t1.y + this.t1.height) + 4);
                    listB1.mask = this.cntMask;
                    listB1.scr.buttonMode = true;
                    this.t1.txtTitle.text = "Ignore List";
                    this.t1.txtSubTitle.text = "";
                    _local6 = 0;
                    this.tcnt = MovieClip(getChildByName("cnt"));
                    this.fData.ul = [];
                    for each (_local8 in this.rootClass.chatF.ignoreList.data.users)
                    {
                        this.fData.ul.push({"sName":_local8});
                    };
                    _local7 = 0;
                    while (_local7 < this.fData.ul.length)
                    {
                        o = this.tcnt.cnt.addChild(new mcUListBItem());
                        o.txtName.text = this.fData.ul[_local7].sName;
                        o.addEventListener(MouseEvent.CLICK, this.uNameClick, false, 0, true);
                        o.buttonMode = true;
                        o.y = (_local6 * 20);
                        _local6++;
                        _local7++;
                    };
                    _scr = this.tcnt.scr;
                    if (this.tcnt.cnt.height < this.tcnt.cntMask.height)
                    {
                        _scr.visible = false;
                    }
                    else
                    {
                        _cntMask = this.tcnt.cntMask;
                        _cnt = this.tcnt.cnt;
                        _scr.visible = true;
                        _scr.h.height = int(((_cntMask.height / _cnt.height) * _scr.b.height));
                        this.hRun = (_scr.b.height - _scr.h.height);
                        this.dRun = ((_cnt.height - _cntMask.height) + 5);
                        _scr.h.y = 0;
                        _cnt.oy = (_cnt.y = _scr.y);
                        _scr.visible = false;
                        _scr.hit.alpha = 0;
                        this.mDown = false;
                        if (_cnt.height > _scr.b.height)
                        {
                            _scr.visible = true;
                            _scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                            _scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                            _cnt.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
                        };
                    };
                    this.tcnt.cnt.iproto.visible = false;
                    break;
            };
            this.bg.btnClose.addEventListener(MouseEvent.CLICK, this.closeClick, false, 0, true);
        }

        private function clearCnt():void
        {
            var _local1:* = getChildByName("cnt");
            if (_local1 != null)
            {
                removeChild(_local1);
            };
        }

        private function closeClick(_arg1:MouseEvent):void
        {
            this.fClose();
        }

        private function uNameClick(mouseEvent:MouseEvent):void
        {
            var target:MovieClip = MovieClip(mouseEvent.currentTarget);
            var obj:Object = {};
            if (("ID" in target))
            {
                obj.ID = target.ID;
            };
            obj.strUsername = target.txtName.text;
            if (((this.fData.typ == "userListFriends") && (!(target.txtMeta.text == this.rootClass.objServerInfo.Name))))
            {
                this.rootClass.ui.cMenu.fOpenWith("offline", obj);
            }
            else
            {
                if (((this.fData.typ == "userListFriends") && (target.txtMeta.text == this.rootClass.objServerInfo.Name)))
                {
                    this.rootClass.ui.cMenu.fOpenWith("friend", obj);
                }
                else
                {
                    if (this.fData.typ == "userListIgnore")
                    {
                        this.rootClass.ui.cMenu.fOpenWith("ignored", obj);
                    }
                    else
                    {
                        this.rootClass.ui.cMenu.fOpenWith("user", obj);
                    };
                };
            };
        }

        private function scrUp(_arg1:MouseEvent):void
        {
            this.mDown = false;
            this.rootClass.stage.removeEventListener(MouseEvent.MOUSE_UP, this.scrUp);
        }

        private function scrDown(_arg1:MouseEvent):void
        {
            this.mbY = int(mouseY);
            this.mhY = int(this.tcnt.scr.h.y);
            this.mDown = true;
            this.rootClass.stage.addEventListener(MouseEvent.MOUSE_UP, this.scrUp);
        }

        private function hEF(_arg1:Event):void
        {
            var _scr:MovieClip;
            if (this.mDown)
            {
                _scr = this.tcnt.scr;
                this.mbD = (int(mouseY) - this.mbY);
                _scr.h.y = (this.mhY + this.mbD);
                if ((_scr.h.y + _scr.h.height) > _scr.b.height)
                {
                    _scr.h.y = int((_scr.b.height - _scr.h.height));
                };
                if (_scr.h.y < 0)
                {
                    _scr.h.y = 0;
                };
            };
        }

        private function dEF(_arg1:Event):void
        {
            var _scr:MovieClip = this.tcnt.scr;
            var _local3:* = MovieClip(_arg1.currentTarget);
            var _local4:* = (-(_scr.h.y) / this.hRun);
            var _local5:* = (int((_local4 * this.dRun)) + _local3.oy);
            if (Math.abs((_local5 - _local3.y)) > 0.2)
            {
                _local3.y = (_local3.y + ((_local5 - _local3.y) >> 2));
            }
            else
            {
                _local3.y = _local5;
            };
        }

        private function frame1():void
        {
            stop();
        }

        private function frame6():void
        {
            this.bg.btnWiki.visible = false;
            this.bg.btnPin.visible = false;
            this.update();
        }

        private function frame10():void
        {
            stop();
        }


    }
}//package 

