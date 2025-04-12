// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Chat.ChatCustomizationPanel

package Main.Chat
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Game_fla.*;

    public class ChatCustomizationPanel extends MovieClip 
    {

        public var game:Game = Game.root;
        public var data:Object;
        public var chatID:int;
        public var txtSearch:TextField;
        public var txtUnlock:TextField;
        public var txtEquip:TextField;
        public var btnClose:SimpleButton;
        public var btnEquip:SimpleButton;
        public var mcTarget:MovieClip = null;
        public var mcUnlock:MovieClip;
        public var mcMask:MovieClip;
        public var mcList:MovieClip;
        public var mcScroll:LPFElementScrollBar;
        private var maxVisibleItems:int = 10;

        public function ChatCustomizationPanel()
        {
            this.data = mcPopup_323(parent).fData;
            this.txtEquip.mouseEnabled = false;
            this.btnEquip.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.txtSearch.addEventListener(Event.CHANGE, this.onSearch, false, 0, true);
            this.mcUnlock.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.mcUnlock.reCheck(false);
            this.txtUnlock.htmlText = (("You have unlocked: <font color='#FFFFFF'>" + this.data.Total) + "</font>");
            this.build(this.data.chats);
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
            while (this.mcList.numChildren > 0)
            {
                this.mcList.removeChildAt(0);
            };
            var filtered:Array = [];
            var i:int;
            while (i < this.data.chats.length)
            {
                element = this.data.chats[i];
                passesSearch = (!(element.Name.toLowerCase().indexOf(searchText) == -1));
                passesUnlock = ((!(this.mcUnlock.bitChecked)) || (!(element.Lock)));
                if (((passesSearch) && (passesUnlock)))
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
            var moreData:Object;
            var mcMore:mcCommonElement;
            var endIndex:int = Math.min(this.maxVisibleItems, data.length);
            var i:int;
            while (i < endIndex)
            {
                mcElement = new mcCommonElement(data[i], ((!(this.game.world.myAvatar.objData.chat == null)) && (data[i].id == this.game.world.myAvatar.objData.chat.id)));
                mcElement.name = "btnElement";
                mcElement.y = (32 * i);
                mcElement.Rarity.gotoAndStop(0);
                mcElement.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
                this.mcList.addChild(mcElement);
                i++;
            };
            if (endIndex < data.length)
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
            switch (event.currentTarget.name)
            {
                case "mcBoosted":
                case "mcUnlock":
                    this.filter(this.txtSearch.text.toLowerCase(), true);
                    break;
                case "mcDetails":
                    mcPreview.visible = ((!(this.mcTarget == null)) && (mcDetails.bitChecked));
                    break;
                case "btnMore":
                    this.maxVisibleItems = (this.maxVisibleItems + 10);
                    this.filter(this.txtSearch.text.toLowerCase(), false);
                    break;
                case "btnElement":
                    if (this.mcTarget != null)
                    {
                        this.mcTarget.Rarity.gotoAndStop(0);
                    };
                    this.mcTarget = event.currentTarget;
                    this.mcTarget.Rarity.gotoAndStop(6);
                    this.chatID = this.mcTarget.Data.id;
                    this.txtEquip.text = (((!(this.game.world.myAvatar.objData.chat == null)) && (this.mcTarget.Data.id == this.game.world.myAvatar.objData.chat.id)) ? "Unequip" : "Equip");
                    break;
                case "btnEquip":
                    if (this.mcTarget == null)
                    {
                        this.game.MsgBox.notify("Please select a chat type.");
                        return;
                    };
                    if (this.mcTarget.Data.Lock)
                    {
                        this.game.MsgBox.notify("This chat type is locked.");
                        return;
                    };
                    if (this.game.world.coolDown("updateTitle"))
                    {
                        Game.root.network.send(((this.txtEquip.text == "Equip") ? "equipChat" : "unequipChat"), [this.chatID]);
                    };
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }


    }
}//package Main.Chat

