// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//menuEditBuilding

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class menuEditBuilding extends MovieClip 
    {

        private var guildRoot:MovieClip;
        private var curLot:String;
        private var Parent:MovieClip;
        private var Preview:MovieClip;
        private var buildPreviews:Object = {};
        private var game:Game;
        private var curPreview:int;
        private var pLoader:GuildLoader;
        private var scr:*;

        public function menuEditBuilding(_arg_1:MovieClip, _arg_2:String, _arg_3:MovieClip, _arg_4:Number, game:Game)
        {
            var i:int;
            var inventoryKey:String;
            var inventoryElement:Object;
            var landList:LandList;
            super();
            this.Preview = _arg_1;
            this.curLot = _arg_2;
            this.guildRoot = _arg_3;
            this.game = game;
            if (this.guildRoot.hasBuilding(this.curLot))
            {
                MainController.modal("Would you like to remove this building?", this.destroyBuilding, {}, null, "dual");
            }
            else
            {
                if (this.Preview != null)
                {
                    this.game.world.map.removeChild(this.Preview);
                    this.Preview = null;
                };
                if (game.ui.GuildHallPop.getChildByName("guildHallBuilding") != null)
                {
                    MainController.modal("Please remove the building preview first.", null, {}, null, "mono");
                    return;
                };
                this.Preview = (new LandPreview() as MovieClip);
                this.Preview.x = 300;
                this.Preview.y = 175;
                this.Preview.cntMask.visible = false;
                this.Preview.imask.visible = false;
                this.game.ui.GuildHallPop.addChild(this.Preview);
                this.Preview.btnAdd.addEventListener(MouseEvent.CLICK, this.addNewBuilding, false, 0, true);
                this.Preview.btnAdd.addTxt.text = "Add Building";
                this.Preview.txtTitle.text = "Buildings";
                this.Preview.mcHeader.buttonMode = true;
                this.Preview.name = "guildHallBuilding";
                this.Preview.txtTitle.mouseEnabled = false;
                this.Preview.mcHeader.addEventListener(MouseEvent.MOUSE_DOWN, onDragIn);
                this.Preview.btnClose.addEventListener(MouseEvent.CLICK, this.onClose);
                this.Preview.btnAdd.buttonMode = true;
                this.Preview.mcItemList.mask = this.Preview.imask;
                i = 0;
                for (inventoryKey in this.guildRoot.Inventory)
                {
                    if (inventoryKey != "Frames")
                    {
                        inventoryElement = this.guildRoot.Inventory[inventoryKey];
                        landList = new LandList();
                        landList.x = 3;
                        landList.y = (landList.height * i);
                        i++;
                        this.Preview.mcItemList.addChild(landList);
                        landList.lTxt.text = inventoryElement.sName;
                        landList.name = String(inventoryKey);
                        landList.btn.addEventListener(MouseEvent.CLICK, this.onBuildingClick, false, 0, true);
                    };
                };
                this.scr = new sBar(this.Preview.scr, this.Preview.imask, this.game);
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


        public function Destroy():void
        {
            if (((!(this.Preview == null)) && (!(this.game.ui.GuildHallPop.getChildByName("guildHallBuilding") == null))))
            {
                this.game.ui.GuildHallPop.removeChildAt(0);
                this.Preview = null;
            };
        }

        public function destroyBuilding(_arg_1:Object):void
        {
            if (_arg_1.accept)
            {
                this.guildRoot.destoryBuilding(this.curLot);
            };
        }

        private function onPreviewComplete(guildLoader:GuildLoader):void
        {
            var movieClip:MovieClip = MovieClip(new guildLoader.swfClass());
            movieClip.scaleX = (movieClip.scaleY = 0.25);
            movieClip.y = movieClip.height;
            movieClip.x = 75;
            this.buildPreviews[this.guildRoot.Inventory[this.curPreview].sLink] = movieClip;
            this.Preview.mcPreview.addChild(movieClip);
        }

        private function onClose(event:MouseEvent):void
        {
            event.currentTarget.parent.parent.removeChildAt(0);
        }

        private function onBuildingClick(_arg_1:MouseEvent):void
        {
            if (this.Preview.mcPreview.numChildren > 0)
            {
                this.Preview.mcPreview.removeChild(this.buildPreviews[this.guildRoot.Inventory[this.curPreview].sLink]);
            };
            this.curPreview = int(MovieClip(_arg_1.currentTarget.parent).name);
            if (this.buildPreviews[this.guildRoot.Inventory[this.curPreview].sLink] == null)
            {
                this.pLoader = new GuildLoader(this.onPreviewComplete, ("maps/" + this.guildRoot.Inventory[this.curPreview].sFile), this.game, this.guildRoot.Inventory[this.curPreview].sLink, this.curPreview);
            }
            else
            {
                this.Preview.mcPreview.addChild(this.buildPreviews[this.guildRoot.Inventory[this.curPreview].sLink]);
            };
        }

        private function addNewBuilding(_arg_1:MouseEvent):void
        {
            var i:int;
            if (this.guildRoot.Inventory[this.curPreview] == null)
            {
                MainController.modal("Please select an item.", null, {}, null, "mono");
                this.Destroy();
                return;
            };
            if (this.guildRoot.Links[this.guildRoot.Inventory[this.curPreview].sLink] != null)
            {
                MainController.modal("You have already placed this building in your guild hall.", null, {}, null, "mono");
                this.Destroy();
                return;
            };
            if ((int(this.curLot) + this.guildRoot.Inventory[this.curPreview].iStk) > 4)
            {
                MainController.modal("There isn't enough space to place this building here.", null, {}, null, "mono");
                this.Destroy();
                return;
            };
            i = 0;
            while (i < this.guildRoot.Inventory[this.curPreview].iStk)
            {
                if (this.guildRoot.hasBuilding(String((int(this.curLot) + i))))
                {
                    MainController.modal("There isn't enough space to place this building here.", null, {}, null, "mono");
                    this.Destroy();
                    return;
                };
                i++;
            };
            this.guildRoot.totalFiles++;
            this.guildRoot.addBuildingToCell(this.curLot, this.guildRoot.Inventory[this.curPreview].iStk, this.curPreview);
        }


    }
}//package 

