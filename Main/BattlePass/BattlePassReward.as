// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.BattlePass.BattlePassReward

package Main.BattlePass
{
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import Main.Avatar.*;
    import Main.*;

    public class BattlePassReward extends Sprite 
    {

        public var game:Game = Game.root;
        public var btnClick:SimpleButton;
        public var txtItemName:TextField;
        public var txtLevel:TextField;
        public var backgroundDisplay:Sprite;
        private var data:Object;
        private var battlePassPanel:BattlePassPanel;
        public var mcLock:Sprite;

        public function BattlePassReward(battlePassPanel:BattlePassPanel, data:Object, level:int)
        {
            var icon:MovieClip;
            super();
            this.data = data;
            this.battlePassPanel = battlePassPanel;
            this.txtItemName.htmlText = this.data.item.sName;
            this.txtLevel.text = ("Level " + this.data.level);
            this.btnClick.addEventListener(MouseEvent.CLICK, this.onRewardClick, false, 0, true);
            if (this.data.level <= level)
            {
                this.mcLock.visible = false;
            };
            var cls:Class = Game.root.world.getClass(this.data.item.sIcon);
            if (cls == null)
            {
                cls = Game.root.world.getClass("iibag");
            };
            icon = MovieClip(addChildAt(new (cls)(), 3));
            var ar:Number = (icon.width / icon.height);
            icon.height = 41;
            icon.width = (41 * ar);
            icon.x = ((icon.parent.width - icon.width) / 2);
            icon.y = 4.5;
            icon.mouseChildren = false;
            icon.mouseEnabled = false;
            AvatarUtil.changeColor(this.backgroundDisplay, Rarity.rarities[this.data.item.iRty].ColorDecimal, "none");
        }

        private function onRewardClick(event:MouseEvent):void
        {
            var reward:BattlePassReward;
            var rarity:Object;
            reward = BattlePassReward(event.currentTarget.parent);
            rarity = Rarity.rarities[reward.data.item.iRty];
            this.battlePassPanel.battlePassPreview.visible = true;
            this.battlePassPanel.rarityGlowDisplay.visible = true;
            this.battlePassPanel.txtItemName.visible = true;
            this.battlePassPanel.txtItemRarity.visible = true;
            this.battlePassPanel.txtItemName.htmlText = ((((("<a href='" + Config.serverWikiItemURL) + reward.data.item.ItemID) + "' target='_blank'>") + reward.data.item.sName) + "</a>");
            this.battlePassPanel.txtItemRarity.htmlText = rarity.HTML;
            AvatarUtil.changeColor(this.battlePassPanel.rarityGlowDisplay, rarity.ColorDecimal, "none");
            this.battlePassPanel.battlePassPreview.preview.item = new Item({
                "ItemID":reward.data.item.ItemID,
                "sName":reward.data.item.sName,
                "sFile":reward.data.item.sFile,
                "sLink":reward.data.item.sLink,
                "sIcon":reward.data.item.sIcon,
                "sType":reward.data.item.sType,
                "sES":reward.data.item.sES
            });
            switch (reward.data.item.sES)
            {
                case "co":
                case "ar":
                    this.battlePassPanel.battlePassPreview.mcPreview.scaleX = 2;
                    this.battlePassPanel.battlePassPreview.mcPreview.scaleY = 2;
                    this.battlePassPanel.battlePassPreview.mcPreview.y = 200;
                    this.battlePassPanel.battlePassPreview.mcPreview.x = 200;
                    break;
                case "mi":
                case "en":
                case "hi":
                case "ho":
                case "pe":
                case "ba":
                case "he":
                case "Weapon":
                default:
                    this.battlePassPanel.battlePassPreview.mcPreview.scaleX = 1;
                    this.battlePassPanel.battlePassPreview.mcPreview.scaleY = 1;
                    this.battlePassPanel.battlePassPreview.mcPreview.y = 0;
                    this.battlePassPanel.battlePassPreview.mcPreview.x = 0;
            };
            this.battlePassPanel.battlePassPreview.preview.loadPreview();
        }


    }
}//package Main.BattlePass

