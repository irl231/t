// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//PVPPanelMC

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import Game_fla.mcPopup_323;
    import flash.events.MouseEvent;
    import Game_fla.mcPVPPanel_481;
    import Main.Aqw.PvPMap;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class PVPPanelMC extends MovieClip 
    {

        public var btnClose:SimpleButton;
        public var cnt:MovieClip;
        private var world:World;
        private var mcPopup:mcPopup_323;
        private var nextMode:String;
        private var itemSel:MovieClip;
        private var pending:Boolean = false;

        public function PVPPanelMC():void
        {
            var rootClass:Game = Game.root;
            this.world = rootClass.world;
            this.mcPopup = rootClass.ui.mcPopup;
            super();
            addFrameScript(0, this.frame1, 4, this.frame5, 11, this.frame12, 24, this.frame25, 30, this.frame31, 36, this.frame37, 49, this.frame50);
            this.btnClose.addEventListener(MouseEvent.MOUSE_DOWN, this.btnCloseClick, false, 0, true);
        }

        private static function onMapItemOut(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.currentTarget.parent as MovieClip);
            if (((_local2.iHi) && (!(_local2.iSel))))
            {
                _local2.iHi = false;
                _local2.gotoAndPlay("out1");
            };
        }


        public function openWith(_arg1:Object):void
        {
            this.nextMode = _arg1.typ;
            if (this.isValidMode(this.nextMode))
            {
                if (((!(this.currentLabel == "init")) && (this.currentLabel.indexOf("-out") < 0)))
                {
                    this.gotoAndPlay((this.currentLabel + "-out"));
                }
                else
                {
                    this.gotoAndPlay(this.nextMode);
                };
            };
        }

        public function fClose():void
        {
            this.killCurrentListeners();
        }

        public function updateBody():void
        {
            var body:mcPVPPanel_481 = this.cnt.body;
            if (this.pending)
            {
                this.pending = false;
            };
            if (this.itemSel.warzone != this.world.PVPQueue.warzone)
            {
                body.bJoin.visible = true;
                if (body.msg != null)
                {
                    body.msg.visible = false;
                };
                body.bExit.visible = false;
            }
            else
            {
                body.bJoin.visible = false;
                if (body.msg != null)
                {
                    body.msg.visible = false;
                };
                body.bExit.visible = true;
            };
        }

        private function playNextMode():void
        {
            this.killCurrentListeners();
            this.gotoAndPlay(this.nextMode);
        }

        private function isValidMode(_arg1:String):Boolean
        {
            var _local2:Boolean;
            var _local3:int;
            while (((_local3 < this.currentLabels.length) && (!(_local2))))
            {
                if (this.currentLabels[_local3].name == _arg1)
                {
                    _local2 = true;
                };
                _local3++;
            };
            return (_local2);
        }

        private function update():void
        {
            if (currentLabel == "maps")
            {
                this.updateMaps();
            };
            if (currentLabel == "results")
            {
                this.updateResults();
            };
        }

        private function updateMaps():void
        {
            var map:PvPMap;
            var body:mcPVPPanel_481;
            var proto:pvpProto;
            while (this.cnt.iList.numChildren > 1)
            {
                this.cnt.iList.removeChildAt(1);
            };
            var _local3:int;
            for each (map in this.world.PVPMaps)
            {
                if (!map.hidden)
                {
                    proto = this.cnt.iList.addChild(new pvpProto());
                    proto.t1.ti.text = map.nam;
                    proto.t2.ti.text = map.desc;
                    proto.icon.gotoAndStop(map.icon);
                    proto.y = (_local3 * 40);
                    proto.iSel = false;
                    proto.iHi = false;
                    proto.label = map.label;
                    proto.warzone = map.warzone;
                    proto.hit.alpha = 0;
                    proto.hit.buttonMode = true;
                    proto.hit.addEventListener(MouseEvent.CLICK, this.onMapItemClick, false, 0, true);
                    proto.hit.addEventListener(MouseEvent.MOUSE_OVER, this.onMapItemOver, false, 0, true);
                    proto.hit.addEventListener(MouseEvent.MOUSE_OUT, onMapItemOut, false, 0, true);
                    proto.width = 235;
                    proto.height = 36.6;
                    _local3++;
                };
            };
            this.cnt.iList.iproto.visible = false;
            body = this.cnt.body;
            body.bJoin.addEventListener(MouseEvent.MOUSE_DOWN, this.btnJoinClick, false, 0, true);
            body.bExit.addEventListener(MouseEvent.MOUSE_DOWN, this.btnExitClick, false, 0, true);
            body.bJoin.visible = false;
            body.bExit.visible = false;
            body.msg.visible = false;
            body.gotoAndStop("init");
        }

        private function updateResults():void
        {
            var _local1:Object = this.world.PVPResults;
            var _local2:int = _local1.team;
            if (_local2 == this.world.myAvatar.dataLeaf.pvpTeam)
            {
                this.cnt.outlineV.visible = true;
                this.cnt.outlineL.visible = false;
            }
            else
            {
                this.cnt.outlineV.visible = false;
                this.cnt.outlineL.visible = true;
            };
            if (this.world.PVPFactions.length == 0)
            {
                this.cnt.ti.text = (("Team " + ["A", "B"][_local2]) + " won!");
                this.world.rootClass.mixer.playSound("GuildWarWin");
            }
            else
            {
                this.cnt.ti.text = (("The " + this.world.PVPFactions[_local2].sName) + " won!");
                this.world.rootClass.mixer.playSound("GuildWarWin");
            };
            this.cnt.btnBack.addEventListener(MouseEvent.CLICK, this.btnBackClick, false, 0, true);
        }

        private function killCurrentListeners():void
        {
            var body:mcPVPPanel_481;
            if (this.currentLabel == "maps")
            {
                body = this.cnt.body;
                body.bJoin.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnJoinClick);
                body.bExit.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnExitClick);
            };
            if (this.currentLabel == "results")
            {
                this.cnt.btnBack.removeEventListener(MouseEvent.CLICK, this.btnBackClick);
            };
            this.btnClose.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnCloseClick);
        }

        private function onMapItemClick(_arg1:MouseEvent):void
        {
            var proto:pvpProto;
            var _local2:pvpProto = _arg1.currentTarget.parent;
            _local2.iHi = false;
            if (!_local2.iSel)
            {
                this.itemSel = _local2;
                _local2.iSel = true;
                _local2.gotoAndPlay("in2");
            };
            var i:uint;
            while (i < this.cnt.iList.numChildren)
            {
                proto = this.cnt.iList.getChildAt(i);
                if (proto != _local2)
                {
                    if (proto.iSel)
                    {
                        proto.gotoAndPlay("out2");
                    };
                    if (proto.iHi)
                    {
                        proto.gotoAndPlay("out1");
                    };
                    proto.iSel = false;
                    proto.iHi = false;
                };
                i++;
            };
            var body:mcPVPPanel_481 = this.cnt.body;
            body.gotoAndStop(_local2.label);
            body.title.text = _local2.t1.ti.text;
        }

        private function onMapItemOver(_arg1:MouseEvent):void
        {
            var _local3:MovieClip;
            var _local2:MovieClip = (_arg1.currentTarget.parent as MovieClip);
            if (((!(_local2.iHi)) && (!(_local2.iSel))))
            {
                _local2.iHi = true;
                _local2.gotoAndPlay("in1");
            };
            var i:uint;
            while (i < this.cnt.iList.numChildren)
            {
                _local3 = (this.cnt.iList.getChildAt(i) as MovieClip);
                if (_local3 != _local2)
                {
                    if (((_local3.iHi) && (!(_local3.iSel))))
                    {
                        _local3.gotoAndPlay("out1");
                    };
                    _local3.iHi = false;
                };
                i++;
            };
        }

        private function btnCloseClick(_arg1:MouseEvent=null):void
        {
            this.mcPopup.onClose();
        }

        private function btnJoinClick(_arg1:MouseEvent):void
        {
            if (!this.pending)
            {
                this.pending = true;
                this.world.requestPVPQueue(this.itemSel.warzone);
            };
        }

        private function btnExitClick(_arg1:MouseEvent):void
        {
            if (!this.pending)
            {
                this.pending = true;
                this.world.requestPVPQueue("none");
            };
        }

        private function btnBackClick(_arg1:MouseEvent):void
        {
            if (Game.root.world.myAvatar.dataLeaf.intState == 0)
            {
                Game.root.chatF.pushMsg("warning", "You are dead!", "SERVER", "", 0);
                return;
            };
            this.world.gotoTown(Config.getString("join_town"), "Enter", "Spawn");
            this.mcPopup.onClose();
        }

        private function frame1():void
        {
            this.openWith(MovieClip(parent).fData);
        }

        private function frame5():void
        {
            this.update();
        }

        private function frame12():void
        {
            stop();
        }

        private function frame25():void
        {
            this.playNextMode();
        }

        private function frame31():void
        {
            this.update();
        }

        private function frame37():void
        {
            stop();
        }

        private function frame50():void
        {
            this.playNextMode();
        }


    }
}//package 

