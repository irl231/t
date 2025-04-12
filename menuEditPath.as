// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//menuEditPath

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class menuEditPath extends MovieClip 
    {

        private const frameCosts:Object = {
            "fr1":{
                "iCost":0,
                "bCoins":true
            },
            "fr2":{
                "iCost":1000,
                "bCoins":true
            },
            "fr3":{
                "iCost":100,
                "bCoins":true
            },
            "fr4":{
                "iCost":2000,
                "bCoins":true
            },
            "fr5":{
                "iCost":2500,
                "bCoins":true
            },
            "fr6":{
                "iCost":3000,
                "bCoins":true
            }
        };

        private var gMap:guildHallMap;
        private var Preview:MovieClip;
        private var game:Game;
        private var guildHall:GuildHall;
        private var frameObj:Object;
        private var btn:MovieClip;
        private var Parent:GuildMenu;

        public function menuEditPath(p:MovieClip, game:Game, g:guildHallMap, button:MovieClip, guildHall:GuildHall, guildMenu:GuildMenu, Add:Boolean)
        {
            var connType:int;
            var mcList:MovieClip;
            var toCell:String;
            var c:Object;
            var i:int;
            super();
            this.Preview = p;
            this.game = game;
            this.gMap = g;
            this.guildHall = guildHall;
            this.btn = button;
            this.Parent = guildMenu;
            var padName:String = ("Pad" + this.btn.name);
            if (Add)
            {
                connType = this.gMap.canConnect(this.guildHall.CurrentCell, ("Pad" + String(this.btn.name)));
                if (this.Preview != null)
                {
                    this.game.world.map.removeChild(this.Preview);
                    this.Preview = null;
                };
                if (connType == 1)
                {
                    MainController.modal("Would you like to connect to the adjacent frame?", this.createConnection, {
                        "arrow":this.btn.name,
                        "toCell":this.gMap.hasAdjCell(this.guildHall.CurrentCell, this.gMap.getPadDirection(padName))
                    });
                    this.btn.removeEventListener(MouseEvent.CLICK, this.Parent.padEditClick);
                }
                else
                {
                    if (connType != 2)
                    {
                        if (this.guildHall.CellTotal >= this.guildHall.Lots)
                        {
                            MainController.modal("You do not own anymore land, please buy more before adding a new area.", null, {}, null, "mono");
                            return;
                        };
                        if (game.ui.GuildHallPop.getChildByName("guildHallLand") != null)
                        {
                            MainController.modal("Please remove the land preview first.", null, {}, null, "mono");
                            return;
                        };
                        this.frameObj = {};
                        this.frameObj.padName = padName;
                        this.frameObj.btn = this.btn;
                        this.Preview = (new LandPreview() as MovieClip);
                        this.Preview.imask.visible = false;
                        this.Preview.x = 300;
                        this.Preview.y = 200;
                        this.Preview.mcPreview.mask = this.Preview.cntMask;
                        this.Preview.btnAdd.visible = false;
                        this.game.ui.GuildHallPop.addChild(this.Preview);
                        this.Preview.btnAdd.addEventListener(MouseEvent.CLICK, this.addNewFrame, false, 0, true);
                        this.Preview.mcHeader.buttonMode = true;
                        this.Preview.name = "guildHallLand";
                        this.Preview.txtTitle.mouseEnabled = false;
                        this.Preview.mcHeader.addEventListener(MouseEvent.MOUSE_DOWN, onDragIn);
                        this.Preview.btnClose.addEventListener(MouseEvent.CLICK, this.onClose);
                        this.Preview.btnAdd.buttonMode = true;
                        this.btn.removeEventListener(MouseEvent.CLICK, this.Parent.padEditClick);
                        i = 0;
                        while (i < this.game.world.map.mapFrames.length)
                        {
                            mcList = (new LandList() as MovieClip);
                            mcList.x = 3;
                            mcList.y = (28 + (mcList.height * i));
                            this.Preview.addChild(mcList);
                            mcList.lTxt.text = this.game.world.map.mapFrames[i];
                            mcList.btn.addEventListener(MouseEvent.CLICK, this.onFrameClick, false, 0, true);
                            i++;
                        };
                    };
                };
            }
            else
            {
                try
                {
                    toCell = this.gMap.hasAdjCell(this.guildHall.CurrentCell, this.gMap.getPadDirection(padName));
                    if (((!(this.guildHall.CurrentCell == "Enter")) && (this.guildHall.getCell(this.guildHall.CurrentCell).ConnectionTotal == 1)))
                    {
                        MainController.modal("You cannot remove this connection, try removing the adjacent frame.", null, {}, null, "mono");
                        return;
                    };
                    c = {};
                    this.gMap.mapAllCells(c, toCell, this.guildHall.CurrentCell);
                    if ((((c["Enter"] == null) && (c[this.guildHall.CurrentCell] == null)) && (this.guildHall.getCell(toCell).ConnectionTotal > 1)))
                    {
                        MainController.modal("Need alternate connections first.", null, {}, null, "mono");
                        return;
                    };
                    MainController.modal(((this.guildHall.getCell(toCell).ConnectionTotal == 1) ? "Would you like to remove this connection? Frame will be deleted as well" : "Would you like to remove the connection?"), this.destroyConnection, {
                        "arrow":this.btn.name,
                        "toCell":toCell
                    });
                }
                catch(e:Error)
                {
                };
            };
        }

        private static function onDragIn(event:MouseEvent):void
        {
            event.currentTarget.parent.startDrag();
            event.currentTarget.addEventListener(MouseEvent.MOUSE_UP, onDragOut);
        }

        private static function onDragOut(event:MouseEvent):void
        {
            event.currentTarget.parent.stopDrag();
            event.currentTarget.addEventListener(MouseEvent.MOUSE_UP, onDragOut);
        }


        public function buyRequest(_arg_1:Object):void
        {
            if (_arg_1.accept)
            {
                this.guildHall.addNewFrame(_arg_1.Frame);
                this.btn.addEventListener(MouseEvent.CLICK, this.Parent.padChangeClick, false, 0, true);
            };
        }

        public function createConnection(o:Object):void
        {
            var s:String;
            if (o.accept)
            {
                s = ("Pad" + o.arrow);
                this.Parent.togglePath(("arrow" + o.arrow), true);
                this.game.network.send("guild", ["addConnection", this.guildHall.CurrentCell, o.toCell, s]);
                this.btn.addEventListener(MouseEvent.CLICK, this.Parent.padChangeClick, false, 0, true);
            }
            else
            {
                this.btn.addEventListener(MouseEvent.MOUSE_OUT, this.Parent.padEditOut, false, 0, true);
                this.btn.addEventListener(MouseEvent.MOUSE_OVER, this.Parent.padEditOver, false, 0, true);
                this.guildHall.CurrentBG[("arrow" + o.arrow)].visible = false;
                this.btn.addEventListener(MouseEvent.CLICK, this.Parent.padEditClick, false, 0, true);
            };
        }

        public function destroyConnection(o:Object):void
        {
            var _local_2:String;
            if (o.accept)
            {
                _local_2 = ("Pad" + o.arrow);
                this.Parent.togglePath(("arrow" + o.arrow), false);
                this.game.network.send("guild", ["removeConnection", this.guildHall.CurrentCell, o.toCell, _local_2]);
                this.btn.addEventListener(MouseEvent.CLICK, this.Parent.padEditClick, false, 0, true);
            }
            else
            {
                this.btn.addEventListener(MouseEvent.CLICK, this.Parent.padChangeClick, false, 0, true);
            };
        }

        public function Destroy():void
        {
            if (this.Preview != null)
            {
                try
                {
                    this.game.world.map.removeChild(this.Preview);
                }
                catch(e:Error)
                {
                };
                this.Preview = null;
            };
        }

        private function onClose(event:MouseEvent):void
        {
            event.currentTarget.parent.parent.removeChildAt(0);
        }

        private function onFrameClick(_arg_1:MouseEvent):void
        {
            var _local_2:Class = this.game.world.map.getFrame(MovieClip(_arg_1.currentTarget.parent).lTxt.text);
            var _local_3:MovieClip = (new (_local_2)() as MovieClip);
            _local_3.scaleX = (_local_3.scaleY = 0.16);
            if (this.Preview.mcPreview.numChildren > 0)
            {
                this.Preview.mcPreview.removeChild(this.Preview.mcPreview.getChildAt(0));
            };
            this.frameObj.linkage = MovieClip(_arg_1.currentTarget.parent).lTxt.text;
            this.Preview.btnAdd.addTxt.text = ((this.guildHall.getFrame(this.frameObj.linkage)) ? "Add Frame" : "Buy Frame");
            this.frameObj.buy = (!(this.guildHall.getFrame(this.frameObj.linkage)));
            this.frameObj.iCost = this.frameCosts[this.frameObj.linkage].iCost;
            this.frameObj.bCoins = this.frameCosts[this.frameObj.linkage].bCoins;
            this.Preview.btnAdd.visible = true;
            this.Preview.mcPreview.addChild(_local_3);
        }

        private function addNewFrame(_arg_1:MouseEvent):void
        {
            if (this.frameObj.linkage == null)
            {
                return;
            };
            if (!this.frameObj.buy)
            {
                this.guildHall.addNewFrame(this.frameObj);
                try
                {
                    this.game.world.map.removeChild(this.Preview);
                }
                catch(e:Error)
                {
                };
                this.btn.addEventListener(MouseEvent.CLICK, this.Parent.padChangeClick, false, 0, true);
            }
            else
            {
                if (this.frameObj.iCost > this.game.world.myAvatar.objData.intCoins)
                {
                    this.game.MsgBox.notify("Insufficient Funds!");
                }
                else
                {
                    MainController.modal((("Are you sure you want to buy this land for: " + this.frameObj.iCost) + " Coins?"), this.buyRequest, {"Frame":this.frameObj});
                };
            };
        }


    }
}//package 

