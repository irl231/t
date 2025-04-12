// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.WorldBoss.WorldBossInvite

package Main.WorldBoss
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.events.*;
    import flash.utils.*;
    import Main.Controller.*;

    public class WorldBossInvite extends Sprite 
    {

        public var mcHead:MovieClip;
        public var btnJoin:SimpleButton;
        public var btnClose:SimpleButton;
        public var strTimeLeft:TextField;
        public var strLevel:TextField;
        public var strName:TextField;
        private var worldBossTimer:Timer;
        private var _bossID:int;

        public function WorldBossInvite()
        {
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onDraggableMouseDown, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onDraggableMouseUP, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.MOUSE_DOWN, this.onClose, false, 0, true);
            this.btnJoin.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseEventClick, false, 0, true);
            this.strTimeLeft.mouseEnabled = false;
            this.strLevel.mouseEnabled = false;
            this.strName.mouseEnabled = false;
            this.mcHead.backhair.visible = false;
        }

        public function set bossID(value:int):void
        {
            this._bossID = value;
        }

        public function setTimer(seconds:int):void
        {
            this.worldBossTimer = new Timer(1000, seconds);
            this.worldBossTimer.addEventListener(TimerEvent.TIMER, this.startWorldBossTime, false, 0, true);
            this.worldBossTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onWorldBossTimeOut, false, 0, true);
            this.worldBossTimer.start();
        }

        private function onDraggableMouseDown(event:MouseEvent):void
        {
            this.startDrag();
        }

        private function onDraggableMouseUP(event:MouseEvent):void
        {
            this.stopDrag();
        }

        private function onMouseEventClick(event:MouseEvent):void
        {
            Game.root.network.send("joinWorldBoss", [this._bossID]);
            this.onClose();
        }

        private function startWorldBossTime(event:TimerEvent):void
        {
            this.strTimeLeft.text = String((this.worldBossTimer.repeatCount - this.worldBossTimer.currentCount));
        }

        private function onWorldBossTimeOut(event:TimerEvent):void
        {
            this.onClose();
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            UIController.close("boss_invite");
            LoadController.singleton.clearLoader("boss_invite_junk");
        }


    }
}//package Main.WorldBoss

