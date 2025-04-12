// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.WorldBoss.WorldBossPanel

package Main.WorldBoss
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import fl.motion.Color;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import fl.motion.*;
    import Main.Controller.*;

    public class WorldBossPanel extends Sprite 
    {

        public var txtHealth:TextField;
        public var txtMana:TextField;
        public var txtKills:TextField;
        public var txtDeaths:TextField;
        public var tTitle:TextField;
        public var btnClose:SimpleButton;
        public var txtWorldBossName:TextField;
        public var txtLoad:TextField;
        public var mcBoss:DisplayObject = null;
        public var mcPortrait:MovieClip;
        public var cntMask:MovieClip;
        public var bossList:MovieClip;
        public var btnJoin:SimpleButton;
        public var scr:LPFElementScrollBar;
        private var bosses:Array;
        private var bossesLoaded:int = 0;
        private var color:Color = new Color();
        private var bossTotalLoaded:int = 0;
        private var targetBossID:int = 0;

        public function WorldBossPanel()
        {
            this.txtWorldBossName.text = "";
            Game.root.network.send("loadWorldBoss", []);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            this.btnJoin.addEventListener(MouseEvent.MOUSE_DOWN, this.onJoin, false, 0, true);
            this.bossList.mask = this.cntMask;
            this.txtLoad.mouseEnabled = false;
        }

        public function distributeList(list:Array):void
        {
            this.bossTotalLoaded = 0;
            this.bosses = list;
            while (this.bossesLoaded < this.bosses.length)
            {
                LoadController.singleton.addLoadJunk(("mon/" + list[this.bossesLoaded].monFile), (("boss_" + this.bosses[this.bossesLoaded].worldBossId) + "_junk"), this.onBossLoadFinal);
                this.bossesLoaded++;
            };
        }

        private function onBossLoadFinal(event:Event):void
        {
            var monster:WorldBossElement;
            var data:Object;
            var i:int;
            var linkageHead:String;
            var percentage:int = int(int(((this.bossesLoaded / this.bosses.length) * 100)));
            this.txtLoad.text = (("Loading List... " + ((percentage < 100) ? percentage : 100)) + "%");
            this.bossTotalLoaded++;
            if (this.bossTotalLoaded == this.bosses.length)
            {
                this.txtLoad.text = "";
                i = 0;
                while (i < this.bosses.length)
                {
                    data = this.bosses[i];
                    monster = WorldBossElement(this.bossList.addChild(new WorldBossElement()));
                    monster.y = ((i * 114.7) + -6.1);
                    monster.x = -15.3;
                    monster.txtName.htmlText = data.monName.toUpperCase();
                    monster.txtSpawn.htmlText = (((String("Spawn Time: ").toUpperCase() + "<font color='#FFFFFF'>") + data.spawnTime) + "</font> Minutes");
                    monster.txtEnd.htmlText = (((String("Time Limit: ").toUpperCase() + "<font color='#FFFFFF'>") + data.timeLimit) + "</font> Seconds");
                    monster.txtLeft.htmlText = (((String("Time Left: ").toUpperCase() + "<font color='#FFFFFF'>") + int((data.timeLeft * -1))) + "</font> Minutes");
                    monster.txtLvl.htmlText = ("Level " + data.monLevel);
                    monster.bossID = data.worldBossId;
                    monster.linkage = data.monLink;
                    monster.health = data.monHealth;
                    monster.mana = data.monMana;
                    monster.kills = data.kills;
                    monster.deaths = data.deaths;
                    monster.buttonMode = true;
                    monster.txtName.mouseEnabled = false;
                    monster.txtSpawn.mouseEnabled = false;
                    monster.txtEnd.mouseEnabled = false;
                    monster.txtLvl.mouseEnabled = false;
                    monster.addEventListener(MouseEvent.MOUSE_OVER, this.onBossHover, false, 0, true);
                    monster.addEventListener(MouseEvent.MOUSE_OUT, this.onBossOut, false, 0, true);
                    monster.addEventListener(MouseEvent.CLICK, this.onBossClick, false, 0, true);
                    if (i == 0)
                    {
                        monster.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                    Game.root.onRemoveChildrens(monster.mcHead.head);
                    linkageHead = ("mcHead" + data.monLink);
                    if (LoadController.singleton.applicationDomainJunk.hasDefinition(linkageHead))
                    {
                        monster.mcHead.head.addChildAt(new (LoadController.singleton.applicationDomainJunk.getDefinition(linkageHead))(), 0).name = "face";
                        monster.mcHead.head.hair.visible = false;
                        monster.mcHead.head.helm.visible = false;
                        monster.mcHead.removeChild(monster.mcHead.backhair);
                    };
                    i++;
                };
            };
            Game.configureScroll(this.bossList, this.cntMask, this.scr);
        }

        private function onBossClick(event:MouseEvent):void
        {
            var borderWidth:Number;
            var borderHeight:Number;
            var iconWidth:Number;
            var iconHeight:Number;
            var widthScale:Number;
            var heightScale:Number;
            var scale:Number;
            var linkage:String = event.currentTarget.linkage;
            var movieClip:MovieClip = MovieClip(event.currentTarget);
            this.targetBossID = movieClip.bossID;
            this.txtWorldBossName.htmlText = movieClip.txtName.text;
            this.txtHealth.htmlText = ("HEALTH: " + movieClip.health);
            this.txtMana.htmlText = ("MANA: " + movieClip.mana);
            this.txtKills.htmlText = ("KILLS: " + movieClip.kills);
            this.txtDeaths.htmlText = ("DEATHS: " + movieClip.deaths);
            if (this.mcBoss != null)
            {
                Game.root.onRemoveChildrens(this.mcBoss);
            };
            if (LoadController.singleton.applicationDomainJunk.hasDefinition(linkage))
            {
                this.mcBoss = this.mcPortrait.addChild(new (LoadController.singleton.applicationDomainJunk.getDefinition(linkage))());
                borderWidth = this.mcPortrait.mcOutline.width;
                borderHeight = this.mcPortrait.mcOutline.height;
                iconWidth = this.mcBoss.width;
                iconHeight = this.mcBoss.height;
                widthScale = (borderWidth / iconWidth);
                heightScale = (borderHeight / iconHeight);
                scale = Math.min(widthScale, heightScale);
                scale = (scale * 0.9);
                this.mcBoss.scaleX = (this.mcBoss.scaleY = scale);
                this.mcBoss.x = (borderWidth / 2);
                this.mcBoss.y = ((borderHeight - ((heightScale * scale) / 2)) - 10);
            };
        }

        private function onBossHover(event:MouseEvent):void
        {
            this.color.brightness = 0.1;
            MovieClip(event.currentTarget).transform.colorTransform = this.color;
        }

        private function onBossOut(event:MouseEvent):void
        {
            this.color.brightness = 0;
            MovieClip(event.currentTarget).transform.colorTransform = this.color;
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            UIController.close("boss_board");
            var i:int;
            while (i < this.bosses.length)
            {
                LoadController.singleton.clearLoader((("boss_" + this.bosses[i].worldBossId) + "_junk"));
                i++;
            };
        }

        private function onJoin(event:Event):void
        {
            Game.root.network.send("joinWorldBoss", [this.targetBossID]);
            this.onClose();
        }


    }
}//package Main.WorldBoss

