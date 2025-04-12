// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//BankFilter

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;

    public class BankFilter extends MovieClip 
    {

        public var rootClass:Game;
        public var btnFilter:MovieClip;
        public var chkLegend:MovieClip;
        public var chkRarity:MovieClip;
        public var chkGold:MovieClip;
        public var chkFree:MovieClip;
        public var chkAC:MovieClip;
        public var buyTicket:SimpleButton;

        public function BankFilter(mc:Game)
        {
            this.rootClass = mc;
            this.chkAC.checkmark.visible = false;
            this.chkGold.checkmark.visible = false;
            this.chkLegend.checkmark.visible = false;
            this.chkFree.checkmark.visible = false;
            this.chkRarity.checkmark.visible = false;
            this.chkAC.addEventListener(MouseEvent.CLICK, this.onChkChange, false, 0, true);
            this.chkGold.addEventListener(MouseEvent.CLICK, this.onChkChange, false, 0, true);
            this.chkLegend.addEventListener(MouseEvent.CLICK, this.onChkChange, false, 0, true);
            this.chkFree.addEventListener(MouseEvent.CLICK, this.onChkChange, false, 0, true);
            this.chkRarity.addEventListener(MouseEvent.CLICK, this.onChkChange, false, 0, true);
            this.btnFilter.addEventListener(MouseEvent.CLICK, this.onBtnFilter, false, 0, true);
            this.buyTicket.addEventListener(MouseEvent.CLICK, this.onBuyTicket, false, 0, true);
        }

        public function onFilter(bank:*, index:int, arr:Vector.<Item>):Boolean
        {
            var filter_result:Boolean;
            if (this.chkAC.checkmark.visible)
            {
                filter_result = (bank.bCoins == 1);
                if (this.chkLegend.checkmark.visible)
                {
                    filter_result = ((filter_result) && (bank.bUpg == 1));
                };
                if (this.chkFree.checkmark.visible)
                {
                    filter_result = ((filter_result) && (bank.bUpg == 0));
                };
            }
            else
            {
                if (this.chkGold.checkmark.visible)
                {
                    filter_result = (bank.bCoins == 0);
                    if (this.chkLegend.checkmark.visible)
                    {
                        filter_result = ((filter_result) && (bank.bUpg == 1));
                    };
                    if (this.chkFree.checkmark.visible)
                    {
                        filter_result = ((filter_result) && (bank.bUpg == 0));
                    };
                }
                else
                {
                    if (this.chkLegend.checkmark.visible)
                    {
                        filter_result = (bank.bUpg == 1);
                    };
                    if (this.chkFree.checkmark.visible)
                    {
                        filter_result = (bank.bUpg == 0);
                    };
                };
            };
            if (this.chkRarity.checkmark.visible)
            {
                filter_result = (bank.iRty == 30);
            };
            if ((((((!(this.chkAC.checkmark.visible)) && (!(this.chkGold.checkmark.visible))) && (!(this.chkLegend.checkmark.visible))) && (!(this.chkFree.checkmark.visible))) && (!(this.chkRarity.checkmark.visible))))
            {
                filter_result = true;
            };
            return (filter_result);
        }

        public function onChkChange(e:MouseEvent):void
        {
            e.currentTarget.checkmark.visible = (!(e.currentTarget.checkmark.visible));
            switch (e.currentTarget.name)
            {
                case "chkAC":
                    if (e.currentTarget.checkmark.visible)
                    {
                        this.chkGold.checkmark.visible = false;
                    };
                    break;
                case "chkGold":
                    if (e.currentTarget.checkmark.visible)
                    {
                        this.chkAC.checkmark.visible = false;
                    };
                    break;
                case "chkLegend":
                    if (e.currentTarget.checkmark.visible)
                    {
                        this.chkFree.checkmark.visible = false;
                    };
                    break;
                case "chkFree":
                    if (e.currentTarget.checkmark.visible)
                    {
                        this.chkLegend.checkmark.visible = false;
                    };
                    break;
            };
        }

        public function onBtnFilter(e:MouseEvent):void
        {
            var mcFocus:MovieClip = MovieClip(this.rootClass.ui.mcPopup.getChildByName("mcBank")).bankPanel.frames[1].mc;
            mcFocus.fOpen({
                "fData":{
                    "list":this.rootClass.world.bankinfo.items.filter(this.onFilter),
                    "itemsB":this.rootClass.world.bankinfo.items,
                    "itemsI":this.rootClass.world.myAvatar.items,
                    "objData":this.rootClass.world.myAvatar.objData,
                    "isBank":true
                },
                "r":{
                    "x":21,
                    "y":46,
                    "w":265,
                    "h":304
                },
                "sMode":"bank",
                "refreshTabs":true
            });
        }

        public function onBuyTicket(e:MouseEvent):void
        {
            this.rootClass.world.sendLoadShopRequest(5);
        }


    }
}//package 

