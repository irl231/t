// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameListViewTabbed

package Main.Aqw.LPF
{
    import flash.text.TextField;
    import flash.display.MovieClip;
    import Main.SearchMC;
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.events.*;
    import Main.*;
    import flash.ui.*;

    public class LPFFrameListViewTabbed extends LPFFrame 
    {

        public var tMsg:TextField;
        public var listMask:MovieClip;
        public var bgTabs:MovieClip;
        public var bgList:MovieClip;
        public var tabs:MovieClip;
        public var iList:MovieClip;
        public var scr:LPFElementScrollBar;
        public var tSel:Object;
        public var mcSearch:SearchMC;
        public var onSearch:Boolean = false;
        public var mcSeller:MovieClip;
        public var mcDuration:MovieClip;
        public var mcPrice:MovieClip;
        public var mcLevel:MovieClip;
        private var listA:Array = [];
        private var aSel:Array = [];
        private var iSel:Object;
        private var tabStates:Array = [];
        private var filterMap:Object = {};
        private var itemEventType:String;
        private var tabEventType:String;
        private var sortOrder:Array = [];
        private var filter:String = "";
        private var allowDesel:Boolean = false;
        private var onDemand:Boolean = false;
        private var openBlank:Boolean = false;
        private var refreshTabs:Boolean = false;
        private var bLimited:Boolean = false;
        private var onAuction:Boolean = false;
        private var onInventory:Boolean = false;
        private var onRetrieve:Boolean = false;
        private var itemList:Vector.<Item>;

        public function LPFFrameListViewTabbed():void
        {
            x = 0;
            y = 0;
            fData = {};
            this.mcSearch = new SearchMC();
        }

        private function get search():Vector.<Item>
        {
            var item:Item;
            var item2:Item;
            var items:Vector.<Item> = new Vector.<Item>();
            switch (this.tSel.filter)
            {
                case "search":
                    if (this.onSearch)
                    {
                        for each (item in fData.list)
                        {
                            if (item.sName.toLowerCase().indexOf(this.mcSearch.txtSearch.text.toLowerCase()) > -1)
                            {
                                items.push(item);
                            };
                        };
                        this.onSearch = false;
                    }
                    else
                    {
                        this.addSearchBox();
                    };
                    break;
                default:
                    for each (item2 in fData.list)
                    {
                        if (this.filterMap[this.tSel.filter].indexOf(item2.sType) > -1)
                        {
                            items.push(item2);
                        };
                    };
            };
            return (items);
        }

        override public function fOpen(data:Object):void
        {
            fData = data.fData;
            this.itemList = fData.list;
            positionBy(data.r);
            this.drawBG();
            if (("tabStates" in data))
            {
                this.tabStates = data.tabStates;
            };
            if (("filterMap" in data))
            {
                this.filterMap = data.filterMap;
            };
            if (("sortOrder" in data))
            {
                this.sortOrder = data.sortOrder;
            };
            if (("eventTypes" in data))
            {
                eventTypes = data.eventTypes;
            };
            if (("filter" in data))
            {
                this.filter = data.filter;
            };
            if (("itemEventType" in data))
            {
                this.itemEventType = data.itemEventType;
            };
            if (("tabEventType" in data))
            {
                this.tabEventType = data.tabEventType;
            };
            if (("sName" in data))
            {
                sName = data.sName;
            };
            if (("onAuction" in data))
            {
                this.onAuction = data.onAuction;
            };
            if (("onInventory" in data))
            {
                this.onInventory = data.onInventory;
            };
            if (("onRetrieve" in data))
            {
                this.onRetrieve = data.onRetrieve;
            };
            if (("allowDesel" in data))
            {
                this.allowDesel = data.allowDesel;
            };
            if (("openBlank" in data))
            {
                this.openBlank = data.openBlank;
            };
            if (("onDemand" in data))
            {
                this.onDemand = data.onDemand;
            };
            if (("refreshTabs" in data))
            {
                this.refreshTabs = data.refreshTabs;
            };
            if (("bLimited" in fData))
            {
                this.bLimited = data.fData.bLimited;
            };
            if (!this.openBlank)
            {
                this.tSel = ((this.iSel == null) ? this.getTabByFilter("All") : this.getTabByFilter(this.iSel.sType));
            };
            if (this.onAuction)
            {
                this.mcSeller.visible = true;
                this.mcDuration.visible = true;
                this.mcPrice.visible = true;
                this.mcLevel.visible = true;
            };
            if (this.onInventory)
            {
                this.mcSeller.visible = false;
                this.mcDuration.visible = false;
                this.mcPrice.visible = false;
                this.mcLevel.visible = false;
            };
            if (this.onRetrieve)
            {
                this.mcSeller.visible = true;
                this.mcDuration.visible = true;
                this.mcPrice.visible = true;
                this.mcLevel.visible = true;
            };
            this.initTabs();
            this.fDraw();
            getLayout().registerForEvents(this, eventTypes);
            switch (rootClass.ui.mcPopup.currentLabel)
            {
                case "AuctionPanel":
                    rootClass.auctionTabs = this;
                    if (rootClass.vendingOwner != "")
                    {
                        this.mcSeller.visible = false;
                        this.mcDuration.visible = false;
                    };
                    break;
                case "TradePanel":
                    rootClass.tradeTabs[sName] = this;
                    this.mcSeller.visible = false;
                    this.mcDuration.visible = false;
                    this.mcPrice.visible = false;
                    this.mcLevel.visible = false;
                    break;
                case "Bank":
                    rootClass.auctionTabs = this;
                default:
                    this.mcSeller.visible = false;
                    this.mcDuration.visible = false;
                    this.mcPrice.visible = false;
                    this.mcLevel.visible = false;
            };
        }

        override public function update(_arg_1:Object):void
        {
            if (_arg_1.eventType == this.itemEventType)
            {
                this.iSel = _arg_1.fData;
            };
            if (_arg_1.eventType == this.tabEventType)
            {
                this.iSel = null;
            };
            getLayout().update(_arg_1);
        }

        override public function notify(object:Object):void
        {
            switch (object.eventType)
            {
                case "sModeSet":
                    fData = object.fData;
                    this.fRefresh(object);
                    break;
                case "refreshItems":
                    if (((!(this.tSel == null)) && (this.tSel.filter == "search")))
                    {
                        this.onSearch = true;
                    };
                    if (fData.list.indexOf(this.iSel) == -1)
                    {
                        this.iSel = null;
                    };
                    this.fDraw(false);
                    if (this.refreshTabs)
                    {
                        this.initTabs();
                    };
                    break;
                case "refreshInv":
                    this.itemList = Game.root.world.myAvatar.filtered_inventory;
                    this.fDraw(true);
                    break;
                case "refreshBank":
                    this.fDraw(false);
                    break;
                case "listItemASel":
                    this.fRefresh(object);
                    if (this.filter != "")
                    {
                        this.shadeListByTypeFilter(object.fData);
                    };
                    break;
                case this.tabEventType:
                    if ((((!(object.fData == null)) && ("loadPending" in object.fData)) && ("msg" in object.fData)))
                    {
                        this.setMessage(object.fData.msg);
                    };
                    break;
            };
        }

        public function fRefresh(_arg_1:Object):void
        {
            if (("tabStates" in _arg_1))
            {
                this.tabStates = _arg_1.tabStates;
            };
            if (("filterMap" in _arg_1))
            {
                this.filterMap = _arg_1.filterMap;
            };
            if (("sortOrder" in _arg_1))
            {
                this.sortOrder = _arg_1.sortOrder;
            };
            if (("eventTypes" in _arg_1))
            {
                eventTypes = _arg_1.eventTypes;
            };
            if (("filter" in _arg_1))
            {
                this.filter = _arg_1.filter;
            };
            if (("itemEventType" in _arg_1))
            {
                this.itemEventType = _arg_1.itemEventType;
            };
            if (("tabEventType" in _arg_1))
            {
                this.tabEventType = _arg_1.tabEventType;
            };
            if (("sName" in _arg_1))
            {
                sName = _arg_1.sName;
            };
            this.iSel = null;
            this.tSel = this.getTabByFilter("All");
            if (fData.list != null)
            {
                this.itemList = fData.list;
            };
            this.initTabs();
            this.fDraw();
        }

        public function getTabByFilter(filter:String):Object
        {
            var tab:Object;
            var i:int;
            while (i < this.tabStates.length)
            {
                tab = this.tabStates[i];
                if (tab.filter == filter)
                {
                    return (tab);
                };
                i++;
            };
            if (((this.tabStates.length > 0) && (!(filter == "none"))))
            {
                return (this.tabStates[0]);
            };
            return (null);
        }

        public function getListItemByiSel():LPFElementListItemItem
        {
            var lpfElementListItemItem:LPFElementListItemItem;
            var i:int;
            while (i < this.iList.numChildren)
            {
                try
                {
                    lpfElementListItemItem = LPFElementListItemItem(this.iList.getChildAt(i));
                    if (lpfElementListItemItem.fData == this.iSel)
                    {
                        return (lpfElementListItemItem);
                    };
                }
                catch(e)
                {
                };
                i++;
            };
            return (null);
        }

        private function initTabs():void
        {
            var tab:Object;
            var item:Item;
            var key:String;
            var tab2:Object;
            var viewTab:LPFElementListViewTab;
            var _icon:Object;
            var iconMC:DisplayObject;
            while (this.tabs.numChildren > 0)
            {
                this.tabs.removeChildAt(0);
            };
            this.bgTabs.graphics.clear();
            var exclude:Array = ["All", "search"];
            var i:int;
            while (i < this.tabStates.length)
            {
                tab = this.tabStates[i];
                if (((!(exclude.indexOf(tab.filter) == -1)) || (this.onDemand)))
                {
                    tab.state = 0;
                }
                else
                {
                    tab.state = -1;
                };
                for each (item in fData.list)
                {
                    for (key in this.filterMap)
                    {
                        if (((this.filterMap[key].indexOf(item.sType) > -1) && (tab.filter == key)))
                        {
                            tab.state = 0;
                        };
                    };
                };
                i++;
            };
            var ii:int;
            while (ii < this.tabStates.length)
            {
                tab2 = this.tabStates[ii];
                viewTab = LPFElementListViewTab(this.tabs.addChild(new LPFElementListViewTab()));
                _icon = rootClass.world.getClass(tab2.icon);
                iconMC = viewTab.icon.addChild(new (_icon)());
                iconMC.scaleX = (iconMC.scaleY = (16 / iconMC.height));
                iconMC.x = (iconMC.x - (iconMC.width >> 1));
                iconMC.y = 2;
                viewTab.icon.mouseEnabled = false;
                viewTab.icon.mouseChildren = false;
                viewTab.o = tab2;
                tab2.mc = viewTab;
                viewTab.bg2.visible = false;
                if (tab2 == this.tSel)
                {
                    tab2.state = 1;
                };
                if (tab2.state == -1)
                {
                    viewTab.icon.alpha = 0.3;
                    viewTab.bg3.visible = true;
                    viewTab.bg2.visible = false;
                    viewTab.bg.visible = false;
                    viewTab.mouseEnabled = false;
                    viewTab.mouseChildren = false;
                }
                else
                {
                    viewTab.bg3.visible = false;
                    viewTab.buttonMode = true;
                    if (tab2.state == 1)
                    {
                        viewTab.bg.visible = false;
                        viewTab.bg2.visible = true;
                    };
                    viewTab.addEventListener(MouseEvent.MOUSE_DOWN, this.tabClick, false, 0, true);
                };
                viewTab.x = (int(((viewTab.width + 3) * ii)) + 1);
                ii++;
            };
            this.drawTabBG();
        }

        private function fDraw(reset:Boolean=true):void
        {
            var item:Item;
            var i:int;
            var item3:Item;
            var item2:Item;
            this.listA = [];
            var items:Vector.<Item> = new Vector.<Item>();
            this.closeAll();
            if (reset)
            {
                this.iList.y = (this.bgTabs.height - 1);
            };
            if (this.tSel == null)
            {
                this.setMessage("No Tab Selected");
                this.scr.fOpen({
                    "subject":this.iList,
                    "subjectMask":this.listMask,
                    "reset":reset
                });
                return;
            };
            this.setMessage("");
            if (this.tSel.filter == "All")
            {
                items = this.itemList;
            }
            else
            {
                if (((this.tSel.filter == "boosted") || (this.tSel.filter == "enhancement")))
                {
                    for each (item3 in fData.list)
                    {
                        if (((["Weapon", "he", "ar", "ba"].indexOf(item3.sES) > -1) && (!(item3.sType == "Enhancement"))))
                        {
                            items.push(item3);
                        };
                    };
                }
                else
                {
                    for each (item2 in fData.list)
                    {
                        if (this.filterMap[this.tSel.filter].indexOf(item2.sType) > -1)
                        {
                            items.push(item2);
                        };
                    };
                };
            };
            if ((((this.onDemand) && (!(this.onSearch))) && (items.length == 0)))
            {
                this.setMessage("");
                this.scr.fOpen({
                    "subject":this.iList,
                    "subjectMask":this.listMask,
                    "reset":reset
                });
                return;
            };
            var sorted:Array = [];
            var sortLength:int = this.sortOrder.length;
            i = 0;
            while (i < sortLength)
            {
                sorted = [];
                for each (item in items)
                {
                    if (item.sType == this.sortOrder[i])
                    {
                        sorted.push(item);
                    };
                };
                if (sorted.length > 0)
                {
                    sorted.sortOn(["sName", "iLvl"], [undefined, (Array.DESCENDING | Array.NUMERIC)]);
                    this.listA = this.listA.concat(sorted);
                };
                i++;
            };
            sorted = [];
            for each (item in items)
            {
                if (this.listA.indexOf(item) == -1)
                {
                    sorted.push(item);
                };
            };
            if (sorted.length > 0)
            {
                sorted.sortOn(["sType", "sName"]);
                this.listA = this.listA.concat(sorted);
            };
            var itemData:Object = {};
            itemData.eventType = this.itemEventType;
            itemData.allowDesel = this.allowDesel;
            itemData.onAuction = this.onAuction;
            itemData.onInventory = this.onInventory;
            itemData.onRetrieve = this.onRetrieve;
            itemData.bLimited = ((this.bLimited) && (getLayout().sMode == "shopBuy"));
            var listLength:int = this.listA.length;
            i = 0;
            while (i < listLength)
            {
                this.addItem(itemData, i);
                i++;
            };
            this.scr.fOpen({
                "subject":this.iList,
                "subjectMask":this.listMask,
                "reset":reset
            });
        }

        private function addItem(itemData:Object, key:int):void
        {
            itemData.fData = this.listA[key];
            var listItem:LPFElementListItemItem = LPFElementListItemItem(this.iList.addChild(new LPFElementListItemItem()));
            listItem.subscribeTo(this);
            listItem.fOpen(itemData);
            if (listItem.fData == this.iSel)
            {
                listItem.select();
            };
            if (key != 0)
            {
                listItem.y = (this.iList.height - 4);
            };
        }

        private function setSelectedTableItem():*
        {
            this.tSel.mc.bg.visible = false;
            this.tSel.mc.bg2.visible = true;
            this.tSel.state = 1;
        }

        private function setUnselectedTableItem():*
        {
            this.tSel.mc.bg.visible = true;
            this.tSel.mc.bg2.visible = false;
            this.tSel.state = 0;
        }

        private function addSearchBox():void
        {
            this.removeSearchBox();
            this.mcSearch.txtSearch.text = "";
            this.mcSearch.btnSearch.addEventListener(MouseEvent.MOUSE_DOWN, this.tabClick);
            this.mcSearch.txtSearch.addEventListener(KeyboardEvent.KEY_DOWN, this.checkKeyClick);
            var search:DisplayObject = this.iList.addChild(this.mcSearch);
            if (rootClass.ui.mcPopup.currentLabel == "AuctionPanel")
            {
                search.x = 135;
            };
        }

        private function removeSearchBox():void
        {
            var child:DisplayObject;
            var i:int;
            while (i < this.iList.numChildren)
            {
                child = this.iList.getChildAt(i);
                if ((child is SearchMC))
                {
                    this.iList.removeChildAt(i);
                };
                i++;
            };
        }

        private function drawTabBG():void
        {
            var lpfElementListViewTab:LPFElementListViewTab;
            var graphics:Graphics = this.bgTabs.graphics;
            var bottomLine:int = (this.bgTabs.bg.height - 1);
            graphics.clear();
            graphics.lineStyle(0, 0x666666, 1);
            graphics.moveTo(0, bottomLine);
            if (this.tSel != null)
            {
                lpfElementListViewTab = this.tSel.mc;
                if (lpfElementListViewTab.x > 1)
                {
                    graphics.lineTo(lpfElementListViewTab.x, bottomLine);
                };
                graphics.moveTo((lpfElementListViewTab.x + lpfElementListViewTab.width), bottomLine);
                graphics.lineTo(this.bgList.width, bottomLine);
                lpfElementListViewTab.x--;
                this.bgTabs.bg.visible = true;
            }
            else
            {
                graphics.lineTo(this.bgList.width, bottomLine);
                this.bgTabs.bg.visible = false;
            };
        }

        private function setMessage(_arg_1:String):void
        {
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                this.tMsg.text = _arg_1;
                this.tMsg.visible = true;
            }
            else
            {
                this.tMsg.text = "";
                this.tMsg.visible = false;
            };
        }

        private function shadeListByTypeFilter(fData:Object):void
        {
            var item:Object;
            var i:int;
            var displayObject:DisplayObject;
            var lpfElementListItemItem:LPFElementListItemItem;
            if (fData.eSel != null)
            {
                item = fData.eSel;
            };
            if (fData.iSel != null)
            {
                item = fData.iSel;
            };
            var isBoost:Boolean = ((item.sType == "Boost") || (item.sType == "Enhancement"));
            if (item != null)
            {
                i = 0;
                while (i < this.iList.numChildren)
                {
                    displayObject = this.iList.getChildAt(i);
                    if ((displayObject is LPFElementListItemItem))
                    {
                        lpfElementListItemItem = LPFElementListItemItem(displayObject);
                        if (((isBoost) && (["Weapon", "he", "ar", "ba"].indexOf(lpfElementListItemItem.fData.sES) > -1)))
                        {
                            lpfElementListItemItem.alpha = 1;
                            lpfElementListItemItem.mouseEnabled = true;
                            lpfElementListItemItem.mouseChildren = true;
                        }
                        else
                        {
                            if (((lpfElementListItemItem.fData[this.filter] == item[this.filter]) && (!(lpfElementListItemItem.fData.sType == item.sType))))
                            {
                                lpfElementListItemItem.alpha = 1;
                                lpfElementListItemItem.mouseEnabled = true;
                                lpfElementListItemItem.mouseChildren = true;
                            }
                            else
                            {
                                lpfElementListItemItem.alpha = 0.3;
                                lpfElementListItemItem.mouseEnabled = false;
                                lpfElementListItemItem.mouseChildren = false;
                            };
                        };
                    };
                    i++;
                };
            };
        }

        private function drawBG():void
        {
            this.bgList.width = w;
            this.bgList.height = ((h - this.listMask.y) + 3);
            this.bgList.y = this.listMask.y;
            this.listMask.width = w;
            this.listMask.height = (h - this.listMask.y);
            this.scr.b.height = ((this.listMask.height - (this.scr.a2.height << 1)) + 1);
            this.scr.hit.height = this.scr.b.height;
            this.scr.hit.alpha = 0;
            this.scr.a2.y = ((this.scr.b.y + this.scr.b.height) + this.scr.a2.height);
            this.scr.x = (w + 2);
            this.tMsg.x = Math.round(((this.bgList.width >> 1) - (this.tMsg.width >> 1)));
            this.tMsg.y = Math.round((this.bgList.y + ((this.bgList.height >> 1) - (this.tMsg.height >> 1))));
        }

        private function closeAll():void
        {
            var child:DisplayObject;
            while (this.iList.numChildren > 0)
            {
                child = this.iList.getChildAt(0);
                if ((child is LPFElementListItem))
                {
                    LPFElementListItem(child).fClose();
                }
                else
                {
                    this.iList.removeChildAt(0);
                };
            };
        }

        public function checkKeyClick(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ENTER)
            {
                this.tabClick();
            };
        }

        private function tabClick(event:MouseEvent=null):void
        {
            if (this.tSel != null)
            {
                this.setUnselectedTableItem();
            };
            if ((((((event == null) || ((!(event == null)) && (event.currentTarget.name == "btnSearch"))) && (!(this.tSel == null))) && (this.tSel.filter == "search")) && (!(this.onSearch))))
            {
                this.onSearch = true;
                this.setSelectedTableItem();
                this.removeSearchBox();
            }
            else
            {
                if (event != null)
                {
                    this.tSel = Object(LPFElementListViewTab(event.currentTarget).o);
                    this.setSelectedTableItem();
                    if (this.tSel.filter != "search")
                    {
                        this.removeSearchBox();
                    };
                };
            };
            if (this.tSel != null)
            {
                this.drawTabBG();
                if (((this.onDemand) && (!(this.onSearch))))
                {
                    this.closeAll();
                    this.iList.y = (this.bgTabs.height - 1);
                    this.update({
                        "fData":{"types":this.filterMap[this.tSel.filter]},
                        "eventType":this.tabEventType,
                        "fCaller":sName
                    });
                }
                else
                {
                    this.fDraw();
                };
            };
        }


    }
}//package Main.Aqw.LPF

