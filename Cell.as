// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Cell

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public class Cell 
    {

        private const Arrows:Object = {
            "Pad1":"arrow1",
            "Pad2":"arrow2",
            "Pad3":"arrow3",
            "Pad4":"arrow4",
            "Pad5":"arrow5",
            "Pad6":"arrow6",
            "Pad7":"arrow7",
            "Pad8":"arrow8"
        };

        public var parent:MovieClip;
        private var cellName:String;
        private var cellLinkage:String;
        private var incConn:int = 0;
        private var buildings:Object;
        private var mcBg:MovieClip;
        private var game:Game;
        private var cellSetup:Boolean = false;
        private var loaders:*;
        private var lotLoading:String = "";
        private var totalConnections:int = 0;
        private var cellObjects:Interior;
        private var ID:int = -1;
        private var cellConnections:Object = {};
        private var buildingPads:Object = {};
        private var cellIDs:Array = [];

        public function Cell(guildData:Object, game:Game, guildHall:GuildHall)
        {
            var split:Array;
            var i:int;
            var split1:Array;
            var split3:Array;
            var i1:int;
            var building:Building;
            super();
            this.buildings = {};
            this.game = game;
            this.parent = guildHall;
            this.ID = guildData.ID;
            this.cellName = guildData.strCell;
            this.cellLinkage = guildData.strLinkage;
            if (guildData.strConnections != null)
            {
                split = guildData.strConnections.split("|");
                this.totalConnections = split.length;
                i = 0;
                while (i < split.length)
                {
                    split1 = split[i].split(",");
                    this.cellConnections[split1[0]] = {
                        "frame":split1[1],
                        "pad":split1[2]
                    };
                    i++;
                };
            };
            if (guildData.strInterior == null)
            {
                guildData.strInterior = "|||";
            };
            var split2:Array = guildData.strInterior.split("|");
            if (((!(guildData.strBuildings == null)) && (!(guildData.strBuildings == ""))))
            {
                split3 = guildData.strBuildings.split("|");
                i1 = 0;
                while (i1 < split3.length)
                {
                    building = new Building(split3[i1], "", this, this.game);
                    this.buildings[("Lot" + String(building.lot))] = building;
                    this.checkSize(building);
                    this.parent.Links[building.Link] = true;
                    building.interior = new Interior(split2[(building.lot - 1)], this.game, this.parent);
                    i1++;
                };
            };
        }

        public function get Name():String
        {
            return (this.cellName);
        }

        public function get Connections():Object
        {
            return (this.cellConnections);
        }

        public function get BgMovie():MovieClip
        {
            if (this.mcBg == null)
            {
                this.createBgMovie();
            };
            return (this.mcBg);
        }

        public function get Buildings():Object
        {
            return (this.buildings);
        }

        public function get ConnectionTotal():int
        {
            return (this.totalConnections);
        }

        public function get Connection():Object
        {
            return (this.cellConnections);
        }

        public function get IntIDs():Array
        {
            var _local_2:*;
            var _local_1:Array = [];
            _local_1 = _local_1.concat(this.cellIDs);
            for (_local_2 in this.buildings)
            {
                _local_1 = _local_1.concat(this.buildings[_local_2].interior.IDs);
            };
            return (_local_1);
        }

        public function get CellIntStr():String
        {
            var c:String = "";
            var i:int = 1;
            while (i < 5)
            {
                c = (c + (((!(this.buildings[("Lot" + String(i))] == null)) && (!(this.buildings[("Lot" + String(i))] == this.buildings[("Lot" + String((i - 1)))]))) ? (this.buildings[("Lot" + String(i))].interior.IntStr + "|") : "|"));
                i++;
            };
            return (c.substr(0, (c.length - 1)));
        }

        public function displayBuildings():void
        {
            var buildingsKey:String;
            for (buildingsKey in this.buildings)
            {
                if (!this.buildings[buildingsKey].bLoaded)
                {
                    this.buildings[buildingsKey].Load();
                }
                else
                {
                    this.addBuildingToMap(buildingsKey);
                };
            };
        }

        public function addBuildingToMap(_arg_1:String):void
        {
            var _local_2:MovieClip = this.buildings[_arg_1].BuildingExt;
            _local_2.x = ((240 * (this.buildings[_arg_1].lot - 1)) + (_local_2.width >> 1));
            _local_2.y = 275;
            if (!this.buildings[_arg_1].cellSetup)
            {
                this.buildingSetup(_local_2, this.buildings[_arg_1].lot);
                this.buildings[_arg_1].cellSetup = true;
            };
            this.mcBg.addChild(_local_2);
        }

        public function loadBuildings():int
        {
            var _local_1:int;
            var buildingsKey:String;
            for (buildingsKey in this.buildings)
            {
                if (((!(this.buildings[buildingsKey].bLoaded)) && (!(this.buildings[buildingsKey].bLoading))))
                {
                    _local_1 = (_local_1 + this.buildings[buildingsKey].loadBuildingFile());
                };
            };
            return (_local_1);
        }

        public function editCellConnection(c:Object):void
        {
            var cellConn:Array;
            var connInfo:Array;
            var i:uint;
            var s:* = undefined;
            this.cellConnections = {};
            if (c.strConnections != null)
            {
                cellConn = c.strConnections.split("|");
                this.totalConnections = cellConn.length;
                i = 0;
                while (i < cellConn.length)
                {
                    connInfo = cellConn[i].split(",");
                    this.cellConnections[connInfo[0]] = {
                        "frame":connInfo[1],
                        "pad":connInfo[2]
                    };
                    i++;
                };
            };
            if (this.cellName == this.parent.CurrentCell)
            {
                for (s in this.Arrows)
                {
                    try
                    {
                        if (this.cellConnections[s] == null)
                        {
                            this.mcBg[this.Arrows[s]].visible = ((s == "Pad1") || (s == "Pad5"));
                        }
                        else
                        {
                            if (((s == "Pad1") || (s == "Pad5")))
                            {
                                this.mcBg[this.Arrows[s]].visible = false;
                            };
                        };
                    }
                    catch(e:Error)
                    {
                    };
                };
            }
            else
            {
                this.mcBg = null;
            };
        }

        public function removeConnection(_arg_1:String):void
        {
            delete this.cellConnections[_arg_1];
            this.totalConnections--;
        }

        public function updateBuildings(_arg_1:String):void
        {
            var _local_3:Building;
            var _local_4:uint;
            var _local_2:Array = _arg_1.split("|");
            while (_local_4 < _local_2.length)
            {
                _local_3 = new Building(_local_2[_local_4], "", this, this.game);
                if (this.buildings[("Lot" + String(_local_3.lot))] == null)
                {
                    this.buildings[("Lot" + String(_local_3.lot))] = _local_3;
                    this.checkSize(_local_3);
                };
                _local_3.interior = new Interior("", this.game, this.parent);
                if (this.cellName == this.parent.CurrentCell)
                {
                    this.lotLoading = ("Lot" + String(_local_3.lot));
                    this.parent.Links[_local_3.Link] = true;
                    _local_3.loadBuildingFile();
                    this.addBuildingToFrame();
                };
                _local_4++;
            };
        }

        public function removeBuilding(_arg_1:String):void
        {
            var _local_3:MovieClip;
            var _local_4:*;
            var _local_5:Building;
            var _local_2:MovieClip = this.buildings[_arg_1].BuildingExt;
            for (_local_4 in _local_2.pads)
            {
                this.mcBg.removeChild(this.mcBg.getChildByName((_arg_1 + _local_2.pads[_local_4].padName)));
            };
            try
            {
                this.game.world.removeChild(this.buildings[_arg_1].BuildingMap);
            }
            catch(err)
            {
            };
            this.mcBg.removeChild(_local_2);
            delete this.parent.Links[this.buildings[_arg_1].Link];
            _local_5 = this.buildings[_arg_1];
            for (_local_4 in this.buildings)
            {
                if (this.buildings[_local_4] == _local_5)
                {
                    delete this.buildings[_local_4];
                };
            };
            this.game.world.cellSetup(0.8, 8, "normal");
        }

        public function loadInteriors():void
        {
            var _local_1:*;
            for (_local_1 in this.buildings)
            {
                if (this.buildings[_local_1].interior != null)
                {
                    this.buildings[_local_1].interior.loadAllItems();
                };
            };
        }

        public function showNewConnection():void
        {
            var _local_1:*;
            for (_local_1 in this.Arrows)
            {
                try
                {
                    this.mcBg[this.Arrows[_local_1]].visible = ((this.cellConnections[_local_1] == null) ? ((_local_1 == "Pad1") || (_local_1 == "Pad5")) : (!((_local_1 == "Pad1") || (_local_1 == "Pad5"))));
                }
                catch(e:Error)
                {
                };
            };
        }

        public function updateInterior(_arg_1:String):void
        {
            var _local_3:*;
            var _local_2:Array = _arg_1.split("|");
            for (_local_3 in this.buildings)
            {
                this.buildings[_local_3].interior = new Interior(_local_2[(this.buildings[_local_3].lot - 1)], this.game, this.parent);
                this.buildings[_local_3].interior.loadAllItems();
            };
        }

        public function hasBuildingOnLot(_arg_1:String):Boolean
        {
            return ((_arg_1 == null) ? false : (!(this.buildings[("Lot" + _arg_1)] == null)));
        }

        public function getBuildingMC(_arg_1:String):MovieClip
        {
            return (this.buildings[_arg_1].BuildingMap);
        }

        public function getHousePad(_arg_1:String):Object
        {
            return (this.buildingPads[_arg_1]);
        }

        private function checkSize(_arg_1:Building):*
        {
            switch (_arg_1.Size)
            {
                case 2:
                    this.buildings[("Lot" + String((_arg_1.lot + 1)))] = _arg_1;
                    return;
                case 3:
                    this.buildings[("Lot" + String((_arg_1.lot + 1)))] = _arg_1;
                    this.buildings[("Lot" + String((_arg_1.lot + 2)))] = _arg_1;
                    return;
                case 4:
                    this.buildings[("Lot" + String((_arg_1.lot + 1)))] = _arg_1;
                    this.buildings[("Lot" + String((_arg_1.lot + 2)))] = _arg_1;
                    this.buildings[("Lot" + String((_arg_1.lot + 3)))] = _arg_1;
                    return;
            };
        }

        private function createBgMovie():void
        {
            var arrowsKey:String;
            var frame:Class = this.game.world.map.getFrame(this.cellLinkage);
            this.mcBg = (new (frame)() as MovieClip);
            for (arrowsKey in this.Arrows)
            {
                try
                {
                    if (this.cellConnections[arrowsKey] == null)
                    {
                        this.mcBg[this.Arrows[arrowsKey]].visible = ((arrowsKey == "Pad1") || (arrowsKey == "Pad5"));
                    }
                    else
                    {
                        if (((arrowsKey == "Pad1") || (arrowsKey == "Pad5")))
                        {
                            this.mcBg[this.Arrows[arrowsKey]].visible = false;
                        };
                    };
                }
                catch(e:Error)
                {
                    trace(("[CELL] createBgMovie " + e));
                };
            };
            this.displayBuildings();
        }

        private function buildingSetup(_arg_1:MovieClip, _arg_2:int, _arg_3:Boolean=false):void
        {
            var _local_4:MovieClip;
            var _local_5:Class;
            var _local_6:MovieClip;
            var _local_7:*;
            for (_local_7 in _arg_1.pads)
            {
                _local_5 = this.game.world.map.getFrame("GotoCell");
                _local_4 = (new (_local_5)() as MovieClip);
                _local_4.x = (_arg_1.x + _arg_1.pads[_local_7].X);
                _local_4.y = (275 + _arg_1.pads[_local_7].Y);
                _local_4.height = _arg_1.pads[_local_7].H;
                _local_4.width = _arg_1.pads[_local_7].W;
                this.mcBg.addChild(_local_4);
                _local_4.name = (("Lot" + String(_arg_2)) + _arg_1.pads[_local_7].padName);
                this.buildingPads[_local_4.name] = {
                    "Lot":("Lot" + String(_arg_2)),
                    "Frame":_arg_1.pads[_local_7].strFrame,
                    "Pad":_arg_1.pads[_local_7].strPad
                };
                if (_arg_3)
                {
                    this.game.world.arrEvent.push(MovieClip(_local_4));
                };
            };
        }

        private function addBuildingToFrame():void
        {
            if (this.buildings[this.lotLoading].bLoaded)
            {
                this.addBuildingToMap(this.lotLoading);
            }
            else
            {
                this.buildings[this.lotLoading].Load();
            };
        }


    }
}//package 

