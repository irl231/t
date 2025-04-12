// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFLayout

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import Main.Model.Item;
    import Game_fla.mcPopup_323;
    import Game_fla.*;

    public class LPFLayout extends MovieClip 
    {

        public var panels:Array = [];
        public var fData:Object = {};
        public var w:int;
        public var h:int;
        public var panelID:int = 0;
        public var events:Object = {};
        public var sMode:String;
        public var iSel:Item;
        public var eSel:Item;

        public function LPFLayout():void
        {
            this.events = {};
            super();
        }

        public function update(_arg1:Object):void
        {
            _arg1 = this.handleUpdate(_arg1);
            this.notifyByEventType(_arg1);
        }

        public function notifyByEventType(data:Object):void
        {
            var arr:Array;
            var i:int;
            if (((!(data == null)) && (!(this.events[data.eventType] == null))))
            {
                arr = this.events[data.eventType];
                i = 0;
                while (i < arr.length)
                {
                    LPFFrame(arr[i]).notify(data);
                    i++;
                };
            };
        }

        public function registerForEvents(_arg1:LPFFrame, _arg2:Array):void
        {
            var _local3:String;
            var _local4:int;
            while (_local4 < _arg2.length)
            {
                _local3 = _arg2[_local4];
                if (this.events[_local3] == null)
                {
                    this.events[_local3] = [];
                };
                if (this.events[_local3].indexOf(_arg1) == -1)
                {
                    this.events[_local3].push(_arg1);
                };
                _local4++;
            };
        }

        public function unregisterFrame(_arg1:*):void
        {
            var _local2:String;
            var _local3:int;
            while (_local3 < _arg1.eventTypes.length)
            {
                _local2 = _arg1.eventTypes[_local3];
                if (this.events[_local2] == null)
                {
                    return;
                };
                while (this.events[_local2].indexOf(_arg1) > -1)
                {
                    this.events[_local2].splice(this.events[_local2].indexOf(_arg1), 1);
                };
                _local3++;
            };
        }

        public function addPanel(data:Object):LPFPanel
        {
            var panel:LPFPanel = LPFPanel(addChild(data.panel));
            panel.subscribeTo(this);
            this.panels.push({
                "mc":panel,
                "id":this.panelID++
            });
            panel.fOpen(data);
            return (panel);
        }

        public function delPanel(_arg1:*):void
        {
            var _local2:int;
            while (_local2 < this.panels.length)
            {
                if (this.panels[_local2].mc == _arg1)
                {
                    this.panels.splice(_local2, 1);
                };
                _local2++;
            };
            removeChild(_arg1);
        }

        public function fOpen(data:Object):void
        {
            this.fData = data.fData;
            this.x = data.r.x;
            this.y = data.r.y;
            this.w = data.r.w;
            this.h = data.r.h;
        }

        public function fClose():void
        {
            var mcPopup:mcPopup_323;
            while (this.panels.length > 0)
            {
                this.panels[0].mc.fClose();
                this.panels.shift();
            };
            if (parent != null)
            {
                mcPopup = mcPopup_323(parent);
                mcPopup.removeChild(this);
                mcPopup.onClose();
            };
        }

        public function getTabStates(item:Object=null, bank:Boolean=false):Array
        {
            var tab:Object;
            var tabs:Array = [{
                "sTag":"Show All",
                "icon":"iipack",
                "state":-1,
                "filter":"All",
                "mc":{}
            }, {
                "sTag":"Show only weapons",
                "icon":"iwsword",
                "state":-1,
                "filter":"Weapon",
                "mc":{}
            }, {
                "sTag":"Show only armor",
                "icon":"iiclass",
                "state":-1,
                "filter":"ar",
                "mc":{}
            }, {
                "sTag":"Show only helms",
                "icon":"iihelm",
                "state":-1,
                "filter":"he",
                "mc":{}
            }, {
                "sTag":"Show only capes",
                "icon":"iicape",
                "state":-1,
                "filter":"ba",
                "mc":{}
            }, {
                "sTag":"Show only pets",
                "icon":"iipet",
                "state":-1,
                "filter":"pe",
                "mc":{}
            }, {
                "sTag":"Show only amulets",
                "icon":"iin1",
                "state":-1,
                "filter":"am",
                "mc":{}
            }, {
                "sTag":"Show only items",
                "icon":"iibag",
                "state":-1,
                "filter":"it",
                "mc":{}
            }];
            if (item != null)
            {
                for each (tab in tabs)
                {
                    if (tab.filter == item.sES)
                    {
                        return ([tab]);
                    };
                };
                return ([tabs[0]]);
            };
            return (tabs);
        }

        public function getSortOrder():Array
        {
            return (["Sword", "Axe", "Gauntlet", "Dagger", "HandGun", "Rifle", "Gun", "Whip", "Bow", "Mace", "Polearm", "Staff", "Wand", "Class", "Armor", "Entity", "Helm", "Cape", "Misc", "Earring", "Ring", "Amulet", "Belt", "Pet", "House", "Wall Item", "Floor Item", "Enhancement", "Note", "Resource", "Item", "Quest Item", "ServerUse"]);
        }

        public function getFilterMap():Object
        {
            return ({
                "Weapon":["Sword", "Axe", "Gauntlet", "Dagger", "HandGun", "Rifle", "Gun", "Whip", "Bow", "Mace", "Polearm", "Staff", "Wand"],
                "ar":["Class", "Armor", "Entity"],
                "he":["Helm"],
                "ba":["Cape"],
                "pe":["Pet"],
                "am":["Misc", "Earring", "Amulet", "Necklace", "Belt", "Ring"],
                "it":["Enhancement", "Note", "Resource", "Item", "Quest Item", "ServerUse", "House", "Wall Item", "Floor Item"],
                "enh":["Enhancement"]
            });
        }

        protected function handleUpdate(_arg1:Object):Object
        {
            return (_arg1);
        }

        protected function tempFill():void
        {
        }


    }
}//package Main.Aqw.LPF

