// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.Preview

package Main.UI
{
    import flash.display.MovieClip;
    import Main.Model.Item;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import Main.Avatar.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;

    public class Preview 
    {

        private var target:MovieClip;
        public var item:Item = null;
        private var sLinkHouse:String = "";
        private var sLinkHouseItem:String = "";
        private var sLinkArmor:String = "";
        private var sLinkCape:String = "";
        private var sLinkHelm:String = "";
        private var sLinkPet:String = "";
        private var sLinkMisc:String = "";
        private var sLinkEntity:String = "";
        private var sLinkWeapon:String = "";
        public var LOAD_KEY:String;
        public var gender:String = Game.root.world.myAvatar.objData.strGender;
        public var objData:Object = null;

        public function Preview(parent:MovieClip):void
        {
            this.target = parent;
        }

        private function colorized(item:MovieClip):void
        {
            this.objData = Game.root.copyObj(Game.root.world.myAvatar.objData);
            this.objData.eqp = new Object();
            this.objData.eqp[this.item.sES] = this.item;
            this.objData.iUpgDays = 1;
            if (((this.item.sES == "ar") || (this.item.sES == "co")))
            {
                AvatarColor.applyArmorColors(this.item, item);
            }
            else
            {
                AvatarColor.changeColorSpecial(item, this.item, ((this.item.sES == "pe") || (this.item.sES == "mi")));
            };
        }

        public function clearPreview():void
        {
            var child:MovieClip;
            var numChildren:int = MovieClip(this.target.mcPreview).numChildren;
            var i:int = (numChildren - 1);
            while (i >= 0)
            {
                child = MovieClip(MovieClip(this.target.mcPreview).getChildAt(i));
                Game.movieClipStopAll(child);
                MovieClip(this.target.mcPreview).removeChildAt(i);
                i--;
            };
            LoadController.singleton.clearLoader(this.LOAD_KEY);
        }

        private function addGlow(mc:MovieClip, armor:Boolean=true):void
        {
            UIController.addGlow(mc);
            if (armor)
            {
                this.repositionPreview(mc);
            };
        }

        public function repositionPreview(movieClip:MovieClip):void
        {
            var rectangleFinal:Number;
            var rectangle:Rectangle = movieClip.getBounds(this.target);
            if (rectangle.height > 175)
            {
                rectangleFinal = (175 / rectangle.height);
                movieClip.scaleX = (movieClip.scaleX * rectangleFinal);
                movieClip.scaleY = (movieClip.scaleY * rectangleFinal);
            };
            movieClip.x = (movieClip.x - int(((movieClip.getBounds(this.target).x + (movieClip.getBounds(this.target).width >> 1)) - (this.target.width >> 1))));
            movieClip.y = int((movieClip.y - movieClip.getBounds(this.target).y));
        }

        public function loadPreview():void
        {
            var cls:Class;
            var item:MovieClip;
            this.clearPreview();
            if (this.item.sType.toLowerCase() == "enhancement")
            {
                cls = Game.root.world.getClass("iidesign");
                if (cls == null)
                {
                    return;
                };
                item = new (cls)();
                item.scaleX = (item.scaleY = 3);
                MovieClip(this.target.mcPreview).addChild(item);
                this.addGlow(item);
                return;
            };
            if (("btnGender" in this.target))
            {
                this.target.btnGender.visible = false;
            };
            switch (this.item.sES)
            {
                case "Weapon":
                    this.sLinkWeapon = this.item.sLink;
                    LoadController.singleton.addLoadJunk(this.item.sFile, this.LOAD_KEY, this.onLoadWeaponComplete);
                    break;
                case "he":
                    this.sLinkHelm = this.item.sLink;
                    LoadController.singleton.addLoadJunk(this.item.sFile, this.LOAD_KEY, this.onLoadHelmComplete);
                    break;
                case "ba":
                    this.sLinkCape = this.item.sLink;
                    LoadController.singleton.addLoadJunk(this.item.sFile, this.LOAD_KEY, this.onLoadCapeComplete);
                    break;
                case "pe":
                    this.sLinkPet = this.item.sLink;
                    LoadController.singleton.addLoadJunk(this.item.sFile, this.LOAD_KEY, this.onLoadPetComplete);
                    break;
                case "ar":
                case "co":
                    if (("btnGender" in this.target))
                    {
                        this.target.btnGender.visible = true;
                    };
                    this.sLinkArmor = this.item.sLink;
                    LoadController.singleton.addLoadJunk(((("classes/" + this.gender) + "/") + this.item.sFile), this.LOAD_KEY, this.onLoadArmorComplete);
                    break;
                case "ho":
                    this.sLinkHouse = (this.item.sFile.substr(0, -4).substr((this.item.sFile.lastIndexOf("/") + 1)).split("-").join("_") + "_preview");
                    LoadController.singleton.addLoadJunk((("maps/" + this.item.sFile.substr(0, -4)) + "_preview.swf"), this.LOAD_KEY, this.onLoadHouseComplete);
                    break;
                case "hi":
                    this.sLinkHouseItem = this.item.sLink;
                    LoadController.singleton.addLoadJunk(this.item.sFile, this.LOAD_KEY, this.onloadHouseItemComplete);
                    break;
                case "mi":
                    this.sLinkMisc = this.item.sLink;
                    LoadController.singleton.addLoadJunk(this.item.sFile, this.LOAD_KEY, this.onLoadMiscComplete);
                    break;
                case "en":
                    this.sLinkEntity = this.item.sLink;
                    LoadController.singleton.addLoadJunk(this.item.sFile, this.LOAD_KEY, this.onLoadEntityComplete);
                    break;
                default:
                    if ((((this.item.sType.toLowerCase() == "item") && (!(this.item.sLink.toLowerCase() == "none"))) || ((this.item.sType.toLowerCase() == "item") && (this.item.sLink.toLowerCase() == "none"))))
                    {
                        this.loadBag(this.item);
                    }
                    else
                    {
                        if (this.item.sES == "am")
                        {
                            this.loadBag(this.item, true);
                        }
                        else
                        {
                            if (((this.item.sType.toLowerCase() == "serveruse") || (this.item.sType.toLowerCase() == "clientuse")))
                            {
                                this.loadBag(this.item);
                            };
                        };
                    };
            };
        }

        private function loadBag(item:Item, icon:Boolean=false):void
        {
            this.clearPreview();
            var cls:Class;
            if (((((icon) || (item == null)) || (String(item.sFile).length < 1)) || (Game.root.world.getClass(item.sFile) == null)))
            {
                cls = (Game.root.world.getClass(item.sIcon) as Class);
            }
            else
            {
                if ((((!(item == null)) && (String(item.sFile).length > 0)) && (!(Game.root.world.getClass(item.sFile) == null))))
                {
                    cls = (Game.root.world.getClass(item.sFile) as Class);
                };
            };
            if (cls == null)
            {
                cls = (Game.root.world.getClass("iibag") as Class);
            };
            if (cls == null)
            {
                return;
            };
            var mc:MovieClip = new (cls)();
            mc.scaleX = (mc.scaleY = 3);
            MovieClip(this.target.mcPreview).addChild(mc);
            this.addGlow(mc);
        }

        private function onLoadWeaponComplete(event:Event):void
        {
            this.clearPreview();
            var item:MovieClip = ((LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkWeapon)) ? new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkWeapon))() : event.target.content);
            item.scaleX = (item.scaleY = 0.3);
            MovieClip(this.target.mcPreview).addChild(item);
            Game.root.world.myAvatar.pMC.setItemData(item);
            this.addGlow(item);
            this.colorized(this.target.mcPreview);
        }

        private function onLoadHelmComplete(_arg1:Event):void
        {
            var item:MovieClip;
            this.clearPreview();
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkHelm))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkHelm))();
                item.scaleX = (item.scaleY = 0.8);
                MovieClip(this.target.mcPreview).addChild(item);
                Game.root.world.myAvatar.pMC.setItemData(item);
                this.addGlow(item);
                this.colorized(this.target.mcPreview);
            };
        }

        private function onLoadCapeComplete(event:Event):void
        {
            var item:MovieClip;
            this.clearPreview();
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkCape))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkCape))();
                item.scaleX = (item.scaleY = 0.5);
                MovieClip(this.target.mcPreview).addChild(item);
                Game.root.world.myAvatar.pMC.setItemData(item);
                this.addGlow(item);
                this.colorized(this.target.mcPreview);
            };
        }

        private function onLoadPetComplete(_arg1:Event):void
        {
            var item:MovieClip;
            this.clearPreview();
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkPet))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkPet))();
                item.scaleX = (item.scaleY = 2);
                MovieClip(this.target.mcPreview).addChild(item);
                Game.root.world.myAvatar.pMC.setItemData(item);
                this.addGlow(item);
                this.colorized(this.target.mcPreview);
            };
        }

        private function onLoadArmorComplete(_arg1:Event):void
        {
            this.clearPreview();
            this.objData = Game.root.copyObj(Game.root.world.myAvatar.objData);
            this.objData.eqp = {};
            this.objData.strGender = this.gender;
            this.objData.iUpgDays = 1;
            delete this.objData.strHairFilename;
            if (this.objData.hasOwnProperty("title"))
            {
                delete this.objData.title;
            };
            var avatarMC:AvatarMC = AvatarUtil.createAvatar("player", this.target.mcPreview, this.objData, 0);
            avatarMC.loadArmorPieces(this.sLinkArmor, LoadController.singleton.applicationDomainJunk);
            avatarMC.visible = true;
            this.addGlow(avatarMC.mcChar, false);
            this.colorized(avatarMC.mcChar);
        }

        private function onLoadHouseComplete(event:Event):void
        {
            var item:MovieClip;
            this.clearPreview();
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkHouse))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkHouse))();
                item.x = 0;
                item.y = 300;
                MovieClip(this.target.mcPreview).addChild(item);
                Game.root.world.myAvatar.pMC.setItemData(item);
                this.addGlow(item);
            };
        }

        private function onloadHouseItemComplete(_arg1:Event):void
        {
            var item:MovieClip;
            this.clearPreview();
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkHouseItem))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkHouseItem))();
                MovieClip(this.target.mcPreview).addChild(item);
                Game.root.world.myAvatar.pMC.setItemData(item);
                this.addGlow(item);
            };
        }

        private function onLoadMiscComplete(_arg1:Event):void
        {
            var item:MovieClip;
            this.clearPreview();
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkMisc))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkMisc))();
                MovieClip(this.target.mcPreview).addChild(item);
                Game.root.world.myAvatar.pMC.setItemData(item);
                this.addGlow(item);
                this.colorized(this.target.mcPreview);
            };
        }

        private function onLoadEntityComplete(_arg1:Event):void
        {
            var item:MovieClip;
            this.clearPreview();
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.sLinkEntity))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.sLinkEntity))();
                item.scaleX = (item.scaleY = 2);
                MovieClip(this.target.mcPreview).addChild(item);
                Game.root.world.myAvatar.pMC.setItemData(item);
                this.addGlow(item);
                this.colorized(this.target.mcPreview);
            };
        }

        public function onBtnLibraryClick(event:Event):void
        {
            navigateToURL(new URLRequest((Config.serverWikiItemURL + this.item.ItemID)), "_blank");
        }

        public function onBtnCustomizeClick(event:Event):void
        {
            Game.root.toggleCustomizationPanel(this.item);
        }

        public function onBtnChatShowClick(event:Event):void
        {
            MainController.modal((("Do you want to show the item '" + this.item.sName) + "' in chat?"), this.chatShowRequest, {}, "white,medium", "dual", true);
        }

        public function onBtnGenderClick(_arg1:Event):void
        {
            this.gender = ((this.gender == "M") ? "F" : "M");
            this.loadPreview();
        }

        public function onBtnDeleteClick(_arg1:Event):void
        {
            if (this.item.bEquip)
            {
                Game.root.MsgBox.notify("Item is currently equipped!");
                return;
            };
            var iQty:int = ((this.item.sES == "ar") ? 1 : this.item.iQty);
            MainController.modal(((this.item.sES == "ar") ? (("Are you sure you want to delete '" + this.item.sName) + "' and the rank associated with it?") : (("Are you sure you want to delete '" + this.item.sName) + "'?")), this.deleteRequest, {}, "white,medium", null, true, ((iQty > 1) ? ({
"min":1,
"max":iQty
}) : (null)));
        }

        private function chatShowRequest(event:Object):void
        {
            if (event.accept)
            {
                if (Game.root.world.chatFocus == null)
                {
                    Game.root.world.chatFocus = Game.root.ui.mcInterface.te;
                };
                Game.root.world.chatFocus.htmlText = ((Game.root.world.chatFocus.htmlText != "") ? (Game.root.world.chatFocus.htmlText + " ") : "");
                Game.root.world.chatFocus.htmlText = (((((Game.root.world.chatFocus.htmlText + "<a href='loadItem:") + this.item.CharItemID) + "'>&lt;") + this.item.sName.replace(Chat.regExpLinking2, "$1")) + "&gt;</a> ");
                if (Game.root.world.chatFocus == Game.root.ui.mcInterface.te)
                {
                    Game.root.world.chatFocus.htmlText = Game.root.world.chatFocus.htmlText.replace(Chat.regExpSPACE, " ");
                    Game.root.chatF.openMsgEntry();
                };
            };
        }

        private function deleteRequest(params:Object):void
        {
            if (((this.item == null) || (!(params.accept))))
            {
                return;
            };
            if (this.item.bTemp)
            {
                Game.root.world.sendRemoveTempItemRequest(this.item, ((params.iQty == null) ? 1 : params.iQty));
            }
            else
            {
                Game.root.world.sendRemoveItemRequest(this.item, ((params.iQty == null) ? 1 : params.iQty));
            };
        }

        public function onDeleteTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"Delete item"});
        }

        public function onChatShowTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"Link item"});
        }

        public function onCustomizeTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"Customize Item"});
        }

        public function onGenderTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"Change Gender"});
        }

        public function onDeleteTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        public function onGenderTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        public function onChatShowTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        public function onCustomizeTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        public function onbtnLibraryTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        public function onbtnLibraryTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"Check Item in Wiki"});
        }

        public function onCoinTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":(("This item requires " + Config.getString("coins_name")) + " to purchase.")});
        }

        public function onCoinTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        public function onUpgradeTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"This item is exclusive to VIP."});
        }

        public function onUpgradeTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        public function onSpecialTTOver(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"This item has a SPECIAL damage boost."});
        }

        public function onSpecialTTOut(mouseEvent:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }


    }
}//package Main.UI

