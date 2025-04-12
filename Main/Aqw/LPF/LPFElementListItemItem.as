// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFElementListItemItem

package Main.Aqw.LPF
{
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.*;

    public class LPFElementListItemItem extends LPFElementListItem 
    {

        public var tSeller:TextField;
        public var tDuration:TextField;
        public var tGold:TextField;
        public var tCoins:TextField;
        public var blackBG:MovieClip;
        public var mcLine:MovieClip;
        public var icon:MovieClip;
        public var tName:TextField;
        public var selBG:MovieClip;
        public var tLevel:TextField;
        public var tLevelDisplay:MovieClip;
        public var iconAC:MovieClip;
        public var eqpBG:MovieClip;
        public var wearBG:MovieClip;
        public var iconRing:MovieClip;
        public var hit:MovieClip;
        public var sel:Boolean = false;
        public var rarity:MovieClip;
        private var onAuction:Boolean = false;
        private var onInventory:Boolean = false;
        private var onRetrieve:Boolean = false;
        private var rootClass:Game = Game.root;
        private var allowDesel:Boolean = false;
        private var bLimited:Boolean = false;

        public function LPFElementListItemItem():void
        {
            addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
        }

        override public function fOpen(data:Object):void
        {
            fData = data.fData;
            if (data.eventType != undefined)
            {
                eventType = data.eventType;
            };
            if (data.allowDesel != undefined)
            {
                this.allowDesel = data.allowDesel;
            };
            if (data.bLimited != undefined)
            {
                this.bLimited = data.bLimited;
            };
            if (data.onAuction != undefined)
            {
                this.onAuction = data.onAuction;
            };
            if (data.onInventory != undefined)
            {
                this.onInventory = data.onInventory;
            };
            if (data.onRetrieve != undefined)
            {
                this.onRetrieve = data.onRetrieve;
            };
            this.fDraw();
        }

        override protected function fDraw():void
        {
            var rank:Number;
            this.eqpBG.visible = false;
            this.wearBG.visible = false;
            this.tSeller.visible = false;
            this.tDuration.visible = false;
            this.tCoins.visible = false;
            switch (this.rootClass.ui.mcPopup.currentLabel)
            {
                case "AuctionPanel":
                    this.eqpBG.width = 595;
                    this.wearBG.width = 595;
                    this.selBG.width = 595;
                    this.blackBG.width = 595;
                    this.mcLine.width = 595;
                    this.tLevel.x = 240;
                    this.tLevelDisplay.x = 224;
                    if (((this.onAuction) || (this.onRetrieve)))
                    {
                        this.tSeller.visible = true;
                        this.tDuration.visible = true;
                        this.tCoins.visible = true;
                        this.tSeller.htmlText = fData.Player;
                        this.tDuration.htmlText = fData.Duration;
                        this.tCoins.htmlText = this.rootClass.strNumWithCommas(fData.Coins);
                        if (this.rootClass.vendingOwner != "")
                        {
                            this.tSeller.visible = false;
                            this.tDuration.visible = false;
                            if (this.onRetrieve)
                            {
                                this.tDuration.visible = true;
                                this.tDuration.htmlText = fData.Player;
                            };
                        };
                    };
                    if (this.onInventory)
                    {
                        this.tSeller.htmlText = "";
                        this.tDuration.htmlText = "";
                        this.tCoins.htmlText = "";
                    };
                    break;
                default:
                    this.eqpBG.visible = fData.bEquip;
                    this.wearBG.visible = fData.bWear;
            };
            var itemColor:String = "#FFFFFF";
            var playerLevel:int = this.rootClass.world.myAvatar.dataLeaf.intLevel;
            var itemName:String = fData.sName;
            if (fData.bUpg == 1)
            {
                itemColor = "#FCC749";
            };
            if (((fData.iLvl > playerLevel) || ((!(fData.EnhLvl == null)) && (fData.EnhLvl > playerLevel))))
            {
                itemColor = "#FF0000";
            };
            if (((this.bLimited) && (fData.iQtyRemain <= 0)))
            {
                itemColor = "#666666";
            };
            this.tName.htmlText = (((("<font color='" + itemColor) + "'>") + itemName) + "</font>");
            if (this.bLimited)
            {
                this.tName.htmlText = (this.tName.htmlText + (("<font color='#AA0000'> x" + fData.iQtyRemain) + "</font>"));
            }
            else
            {
                if (fData.iStk > 1)
                {
                    this.tName.htmlText = (this.tName.htmlText + (("<font color='#999999'> x" + fData.iQty) + "</font>"));
                };
            };
            if (((fData.sES == "ar") && (fData.EnhID > 0)))
            {
                rank = Rank.getRankFromPoints(fData.iQty);
                this.tName.htmlText = (this.tName.htmlText + (("<font color='#999999'>, Rank " + rank) + "</font>"));
            };
            if (fData.EnhLvl > 0)
            {
                this.tLevel.htmlText = (("<font color='#00CCFF'>" + fData.EnhLvl) + "</font>");
            }
            else
            {
                if (fData.iLvl > 0)
                {
                    this.tLevel.htmlText = (("<font color='#FFFFFF'>" + fData.iLvl) + "</font>");
                }
                else
                {
                    this.tLevel.visible = false;
                };
            };
            this.iconAC.visible = false;
            var enhPattern:Object;
            if (["Weapon", "he", "ar", "ba"].indexOf(fData.sES) > -1)
            {
                if (fData.PatternID != -1)
                {
                    enhPattern = this.rootClass.world.enhPatternTree[fData.PatternID];
                }
                else
                {
                    if (fData.EnhPatternID != -1)
                    {
                        enhPattern = this.rootClass.world.enhPatternTree[fData.EnhPatternID];
                    };
                };
            };
            this.icon.removeChildren();
            var mcIcon:DisplayObject = this.icon.addChild(fData.iconClass);
            var mcIconX:int;
            var mcIconY:int;
            var scale_1:Number = 23;
            var scale_2:Number = 19;
            if (fData.sType.toLowerCase() == "enhancement")
            {
                mcIconX = 1;
                mcIconY = 1;
                scale_1 = 13;
                scale_2 = 11;
            };
            mcIcon.scaleX = ((mcIcon.width > mcIcon.height) ? mcIcon.scaleY = (scale_1 / mcIcon.width) : mcIcon.scaleY = (scale_2 / mcIcon.height));
            mcIcon.x = (-(mcIcon.width >> 1) + mcIconX);
            mcIcon.y = (-(mcIcon.height >> 1) + mcIconY);
            this.iconRing.y = (this.iconRing.y = 2);
            this.iconRing.width = (this.iconRing.height = 25);
            if (fData.sType.toLowerCase() == "enhancement")
            {
                this.icon.transform.colorTransform = MainController.colorCT.blackoutCT;
            }
            else
            {
                if (fData.EnhLvl > 0)
                {
                    this.iconRing.width = (this.iconRing.height = 19);
                    this.iconRing.x = (this.iconRing.x + 3);
                    this.iconRing.y = (this.iconRing.y + 3);
                }
                else
                {
                    this.iconRing.visible = false;
                    if (["Weapon", "he", "ar", "ba"].indexOf(fData.sES) > -1)
                    {
                        this.icon.transform.colorTransform = MainController.colorCT.greyoutCT;
                    };
                };
            };
            if (enhPattern != null)
            {
                this.iconRing.bg.transform.colorTransform = MainController.getCatCT(enhPattern.sDesc);
            };
            this.selBG.alpha = 0;
            buttonMode = true;
            mouseChildren = false;
        }

        override public function select():void
        {
            this.sel = true;
            this.selBG.alpha = 1;
        }

        override public function deselect():void
        {
            this.sel = false;
            this.selBG.alpha = 0;
        }

        override protected function onClick(mouseEvent:MouseEvent):void
        {
            var lpfElementListItemItem:LPFElementListItemItem;
            if (!this.rootClass.isGreedyModalInStack())
            {
                if (!this.sel)
                {
                    lpfElementListItemItem = LPFFrameListViewTabbed(fParent).getListItemByiSel();
                    if (lpfElementListItemItem != null)
                    {
                        lpfElementListItemItem.deselect();
                    };
                    this.select();
                }
                else
                {
                    if (this.allowDesel)
                    {
                        this.deselect();
                    };
                };
                update();
            };
        }

        override protected function onMouseOver(_arg1:MouseEvent):void
        {
            if (!this.sel)
            {
                this.selBG.alpha = 0.6;
            };
        }

        override protected function onMouseOut(_arg1:MouseEvent):void
        {
            if (!this.sel)
            {
                this.selBG.alpha = 0;
            };
        }


    }
}//package Main.Aqw.LPF

