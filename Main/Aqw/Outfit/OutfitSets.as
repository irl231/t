// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.Outfit.OutfitSets

package Main.Aqw.Outfit
{
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import fl.motion.Color;
    import flash.filters.ColorMatrixFilter;
    import fl.motion.AdjustColor;
    import flash.events.MouseEvent;
    import flash.events.*;
    import fl.motion.*;
    import flash.filters.*;
    import Main.*;
    import Main.Aqw.Outfit.Button.*;

    public class OutfitSets extends Sprite 
    {

        private const pageIndicer:int = 6;

        public var btnLeft:SimpleButton;
        public var checkmark:MovieClip;
        public var txtPage:TextField;
        public var chkbox:MovieClip;
        public var btnWear:MovieClip;
        public var highlighter:MovieClip;
        public var btnEquip:MovieClip;
        public var btnRight:SimpleButton;
        public var interfaceOutfitEdit:OutfitEdit;
        public var outfitPanel:OutfitPanel;
        public var r:Game;
        public var world:World;
        public var keepColors:Boolean = false;
        internal var selected:int = -1;
        private var page:int = 0;
        private var pages:int;

        public function OutfitSets(_arg_1:OutfitPanel)
        {
            this.outfitPanel = _arg_1;
            this.r = _arg_1.r;
            this.world = _arg_1.world;
            this.initInterface();
        }

        public function initInterface():void
        {
            this.drawMenu();
            if (this.pages > 1)
            {
                if (!this.btnLeft.hasEventListener(MouseEvent.CLICK))
                {
                    this.btnLeft.addEventListener(MouseEvent.CLICK, this.onLeft, false, 0, true);
                    this.btnRight.addEventListener(MouseEvent.CLICK, this.onRight, false, 0, true);
                };
                this.applyBrightness(this.btnLeft, 0);
                this.applyBrightness(this.btnRight, 0);
            }
            else
            {
                this.applyBrightness(this.btnLeft);
                this.applyBrightness(this.btnRight);
            };
            this.btnWear.visible = Config.getBoolean("feature_wear");
            this.highlighter.mouseEnabled = false;
            this.btnEquip.addEventListener(MouseEvent.CLICK, this.onEquip, false, 0, true);
            this.btnWear.addEventListener(MouseEvent.CLICK, this.onWear, false, 0, true);
            this.checkmark.visible = this.keepColors;
            this.checkmark.mouseEnabled = false;
            this.chkbox.addEventListener(MouseEvent.CLICK, this.onCheckChanged, false, 0, true);
            this.outfitPanel.unlockinterface.btn2.addEventListener(MouseEvent.CLICK, this.onBuySlot, false, 0, true);
            this.outfitPanel.unlockinterface.btnClose.addEventListener(MouseEvent.CLICK, this.onBuySlotExit, false, 0, true);
        }

        public function applyBrightness(_arg_1:*, _arg_2:int=0):void
        {
            var _local_3:Color = new Color();
            _local_3.brightness = _arg_2;
            _arg_1.transform.colorTransform = _local_3;
        }

        public function drawMenu():void
        {
            var _local_7:int;
            var _local_8:Sprite;
            var _local_1:int = 5;
            while (_local_1 < this.numChildren)
            {
                if (this.getChildAt(_local_1).name.indexOf("set_") != -1)
                {
                    this.removeChild(this.getChildAt(_local_1));
                    _local_1--;
                };
                _local_1++;
            };
            this.highlighter.visible = false;
            this.selected = -1;
            this.setEnabled(this.btnEquip, false);
            this.setEnabled(this.btnWear, false);
            this.outfitPanel.sets.sortOn("name");
            this.pages = (Math.ceil((this.outfitPanel.slots / this.pageIndicer)) + 1);
            var _local_2:int = 1.45;
            var _local_3:int = -124.35;
            var _local_4:int = 55.55;
            var _local_5:int = 5.2;
            var _local_6:int = 40.15;
            var _local_9:int = (this.page * this.pageIndicer);
            while (_local_9 < ((this.page * this.pageIndicer) + this.pageIndicer))
            {
                if (this.outfitPanel.sets[_local_9])
                {
                    _local_8 = addChild(new OutfitButton());
                    _local_8.txtName.text = this.outfitPanel.sets[_local_9].name;
                    _local_8.txtName.mouseEnabled = false;
                    _local_8.btnMain.addEventListener(MouseEvent.CLICK, this.onEquipSet, false, 0, true);
                    _local_8.btnEdit.addEventListener(MouseEvent.CLICK, this.onEditSet, false, 0, true);
                    _local_8.btnDelete.addEventListener(MouseEvent.CLICK, this.onDeleteSet, false, 0, true);
                    _local_7 = 0;
                }
                else
                {
                    if (_local_9 < this.outfitPanel.slots)
                    {
                        _local_8 = addChild(new OutfitNewButton());
                        _local_8.addEventListener(MouseEvent.CLICK, this.onNewSet, false, 0, true);
                        _local_7 = 1;
                    }
                    else
                    {
                        _local_8 = addChild(new OutfitUnlockButton());
                        _local_8.addEventListener(MouseEvent.CLICK, this.onUnlock, false, 0, true);
                        _local_7 = 2;
                    };
                };
                _local_8.name = ("set_" + _local_9);
                _local_8.x = _local_2;
                if (_local_9 == (this.page * this.pageIndicer))
                {
                    _local_8.y = _local_3;
                }
                else
                {
                    switch (_local_7)
                    {
                        case 0:
                            _local_7 = _local_4;
                            break;
                        case 1:
                            _local_7 = _local_5;
                            break;
                        case 2:
                            _local_7 = _local_6;
                            break;
                    };
                    _local_8.y = ((getChildByName(("set_" + Number((_local_9 - 1)).toString())).y + getChildByName(("set_" + Number((_local_9 - 1)).toString())).height) + 5);
                };
                _local_9++;
            };
            this.txtPage.text = (((this.page + 1) + " / ") + this.pages);
        }

        public function positionHighlighter(_arg_1:int):void
        {
            this.highlighter.visible = true;
            this.highlighter.x = -144.6;
            this.highlighter.y = (_arg_1 - 17.5);
            this.setChildIndex(this.highlighter, (this.numChildren - 1));
        }

        public function setupEditor():void
        {
            this.outfitPanel.addChild(this.interfaceOutfitEdit);
            this.interfaceOutfitEdit.x = 715;
            this.interfaceOutfitEdit.y = 310;
            this.visible = false;
        }

        public function onServerResponseRemove(_arg_1:String):void
        {
            var _local_3:*;
            var _local_2:int;
            while (_local_2 < this.outfitPanel.sets.length)
            {
                _local_3 = this.outfitPanel.sets[_local_2];
                if (_local_3.name == _arg_1)
                {
                    this.outfitPanel.sets.splice(_local_2, 1);
                    this.drawMenu();
                    return;
                };
                _local_2++;
            };
        }

        internal function setEnabled(_arg_1:MovieClip, _arg_2:Boolean):void
        {
            var _local_3:ColorMatrixFilter;
            if (_arg_2)
            {
                _arg_1.buttonMode = true;
                _arg_1.filters = [];
                return;
            };
            var _local_4:AdjustColor = new AdjustColor();
            var _local_5:Array = [];
            _local_4.hue = 0;
            _local_4.saturation = -100;
            _local_4.brightness = 0;
            _local_4.contrast = 0;
            _local_5 = _local_4.CalculateFinalFlatArray();
            _local_3 = new ColorMatrixFilter(_local_5);
            _arg_1.buttonMode = false;
            _arg_1.filters = [_local_3];
        }

        private function handleEmpty(_arg_1:String):int
        {
            return ((_arg_1 == "") ? -1 : parseInt(_arg_1));
        }

        private function getItemByID(_arg_1:int):*
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

        public function onEquip(_arg_1:MouseEvent):void
        {
            var _local_2:Object;
            if (this.selected != -1)
            {
                if (!this.world.coolDown("equipLoadout"))
                {
                    this.outfitPanel.slowDown();
                    return;
                };
                _local_2 = this.outfitPanel.sets[this.selected];
                Game.root.network.send("equipLoadout", [_local_2.name, ((this.keepColors) ? 1 : 0)]);
                this.outfitPanel.onClose();
            };
        }

        public function onWear(_arg_1:MouseEvent):void
        {
            var _local_2:Object;
            if (this.selected != -1)
            {
                if (!this.world.coolDown("wearLoadout"))
                {
                    this.outfitPanel.slowDown();
                    return;
                };
                _local_2 = this.outfitPanel.sets[this.selected];
                Game.root.network.send("wearLoadout", [_local_2.name, ((this.keepColors) ? 1 : 0)]);
                this.outfitPanel.onClose();
            };
        }

        public function onLeft(_arg_1:MouseEvent):void
        {
            this.page--;
            if (this.page < 0)
            {
                this.page = (this.pages - 1);
            };
            this.drawMenu();
        }

        public function onRight(_arg_1:MouseEvent):void
        {
            this.page++;
            if (this.page > (this.pages - 1))
            {
                this.page = 0;
            };
            this.drawMenu();
        }

        public function onEquipSet(_arg_1:MouseEvent):void
        {
            var _local_5:*;
            var _local_6:Array;
            var _local_7:*;
            var _local_8:*;
            var _local_9:String;
            var _local_2:int;
            this.positionHighlighter(_arg_1.currentTarget.parent.y);
            this.selected = parseInt(_arg_1.currentTarget.parent.name.slice(4));
            this.setEnabled(this.btnEquip, true);
            this.setEnabled(this.btnWear, true);
            var _local_3:Array = ["he", "ba", "ar", "co", "Weapon", "pe", "am", "mi"];
            var _local_4:Object = this.outfitPanel.sets[this.selected];
            for each (_local_5 in _local_3)
            {
                if (_local_4[_local_5] != null)
                {
                    _local_8 = this.r.copyObj(this.getItemByID(_local_4[_local_5]));
                    if (_local_8)
                    {
                        this.outfitPanel.pAV.objData.eqp[_local_5] = _local_8;
                        this.outfitPanel.pAV.loadMovieAtES(_local_5, _local_8.sFile, _local_8.sLink);
                    }
                    else
                    {
                        _local_2++;
                        delete this.outfitPanel.pAV.objData.eqp[_local_5];
                        this.outfitPanel.pAV.unloadMovieAtES(_local_5);
                    };
                }
                else
                {
                    delete this.outfitPanel.pAV.objData.eqp[_local_5];
                    this.outfitPanel.pAV.unloadMovieAtES(_local_5);
                };
            };
            _local_6 = ["intColorHair", "intColorSkin", "intColorEye", "intColorBase", "intColorTrim", "intColorAccessory"];
            for each (_local_7 in _local_6)
            {
                _local_9 = _local_7.substr(8);
                _local_9 = (_local_9.charAt(0).toLowerCase() + _local_9.substr(1));
                if (_local_4.colors[_local_9])
                {
                    this.outfitPanel.pAV.objData[_local_7] = _local_4.colors[_local_9];
                };
            };
            if (_local_2 > 0)
            {
                this.r.MsgBox.notify((("Could not find " + _local_2) + " set item(s) in your inventory!"));
            };
        }

        public function onEditSet(_arg_1:MouseEvent):void
        {
            this.onEquipSet(_arg_1);
            this.interfaceOutfitEdit = new OutfitEdit(this.outfitPanel, parseInt(_arg_1.currentTarget.parent.name.slice(4)));
            this.setupEditor();
        }

        public function onDeleteSet(_arg_1:MouseEvent):void
        {
            if (!this.world.coolDown("removeLoadout"))
            {
                this.outfitPanel.slowDown();
                return;
            };
            var _local_2:Number = parseInt(_arg_1.currentTarget.parent.name.slice(4));
            Game.root.network.send("removeLoadout", [this.outfitPanel.sets[_local_2].name]);
        }

        public function onNewSet(_arg_1:MouseEvent):void
        {
            var _local_3:*;
            this.outfitPanel.pAV.items = this.world.myAvatar.items.concat();
            this.outfitPanel.pAV.objData = this.outfitPanel.clone(this.world.myAvatar.objData);
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
            this.interfaceOutfitEdit = new OutfitEdit(this.outfitPanel, -1);
            this.setupEditor();
        }

        public function onUnlock(_arg_1:MouseEvent):void
        {
            if (this.outfitPanel.slots >= Config.getInt("slot_outfit_max"))
            {
                this.r.MsgBox.notify("You have reached the maximum amount of available loadout slots.");
                return;
            };
            if (this.world.myAvatar.objData.intCoins < Config.getInt("slot_outfit_cost"))
            {
                this.r.MsgBox.notify((((("You need at least " + Config.getInt("slot_outfit_cost")) + " ") + Config.getString("coins_name_short")) + " to purchase a new loadout slot."));
                return;
            };
            this.outfitPanel.unlockinterface.visible = true;
            this.outfitPanel.setChildIndex(this.outfitPanel.unlockinterface, (this.outfitPanel.numChildren - 1));
        }

        private function onBuySlot(_arg_1:MouseEvent):void
        {
            Game.root.network.send("buyLoadoutSlots", [1]);
        }

        private function onBuySlotExit(_arg_1:MouseEvent):void
        {
            this.outfitPanel.unlockinterface.visible = false;
        }

        private function onCheckChanged(_arg_1:MouseEvent):void
        {
            this.keepColors = (!(this.keepColors));
            this.checkmark.visible = this.keepColors;
        }

        private function onOver(_arg_1:MouseEvent):void
        {
        }

        private function onOut(_arg_1:MouseEvent):void
        {
            this.outfitPanel.tt.close();
        }


    }
}//package Main.Aqw.Outfit

