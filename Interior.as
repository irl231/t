// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Interior

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Interior 
    {

        private var totalItems:int = 0;
        private var itemIDs:Array = new Array();
        private var rootClass:Game;
        private var frames:Object = new Object();
        private var guildRoot:MovieClip;
        private var Loaders:Object = new Object();
        private var placeNow:Boolean = false;

        public function Interior(inter:String, r:MovieClip, gr:MovieClip)
        {
            var itemTokens:Array;
            var itemDetail:Array;
            var i:uint;
            super();
            this.rootClass = r;
            this.guildRoot = gr;
            try
            {
                itemTokens = inter.split(":");
            }
            catch(e)
            {
                itemTokens = "".split(":");
            };
            while (i < itemTokens.length)
            {
                itemDetail = itemTokens[i].split(",");
                if (itemDetail[3] != undefined)
                {
                    if (this.frames[itemDetail[3]] == null)
                    {
                        this.frames[itemDetail[3]] = new Array();
                    };
                    this.itemIDs.push(itemDetail[0]);
                    if (itemDetail.length > 4)
                    {
                        this.frames[itemDetail[3]].push({
                            "pos":new Point(Number(itemDetail[1]), Number(itemDetail[2])),
                            "itemID":itemDetail[0],
                            "fct":itemDetail[4],
                            "val":itemDetail[5]
                        });
                    }
                    else
                    {
                        this.frames[itemDetail[3]].push({
                            "pos":new Point(Number(itemDetail[1]), Number(itemDetail[2])),
                            "itemID":itemDetail[0]
                        });
                    };
                };
                i++;
            };
        }

        private function loadInterior(_arg_1:String, _arg_2:String, _arg_3:int):void
        {
            this.Loaders[String(_arg_3)] = new GuildLoader(this.onItemLoadComplete, _arg_1, this.rootClass, _arg_2, _arg_3);
        }

        public function onItemLoadComplete(_arg_1:GuildLoader):void
        {
            this.guildRoot.ItemData[String(_arg_1.ID)].c = _arg_1.swfClass;
            if (((!(this.guildRoot.ItemData[String(_arg_1.ID)].sMeta == null)) && (this.guildRoot.ItemData[String(_arg_1.ID)].sMeta.indexOf("NPC") > -1)))
            {
                this.guildRoot.ItemData[String(_arg_1.ID)].aClass = _arg_1.getClass((this.guildRoot.ItemData[String(_arg_1.ID)].sLink + "_APOP"));
            };
            delete this.Loaders[String(_arg_1.ID)];
        }

        private function onItemClick(_arg_1:MouseEvent):void
        {
            var _local_3:Object;
            var _local_2:* = this.guildRoot.ItemData[String(_arg_1.currentTarget.name)];
            if (_local_2 == null)
            {
                return;
            };
            if (this.guildRoot.EditMode)
            {
                return;
            };
            if (MovieClip(_arg_1.currentTarget).x < 480)
            {
                _local_3 = {
                    "npcLinkage":(_local_2.sLink + "_NPC"),
                    "npcEntry":"left",
                    "cnt":(_local_2.sLink + "_APOP"),
                    "scene":"none"
                };
            }
            else
            {
                _local_3 = {
                    "npcLinkage":(_local_2.sLink + "_NPC"),
                    "npcEntry":"right",
                    "cnt":(_local_2.sLink + "_APOP"),
                    "scene":"none"
                };
            };
            var _local_4:MovieClip = this.rootClass.world.attachMovieFront("Apop");
            _local_4.updateWithClasses(_local_3, this.guildRoot.ItemData[String(_arg_1.currentTarget.name)].c, this.guildRoot.ItemData[String(_arg_1.currentTarget.name)].aClass);
        }

        public function addItems(f:String):void
        {
            var mc:MovieClip;
            var i:uint;
            if (this.frames[f] == null)
            {
                return;
            };
            i = 0;
            while (i < this.frames[f].length)
            {
                try
                {
                    mc = new this.guildRoot.ItemData[this.frames[f][i].itemID].c();
                    mc.x = this.frames[f][i].pos.x;
                    mc.y = this.frames[f][i].pos.y;
                    mc.name = this.frames[f][i].itemID;
                    if (((!(this.guildRoot.ItemData[this.frames[f][i].itemID].sMeta == null)) && (this.guildRoot.ItemData[this.frames[f][i].itemID].sMeta.indexOf("NPC") > -1)))
                    {
                        mc.scaleX = (mc.scaleY = 0.2);
                        if (mc.x > 480)
                        {
                            mc.scaleX = (mc.scaleX * -1);
                        };
                        mc.addEventListener(MouseEvent.CLICK, this.onItemClick, false, 0, true);
                    };
                    mc.scaleX = (mc.scaleX * this.rootClass.world.Scale);
                    mc.scaleY = (mc.scaleY * this.rootClass.world.Scale);
                    this.rootClass.world.CHARS.addChild(mc);
                    this.guildRoot.MCs.push(mc);
                }
                catch(e)
                {
                    trace(e);
                };
                i++;
            };
        }

        public function loadAllItems():void
        {
            var i:uint;
            try
            {
                i = 0;
                while (i < this.itemIDs.length)
                {
                    if (this.guildRoot.ItemData[this.itemIDs[i]].c == null)
                    {
                        try
                        {
                            if (((!(this.guildRoot.ItemData[this.itemIDs[i]].sMeta == null)) && (this.guildRoot.ItemData[this.itemIDs[i]].sMeta.indexOf("NPC") > -1)))
                            {
                                this.loadInterior(this.guildRoot.ItemData[this.itemIDs[i]].sFile, (this.guildRoot.ItemData[this.itemIDs[i]].sLink + "_NPC"), int(this.itemIDs[i]));
                            }
                            else
                            {
                                this.loadInterior(this.guildRoot.ItemData[this.itemIDs[i]].sFile, this.guildRoot.ItemData[this.itemIDs[i]].sLink, int(this.itemIDs[i]));
                            };
                        }
                        catch(e)
                        {
                            loadInterior(guildRoot.ItemData[itemIDs[i]].sFile, guildRoot.ItemData[itemIDs[i]].sLink, int(itemIDs[i]));
                        };
                    };
                    i++;
                };
            }
            catch(e)
            {
                return;
            };
        }

        public function addNewItem(_arg_1:String, _arg_2:Point, _arg_3:Object, _arg_4:Class):void
        {
            if (this.frames[_arg_1] == null)
            {
                this.frames[_arg_1] = new Array();
            };
            this.frames[_arg_1].push({
                "pos":_arg_2,
                "itemID":_arg_3.ItemID
            });
            if (this.guildRoot.ItemData[_arg_3.ItemID] == null)
            {
                this.guildRoot.ItemData[_arg_3.ItemID] = _arg_3;
                this.guildRoot.ItemData[_arg_3.ItemID].c = _arg_4;
                this.itemIDs.push(_arg_3.ItemID);
            };
        }

        public function removeItem(_arg_1:String, _arg_2:String):void
        {
            var _local_3:uint;
            var _local_4:uint;
            if (this.frames[_arg_1] == null)
            {
                return;
            };
            while (_local_3 < this.frames[_arg_1].length)
            {
                if (this.frames[_arg_1][_local_3].itemID == _arg_2)
                {
                    this.frames[_arg_1].splice(_local_3, 1);
                    break;
                };
                _local_3++;
            };
            while (_local_4 < this.itemIDs.length)
            {
                if (this.itemIDs[_local_4] == _arg_2)
                {
                    this.itemIDs.splice(_local_4, 1);
                    return;
                };
                _local_4++;
            };
        }

        public function updateItem(_arg_1:String, _arg_2:Point, _arg_3:String):void
        {
            var _local_4:uint;
            if (this.frames[_arg_1] == null)
            {
                return;
            };
            while (_local_4 < this.frames[_arg_1].length)
            {
                if (this.frames[_arg_1][_local_4].itemID == _arg_3)
                {
                    this.frames[_arg_1][_local_4].pos = _arg_2;
                };
                _local_4++;
            };
        }

        public function checkItemID(_arg_1:int):Boolean
        {
            var _local_2:uint;
            if (this.itemIDs.length < 1)
            {
                return (false);
            };
            while (_local_2 < this.itemIDs.length)
            {
                if (int(this.itemIDs[_local_2]) == _arg_1)
                {
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }

        public function get IDs():Array
        {
            return (this.itemIDs);
        }

        public function get IntStr():String
        {
            var _local_2:*;
            var _local_3:uint;
            var _local_1:* = "";
            for (_local_2 in this.frames)
            {
                if (_local_2 != "undefined")
                {
                    _local_3 = 0;
                    while (_local_3 < this.frames[_local_2].length)
                    {
                        if (this.frames[_local_2][_local_3].fct != null)
                        {
                            _local_1 = ((((((((((((_local_1 + this.frames[_local_2][_local_3].itemID) + ",") + this.frames[_local_2][_local_3].pos.x) + ",") + this.frames[_local_2][_local_3].pos.y) + ",") + _local_2) + ",") + this.frames[_local_2][_local_3].fct) + ",") + this.frames[_local_2][_local_3].val) + ":");
                        }
                        else
                        {
                            _local_1 = ((((((((_local_1 + this.frames[_local_2][_local_3].itemID) + ",") + this.frames[_local_2][_local_3].pos.x) + ",") + this.frames[_local_2][_local_3].pos.y) + ",") + _local_2) + ":");
                        };
                        _local_3++;
                    };
                };
            };
            _local_1 = _local_1.substr(0, (_local_1.length - 1));
            return (_local_1);
        }

        public function getItemCount(_arg_1:String):int
        {
            if (this.frames[_arg_1] == null)
            {
                return (0);
            };
            return (this.frames[_arg_1].length);
        }


    }
}//package 

