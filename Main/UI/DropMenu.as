// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.DropMenu

package Main.UI
{
    import Main.Model.Item;
    import __AS3__.vec.Vector;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.IOErrorEvent;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import Main.Avatar.*;
    import Main.Controller.*;
    import Main.*;

    public class DropMenu extends AbstractPanel 
    {

        private var itemSelected:Item = null;
        private var items:Vector.<Item> = new Vector.<Item>();

        public function DropMenu(game:Game):void
        {
            super(game);
        }

        override protected function onAddedToStage(event:Event):void
        {
            var displayObject:DisplayObject;
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.drag = new Drag(this, this.hit);
            this.hit.alpha = 0;
            var dropStackNumChildren:int = MovieClip(game.ui.dropStack).numChildren;
            var i:int;
            while (i < dropStackNumChildren)
            {
                displayObject = MovieClip(game.ui.dropStack).getChildAt(i);
                if ((displayObject is DFrame2MC))
                {
                    this.dropItem(this.game.copyObj(DFrame2MC(displayObject).fData));
                };
                i++;
            };
            this.btnClose.addEventListener(MouseEvent.CLICK, onClickClose);
            this.preview.bAdd.addEventListener(MouseEvent.CLICK, this.onClickAccept);
            this.preview.bDel.addEventListener(MouseEvent.CLICK, this.onClickDeny);
            this.buildA();
        }

        override public function onHide():void
        {
            this.clearPreview();
            super.onHide();
        }

        override protected function buildA():void
        {
            var item:Item;
            var i:int;
            var itemType:String;
            var protoA:hProto;
            this.game.onRemoveChildrens(iListA.iList);
            var types:Array = [];
            for each (item in this.items)
            {
                if (types.indexOf(item.sType) == -1)
                {
                    types.push(item.sType);
                };
            };
            this.iListB.visible = false;
            this.preview.visible = false;
            var maxWidth:Number = 75;
            i = 0;
            for each (itemType in types)
            {
                protoA = hProto(MovieClip(iListA.iList).addChild(new hProto()));
                protoA.ti.text = itemType;
                protoA.ti.autoSize = "left";
                if (protoA.ti.textWidth > maxWidth)
                {
                    maxWidth = protoA.ti.textWidth;
                };
                protoA.hit.alpha = 0;
                protoA.itemType = itemType;
                protoA.addEventListener(MouseEvent.CLICK, onClickProtoA);
                protoA.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverProto, false, 0, true);
                protoA.y = (protoA.height * i);
                protoA.buttonMode = true;
                protoA.bg.visible = false;
                i++;
            };
            resizeMe(iListA, maxWidth);
            new Scroll(this.iListA.scr, this.iListA.iList, this.iListA.imask, this.iListA.scr.hit, this.iListA.scr.h, this.iListA.scr.b);
        }

        override protected function buildB(proto:hProto):void
        {
            var item:Item;
            var protoB:hProto;
            var addX:String;
            this.game.onRemoveChildrens(iListB.iList);
            this.preview.visible = false;
            this.iListB.visible = true;
            var maxWidth:Number = 75;
            var j:int;
            for each (item in this.items)
            {
                if (proto.itemType == item.sType)
                {
                    protoB = hProto(MovieClip(iListB.iList).addChild(new hProto()));
                    addX = ((item.iStk > 1) ? (" x" + item.iQty) : "");
                    protoB.ti.htmlText = ((item.bUpg == 1) ? ((("<font color='#FCC749'>" + item.sName) + addX) + "</font>") : (item.sName + addX));
                    protoB.ti.autoSize = "left";
                    if (protoB.ti.textWidth > maxWidth)
                    {
                        maxWidth = protoB.ti.textWidth;
                    };
                    protoB.hit.alpha = 0;
                    protoB.item = item;
                    protoB.addEventListener(MouseEvent.CLICK, this.onClickProtoB);
                    protoB.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverProto, false, 0, true);
                    protoB.y = (protoB.height * j);
                    protoB.buttonMode = true;
                    protoB.bg.visible = false;
                    j++;
                };
            };
            resizeMe(iListB, maxWidth);
            new Scroll(this.iListB.scr, this.iListB.iList, this.iListB.imask, this.iListB.scr.hit, this.iListB.scr.h, this.iListB.scr.b);
        }

        override protected function onClickProtoB(mouseEvent:MouseEvent):void
        {
            var cls:Class;
            var item:MovieClip;
            this.clearPreview();
            var proto:hProto = hProto(mouseEvent.currentTarget);
            this.itemSelected = proto.item;
            this.preview.content.x = 70;
            this.preview.content.y = 80;
            if (this.itemSelected.sType.toLowerCase() == "enhancement")
            {
                cls = Game.root.world.getClass("iidesign");
                if (cls == null)
                {
                    return;
                };
                item = new (cls)();
                item.scaleX = (item.scaleY = 3);
                this.previewHandler(item);
                UIController.addGlow(item);
                return;
            };
            switch (this.itemSelected.sES)
            {
                case "Weapon":
                    LoadController.singleton.addLoadJunk(this.itemSelected.sFile, "drop_menu_junk", this.onLoadWeaponComplete, this.onLoadError);
                    break;
                case "hi":
                case "mi":
                case "en":
                case "he":
                case "ba":
                case "pe":
                    LoadController.singleton.addLoadJunk(this.itemSelected.sFile, "drop_menu_junk", this.onLoadAnyComplete, this.onLoadError);
                    break;
                case "ar":
                case "co":
                    LoadController.singleton.addLoadJunk(((("classes/" + game.world.myAvatar.objData.strGender) + "/") + this.itemSelected.sFile), "drop_menu_junk", this.onLoadArmorComplete, this.onLoadError);
                    break;
                case "ho":
                    LoadController.singleton.addLoadJunk((("maps/" + this.itemSelected.sFile.substr(0, -4)) + "_preview.swf"), "drop_menu_junk", this.onLoadHouseComplete, this.onLoadError);
                    break;
                default:
                    if ((((this.itemSelected.sType.toLowerCase() == "item") && (!(this.itemSelected.sLink.toLowerCase() == "none"))) || ((this.itemSelected.sType.toLowerCase() == "item") && (this.itemSelected.sLink.toLowerCase() == "none"))))
                    {
                        this.loadBag();
                    }
                    else
                    {
                        if (this.itemSelected.sES == "am")
                        {
                            this.loadBag(true);
                        }
                        else
                        {
                            if (((this.itemSelected.sType.toLowerCase() == "serveruse") || (this.itemSelected.sType.toLowerCase() == "clientuse")))
                            {
                                this.loadBag();
                            };
                        };
                    };
            };
        }

        public function dropItem(itemObj:Object):void
        {
            var item:Item;
            var drop:Item = new Item(itemObj);
            var has:Boolean;
            for each (item in this.items)
            {
                if (item.ItemID == drop.ItemID)
                {
                    item.iQty = (item.iQty + drop.iQty);
                    has = true;
                };
            };
            if (!has)
            {
                this.items.push(drop);
            };
            Game.root.addUpdate((((('Dropped item: <font color="#ffffff">' + drop.sName) + '</font> (<font color="#ffffff">x') + drop.iQty) + "</font>)"));
            this.buildA();
        }

        public function getDropOrDeny(itemObj:Object):void
        {
            var item:Item;
            for each (item in this.items)
            {
                if (item.ItemID == itemObj.ItemID)
                {
                    this.items.removeAt(this.items.indexOf(item));
                };
            };
            this.buildA();
        }

        private function previewHandler(movieClip:MovieClip):DisplayObject
        {
            var containerWidth:int;
            var containerHeight:int;
            containerWidth = 115;
            containerHeight = 115;
            var scale:Number = (((containerHeight / containerWidth) > (movieClip.height / movieClip.width)) ? (containerWidth / movieClip.width) : (containerHeight / movieClip.height));
            movieClip.scaleX = scale;
            movieClip.scaleY = scale;
            movieClip.x = 0;
            movieClip.y = 0;
            this.preview.content.addChild(movieClip);
            if (this.itemSelected.bUpg)
            {
                this.preview.mcSpecial.visible = false;
                this.preview.mcUpgrade.visible = true;
            }
            else
            {
                this.preview.mcSpecial.visible = false;
                this.preview.mcUpgrade.visible = false;
            };
            this.preview.visible = true;
            resizeMe();
            return (this.preview.content.getChildAt(0));
        }

        private function clearPreview():void
        {
            var child:MovieClip;
            var numChildren:int = this.preview.content.numChildren;
            var i:int = (numChildren - 1);
            while (i >= 0)
            {
                child = MovieClip(this.preview.content.getChildAt(i));
                Game.movieClipStopAll(child);
                this.preview.content.removeChildAt(i);
                i--;
            };
            this.itemSelected = null;
            LoadController.singleton.clearLoader("drop_menu_junk");
        }

        private function loadBag(icon:Boolean=false):void
        {
            this.preview.content.x = 20;
            this.preview.content.y = 0;
            var cls:Class;
            if (((((icon) || (this.itemSelected == null)) || (String(this.itemSelected.sFile).length < 1)) || (Game.root.world.getClass(this.itemSelected.sFile) == null)))
            {
                cls = (Game.root.world.getClass(this.itemSelected.sIcon) as Class);
            }
            else
            {
                if ((((!(this.itemSelected == null)) && (String(this.itemSelected.sFile).length > 0)) && (!(Game.root.world.getClass(this.itemSelected.sFile) == null))))
                {
                    cls = (Game.root.world.getClass(this.itemSelected.sFile) as Class);
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
            this.previewHandler(mc);
            UIController.addGlow(mc);
        }

        private function onLoadWeaponComplete(event:Event):void
        {
            var item:MovieClip = ((LoadController.singleton.applicationDomainJunk.hasDefinition(this.itemSelected.sLink)) ? new (LoadController.singleton.applicationDomainJunk.getDefinition(this.itemSelected.sLink))() : event.target.content);
            this.previewHandler(item);
            UIController.addGlow(item);
        }

        private function onLoadAnyComplete(_arg1:Event):void
        {
            var item:MovieClip;
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(this.itemSelected.sLink))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(this.itemSelected.sLink))();
                switch (this.itemSelected.sES.toLowerCase())
                {
                    case "he":
                        this.preview.content.x = 95;
                        this.preview.content.y = 60;
                        break;
                    case "pe":
                        this.preview.content.x = 140;
                        this.preview.content.y = 95;
                        break;
                };
                this.previewHandler(item);
                UIController.addGlow(item);
            };
        }

        private function onLoadArmorComplete(_arg1:Event):void
        {
            this.preview.content.y = 100;
            var avatarMC:AvatarMC = AvatarUtil.buildAvatarPreview(LoadController.singleton.applicationDomainJunk, this.itemSelected.sLink);
            this.previewHandler(avatarMC);
            avatarMC.scale(3);
            UIController.addGlow(avatarMC.mcChar);
        }

        private function onLoadHouseComplete(event:Event):void
        {
            var item:MovieClip;
            var linkage:* = (this.itemSelected.sFile.substr(0, -4).substr((this.itemSelected.sFile.lastIndexOf("/") + 1)).split("-").join("_") + "_preview");
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(linkage))
            {
                item = new (LoadController.singleton.applicationDomainJunk.getDefinition(linkage))();
                this.previewHandler(item);
                UIController.addGlow(item);
            };
        }

        private function onClickAccept(e:MouseEvent):void
        {
            var movieClip:MovieClip;
            var drop:DFrame2MC;
            var dropStackNumChildren:int = MovieClip(game.ui.dropStack).numChildren;
            var i:int;
            while (i < dropStackNumChildren)
            {
                movieClip = MovieClip(game.ui.dropStack.getChildAt(i));
                if ((movieClip is DFrame2MC))
                {
                    drop = DFrame2MC(movieClip);
                    if (drop.fData.ItemID == this.itemSelected.ItemID)
                    {
                        drop.cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        break;
                    };
                };
                i++;
            };
            this.clearPreview();
        }

        private function onClickDeny(e:MouseEvent):void
        {
            var item:Item;
            var dropStackNumChildren:int;
            var i:int;
            var movieClip:MovieClip;
            var drop:DFrame2MC;
            for each (item in this.items)
            {
                if (item.ItemID == this.itemSelected.ItemID)
                {
                    this.items.removeAt(this.items.indexOf(item));
                };
            };
            dropStackNumChildren = MovieClip(game.ui.dropStack).numChildren;
            i = 0;
            while (i < dropStackNumChildren)
            {
                movieClip = MovieClip(game.ui.dropStack.getChildAt(i));
                if ((movieClip is DFrame2MC))
                {
                    drop = DFrame2MC(movieClip);
                    if (drop.fData.ItemID == this.itemSelected.ItemID)
                    {
                        drop.cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        break;
                    };
                };
                i++;
            };
            this.clearPreview();
        }

        private function onLoadError(ioErrorEvent:IOErrorEvent):void
        {
            this.preview.content.x = 20;
            this.preview.content.y = 0;
            var icon:MovieClip = new (Game.root.world.getClass("iibag"))();
            UIController.addGlow(icon);
            this.previewHandler(icon);
        }


    }
}//package Main.UI

