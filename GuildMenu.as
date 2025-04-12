// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildMenu

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class GuildMenu extends MovieClip 
    {

        private const memMenu:Array = [{"txt":"Guild Hall Menu"}, {
            "txt":"Building Shop",
            "fct":"buildShop"
        }];
        private const mainMenu:Array = [{"txt":"Guild Hall Menu"}, {
            "txt":"Edit Mode",
            "fct":"editGuildHall"
        }, {
            "txt":"Buy Land",
            "fct":"buyLand"
        }, {
            "txt":"Building Shop",
            "fct":"buildShop"
        }, {
            "txt":"Save Item Placement",
            "fct":"saveInterior"
        }, {
            "txt":"Hide Panel",
            "fct":"hidePanel"
        }];

        private var Parent:GuildHall;
        private var menuMC:MovieClip;
        private var game:Game;
        private var lastClicked:MovieClip;
        private var editMode:Boolean = false;
        private var gMap:guildHallMap;
        private var btns:Array;
        private var Menus:Array = [];
        private var menusAdded:Array = [];
        private var Preview:MovieClip;
        private var buildEdit:menuEditBuilding;
        private var pathEdit:menuEditPath;
        private var gShop:GuildShop;
        private var interiorMenu:MovieClip;

        public function GuildMenu(game:Game, guildHall:GuildHall)
        {
            this.game = game;
            this.menuMC = new MovieClip();
            super();
            this.Parent = guildHall;
            this.buildMenu(((this.game.world.myAvatar == null) ? this.memMenu : ((this.game.world.myAvatar.objData.guildRank.ManageFinances) ? this.mainMenu : this.memMenu)), 900, 50);
            this.game.ui.addChild(this.menuMC);
        }

        private static function getBuildingPos(_arg1:String):int
        {
            switch (_arg1)
            {
                case "Lot1":
                    return (5);
                case "Lot2":
                    return (245);
                case "Lot3":
                    return (485);
                case "Lot4":
                    return (725);
            };
            return (0);
        }


        public function get Menu():MovieClip
        {
            return (this.menuMC);
        }

        public function get EditMode():Boolean
        {
            return (this.editMode);
        }

        public function closeInt():void
        {
            if (this.Parent.inBuilding)
            {
                this.editGuildHall();
            };
        }

        public function cellChange():void
        {
            if (this.editMode)
            {
                this.editGuildHall();
            };
            if (((!(this.interiorMenu == null)) && (!(this.Parent.inBuilding))))
            {
                this.interiorMenu.Destroy();
            };
            if (this.buildEdit != null)
            {
                this.buildEdit.Destroy();
            };
            if (this.pathEdit != null)
            {
                this.pathEdit.Destroy();
            };
            if (this.gShop != null)
            {
                this.gShop.Destroy();
            };
        }

        public function doBuyLand(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.game.network.send("guild", ["buyplot"]);
            };
        }

        public function togglePath(_arg1:String, _arg2:Boolean):void
        {
            switch (_arg1)
            {
                case "arrow1":
                case "arrow5":
                    this.Parent.CurrentBG[_arg1].visible = (!(_arg2));
                    return;
            };
            this.Parent.CurrentBG[_arg1].visible = _arg2;
        }

        public function openShop(shopinfo:Object, items:Array):void
        {
            shopinfo.items = MainController.arrToVectorItem(shopinfo.items);
            this.gShop = new GuildShop(this.game, this, shopinfo, MainController.arrToVectorItem(items));
        }

        public function closeShop():void
        {
            this.gShop.Destroy();
            this.gShop = null;
        }

        public function refreshShop(items:Array):void
        {
            if (this.gShop != null)
            {
                this.gShop.reset(MainController.arrToVectorItem(items));
            };
        }

        public function Destory():void
        {
            var _local1:uint;
            if (this.interiorMenu != null)
            {
                this.interiorMenu.Destroy();
            };
            if (this.buildEdit != null)
            {
                this.buildEdit.Destroy();
            };
            if (this.pathEdit != null)
            {
                this.pathEdit.Destroy();
            };
            if (this.gShop != null)
            {
                this.gShop.Destroy();
            };
            try
            {
                _local1 = 0;
                while (_local1 < this.btns.length)
                {
                    this.game.world.map.removeChild(this.btns[_local1]);
                    _local1++;
                };
            }
            catch(e:Error)
            {
                trace(e);
            };
            this.game.ui.removeChild(this.menuMC);
        }

        public function isItemInInventory(_arg1:int):Boolean
        {
            var o:Object = this.Parent.Inventory[String(_arg1)];
            return ((o == null) ? false : (o.unm == this.game.world.myAvatar.objData.strUsername));
        }

        private function buildMenu(_arg1:Array, _arg2:Number, _arg3:Number):MovieClip
        {
            var movieClip:MovieClip;
            var movieClip1:MovieClip;
            var _local6:uint;
            movieClip1 = new MovieClip();
            if (_arg1[0].fct == null)
            {
                movieClip = new menuTop();
                movieClip.txt.text = _arg1[0].txt;
            }
            else
            {
                movieClip = new menuListItem();
                movieClip.mTxt.text = _arg1[0].txt;
                movieClip.name = _arg1[0].fct;
                movieClip.addEventListener(MouseEvent.CLICK, this.callFunction, false, 0, true);
            };
            movieClip.y = _arg3;
            movieClip.x = _arg2;
            movieClip1.addChild(movieClip);
            _local6 = 1;
            while (_local6 < _arg1.length)
            {
                movieClip = new menuListItem();
                movieClip.y = (movieClip1.height + _arg3);
                movieClip1.addChild(movieClip);
                movieClip.x = _arg2;
                movieClip.name = _arg1[_local6].fct;
                movieClip.mTxt.text = _arg1[_local6].txt;
                movieClip.buttonMode = true;
                movieClip.mouseChildren = false;
                movieClip.addEventListener(MouseEvent.CLICK, this.callFunction, false, 0, true);
                _local6++;
            };
            this.menuMC.addChild(movieClip1);
            return (movieClip1);
        }

        private function editGuildHall():void
        {
            var _local1:uint;
            var movieClip:MovieClip;
            var currentBG:MovieClip;
            var i:int;
            var s:String;
            var s1:String;
            if (this.editMode)
            {
                this.editMode = false;
                this.lastClicked.mTxt.text = "Edit Mode";
                try
                {
                    _local1 = 0;
                    while (_local1 < this.btns.length)
                    {
                        this.game.world.map.removeChild(this.btns[_local1]);
                        _local1++;
                    };
                    if (this.interiorMenu != null)
                    {
                        this.interiorMenu.Destroy();
                    };
                    if (this.buildEdit != null)
                    {
                        this.buildEdit.Destroy();
                    };
                }
                catch(e:Error)
                {
                    trace(e);
                };
            }
            else
            {
                this.game.network.send("guild", ["getInv"]);
                this.btns = [];
                this.editMode = true;
                this.lastClicked.mTxt.text = "Edit Off";
                if (this.Parent.Inside)
                {
                    this.interiorMenu = new guildIntMenu(this.game, this, this.Parent, this.Parent.bInt);
                    return;
                };
                currentBG = this.Parent.CurrentBG;
                this.gMap = this.Parent.GuildGrid;
                i = 1;
                for (;i <= 8;(i = (i + 1)))
                {
                    s = ("Pad" + String(i));
                    if (i > 5)
                    {
                        s1 = this.gMap.hasAdjCell(this.Parent.CurrentCell, this.gMap.getPadDirection(s));
                        if (this.Parent.hasBuilding(this.gMap.onLot(this.Parent.getPadPair(s)), s1))
                        {
                            continue;
                        };
                    };
                    if (!this.Parent.hasBuilding(this.gMap.onLot(s)))
                    {
                        movieClip = new EditBtn();
                        movieClip.x = currentBG[s].x;
                        movieClip.y = currentBG[s].y;
                        movieClip.width = currentBG[s].width;
                        movieClip.height = currentBG[s].height;
                        this.btns.push(this.game.world.map.addChild(movieClip));
                        movieClip.name = String(i);
                        if (!this.Parent.hasConnection(s))
                        {
                            movieClip.addEventListener(MouseEvent.MOUSE_OUT, this.padEditOut, false, 0, true);
                            movieClip.addEventListener(MouseEvent.MOUSE_OVER, this.padEditOver, false, 0, true);
                            movieClip.addEventListener(MouseEvent.CLICK, this.padEditClick, false, 0, true);
                        }
                        else
                        {
                            movieClip.addEventListener(MouseEvent.CLICK, this.padChangeClick, false, 0, true);
                        };
                    };
                    if (((!(this.gMap.onLot(s) == null)) && (!(this.Parent.hasConnection(s)))))
                    {
                        movieClip = new EditBuilding();
                        movieClip.y = 175;
                        movieClip.x = getBuildingPos(("Lot" + this.gMap.onLot(s)));
                        movieClip.name = this.gMap.onLot(s);
                        movieClip.buttonMode = true;
                        this.btns.push(this.game.world.map.addChild(movieClip));
                        movieClip.addEventListener(MouseEvent.CLICK, this.buildingEditClick, false, 0, true);
                    };
                };
                movieClip = new EditBuilding();
                movieClip.name = "2";
                movieClip.y = 175;
                movieClip.x = getBuildingPos("Lot2");
                movieClip.buttonMode = true;
                movieClip.addEventListener(MouseEvent.CLICK, this.buildingEditClick, false, 0, true);
                this.btns.push(this.game.world.map.addChild(movieClip));
            };
        }

        private function buyLand():void
        {
            if (this.Parent.Lots < 16)
            {
                MainController.modal((((("You own " + this.Parent.Lots) + "/16 plots. Would you like to buy another for 1000 ") + Config.getString("coins_name_short")) + "."), this.doBuyLand, {}, null, "dual");
            }
            else
            {
                MainController.modal("You already have the maximum amount of land.", null, {}, null, "mono");
            };
        }

        private function buildShop():void
        {
            if (this.Parent.Inventory == null)
            {
                this.game.network.send("guild", ["getInv"]);
            };
            this.game.network.send("guild", ["getShop", Config.getInt("shop_guildhall")]);
        }

        private function saveInterior():void
        {
            this.Parent.saveInterior();
        }

        private function hidePanel():void
        {
            this.game.onRemoveChildrens(this.menuMC);
            var houseOpen:* = this.menuMC.addChild(new HouseOpen());
            houseOpen.x = 930;
            houseOpen.y = 50;
            houseOpen.height = (houseOpen.height + 15);
            houseOpen.width = (houseOpen.width + 80);
            houseOpen.addEventListener(MouseEvent.CLICK, this.onRebuildMenu, false, 0, true);
        }

        public function onRebuildMenu(_arg1:MouseEvent):void
        {
            this.buildMenu(((this.game.world.myAvatar == null) ? this.memMenu : ((this.game.world.myAvatar.objData.guildRank.ManageFinances) ? this.mainMenu : this.memMenu)), 900, 50);
        }

        private function clearMenus(_arg1:String=null):void
        {
            if (this.buildEdit != null)
            {
                this.buildEdit.Destroy();
                this.buildEdit = null;
            };
            if (this.pathEdit != null)
            {
                this.pathEdit.Destroy();
                this.pathEdit = null;
            };
        }

        private function removeMenu(_arg1:Array):void
        {
            var _local2:int;
            while (_local2 < _arg1.length)
            {
                this.menuMC.removeChild(_arg1[_local2]);
                _local2++;
            };
            _arg1 = [];
        }

        public function padEditOut(_arg1:MouseEvent):void
        {
            this.togglePath(("arrow" + _arg1.currentTarget.name), false);
        }

        public function padEditOver(_arg1:MouseEvent):void
        {
            this.togglePath(("arrow" + _arg1.currentTarget.name), true);
        }

        public function buildingEditClick(_arg1:MouseEvent):void
        {
            this.clearMenus();
            this.buildEdit = new menuEditBuilding(this.Preview, _arg1.currentTarget.name, this.Parent, _arg1.currentTarget.x, this.game);
        }

        public function padEditClick(_arg1:MouseEvent):void
        {
            this.clearMenus(_arg1.currentTarget.name);
            this.pathEdit = new menuEditPath(this.Preview, this.game, this.gMap, MovieClip(_arg1.currentTarget), this.Parent, this, true);
            _arg1.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, this.padEditOver);
            _arg1.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, this.padEditOut);
        }

        public function padChangeClick(_arg1:MouseEvent):void
        {
            this.pathEdit = new menuEditPath(this.Preview, this.game, this.gMap, MovieClip(_arg1.currentTarget), this.Parent, this, false);
        }

        private function callFunction(_arg1:MouseEvent):void
        {
            var _local3:Function;
            this.lastClicked = MovieClip(_arg1.currentTarget);
            var _local2:Array = _arg1.currentTarget.name.split(".");
            switch (_local2.length)
            {
                case 1:
                    _local3 = this[_arg1.currentTarget.name];
                    break;
                case 2:
                    _local3 = this.game[_local2[1]];
                    break;
                case 3:
                    _local3 = this.game.world[_local2[2]];
                    break;
            };
            (_local3());
        }


    }
}//package 

