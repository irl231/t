// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//HouseMenu

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import Main.Model.Item;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import Main.Controller.*;

    public class HouseMenu extends MovieClip 
    {

        public var preview:MovieClip;
        public var fxmask:MovieClip;
        public var btnClose:SimpleButton;
        public var tTitle:MovieClip;
        public var bg:MovieClip;
        public var iListA:MovieClip;
        public var iListB:MovieClip;
        public var hit:MovieClip;
        public var world:World;
        public var rootClass:Game;
        public var CHARS:MovieClip;
        public var fData:Object = null;
        internal var mDown:Boolean = false;
        internal var hRun:int = 0;
        internal var dRun:int = 0;
        internal var mbY:int = 0;
        internal var mhY:int = 0;
        internal var mbD:int = 0;
        internal var ox:int = 0;
        internal var oy:int = 0;
        internal var mox:int = 0;
        internal var moy:int = 0;
        internal var scrTgt:MovieClip;

        public function HouseMenu():void
        {
            this.fOpen("default");
            visible = false;
            var _local1:MovieClip = (this as MovieClip);
            _local1.tTitle.mouseEnabled = false;
            _local1.preview.tPreview.mouseEnabled = false;
            _local1.hit.alpha = 0;
            _local1.hit.buttonMode = true;
        }

        public function fOpen(_arg1:String):void
        {
            var _local2:MovieClip;
            this.rootClass = Game.root;
            this.world = this.rootClass.world;
            this.CHARS = (this.rootClass.world.CHARS as MovieClip);
            _local2 = MovieClip(this.parent).mcHouseItemHandle;
            _local2.visible = false;
            _local2.x = 1000;
            _local2.addEventListener(Event.ENTER_FRAME, this.onHandleEnterFrame, false, 0, true);
            _local2.bCancel.addEventListener(MouseEvent.CLICK, this.onHandleCancelClick, false, 0, true);
            _local2.bDelete.addEventListener(MouseEvent.CLICK, this.onHandleDeleteClick, false, 0, true);
            _local2.frame.addEventListener(MouseEvent.MOUSE_DOWN, this.onHandleMoveClick, false, 0, true);
            _local2.bCancel.buttonMode = true;
            _local2.bDelete.buttonMode = true;
            var _local3:MovieClip = MovieClip(this.rootClass.ui.mcPopup);
            _local3.mcHouseOptions.cnt.bDesign.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsDesignClick, false, 0, true);
            _local3.mcHouseOptions.cnt.bSave.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsSaveClick, false, 0, true);
            _local3.mcHouseOptions.cnt.bHide.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsHideClick, false, 0, true);
            _local3.mcHouseOptions.cnt.bFloor.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsFloorClick, false, 0, true);
            _local3.mcHouseOptions.cnt.bWall.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsWallClick, false, 0, true);
            _local3.mcHouseOptions.cnt.bMisc.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsMiscClick, false, 0, true);
            _local3.mcHouseOptions.cnt.bHouse.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsHouseClick, false, 0, true);
            _local3.mcHouseOptions.bExpand.addEventListener(MouseEvent.CLICK, this.world.onHouseOptionsExpandClick, false, 0, true);
            _local3.mcHouseOptions.cnt.bDesign.buttonMode = true;
            _local3.mcHouseOptions.cnt.bSave.buttonMode = true;
            _local3.mcHouseOptions.cnt.bHide.buttonMode = true;
            _local3.mcHouseOptions.cnt.bFloor.buttonMode = true;
            _local3.mcHouseOptions.cnt.bWall.buttonMode = true;
            _local3.mcHouseOptions.cnt.bMisc.buttonMode = true;
            _local3.mcHouseOptions.cnt.bHouse.buttonMode = true;
            _local3.mcHouseOptions.bExpand.buttonMode = true;
            _local3.mcHouseOptions.cnt.bDesign.ti.mouseEnabled = false;
            var _local4:MovieClip = (this as MovieClip);
            _local4.preview.bAdd.buttonMode = true;
            _local4.preview.t2.mouseEnabled = false;
            _local4.preview.bAdd.addEventListener(MouseEvent.CLICK, this.onItemAddClick, false, 0, true);
            _local4.btnClose.addEventListener(MouseEvent.CLICK, this.btnCloseClick, false, 0, true);
            _local4.bg.addEventListener(MouseEvent.MOUSE_DOWN, this.onHouseMenuBGClick, false, 0, true);
            _local4.bg.addEventListener(Event.ENTER_FRAME, this.onHouseMenuBGEnterFrame, false, 0, true);
            _local4.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.onHouseMenuBGClick, false, 0, true);
            _local4.hit.addEventListener(Event.ENTER_FRAME, this.onHouseMenuBGEnterFrame, false, 0, true);
            this.rootClass.world.showHouseOptions("default");
            if (_arg1.toLowerCase() == "edit")
            {
                this.showEditMenu();
            };
        }

        public function showEditMenu():void
        {
            var _local1:MovieClip = MovieClip(this);
            this.buildHouseMenu();
            _local1.visible = true;
            _local1.y = 315;
            _local1.x = int((480 - (_local1.bg.width / 2)));
            this.rootClass.ui.mcPopup.mcHouseOptions.cnt.bDesign.ti.text = "Done Editing";
        }

        public function hideEditMenu():void
        {
            var _local1:MovieClip;
            _local1 = MovieClip(this);
            _local1.visible = false;
            _local1.x = 1000;
            stage.focus = stage;
            this.rootClass.ui.mcPopup.mcHouseOptions.cnt.bDesign.ti.text = "Edit House";
            this.onHandleCancelClick();
        }

        public function btnCloseClick(_arg1:MouseEvent=null):void
        {
            this.hideEditMenu();
        }

        public function fClose(_arg1:MouseEvent=null):void
        {
            this.hideItemHandle();
            var _local2:MovieClip = MovieClip(this);
            var _local3:MovieClip = MovieClip(this.rootClass.ui.mcPopup);
            var _local4:MovieClip = MovieClip(this.parent).mcHouseItemHandle;
            _local4.removeEventListener(Event.ENTER_FRAME, this.onHandleEnterFrame);
            _local4.bCancel.removeEventListener(MouseEvent.CLICK, this.onHandleCancelClick);
            _local4.bDelete.removeEventListener(MouseEvent.CLICK, this.onHandleDeleteClick);
            _local4.frame.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHandleMoveClick);
            _local3.mcHouseOptions.cnt.bDesign.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsDesignClick);
            _local3.mcHouseOptions.cnt.bSave.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsSaveClick);
            _local3.mcHouseOptions.cnt.bHide.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsHideClick);
            _local3.mcHouseOptions.cnt.bFloor.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsFloorClick);
            _local3.mcHouseOptions.cnt.bWall.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsWallClick);
            _local3.mcHouseOptions.cnt.bMisc.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsMiscClick);
            _local3.mcHouseOptions.cnt.bHouse.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsHouseClick);
            _local3.mcHouseOptions.bExpand.removeEventListener(MouseEvent.CLICK, this.world.onHouseOptionsExpandClick);
            _local2.preview.bAdd.removeEventListener(MouseEvent.CLICK, this.onItemAddClick);
            _local2.btnClose.removeEventListener(MouseEvent.CLICK, this.btnCloseClick);
            _local2.bg.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHouseMenuBGClick);
            _local2.bg.removeEventListener(Event.ENTER_FRAME, this.onHouseMenuBGEnterFrame);
            _local2.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHouseMenuBGClick);
            _local2.hit.removeEventListener(Event.ENTER_FRAME, this.onHouseMenuBGEnterFrame);
            _local2.btnClose.removeEventListener(MouseEvent.CLICK, this.btnCloseClick);
            this.destroyIList(_local2.iListA);
            this.destroyIList(_local2.iListB);
            _local2.visible = false;
            stage.focus = stage;
        }

        public function buildHouseMenu():void
        {
            var category:String;
            var categoryItems:Array;
            var isUnique:Boolean;
            var item:Item;
            var categoryList:Array;
            var existingItem:Item;
            var categoryMap:Object = {};
            for each (item in this.world.myAvatar.houseitems)
            {
                category = item.sType;
                if (!(category in categoryMap))
                {
                    categoryMap[category] = [];
                };
                categoryItems = categoryMap[category];
                isUnique = true;
                for each (existingItem in categoryItems)
                {
                    if (existingItem.ItemID == item.ItemID)
                    {
                        isUnique = false;
                        break;
                    };
                };
                if (isUnique)
                {
                    categoryItems.push(item);
                };
            };
            for (category in categoryMap)
            {
                categoryMap[category].sortOn("sName");
            };
            this.fData = categoryMap;
            categoryList = [];
            for (category in categoryMap)
            {
                categoryList.push(category);
            };
            categoryList.sort(this.rootClass.arraySort);
            this.buildItemList(categoryList, "A", this);
        }

        public function buildItemList(categoryList:Array, _type:String, target:MovieClip):void
        {
            var listContainer:MovieClip;
            var listItem:MovieClip;
            var maxWidth:int = 90;
            this.preview.cnt.visible = false;
            this.preview.t2.visible = false;
            this.preview.bAdd.visible = false;
            this.preview.tPreview.visible = false;
            if (_type == "A")
            {
                this.iListB.visible = false;
                listContainer = this.iListA;
            }
            else
            {
                if (_type == "B")
                {
                    this.iListB.visible = true;
                    listContainer = this.iListB;
                }
                else
                {
                    return;
                };
            };
            this.destroyIList(listContainer);
            listContainer.par = target;
            var i:int;
            while (i < categoryList.length)
            {
                listItem = listContainer.iList.addChild(new hProto());
                listItem.ti.autoSize = "left";
                listItem.ti.text = ((_type == "A") ? String(categoryList[i]) : String(categoryList[i].sName));
                maxWidth = Math.max(maxWidth, int(listItem.ti.textWidth));
                listItem.hit.alpha = 0;
                listItem.typ = _type;
                listItem.val = categoryList[i];
                listItem.iSel = false;
                listItem.addEventListener(MouseEvent.CLICK, this.onHouseMenuItemClick, false, 0, true);
                listItem.addEventListener(MouseEvent.MOUSE_OVER, this.onHouseMenuItemMouseOver, false, 0, true);
                listItem.y = (listContainer.iList.iproto.y + (i * 16));
                listItem.bg.visible = ((_type == "B") && (listItem.val.bEquip == 1));
                listItem.buttonMode = true;
                i++;
            };
            listContainer.iList.iproto.visible = false;
            listContainer.iList.y = ((listContainer.imask.height / 2) - (listContainer.iList.height / 2));
            if (_type == "B")
            {
                listContainer.x = ((listContainer.par.x + listContainer.par.width) + 1);
            };
            maxWidth = (maxWidth + 7);
            i = 1;
            while (i < listContainer.iList.numChildren)
            {
                listItem = (listContainer.iList.getChildAt(i) as MovieClip);
                listItem.bg.width = maxWidth;
                listItem.hit.width = maxWidth;
                i++;
            };
            var scrollbar:MovieClip = listContainer.scr;
            var mask:MovieClip = listContainer.imask;
            var itemList:MovieClip = listContainer.iList;
            scrollbar.h.y = 0;
            scrollbar.visible = false;
            scrollbar.hit.alpha = 0;
            scrollbar.mDown = false;
            if (itemList.height > scrollbar.b.height)
            {
                scrollbar.h.height = int(((scrollbar.b.height / itemList.height) * scrollbar.b.height));
                this.hRun = (scrollbar.b.height - scrollbar.h.height);
                this.dRun = ((itemList.height - scrollbar.b.height) + 10);
                itemList.oy = (itemList.y = mask.y);
                scrollbar.visible = true;
                scrollbar.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                scrollbar.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                itemList.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
            }
            else
            {
                scrollbar.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.scrDown);
                scrollbar.h.removeEventListener(Event.ENTER_FRAME, this.hEF);
                itemList.removeEventListener(Event.ENTER_FRAME, this.dEF);
            };
            listContainer.imask.width = (maxWidth - 1);
            listContainer.divider.x = maxWidth;
            listContainer.scr.x = maxWidth;
            listContainer.w = (maxWidth + ((listContainer.scr.visible) ? listContainer.scr.width : 1));
            this.resizeMe();
        }

        private function destroyIList(target:MovieClip):void
        {
            var child:MovieClip;
            while (target.iList.numChildren > 1)
            {
                child = target.iList.getChildAt(1);
                child.removeEventListener(MouseEvent.CLICK, this.onHouseMenuItemClick);
                child.removeEventListener(MouseEvent.MOUSE_OVER, this.onHouseMenuItemMouseOver);
                delete child.val;
                target.iList.removeChildAt(1);
            };
            target.scr.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.scrDown);
            target.scr.h.removeEventListener(Event.ENTER_FRAME, this.hEF);
            target.iList.removeEventListener(Event.ENTER_FRAME, this.dEF);
        }

        public function onHouseMenuItemClick(event:MouseEvent):void
        {
            var index:int;
            var childMC:MovieClip;
            var targetMC:MovieClip = (event.currentTarget as MovieClip);
            var parentMC:MovieClip = (targetMC.parent as MovieClip);
            if (targetMC.typ == "A")
            {
                index = 0;
                while (index < parentMC.numChildren)
                {
                    MovieClip(parentMC.getChildAt(index)).bg.visible = false;
                    index++;
                };
                targetMC.bg.visible = true;
                this.buildItemList(this.fData[targetMC.val], "B", parentMC);
            }
            else
            {
                if (targetMC.typ == "B")
                {
                    index = 1;
                    while (index < parentMC.numChildren)
                    {
                        childMC = (parentMC.getChildAt(index) as MovieClip);
                        childMC.iSel = false;
                        index++;
                    };
                    targetMC.iSel = true;
                    this.refreshIListB();
                    this.world.loadHouseItemB(targetMC.val);
                    this.resizeMe();
                };
            };
        }

        public function onHouseMenuItemMouseOver(_arg1:MouseEvent):void
        {
            var _local3:MovieClip;
            var _local2:MovieClip = MovieClip(_arg1.currentTarget);
            var _local4:int = 1;
            while (_local4 < _local2.parent.numChildren)
            {
                _local3 = MovieClip(_local2.parent.getChildAt(_local4));
                if (_local3.bg.alpha < 0.4)
                {
                    _local3.bg.visible = false;
                };
                _local4++;
            };
            if (!_local2.bg.visible)
            {
                _local2.bg.visible = true;
                _local2.bg.alpha = 0.33;
            };
        }

        private function refreshIListB():void
        {
            var _local3:MovieClip;
            var _local1:MovieClip = MovieClip(this).iListB.iList;
            var _local2:int = 1;
            while (_local2 < _local1.numChildren)
            {
                _local3 = (_local1.getChildAt(_local2) as MovieClip);
                if (_local3.val != null)
                {
                    _local3.bg.visible = false;
                    if (_local3.iSel)
                    {
                        _local3.bg.visible = true;
                        _local3.bg.alpha = 0.5;
                    };
                    if (int(_local3.val.bEquip) == 1)
                    {
                        _local3.bg.visible = true;
                        _local3.bg.alpha = 1;
                    };
                };
                _local2++;
            };
        }

        public function onItemAddClick(_arg1:MouseEvent):void
        {
            var _local3:int;
            var _local2:Object = MovieClip(_arg1.currentTarget.parent).item;
            if (int(_local2.bEquip) != 1)
            {
                if (((_local2.bUpg == 1) && (!(this.rootClass.world.myAvatar.isUpgraded()))))
                {
                    this.rootClass.showUpgradeWindow();
                }
                else
                {
                    if (_local2.sType == "House")
                    {
                        this.world.equipHouse(_local2);
                    }
                    else
                    {
                        _local2.bEquip = 1;
                        this.refreshIListB();
                        _local3 = ((_local2.sType.toLowerCase().indexOf("wall") > -1) ? 150 : 300);
                        this.world.loadHouseItem(_local2, 480, _local3);
                    };
                };
            };
        }

        public function previewHouseItem(_arg1:Object):void
        {
            var _local2:String;
            if (_arg1.item.sType == "House")
            {
                _local2 = (_arg1.item.sFile.substr(0, -4).substr((_arg1.item.sFile.lastIndexOf("/") + 1)).split("-").join("_") + "_preview");
            }
            else
            {
                _local2 = _arg1.item.sLink;
            };
            var _local3:Class = (LoadController.singleton.applicationDomainMap.getDefinition(_local2) as Class);
            var _local4:MovieClip = (MovieClip(this).preview.cnt as MovieClip);
            if (_local4.numChildren > 0)
            {
                _local4.removeChildAt(0);
            };
            var _local5:MovieClip = (_local4.addChild(new (_local3)()) as MovieClip);
            var _local6:* = (130 / _local5.width);
            if (_local5.height > _local5.width)
            {
                _local6 = (113 / _local5.height);
            };
            _local5.scaleX = _local6;
            _local5.scaleY = _local6;
            _local5.x = (130 / 2);
            _local5.y = ((113 / 2) + (_local5.height / 2));
            _local5.ItemID = _arg1.item.ItemID;
            MovieClip(this).preview.item = _arg1.item;
            MovieClip(this).preview.bAdd.visible = true;
            MovieClip(this).preview.tPreview.visible = true;
            MovieClip(this).preview.t2.visible = false;
            MovieClip(this).preview.cnt.visible = true;
        }

        public function resizeMe():*
        {
            var _local1:MovieClip = MovieClip(this);
            if (_local1.iListA.visible)
            {
                _local1.bg.width = ((_local1.iListA.x + _local1.iListA.w) + 5);
            };
            if (_local1.iListB.visible)
            {
                _local1.iListB.x = ((_local1.iListA.x + _local1.iListA.w) + 1);
                _local1.bg.width = (_local1.bg.width + (_local1.iListB.w + 1));
                _local1.iListA.divider.visible = (!(_local1.iListA.scr.visible));
            }
            else
            {
                _local1.iListA.divider.visible = false;
            };
            if (((_local1.preview.t2.visible) || (_local1.preview.cnt.visible)))
            {
                _local1.preview.x = ((_local1.iListB.x + _local1.iListB.w) + 4);
                _local1.bg.width = (_local1.bg.width + (_local1.preview.width + 4));
                _local1.iListB.divider.visible = (!(_local1.iListB.scr.visible));
            }
            else
            {
                _local1.iListB.divider.visible = false;
            };
            var _local2:* = ((((_local1.tTitle.x + this.tTitle.width) + 4) + _local1.btnClose.width) + 4);
            if (_local1.bg.width < _local2)
            {
                _local1.bg.width = _local2;
            };
            _local1.btnClose.x = (_local1.bg.width - 19);
            _local1.fxmask.width = _local1.bg.width;
            if (_local1.x < 0)
            {
                _local1.x = 0;
            };
            if ((_local1.x + _local1.bg.width) > 960)
            {
                _local1.x = (960 - _local1.bg.width);
            };
            if (_local1.y < 0)
            {
                _local1.y = 0;
            };
            if ((_local1.y + _local1.bg.height) > 495)
            {
                _local1.y = (495 - _local1.bg.height);
            };
        }

        public function scrDown(_arg1:MouseEvent):*
        {
            this.mbY = int(mouseY);
            this.mhY = int(MovieClip(_arg1.currentTarget.parent).h.y);
            this.scrTgt = MovieClip(_arg1.currentTarget.parent);
            this.scrTgt.mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.scrUp, false, 0, true);
        }

        public function scrUp(_arg1:MouseEvent):*
        {
            this.scrTgt.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.scrUp);
        }

        public function hEF(_arg1:Event):*
        {
            var _local2:*;
            if (MovieClip(_arg1.currentTarget.parent).mDown)
            {
                _local2 = MovieClip(_arg1.currentTarget.parent);
                this.mbD = (int(mouseY) - this.mbY);
                _local2.h.y = (this.mhY + this.mbD);
                if ((_local2.h.y + _local2.h.height) > _local2.b.height)
                {
                    _local2.h.y = int((_local2.b.height - _local2.h.height));
                };
                if (_local2.h.y < 0)
                {
                    _local2.h.y = 0;
                };
            };
        }

        public function dEF(_arg1:Event):*
        {
            var _local2:* = MovieClip(_arg1.currentTarget.parent).scr;
            var _local3:* = MovieClip(_arg1.currentTarget);
            var _local4:* = (-(_local2.h.y) / this.hRun);
            var _local5:* = (int((_local4 * this.dRun)) + _local3.oy);
            if (Math.abs((_local5 - _local3.y)) > 0.2)
            {
                _local3.y = (_local3.y + ((_local5 - _local3.y) / 4));
            }
            else
            {
                _local3.y = _local5;
            };
        }

        public function drawItemHandle(_arg1:MovieClip):void
        {
            var _local2:int = Math.ceil(_arg1.width);
            var _local3:int = Math.ceil(_arg1.height);
            var _local4:MovieClip = (MovieClip(this.parent).mcHouseItemHandle as MovieClip);
            _local4.visible = true;
            var _local5:Rectangle = _arg1.getBounds(stage);
            _local4.frame.width = ((_local2 > 100) ? _local2 : 100);
            _local4.frame.height = ((_local3 > 50) ? _local3 : 50);
            _local4.x = int((_arg1.x - (_local4.frame.width / 2)));
            _local4.y = int(_local5.y);
            if (_local4.tgt != null)
            {
                _local4.tgt.filters = [];
            };
            _local4.tgt = _arg1;
            _local4.tgt.filters = [new GlowFilter(0xFFFFFF, 1, 8, 8, 2, 2)];
        }

        public function hideItemHandle():void
        {
            var _local1:MovieClip = (MovieClip(this.parent).mcHouseItemHandle as MovieClip);
            _local1.visible = false;
            _local1.x = 1000;
            if (_local1.tgt != null)
            {
                _local1.tgt.filters = [];
            };
            _local1.tgt = null;
        }

        public function onHandleMoveClick(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = this.rootClass.ui.mcPopup.mcHouseItemHandle;
            _local2.mDown = true;
            _local2.ox = _local2.x;
            _local2.oy = _local2.y;
            _local2.mox = stage.mouseX;
            _local2.moy = stage.mouseY;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onHandleMoveRelease, false, 0, true);
        }

        public function onHandleMoveRelease(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = this.rootClass.ui.mcPopup.mcHouseItemHandle;
            _local2.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onHandleMoveRelease);
            this.world.houseItemValidate(MovieClip(_local2.tgt));
        }

        public function onHandleDeleteClick(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = this.rootClass.ui.mcPopup.mcHouseItemHandle;
            var _local3:MovieClip = _local2.tgt;
            _local3.item.bEquip = 0;
            this.refreshIListB();
            delete _local3.item;
            delete _local3.ItemID;
            _local3.removeEventListener(Event.ENTER_FRAME, this.world.onHouseItemEnterFrame);
            _local3.parent.removeChild(_local3);
            this.hideItemHandle();
        }

        public function onHandleCancelClick(_arg1:MouseEvent=null):void
        {
            var _local2:MovieClip = this.rootClass.ui.mcPopup.mcHouseItemHandle;
            if (_local2.tgt != null)
            {
                _local2.tgt.filters = [];
            };
            _local2.tgt = null;
            _local2.x = 1000;
            _local2.visible = false;
        }

        public function onHandleEnterFrame(_arg1:Event):*
        {
            var _local2:MovieClip = (_arg1.currentTarget as MovieClip);
            if (_local2.visible)
            {
                _local2.bCancel.x = ((_local2.frame.width - _local2.bCancel.width) - 4);
                _local2.bDelete.x = ((_local2.bCancel.x - _local2.bDelete.width) - 4);
                if (_local2.mDown)
                {
                    _local2.x = (_local2.ox + (stage.mouseX - _local2.mox));
                    _local2.y = (_local2.oy + (stage.mouseY - _local2.moy));
                    if ((_local2.x + (_local2.frame.width / 2)) < 0)
                    {
                        _local2.x = -(int((_local2.frame.width / 2)));
                    };
                    if ((_local2.x + (_local2.frame.width / 2)) > 960)
                    {
                        _local2.x = int((960 - (_local2.frame.width / 2)));
                    };
                    if ((_local2.y + (_local2.frame.height / 2)) < 0)
                    {
                        _local2.y = -(int((_local2.frame.height / 2)));
                    };
                    if ((_local2.y + (_local2.frame.height / 2)) > 495)
                    {
                        _local2.y = int((495 - (_local2.frame.height / 2)));
                    };
                    _local2.tgt.x = Math.ceil((_local2.x + (_local2.frame.width / 2)));
                    _local2.tgt.y = Math.ceil((_local2.y - (_local2.tgt.getBounds(stage).y - _local2.tgt.y)));
                };
            };
        }

        public function onHouseMenuBGClick(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = MovieClip(this);
            _local2.mDown = true;
            _local2.ox = _local2.x;
            _local2.oy = _local2.y;
            _local2.mox = stage.mouseX;
            _local2.moy = stage.mouseY;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onHouseMenuBGRelease, false, 0, true);
        }

        public function onHouseMenuBGRelease(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = MovieClip(this);
            _local2.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onHouseMenuBGRelease);
        }

        public function onHouseMenuBGEnterFrame(_arg1:Event):*
        {
            var _local2:MovieClip = (_arg1.currentTarget.parent as MovieClip);
            if (_local2.visible)
            {
                if (_local2.mDown)
                {
                    _local2.x = (_local2.ox + (stage.mouseX - _local2.mox));
                    _local2.y = (_local2.oy + (stage.mouseY - _local2.moy));
                    if (_local2.x < 0)
                    {
                        _local2.x = 0;
                    };
                    if ((_local2.x + _local2.bg.width) > 960)
                    {
                        _local2.x = (960 - _local2.bg.width);
                    };
                    if (_local2.y < 0)
                    {
                        _local2.y = 0;
                    };
                    if ((_local2.y + _local2.bg.height) > 495)
                    {
                        _local2.y = (495 - _local2.bg.height);
                    };
                };
            };
        }


    }
}//package 

