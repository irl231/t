// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Apop

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import Main.Avatar.*;

    public class Apop extends MovieClip 
    {

        public var npc:MovieClip;
        public var btnClose:MovieClip;
        public var cnt:MovieClip;
        public var rootClass:Game = Game.root;
        public var o:Object = null;
        public var objSettings:Object = null;
        public var nMask:MovieClip;
        public var placement:MovieClip;
        private var mc:MovieClip;

        public function Apop():void
        {
            addFrameScript(5, this.frame6);
            this.mc = MovieClip(this);
            this.mc.btnClose.addEventListener(MouseEvent.CLICK, this.xClick, false, 0, true);
        }

        public function update(_arg1:Object, data:Object):void
        {
            var _npcLinkage:String;
            var cls:Class;
            var npcRight:MovieClip;
            var npcLeft:MovieClip;
            var avatarMC:AvatarMC;
            var _local10:Class;
            var _local11:*;
            var _local12:MovieClip;
            var _local13:Boolean;
            var _local14:int;
            this.o = _arg1;
            this.objSettings = data;
            _npcLinkage = "none";
            var _npcEntry:String = "none";
            var _scene:String = "none";
            var _cnt:String = "none";
            var _frmae:String = "none";
            if (("npcLinkage" in this.o))
            {
                _npcLinkage = this.o.npcLinkage;
            };
            if (("npcEntry" in this.o))
            {
                _npcEntry = this.o.npcEntry;
            };
            if (("cnt" in this.o))
            {
                _cnt = this.o.cnt;
            };
            if (("scene" in this.o))
            {
                _scene = this.o.scene;
            };
            if (("frame" in this.o))
            {
                _frmae = this.o.frame;
            };
            if (_npcLinkage != "none")
            {
                cls = (this.rootClass.world.getClass(_npcLinkage) as Class);
                if (cls != null)
                {
                    if (_npcEntry == "right")
                    {
                        npcRight = this.mc.npc.npcRight;
                        npcLeft = this.mc.npc.npcLeft;
                        if (npcLeft.currentLabel != "init")
                        {
                            npcLeft.gotoAndPlay("slide-out");
                        }
                        else
                        {
                            npcLeft.visible = false;
                        };
                    }
                    else
                    {
                        npcRight = this.mc.npc.npcLeft;
                        npcLeft = this.mc.npc.npcRight;
                        if (npcLeft.currentLabel != "init")
                        {
                            npcLeft.gotoAndPlay("slide-out");
                        }
                        else
                        {
                            npcLeft.visible = false;
                        };
                    };
                    npcRight.visible = true;
                    npcRight.npc.removeChildAt(0);
                    if (_npcLinkage == "AvatarMC")
                    {
                        avatarMC = AvatarUtil.createAvatar("npc_apop", npcRight.npc, data);
                        avatarMC.scale(5);
                        avatarMC.x = -100;
                        avatarMC.y = ((this.npc.height >> 1) - 100);
                        if (avatarMC.pAV.objData.eqp.en != null)
                        {
                            avatarMC.scaleX = (avatarMC.scaleY = 2.85);
                        };
                        avatarMC.disableAnimations();
                    }
                    else
                    {
                        npcRight.npc.addChild(new (cls)());
                    };
                    if (npcRight.currentLabel != "init")
                    {
                        npcRight.gotoAndPlay("slide-hook");
                    }
                    else
                    {
                        npcRight.gotoAndPlay("slide-in");
                    };
                }
                else
                {
                    this.mc.npc.npcRight.visible = false;
                    this.mc.npc.npcLeft.visible = false;
                };
            };
            if (_cnt != "none")
            {
                _local10 = (this.rootClass.world.getClass(_cnt) as Class);
                if (_local10 != null)
                {
                    this.mc.cnt.removeChildAt(0);
                    _local11 = ((_cnt == "Plugins.ConfigurableNPC.CoreAPOP") ? this.mc.cnt.addChild(new _local10(data, this.rootClass)) : this.mc.cnt.addChild(new (_local10)()));
                    _local11.name = "cnt";
                    if (_scene != "none")
                    {
                        if (this.rootClass.checkForFrame(_local11, _scene))
                        {
                            _local11.gotoAndPlay(_scene);
                        };
                    };
                };
            };
            if (_frmae != "none")
            {
                _local12 = MovieClip(this.mc.cnt.getChildByName("cnt"));
                _local13 = false;
                _local14 = 0;
                while (_local14 < _local12.currentLabels.length)
                {
                    if (_local12.currentLabels[_local14].name == _frmae)
                    {
                        _local13 = true;
                    };
                    _local14++;
                };
                if (_local13)
                {
                    _local12.gotoAndPlay(_frmae);
                }
                else
                {
                    this.rootClass.addUpdate((("Label " + _frmae) + " not found!"));
                };
            };
            if (this.mc.currentLabel == "init")
            {
                this.mc.gotoAndPlay("in");
            };
        }

        public function updateWithClasses(_arg1:Object, _arg2:Class, _arg3:Class):void
        {
            var _local7:MovieClip;
            var _local8:MovieClip;
            var _local9:*;
            var _local10:MovieClip;
            var _local11:Boolean;
            var _local12:int;
            this.rootClass = Game(MovieClip(this.stage.getChildAt(0)));
            this.o = _arg1;
            var _local4:String = "none";
            var _local5:String = "none";
            var _local6:String = "none";
            if (("npcEntry" in this.o))
            {
                _local4 = this.o.npcEntry;
            };
            if (("scene" in this.o))
            {
                _local5 = this.o.scene;
            };
            if (("frame" in this.o))
            {
                _local6 = this.o.frame;
            };
            if (_arg2 != null)
            {
                if (_local4 == "right")
                {
                    _local7 = this.mc.npc.npcRight;
                    _local8 = this.mc.npc.npcLeft;
                    if (_local8.currentLabel != "init")
                    {
                        _local8.gotoAndPlay("slide-out");
                    }
                    else
                    {
                        _local8.visible = false;
                    };
                }
                else
                {
                    _local7 = this.mc.npc.npcLeft;
                    _local8 = this.mc.npc.npcRight;
                    if (_local8.currentLabel != "init")
                    {
                        _local8.gotoAndPlay("slide-out");
                    }
                    else
                    {
                        _local8.visible = false;
                    };
                };
                _local7.visible = true;
                _local7.npc.removeChildAt(0);
                _local7.npc.addChild(new (_arg2)());
                if (_local7.currentLabel != "init")
                {
                    _local7.gotoAndPlay("slide-hook");
                }
                else
                {
                    _local7.gotoAndPlay("slide-in");
                };
            }
            else
            {
                this.mc.npc.npcRight.visible = false;
                this.mc.npc.npcLeft.visible = false;
            };
            if (_arg3 != null)
            {
                this.mc.cnt.removeChildAt(0);
                _local9 = this.mc.cnt.addChild(new (_arg3)());
                _local9.name = "cnt";
                if (_local5 != "none")
                {
                    _local9.gotoAndPlay(_local5);
                };
            };
            if (_local6 != "none")
            {
                _local10 = MovieClip(this.mc.cnt.getChildByName("cnt"));
                _local11 = false;
                _local12 = 0;
                while (_local12 < _local10.currentLabels.length)
                {
                    if (_local10.currentLabels[_local12].name == _local6)
                    {
                        _local11 = true;
                    };
                    _local12++;
                };
                if (_local11)
                {
                    _local10.gotoAndPlay(_local6);
                }
                else
                {
                    this.rootClass.addUpdate((("Label " + _local6) + " not found!"));
                };
            };
            if (this.mc.currentLabel == "init")
            {
                this.mc.gotoAndPlay("in");
            };
        }

        public function fClose():void
        {
            if (this.o.cnt == "Plugins.ConfigurableNPC.CoreAPOP")
            {
                this.rootClass.world.closeAPOP(this.objSettings.NpcMapID);
            };
            var _local1:MovieClip = MovieClip(this.mc.cnt.getChildByName("cnt"));
            _local1.soundTransform = new SoundTransform(0);
            _local1.stop();
            this.mc.btnClose.removeEventListener(MouseEvent.CLICK, this.xClick);
            this.mc.parent.removeChild(this);
        }

        public function exit():void
        {
            this.fClose();
        }

        private function frame6():void
        {
            stop();
        }

        private function xClick(_arg1:MouseEvent):void
        {
            this.fClose();
        }


    }
}//package 

