// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Pet.PetElement

package Main.Pet
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

    public class PetElement extends Sprite 
    {

        public var check:Sprite;
        public var txtName:TextField;
        public var progress:MovieClip;
        public var headDisplay:Sprite;
        public var btnView:SimpleButton;
        public var data:Object;
        private var petPanel:PetPanel;

        public function PetElement(petPanel:PetPanel, data:Object)
        {
            trace(JSON.stringify(data));
            this.petPanel = petPanel;
            this.data = data;
            trace(this.data);
            trace(this.data.Name);
            this.txtName.text = this.data.Name;
            this.check.visible = this.data.Status;
            PetPanel.setProgress(this.progress.progressBar, this.progress.progressText, this.data.Percentage);
            this.btnView.addEventListener(MouseEvent.CLICK, this.onViewClick, false, 0, true);
            var key:* = (("pet_" + this.data.id) + "_junk");
            this.petPanel.loaders.push(key);
            LoadController.singleton.addLoadJunk(this.data.File, key, this.onFileLoadComplete);
        }

        private static function onPreviewClick(mouseEvent:MouseEvent):void
        {
            LPFLayoutChatItemPreview.linkItem(mouseEvent.currentTarget.parent.ItemData);
        }


        private function setupView():void
        {
            var object:Object;
            var item:Item;
            var dropFrameMC:DFrameMCcnt;
            var mcIcon:DisplayObject;
            var glowFilter:GlowFilter;
            this.petPanel.viewDisplay.txtName.text = this.data.Name;
            this.petPanel.viewDisplay.txtDescription.text = this.data.Description;
            PetPanel.setProgress(this.petPanel.progressTotal.progressBar, this.petPanel.progressTotal.progressText, this.data.Percentage);
            this.btnView.removeEventListener(MouseEvent.CLICK, this.onViewClick);
            var head:MovieClip = MovieClip(this.petPanel.viewDisplay.headDisplay.addChild(new (Class(LoadController.singleton.applicationDomainJunk.getDefinition(this.data.Linkage)))()));
            head.width = (head.height = 100);
            this.petPanel.viewDisplay.rewardDisplay.y = (this.petPanel.viewDisplay.txtDescription.y + this.petPanel.viewDisplay.txtDescription.height);
            var position:int = 10;
            for each (object in this.data.Rewards)
            {
                item = new Item(object);
                dropFrameMC = (this.petPanel.viewDisplay.rewardDisplay.addChild(new DFrameMCcnt()) as DFrameMCcnt);
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
            if (this.data.Percentage >= 100)
            {
                this.petPanel.btnReward.filters = [];
            }
            else
            {
                this.petPanel.btnReward.filters = [new ColorMatrixFilter([0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0, 0, 0, 1, 0])];
            };
            Game.configureScroll(this.petPanel.viewDisplay, this.petPanel.viewMask, this.petPanel.viewScroll);
        }

        private function setupChains():void
        {
            var chain:Object;
            var petChainElement:Pet2Element;
            var i:int;
            var sortedChains:Array = PetPanel.sortData(this.data.Chains);
            var petElementHeight:Number = 45;
            for each (chain in sortedChains)
            {
                petChainElement = Pet2Element(this.petPanel.list2Display.addChild(new Pet2Element(this.petPanel, chain)));
                petChainElement.y = (petElementHeight * i);
                i++;
            };
            Game.configureScroll(this.petPanel.list2Display, this.petPanel.list2Mask, this.petPanel.list2Scroll);
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
            this.petPanel.gotoAndStop("View");
            this.petPanel.currentData = this.data;
            this.setupView();
            this.setupChains();
        }


    }
}//package Main.Pet

