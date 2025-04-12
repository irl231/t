// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FactionsMC

package 
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import Main.*;

    public class FactionsMC extends MovieClip 
    {

        public var factions:Array = [];
        public var cnt:MovieClip;
        public var hRun:int = 0;
        public var dRun:int = 0;
        public var mbY:int = 0;
        public var mhY:int = 0;
        public var mbD:int = 0;
        private var isOpen:Boolean = false;
        private var mDown:Boolean = false;

        public function FactionsMC():void
        {
            addFrameScript(0, this.frame1, 6, this.frame7, 11, this.frame12, 15, this.frame16);
            this.cnt.bg.btnClose.addEventListener(MouseEvent.CLICK, this.xClick);
        }

        private static function onLibraryClick(event:Event):void
        {
            navigateToURL(new URLRequest((Config.serverWikiFactionURL + event.currentTarget.FactionID)), "_blank");
        }

        private static function iMouseOver(mouseEvent:MouseEvent):void
        {
            var movieClip:MovieClip;
            movieClip = MovieClip(mouseEvent.currentTarget.parent.mHi);
            movieClip.visible = true;
            movieClip.y = MovieClip(mouseEvent.currentTarget).y;
        }

        private static function iMouseOut(mouseEvent:MouseEvent):void
        {
            mouseEvent.currentTarget.parent.mHi.visible = false;
        }


        public function open():void
        {
            this.factions = Game.root.world.myAvatar.factions;
            if (!this.isOpen)
            {
                this.isOpen = true;
                this.cnt.gotoAndPlay("intro");
            }
            else
            {
                this.isOpen = false;
                this.fClose();
            };
        }

        public function showFactionList():void
        {
            if (this.factions.length > 0)
            {
                this.buildFactionList();
            }
            else
            {
                this.showEmptyList();
            };
            this.cnt.fList.visible = true;
            this.cnt.fList.mHi.visible = false;
            this.cnt.mouseChildren = true;
        }

        public function fClose():void
        {
            this.cnt.bg.btnClose.removeEventListener(MouseEvent.CLICK, this.xClick);
            Game.root.ui.mcPopup.onClose();
        }

        private function frame1():void
        {
            this.open();
        }

        private function frame7():void
        {
            stop();
        }

        private function frame12():void
        {
        }

        private function frame16():void
        {
            this.fClose();
        }

        private function buildFactionList():void
        {
            var faction:*;
            var proto:fProto;
            var factionButton:LibraryButton;
            var factionLength:int = this.factions.length;
            var i:int;
            while (i < factionLength)
            {
                faction = this.factions[i];
                if (faction != null)
                {
                    proto = fProto(this.cnt.fList.addChild(new fProto()));
                    proto.t1.htmlText = faction.sName;
                    proto.t1.x = 18;
                    proto.tRank.htmlText = ("Rank " + faction.iRank);
                    proto.t2.htmlText = ((faction.iRank >= 10) ? "0<font color='#FF0000'>/</font>0" : ((faction.iRep + " <font color='#FF0000'>/</font> ") + Rank.getPointsFromRank((faction.iRank + 1))));
                    factionButton = LibraryButton(proto.addChild(new LibraryButton()));
                    factionButton.FactionID = faction.FactionID;
                    factionButton.scaleX = (factionButton.scaleY = 0.7);
                    factionButton.y = 2.5;
                    factionButton.addEventListener(MouseEvent.CLICK, onLibraryClick);
                    proto.addEventListener(MouseEvent.MOUSE_OVER, iMouseOver, false, 0, true);
                    proto.addEventListener(MouseEvent.MOUSE_OUT, iMouseOut, false, 0, true);
                    proto.hit.alpha = 0;
                    proto.y = (i * 20);
                    proto.x = 10;
                };
                i++;
            };
            this.cnt.scr.h.height = int(((this.cnt.scr.b.height / this.cnt.fList.height) * this.cnt.scr.b.height));
            this.hRun = (this.cnt.scr.b.height - this.cnt.scr.h.height);
            this.dRun = ((this.cnt.fList.height - this.cnt.scr.b.height) + 20);
            this.cnt.scr.h.y = 0;
            this.cnt.fList.oy = (this.cnt.fList.y = 57);
            this.cnt.scr.visible = false;
            this.cnt.scr.hit.alpha = 0;
            this.mDown = false;
            if (this.cnt.fList.height > this.cnt.scr.b.height)
            {
                this.cnt.scr.visible = true;
                this.cnt.scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                this.cnt.scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                this.cnt.fList.addEventListener(Event.ENTER_FRAME, MainController.dEF, false, 0, true);
            };
            this.cnt.scr.hit.buttonMode = true;
            this.cnt.fList.iproto.visible = false;
        }

        private function showEmptyList():void
        {
            var proto:fProto = fProto(this.cnt.fList.addChild(new fProto()));
            proto.t1.htmlText = '<font color="#DDDDDD">No Factions!</font>';
            proto.t2.visible = false;
            proto.tRank.visible = false;
            proto.hit.alpha = 0;
            proto.x = 10;
            this.cnt.fList.iproto.visible = false;
            this.cnt.scr.visible = false;
        }

        public function xClick(_arg1:MouseEvent=null):void
        {
            this.gotoAndPlay("outro");
        }

        private function scrDown(_arg1:MouseEvent):void
        {
            this.mbY = int(mouseY);
            this.mhY = int(MovieClip(_arg1.currentTarget.parent).h.y);
            this.mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.scrUp);
        }

        private function scrUp(_arg1:MouseEvent):void
        {
            this.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.scrUp);
        }

        private function hEF(_arg1:Event):void
        {
            var _local2:*;
            if (this.mDown)
            {
                _local2 = MovieClip(_arg1.currentTarget.parent);
                this.mbD = (int(mouseY) - this.mbY);
                _local2.h.y = (this.mhY + this.mbD);
                if ((_local2.h.y + _local2.h.height) > _local2.b.height)
                {
                    _local2.h.y = int((_local2.b.height - _local2.h.height));
                };
                if (_local2.h.y < 0)
                {
                    _local2.h.y = 0;
                };
            };
        }


    }
}//package 

