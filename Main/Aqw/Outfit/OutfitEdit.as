// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.Outfit.OutfitEdit

package Main.Aqw.Outfit
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import Main.Model.Item;
    import __AS3__.vec.Vector;
    import flash.display.Shape;
    import fl.motion.Color;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.events.Event;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import fl.motion.*;
    import Main.*;

    public class OutfitEdit extends Sprite 
    {

        private const game:Game = Game.root;

        public var hair3:MovieClip;
        public var cat0:MovieClip;
        public var mcPencil:MovieClip;
        public var armor1:MovieClip;
        public var cat1:MovieClip;
        public var armor2:MovieClip;
        public var cat2:MovieClip;
        public var armor3:MovieClip;
        public var cat3:MovieClip;
        public var cat4:MovieClip;
        public var cat5:MovieClip;
        public var cat6:MovieClip;
        public var cat7:MovieClip;
        public var txtSearch:TextField;
        public var cat8:MovieClip;
        public var txtSetName:TextField;
        public var bg:MovieClip;
        public var btnCancel:SimpleButton;
        public var txtUpdate:TextField;
        public var bg2:MovieClip;
        public var scr:MovieClip;
        public var btnUpdate:SimpleButton;
        public var hair1:MovieClip;
        public var hair2:MovieClip;
        public var btnBack:SimpleButton;
        internal var activeTab:int = 0;
        private var outfitPanel:OutfitPanel;
        private var originalName:String;
        private var outfit:Object;
        private var outfitIndex:int;
        private var itemList:MovieClip;
        private var mask_mc:MovieClip;
        private var mDown:Boolean = false;
        private var s_sES:Array = ["he", "ba", "ar", "co", "Weapon", "pe", "am", "mi"];
        private var tabs:Array = ["all", "Weapon", "co", "ar", "he", "ba", "pe", "am", "mi"];

        public function OutfitEdit(outfitPanel:OutfitPanel, id:int)
        {
            var item:Item;
            super();
            this.outfitPanel = outfitPanel;
            if (id == -1)
            {
                this.outfit = {
                    "name":"Set Name",
                    "colors":{
                        "hair":this.outfitPanel.pAV.objData.intColorHair,
                        "skin":this.outfitPanel.pAV.objData.intColorSkin,
                        "eye":this.outfitPanel.pAV.objData.intColorEye,
                        "base":this.outfitPanel.pAV.objData.intColorBase,
                        "trim":this.outfitPanel.pAV.objData.intColorTrim,
                        "accessory":this.outfitPanel.pAV.objData.intColorAccessory
                    }
                };
                for each (item in this.outfitPanel.pAV.items)
                {
                    if (item.bEquip)
                    {
                        this.outfit[item.sES] = item.ItemID;
                    };
                };
                this.originalName = null;
            }
            else
            {
                this.outfit = this.game.copyObj(this.outfitPanel.sets[id]);
                this.originalName = this.outfit.name;
            };
            this.outfitIndex = id;
            this.initInterface();
        }

        private static function itemSort(a:Item, b:Item):int
        {
            if (a.bEquip > b.bEquip)
            {
                return (-1);
            };
            if (a.bEquip < b.bEquip)
            {
                return (1);
            };
            if (a.sType > b.sType)
            {
                return (-1);
            };
            if (a.sType < b.sType)
            {
                return (1);
            };
            if (a.sName < b.sName)
            {
                return (-1);
            };
            if (a.sName > b.sName)
            {
                return (1);
            };
            return (0);
        }


        public function handleEmpty(value:String):int
        {
            return ((value == "") ? -1 : parseInt(value));
        }

        public function onServerResponseUpdate():void
        {
            if (this.outfitIndex != -1)
            {
                this.outfitPanel.sets[this.outfitIndex] = this.game.copyObj(this.outfit);
            }
            else
            {
                this.outfitPanel.sets.push(this.outfit);
            };
            this.onBack();
        }

        public function setIcon(_arg_1:MovieClip, _arg_2:String, _arg_3:Boolean=false):void
        {
            var _local_5:*;
            var _local_6:*;
            var _local_7:*;
            var _local_8:*;
            var _local_9:*;
            var _local_4:Class = (this.game.world.getClass(_arg_2) as Class);
            if (_local_4 != null)
            {
                _local_5 = _arg_1.addChild(new (_local_4)());
                if (_arg_3)
                {
                    _local_5.scaleX = (_local_5.scaleY = (16 / _local_5.height));
                    _local_5.x = (_local_5.x - (_local_5.width / 2));
                    _local_5.y = 2;
                    _arg_1.mouseEnabled = false;
                    _arg_1.mouseChildren = false;
                    return;
                };
                _local_6 = 23;
                _local_7 = 19;
                _local_8 = _local_5.width;
                _local_9 = _local_5.height;
                if (_local_8 > _local_9)
                {
                    _local_5.scaleX = (_local_5.scaleY = (_local_6 / _local_8));
                }
                else
                {
                    _local_5.scaleX = (_local_5.scaleY = (_local_7 / _local_9));
                };
                _local_5.x = -(_local_5.width / 2);
                _local_5.y = -(_local_5.height / 2);
            };
        }

        public function tabFilter(param1:Item, param2:int, items:Vector.<Item>):Boolean
        {
            if (this.activeTab == 0)
            {
                return (true);
            };
            if (param1.sES == this.tabs[this.activeTab])
            {
                return (true);
            };
            return (false);
        }

        public function initTabs():void
        {
            var _local_1:*;
            var _local_2:*;
            var _local_3:String;
            for (_local_1 in this.tabs)
            {
                _local_2 = getChildByName(("cat" + _local_1));
                _local_3 = "";
                switch (this.tabs[_local_1])
                {
                    case "all":
                        _local_3 = "iipack";
                        break;
                    case "he":
                        _local_3 = "iihelm";
                        break;
                    case "ba":
                        _local_3 = "iicape";
                        break;
                    case "ar":
                        _local_3 = "iiclass";
                        break;
                    case "co":
                        _local_3 = "iwarmor";
                        break;
                    case "Weapon":
                        _local_3 = "iwsword";
                        break;
                    case "pe":
                        _local_3 = "iipet";
                        break;
                    case "mi":
                        _local_3 = "imr2";
                        break;
                    case "am":
                        _local_3 = "iin1";
                        break;
                };
                this.setIcon(_local_2.icon, _local_3, true);
                _local_2.addEventListener(MouseEvent.CLICK, this.onTabClick, false, 0, true);
            };
        }

        public function initInterface():void
        {
            var _local_1:Shape;
            this.btnBack.addEventListener(MouseEvent.CLICK, this.onBack, false, 0, true);
            this.mcPencil.visible = (this.outfitIndex == -1);
            this.mcPencil.addEventListener(MouseEvent.CLICK, this.onPencil, false, 0, true);
            this.btnUpdate.addEventListener(MouseEvent.CLICK, this.onSetUpdate, false, 0, true);
            this.btnCancel.addEventListener(MouseEvent.CLICK, this.onBack, false, 0, true);
            this.txtSearch.addEventListener(MouseEvent.CLICK, this.onReset, false, 0, true);
            this.txtSearch.addEventListener(Event.CHANGE, this.onSearch, false, 0, true);
            this.txtSetName.addEventListener(MouseEvent.CLICK, this.onReset, false, 0, true);
            this.txtUpdate.mouseEnabled = false;
            this.txtUpdate.text = ((this.outfitIndex == -1) ? "Create Set" : "Update Set");
            _local_1 = new Shape();
            _local_1.graphics.beginFill(0);
            _local_1.graphics.drawRect(this.bg.x, this.bg.y, this.bg.width, this.bg.height);
            _local_1.graphics.endFill();
            addChild(_local_1);
            this.itemList = new MovieClip();
            this.itemList.x = this.bg.x;
            this.itemList.y = this.bg.y;
            addChild(this.itemList);
            this.itemList.mask = _local_1;
            this.itemList.addEventListener(MouseEvent.MOUSE_WHEEL, this.onScroll, false, 0, true);
            var _local_2:Color = new Color();
            _local_2.setTint(this.outfit.colors.hair, 1);
            this.hair1.transform.colorTransform = _local_2;
            _local_2.setTint(this.outfit.colors.skin, 1);
            this.hair2.transform.colorTransform = _local_2;
            _local_2.setTint(this.outfit.colors.eye, 1);
            this.hair3.transform.colorTransform = _local_2;
            _local_2.setTint(this.outfit.colors.base, 1);
            this.armor1.transform.colorTransform = _local_2;
            _local_2.setTint(this.outfit.colors.trim, 1);
            this.armor2.transform.colorTransform = _local_2;
            _local_2.setTint(this.outfit.colors.accessory, 1);
            this.armor3.transform.colorTransform = _local_2;
            this.txtSetName.text = this.outfit.name;
            this.txtSetName.restrict = "A-Z a-z 0-9";
            this.txtSetName.maxChars = 30;
            this.buildMenu();
            this.initScroll();
            this.initTabs();
        }

        public function resetScroll():void
        {
            this.scr.h.y = 0;
            this.itemList.y = (this.bg.y + (this.scr.h.y * ((this.bg.height - this.itemList.height) / 176)));
        }

        public function initScroll():void
        {
            this.scr.hit.alpha = 0;
            this.scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.btnHold, false, 0, true);
            this.scr.addEventListener(Event.ENTER_FRAME, this.onChange, false, 0, true);
        }

        public function isEquipped(_arg_1:int):Boolean
        {
            var _local_2:* = this.outfit.layout.split(",");
            if (_local_2.indexOf(_arg_1) != -1)
            {
                return (true);
            };
            return (false);
        }

        public function buildMenu(items:Vector.<Item>=null):void
        {
            var _local_2:Item;
            var _local_3:*;
            var _local_6:String;
            var _local_7:Object;
            var _local_4:int;
            if (!items)
            {
                for each (_local_2 in this.outfitPanel.pAV.items)
                {
                    if (_local_2.ItemID == this.outfit[_local_2.sES])
                    {
                        _local_2.bEquip = 1;
                    }
                    else
                    {
                        _local_2.bEquip = 0;
                    };
                };
                items = Vector.<Item>(this.outfitPanel.pAV.items).sort(itemSort);
            };
            while (this.itemList.numChildren > 0)
            {
                this.itemList.removeChildAt(0);
            };
            var _local_5:* = this.game.world.myAvatar.dataLeaf;
            for each (_local_2 in items)
            {
                if (!(((!(_local_2.sES)) || (_local_2.sES == "None")) || (_local_2.sType == "Enhancement")))
                {
                    if (!((!(["Weapon", "he", "ar", "ba"].indexOf(_local_2.sES) == -1)) && (_local_2.EnhID == 0)))
                    {
                        if (!((_local_2.iLvl > _local_5.intLevel) || ((!(_local_2.EnhLvl == null)) && (_local_2.EnhLvl > _local_5.intLevel))))
                        {
                            _local_3 = new OutfitItem();
                            _local_6 = (("<font color='#FFFFFF'>" + _local_2.sName) + "</font>");
                            if (_local_2.bUpg == 1)
                            {
                                _local_6 = (("<font color='#FCC749'>" + _local_2.sName) + "</font>");
                            };
                            if (((_local_2.iLvl > _local_5.intLevel) || ((!(_local_2.EnhLvl == null)) && (_local_2.EnhLvl > _local_5.intLevel))))
                            {
                                _local_6 = (("<font color='#FF0000'>" + _local_2.sName) + "</font>");
                            };
                            _local_3.tName.text = "";
                            _local_3.tName.htmlText = _local_6;
                            _local_3.iconAC.visible = _local_2.bCoins;
                            _local_3.wearBG.visible = false;
                            _local_3.eqpBG.visible = _local_2.bEquip;
                            _local_3.selBG.visible = false;
                            this.setIcon(_local_3.icon, _local_2.sIcon);
                            if (["Weapon", "he", "ar", "ba"].indexOf(_local_2.sES) > -1)
                            {
                                _local_3.iconRing.visible = true;
                                _local_3.iconRing.x = (_local_3.iconRing.x + 3);
                                _local_3.iconRing.y = 5;
                                _local_3.iconRing.width = (_local_3.iconRing.height = 19);
                                if (_local_2.PatternID != null)
                                {
                                    _local_7 = this.game.world.enhPatternTree[_local_2.PatternID];
                                };
                                if (_local_2.EnhPatternID != null)
                                {
                                    _local_7 = this.game.world.enhPatternTree[_local_2.EnhPatternID];
                                };
                                if (_local_7 != null)
                                {
                                    if (_local_7.hasOwnProperty("COLOR"))
                                    {
                                        _local_3.iconRing.bg.transform.colorTransform = _local_7.COLOR;
                                    }
                                    else
                                    {
                                        _local_3.iconRing.bg.transform.colorTransform = this.getCatCT(_local_7.sDesc);
                                    };
                                };
                                if (((!(_local_2.EnhLvl == null)) && (_local_2.EnhLvl < 1)))
                                {
                                    _local_3.icon.transform.colorTransform = MainController.colorCT.greyoutCT;
                                };
                            }
                            else
                            {
                                _local_3.iconRing.visible = false;
                            };
                            _local_3.tLevel.text = "";
                            if (((!(_local_2.EnhLvl == null)) && (_local_2.EnhLvl > 0)))
                            {
                                _local_3.tLevel.htmlText = (("<font color='#00CCFF'>" + _local_2.EnhLvl) + "</font>");
                            }
                            else
                            {
                                if (((!(_local_2.iLvl == null)) && (_local_2.iLvl > 0)))
                                {
                                    _local_3.tLevel.htmlText = (("<font color='#FFFFFF'>" + _local_2.iLvl) + "</font>");
                                }
                                else
                                {
                                    _local_3.tLevel.visible = false;
                                };
                            };
                            _local_3.x = 0;
                            _local_3.y = ((_local_4 > 0) ? (_local_4 * 30) : 0);
                            _local_4++;
                            _local_3.addEventListener(MouseEvent.CLICK, this.onItemClick, false, 0, true);
                            this.itemList.addChild(_local_3);
                        };
                    };
                };
            };
        }

        public function getItem(_arg_1:String):*
        {
            var _local_2:*;
            for each (_local_2 in this.outfitPanel.pAV.items)
            {
                if (_local_2.sName == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getItemByID(_arg_1:int):*
        {
            var _local_2:*;
            for each (_local_2 in this.outfitPanel.pAV.items)
            {
                if (_local_2.ItemID == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getItemMC(_arg_1:int):*
        {
            var _local_3:*;
            var _local_4:int;
            if (_arg_1 == -1)
            {
                return (null);
            };
            var _local_2:* = "";
            for each (_local_3 in this.outfitPanel.pAV.items)
            {
                if (_local_3.ItemID == _arg_1)
                {
                    _local_2 = _local_3.sName;
                    break;
                };
            };
            if (_local_2 == "")
            {
                return (null);
            };
            while (_local_4 < this.itemList.numChildren)
            {
                if ((this.itemList.getChildAt(_local_4) as MovieClip).tName.text == _local_2)
                {
                    return (this.itemList.getChildAt(_local_4));
                };
                _local_4++;
            };
            return (null);
        }

        public function nameSearch(param1:Item, param2:int, _arg_3:Vector.<Item>):Boolean
        {
            if (param1.sName.toLowerCase().indexOf(this.txtSearch.text.toLowerCase()) != -1)
            {
                return (true);
            };
            return (false);
        }

        private function getCatCT(_arg_1:String):ColorTransform
        {
            var _local_2:ColorTransform = new ColorTransform(1, 1, 1, 1, 96, 0, 0, 0);
            var _local_3:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 96, 0, 0);
            var _local_4:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 96, 0);
            var _local_5:ColorTransform = new ColorTransform(1, 1, 1, 1, 64, 64, 64, 0);
            var _local_6:ColorTransform = new ColorTransform(1, 1, 1, 1, 96, 36, 0, 0);
            var _local_7:ColorTransform = new ColorTransform(1, 1, 1, 1, 96, 64, 24, 0);
            var _local_8:ColorTransform = new ColorTransform(1, 1, 1, 1, 96, 0, 96, 0);
            var _local_9:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
            var _local_10:ColorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0, 0);
            var _local_11:ColorTransform = _local_9;
            if (_arg_1 == "M1")
            {
                _local_11 = _local_2;
            };
            if (_arg_1 == "M2")
            {
                _local_11 = _local_3;
            };
            if (_arg_1 == "M3")
            {
                _local_11 = _local_7;
            };
            if (_arg_1 == "C1")
            {
                _local_11 = _local_4;
            };
            if (_arg_1 == "C2")
            {
                _local_11 = _local_5;
            };
            if (_arg_1 == "C3")
            {
                _local_11 = _local_6;
            };
            if (_arg_1 == "S1")
            {
                _local_11 = _local_8;
            };
            if (_arg_1 == "none")
            {
                _local_11 = _local_9;
            };
            return (_local_11);
        }

        public function onSetUpdate(_arg_1:MouseEvent):void
        {
            if (this.outfitIndex == -1)
            {
                if (this.outfitPanel.sets.length >= this.outfitPanel.slots)
                {
                    this.game.MsgBox.notify("You have no more free outfit slots!");
                    return;
                };
            };
            if (!this.game.world.coolDown("addLoadout"))
            {
                this.outfitPanel.slowDown();
                return;
            };
            var _local_2:* = this.outfitPanel.pAV;
            this.outfit.name = this.txtSetName.text;
            if (this.outfitIndex != -1)
            {
                this.outfit.colors = {
                    "hair":this.outfitPanel.world.myAvatar.objData.intColorHair,
                    "skin":this.outfitPanel.world.myAvatar.objData.intColorSkin,
                    "eye":this.outfitPanel.world.myAvatar.objData.intColorEye,
                    "base":this.outfitPanel.world.myAvatar.objData.intColorBase,
                    "trim":this.outfitPanel.world.myAvatar.objData.intColorTrim,
                    "accessory":this.outfitPanel.world.myAvatar.objData.intColorAccessory
                };
            }
            else
            {
                this.outfit.colors = {
                    "hair":_local_2.objData.intColorHair,
                    "skin":_local_2.objData.intColorSkin,
                    "eye":_local_2.objData.intColorEye,
                    "base":_local_2.objData.intColorBase,
                    "trim":_local_2.objData.intColorTrim,
                    "accessory":_local_2.objData.intColorAccessory
                };
            };
            var outFitData:Object = this.game.copyObj(this.outfit);
            delete outFitData.name;
            if (this.originalName == null)
            {
                Game.root.network.send("addLoadout", [this.outfit.name, JSON.stringify(outFitData)]);
            }
            else
            {
                Game.root.network.send("addLoadout", [this.outfit.name, JSON.stringify(outFitData), this.originalName]);
            };
        }

        public function onTabClick(mouseEvent:MouseEvent):void
        {
            this.activeTab = mouseEvent.currentTarget.name.slice(3);
            this.buildMenu(this.outfitPanel.pAV.items.filter(this.tabFilter).sort(itemSort));
            this.resetScroll();
        }

        public function onScroll(_arg_1:MouseEvent):void
        {
            if (this.itemList.height < this.bg.height)
            {
                return;
            };
            _arg_1.delta = (_arg_1.delta * 6);
            this.itemList.y = (this.itemList.y + _arg_1.delta);
            if (this.itemList.y >= this.bg.y)
            {
                this.itemList.y = this.bg.y;
            };
            if (this.itemList.y <= (this.bg.y + (this.bg.height - this.itemList.height)))
            {
                this.itemList.y = (this.bg.y + (this.bg.height - this.itemList.height));
            };
            this.scr.h.y = ((this.itemList.y - this.bg.y) / ((this.bg.height - this.itemList.height) / 176));
        }

        public function btnHold(_arg_1:MouseEvent):void
        {
            this.mDown = true;
            MovieClip(stage.getChildAt(0)).addEventListener(MouseEvent.MOUSE_UP, this.btnRelease, false, 0, true);
        }

        public function btnRelease(_arg_1:MouseEvent):void
        {
            this.mDown = false;
            MovieClip(stage.getChildAt(0)).removeEventListener(MouseEvent.MOUSE_UP, this.btnRelease);
        }

        public function onChange(_arg_1:Event):void
        {
            var _local_2:Point;
            if (this.mDown)
            {
                if (this.itemList.height < this.bg.height)
                {
                    return;
                };
                _local_2 = new Point(MovieClip(stage.getChildAt(0)).mouseX, MovieClip(stage.getChildAt(0)).mouseY);
                this.scr.h.y = this.scr.globalToLocal(_local_2).y;
                if (this.scr.h.y <= 0)
                {
                    this.scr.h.y = 0;
                };
                if (this.scr.h.y >= 176)
                {
                    this.scr.h.y = 176;
                };
                this.itemList.y = (this.bg.y + (this.scr.h.y * ((this.bg.height - this.itemList.height) / 176)));
            };
        }

        public function onBack(_arg_1:MouseEvent=null):void
        {
            var _local_3:*;
            parent.removeChild(this);
            this.outfitPanel.interfaceOutfitSets.interfaceOutfitEdit = null;
            this.outfitPanel.interfaceOutfitSets.drawMenu();
            this.outfitPanel.interfaceOutfitSets.visible = true;
            this.outfitPanel.pAV.items = this.game.world.myAvatar.items.concat();
            this.outfitPanel.pAV.objData = this.outfitPanel.clone(this.game.world.myAvatar.objData);
            var _local_2:Array = ["he", "ba", "ar", "co", "Weapon", "pe", "am", "mi"];
            for each (_local_3 in _local_2)
            {
                if (this.outfitPanel.pAV.objData.eqp[_local_3] != null)
                {
                    this.outfitPanel.pAV.loadMovieAtES(_local_3, this.outfitPanel.pAV.objData.eqp[_local_3].sFile, this.outfitPanel.pAV.objData.eqp[_local_3].sLink);
                }
                else
                {
                    this.outfitPanel.pAV.unloadMovieAtES(_local_3);
                };
            };
        }

        public function onItemClick(_arg_1:MouseEvent):void
        {
            var _local_5:*;
            var _local_2:MovieClip = (_arg_1.currentTarget as MovieClip);
            var _local_3:* = this.getItem(_local_2.tName.text);
            if (((_local_3.bUpg == 1) && (!(this.game.world.myAvatar.isUpgraded()))))
            {
                this.game.MsgBox.notify("You must be upgraded in order to use this item.");
                return;
            };
            var _local_4:* = this.outfitPanel.pAV;
            if (((!(this.outfit[_local_3.sES])) || (!(this.outfit[_local_3.sES] == _local_3.ItemID))))
            {
                _local_4.objData.eqp[_local_3.sES] = _local_3;
                _local_5 = this.getItemMC(this.outfit[_local_3.sES]);
                if (_local_5)
                {
                    _local_5.eqpBG.visible = false;
                };
                this.outfit[_local_3.sES] = _local_3.ItemID;
                this.outfitPanel.pAV.equipItem(_local_3.ItemID);
                _local_4.loadMovieAtES(_local_3.sES, _local_3.sFile, _local_3.sLink);
                _local_2.eqpBG.visible = true;
            }
            else
            {
                if (((!(_local_3.sES == "ar")) && (!(_local_3.sES == "Weapon"))))
                {
                    delete _local_4.objData.eqp[_local_3.sES];
                    delete this.outfit[_local_3.sES];
                    this.outfitPanel.pAV.unequipItem(_local_3.ItemID);
                    _local_4.unloadMovieAtES(_local_3.sES);
                    _local_2.eqpBG.visible = false;
                };
            };
        }

        public function onReset(mouseEvent:MouseEvent):void
        {
            var search:* = (!(mouseEvent.currentTarget.name.indexOf("txtSearch") == -1));
            if (((search) && (this.txtSearch.text == "Search for an item")))
            {
                this.txtSearch.text = "";
            };
            if (((!(search)) && (this.txtSetName.text == "Set Name")))
            {
                this.txtSetName.text = "";
                this.mcPencil.visible = false;
            };
        }

        public function onPencil(_arg_1:MouseEvent):void
        {
            stage.focus = this.txtSetName;
            this.txtSetName.text = "";
            this.mcPencil.visible = false;
        }

        public function onSearch(event:Event):void
        {
            this.buildMenu(this.outfitPanel.pAV.items.filter(this.nameSearch).sort(itemSort));
        }


    }
}//package Main.Aqw.Outfit

