// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcTitle

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.*;
    import Game_fla.*;

    public class mcTitle extends MovieClip 
    {

        public var game:Game = Game.root;
        public var data:Object;
        public var titleID:int;
        public var txtName:TextField;
        public var txtRarity:TextField;
        public var txtDescription:TextField;
        public var txtUnlock:TextField;
        public var txtEquip:TextField;
        public var txtSearch:TextField;
        public var btnClose:SimpleButton;
        public var btnEquip:SimpleButton;
        public var mcTarget:MovieClip = null;
        public var mcPreview:MovieClip;
        public var mcBoosted:MovieClip;
        public var mcMask:MovieClip;
        public var mcList:MovieClip;
        public var mcUnlock:MovieClip;
        public var mcDetails:MovieClip;
        public var mcScroll:LPFElementScrollBar;
        private var maxVisibleItems:int = 10;

        public function mcTitle()
        {
            this.data = mcPopup_323(parent).fData;
            this.txtEquip.mouseEnabled = false;
            this.btnEquip.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.mcUnlock.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.mcDetails.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.mcBoosted.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.txtSearch.addEventListener(Event.CHANGE, this.onSearch, false, 0, true);
            this.mcPreview.btnHide.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.mcPreview.visible = false;
            this.mcUnlock.reCheck(false);
            this.mcBoosted.reCheck(false);
            this.mcDetails.reCheck(true);
            this.txtUnlock.htmlText = (("You have unlocked: <font color='#FFFFFF'>" + this.data.Total) + "</font>");
            this.build(this.data.titles);
        }

        private function onSearch(event:Event):void
        {
            this.filter(this.txtSearch.text.toLowerCase(), true);
        }

        public function filter(searchText:String, reset:Boolean):void
        {
            var element:Object;
            var passesSearch:Boolean;
            var passesUnlock:Boolean;
            var passesBoosted:Boolean;
            while (this.mcList.numChildren > 0)
            {
                this.mcList.removeChildAt(0);
            };
            var filtered:Array = [];
            var i:int;
            while (i < this.data.titles.length)
            {
                element = this.data.titles[i];
                passesSearch = (!(element.Name.toLowerCase().indexOf(searchText) == -1));
                passesUnlock = ((!(this.mcUnlock.bitChecked)) || (!(element.Lock)));
                passesBoosted = ((!(this.mcBoosted.bitChecked)) || (!(element.Effect == null)));
                if ((((passesSearch) && (passesUnlock)) && (passesBoosted)))
                {
                    filtered.push(element);
                };
                i++;
            };
            if (reset)
            {
                this.maxVisibleItems = 10;
            };
            this.build(filtered, reset);
        }

        private function build(data:Array, reset:Boolean=true):void
        {
            var mcElement:mcCommonElement;
            var moreData:*;
            var mcMore:mcCommonElement;
            if (reset)
            {
                while (this.mcList.numChildren > 0)
                {
                    this.mcList.removeChildAt(0);
                };
            };
            var endIndex:int = Math.min(this.maxVisibleItems, data.length);
            var i:int;
            while (i < endIndex)
            {
                mcElement = new mcCommonElement(data[i], ((!(this.game.world.myAvatar.objData.title == null)) && (data[i].id == this.game.world.myAvatar.objData.title.id)));
                mcElement.name = "btnElement";
                mcElement.y = (32 * i);
                mcElement.Rarity.gotoAndStop(mcElement.Data.Rarity);
                mcElement.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
                this.mcList.addChild(mcElement);
                i++;
            };
            if (this.maxVisibleItems < data.length)
            {
                moreData = new Object();
                moreData.Name = "Show More";
                moreData.Lock = false;
                mcMore = new mcCommonElement(moreData, false);
                mcMore.name = "btnMore";
                mcMore.y = (32 * endIndex);
                mcMore.Rarity.gotoAndStop(0);
                mcMore.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
                this.mcList.addChild(mcMore);
            };
            Game.configureScroll(this.mcList, this.mcMask, this.mcScroll, 0, reset);
        }

        private function onClick(event:MouseEvent):void
        {
            var key:String;
            var value:Number;
            var color:String;
            switch (event.currentTarget.name)
            {
                case "mcBoosted":
                case "mcUnlock":
                    this.filter(this.txtSearch.text.toLowerCase(), true);
                    break;
                case "mcDetails":
                    this.mcPreview.visible = ((!(this.mcTarget == null)) && (this.mcDetails.bitChecked));
                    break;
                case "btnHide":
                    this.mcPreview.visible = false;
                    break;
                case "btnMore":
                    this.maxVisibleItems = (this.maxVisibleItems + 10);
                    this.filter(this.txtSearch.text.toLowerCase(), false);
                    break;
                case "btnElement":
                    this.mcTarget = event.currentTarget;
                    this.titleID = this.mcTarget.Data.id;
                    this.mcPreview.txtTitle.text = "Details";
                    this.mcPreview.txtName.text = this.mcTarget.Data.Name;
                    this.mcPreview.txtRarity.htmlText = Rarity.HTML(this.mcTarget.Data.Rarity);
                    this.mcPreview.txtDescription.htmlText = this.mcTarget.Data.Description;
                    this.mcPreview.txtExperienceBoost.htmlText = "0.00";
                    this.mcPreview.txtCoinsBoost.htmlText = "0.00";
                    this.mcPreview.txtClassPointsBoost.htmlText = "0.00";
                    this.mcPreview.txtReputationBoost.htmlText = "0.00";
                    this.mcPreview.txtDamageIncreaseBoost.htmlText = "0.00";
                    this.mcPreview.txtDamageReductionBoost.htmlText = "0.00";
                    if (this.mcTarget.Data.Effect != null)
                    {
                        for (key in this.mcTarget.Data.Effect)
                        {
                            value = this.mcTarget.Data.Effect[key];
                            if (((("txt" + key) + "Boost") in this.mcPreview))
                            {
                                color = ((value != 0) ? "#00FF00" : "#FFFFFF");
                                this.mcPreview[(("txt" + key) + "Boost")].htmlText = (((("<font color='" + color) + "'>") + value.toFixed(2)) + "</font>");
                            };
                        };
                    };
                    this.mcPreview.visible = this.mcDetails.bitChecked;
                    this.txtEquip.text = (((!(this.game.world.myAvatar.objData.title == null)) && (this.mcTarget.Data.id == this.game.world.myAvatar.objData.title.id)) ? "Unequip" : "Equip");
                    break;
                case "btnEquip":
                    if (this.mcTarget == null)
                    {
                        this.game.MsgBox.notify("Please select a title.");
                        return;
                    };
                    if (this.mcTarget.Data.Lock)
                    {
                        this.game.MsgBox.notify("This title is locked.");
                        return;
                    };
                    if (this.game.world.coolDown("updateTitle"))
                    {
                        Game.root.network.send(((this.txtEquip.text == "Equip") ? "equipTitles" : "removeTitles"), [this.titleID]);
                    };
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }


    }
}//package 

