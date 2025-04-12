// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameSimpleList

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import Main.Model.Item;
    import flash.display.DisplayObject;
    import Main.Model.*;

    public class LPFFrameSimpleList extends LPFFrame 
    {

        public var bg:MovieClip;
        public var iList:MovieClip;
        public var ti:TextField;
        public var mcScroll:MovieClip;
        public var mcMask:MovieClip;
        private var r:Object;

        public function LPFFrameSimpleList():void
        {
            x = 0;
            y = 0;
            fData = null;
        }

        override public function fOpen(_arg1:Object):void
        {
            if (_arg1.fData != undefined)
            {
                fData = _arg1.fData;
            };
            this.r = _arg1.r;
            w = int(this.r.w);
            this.ti.autoSize = "left";
            if (_arg1.eventTypes != undefined)
            {
                eventTypes = _arg1.eventTypes;
            };
            if (((!(fData.msg == undefined)) && (fData.msg.length > 0)))
            {
                this.ti.htmlText = fData.msg;
            };
            this.fDraw();
            positionBy(this.r);
            getLayout().registerForEvents(this, eventTypes);
        }

        override public function fClose():void
        {
            fData = null;
            getLayout().unregisterFrame(this);
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        override public function notify(_arg1:Object):void
        {
            switch (_arg1.eventType)
            {
                case "listItemASel":
                    fData = (((!(_arg1.fData == null)) && (!(_arg1.fData.oSel == null))) ? _arg1.fData.oSel : null);
                    this.fDraw();
                    positionBy(this.r);
                    break;
                case "refreshItems":
                    this.fDraw();
                    positionBy(this.r);
                    break;
            };
        }

        private function fDraw():void
        {
            var i:int;
            var turn:Item;
            var lpfElementSimpleItem:LPFElementSimpleItem;
            var lpfElementSimpleItemPreviously:DisplayObject;
            while (this.iList.numChildren > 0)
            {
                this.iList.removeChildAt(0);
            };
            if (!(fData is Item))
            {
                visible = false;
                return;
            };
            var item:Item = Item(fData);
            this.iList.y = 0;
            this.mcMask.y = 0;
            if (item.turnin.length > 0)
            {
                i = 0;
                for each (turn in item.turnin)
                {
                    lpfElementSimpleItem = LPFElementSimpleItem(this.iList.addChild(new LPFElementSimpleItem()));
                    lpfElementSimpleItem.fOpen(turn);
                    if (i > 0)
                    {
                        lpfElementSimpleItemPreviously = this.iList.getChildAt((i - 1));
                        lpfElementSimpleItem.y = ((lpfElementSimpleItemPreviously.y + lpfElementSimpleItemPreviously.height) + 4);
                    };
                    lpfElementSimpleItem.x = int(((w >> 1) - (lpfElementSimpleItem.width >> 1)));
                    i++;
                };
                this.bg.height = (int((this.iList.height + (this.iList.y << 1))) + 1);
                this.bg.width = int(w);
                this.ti.width = int((w - 2));
                if (this.ti.htmlText.length > 0)
                {
                    this.ti.y = (this.bg.height + 2);
                    this.ti.visible = true;
                }
                else
                {
                    this.ti.visible = false;
                };
                visible = true;
            }
            else
            {
                visible = false;
            };
            if (this.bg.height >= this.mcMask.height)
            {
                this.bg.height = this.mcMask.height;
            };
            if (item.turnin.length >= 3)
            {
                Game.configureScroll(this.iList, this.mcMask, this.mcScroll, this.bg.height);
                this.mcScroll.x = ((this.bg.width - this.mcScroll.width) - 5);
            }
            else
            {
                this.mcMask.visible = false;
                this.mcScroll.visible = false;
            };
        }


    }
}//package Main.Aqw.LPF

