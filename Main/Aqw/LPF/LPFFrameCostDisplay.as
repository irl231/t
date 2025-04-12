// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameCostDisplay

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import Main.Model.Item;
    import flash.events.MouseEvent;
    import Main.Model.*;
    import flash.events.*;
    import Main.*;

    public class LPFFrameCostDisplay extends LPFFrame 
    {

        public var mcCoins:MovieClip;
        public var mcGold:MovieClip;
        public var bg:MovieClip;
        private var r:Object;

        public function LPFFrameCostDisplay():void
        {
            x = 0;
            y = 0;
            fData = {};
        }

        override public function fOpen(_arg1:Object):void
        {
            fData = _arg1.fData;
            if (_arg1.eventTypes != undefined)
            {
                eventTypes = _arg1.eventTypes;
            };
            if (_arg1.r != undefined)
            {
                this.r = _arg1.r;
            };
            this.fDraw();
            this.positionBy(this.r);
            getLayout().registerForEvents(this, eventTypes);
            this.mcCoins.addEventListener(MouseEvent.MOUSE_OVER, this.onCoinsTTOver, false, 0, true);
            this.mcCoins.addEventListener(MouseEvent.MOUSE_OUT, this.onTTOut, false, 0, true);
            this.mcGold.addEventListener(MouseEvent.MOUSE_OVER, this.onGoldTTOver, false, 0, true);
            this.mcGold.addEventListener(MouseEvent.MOUSE_OUT, this.onTTOut, false, 0, true);
            this.mcGold.hit.alpha = 0;
            this.mcCoins.hit.alpha = 0;
        }

        override public function fClose():void
        {
            this.mcCoins.removeEventListener(MouseEvent.MOUSE_OVER, this.onCoinsTTOver);
            this.mcCoins.removeEventListener(MouseEvent.MOUSE_OUT, this.onTTOut);
            this.mcGold.removeEventListener(MouseEvent.MOUSE_OVER, this.onGoldTTOver);
            this.mcGold.removeEventListener(MouseEvent.MOUSE_OUT, this.onTTOut);
            getLayout().unregisterFrame(this);
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        override protected function positionBy(r:Object):void
        {
            var _local2:int;
            if (this.mcGold.visible)
            {
                this.bg.width = (((this.mcGold.x + this.mcGold.ti.x) + this.mcGold.ti.textWidth) + 10);
                w = this.bg.width;
                _local2 = 1;
            }
            else
            {
                this.bg.width = (((this.mcCoins.x + this.mcCoins.ti.x) + this.mcCoins.ti.textWidth) + 10);
                w = this.bg.width;
            };
            if (((!(r == null)) && (!(r.xPosRule == undefined))))
            {
                if (r.xPosRule == "centerOnX")
                {
                    x = (int((r.x - (w >> 1))) + _local2);
                };
            }
            else
            {
                x = ((r.x > -1) ? r.x : (int(((fParent.w >> 1) - (w >> 1))) + _local2));
            };
            this.positionByFinal(r);
        }

        override public function notify(_arg1:Object):void
        {
            if (_arg1.eventType == "listItemASel")
            {
                if (((!(_arg1.fData == null)) && (!(_arg1.fData.oSel == null))))
                {
                    fData = _arg1.fData.oSel;
                };
                this.fDraw();
            };
        }

        private function fDraw():void
        {
            var item:Item;
            var cost:Number;
            var isShopSell:Boolean;
            var color:String;
            var lpfLayout:LPFLayout = getLayout();
            visible = false;
            if (((lpfLayout.sMode.indexOf("shop") > -1) && (!(fData == null))))
            {
                item = Item(fData);
                visible = true;
                this.mcGold.visible = false;
                this.mcCoins.visible = false;
                this.mcGold.x = 0;
                this.mcCoins.x = 0;
                this.mcGold.ti.text = "";
                this.mcCoins.ti.text = "";
                if (item.iCost > 0)
                {
                    cost = Number(item.iCost);
                    isShopSell = (lpfLayout.sMode == "shopSell");
                    color = "#FFFFFF";
                    if (item.bCoins)
                    {
                        if (isShopSell)
                        {
                            cost = item.cost;
                        }
                        else
                        {
                            if (cost > rootClass.world.myAvatar.objData.intCoins)
                            {
                                color = "#FF0000";
                            };
                        };
                        this.mcCoins.ti.htmlText = (((("<font color='" + color) + "'>") + MainController.formatNumber(cost)) + "</font>");
                        this.mcCoins.visible = true;
                    }
                    else
                    {
                        if (isShopSell)
                        {
                            cost = item.cost;
                        }
                        else
                        {
                            if (cost > rootClass.world.myAvatar.objData.intGold)
                            {
                                color = "#FF0000";
                            };
                        };
                        this.mcGold.ti.htmlText = (((("<font color='" + color) + "'>") + MainController.formatNumber(cost)) + "</font>");
                        this.mcGold.visible = true;
                    };
                    this.mcGold.hit.width = ((this.mcGold.ti.x + this.mcGold.ti.textWidth) + 2);
                    this.mcCoins.hit.width = ((this.mcCoins.ti.x + this.mcCoins.ti.textWidth) + 2);
                    visible = true;
                }
                else
                {
                    visible = false;
                };
            };
        }

        private function onCoinsTTOver(_arg1:MouseEvent):void
        {
            rootClass.ui.ToolTip.openWith({"str":Config.getString("coins_name")});
        }

        private function onGoldTTOver(_arg1:MouseEvent):void
        {
            rootClass.ui.ToolTip.openWith({"str":"Gold"});
        }

        private function onTTOut(_arg1:MouseEvent):void
        {
            rootClass.ui.ToolTip.close();
        }


    }
}//package Main.Aqw.LPF

