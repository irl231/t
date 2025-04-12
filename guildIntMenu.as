// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//guildIntMenu

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class guildIntMenu extends MovieClip 
    {

        public var preview:MovieClip;
        public var fxmask:MovieClip;
        public var btnClose:SimpleButton;
        public var tTitle:MovieClip;
        public var bg:MovieClip;
        public var iListA:MovieClip;
        public var iListB:MovieClip;
        public var hit:MovieClip;
        private var rootClass:Game;
        private var floorItems:Array = new Array();
        private var wallItems:Array = new Array();
        private var guildItems:Array = new Array();
        private var Parent:MovieClip;
        private var items:Array;
        private var classes:Object = new Object();
        private var curLink:String;
        private var curID:int;
        private var itemLoader:GuildLoader;
        private var mDown:Boolean = false;
        private var mcTarget:MovieClip;
        private var roomInt:Interior;
        private var guildRoot:MovieClip;
        private var Offset:Point;
        private var prevTarget:MovieClip;
        private var bDelete:MovieClip;
        private var scr:sBar;

        public function guildIntMenu(_arg_1:MovieClip, _arg_2:MovieClip, _arg_3:MovieClip, _arg_4:Interior)
        {
            var _local_5:uint;
            super();
            this.rootClass = _arg_1;
            this.name = "guildHouseList";
            var existingChild:MovieClip = (this.rootClass.ui.getChildByName(this.name) as MovieClip);
            if (existingChild != null)
            {
                this.rootClass.ui.removeChild(existingChild);
                return;
            };
            this.Parent = _arg_2;
            this.roomInt = _arg_4;
            this.guildRoot = _arg_3;
            this.iListB.visible = false;
            this.preview.visible = false;
            this.iListA.scr.visible = false;
            this.resize();
            this.buildItemLists();
            this.tTitle.mouseEnabled = false;
            this.x = 200;
            this.y = 200;
            this.hit.buttonMode = true;
            this.preview.bAdd.buttonMode = true;
            this.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.onHitDown, false, 0, true);
            this.rootClass.addEventListener(MouseEvent.MOUSE_UP, this.onHitUp, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.preview.bAdd.addEventListener(MouseEvent.CLICK, this.onAddClick, false, 0, true);
            this.addEventListener(Event.ENTER_FRAME, this.onEnter, false, 0, true);
            this.hit.alpha = 0;
            this.rootClass.ui.addChild(this);
            this.bDelete = (new btnDelete() as MovieClip);
            while (_local_5 < this.guildRoot.MCs.length)
            {
                this.guildRoot.MCs[_local_5].addEventListener(MouseEvent.MOUSE_DOWN, this.onHitDown, false, 0, true);
                this.guildRoot.MCs[_local_5].addEventListener(MouseEvent.MOUSE_UP, this.onHitUp, false, 0, true);
                _local_5++;
            };
            this.bDelete.addEventListener(MouseEvent.CLICK, this.onDeleteClick, false, 0, true);
        }

        public function Destroy():void
        {
            var _local_1:uint;
            if (this.rootClass.ui.getChildByName("guildHouseList") != null)
            {
                this.rootClass.ui.removeChild(this);
                if (this.prevTarget != null)
                {
                    this.prevTarget.removeChild(this.bDelete);
                };
                while (_local_1 < this.guildRoot.MCs.length)
                {
                    this.guildRoot.MCs[_local_1].removeEventListener(MouseEvent.MOUSE_DOWN, this.onHitDown);
                    this.guildRoot.MCs[_local_1].removeEventListener(MouseEvent.MOUSE_UP, this.onHitUp);
                    _local_1++;
                };
            };
        }

        private function buildItemLists():void
        {
            var _local_1:Object;
            var _local_2:MovieClip;
            var _local_3:uint;
            while (_local_3 < this.rootClass.world.myAvatar.houseitems.length)
            {
                _local_1 = this.rootClass.world.myAvatar.houseitems[_local_3];
                switch (_local_1.sType)
                {
                    case "Wall Item":
                        this.wallItems.push(_local_1);
                        break;
                    case "Floor Item":
                        this.floorItems.push(_local_1);
                        break;
                    case "Guild":
                        this.guildItems.push(_local_1);
                        break;
                };
                _local_3++;
            };
            this.iListA.iList.removeChildAt(0);
            if (this.floorItems.length > 0)
            {
                _local_2 = (new hProto() as MovieClip);
                _local_2.name = "Floor";
                _local_2.ti.text = "Floor Items";
                _local_2.ti.autoSize = "left";
                _local_2.hit.alpha = 0;
                _local_2.bg.alpha = 0;
                _local_2.addEventListener(MouseEvent.CLICK, this.onListAClick, false, 0, true);
                this.iListA.iList.addChild(_local_2);
            };
            if (this.wallItems.length > 0)
            {
                _local_2 = (new hProto() as MovieClip);
                _local_2.name = "Wall";
                _local_2.ti.autoSize = "left";
                _local_2.ti.text = "Wall Items";
                _local_2.hit.alpha = 0;
                _local_2.bg.alpha = 0;
                _local_2.y = (_local_2.height - 4);
                _local_2.addEventListener(MouseEvent.CLICK, this.onListAClick, false, 0, true);
                this.iListA.iList.addChild(_local_2);
            };
            if (this.guildItems.length > 0)
            {
                _local_2 = (new hProto() as MovieClip);
                _local_2.name = "Guild";
                _local_2.ti.autoSize = "left";
                _local_2.ti.text = "Guild Items";
                _local_2.hit.alpha = 0;
                _local_2.bg.alpha = 0;
                _local_2.y = (_local_2.height + 10);
                _local_2.addEventListener(MouseEvent.CLICK, this.onListAClick, false, 0, true);
                this.iListA.iList.addChild(_local_2);
            };
            this.iListA.iList.y = ((this.iListA.imask.y + (this.iListA.imask.height >> 1)) - (this.iListA.iList.height >> 1));
            this.iListA.iList.buttonMode = true;
        }

        private function resize():void
        {
            if (this.preview.visible)
            {
                this.preview.x = this.bg.width;
                this.bg.width = (((this.iListA.width + this.iListB.width) + this.preview.width) + 5);
            }
            else
            {
                if (this.iListB.visible)
                {
                    this.bg.width = (this.iListA.width + this.iListB.width);
                }
                else
                {
                    this.bg.width = ((this.iListA.x + this.iListA.width) + 5);
                };
            };
            this.btnClose.x = (this.bg.width - 19);
            this.fxmask.width = this.bg.width;
        }

        private function onHitDown(_arg_1:MouseEvent):void
        {
            this.mDown = true;
            this.mcTarget = MovieClip(_arg_1.currentTarget);
            if (this.mcTarget == null)
            {
                return;
            };
            if (this.mcTarget == this.hit)
            {
                this.mcTarget = this;
            }
            else
            {
                if (this.mcTarget.name.indexOf("instance") < 0)
                {
                    if (this.prevTarget == null)
                    {
                        this.prevTarget = this.mcTarget;
                        this.mcTarget.addChild(this.bDelete);
                    }
                    else
                    {
                        if (this.prevTarget != this.mcTarget)
                        {
                            this.prevTarget.removeChild(this.bDelete);
                            this.prevTarget = this.mcTarget;
                            this.mcTarget.addChild(this.bDelete);
                        };
                    };
                };
            };
            this.Offset = new Point((this.rootClass.mouseX - this.mcTarget.x), (this.rootClass.mouseY - this.mcTarget.y));
        }

        private function onHitUp(_arg_1:MouseEvent):void
        {
            this.mDown = false;
            if (((!(this.mcTarget == this.hit)) && (!(this.mcTarget == null))))
            {
                if (this.mcTarget.name.indexOf("instance") < 0)
                {
                    this.roomInt.updateItem(this.rootClass.world.map.currentLabel, new Point(this.mcTarget.x, this.mcTarget.y), this.mcTarget.name);
                };
                if (((!(this.guildRoot.ItemData[this.mcTarget.name] == null)) && ((!(this.guildRoot.ItemData[this.mcTarget.name].sMeta == null)) && (this.guildRoot.ItemData[this.mcTarget.name].sMeta.indexOf("NPC") > -1))))
                {
                    if (this.mcTarget.x > 480)
                    {
                        if (this.mcTarget.scaleX > 0)
                        {
                            this.mcTarget.scaleX = (this.mcTarget.scaleX * -1);
                        };
                    }
                    else
                    {
                        if (this.mcTarget.scaleX < 0)
                        {
                            this.mcTarget.scaleX = (this.mcTarget.scaleX * -1);
                        };
                    };
                };
            };
            this.mcTarget = null;
        }

        private function onEnter(_arg_1:Event):void
        {
            if (((!(this.mcTarget == null)) && (this.mDown)))
            {
                this.mcTarget.x = (this.rootClass.mouseX - this.Offset.x);
                this.mcTarget.y = (this.rootClass.mouseY - this.Offset.y);
            };
        }

        private function onCloseClick(_arg_1:MouseEvent):void
        {
            this.Destroy();
            this.Parent.closeInt();
        }

        private function onDeleteClick(_arg_1:MouseEvent):void
        {
            var _local_2:uint;
            while (_local_2 < this.guildRoot.MCs.length)
            {
                if (this.guildRoot.MCs[_local_2] == this.prevTarget)
                {
                    this.guildRoot.MCs.splice(_local_2, 1);
                };
                _local_2++;
            };
            this.rootClass.world.CHARS.removeChild(this.prevTarget);
            this.prevTarget.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHitDown);
            this.prevTarget.removeEventListener(MouseEvent.MOUSE_UP, this.onHitUp);
            this.roomInt.removeItem(this.rootClass.world.map.currentLabel, this.prevTarget.name);
            this.prevTarget = null;
        }

        private function onAddClick(_arg_1:MouseEvent):void
        {
            var _local_2:MovieClip;
            var _local_3:*;
            if (((!(this.roomInt.checkItemID(int(this.curID)))) && (this.roomInt.getItemCount(this.rootClass.world.map.currentLabel) < 10)))
            {
                _local_2 = (new (this.classes[String(this.curID)])() as MovieClip);
                _local_2.x = 400;
                _local_2.y = 200;
                _local_2.name = String(this.curID);
                _local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onHitDown, false, 0, true);
                this.rootClass.world.CHARS.addChild(_local_2);
                this.guildRoot.MCs.push(_local_2);
                _local_3 = this.getItemByID(this.curID);
                if (((!(_local_3.sMeta == null)) && (_local_3.sMeta.indexOf("NPC") > -1)))
                {
                    _local_2.scaleX = (_local_2.scaleY = 0.2);
                };
                _local_2.scaleX = (_local_2.scaleX * this.rootClass.world.Scale);
                _local_2.scaleY = (_local_2.scaleY * this.rootClass.world.Scale);
                this.roomInt.addNewItem(this.rootClass.world.map.currentLabel, new Point(_local_2.x, _local_2.y), _local_3, this.classes[String(this.curID)]);
            }
            else
            {
                this.rootClass.MsgBox.notify("You already added this item in this hall!");
            };
        }

        private function onListAClick(_arg_1:MouseEvent):void
        {
            var _local_2:uint;
            var _local_3:MovieClip;
            if (this.scr != null)
            {
                this.scr.Destroy();
                this.scr = null;
            };
            if (this.preview.cnt.numChildren > 0)
            {
                this.preview.cnt.removeChildAt(0);
            };
            this.preview.visible = false;
            this.iListB.visible = true;
            var _local_4:int = this.iListB.iList.numChildren;
            _local_2 = 0;
            while (_local_2 < _local_4)
            {
                this.iListB.iList.removeChildAt(0);
                _local_2++;
            };
            switch (_arg_1.currentTarget.name)
            {
                case "Floor":
                    this.items = this.floorItems;
                    break;
                case "Wall":
                    this.items = this.wallItems;
                    break;
                case "Guild":
                    this.items = this.guildItems;
                    break;
            };
            _local_2 = 0;
            while (_local_2 < this.items.length)
            {
                _local_3 = (new hProto() as MovieClip);
                _local_3.ti.text = this.items[_local_2].sName;
                _local_3.ti.autoSize = "left";
                _local_3.y = (_local_3.height * _local_2);
                _local_3.hit.alpha = 0;
                _local_3.bg.alpha = 0;
                _local_3.name = String(_local_2);
                _local_3.addEventListener(MouseEvent.CLICK, this.onListBClick, false, 0, true);
                this.iListB.iList.addChild(_local_3);
                this.iListB.iList.buttonMode = true;
                _local_2++;
            };
            this.iListB.scr.x = (this.iListB.width - (this.iListB.scr.width + 1));
            this.iListB.divider.x = (this.iListB.scr.x + this.iListB.scr.width);
            this.resize();
            if (this.iListB.iList.height > this.iListB.imask.height)
            {
                this.iListB.iList.y = this.iListB.imask.y;
                this.iListB.scr.visible = true;
                this.scr = new sBar(this.iListB.scr, this.iListB.imask, this.rootClass);
            }
            else
            {
                this.iListB.scr.visible = false;
                this.iListB.iList.y = ((this.iListB.imask.y + (this.iListB.imask.height >> 1)) - (this.iListB.iList.height >> 1));
            };
            this.iListB.imask.width = 150;
        }

        private function onListBClick(_arg_1:MouseEvent):void
        {
            if (this.preview.cnt.numChildren > 0)
            {
                this.preview.cnt.removeChildAt(0);
            };
            this.preview.visible = false;
            this.resize();
            var _local_2:* = this.items[int(_arg_1.currentTarget.name)];
            if (this.classes[String(_local_2.ItemID)] != null)
            {
                this.preview.visible = true;
                if (this.preview.cnt.numChildren > 0)
                {
                    this.preview.cnt.removeChildAt(0);
                };
                this.resize();
                this.attachPreview((new (this.classes[String(_local_2.ItemID)])() as MovieClip));
            }
            else
            {
                this.curLink = _local_2.sLink;
                this.curID = int(_local_2.ItemID);
                if (((!(_local_2.sMeta == null)) && (_local_2.sMeta.indexOf("NPC") > -1)))
                {
                    this.itemLoader = new GuildLoader(this.onItemLoadComplete, _local_2.sFile, this.rootClass, (_local_2.sLink + "_NPC"), _local_2.ItemID);
                }
                else
                {
                    this.itemLoader = new GuildLoader(this.onItemLoadComplete, _local_2.sFile, this.rootClass, _local_2.sLink, _local_2.ItemID);
                };
                this.preview.visible = true;
                this.preview.t2.visible = true;
                this.resize();
            };
        }

        private function onItemLoadComplete(_arg_1:GuildLoader):void
        {
            this.classes[String(_arg_1.ID)] = _arg_1.swfClass;
            try
            {
                if (this.guildRoot.ItemData[String(_arg_1.ID)].sMeta.indexOf("NPC") > -1)
                {
                    this.guildRoot.ItemData[String(_arg_1.ID)].aClass = _arg_1.getClass((this.guildRoot.ItemData[String(_arg_1.ID)].sLink + "_APOP"));
                };
            }
            catch(e)
            {
            };
            this.attachPreview(MovieClip(new _arg_1.swfClass()));
        }

        private function attachPreview(_arg_1:MovieClip):*
        {
            var _local_2:* = (130 / _arg_1.width);
            if (_arg_1.height > _arg_1.width)
            {
                _local_2 = (113 / _arg_1.height);
            };
            _arg_1.scaleX = _local_2;
            _arg_1.scaleY = _local_2;
            _arg_1.x = 65;
            _arg_1.y = (56.5 + (_arg_1.height >> 1));
            this.preview.cnt.addChild(_arg_1);
            this.preview.t2.visible = false;
        }

        private function getItemByID(_arg_1:int):Object
        {
            var _local_2:int;
            while (_local_2 < this.rootClass.world.myAvatar.houseitems.length)
            {
                if (this.rootClass.world.myAvatar.houseitems[_local_2].ItemID == _arg_1)
                {
                    return (this.rootClass.world.myAvatar.houseitems[_local_2]);
                };
                _local_2++;
            };
            return (null);
        }


    }
}//package 

