// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//guildHallMap

package 
{
    import flash.geom.Point;
    import flash.geom.*;

    public class guildHallMap 
    {

        private const padDirection:Object = {
            "Pad1":new Point(-1, 0),
            "Pad2":new Point(-1, 1),
            "Pad3":new Point(0, 1),
            "Pad4":new Point(1, 1),
            "Pad5":new Point(1, 0),
            "Pad6":new Point(1, -1),
            "Pad7":new Point(0, -1),
            "Pad8":new Point(-1, -1)
        };
        private const padToLot:Object = {
            "Pad2":"1",
            "Pad3":"3",
            "Pad4":"4"
        };

        private var guildMap:Object;
        private var Cells:Object;

        public function guildHallMap(_arg_1:Object)
        {
            this.Cells = _arg_1;
            this.buildGuildMap();
        }

        public function get EmptyFrame():String
        {
            var i:int = 1;
            while (i < 16)
            {
                if (this.guildMap[("r" + String(i))] == null)
                {
                    return ("r" + String(i));
                };
                i++;
            };
            return ("");
        }

        public function buildGuildMap():void
        {
            this.guildMap = {};
            this.guildMap["Enter"] = new Point(0, 0);
            this.mapConnections(this.Cells["Enter"]);
        }

        public function traceCellData():void
        {
            var guildMapKey:String;
            for (guildMapKey in this.guildMap)
            {
                trace(((("guildMap[" + guildMapKey) + "]: ") + this.guildMap[guildMapKey]));
            };
        }

        public function getBGList(_arg_1:String):Array
        {
            var guildMapKey:String;
            var _local_3:int;
            var _local_4:int;
            var arr:Array = [];
            for (guildMapKey in this.guildMap)
            {
                _local_3 = (this.guildMap[guildMapKey].y - this.guildMap[_arg_1].y);
                _local_4 = (this.guildMap[guildMapKey].x - this.guildMap[_arg_1].x);
                if (((_local_3 == 1) && ((_local_4 >= -1) && (_local_4 <= 1))))
                {
                    arr.push({
                        "frame":guildMapKey,
                        "dir":_local_4
                    });
                };
            };
            return (arr);
        }

        public function hasAdjCell(_arg_1:String, _arg_2:Point):String
        {
            var guildMapKey:String;
            var subtract:Point;
            for (guildMapKey in this.guildMap)
            {
                subtract = this.guildMap[guildMapKey].subtract(this.guildMap[_arg_1]);
                if (subtract.equals(_arg_2))
                {
                    return (guildMapKey);
                };
            };
            return ("");
        }

        public function getAllAdjCells(_arg_1:String):Array
        {
            var padDirectionKey:String;
            var adjCell:String;
            var arr:Array = [];
            for (padDirectionKey in this.padDirection)
            {
                adjCell = this.hasAdjCell(_arg_1, this.padDirection[padDirectionKey]);
                if (adjCell != "")
                {
                    arr.push(adjCell);
                };
            };
            return (arr);
        }

        public function canConnect(_arg_1:String, _arg_2:String):int
        {
            var cell:String = this.hasAdjCell(_arg_1, this.padDirection[_arg_2]);
            return ((cell != "") ? ((this.Cells[cell].hasBuildingOnLot(this.padToLot[_arg_2])) ? 2 : 1) : 0);
        }

        public function getPadDirection(_arg_1:String):Point
        {
            return (this.padDirection[_arg_1]);
        }

        public function onLot(_arg_1:String):String
        {
            return (this.padToLot[_arg_1]);
        }

        public function hasAltPath(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String=""):Boolean
        {
            var connectionsKey:String;
            var frame:String;
            for (connectionsKey in this.Cells[_arg_1].Connections)
            {
                frame = this.Cells[_arg_1].Connections[connectionsKey].frame;
                if (((!((frame == _arg_2) || (frame == _arg_4))) && ((frame == _arg_3) || (this.hasAltPath(frame, _arg_2, _arg_3, _arg_1)))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function mapAllCells(_arg_1:Object, _arg_2:String, _arg_3:String):void
        {
            var _local_4:String;
            var _local_5:*;
            if (_arg_1["Enter"] != null)
            {
                return;
            };
            _arg_1[_arg_2] = true;
            for (_local_5 in this.Cells[_arg_2].Connections)
            {
                _local_4 = this.Cells[_arg_2].Connections[_local_5].frame;
                if (((!(_local_4 == _arg_3)) && (_arg_1[_local_4] == null)))
                {
                    if (this.Cells[_local_4].ConnectionTotal > 1)
                    {
                        this.mapAllCells(_arg_1, _local_4, _arg_2);
                    }
                    else
                    {
                        _arg_1[_local_4] = true;
                    };
                };
            };
        }

        private function mapConnections(_arg_1:Cell):void
        {
            var connectionsKey:String;
            var point:Point;
            if (_arg_1.Connections == null)
            {
                return;
            };
            for (connectionsKey in _arg_1.Connections)
            {
                if (((!(connectionsKey == "")) && (this.guildMap[_arg_1.Connections[connectionsKey].frame] == null)))
                {
                    point = this.guildMap[_arg_1.Name].add(this.padDirection[connectionsKey]);
                    this.guildMap[_arg_1.Connections[connectionsKey].frame] = point;
                    this.mapConnections(this.Cells[_arg_1.Connections[connectionsKey].frame]);
                };
            };
        }


    }
}//package 

