// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildHall

package 
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import Main.Controller.*;

    public class GuildHall extends MovieClip 
    {

        private const lotPads:Object = {
            "Lot1":"Left",
            "Lot2":"Top2",
            "Lot3":"Top4",
            "Lot4":"Right"
        };
        private const padSpawnPairs:Object = {
            "Pad1":"Right",
            "Pad2":"Right",
            "Pad3":"Down1",
            "Pad4":"Down2",
            "Pad5":"Left",
            "Pad6":"Left",
            "Pad7":"Top3",
            "Pad8":"Right"
        };
        private const padPairs:Object = {
            "Pad1":"Pad5",
            "Pad2":"Pad6",
            "Pad3":"Pad7",
            "Pad4":"Pad8",
            "Pad5":"Pad1",
            "Pad6":"Pad2",
            "Pad7":"Pad3",
            "Pad8":"Pad4"
        };
        private const frameToBit:Object = {
            "fr1":0,
            "fr2":1,
            "fr3":2,
            "fr4":3,
            "fr5":4,
            "fr6":5
        };

        public var totalFiles:int;
        public var HallSize:int = -1;
        private var rootClass:Game;
        private var currentCell:String = "Enter";
        private var guildMap:MovieClip;
        private var currentLot:String = "";
        private var buildingsLoaded:int = 0;
        private var GuildMapGrid:guildHallMap;
        private var totalCells:int = 0;
        private var interiorMCs:Array;
        private var Menu:GuildMenu = null;
        public var inBuilding:Boolean = false;
        private var gInv:Object;
        private var Cells:Object = {};
        private var buildingFiles:Object = {};
        private var guildItemData:Object = {};
        private var buildingLinks:Object = {};

        public function GuildHall(guildData:Array, game:Game)
        {
            var cell:Cell;
            super();
            this.rootClass = game;
            var cellIds:Array = [];
            this.HallSize = ((this.rootClass.world.myAvatar != null) ? this.rootClass.world.myAvatar.objData.guild.HallSize : 15);
            var counter:uint;
            while (counter < guildData.length)
            {
                cell = new Cell(guildData[counter], this.rootClass, this);
                if (((cell.Name == "Enter") || (!(cell.Connection == null))))
                {
                    this.Cells[cell.Name] = cell;
                    cellIds = cellIds.concat(cell.IntIDs);
                    this.totalCells++;
                };
                counter++;
            };
            this.GuildMapGrid = new guildHallMap(this.Cells);
            this.GuildMapGrid.traceCellData();
            var bgList:Array = this.GuildMapGrid.getBGList("Enter");
            var counter2:uint;
            while (counter2 < bgList.length)
            {
                trace(((((("bgList[" + counter2) + "].frame: ") + bgList[counter2].frame) + " dir: ") + bgList[counter2].dir));
                counter2++;
                counter2++;
            };
            this.rootClass.network.send("guild", ["getInterior", cellIds]);
        }

        public function get GuildGrid():guildHallMap
        {
            return (this.GuildMapGrid);
        }

        public function get CurrentBG():MovieClip
        {
            return (this.Cells[this.currentCell].BgMovie);
        }

        public function get CurrentCell():String
        {
            return (this.currentCell);
        }

        public function get ItemData():Object
        {
            return (this.guildItemData);
        }

        public function get MCs():Array
        {
            return (this.interiorMCs);
        }

        public function get Inside():Boolean
        {
            return (this.inBuilding);
        }

        public function get bInt():Interior
        {
            return (this.Cells[this.currentCell].Buildings[this.currentLot].interior);
        }

        public function get Inventory():Object
        {
            return (this.gInv);
        }

        public function get Links():Object
        {
            return (this.buildingLinks);
        }

        public function get CellTotal():int
        {
            return (this.totalCells);
        }

        public function get Lots():int
        {
            return (this.HallSize);
        }

        public function get EditMode():Boolean
        {
            return (this.Menu.EditMode);
        }

        public function buildMenu():void
        {
            this.Menu = new GuildMenu(this.rootClass, this);
        }

        public function updateBuildingLoad():void
        {
            this.buildingsLoaded++;
            if (this.rootClass.world.mapLoadInProgress)
            {
                this.rootClass.mcConnDetail.showConn(((("Buildings Loaded... " + this.buildingsLoaded) + " of ") + this.totalFiles));
                if (this.buildingsLoaded == this.totalFiles)
                {
                    this.finishLoad();
                };
            };
        }

        public function changeCell(cell:String, connection:String):void
        {
            trace((((("[GUILDHALL] changeCell : (Name: " + cell) + ", Pad: ") + connection) + ")."));
            if (this.Cells[cell] == null)
            {
                return;
            };
            var connectionObject:Object = this.Cells[cell].Connection[connection];
            if (connectionObject == null)
            {
                return;
            };
            this.Cells[connectionObject.frame].loadInteriors();
            if (connectionObject != null)
            {
                this.rootClass.world.moveToCell(connectionObject.frame, connectionObject.pad);
            };
        }

        public function enterBuilding(pad:String):void
        {
            var label:*;
            trace((("[GUILDHALL] enterBuilding : (Name: " + pad) + ")."));
            var house:Object = this.Cells[this.currentCell].getHousePad(pad);
            this.currentLot = house.Lot;
            var building:MovieClip = this.Cells[this.currentCell].getBuildingMC(this.currentLot);
            this.rootClass.world.removeChild(this.rootClass.world.map);
            this.rootClass.world.map = building;
            this.rootClass.world.addChildAt(this.rootClass.world.map, 0).x = 0;
            for each (label in this.rootClass.world.map.currentLabels)
            {
                trace(((("Label name: " + label.name) + ", Frame number: ") + label.frame));
            };
            this.inBuilding = true;
            this.rootClass.world.moveToCell(house.Frame, house.Pad);
        }

        public function exitBuilding(frame:String):void
        {
            trace((("[GUILDHALL] exitBuilding: (Name: " + frame) + ")."));
            this.rootClass.world.removeChild(this.rootClass.world.map);
            this.rootClass.world.map = this.guildMap;
            this.rootClass.world.addChildAt(this.rootClass.world.map, 0).x = 0;
            trace((((("[GUILDHALL] exitBuilding: (Cell: " + this.currentCell) + ") (Pad: ") + this.lotPads[this.currentLot]) + ")."));
            this.rootClass.world.moveToCell(this.currentCell, this.lotPads[this.currentLot]);
            this.currentLot = "";
            this.inBuilding = false;
            if (this.Menu != null)
            {
                this.Menu.cellChange();
            };
        }

        public function createGuildCell(cell:String):MovieClip
        {
            trace((("[GUILDHALL] createGuildCell : (Name : " + cell) + ")."));
            this.currentCell = cell;
            this.loadAdjData();
            return (this.Cells[cell].BgMovie);
        }

        public function loadGuildMap(map:String):void
        {
            trace((("[GUILDHALL] loadGuildMap : (Name : " + map) + ")."));
            this.rootClass.mcConnDetail.showConn("Loading Guild Map Files...");
            if (((!(this.rootClass.world.map == null)) && (this.rootClass.world.contains(this.rootClass.world.map))))
            {
                this.rootClass.world.removeChild(this.rootClass.world.map);
                this.rootClass.world.map = null;
            };
            LoadController.singleton.addLoadMap(("maps/" + map), "map", this.onMapLoadComplete, this.onMapLoadError, this.onMapLoadProgress, true);
            this.rootClass.clearPopups();
        }

        public function addNewFrame(option:Object):void
        {
            trace("[GUILDHALL] addNewFrame.");
            var gridFrame:String = this.GuildMapGrid.EmptyFrame;
            if (gridFrame != "")
            {
                this.rootClass.network.send("guild", ["addFrame", gridFrame, option.linkage, this.currentCell, option.padName, int(option.buy), option.iCost, option.bCoins]);
            }
            else
            {
                this.rootClass.MsgBox.notify("You cannot buy any more land!");
            };
        }

        public function updateGuild():void
        {
            trace("[GUILDHALL] updateGuild.");
            this.GuildMapGrid = new guildHallMap(this.Cells);
        }

        public function addBuildingToCell(slot:String, _arg2:String, data:int):void
        {
            trace((((("[GUILDHALL] addBuildingToCell : (File : " + this.gInv[data].sFile) + ", Current : ") + data) + ")."));
            this.rootClass.network.send("guild", ["addBuilding", this.currentCell, slot, this.gInv[data].ItemID]);
        }

        public function destoryBuilding(_arg1:int):void
        {
            trace("[GUILDHALL] destoryBuilding");
            this.rootClass.network.send("guild", ["removeBuilding", this.currentCell, this.Cells[this.currentCell].Buildings[("Lot" + _arg1)].lot]);
        }

        public function removeConnection(cell:String, connection:String):void
        {
            trace((((("[GUILDHALL] removeConnection (Cell : " + cell) + ", Connection : ") + connection) + ")."));
            this.Cells[this.currentCell].removeConnection(connection);
            if (this.Cells[cell].ConnectionTotal == 1)
            {
                delete this.Cells[cell];
            }
            else
            {
                this.Cells[cell].removeConnection(this.padPairs[connection]);
            };
            this.GuildMapGrid.buildGuildMap();
        }

        public function updateItems(items:Object):void
        {
            trace("[GUILDHALL] updateItems.");
            this.guildItemData = items;
            this.Cells["Enter"].loadInteriors();
        }

        public function updateInterior():void
        {
            var counter:uint;
            trace("[GUILDHALL] updateInterior.");
            if (this.Menu != null)
            {
                this.Menu.cellChange();
            };
            if (this.interiorMCs != null)
            {
                counter = 0;
                while (counter < this.interiorMCs.length)
                {
                    this.rootClass.world.CHARS.removeChild(this.interiorMCs[counter]);
                    counter++;
                };
            };
            this.interiorMCs = [];
            if (this.currentLot != "")
            {
                this.Cells[this.currentCell].Buildings[this.currentLot].interior.addItems(this.rootClass.world.map.currentLabel);
            };
        }

        public function updateInventory(inventory:Object):void
        {
            var inventoryKey:String;
            var item:*;
            trace((("[GUILDHALL] updateInventory : (Name : " + inventory) + ")."));
            if (this.gInv == null)
            {
                this.gInv = {};
            };
            for (inventoryKey in inventory)
            {
                for (item in inventory[inventoryKey])
                {
                    trace(("i: " + JSON.stringify(item)));
                    if (((this.gInv[item] == null) || (inventoryKey == this.rootClass.world.myAvatar.objData.strUsername.toLowerCase())))
                    {
                        if (item != "Frames")
                        {
                            this.gInv[item] = inventory[inventoryKey][item];
                            this.gInv[item].unm = inventoryKey;
                        }
                        else
                        {
                            if (inventoryKey == this.rootClass.world.myAvatar.objData.strUsername.toLowerCase())
                            {
                                this.gInv[item] = inventory[inventoryKey][item];
                            };
                        };
                    };
                };
            };
        }

        public function handleHallUpdate(resObj:Object):void
        {
            var Item:* = undefined;
            var connection:Array;
            var counter:uint;
            var cell:Cell;
            trace((("[GUILDHALL] handleHallUpdate : (Name : " + resObj.gCmd) + ")."));
            var data:Array = [];
            var timer:Timer = new Timer(1000, 1);
            switch (resObj.gCmd)
            {
                case "addconnection":
                    this.Cells[resObj.cellA.strCell].editCellConnection(resObj.cellA);
                    this.Cells[resObj.cellB.strCell].editCellConnection(resObj.cellB);
                    if (resObj.Frame == this.rootClass.world.strFrame)
                    {
                        timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent):void
                        {
                            rootClass.world.moveToCell(rootClass.world.strFrame, rootClass.world.strPad);
                            trace((((("[GUILDHALL] Moved to cell: (Frame: " + rootClass.world.strFrame) + ") (Pad: ") + rootClass.world.strPad) + ")."));
                        });
                        timer.start();
                    };
                    this.updateGuild();
                    return;
                case "removeconnection":
                    this.Cells[resObj.cellA.strCell].editCellConnection(resObj.cellA);
                    if (resObj.doDelete)
                    {
                        delete this.Cells[resObj.cellB.strCell];
                        this.totalCells--;
                    }
                    else
                    {
                        this.Cells[resObj.cellB.strCell].editCellConnection(resObj.cellB);
                    };
                    this.updateGuild();
                    return;
                case "addframe":
                    this.Cells = {};
                    connection = [];
                    this.totalCells = 0;
                    counter = 0;
                    while (counter < resObj.guildHall.length)
                    {
                        cell = new Cell(resObj.guildHall[counter], this.rootClass, this);
                        if (((cell.Name == "Enter") || (!(cell.Connection == null))))
                        {
                            this.Cells[cell.Name] = cell;
                            connection = connection.concat(cell.IntIDs);
                            this.totalCells++;
                        };
                        cell.loadBuildings();
                        if (resObj.Frame == this.rootClass.world.strFrame)
                        {
                            timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent):void
                            {
                                rootClass.world.moveToCell(rootClass.world.strFrame, rootClass.world.strPad);
                                trace((((("[GUILDHALL] Moved to cell: (Frame: " + rootClass.world.strFrame) + ") (Pad: ") + rootClass.world.strPad) + ")."));
                            });
                        };
                        timer.start();
                        counter++;
                    };
                    this.updateGuild();
                    return;
                case "addbuilding":
                    this.Cells[resObj.Cell].updateBuildings(resObj.Buildings);
                    if (resObj.Frame == this.rootClass.world.strFrame)
                    {
                        timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent):void
                        {
                            rootClass.world.moveToCell(rootClass.world.strFrame, rootClass.world.strPad);
                            trace((((("[GUILDHALL] Moved to cell: (Frame: " + rootClass.world.strFrame) + ") (Pad: ") + rootClass.world.strPad) + ")."));
                        });
                        timer.start();
                    };
                    return;
                case "removeBuilding":
                    this.Cells[resObj.Cell].removeBuilding(("Lot" + String(resObj.Lot)));
                    return;
                case "guildShop":
                    for (Item in this.gInv)
                    {
                        if (Item != "Frames")
                        {
                            data.push(this.gInv[Item]);
                        };
                    };
                    this.Menu.openShop(resObj.shopinfo, data);
                    return;
                case "buyItem":
                    if (resObj.bitSuccess == 1)
                    {
                        this.gInv[String(resObj.Item.ItemID)] = resObj.Item;
                        this.rootClass.world.myAvatar.objData.intCoins = (this.rootClass.world.myAvatar.objData.intCoins - Number(resObj.Item.iCost));
                        this.rootClass.showItemDrop(resObj.Item, false);
                        for (Item in this.gInv)
                        {
                            if (Item != "Frames")
                            {
                                data.push(this.gInv[Item]);
                            };
                        };
                        this.Menu.refreshShop(data);
                    }
                    else
                    {
                        this.rootClass.MsgBox.notify(resObj.strMessage);
                    };
                    return;
                case "buyPlot":
                    if (resObj.bitSuccess == 1)
                    {
                        this.HallSize++;
                        this.rootClass.world.myAvatar.objData.intCoins = (this.rootClass.world.myAvatar.objData.intCoins - 1000);
                    };
                    return;
                case "removeItem":
                    delete this.gInv[String(resObj.ItemID)];
                    this.rootClass.world.myAvatar.objData.intCoins = (this.rootClass.world.myAvatar.objData.intCoins + Number(resObj.iCost));
                    for (Item in this.gInv)
                    {
                        if (Item != "Frames")
                        {
                            data.push(this.gInv[Item]);
                        };
                    };
                    this.Menu.refreshShop(data);
                    return;
                case "updateInterior":
                    this.Cells[resObj.Cell].updateInterior(resObj.interior);
                    this.updateInterior();
                    return;
            };
        }

        public function saveInterior():void
        {
            trace("[GUILDHALL] saveInterior.");
            this.rootClass.network.send("guild", ["saveInt", this.Cells[this.currentCell].CellIntStr, this.currentCell]);
        }

        public function destroyMenu():void
        {
            trace("[GUILDHALL] destroyMenu.");
            if (this.Menu != null)
            {
                this.Menu.Destory();
            };
        }

        public function getCell(cell:String):Cell
        {
            trace((("[GUILDHALL] getCell : (Cell : " + cell) + ")."));
            return (this.Cells[cell]);
        }

        public function getBuildingMCs(cell:String):Object
        {
            trace((("[GUILDHALL] getBuildingMCs : (Cell : " + cell) + ")."));
            return (this.Cells[cell].Buildings);
        }

        public function hasConnection(link:String):Boolean
        {
            trace((("[GUILDHALL] hasConnection : (Link : " + link) + ")."));
            return (!(this.Cells[this.currentCell].Connection[link] == null));
        }

        public function hasBuilding(lot:String, cell:String=""):Boolean
        {
            trace((((("[GUILDHALL] hasBuilding : (Lot : " + lot) + ", Cell : ") + cell) + ")."));
            if (cell == "")
            {
                return (this.Cells[this.currentCell].hasBuildingOnLot(lot));
            };
            return (this.Cells[cell].hasBuildingOnLot(lot));
        }

        public function getConnPad(connection:String):String
        {
            trace((("[GUILDHALL] getConnPad : (Pad : " + pad) + ")."));
            return (this.padSpawnPairs[connection]);
        }

        public function getPadPair(pad:String):String
        {
            trace((("[GUILDHALL] getPadPair : (Pad : " + pad) + ")."));
            return (this.padPairs[pad]);
        }

        public function getFrame(frame:String):Boolean
        {
            trace("[GUILDHALL] getFrame.");
            if (this.gInv.Frames == null)
            {
                return (this.frameToBit[frame] == 0);
            };
            return (!((this.gInv.Frames & Math.pow(2, this.frameToBit[frame])) == 0));
        }

        private function loadAllAssets(cell:String):void
        {
            var data:*;
            var connections:Object = this.Cells[cell].Connections;
            this.totalFiles = this.Cells[cell].loadBuildings();
            for (data in connections)
            {
                if (data != "")
                {
                    this.totalFiles = (this.totalFiles + this.Cells[connections[data].frame].loadBuildings());
                };
            };
            if (this.totalFiles > 0)
            {
                this.rootClass.mcConnDetail.showConn(((("Buildings Loaded... " + this.buildingsLoaded) + " of ") + this.totalFiles));
            }
            else
            {
                this.finishLoad();
            };
        }

        private function finishLoad():void
        {
            var guildMap:Number;
            trace("[GUILDHALL] finishLoad.");
            if (((!(this.rootClass.world.mondef == null)) && (this.rootClass.world.mondef.length)))
            {
                this.rootClass.world.initMonsters();
            }
            else
            {
                guildMap = (this.rootClass.world.addChildAt(this.rootClass.world.map, 0).x = 0);
                this.rootClass.world.CHARS.x = 0;
                this.rootClass.world.setSpawnPoint("", "");
                this.rootClass.world.enterMap();
            };
            this.rootClass.world.mapLoadInProgress = false;
        }

        private function loadAdjData():void
        {
            var connectionKey:String;
            var frame:String;
            for (connectionKey in this.Cells[this.currentCell].Connection)
            {
                if (connectionKey != "")
                {
                    frame = this.Cells[this.currentCell].Connection[connectionKey].frame;
                    if (this.Cells[frame] != null)
                    {
                        this.Cells[frame].loadBuildings();
                        this.Cells[frame].loadInteriors();
                    };
                };
            };
        }

        private function onMapLoadComplete(event:Event):void
        {
            trace((("[GUILDHALL] onMapLoadComplete : (Name : " + event) + ")."));
            this.rootClass.ui.visible = true;
            this.rootClass.world.map = MovieClip(event.target.content);
            this.guildMap = MovieClip(event.target.content);
            this.loadAllAssets("Enter");
        }

        private function onMapLoadProgress(event:ProgressEvent):void
        {
            var progress:int = int(Math.floor(((event.bytesLoaded / event.bytesTotal) * 100)));
            this.rootClass.mcConnDetail.showConn((("Loading Map... " + progress) + "%"));
        }

        private function onMapLoadError(event:IOErrorEvent):void
        {
            this.rootClass.world.mapLoadInProgress = false;
            this.rootClass.mcConnDetail.showError("Loading Map Files... Failed!");
        }


    }
}//package 

