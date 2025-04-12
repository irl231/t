// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//QTrackerMC

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;

    public class QTrackerMC extends MovieClip 
    {

        public var bMask:MovieClip;
        public var bg:MovieClip;
        public var scr:MovieClip;
        public var close:SimpleButton;
        public var txtDetail:TextField;
        public var rootClass:Game;
        internal var mDown:Boolean = false;
        internal var mbY:*;
        internal var mhY:*;
        internal var drag:Object;

        public function QTrackerMC():void
        {
            this.rootClass = Game.root;
            this.drag = {};
            super();
            addFrameScript(0, this.frame1);
            visible = false;
        }

        private function isOneTimeQuestDone(quest:Object):Boolean
        {
            return ((quest.bOnce == 1) && ((quest.iSlot < 0) || (this.rootClass.world.getQuestValue(quest.iSlot) >= quest.iValue)));
        }

        public function updateQuest():void
        {
            var questTreeKey:String;
            var quest:Object;
            var detail:String;
            var ii:int;
            var item:Object;
            this.txtDetail.htmlText = "";
            var i:int;
            for (questTreeKey in this.rootClass.world.questTree)
            {
                quest = this.rootClass.world.questTree[questTreeKey];
                if (((!(quest.status == null)) && (!(this.isOneTimeQuestDone(quest)))))
                {
                    this.txtDetail.htmlText = (this.txtDetail.htmlText + (("<font color='#00CC00'><b>" + quest.sName) + "</b></font>"));
                    if (((!(quest.turnin == null)) && (quest.turnin.length > 0)))
                    {
                        detail = "";
                        ii = 0;
                        while (ii < quest.turnin.length)
                        {
                            item = this.rootClass.world.invTree[quest.turnin[ii].ItemID];
                            if (ii > 0)
                            {
                                detail = (detail + ",<br>");
                            };
                            detail = (detail + ((((("    " + item.sName) + " ") + item.iQty) + "/") + quest.turnin[ii].iQty));
                            ii++;
                        };
                        this.txtDetail.htmlText = (this.txtDetail.htmlText + detail);
                    };
                    i++;
                };
            };
            if (i == 0)
            {
                this.txtDetail.htmlText = "You are not on any quest!";
            };
            this.close.x = ((this.txtDetail.x + this.txtDetail.textWidth) + 10);
            this.bg.width = (this.close.x + 20);
            var heightFinal:Number = ((this.txtDetail.y + this.txtDetail.textHeight) + 10);
            this.bg.height = ((heightFinal > 108) ? 108 : heightFinal);
            if (this.txtDetail.height > this.scr.height)
            {
                this.scr.visible = true;
                this.scr.x = (this.close.x + 5);
                this.scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
            }
            else
            {
                this.scr.visible = false;
            };
        }

        public function toggle():void
        {
            visible = (!(visible));
            if (visible)
            {
                this.updateQuest();
            };
        }

        private function frame1():void
        {
            this.initOpen();
            stop();
        }

        private function initOpen():void
        {
            this.scr.hit.alpha = 0;
            this.txtDetail.autoSize = "left";
            this.close.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMoveClick, false, 0, true);
        }

        public function onMoveClick(_arg1:MouseEvent):void
        {
            if (((!(_arg1.target == this.close)) && (!(_arg1.target == this.scr.hit))))
            {
                this.drag.ox = this.x;
                this.drag.oy = this.y;
                this.drag.mox = this.rootClass.stage.mouseX;
                this.drag.moy = this.rootClass.stage.mouseY;
                this.rootClass.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMoveRelease, false, 0, true);
                this.addEventListener(Event.ENTER_FRAME, this.onMoveEnterFrame, false, 0, true);
            };
        }

        public function onMoveRelease(_arg1:MouseEvent):void
        {
            this.rootClass.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMoveRelease);
            this.removeEventListener(Event.ENTER_FRAME, this.onMoveEnterFrame);
        }

        public function onMoveEnterFrame(_arg1:Event):void
        {
            this.x = (this.drag.ox + (this.rootClass.stage.mouseX - this.drag.mox));
            if (this.x < 0)
            {
                this.x = 0;
            };
            if ((this.x + this.bg.width) > 960)
            {
                this.x = (960 - this.bg.width);
            };
            this.y = (this.drag.oy + (this.rootClass.stage.mouseY - this.drag.moy));
            if (this.y < 0)
            {
                this.y = 0;
            };
            if ((this.y + this.bg.height) > 500)
            {
                this.y = (500 - this.bg.height);
            };
        }

        private function onCloseClick(_arg1:MouseEvent):void
        {
            visible = false;
        }

        private function onRollOver(_arg1:MouseEvent):void
        {
            this.bg.visible = true;
            this.scr.visible = (this.txtDetail.height > this.scr.height);
            this.close.visible = true;
        }

        private function scrDown(_arg1:MouseEvent):void
        {
            this.mDown = true;
            this.mbY = int(mouseY);
            this.mhY = int(MovieClip(_arg1.currentTarget.parent).h.y);
            this.rootClass.stage.addEventListener(MouseEvent.MOUSE_UP, this.scrUp, false, 0, true);
            this.scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
        }

        private function scrUp(_arg1:MouseEvent):void
        {
            this.mDown = false;
            this.rootClass.stage.removeEventListener(MouseEvent.MOUSE_UP, this.scrUp);
            this.scr.h.addEventListener(Event.ENTER_FRAME, this.hEF);
        }

        private function hEF(_arg1:Event):void
        {
            if (this.mDown)
            {
                this.scr.h.y = (this.mhY + (int(mouseY) - this.mbY));
                if ((this.scr.h.y + this.scr.h.height) > this.scr.b.height)
                {
                    this.scr.h.y = int((this.scr.b.height - this.scr.h.height));
                };
                if (this.scr.h.y < 0)
                {
                    this.scr.h.y = 0;
                };
                this.txtDetail.y = (int(((-(this.scr.h.y) / (this.scr.b.height - this.scr.h.height)) * (this.txtDetail.height - this.scr.b.height))) + 22);
            };
        }


    }
}//package 

