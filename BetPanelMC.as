// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//BetPanelMC

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import Main.*;

    public dynamic class BetPanelMC extends MovieClip 
    {

        public var rootClass:Game = Game.root;
        public var btnFight:SimpleButton;
        public var btnClose:SimpleButton;
        public var btnRandom:SimpleButton;
        public var btnLeft:MovieClip;
        public var btnRight:MovieClip;
        public var mcMap:MovieClip;
        public var currentMap:int = 0;
        public var txtDescription:TextField;
        public var txtCoins:TextField;
        public var txtMap:TextField;
        public var strUsername:String;
        public var imageLoader:Loader;
        public var pvpMaps:Array = [{
            "Name":"Current Map",
            "Map":"current map",
            "Image":"current-map.png"
        }, {
            "Name":"Doom Arena A",
            "Map":"doomarenaa",
            "Image":"doomarenaa.png"
        }, {
            "Name":"Doom Arena B",
            "Map":"doomarenab",
            "Image":"doomarenab.png"
        }, {
            "Name":"Doom Arena C",
            "Map":"doomarenac",
            "Image":"doomarenac.png"
        }, {
            "Name":"Doom Arena D",
            "Map":"doomarenad",
            "Image":"doomarenad.png"
        }];

        public function BetPanelMC()
        {
            addFrameScript(0, this.frame1);
        }

        public function setupMap():void
        {
            if (((this.imageLoader) && (this.mcMap.contains(this.imageLoader))))
            {
                this.mcMap.removeChild(this.imageLoader);
                this.imageLoader = null;
            };
            var url:String = (Config.serverMapImageURL + ((this.pvpMaps[this.currentMap]["Name"] == "Current Map") ? (((this.rootClass.world.strMapName + "?frame=") + this.rootClass.world.strFrame)) : ((this.pvpMaps[this.currentMap]["Map"] + "?frame=r1"))));
            var request:URLRequest = new URLRequest(url);
            this.imageLoader = new Loader();
            this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onImageCompleteLoad);
            this.imageLoader.load(request);
        }

        public function onImageCompleteLoad(event:*):void
        {
            this.txtMap.text = this.pvpMaps[this.currentMap]["Name"];
            this.mcMap.addChild(this.imageLoader);
            this.mcMap.height = 97;
            this.mcMap.width = 165;
        }

        public function sendDuelInviteCallBack(event:Object):void
        {
            if (event.accept)
            {
                this.rootClass.network.send("duel", [this.strUsername, this.txtCoins.text, this.pvpMaps[this.currentMap]["Map"]]);
                MovieClip(parent).onClose();
            };
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }

        private function frame1():void
        {
            this.btnFight.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnRight.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnLeft.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnRandom.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.setupMap();
            stop();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnFight":
                    if (((this.txtCoins.length == 0) || (isNaN(Number(this.txtCoins.text)))))
                    {
                        this.txtCoins.text = "0";
                    };
                    if (this.txtCoins.text > this.rootClass.world.myAvatar.objData.intCoins)
                    {
                        this.rootClass.MsgBox.notify("Insufficient Funds!");
                        return;
                    };
                    MainController.modal((((((((("Are you sure you want to bet '" + this.txtCoins.text) + "' ") + Config.getString("coins_name_short")) + " to a duel with ") + this.strUsername) + " at ") + this.pvpMaps[this.currentMap]["Name"]) + "?"), this.sendDuelInviteCallBack, {}, "white,medium", "dual");
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
                case "btnRight":
                    this.currentMap = ((++this.currentMap > (this.pvpMaps.length - 1)) ? 0 : this.currentMap);
                    this.setupMap();
                    break;
                case "btnLeft":
                    this.currentMap = ((--this.currentMap < 0) ? (this.pvpMaps.length - 1) : this.currentMap);
                    this.setupMap();
                    break;
                case "btnRandom":
                    this.currentMap = Math.floor((Math.random() * this.pvpMaps.length));
                    this.setupMap();
                    break;
            };
        }


    }
}//package 

