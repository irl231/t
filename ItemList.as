// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//ItemList

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import Main.*;

    public class ItemList extends MovieClip 
    {

        public var mcSort:MovieClip;
        public var btnUp:SimpleButton;
        public var btnDown:SimpleButton;
        public var mcScrollBar:MovieClip;
        public var inventorySlot:Number = 100;
        private var intSelected:Number = -1;
        private var intPlacement:Number = 0;
        private var itemList:Vector.<Item> = new Vector.<Item>();
        private var sortedList:Array;
        private var strSortBy:String = "all";

        public function ItemList()
        {
            var inventoryItem:InventoryItem;
            super();
            this.mcSort.visible = false;
            this.mcScrollBar.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler, false, 0, true);
            this.btnUp.addEventListener(MouseEvent.CLICK, this.onBtnClickHandler, false, 0, true);
            this.btnDown.addEventListener(MouseEvent.CLICK, this.onBtnClickHandler, false, 0, true);
            var i:int;
            while (i < 10)
            {
                inventoryItem = new InventoryItem();
                inventoryItem.name = ("mcInventoryItem" + i);
                inventoryItem.y = (22 * i);
                inventoryItem.strIndex.text = "";
                inventoryItem.strName.text = "";
                inventoryItem.strLevel.text = "";
                inventoryItem.intIndex = -1;
                this.addChild(inventoryItem);
                i++;
            };
            this.mcSort.btnAll.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
            this.mcSort.btnArmor.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
            this.mcSort.btnWeapon.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
            this.mcSort.btnHelm.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
            this.mcSort.btnBack.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
            this.mcSort.btnPet.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
            this.mcSort.btnItem.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
            this.mcSort.btnDesign.addEventListener(MouseEvent.CLICK, this.onSortClick, false, 0, true);
        }

        public function get selectedItem():Item
        {
            if (this.itemList == null)
            {
                return (null);
            };
            return (this.sortedList[this.intSelected]);
        }

        private function get intScrollCount():Number
        {
            return (this.inventorySlot - 10);
        }

        public function sort():void
        {
            this.sortBy(this.strSortBy);
        }

        public function sortBy(_arg1:String):void
        {
            var _local4:Object;
            var _local3:int;
            this.strSortBy = _arg1.toLowerCase();
            var _local2:Array = [];
            while (_local3 < this.itemList.length)
            {
                _local4 = this.itemList[_local3];
                switch (_arg1.toLowerCase())
                {
                    case "all":
                        _local2.push(_local4);
                        break;
                    case "armor":
                        if (((_local4.sES == "ar") || (_local4.sES == "co")))
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "weapon":
                        if (_local4.sES == "Weapon")
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "helm":
                        if (_local4.sES == "he")
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "back":
                        if (_local4.sES == "ba")
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "pet":
                        if (_local4.sES == "pe")
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "item":
                        if (_local4.sES == "None")
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "design":
                        if ((((!(_local4.sES == "co")) && (!(_local4.sES == "None"))) && (!(_local4.EnhID > 0))))
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "nonac":
                        if (_local4.bCoins == 0)
                        {
                            _local2.push(_local4);
                        };
                        break;
                    case "ac":
                        if (_local4.bCoins == 1)
                        {
                            _local2.push(_local4);
                        };
                        break;
                    default:
                        _local2.push(_local4);
                };
                _local3++;
            };
            this.inventorySlot = _local2.length;
            this.sortedList = _local2;
            this.reset();
        }

        public function sortByd(sortCriteria:String):void
        {
            var item:Object;
            var lowerCaseSortCriteria:String = sortCriteria.toLowerCase();
            this.sortedList = [];
            var i:int;
            while (i < this.itemList.length)
            {
                item = this.itemList[i];
                switch (lowerCaseSortCriteria)
                {
                    case "all":
                        this.sortedList.push(item);
                        break;
                    case "armor":
                        if (((item.sES == "ar") || (item.sES == "co")))
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "weapon":
                        if (item.sES == "Weapon")
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "helm":
                        if (item.sES == "he")
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "back":
                        if (item.sES == "ba")
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "pet":
                        if (item.sES == "pe")
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "item":
                        if (item.sES == "None")
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "design":
                        if ((((!(item.sES == "co")) && (!(item.sES == "None"))) && (!(item.EnhID > 0))))
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "nonac":
                        if (item.bCoins == 0)
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    case "ac":
                        if (item.bCoins == 1)
                        {
                            this.sortedList.push(item);
                        };
                        break;
                    default:
                        this.sortedList.push(item);
                };
                i++;
            };
            this.inventorySlot = this.sortedList.length;
            this.reset();
        }

        public function clearSelection():void
        {
            var selectedItem:InventoryItem = InventoryItem(getChildByName(("mcInventoryItem" + (this.intSelected - this.intPlacement))));
            if (selectedItem != null)
            {
                selectedItem.reset();
            };
            this.intSelected = -1;
            if (this.intPlacement != 0)
            {
                this.intPlacement = 0;
                this.mcScrollBar.mcSlider.y = 0;
            };
            var parentMovieClip:MovieClip = MovieClip(parent);
            if (parentMovieClip != null)
            {
                parentMovieClip.refreshDetail();
            };
        }

        public function init(items:Vector.<Item>):void
        {
            if (items == null)
            {
                return;
            };
            this.itemList = items;
            if (this.itemList == Game.root.world.myAvatar.items)
            {
                this.mcSort.visible = true;
            };
            this.mcScrollBar.mcSlider.visible = (this.intScrollCount > 0);
            this.sort();
        }

        public function reset():void
        {
            this.clearSelection();
            this.refreshList();
        }

        public function refreshList():void
        {
            var itemData:Item;
            var item:InventoryItem;
            var color:String;
            var iconWidth:int;
            var iconHeight:int;
            var currentWidth:int;
            var currentHeight:int;
            var icon:DisplayObject;
            var cls:Class;
            var iiDesign:MovieClip;
            var iiDesignWidth:int;
            var iiDesignHeight:int;
            var i:int;
            while (i < 10)
            {
                itemData = this.sortedList[(i + this.intPlacement)];
                item = InventoryItem(this.getChildByName(("mcInventoryItem" + i)));
                item.strIndex.text = String(((i + this.intPlacement) + 1));
                if (this.intSelected == (i + this.intPlacement))
                {
                    item.select();
                }
                else
                {
                    item.reset();
                };
                item.intIndex = (i + this.intPlacement);
                if (itemData == null)
                {
                    item.clearText();
                    item.unequip();
                }
                else
                {
                    if (itemData.sType == "Enhancement")
                    {
                        itemData.sIcon = this.getESIcon(itemData.sES);
                        itemData.EnhLvl = itemData.iLvl;
                    };
                    color = ((itemData.bUpg == 1) ? "#FFB817" : "#E6E2DB");
                    item.strName.htmlText = (((('<font color="' + color) + '">') + itemData.sName) + "</font>");
                    item.strLevel.text = ((itemData.EnhLvl != -1) ? ("Lvl " + itemData.EnhLvl) : "");
                    if (itemData.bEquip == 1)
                    {
                        item.equip();
                    }
                    else
                    {
                        item.unequip();
                    };
                    iconWidth = 21;
                    iconHeight = 19;
                    currentWidth = iconWidth;
                    currentHeight = iconHeight;
                    Game.root.onRemoveChildrens(item.icon);
                    icon = item.icon.addChild(itemData.iconClass);
                    currentWidth = icon.width;
                    currentHeight = icon.height;
                    icon.scaleX = ((currentWidth > currentHeight) ? icon.scaleY = (iconWidth / currentWidth) : icon.scaleY = (iconHeight / currentHeight));
                    icon.x = Math.round(((iconWidth - icon.width) >> 1));
                    icon.y = Math.round(((iconHeight - icon.height) >> 1));
                    if (((this.isEnhanceable(itemData.sES)) && (!(itemData.EnhID > 0))))
                    {
                        cls = Game.root.world.getClass("iidesign");
                        iiDesign = new (cls)();
                        iiDesign.alpha = 0.4;
                        iiDesignWidth = iiDesign.width;
                        iiDesignHeight = iiDesign.height;
                        iiDesign.scaleX = ((iiDesignWidth > iiDesignHeight) ? iiDesign.scaleY = (iconWidth / iiDesignWidth) : iiDesign.scaleY = (iconHeight / iiDesignHeight));
                        item.icon.addChild(iiDesign);
                    };
                    if (itemData.sES == "ar")
                    {
                        item.strName.htmlText = (item.strName.htmlText + ((" <font color='#999999'>(Rank " + Rank.getRankFromPoints(itemData.iQty)) + ")</font>"));
                    };
                    if (itemData.iStk > 1)
                    {
                        item.strName.htmlText = (item.strName.htmlText + ((" <font color='#999999'>x" + itemData.iQty) + "</font>"));
                    };
                };
                i++;
            };
        }

        public function isEnhanceable(equipSpot:String):Boolean
        {
            return (["Weapon", "he", "ba", "pe", "ar"].indexOf(equipSpot) >= 0);
        }

        public function getESIcon(icon:String):String
        {
            switch (icon)
            {
                case "Weapon":
                    return ("iwsword");
                case "he":
                    return ("iihelm");
                case "ba":
                    return ("iicape");
                case "pe":
                    return ("iipet");
                case "ar":
                    return ("iiclass");
                case "co":
                    return ("iwarmor");
                case "ho":
                    return ("ihhouse");
                default:
                    return ("none");
            };
        }

        public function selectItem(itemIndex:int):void
        {
            var previousItem:InventoryItem;
            if (itemIndex == -1)
            {
                return;
            };
            if ((((this.intSelected - this.intPlacement) >= 0) && ((this.intSelected - this.intPlacement) < 10)))
            {
                previousItem = InventoryItem(this.getChildByName(("mcInventoryItem" + (this.intSelected - this.intPlacement))));
                previousItem.reset();
            };
            this.intSelected = itemIndex;
            var currentItem:InventoryItem = InventoryItem(this.getChildByName(("mcInventoryItem" + (this.intSelected - this.intPlacement))));
            currentItem.select();
            MovieClip(parent).refreshDetail();
        }

        private function mouseDownHandler(_arg1:Event):void
        {
            this.mcScrollBar.mcSlider.startDrag(false, new Rectangle(0, 0, 0, 103));
            stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler, false, 0, true);
        }

        private function mouseUpHandler(_arg1:Event):void
        {
            this.mcScrollBar.mcSlider.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
        }

        private function mouseMoveHandler(event:Event):void
        {
            var newPlacement:int = int(((this.mcScrollBar.mcSlider.y * this.intScrollCount) / 103));
            if (((newPlacement >= 0) && (newPlacement <= this.intScrollCount)))
            {
                this.intPlacement = newPlacement;
            };
            this.refreshList();
        }

        private function onSortClick(event:Event):void
        {
            switch (event.target.name)
            {
                case "btnAll":
                    this.sortBy("all");
                    return;
                case "btnArmor":
                    this.sortBy("armor");
                    return;
                case "btnWeapon":
                    this.sortBy("weapon");
                    return;
                case "btnHelm":
                    this.sortBy("helm");
                    return;
                case "btnBack":
                    this.sortBy("back");
                    return;
                case "btnPet":
                    this.sortBy("pet");
                    return;
                case "btnItem":
                    this.sortBy("item");
                    return;
                case "btnDesign":
                    this.sortBy("design");
                    return;
            };
        }

        private function onBtnClickHandler(event:Event):void
        {
            if (event.currentTarget.name == "btnUp")
            {
                if (this.intPlacement > 0)
                {
                    this.intPlacement--;
                };
            }
            else
            {
                if (((event.currentTarget.name == "btnDown") && (this.intPlacement < this.intScrollCount)))
                {
                    this.intPlacement++;
                };
            };
            this.refreshList();
            this.mcScrollBar.mcSlider.y = Math.ceil(((this.intPlacement * 103) / this.intScrollCount));
        }


    }
}//package 

