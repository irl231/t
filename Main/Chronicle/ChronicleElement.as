// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Chronicle.ChronicleElement

package Main.Chronicle
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import Main.Model.Item;
    import flash.display.DisplayObject;
    import flash.filters.GlowFilter;
    import flash.events.Event;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import Main.Aqw.LPF.*;
    import Main.Controller.*;
    import Main.*;

    public class ChronicleElement extends Sprite 
    {

        public var check:Sprite;
        public var txtName:TextField;
        public var progress:MovieClip;
        public var headDisplay:Sprite;
        public var btnView:SimpleButton;
        public var data:Object;
        private var chroniclePanel:ChroniclePanel;

        public function ChronicleElement(chroniclePanel:ChroniclePanel, data:Object)
        {
            this.chroniclePanel = chroniclePanel;
            this.data = data;
            this.txtName.text = this.data.Name;
            this.check.visible = this.data.Status;
            ChroniclePanel.setProgress(this.progress.progressBar, this.progress.progressText, this.data.Percentage);
            this.btnView.addEventListener(MouseEvent.CLICK, this.onViewClick, false, 0, true);
            var key:* = (("chronicle_" + this.data.id) + "_junk");
            this.chroniclePanel.loaders.push(key);
            LoadController.singleton.addLoadJunk(this.data.File, key, this.onFileLoadComplete);
            if (!this.data.IsReleased)
            {
                this.btnView.filters = [new ColorMatrixFilter([0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0, 0, 0, 1, 0])];
            };
        }

        private static function onPreviewClick(mouseEvent:MouseEvent):void
        {
            LPFLayoutChatItemPreview.linkItem(mouseEvent.currentTarget.parent.ItemData);
        }


        private function setupView():void
        {
            var object:Object;
            var head:MovieClip;
            var item:Item;
            var dropFrameMC:DFrameMCcnt;
            var mcIcon:DisplayObject;
            var glowFilter:GlowFilter;
            this.chroniclePanel.viewDisplay.txtName.text = this.data.Name;
            this.chroniclePanel.viewDisplay.txtDescription.text = this.data.Description;
            this.btnView.removeEventListener(MouseEvent.CLICK, this.onViewClick);
            try
            {
                head = MovieClip(this.chroniclePanel.viewDisplay.headDisplay.addChild(new (Class(LoadController.singleton.applicationDomainJunk.getDefinition(this.data.Linkage)))()));
                head.width = (head.height = 100);
            }
            catch(error)
            {
                Game.root.chatF.pushMsg("warning", error, "SERVER", "", 0);
            };
            this.chroniclePanel.viewDisplay.rewardDisplay.y = (this.chroniclePanel.viewDisplay.txtDescription.y + this.chroniclePanel.viewDisplay.txtDescription.height);
            var position:int = 10;
            for each (object in this.data.Rewards)
            {
                item = new Item(object);
                dropFrameMC = (this.chroniclePanel.viewDisplay.rewardDisplay.addChild(new DFrameMCcnt()) as DFrameMCcnt);
                dropFrameMC.btnEye.addEventListener(MouseEvent.CLICK, onPreviewClick, false, 0, true);
                dropFrameMC.ItemData = item;
                dropFrameMC.ItemID = item.ItemID;
                dropFrameMC.strRate.text = "";
                dropFrameMC.strName.autoSize = "left";
                dropFrameMC.strName.htmlText = item.sName;
                dropFrameMC.strName.width = (dropFrameMC.strName.textWidth + 6);
                dropFrameMC.strType.htmlText = ((((item.sType + " <b><u><font color='#EEFF00'><a target='_blank' href='") + Config.serverWikiItemURL) + item.ItemID) + "'>(Wiki)</a></font></u></b>");
                dropFrameMC.bg.width = 193.4;
                dropFrameMC.fx1.width = dropFrameMC.bg.width;
                if (item.iQty > 1)
                {
                    dropFrameMC.strQ.text = ("x" + item.iQty);
                    dropFrameMC.strQ.x = ((dropFrameMC.bg.width - dropFrameMC.strQ.width) - 7);
                    dropFrameMC.strQ.visible = true;
                }
                else
                {
                    dropFrameMC.strQ.x = 0;
                    dropFrameMC.strQ.visible = false;
                };
                Game.root.onRemoveChildrens(dropFrameMC.icon);
                mcIcon = dropFrameMC.icon.addChild(item.iconClass);
                mcIcon.scaleX = (mcIcon.scaleY = 0.5);
                glowFilter = item.rarityGlow;
                dropFrameMC.icon.filters = [glowFilter];
                dropFrameMC.filters = [glowFilter];
                dropFrameMC.y = position;
                position = (position + (dropFrameMC.height + 8));
            };
            if (((this.data.Percentage >= 100) && (!(this.data.IsCompleted))))
            {
                this.chroniclePanel.btnReward.filters = [];
            }
            else
            {
                this.chroniclePanel.btnReward.filters = [new ColorMatrixFilter([0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0, 0, 0, 1, 0])];
            };
            ChroniclePanel.setProgress(this.chroniclePanel.progressTotal.progressBar, this.chroniclePanel.progressTotal.progressText, this.data.Percentage);
            Game.configureScroll(this.chroniclePanel.viewDisplay, this.chroniclePanel.viewMask, this.chroniclePanel.viewScroll);
        }

        private function setupChains():void
        {
            var chain:Object;
            var chronicleChainElement:ChronicleChainElement;
            var i:int;
            var chronicleElementHeight:Number = 45;
            var total:Number = 0;
            for each (chain in this.data.Chains)
            {
                chronicleChainElement = ChronicleChainElement(this.chroniclePanel.list2Display.addChild(new ChronicleChainElement(this.chroniclePanel, chain)));
                chronicleChainElement.y = (chronicleElementHeight * i);
                total = (total + ((this.data.ChainValueCurrent / this.data.ChainValueRequired) * 100));
                i++;
            };
            Game.configureScroll(this.chroniclePanel.list2Display, this.chroniclePanel.list2Mask, this.chroniclePanel.list2Scroll);
        }

        private function onFileLoadComplete(event:Event=null):void
        {
            var head:MovieClip;
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.data.Linkage))
            {
                head = MovieClip(this.headDisplay.addChild(new (Class(LoadController.singleton.applicationDomainJunk.getDefinition(this.data.Linkage)))()));
                head.width = (head.height = 30);
            };
        }

        private function onViewClick(event:Event):void
        {
            if (!this.data.IsReleased)
            {
                Game.root.MsgBox.notify("This chronicle is not released yet. Please come back later.");
                return;
            };
            this.chroniclePanel.gotoAndStop("View");
            this.chroniclePanel.currentData = this.data;
            this.setupView();
            this.setupChains();
        }


    }
}//package Main.Chronicle

