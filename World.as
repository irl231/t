// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//World

package 
{
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.filters.GlowFilter;
    import Main.Aqw.LPF.LPFLayoutChatItemPreview;
    import Main.Model.ShopModel;
    import Main.Model.Item;
    import fl.motion.AdjustColor;
    import Main.Model.Action;
    import __AS3__.vec.Vector;
    import Main.Aqw.PvPMap;
    import flash.net.URLLoader;
    import Main.Model.TradeInfo;
    import Plugins.MapBuilder.MapController;
    import Main.Controller.BankController;
    import Main.Controller.MarketController;
    import Main.Controller.TradeController;
    import Main.Controller.PartyController;
    import flash.display.Sprite;
    import flash.utils.Timer;
    import Main.Model.MapBitmap;
    import flash.display.DisplayObject;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;
    import flash.media.Sound;
    import Main.UI.AbstractPortrait;
    import Main.Model.Skill;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.display.Graphics;
    import Main.Avatar.AbstractAvatarMC;
    import flash.display.BitmapData;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import flash.media.*;
    import fl.motion.*;
    import flash.filters.*;
    import flash.utils.*;
    import Main.Aqw.LPF.*;
    import Main.Avatar.*;
    import Main.Aqw.*;
    import Plugins.MapBuilder.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;
    import Game_fla.*;
    import FoM.Weather.*;
    import Main.Avatar.Auras.*;
    import Plugins.ConfigurableNPC.*;

    public class World extends MovieClip 
    {

        public static var TICK_MAX:int = 24;
        private static const statusPoisonCT:ColorTransform = new ColorTransform(-0.3, -0.3, -0.3, 0, 0, 20, 0, 0);
        private static const statusStoneCT:ColorTransform = new ColorTransform(-1.3, -1.3, -1.3, 0, 100, 100, 100, 0);
        private static const statusFreezeCT:ColorTransform = new ColorTransform(-0.3, -0.3, -0.3, 0, -50, 80, 0xFF, 0);
        private static const showActionImpactGlow1:GlowFilter = new GlowFilter(0, 1, 5, 5, 5, 1, false, false);
        private static const showActionImpactGlow2:GlowFilter = new GlowFilter(0x330000, 1, 5, 5, 5, 1, false, false);

        public var SkyMC:MovieClip;
        public var GameMonth:Number;
        public var GameTime:Number;
        public var rate:Object;
        public var guildHallData:GuildHall;
        public var linkPreview:LPFLayoutChatItemPreview;
        public var objQuestString:Object;
        public var frames:Array = null;
        public var CELL_MODE:String = "normal";
        public var SCALE:Number = 1;
        public var WALKSPEED:Number = 8;
        public var bitWalk:Boolean = false;
        public var isCross:Boolean = false;
        public var strAreaName:String;
        public var strMapName:String;
        public var strAreaCap:int;
        public var strMapFileName:String;
        public var intMapID:int;
        public var intType:int;
        public var intKillCount:int;
        public var objLock:Array;
        public var objExtra:Object;
        public var monstersHidden:Boolean = false;
        public var objHouseData:Object;
        public var returnInfo:Object;
        public var strMap:String = "";
        public var strFrame:String = "";
        public var strPad:String = "";
        public var mapBoundsMC:MovieClip = null;
        public var chatFocus:* = null;
        public var arrEvent:Array;
        public var arrEventR:Array;
        public var arrSolid:Array;
        public var arrSolidR:Array;
        public var myAvatar:Avatar = null;
        public var mondef:Array;
        public var monmap:Array;
        private var mapMonsterToLoad:int = 0;
        private var mapMonsterLoaded:int = 0;
        public var npcdef:Array;
        public var npcmap:Array;
        public var objectmap:Array = null;
        public var resourcemap:Array = null;
        private var mapObjectToLoad:int = 0;
        private var mapObjectLoaded:int = 0;
        public var shopinfo:ShopModel = null;
        public var shopBuyItem:Item = null;
        public var enhShopID:int = -1;
        public var enhShopItems:Array;
        public var enhItem:Object;
        public var hairshopinfo:Object;
        public var mapEvents:Object;
        public var adData:Object;
        public var cellMap:Object;
        public var scrollData:Object;
        public var mapLoadInProgress:Boolean = false;
        public var mapW:int = 960;
        public var mapH:int = 550;
        public var mapNW:int;
        public var mapNH:int;
        public var mData:MapData;
        public var cHandle:cutsceneHandler;
        public var sController:soundController;
        public var isRemoveProps:Boolean = false;
        public var GCD:int = 1500;
        public var GCDO:int = 1500;
        public var GCDTS:Number = 0;
        public var curRoom:int = 1;
        public var bPvP:Boolean = false;
        public var bSpectate:Boolean = false;
        public var bPK:Boolean = false;
        public var aTarget:Avatar = null;
        public var isCycle:Boolean = false;
        public var showHPBar:Boolean = false;
        public var rootClass:Game;
        public var bookData:Object;
        public var cookData:Object;
        public var hideAvatars:Boolean = false;
        internal var mvTimerObj:Object;
        public var actionReady:Boolean = false;
        internal var actionID:int = 0;
        internal var actionIDLimit:Number = 30;
        internal var actionIDMon:Number = 0;
        internal var actionIDLimitMon:Number = 30;
        internal var actionRangeSpamTS:Number = 0;
        internal var actionResultID:Number = 0;
        internal var actionResultIDLimit:Number = 30;
        internal var minLatencyOneWay:int = 20;
        public var connMsgOut:Boolean = false;
        private var ticksum:Number = 0;
        private var fpsTS:Number = 0;
        private var fpsQualityCounter:int = 0;
        private var isJoined:Boolean;
        public var musicFile:String = "";
        public var musicLoaded:Boolean = false;

        public var objInfo:Object = {"customs":{
                "prefs":{},
                "loadouts":{},
                "costumes":{}
            }};
        private var WeatherColor:AdjustColor = new AdjustColor();
        public var sky:MovieClip = new MovieClip();
        public var objSession:Object = {};
        public var objResponse:Object = {};
        public var spawnPoint:Object = {};
        public var FG:MovieClip = new MovieClip();
        public var CHARS:MovieClip = new MovieClip();
        public var TRASH:MovieClip = new MovieClip();
        public var _map:MovieClip = new MovieClip();
        public var avatars:Object = {};
        public var monsters:Array = [];
        public var npcs:Array = [];
        public var actions:Action = new Action();
        public var lock:Object = {
            "closeTarget":{
                "cd":2500,
                "ts":0
            },
            "loadShop":{
                "cd":3000,
                "ts":0
            },
            "loadEnhShop":{
                "cd":3000,
                "ts":0
            },
            "loadHairShop":{
                "cd":3000,
                "ts":0
            },
            "equipItem":{
                "cd":1500,
                "ts":0
            },
            "unequipItem":{
                "cd":1500,
                "ts":0
            },
            "updateTitle":{
                "cd":1500,
                "ts":0
            },
            "buyItem":{
                "cd":1000,
                "ts":0
            },
            "sellItem":{
                "cd":1000,
                "ts":0
            },
            "getMapItem":{
                "cd":1000,
                "ts":0
            },
            "tryQuestComplete":{
                "cd":1250,
                "ts":0
            },
            "acceptQuest":{
                "cd":1000,
                "ts":0
            },
            "crossConnect":{
                "cd":1000,
                "ts":0
            },
            "doIA":{
                "cd":1000,
                "ts":0
            },
            "rest":{
                "cd":1900,
                "ts":0
            },
            "who":{
                "cd":3000,
                "ts":0
            },
            "tfer":{
                "cd":2000,
                "ts":0
            },
            "serverUseItem":{
                "cd":400,
                "ts":0
            },
            "wearItem":{
                "cd":1500,
                "ts":0
            },
            "unwearItem":{
                "cd":1500,
                "ts":0
            },
            "addLoadout":{
                "cd":1500,
                "ts":0
            },
            "removeLoadout":{
                "cd":1500,
                "ts":0
            },
            "wearLoadout":{
                "cd":3000,
                "ts":0
            },
            "equipLoadout":{
                "cd":3000,
                "ts":0
            },
            "toggleOption":{
                "cd":2000,
                "ts":0
            }
        };
        public var invTree:Object = {};
        public var linkTree:Object = {};
        public var emojiTree:Object = {};
        public var uoTree:Object = {};
        public var monTree:Object = {};
        public var npcTree:Object = {};
        public var waveTree:Object = {};
        public var questTree:Object = {};
        public var enhPatternTree:Object = {};
        public const defaultCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        public const iconCT:ColorTransform = new ColorTransform(0.5, 0.5, 0.5, 1, -50, -50, -50, 0);
        public const deathCT:ColorTransform = new ColorTransform(0.7, 0.7, 1, 1, -20, -20, 20, 0);
        public const avtWCT:ColorTransform = new ColorTransform(0, 0, 0, 0, 0xFF, 0xFF, 0xFF, 0);
        public const avtMCT:ColorTransform = new ColorTransform(0, 0, 0, 0, 30, 0, 0, 0);
        public const avtPCT:ColorTransform = new ColorTransform(0, 0, 0, 0, 40, 40, 70, 0);
        public var areaUsers:Array = [];
        public var PVPMaps:Vector.<PvPMap> = Vector.<PvPMap>([new PvPMap("It's Us Or Them", "This cozy PvP map is ideal for players new to PvP in game.", "usorthem", "usorthem", "tower", false), new PvPMap("Doomwood Arena", "This arena is for one x one duels.", "doomarena", "doomarena", "swords", false), new PvPMap("Doomwood Arena", "This arena is for one x one duels.", "doomarenaa", "doomarena", "swords", true), new PvPMap("Doomwood Arena", "This arena is for one x one duels.", "doomarenab", "doomarena", "swords", true), new PvPMap("Doomwood Arena", "This arena is for one x one duels.", "doomarenac", "doomarena", "swords", true), new PvPMap("Doomwood Arena", "This arena is for one x one duels.", "doomarenad", "doomarena", "swords", true), new PvPMap("Darkovia Arena!", "Join in the ancient war between werewolves and vampires!", "darkoviapvp", "darkoviapvp", "swords", false), new PvPMap("Dage Arena!", "This arena is for one x one duels.", "dage1v1", "dage1v1", "swords", true), new PvPMap("Bludrut Brawl!", "A larger map requiring communication, coordination, and a whole lot of DPS.", "bludrutbrawl", "bludrutbrawl", "swords", false), new PvPMap("Chaos Brawl!", "A larger map requiring communication, coordination, and a whole lot of DPS.", "chaosbrawl", "bludrutbrawl", "swords", true), new PvPMap("Frost Brawl!", "A larger map requiring communication, coordination, and a whole lot of DPS.", "guildarena", "bludrutbrawl", "swords", true), new PvPMap("Dage Brawl!", "A larger map requiring communication, coordination, and a whole lot of DPS.", "dagepvp", "dagepvp", "swords", true)]);
        public var PVPQueue:Object = {
            "warzone":"",
            "ts":-1,
            "avgWait":-1
        };
        public var PVPResults:Object = {
            "pvpScore":[],
            "team":0
        };
        public var PVPFactions:Array = [];
        public var arrHouseItemQueue:Array = [];
        public var ldr_House:URLLoader = new URLLoader();
        public var bankinfo:Object = {
            "items":new Vector.<Item>(),
            "hasRequested":{},
            "Count":0
        };
        public var tradeInfo:TradeInfo = new TradeInfo();
        public var auctioninfo:Object = {
            "items":new Vector.<Item>(),
            "hasRequested":{}
        };
        public var retrieveinfo:Object = {
            "items":new Vector.<Item>(),
            "hasRequested":{}
        };
        public var mapController:MapController = new MapController();
        public var bankController:BankController = new BankController();
        public var marketController:MarketController = new MarketController();
        public var tradeController:TradeController = new TradeController();
        public var partyController:PartyController = new PartyController();
        internal var managerEnterFrame:Sprite = new Sprite();
        private var restTimer:Timer = new Timer(2000, 1);
        private var afkTimer:Timer = new Timer(120000, 1);
        private var mvTimer:Timer = new Timer(1000, 1);
        public var autoActionTimer:Timer = new Timer(2000, 1);
        public var actionMap:Array = [];
        public var actionResults:Object = {};
        public var actionResultsMon:Object = {};
        private var mapBmps:Vector.<MapBitmap> = new Vector.<MapBitmap>();
        private var ticklist:Array = [];
        private var fpsArrayQuality:Array = [];

        public function World(root:Game)
        {
            LoadController.singleton.clearLoaderByType("junk");
            LoadController.singleton.clearLoaderByType("map");
            LoadController.singleton.clearLoaderByType("avatar");
            this.mapNW = this.mapW;
            this.mapNH = this.mapH;
            this.rootClass = root;
            this.addChild(this.sky);
            this.addChild(this.map);
            var charsDO:DisplayObject = this.addChild(this.CHARS);
            this.CHARS.mouseEnabled = false;
            charsDO.x = 0;
            charsDO.y = 0;
            this.addChild(this.TRASH);
            this.TRASH.mouseEnabled = false;
            this.TRASH.visible = false;
            this.TRASH.y = -1000;
            this.addChild(this.managerEnterFrame);
            this.addChild(this.FG);
            this.managerEnterFrame.removeEventListener(Event.ENTER_FRAME, this.onManagerEnterFrame);
            this.autoActionTimer.removeEventListener("timer", this.autoActionHandler);
            this.restTimer.removeEventListener("timer", this.restRequest);
            this.afkTimer.removeEventListener("timer", this.afkTimerHandler);
            this.mvTimer.removeEventListener("timer", this.mvTimerHandler);
            this.managerEnterFrame.addEventListener(Event.ENTER_FRAME, this.onManagerEnterFrame, false, 0, true);
            this.autoActionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.autoActionHandler, false, 0, true);
            this.restTimer.addEventListener("timer", this.restRequest, false, 0, true);
            this.afkTimer.addEventListener("timer", this.afkTimerHandler, false, 0, true);
            this.mvTimer.addEventListener("timer", this.mvTimerHandler, false, 0, true);
            this.initCutscenes();
        }

        private static function countDownActSkill(icon2:Bitmap, i:int, _local8:Number):void
        {
            var skill:MovieClip = icon2.mask[("e" + i)];
            if (skill == null)
            {
                return;
            };
            if (i < _local8)
            {
                skill.y = -300;
            }
            else
            {
                skill.y = icon2.mask[(("e" + i) + "oy")];
                if (i > _local8)
                {
                    skill.gotoAndStop(0);
                };
            };
        }


        public function get Scale():Number
        {
            return (this.SCALE);
        }

        public function get map():MovieClip
        {
            return (this._map);
        }

        public function set map(value:MovieClip):void
        {
            if (((!(this.map == null)) && (this.contains(this.map))))
            {
                this.removeChild(this.map);
            };
            this._map = value;
        }

        public function initGuildhallData(guildData:Array):void
        {
            this.guildHallData = new GuildHall(guildData, this.rootClass);
        }

        public function killWorld():void
        {
            this.managerEnterFrame.removeEventListener(Event.ENTER_FRAME, this.onManagerEnterFrame);
            this.autoActionTimer.reset();
            this.restTimer.reset();
            this.afkTimer.reset();
            Timer(this.rootClass.chatF.mute.timer).reset();
            this.autoActionTimer.removeEventListener("timer", this.autoActionHandler);
            this.restTimer.removeEventListener("timer", this.restRequest);
            this.afkTimer.removeEventListener("timer", this.afkTimerHandler);
            this.mvTimer.removeEventListener("timer", this.mvTimerHandler);
            Timer(this.rootClass.chatF.mute.timer).removeEventListener("timer", this.rootClass.chatF.unmuteMe);
        }

        public function getClass(linkage:String):Class
        {
            if (((this.rootClass.assetsDomain) && (this.rootClass.assetsDomain.hasDefinition(linkage))))
            {
                return (Class(this.rootClass.assetsDomain.getDefinition(linkage)));
            };
            if (Config.isDebug)
            {
                trace("[World] getClass not found from Asset", linkage);
            };
            if (ApplicationDomain.currentDomain.hasDefinition(linkage))
            {
                return (Class(ApplicationDomain.currentDomain.getDefinition(linkage)));
            };
            if (Config.isDebug)
            {
                trace("[World] getClass not found from Game", linkage);
            };
            if (LoadController.singleton.applicationDomainAvatar.hasDefinition(linkage))
            {
                return (Class(LoadController.singleton.applicationDomainAvatar.getDefinition(linkage)));
            };
            if (Config.isDebug)
            {
                trace("[World] getClass not found from Loader Avatar", linkage);
            };
            if (LoadController.singleton.applicationDomainEmoji.hasDefinition(linkage))
            {
                return (Class(LoadController.singleton.applicationDomainEmoji.getDefinition(linkage)));
            };
            if (Config.isDebug)
            {
                trace("[World] getClass not found from Loader Emoji", linkage);
            };
            if (LoadController.singleton.applicationDomainMap.hasDefinition(linkage))
            {
                return (Class(LoadController.singleton.applicationDomainMap.getDefinition(linkage)));
            };
            if (Config.isDebug)
            {
                trace("[World] getClass not found from Loader Map", linkage);
            };
            if (LoadController.singleton.applicationDomainGlobal.hasDefinition(linkage))
            {
                return (Class(LoadController.singleton.applicationDomainGlobal.getDefinition(linkage)));
            };
            if (Config.isDebug)
            {
                trace("[World] getClass not found from Loader Global", linkage);
            };
            return (null);
        }

        public function loadMusic():*
        {
            if (this.musicFile != "")
            {
                Game.loadBGM(Config.getLoadPath(this.musicFile));
            };
        }

        public function loadMap(mapFile:String, musicFile:String=null):void
        {
            this.rootClass.mcConnDetail.showConn("Loading Map Files...");
            this.musicFile = musicFile;
            SoundMixer.stopAll();
            this.loadMusic();
            this.musicLoaded = false;
            this.clearMap();
            this.rootClass.chatF.addToCannedChat({
                "parent":"History",
                "id":"Join History",
                "display":("/join " + this.strAreaName),
                "text":this.strAreaName
            }, this.rootClass.chatF.getJsonCannedChatMenu());
            LoadController.singleton.addLoadMap(("maps/" + mapFile), "map", this.onMapLoadComplete, this.onMapLoadError, this.onMapLoadProgress, true);
            this.rootClass.clearPopups();
        }

        private function clearMap():void
        {
            if (((!(this.map == null)) && (this.contains(this.map))))
            {
                this.removeChild(this.map);
            };
        }

        public function reloadCurrentMap():void
        {
            this.clearMonstersAndProps();
            LoadController.singleton.clearLoaderByType("map");
            this.loadMap(((this.strMapFileName + "?") + Math.random()));
        }

        public function enterMap():void
        {
            var userTreeNode:Object = this.uoTreeLeaf(this.rootClass.network.myUserName);
            if (((this.intType == 0) || (this.returnInfo == null)))
            {
                this.moveToCell(userTreeNode.strFrame, userTreeNode.strPad);
            }
            else
            {
                this.moveToCell(this.returnInfo.strCell, this.returnInfo.strPad);
                this.returnInfo = null;
            };
            this.initMapEvents();
            this.rootClass.mcConnDetail.toHide = true;
            this.rootClass.ui.mcInterface.areaList.visible = true;
            if (this.isCycle)
            {
                this.kathleenIsTheBestSystemInTheWholeDimensionOfArtixEntertainment(this.map);
            };
        }

        public function kathleenIsTheBestSystemInTheWholeDimensionOfArtixEntertainment(mc:MovieClip, width:int=960, height:int=550):void
        {
            this.GameMonth = this.rootClass.getServerTime().getMonth();
            this.GameTime = this.rootClass.date_server.hours;
            switch (true)
            {
                case ((this.GameTime >= 0) && (this.GameTime < 6)):
                    this.SkyMC = new NightMC(this.rootClass);
                    this.WeatherColor.brightness = -20;
                    this.WeatherColor.contrast = 0;
                    this.WeatherColor.saturation = 0;
                    this.WeatherColor.hue = 0;
                    break;
                case ((this.GameTime >= 6) && (this.GameTime < 12)):
                    this.SkyMC = new DayMC(this.rootClass);
                    this.WeatherColor.brightness = 0;
                    this.WeatherColor.contrast = 0;
                    this.WeatherColor.saturation = 0;
                    this.WeatherColor.hue = 0;
                    break;
                case ((this.GameTime >= 12) && (this.GameTime < 15)):
                    this.SkyMC = new Afternoon1MC(this.rootClass);
                    this.WeatherColor.brightness = 0;
                    this.WeatherColor.contrast = 0;
                    this.WeatherColor.saturation = 0;
                    this.WeatherColor.hue = 0;
                    break;
                case ((this.GameTime >= 15) && (this.GameTime < 16)):
                    this.SkyMC = new Afternoon1MC(this.rootClass);
                    this.WeatherColor.brightness = -10;
                    this.WeatherColor.contrast = 0;
                    this.WeatherColor.saturation = 0;
                    this.WeatherColor.hue = 0;
                    break;
                case ((this.GameTime >= 16) && (this.GameTime < 18)):
                    this.SkyMC = new Afternoon2MC(this.rootClass);
                    this.WeatherColor.brightness = -10;
                    this.WeatherColor.contrast = 0;
                    this.WeatherColor.saturation = 0;
                    this.WeatherColor.hue = 0;
                    break;
                case ((this.GameTime >= 18) && (this.GameTime < 24)):
                    this.SkyMC = new NightMC(this.rootClass);
                    this.WeatherColor.brightness = -40;
                    this.WeatherColor.contrast = 0;
                    this.WeatherColor.saturation = 0;
                    this.WeatherColor.hue = 0;
                    break;
            };
            this.sky = new MovieClip();
            mc.addChildAt(this.sky, 0);
            this.sky.addChild(this.SkyMC);
            this.sky.width = width;
            this.sky.height = height;
            this.resizeSky();
        }

        public function setReturnInfo(_arg1:String, _arg2:String, _arg3:String):void
        {
            this.returnInfo = {};
            this.returnInfo.strMap = _arg1;
            this.returnInfo.strCell = _arg2;
            this.returnInfo.strPad = _arg3;
        }

        public function exitCell():void
        {
            this.mvTimerKill();
            this.exitCombat();
            this.mapController.destroy();
            this.rootClass.clearPopups(["House"]);
            if (this.myAvatar != null)
            {
                this.myAvatar.targets = {};
                if (this.myAvatar.pMC != null)
                {
                    this.myAvatar.pMC.stopWalking();
                };
                if (this.myAvatar.petMC != null)
                {
                    this.myAvatar.petMC.stopWalking();
                };
                if (this.myAvatar.target != null)
                {
                    this.setTarget(null);
                };
            };
            if (this.strFrame != "Wait")
            {
                this.clearMonstersAndProps();
                this.hideAllAvatars();
            };
            this.rootClass.sfcSocial = false;
            this.rootClass.ui.mcInterface.areaList.gotoAndStop("init");
        }

        public function moveToCell(frame:String, pad:String, request:Boolean=false):void
        {
            if (((this.strMapName == "battleon") && (frame == "Enter")))
            {
                this.rootClass.gameMenu.open();
            }
            else
            {
                this.rootClass.gameMenu.close();
            };
            UIController.closeAll();
            if (this.bSpectate)
            {
                pad = "Spectator";
            };
            this.afkPostpone();
            if (((((this.objLock == null) || (this.objLock[frame] == null)) || (this.objLock[frame] <= this.intKillCount)) && (this.uoTree[this.rootClass.network.myUserName].freeze == null)))
            {
                this.strMap = this.strMapName;
                this.rootClass.network.send("moveToCell", [frame, pad]);
            };
        }

        public function moveToCellByIDa(_arg1:int):void
        {
            if (this.bSpectate)
            {
                return;
            };
            this.rootClass.network.send("mtcid", [_arg1]);
        }

        public function moveToCellByIDb(_arg1:int):void
        {
            var _local2:MovieClip;
            var _local3:int;
            if (this.bSpectate)
            {
                return;
            };
            while (_local3 < this.arrEvent.length)
            {
                _local2 = (this.arrEvent[_local3] as MovieClip);
                if (((("tID" in _local2) && (_local2.tID == _arg1)) || ((_local2.name.indexOf("ia") == 0) && (int(_local2.name.substr(2)) == _arg1))))
                {
                    this.moveToCell(_local2.tCell, _local2.tPad, true);
                };
                _local3++;
            };
        }

        public function closeAPOP(_arg1:String):void
        {
            this.rootClass.network.send("apopClose", [_arg1]);
        }

        public function openAPOP(_arg1:String):void
        {
            this.rootClass.network.send("apopOpen", [_arg1]);
        }

        public function hideAllAvatars():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((avatar) && (avatar.pMC)))
                {
                    avatar.hideMC();
                };
            };
        }

        public function hideMap():void
        {
            this.visible = false;
        }

        public function showMap():void
        {
            this.visible = true;
        }

        public function hidePlayers():void
        {
            var avatar:Avatar;
            var avatarMC:AvatarMC;
            for each (avatar in this.avatars)
            {
                if (((!(avatar.isMyAvatar)) && (avatar.pMC)))
                {
                    avatarMC = AvatarMC(avatar.pMC);
                    avatarMC.mcChar.visible = false;
                    avatarMC.setEntityVisibility(false);
                    if (avatarMC.shadow != null)
                    {
                        avatarMC.shadow.visible = false;
                    };
                };
            };
        }

        public function showPlayers():void
        {
            var avatar:Avatar;
            var avatarMC:AvatarMC;
            for each (avatar in this.avatars)
            {
                if (((!(avatar.isMyAvatar)) && (avatar.pMC)))
                {
                    avatarMC = AvatarMC(avatar.pMC);
                    avatarMC.mcChar.visible = true;
                    avatarMC.setEntityVisibility(true);
                    if (((Game.root.userPreference.data.hideOtherEntities) && (!(avatarMC.mcChar.visible))))
                    {
                        avatarMC.mcChar.visible = true;
                    };
                    if (avatarMC.shadow != null)
                    {
                        avatarMC.shadow.visible = true;
                    };
                };
            };
        }

        public function hideNPCS():void
        {
            var avatar:Avatar;
            var avatarMC:AvatarMC;
            for each (avatar in this.npcs)
            {
                if (avatar.pMC)
                {
                    avatarMC = AvatarMC(avatar.pMC);
                    avatarMC.setEntityVisibility(false);
                    avatarMC.mcChar.visible = false;
                    if (avatarMC.shadow != null)
                    {
                        avatarMC.shadow.visible = false;
                    };
                };
            };
        }

        public function showNPCS():void
        {
            var avatar:Avatar;
            var avatarMC:AvatarMC;
            for each (avatar in this.npcs)
            {
                if (avatar.pMC)
                {
                    avatarMC = AvatarMC(avatar.pMC);
                    avatarMC.mcChar.visible = true;
                    avatarMC.setEntityVisibility(true);
                    if (avatarMC.shadow != null)
                    {
                        avatarMC.shadow.visible = true;
                    };
                };
            };
        }

        public function hideMonsters():void
        {
            var monster:Avatar;
            for each (monster in this.monsters)
            {
                if (monster.pMC)
                {
                    monster.pMC.mcChar.visible = false;
                    monster.pMC.shadow.visible = false;
                };
            };
        }

        public function showMonsters():void
        {
            var monster:Avatar;
            for each (monster in this.monsters)
            {
                if (monster.pMC)
                {
                    monster.pMC.mcChar.visible = true;
                    monster.pMC.shadow.visible = true;
                };
            };
        }

        public function clearAllAvatars():void
        {
            var avatarsKey:String;
            for (avatarsKey in this.avatars)
            {
                this.destroyAvatar(Number(avatarsKey));
            };
            this.avatars = {};
        }

        public function updateMonstersAndProps():void
        {
            var displayObject:DisplayObject;
            var i:int;
            while (i < this.CHARS.numChildren)
            {
                displayObject = this.CHARS.getChildAt(i);
                if (((displayObject.hasOwnProperty("isProp")) && (MovieClip(displayObject).isProp)))
                {
                    displayObject.visible = (!(this.isRemoveProps));
                }
                else
                {
                    if ((((displayObject.hasOwnProperty("isMonster")) && (MonsterMC(displayObject).isMonster)) && (MonsterMC(displayObject).isGenerated)))
                    {
                        MonsterMC(displayObject).fClose();
                    }
                    else
                    {
                        if (((displayObject.hasOwnProperty("pAV")) && (MovieClip(displayObject).pAV.npcType == "npc")))
                        {
                            displayObject.visible = (!(this.isRemoveProps));
                        };
                    };
                };
                i++;
            };
            i = 0;
            while (i < this.TRASH.numChildren)
            {
                displayObject = this.TRASH.getChildAt(i);
                if (((displayObject.hasOwnProperty("isProp")) && (MovieClip(displayObject).isProp)))
                {
                    displayObject.visible = (!(this.isRemoveProps));
                }
                else
                {
                    if ((((displayObject.hasOwnProperty("isMonster")) && (MovieClip(displayObject).isMonster)) && (MonsterMC(displayObject).isGenerated)))
                    {
                        MonsterMC(displayObject).fClose();
                    };
                };
                i++;
            };
        }

        public function clearMonstersAndProps():void
        {
            var displayObject:DisplayObject;
            var i:int;
            while (i < this.CHARS.numChildren)
            {
                displayObject = this.CHARS.getChildAt(i);
                if (((displayObject.hasOwnProperty("isProp")) && (MovieClip(displayObject).isProp)))
                {
                    this.CHARS.removeChild(displayObject);
                    i--;
                }
                else
                {
                    if (((displayObject.hasOwnProperty("isHouseItem")) && (MovieClip(displayObject).isHouseItem)))
                    {
                        displayObject.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHouseItemClick);
                        this.CHARS.removeChild(displayObject);
                        i--;
                    }
                    else
                    {
                        if (((displayObject.hasOwnProperty("isMonster")) && (MonsterMC(displayObject).isMonster)))
                        {
                            MonsterMC(displayObject).fClose();
                            i--;
                        }
                        else
                        {
                            if (((displayObject.hasOwnProperty("pAV")) && (MovieClip(displayObject).pAV.npcType == "npc")))
                            {
                                this.CHARS.removeChild(displayObject);
                                i--;
                            };
                        };
                    };
                };
                i++;
            };
            i = 0;
            while (i < this.TRASH.numChildren)
            {
                displayObject = this.TRASH.getChildAt(i);
                if (((displayObject.hasOwnProperty("isMonster")) && (MovieClip(displayObject).isMonster)))
                {
                    MonsterMC(displayObject).fClose();
                    i--;
                };
                i++;
            };
            i = 0;
            while (i < this.monsters.length)
            {
                Avatar(this.monsters[i]).pMC = null;
                i++;
            };
            while (this.rootClass.ui.mcPadNames.numChildren)
            {
                displayObject = this.rootClass.ui.mcPadNames.getChildAt(0);
                MovieClip(displayObject).stop();
                this.rootClass.ui.mcPadNames.removeChild(displayObject);
            };
        }

        public function setMapEvents(_arg1:Object):void
        {
            this.mapEvents = _arg1;
        }

        public function initMapEvents():void
        {
            if ((("eventUpdate" in this.map) && (!(this.mapEvents == null))))
            {
                this.map.eventUpdate({
                    "cmd":"event",
                    "args":this.mapEvents
                });
            };
            this.mapEvents = null;
        }

        public function setCellMap(_arg1:Object):void
        {
            this.cellMap = _arg1;
        }

        public function updateCellMap(_arg1:Object):void
        {
            var _local3:String;
            var _local4:MovieClip;
            var _local5:String;
            var _local2:Object = {};
            for (_local3 in this.cellMap)
            {
                _local2 = this.cellMap[_local3];
                if (((!(_local2.ias == null)) && (!(_local2.ias[_arg1.ID] == null))))
                {
                    for (_local5 in _arg1)
                    {
                        _local2.ias[_arg1.ID][_local5] = _arg1[_local5];
                    };
                };
            };
            try
            {
                _local4 = MovieClip(this.CHARS.getChildByName(("ia" + _arg1.ID)));
                _local4.update();
                return;
            }
            catch(e:Error)
            {
            };
            try
            {
                _local4 = MovieClip(this.map.getChildByName(("ia" + _arg1.ID)));
                _local4.update();
            }
            catch(e:Error)
            {
            };
        }

        public function onWalkClick():void
        {
            var mcNPCBuilder:mcNPCTool;
            var mvPT:Point;
            if (this.myAvatar == null)
            {
                return;
            };
            if (this.myAvatar.isStaff())
            {
                mcNPCBuilder = mcNPCTool(UIController.getByName("npc_tool"));
                if (mcNPCBuilder != null)
                {
                    mcNPCBuilder.txtFrame.text = this.strFrame;
                    mcNPCBuilder.txtCell.text = this.strPad;
                    mcNPCBuilder.txtX.text = this.map.mouseX;
                    mcNPCBuilder.txtY.text = this.map.mouseY;
                };
            };
            if (!this.isMoveOK(this.myAvatar.dataLeaf))
            {
                return;
            };
            if (this.strPad == "Spectator")
            {
                return;
            };
            var p:Point = new Point(mouseX, mouseY);
            var initialSpeed:* = this.WALKSPEED;
            if (this.myAvatar.pMC.isFlying)
            {
                initialSpeed = (initialSpeed + 10);
            };
            if (this.bitWalk)
            {
                this.afkPostpone();
                if (((((mouseX >= 0) && (mouseX <= 960)) && (mouseY >= 0)) && (mouseY <= 550)))
                {
                    p = this.CHARS.globalToLocal(p);
                    p.x = Math.round(p.x);
                    p.y = Math.round(p.y);
                    mvPT = this.myAvatar.pMC.simulateTo(p.x, p.y, initialSpeed);
                    if (mvPT != null)
                    {
                        this.myAvatar.pMC.walkTo(mvPT.x, mvPT.y, initialSpeed);
                        if (((this.bPvP) || (this.clickOnEventTest(mvPT.x, mvPT.y))))
                        {
                            this.pushMove(AvatarMC(this.myAvatar.pMC), mvPT.x, mvPT.y, initialSpeed);
                        }
                        else
                        {
                            this.moveRequest({
                                "mc":this.myAvatar.pMC,
                                "tx":mvPT.x,
                                "ty":mvPT.y,
                                "sp":initialSpeed
                            });
                        };
                    };
                };
            };
        }

        public function clickOnEventTest(_arg1:int, _arg2:int):Boolean
        {
            var _local5:int;
            var _local3:Rectangle = this.myAvatar.pMC.shadow.getBounds(this);
            var _local4:Rectangle = new Rectangle();
            _local3.x = (_arg1 - (_local3.width / 2));
            _local3.y = (_arg2 - (_local3.height / 2));
            while (_local5 < this.arrEvent.length)
            {
                if (this.arrEvent[_local5].shadow)
                {
                    _local4 = this.arrEvent[_local5].shadow.getBounds(this);
                    if (_local3.intersects(_local4))
                    {
                        return (true);
                    };
                };
                _local5++;
            };
            return (false);
        }

        public function moveRequest(_arg1:Object):void
        {
            if (!this.mvTimer.running)
            {
                this.pushMove(_arg1.mc, _arg1.tx, _arg1.ty, _arg1.sp);
                this.mvTimer.reset();
                this.mvTimer.start();
            }
            else
            {
                this.mvTimerObj = _arg1;
            };
        }

        public function mvTimerKill():void
        {
            this.mvTimer.reset();
            this.mvTimerObj = null;
        }

        public function pushMove(avatarMC:AvatarMC, xAxis:int, yAxis:int, speed:int):void
        {
            this.uoTreeLeafSet(this.rootClass.network.myUserName, {
                "tx":int(xAxis),
                "ty":int(yAxis),
                "sp":int(speed)
            });
            this.rootClass.network.send("mv", [xAxis, yAxis, speed, this.SCALE]);
        }

        public function monstersToPads():*
        {
            var _local1:*;
            var _local2:*;
            for (_local1 in this.monsters)
            {
                _local2 = this.monsters[_local1];
                if (((!(_local2.objData == null)) && (_local2.objData.strFrame == this.strFrame)))
                {
                    _local2.pMC.walkTo(_local2.pMC.ox, _local2.pMC.oy, (this.WALKSPEED * 1.4));
                };
            };
        }

        public function updatePadNames():*
        {
            var _local2:*;
            var _local1:int;
            while (_local1 < this.rootClass.ui.mcPadNames.numChildren)
            {
                _local2 = MovieClip(this.rootClass.ui.mcPadNames.getChildAt(_local1));
                if ((((this.objLock == null) || (this.objLock[_local2.tCell] == null)) || (this.objLock[_local2.tCell] <= this.intKillCount)))
                {
                    _local2.cnt.lock.visible = false;
                }
                else
                {
                    _local2.cnt.lock.visible = true;
                };
                _local1++;
            };
        }

        public function resizeSky():*
        {
            this.sky.width = ((((this.map) && (this.map.Walkable)) && (this.map.Walkable.width > 0)) ? width : 960);
            this.sky.height = ((((this.map) && (this.map.Walkable)) && (this.map.Walkable.height > 0)) ? height : 550);
        }

        public function cellSetup(scale:Number, speed:Number, cellMode:String):void
        {
            var displayObject:DisplayObject;
            var mapMovieClip:MovieClip;
            var i2:int;
            var displayObject1:DisplayObject;
            var monsterMap:Object;
            var movieClip:MovieClip;
            var uniqueMonMapIDs:Object;
            var j:int;
            var processedMonsters:Object;
            var ii:int;
            var monMapID:int;
            var monster:Object;
            var currentMonMapID:int;
            var monsters:Array;
            var avatar:Avatar;
            this.SCALE = scale;
            this.WALKSPEED = speed;
            this.CELL_MODE = cellMode.toLowerCase();
            this.CHARS.x = 0;
            this.CHARS.y = 0;
            this.map.x = 0;
            this.map.y = 0;
            this.arrSolid = [];
            this.arrEvent = [];
            var i:int;
            if (this.frames != null)
            {
                this.mapController.build(this.frames, this.map.currentLabel);
            };
            var data:Object = this.mapController.find(this.frames, this.map.currentLabel);
            this.resizeSky();
            var monstersPads:Array = [];
            var monsterMapsIDs:Array = [];
            for (;i < this.map.numChildren;)
            {
                displayObject = this.map.getChildAt(i);
                if ((displayObject is MovieClip))
                {
                    mapMovieClip = MovieClip(displayObject);
                    if (((((!(data == null)) && (data.isRemoveOld)) && (!(mapMovieClip is AbstractPad))) && (((mapMovieClip.isSolid) || (mapMovieClip.isEvent)) || (mapMovieClip.isMonster))))
                    {
                        this.map.removeChild(mapMovieClip);
                        if (!mapMovieClip.isSolid)
                        {
                            continue;
                        };
                    };
                    if (mapMovieClip.hasPads)
                    {
                        i2 = 0;
                        while (i2 < mapMovieClip.numChildren)
                        {
                            displayObject1 = mapMovieClip.getChildAt(i2);
                            if ((displayObject1 is MovieClip))
                            {
                                if (((MovieClip(displayObject1).isEvent) && (!(MovieClip(displayObject1).isProp))))
                                {
                                    this.arrEvent.push(MovieClip(displayObject1));
                                };
                                if (MovieClip(displayObject1).isSolid)
                                {
                                    this.arrSolid.push(mapMovieClip);
                                };
                            };
                            i2++;
                        };
                    };
                    if (mapMovieClip.isSolid)
                    {
                        this.arrSolid.push(mapMovieClip);
                    };
                    if (("walk" in displayObject))
                    {
                        mapMovieClip.btnWalkingArea.useHandCursor = false;
                    };
                    if (((mapMovieClip.isEvent) && (!(mapMovieClip.isProp))))
                    {
                        this.arrEvent.push(mapMovieClip);
                    };
                    if (((mapMovieClip.isMonster) && (!(this.isRemoveProps))))
                    {
                        if (((monsterMapsIDs.indexOf(mapMovieClip.MonMapID) === -1) && (!(this.monmap == null))))
                        {
                            monsterMap = this.getMonsterMap(mapMovieClip.MonMapID);
                            monstersPads.push({
                                "x":mapMovieClip.x,
                                "y":mapMovieClip.y,
                                "isGenerated":mapMovieClip.isGenerated,
                                "strDir":mapMovieClip.strDir,
                                "intScale":(((monsterMap == undefined) || (monsterMap.intScale == undefined)) ? mapMovieClip.intScale : monsterMap.intScale),
                                "noMove":mapMovieClip.noMove,
                                "MonMapID":mapMovieClip.MonMapID
                            });
                            monsterMapsIDs.push(mapMovieClip.MonMapID);
                        };
                    };
                    if (mapMovieClip.isProp)
                    {
                        movieClip = MovieClip(this.CHARS.addChild(displayObject));
                        if (this.isRemoveProps)
                        {
                            removeChild(movieClip);
                        }
                        else
                        {
                            if (movieClip.isEvent)
                            {
                                this.arrEvent.push(movieClip);
                                movieClip.isEvent = false;
                            };
                        };
                        i--;
                    };
                    if (((((mapMovieClip.width > 700) && (!("isSolid" in displayObject))) && (!("walk" in displayObject))) && (!("btnSkip" in displayObject))))
                    {
                        mapMovieClip.mouseEnabled = false;
                        mapMovieClip.mouseChildren = false;
                    };
                };
                i++;
            };
            if (this.monmap != null)
            {
                uniqueMonMapIDs = {};
                j = (this.monmap.length - 1);
                while (j >= 0)
                {
                    monMapID = this.monmap[j].MonMapID;
                    if (((!(monsterMapsIDs.indexOf(monMapID) === -1)) || (uniqueMonMapIDs[monMapID])))
                    {
                    }
                    else
                    {
                        if (this.strFrame != this.monmap[j].strFrame)
                        {
                        }
                        else
                        {
                            uniqueMonMapIDs[monMapID] = true;
                            monstersPads.push({
                                "x":this.monmap[j].X,
                                "y":this.monmap[j].Y,
                                "isGenerated":false,
                                "strDir":this.monmap[j].face,
                                "intScale":((this.monmap[j].scale == null) ? undefined : (this.monmap[j].scale / 10)),
                                "noMove":this.monmap[j].noMove,
                                "MonMapID":monMapID
                            });
                        };
                    };
                    j--;
                };
                processedMonsters = {};
                ii = 0;
                while (ii < monstersPads.length)
                {
                    monster = monstersPads[ii];
                    currentMonMapID = monster.MonMapID;
                    if (processedMonsters[currentMonMapID])
                    {
                    }
                    else
                    {
                        processedMonsters[currentMonMapID] = true;
                        monsters = this.getMonsters(currentMonMapID);
                        for each (avatar in monsters)
                        {
                            if (((!(avatar == null)) && (!(monster.isGenerated))))
                            {
                                avatar.pMC = this.createMonsterMC(monster, avatar.objData.MonID);
                                avatar.pMC.isGenerated = (monster is AbstractPad);
                                avatar.pMC.pAV = avatar;
                                avatar.pMC.setData();
                                this.loadAuraByDataLeaf(avatar.dataLeaf, avatar);
                                if (avatar.dataLeaf == null)
                                {
                                    this.TRASH.addChild(avatar.pMC);
                                };
                            };
                        };
                    };
                    ii++;
                };
            };
            this.buildBoundingRects();
            if (this.map.bounds != null)
            {
                this.mapBoundsMC = MovieClip(this.map.getChildByName("bounds"));
            };
            this.playerInit();
            this.updateNpcs();
            this.updateMonsters();
            this.updatePadNames();
            if (!Game.root.userPreference.data.disableRenderMapAsBitmap)
            {
                this.rebuildMapBMP(this.map);
            };
            this.mapScrollCheck(true);
            if (this.objectmap != null)
            {
                this.updateMapObjects();
            };
            if (this.objHouseData != null)
            {
                this.updateHouseItems();
            };
            if (this.guildHallData != null)
            {
                this.guildHallData.updateInterior();
            };
            this.rootClass.antiLagCheck();
        }

        public function getMonsterMap(requiredMonsterMapID:int):Object
        {
            var monsterMap:Object;
            var j:int = (this.monmap.length - 1);
            while (j >= 0)
            {
                monsterMap = this.monmap[j];
                if (requiredMonsterMapID == monsterMap.MonMapID)
                {
                    return ({
                        "x":monsterMap.X,
                        "y":monsterMap.Y,
                        "isGenerated":false,
                        "strDir":monsterMap.face,
                        "intScale":((monsterMap.scale != null) ? (monsterMap.scale / 10) : undefined),
                        "noMove":monsterMap.noMove,
                        "MonMapID":monsterMap.MonMapID
                    });
                };
                j--;
            };
            return (undefined);
        }

        public function killWalkObjects():void
        {
            var _local2:DisplayObject;
            var _local1:int;
            while (_local1 < this.map.numChildren)
            {
                _local2 = this.map.getChildAt(_local1);
                if (((_local2 is MovieClip) && (MovieClip(_local2).isEvent)))
                {
                    removeEventListener("enter", MovieClip(_local2).onEnter);
                };
                _local1++;
            };
        }

        public function gotoTown(areaName:String, frame:String, pad:String, skipCooldown:Boolean=false):void
        {
            var data:Object = this.uoTree[this.rootClass.network.myUserName];
            if (data.intState == 0)
            {
                this.rootClass.chatF.pushMsg("warning", "You are dead!", "SERVER", "", 0);
                return;
            };
            if (((!(this.rootClass.world.myAvatar.invLoaded)) || (!(AvatarMC(this.rootClass.world.myAvatar.pMC).artLoaded))))
            {
                this.rootClass.MsgBox.notify("Character still being loaded.");
                return;
            };
            if (((skipCooldown) || (this.coolDown("tfer"))))
            {
                this.rootClass.MsgBox.notify(("Joining " + areaName));
                this.setReturnInfo(areaName, frame, pad);
                this.rootClass.network.send("cmd", ["tfer", this.rootClass.network.myUserName, areaName, frame, pad]);
                return;
            };
            this.rootClass.MsgBox.notify("You must wait 5 seconds before joining another map.");
        }

        public function gotoQuest(_arg1:String, _arg2:String, _arg3:String):void
        {
            this.gotoTown(_arg1, _arg2, _arg3);
        }

        public function openApop(_arg1:*, _arg2:*=null):*
        {
            var _local2:MovieClip;
            if (this.myAvatar == null)
            {
                return;
            };
            if (this.myAvatar.objData == null)
            {
                return;
            };
            if ((((this.isMovieFront("Apop")) || (!("frame" in _arg1))) || (("frame" in _arg1) && ("cnt" in _arg1))))
            {
                this.removeMovieFront();
                this.rootClass.gameMenu.close();
                _local2 = this.attachMovieFront("Apop");
                _local2.update(_arg1, _arg2);
            };
        }

        public function setSpawnPoint(_arg1:*, _arg2:*):void
        {
            this.spawnPoint.strFrame = _arg1;
            this.spawnPoint.strPad = _arg2;
        }

        public function initObjExtra(_arg1:String):void
        {
            var _local2:Array;
            var _local3:int;
            var _local4:Array;
            this.objExtra = {};
            if (((!(_arg1 == null)) && (!(_arg1 == ""))))
            {
                _local2 = _arg1.split(",");
                _local3 = 0;
                while (_local3 < _local2.length)
                {
                    _local4 = _local2[_local3].split("=");
                    this.objExtra[_local4[0]] = _local4[1];
                    _local3++;
                };
            };
        }

        public function rebuildMapBMP(map:MovieClip):void
        {
            var child:MovieClip;
            this.clearMapBmps();
            this.mapW = ((map.Walkable) ? map.Walkable.width : 960);
            this.mapH = ((map.Walkable) ? map.Walkable.height : 550);
            var i:int;
            while (i < map.numChildren)
            {
                child = (map.getChildAt(i) as MovieClip);
                if (((((((((((((child is MovieClip) && (child.width >= 960)) && (child.name.toLowerCase().indexOf("bmp") == -1)) && (child.name.toLowerCase().indexOf("cs") == -1)) && (child.name.toLowerCase().indexOf("bounds") == -1)) && (((child as MovieClip) == null) || (MovieClip(child).totalFrames < 15))) && (!("isSolid" in child))) && (!("isFloor" in child))) && (!("isWall" in child))) && (!("walk" in child))) && (!("btnSkip" in child))) && (!("noBmp" in child))))
                {
                    this.mapBmps.push(new MapBitmap({
                        "child":child,
                        "x":child.x,
                        "bmDO":null
                    }));
                };
                i++;
            };
            this.rasterize(this.mapBmps);
        }

        private function rasterize(bmps:Vector.<MapBitmap>, _arg2:Boolean=false):void
        {
            var mapBitmap:MapBitmap;
            var point:Point;
            var matrix:Matrix;
            var bmpName:String;
            var displayObject:DisplayObject;
            this.mapNW = ((this.map.Walkable) ? this.map.Walkable.width : this.rootClass.stage.stageWidth);
            var _local3:Number = (this.mapNW / this.mapW);
            this.mapNH = Math.round((this.mapH * _local3));
            var i:int = 1;
            for each (mapBitmap in bmps)
            {
                mapBitmap.child.x = mapBitmap.x;
                if (mapBitmap.bmd != null)
                {
                    mapBitmap.bmd.dispose();
                };
                mapBitmap.bmd = new BitmapData(this.mapNW, this.mapNH, true, 0x999999);
                point = new Point(0, 0);
                point = mapBitmap.child.globalToLocal(point);
                matrix = new Matrix((_local3 * mapBitmap.child.transform.matrix.a), 0, 0, (_local3 * mapBitmap.child.transform.matrix.d), -((point.x * _local3) * mapBitmap.child.transform.matrix.a), -((point.y * _local3) * mapBitmap.child.transform.matrix.d));
                mapBitmap.bmd.draw(mapBitmap.child, matrix, mapBitmap.child.transform.colorTransform, null, new Rectangle(0, 0, this.mapNW, this.mapNH), false);
                mapBitmap.bm = new Bitmap(mapBitmap.bmd);
                bmpName = String(("bmp" + i));
                displayObject = mapBitmap.child.parent.getChildByName(bmpName);
                if (displayObject != null)
                {
                    mapBitmap.child.parent.removeChild(displayObject);
                };
                mapBitmap.bmDO = Bitmap(mapBitmap.child.parent.addChildAt(mapBitmap.bm, (mapBitmap.child.parent.getChildIndex(mapBitmap.child) + 1)));
                mapBitmap.bmDO.name = bmpName;
                mapBitmap.bmDO.width = this.mapW;
                mapBitmap.bmDO.height = this.mapH;
                mapBitmap.child.visible = false;
                if (_arg2)
                {
                    mapBitmap.child.x = (mapBitmap.child.x + 1200);
                };
                i++;
            };
        }

        private function clearMapBmps():void
        {
            var mapBitmap:MapBitmap;
            if (this.mapBmps.length > 0)
            {
                for each (mapBitmap in this.mapBmps)
                {
                    mapBitmap.bmDO.parent.removeChild(mapBitmap.bmDO);
                    if (mapBitmap.bmd != null)
                    {
                        mapBitmap.bmd.dispose();
                    };
                    mapBitmap.child = null;
                    mapBitmap.bmd = null;
                    mapBitmap.bm = null;
                };
            };
            this.mapBmps = new Vector.<MapBitmap>();
        }

        public function initMap():MapData
        {
            this.mData = new MapData();
            return (this.mData);
        }

        public function initCutscenes():cutsceneHandler
        {
            this.cHandle = new cutsceneHandler(this.rootClass);
            return (this.cHandle);
        }

        public function initSound(sound:Sound):soundController
        {
            this.sController = new soundController(sound);
            return (this.sController);
        }

        public function gotoHouse(_arg1:String):void
        {
            _arg1 = _arg1.toLowerCase();
            if (((!(this.objHouseData == null)) && (this.objHouseData.unm == _arg1)))
            {
                return;
            };
            this.rootClass.network.send("house", [_arg1]);
        }

        public function isHouseEquipped():Boolean
        {
            var _local1:int;
            while (_local1 < this.myAvatar.houseitems.length)
            {
                if (this.myAvatar.houseitems[_local1].bEquip)
                {
                    return (true);
                };
                _local1++;
            };
            return (false);
        }

        public function isMyHouse():*
        {
            return ((((!(this.objHouseData == null)) && (!(this.myAvatar == null))) && (!(this.myAvatar.objData == null))) && (this.objHouseData.unm == this.myAvatar.objData.strUsername.toLowerCase()));
        }

        public function showHouseOptions(_arg1:String):void
        {
            var _local2:MovieClip = this.rootClass.ui.mcPopup.mcHouseOptions;
            switch (_arg1)
            {
                case "default":
                case "save":
                default:
                    _local2.visible = true;
                    _local2.bg.x = 0;
                    _local2.cnt.x = 0;
                    _local2.tTitle.x = 5;
                    _local2.bExpand.x = 190;
                    _local2.bg.visible = true;
                    _local2.cnt.visible = true;
                    _local2.tTitle.visible = true;
                    _local2.bExpand.visible = false;
                    return;
                case "hide":
                    _local2.visible = true;
                    _local2.bg.x = 181;
                    _local2.cnt.x = 181;
                    _local2.tTitle.x = 186;
                    _local2.bExpand.x = 120;
                    _local2.bg.visible = false;
                    _local2.cnt.visible = false;
                    _local2.tTitle.visible = false;
                    _local2.bExpand.visible = true;
            };
        }

        public function hideHouseOptions():void
        {
            var _local2:int;
            var _local1:MovieClip = this.rootClass.ui.mcPopup.mcHouseOptions;
            if (_local1.visible)
            {
                _local2 = 0;
                while (_local2 < _local1.numChildren)
                {
                    _local1.getChildAt(_local2).x = 190;
                    _local2++;
                };
            };
            _local1.visible = false;
        }

        public function showHouseInventory(_arg1:int):*
        {
            if (this.myAvatar.houseitems != null)
            {
                this.sendLoadShopRequest(_arg1);
            };
        }

        public function toggleHouseEdit():void
        {
            if (((this.isMyHouse()) && (!(this.myAvatar.houseitems == null))))
            {
                if (this.rootClass.ui.mcPopup.mcHouseMenu.visible)
                {
                    this.rootClass.ui.mcPopup.mcHouseMenu.hideEditMenu();
                }
                else
                {
                    this.rootClass.ui.mcPopup.mcHouseMenu.showEditMenu();
                };
            };
        }

        public function loadHouseInventory():*
        {
            this.rootClass.network.send("loadHouseInventory", []);
        }

        public function updateHouseItems():void
        {
            var _local1:int;
            var _local2:Object;
            if (this.objHouseData != null)
            {
                if (this.isMyHouse())
                {
                    this.initEquippedItems(this.objHouseData.arrPlacement);
                };
                _local1 = 0;
                while (_local1 < this.objHouseData.arrPlacement.length)
                {
                    if (this.strFrame == this.objHouseData.arrPlacement[_local1].c)
                    {
                        _local2 = this.getHouseItem(this.objHouseData.arrPlacement[_local1].ID);
                        if (_local2 != null)
                        {
                            this.loadHouseItem(_local2, this.objHouseData.arrPlacement[_local1].x, this.objHouseData.arrPlacement[_local1].y);
                        };
                    };
                    _local1++;
                };
            };
        }

        public function attachHouseItem(_arg1:Object):void
        {
            var _local2:Class = (LoadController.singleton.applicationDomainMap.getDefinition(_arg1.item.sLink) as Class);
            if (_local2 == null)
            {
                return;
            };
            var _local3:* = new (_local2)();
            _local3.x = _arg1.x;
            _local3.y = _arg1.y;
            _local3.ItemID = _arg1.item.ItemID;
            _local3.item = _arg1.item;
            _local3.isHouseItem = true;
            _local3.isStable = false;
            _local3.addEventListener(MouseEvent.MOUSE_DOWN, this.onHouseItemClick, false, 0, true);
            var _local4:MovieClip = (this.CHARS.addChild(_local3) as MovieClip);
            _local4.name = ("mc" + getQualifiedClassName(_local4));
            this.houseItemValidate(_local3);
        }

        public function houseItemValidate(_arg1:MovieClip):void
        {
            var _local3:int;
            var _local4:DisplayObject;
            var _local2:* = this.getHouseItem(_arg1.ItemID);
            if (_local2.sType == "Floor Item")
            {
                _arg1.isStable = false;
                _arg1.addEventListener(Event.ENTER_FRAME, this.onHouseItemEnterFrame);
            }
            else
            {
                if (_local2.sType == "Wall Item")
                {
                    _arg1.isStable = true;
                    _local3 = 0;
                    while (_local3 < this.map.numChildren)
                    {
                        _local4 = this.map.getChildAt(_local3);
                        if ((((_local4 is MovieClip) && (MovieClip(_local4).isFloor)) && (MovieClip(_local4).hitTestObject(_arg1))))
                        {
                            _arg1.isStable = false;
                            break;
                        };
                        _local3++;
                    };
                    if (!_arg1.isStable)
                    {
                        _arg1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 100, 0, 0, 0);
                    }
                    else
                    {
                        _arg1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
                    };
                };
            };
        }

        public function initHouseData(_arg1:Object):void
        {
            this.objHouseData = _arg1;
            if (this.objHouseData != null)
            {
                this.objHouseData.arrPlacement = this.createItemPlacementArray(this.objHouseData.sHouseInfo);
                this.verifyItemQty();
            };
        }

        public function verifyItemQty():void
        {
            var _local3:*;
            var _local4:*;
            var _local2:int;
            var _local5:*;
            var _local6:*;
            var _local7:*;
            var _local1:* = {};
            while (_local2 < this.objHouseData.arrPlacement.length)
            {
                _local3 = this.objHouseData.arrPlacement[_local2].ID;
                if (_local1[_local3] == null)
                {
                    _local1[_local3] = 1;
                }
                else
                {
                    _local5 = _local1;
                    _local6 = _local3;
                    _local7 = (_local5[_local6] + 1);
                    _local5[_local6] = _local7;
                };
                _local4 = this.getHouseItem(_local3);
                if (((_local4 == null) || (_local4.iQty < _local1[_local3])))
                {
                    this.objHouseData.sHouseInfo = "";
                    this.objHouseData.arrPlacement = [];
                };
                _local2++;
            };
        }

        public function getHouseItem(_arg1:int):Object
        {
            var _local2:int;
            var _local3:int;
            if (((!(this.myAvatar == null)) && (this.isMyHouse())))
            {
                _local2 = 0;
                while (_local2 < this.myAvatar.houseitems.length)
                {
                    if (this.myAvatar.houseitems[_local2].ItemID == _arg1)
                    {
                        return (this.myAvatar.houseitems[_local2]);
                    };
                    _local2++;
                };
            }
            else
            {
                _local3 = 0;
                while (_local3 < this.objHouseData.items.length)
                {
                    if (this.objHouseData.items[_local3].ItemID == _arg1)
                    {
                        return (this.objHouseData.items[_local3]);
                    };
                    _local3++;
                };
            };
            return (null);
        }

        public function removeSelectedItem():void
        {
            var _local1:MovieClip;
            if (this.objHouseData.selectedMC == null)
            {
                this.rootClass.MsgBox.notify("Please selected an item to be removed.");
            }
            else
            {
                _local1 = this.objHouseData.selectedMC;
                _local1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHouseItemClick);
                this.unequipHouseItem(_local1.ItemID);
                this.CHARS.removeChild(_local1);
                delete this.objHouseData.selectedMC;
            };
        }

        public function equipHouse(_arg1:Object):void
        {
            var _local2:* = new ModalMC();
            var _local3:* = {};
            _local3.strBody = (("Are you sure you want to equip '" + _arg1.sName) + "'? It will reset your house items?");
            _local3.params = {"item":_arg1};
            _local3.callback = this.equipHouseRequest;
            this.rootClass.ui.ModalStack.addChild(_local2);
            _local2.init(_local3);
        }

        public function equipHouseRequest(_arg1:*):void
        {
            if (_arg1.accept)
            {
                this.rootClass.world.sendEquipItemRequest(_arg1.item);
                this.rootClass.world.equipHouseByID(_arg1.item.ItemID);
            };
        }

        public function equipHouseByID(_arg1:int):void
        {
            var _local2:int;
            while (_local2 < this.myAvatar.houseitems.length)
            {
                this.myAvatar.houseitems[_local2].bEquip = (this.myAvatar.houseitems[_local2].ItemID == _arg1);
                _local2++;
            };
        }

        public function saveHouseSetup():void
        {
            var _local3:DisplayObject;
            var _local1:int;
            while (_local1 < this.objHouseData.arrPlacement.length)
            {
                if (this.strFrame == this.objHouseData.arrPlacement[_local1].c)
                {
                    this.objHouseData.arrPlacement.splice(_local1, 1);
                    _local1--;
                };
                _local1++;
            };
            _local1 = 0;
            while (_local1 < this.CHARS.numChildren)
            {
                _local3 = this.CHARS.getChildAt(_local1);
                if (((_local3.hasOwnProperty("isHouseItem")) && (MovieClip(_local3).isHouseItem)))
                {
                    if (MovieClip(_local3).isStable)
                    {
                        this.objHouseData.arrPlacement.push({
                            "c":this.strFrame,
                            "ID":MovieClip(_local3).ItemID,
                            "x":_local3.x,
                            "y":_local3.y
                        });
                    }
                    else
                    {
                        this.unequipHouseItem(MovieClip(_local3).ItemID);
                        _local3.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHouseItemClick);
                        this.CHARS.removeChild(_local3);
                    };
                };
                _local1++;
            };
            var _local2:String = this.createItemPlacementString(this.objHouseData.arrPlacement);
            if (this.objHouseData.sHouseInfo != _local2)
            {
                this.sendSaveHouseSetup(_local2);
                this.objHouseData.sHouseInfo = _local2;
            };
        }

        public function createItemPlacementString(_arg1:Array):String
        {
            var _local3:int;
            var _local4:*;
            var _local2:* = "";
            if (_arg1.length > 0)
            {
                _local3 = 0;
                while (_local3 < _arg1.length)
                {
                    for (_local4 in _arg1[_local3])
                    {
                        _local2 = ((((_local2 + _local4) + ":") + _arg1[_local3][_local4]) + ",");
                    };
                    _local2 = _local2.substring(0, (_local2.length - 1));
                    _local2 = (_local2 + "|");
                    _local3++;
                };
                _local2 = _local2.substring(0, (_local2.length - 1));
            };
            return (_local2);
        }

        public function createItemPlacementArray(_arg1:String):Array
        {
            var _local3:*;
            var _local4:int;
            var _local5:*;
            var _local6:*;
            var _local7:int;
            var _local2:Array = [];
            if (_arg1.length > 0)
            {
                _local3 = _arg1.split("|");
                _local4 = 0;
                while (_local4 < _local3.length)
                {
                    _local5 = {};
                    _local6 = _local3[_local4].split(",");
                    _local7 = 0;
                    while (_local7 < _local6.length)
                    {
                        _local5[_local6[_local7].split(":")[0]] = _local6[_local7].split(":")[1];
                        _local7++;
                    };
                    _local2.push(_local5);
                    _local4++;
                };
            };
            return (_local2);
        }

        public function sendSaveHouseSetup(_arg1:*):void
        {
            this.rootClass.network.send("housesave", [_arg1]);
        }

        public function initEquippedItems(_arg1:*):void
        {
            var _local3:int;
            var _local2:int;
            while (_local2 < this.myAvatar.houseitems.length)
            {
                if (this.myAvatar.houseitems[_local2].sType != "House")
                {
                    this.myAvatar.houseitems[_local2].bEquip = false;
                    _local3 = 0;
                    while (_local3 < _arg1.length)
                    {
                        if (this.myAvatar.houseitems[_local2].ItemID == _arg1[_local3].ID)
                        {
                            this.myAvatar.houseitems[_local2].bEquip = true;
                        };
                        _local3++;
                    };
                };
                _local2++;
            };
        }

        public function initHouseInventory(houseInfo:String, itemsArr:Array):void
        {
            var itemObj:Object;
            var houseItems:Vector.<Item> = new Vector.<Item>();
            this.initEquippedItems(this.createItemPlacementArray(houseInfo));
            for each (itemObj in itemsArr)
            {
                houseItems.push(new Item(itemObj));
                this.rootClass.world.invTree[itemObj.ItemID] = itemObj;
            };
            this.myAvatar.houseitems = houseItems;
        }

        public function unequipHouseItem(_arg1:int):void
        {
            var _local2:int;
            while (_local2 < this.myAvatar.houseitems.length)
            {
                if (this.myAvatar.houseitems[_local2].ItemID == _arg1)
                {
                    this.myAvatar.houseitems[_local2].bEquip = false;
                };
                _local2++;
            };
        }

        public function loadHouseItem(_arg1:Object, _arg2:int, _arg3:int):void
        {
            var item:Object;
            var x:int;
            var y:int;
            item = _arg1;
            x = _arg2;
            y = _arg3;
            try
            {
                this.attachHouseItem({
                    "item":item,
                    "x":x,
                    "y":y
                });
            }
            catch(e:Error)
            {
                arrHouseItemQueue.push({
                    "item":item,
                    "typ":"A",
                    "x":x,
                    "y":y
                });
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItem();
                };
                if (Config.isDebug)
                {
                    trace(("world 11 " + e));
                };
            };
        }

        public function loadNextHouseItem():void
        {
            LoadController.singleton.addLoadMap(this.arrHouseItemQueue[0].item.sFile, "house_item", this.onHouseItemComplete);
        }

        public function loadHouseItemB(_arg1:Object):void
        {
            var item:Object;
            item = _arg1;
            try
            {
                this.rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem({"item":item});
            }
            catch(e:Error)
            {
                rootClass.ui.mcPopup.mcHouseMenu.preview.t2.visible = true;
                rootClass.ui.mcPopup.mcHouseMenu.preview.cnt.visible = false;
                rootClass.ui.mcPopup.mcHouseMenu.preview.bAdd.visible = false;
                arrHouseItemQueue.push({
                    "item":item,
                    "typ":"B"
                });
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItemB();
                };
                if (Config.isDebug)
                {
                    trace(("world 12 " + e));
                };
            };
        }

        public function loadNextHouseItemB():void
        {
            var fileName:String;
            var item:Object = this.arrHouseItemQueue[0].item;
            var file:String = item.sFile;
            this.ldr_House = new URLLoader();
            this.ldr_House.dataFormat = URLLoaderDataFormat.BINARY;
            if (item.sType == "House")
            {
                fileName = (item.sFile.substr(0, -4) + "_preview.swf");
                file = ("maps/" + fileName);
            };
            LoadController.singleton.addLoadMap(file, "house_item", this.onHouseItemComplete);
        }

        public function playerInit():void
        {
            var _local4:String;
            var _local3:Array = this.rootClass.network.room.getUserList();
            var _local5:Array = [];
            for (_local4 in _local3)
            {
                if (_local3.hasOwnProperty(_local4))
                {
                    _local5.push(_local3[_local4].getId());
                };
            };
            if (_local5.length > 0)
            {
                this.objectByIDArray(_local5);
            };
            this.myAvatar = this.avatars[this.rootClass.network.myUserId];
            this.myAvatar.isMyAvatar = true;
            this.myAvatar.pMC.disablePNameMouse();
            this.rootClass.sfcSocial = true;
        }

        public function objectByIDArray(_arg1:Array):void
        {
            var _local2:int;
            var _local3:int;
            var _local4:*;
            var _local5:String;
            var _local6:Object;
            var _local7:String;
            var _local8:Array = [];
            _local2 = 0;
            while (_local2 < _arg1.length)
            {
                _local3 = _arg1[_local2];
                _local6 = this.getUoLeafById(_local3);
                if (_local6 != null)
                {
                    _local5 = _local6.uoName;
                    _local7 = String(_local6.strFrame);
                    if (_local3 == this.rootClass.network.myUserId)
                    {
                        _local7 = this.strFrame;
                    };
                    if (this.avatars[_local3] == null)
                    {
                        this.avatars[_local3] = new Avatar(this.rootClass);
                        this.avatars[_local3].uid = _local3;
                        this.avatars[_local3].pnm = _local5;
                    };
                    this.avatars[_local3].dataLeaf = _local6;
                    if (((this.avatars[_local3].pMC == null) && (_local7 == this.strFrame)))
                    {
                        this.avatars[_local3].pMC = this.createAvatarMC(_local3);
                        _local8.push(_local3);
                    };
                    this.updateUserDisplay(_local3);
                };
                _local2++;
            };
            if (_local8.length > 0)
            {
                this.getUserDataByIds(_local8);
            };
        }

        public function objectByID(userID:int):void
        {
            var uoLeaf:Object = this.getUoLeafById(userID);
            if (uoLeaf != null)
            {
                if (this.avatars[userID] == null)
                {
                    this.avatars[userID] = new Avatar(this.rootClass);
                    this.avatars[userID].uid = userID;
                    this.avatars[userID].pnm = uoLeaf.uoName;
                };
                this.avatars[userID].dataLeaf = uoLeaf;
                if (((this.avatars[userID].pMC == null) && (((userID == this.rootClass.network.myUserId) ? this.strFrame : String(uoLeaf.strFrame)) == this.strFrame)))
                {
                    this.avatars[userID].pMC = this.createAvatarMC(userID);
                    this.getUserDataById(userID);
                };
                this.updateUserDisplay(userID);
            };
        }

        public function createAvatarMC(userID:int):AvatarMC
        {
            var avatar:AvatarMC = new AvatarMC();
            avatar.name = ("a" + userID);
            avatar.x = -600;
            avatar.y = 0;
            avatar.pAV = this.avatars[userID];
            avatar.world = this;
            return (avatar);
        }

        public function destroyAvatar(userID:int):void
        {
            var avatar:Avatar = this.avatars[userID];
            if (avatar != null)
            {
                if (((!(avatar.pMC == null)) && (!(avatar.isMyAvatar))))
                {
                    avatar.pMC.fClose();
                    delete this.avatars[userID];
                };
            };
        }

        public function updateUserDisplay(userID:int):void
        {
            var _local5:*;
            var mapPad:*;
            var point:Point;
            var pointSolve:Point;
            var uoLeaf:* = this.getUoLeafById(userID);
            var pMC:MovieClip = this.getMCByUserID(userID);
            if (String(uoLeaf.strFrame) == this.strFrame)
            {
                pMC.tx = int(uoLeaf.tx);
                pMC.ty = int(uoLeaf.ty);
                _local5 = int(uoLeaf.intState);
                mapPad = null;
                if (((("strPad" in uoLeaf) && (!(uoLeaf.strPad.toLowerCase() == "none"))) && (uoLeaf.strPad in this.map)))
                {
                    mapPad = this.map[uoLeaf.strPad];
                };
                if (((!(pMC.tx == 0)) || (!(pMC.ty == 0))))
                {
                    point = new Point(pMC.tx, pMC.ty);
                    if (!this.testTxTy(point, pMC))
                    {
                        pointSolve = this.solveTxTy(point, pMC);
                        if (pointSolve != null)
                        {
                            pMC.x = pointSolve.x;
                            pMC.y = pointSolve.y;
                        }
                        else
                        {
                            pMC.x = int((960 >> 1));
                            pMC.y = int((550 >> 1));
                        };
                    }
                    else
                    {
                        pMC.x = pMC.tx;
                        pMC.y = pMC.ty;
                    };
                }
                else
                {
                    if (mapPad != null)
                    {
                        pMC.x = int(((mapPad.x + int((Math.random() * 10))) - 5));
                        pMC.y = int(((mapPad.y + int((Math.random() * 10))) - 5));
                    }
                    else
                    {
                        if (uoLeaf.strPad == "Spectator")
                        {
                            pMC.x = 0;
                            pMC.y = -99999;
                            pMC.pAV.hideMC();
                        }
                        else
                        {
                            pMC.x = int((960 >> 1));
                            pMC.y = int((550 >> 1));
                        };
                    };
                };
                pMC.scale(this.SCALE);
                pMC.mcChar.gotoAndStop(((_local5) ? "Idle" : "Dead"));
                if (this.showHPBar)
                {
                    pMC.showHPBar();
                }
                else
                {
                    pMC.hideHPBar();
                };
                if (userID == this.rootClass.network.myUserId)
                {
                    this.bitWalk = true;
                };
                if ((((userID == this.rootClass.network.myUserId) || ((this.CELL_MODE == "normal") && (!(this.hideAvatars)))) || ((userID == this.rootClass.network.myUserId) && (!(uoLeaf.strPad == "Spectator")))))
                {
                    pMC.pAV.showMC();
                }
                else
                {
                    pMC.pAV.hideMC();
                };
                if ((((this.bPvP) && (!(uoLeaf.pvpTeam == null))) && (uoLeaf.pvpTeam > -1)))
                {
                    pMC.mcChar.pvpFlag.visible = true;
                    pMC.mcChar.pvpFlag.gotoAndStop(["a", "b", "c"][uoLeaf.pvpTeam]);
                }
                else
                {
                    pMC.mcChar.pvpFlag.visible = false;
                };
                pMC.gotoAndPlay(((pMC.isLoaded) ? "in2" : "hold"));
            };
        }

        public function updatePortrait(_arg1:Avatar):void
        {
            var _local2:Array;
            var avatar:*;
            var portrait:AbstractPortrait;
            var i:int;
            var intHP:Number;
            var intHPMax:Number;
            var hpDisplay:String;
            var intMP:Number;
            var intMPMax:Number;
            var mpDisplay:String;
            var calculation:*;
            if (this.myAvatar == null)
            {
                return;
            };
            if (_arg1 != this.myAvatar)
            {
                _local2 = [this.rootClass.ui.mcPortraitTarget];
            }
            else
            {
                _local2 = ((_arg1 == this.myAvatar.target) ? ([this.rootClass.ui.mcPortraitTarget, this.rootClass.ui.mcPortrait]) : ([this.rootClass.ui.mcPortrait]));
            };
            var _local4:int;
            while (_local4 < _local2.length)
            {
                avatar = {};
                portrait = _local2[_local4];
                portrait.strName.mouseEnabled = false;
                portrait.strClass.mouseEnabled = false;
                switch (_arg1.npcType)
                {
                    case "monster":
                        avatar = this.monTree[_arg1.objData.MonMapID];
                        portrait.strName.text = _arg1.objData.strMonName.toUpperCase();
                        portrait.strClass.text = "Monster";
                        if (portrait.stars != null)
                        {
                            calculation = Math.round((Math.pow((_arg1.objData.intLevel * 1.3), 0.5) / 2));
                            i = 1;
                            while (i <= 5)
                            {
                                portrait.stars.getChildByName(("s" + i)).visible = (i <= calculation);
                                i++;
                            };
                        };
                        break;
                    case "player":
                        avatar = this.uoTree[_arg1.pnm];
                        if (_arg1.constructor.toString().indexOf("objData") != -1)
                        {
                            return;
                        };
                        portrait.strName.text = _arg1.objData.strUsername.toUpperCase();
                        portrait.strClass.htmlText = ((_arg1.objData.strClassName + ", Rank ") + _arg1.objData.iRank);
                        if (portrait.stars != null)
                        {
                            i = 1;
                            while (i <= 5)
                            {
                                portrait.stars.getChildByName(("s" + i)).visible = false;
                                i++;
                            };
                        };
                        break;
                    case "npc":
                        avatar = this.npcTree[_arg1.objData.NpcMapID];
                        if (_arg1.constructor.toString().indexOf("objData") != -1)
                        {
                            return;
                        };
                        portrait.strName.text = _arg1.objData.strUsername.toUpperCase();
                        portrait.strClass.htmlText = _arg1.objData.strClassName;
                        if (portrait.stars != null)
                        {
                            i = 1;
                            while (i <= 5)
                            {
                                portrait.stars.getChildByName(("s" + i)).visible = false;
                                i++;
                            };
                        };
                        break;
                };
                portrait.strLevel.text = _arg1.objData.intLevel;
                intHP = avatar.intHP;
                intHPMax = avatar.intHPMax;
                hpDisplay = avatar.intHP;
                if (Game.root.userPreference.data.combatShowCommaHPDisplay)
                {
                    hpDisplay = MainController.formatNumber(avatar.intHP);
                };
                portrait.HP.strIntHP.text = ((avatar.intHP >= 0) ? hpDisplay : "X");
                if (intHP < 0)
                {
                    intHP = 0;
                };
                if (intHP > intHPMax)
                {
                    intHP = intHPMax;
                };
                portrait.HP.intHPbar.width = (portrait.HP.mcWidth.width * (intHP / intHPMax));
                intMP = avatar.intMP;
                intMPMax = avatar.intMPMax;
                mpDisplay = avatar.intMP;
                if (Game.root.userPreference.data.combatShowCommaMPDisplay)
                {
                    mpDisplay = MainController.formatNumber(avatar.intMP);
                };
                portrait.MP.strIntMP.text = ((avatar.intMP >= 0) ? mpDisplay : "X");
                if (intMP < 0)
                {
                    intMP = 0;
                };
                if (intMP > intMPMax)
                {
                    intMP = intMPMax;
                };
                portrait.MP.intMPbar.width = (portrait.MP.mcWidth.width * (intMP / intMPMax));
                _local4++;
            };
        }

        public function sendChangeGuildSettingsRequest(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["gcc", _arg1]);
        }

        public function getAvatarByUserID(_arg1:int):Avatar
        {
            var _local2:String = String(_arg1);
            if ((_local2 in this.avatars))
            {
                return (this.avatars[_local2]);
            };
            return (null);
        }

        public function getAvatarByUserName(username:String):Avatar
        {
            var avatarsKey:String;
            var avatar:Avatar;
            for (avatarsKey in this.avatars)
            {
                avatar = this.avatars[avatarsKey];
                if ((((!(avatar == null)) && (!(avatar.pnm == null))) && (avatar.pnm.toLowerCase() == username.toLowerCase())))
                {
                    return (this.avatars[avatarsKey]);
                };
            };
            return (null);
        }

        public function getMCByUserName(username:String):AvatarMC
        {
            var _local2:String;
            for (_local2 in this.avatars)
            {
                if ((((!(this.avatars[_local2] == null)) && (!(this.avatars[_local2].pnm == null))) && (this.avatars[_local2].pnm.toLowerCase() == username.toLowerCase())))
                {
                    if (this.avatars[_local2].pMC != null)
                    {
                        return (this.avatars[_local2].pMC);
                    };
                };
            };
            return (null);
        }

        public function getMCByUserID(userId:int):AvatarMC
        {
            return (((!(this.avatars[userId] == undefined)) && (!(this.avatars[userId].pMC == null))) ? this.avatars[userId].pMC : null);
        }

        public function getUoLeafById(_arg1:*):Object
        {
            var _local2:Object;
            for each (_local2 in this.uoTree)
            {
                if (_local2.entID == _arg1)
                {
                    return (_local2);
                };
            };
            return (null);
        }

        public function getUoLeafByName(_arg1:String):Object
        {
            var _local2:Object;
            _arg1 = _arg1.toLowerCase();
            for each (_local2 in this.uoTree)
            {
                if (_local2.uoName == _arg1)
                {
                    return (_local2);
                };
            };
            return (null);
        }

        public function getUserDataById(_arg1:*):void
        {
            this.rootClass.network.send("retrieveUserData", [_arg1]);
        }

        public function getUserDataByIds(_arg1:Array):void
        {
            this.rootClass.network.send("retrieveUserDatas", _arg1);
        }

        public function getUsersByCell(_arg1:String):Array
        {
            var _local3:String;
            var _local2:Array = [];
            for (_local3 in this.avatars)
            {
                if (this.avatars[_local3].dataLeaf.strFrame == _arg1)
                {
                    _local2.push(this.avatars[_local3]);
                };
            };
            return (_local2);
        }

        public function getAllAvatarsInCell():Array
        {
            return (this.getMonstersByCell(this.myAvatar.dataLeaf.strFrame).concat(this.getUsersByCell(this.myAvatar.dataLeaf.strFrame)));
        }

        public function getUsersByCell2(frame:String):Vector.<Avatar>
        {
            var key:String;
            var avatars:Vector.<Avatar> = new Vector.<Avatar>();
            for (key in this.avatars)
            {
                if (this.avatars[key].dataLeaf.strFrame == frame)
                {
                    avatars.push(Avatar(this.avatars[key]));
                };
            };
            return (avatars);
        }

        public function getNpcAvatarByUserName(username:String):Avatar
        {
            var _local2:String;
            for (_local2 in this.npcs)
            {
                if (this.npcs[_local2].objData.strUsername.toLowerCase() == username.toLowerCase())
                {
                    if (this.npcs[_local2].pMC != null)
                    {
                        return (this.npcs[_local2]);
                    };
                };
            };
            return (null);
        }

        public function getNPCMCByUserName(username:String):AvatarMC
        {
            var _local2:String;
            for (_local2 in this.npcs)
            {
                if (this.npcs[_local2].objData.strUsername.toLowerCase() == username.toLowerCase())
                {
                    if (this.npcs[_local2].pMC != null)
                    {
                        return (this.npcs[_local2].pMC);
                    };
                };
            };
            return (null);
        }

        public function getMonstersByCell2(frame:String):Vector.<Avatar>
        {
            var key:String;
            var avatars:Vector.<Avatar> = new Vector.<Avatar>();
            for (key in this.monsters)
            {
                if (this.monsters[key].dataLeaf.strFrame == frame)
                {
                    avatars.push(Avatar(this.monsters[key]));
                };
            };
            return (avatars);
        }

        public function getNpcsByCell2(frame:String):Vector.<Avatar>
        {
            var key:String;
            var avatars:Vector.<Avatar> = new Vector.<Avatar>();
            for (key in this.npcs)
            {
                if (this.npcs[key].dataLeaf.strFrame == frame)
                {
                    avatars.push(Avatar(this.npcs[key]));
                };
            };
            return (avatars);
        }

        public function getAllAvatarsInCell2():Vector.<Avatar>
        {
            return (this.getMonstersByCell2(this.myAvatar.dataLeaf.strFrame).concat(this.getUsersByCell2(this.myAvatar.dataLeaf.strFrame)));
        }

        public function getQuestValue(slot:Number):Number
        {
            var questIndex:int;
            if (((this.myAvatar == null) || (this.myAvatar.objData == null)))
            {
                return (-1);
            };
            questIndex = int(Math.floor((slot / 100)));
            var questDataName:String = ((questIndex > 0) ? ("strQuests" + (questIndex + 1)) : "strQuests");
            return ((questDataName in this.myAvatar.objData) ? MainController.lookAtValue(this.myAvatar.objData[questDataName], (slot - (questIndex * 100))) : -1);
        }

        public function setQuestValue(slot:Number, value:Number):void
        {
            var questIndex:int;
            questIndex = int(Math.floor((slot / 100)));
            var questDataName:String = ((questIndex > 0) ? ("strQuests" + (questIndex + 1)) : "strQuests");
            if ((questDataName in this.myAvatar.objData))
            {
                this.myAvatar.objData[questDataName] = MainController.updateValue(this.myAvatar.objData[questDataName], (slot - (questIndex * 100)), value);
            };
        }

        public function sendUpdateQuestRequest(_arg1:Number, _arg2:Number):void
        {
            this.rootClass.network.send("updateQuest", [_arg1, _arg2]);
        }

        public function setHomeTownCurrent():void
        {
            this.rootClass.network.send("setHomeTown", []);
            this.myAvatar.objData.strHomeTown = this.myAvatar.objData.strMapName;
        }

        public function setHomeTown(_arg1:String):void
        {
            this.rootClass.network.send("setHomeTown", [_arg1]);
            this.myAvatar.objData.strHomeTown = _arg1;
        }

        public function sendBankFromInvRequest(_arg1:Object):*
        {
            var _local2:ModalMC;
            var _local3:Object;
            if (_arg1.bEquip == 1)
            {
                _local2 = new ModalMC();
                _local3 = {};
                _local3.strBody = "You must unequip the item before storing it in the bank!";
                _local3.params = {};
                _local3.glow = "red,medium";
                _local3.btns = "mono";
                this.rootClass.ui.ModalStack.addChild(_local2);
                _local2.init(_local3);
            }
            else
            {
                if (((_arg1.bCoins == 0) && (this.bankController.iBankCount >= this.myAvatar.objData.iBankSlots)))
                {
                    _local2 = new ModalMC();
                    _local3 = {};
                    _local3.strBody = "You have exceeded your maximum bank storage for non-AC items!";
                    _local3.params = {};
                    _local3.glow = "red,medium";
                    _local3.btns = "mono";
                    this.rootClass.ui.ModalStack.addChild(_local2);
                    _local2.init(_local3);
                }
                else
                {
                    this.rootClass.network.send("bankFromInv", [_arg1.ItemID, _arg1.CharItemID]);
                };
            };
        }

        public function sendBankToInvRequest(_arg1:Object):*
        {
            var _local2:*;
            var _local3:*;
            if (this.myAvatar.items.length >= this.myAvatar.objData.iBagSlots)
            {
                _local2 = new ModalMC();
                _local3 = {};
                _local3.strBody = "You have exceeded your maximum inventory storage!";
                _local3.params = {};
                _local3.glow = "red,medium";
                _local3.btns = "mono";
                this.rootClass.ui.ModalStack.addChild(_local2);
                _local2.init(_local3);
            }
            else
            {
                this.rootClass.network.send("bankToInv", [_arg1.ItemID, _arg1.CharItemID]);
            };
        }

        public function sendBankSwapInvRequest(_arg1:Object, _arg2:Object):*
        {
            var _local3:ModalMC;
            var _local4:Object;
            if (_arg2.bEquip == 1)
            {
                _local3 = new ModalMC();
                _local4 = {};
                _local4.strBody = "You must unequip the item before storing it in the bank!";
                _local4.params = {};
                _local4.glow = "red,medium";
                _local4.btns = "mono";
                this.rootClass.ui.ModalStack.addChild(_local3);
                _local3.init(_local4);
            }
            else
            {
                if ((((_arg2.bCoins == 0) && (_arg1.bCoins == 1)) && (this.bankController.iBankCount >= this.myAvatar.objData.iBankSlots)))
                {
                    _local3 = new ModalMC();
                    _local4 = {};
                    _local4.strBody = "You have exceeded your maximum bank storage for non-AC items!";
                    _local4.params = {};
                    _local4.glow = "red,medium";
                    _local4.btns = "mono";
                    this.rootClass.ui.ModalStack.addChild(_local3);
                    _local3.init(_local4);
                }
                else
                {
                    this.rootClass.network.send("bankSwapInv", [_arg2.ItemID, _arg2.CharItemID, _arg1.ItemID, _arg1.CharItemID]);
                };
            };
        }

        public function getInventory(_arg1:*):*
        {
            this.rootClass.network.send("retrieveInventory", [_arg1]);
        }

        public function sendChangeColorRequest(_arg1:int, _arg2:int, _arg3:int, _arg4:int):void
        {
            this.rootClass.network.send("changeColor", [_arg1, _arg2, _arg3, _arg4, this.hairshopinfo.HairShopID]);
        }

        public function sendChangeArmorColorRequest(_arg1:int, _arg2:int, _arg3:int):void
        {
            this.rootClass.network.send("changeArmorColor", [_arg1, _arg2, _arg3]);
        }

        public function sendLoadBankRequest(_arg_1:Array=null):void
        {
            var _local_2:String;
            for each (_local_2 in _arg_1)
            {
                this.bankinfo.hasRequested[_local_2] = true;
            };
            this.rootClass.network.send("loadBank", _arg_1);
        }

        public function sendReloadShopRequest(shopId:int):void
        {
            if ((((!(this.shopinfo == null)) && (this.shopinfo.ShopID == shopId)) && (this.shopinfo.bLimited)))
            {
                this.rootClass.network.send("reloadShop", [shopId]);
            };
        }

        public function sendLoadShopRequest(shopId:int):void
        {
            if (this.coolDown("loadShop"))
            {
                this.rootClass.network.send("loadShop", [shopId]);
            };
        }

        public function sendLoadHairShopRequest(_arg1:int):void
        {
            if (((this.hairshopinfo == null) || (!(this.hairshopinfo.HairShopID == _arg1))))
            {
                this.rootClass.network.send("loadHairShop", [_arg1]);
            }
            else
            {
                this.rootClass.openCharacterCustomize();
            };
        }

        public function sendLoadEnhShopRequest(_arg1:int):void
        {
            var _local2:ModalMC = new ModalMC();
            var _local3:Object = {};
            _local3.strBody = "Old enhancement shops are disabled on the PTR.  Please visit Battleon for the new shops.";
            _local3.params = {};
            _local3.btns = "mono";
            this.rootClass.ui.ModalStack.addChild(_local2);
            _local2.init(_local3);
        }

        public function sendEnhItemRequest(_arg1:Object):void
        {
            this.enhItem = _arg1;
            this.rootClass.network.send("enhanceItem", [_arg1.ItemID, _arg1.EnhID, this.enhShopID]);
        }

        public function sendEnhItemRequestShop(_arg1:Object, _arg2:Object):void
        {
            if (this.coolDown("buyItem"))
            {
                this.enhItem = _arg1;
                this.rootClass.network.send("enhanceItemShop", [_arg1.ItemID, _arg2.ItemID, this.shopinfo.ShopID]);
            };
        }

        public function sendEnhItemRequestLocal(_arg1:Object, _arg2:Object):void
        {
            if (this.coolDown("buyItem"))
            {
                this.enhItem = _arg1;
                this.rootClass.network.send("enhanceItemLocal", [_arg1.ItemID, _arg2.ItemID]);
            };
        }

        public function buyItemCheck(item:Item):Boolean
        {
            if (this.coolDown("buyItem"))
            {
                switch (true)
                {
                    case ((item.bStaff == 1) && (this.myAvatar.objData.intAccessLevel < 40)):
                        this.rootClass.MsgBox.notify("Staff Item: Cannot be purchased yet!");
                        break;
                    case (((!(this.shopinfo == null)) && (!(this.shopinfo.sField == ""))) && (!(Achievement.getAchievement(this.shopinfo.sField, this.shopinfo.iIndex) == 1))):
                        this.rootClass.MsgBox.notify("Item Locked: Special requirement not met.");
                        break;
                    case ((item.bUpg == 1) && (!(this.myAvatar.isUpgraded()))):
                        this.rootClass.showUpgradeWindow();
                        break;
                    case ((item.FactionID > 1) && (this.myAvatar.getRep(item.FactionID) < item.iReqRep)):
                        this.rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
                        break;
                    case (!(this.rootClass.validateArmor(item))):
                        this.rootClass.MsgBox.notify("Item Locked: Class Requirement not met.");
                        break;
                    case ((item.iQSindex >= 0) && (this.getQuestValue(item.iQSindex) < int(item.iQSvalue))):
                        this.rootClass.MsgBox.notify("Item Locked: Quest Requirement not met.");
                        break;
                    case (((this.myAvatar.isItemInInventory(item.ItemID)) || (this.myAvatar.isItemInBank(item.ItemID))) && (this.myAvatar.isItemStackMaxed(item.ItemID))):
                        this.rootClass.MsgBox.notify((("You cannot have more than " + item.iStk) + " of that item!"));
                        break;
                    case (item.iCost > this.myAvatar.objData.intCoins):
                        this.rootClass.MsgBox.notify("Insufficient Funds!");
                        break;
                    case (((!(this.rootClass.isHouseItem(item))) && (this.myAvatar.items.length >= this.myAvatar.objData.iBagSlots)) || ((this.rootClass.isHouseItem(item)) && (this.myAvatar.houseitems.length >= this.myAvatar.objData.iHouseSlots))):
                        this.rootClass.MsgBox.notify("Inventory Full!");
                        break;
                    case ((item.iReqGuildLevel > 0) && ((this.myAvatar.objData.guild == null) || (item.iReqGuildLevel > this.myAvatar.objData.guild.Level))):
                        this.rootClass.MsgBox.notify("Item Locked: Guild Level not met.");
                        break;
                    default:
                        return (true);
                };
            };
            return (false);
        }

        public function sendBuyItemRequest(item:Item):void
        {
            var inventoryItem:Item;
            var quantityAvailable:int;
            var q:int;
            var i:int;
            if (this.buyItemCheck(item))
            {
                if (((this.shopBuyItem == null) || (!(this.shopBuyItem.ShopItemID == item.ShopItemID))))
                {
                    this.shopBuyItem = item;
                };
                if ((((item.iStk > 1) && (!(item.sES == "ar"))) && (!(this.shopinfo.bLimited))))
                {
                    inventoryItem = this.myAvatar.getItemByID(item.ItemID);
                    quantityAvailable = item.iStk;
                    if (inventoryItem != null)
                    {
                        q = 0;
                        i = 1;
                        while (i < 1000)
                        {
                            q = ((item.iQty * i) + inventoryItem.iQty);
                            if (q <= item.iStk)
                            {
                                quantityAvailable = i;
                            };
                            i++;
                        };
                    };
                    MainController.modal((("Number of quantity of '" + item.sName) + "' to buy:"), this.sendBuyItemRequestRequest4, {"iBuy":item}, "white,medium", "dual", true, {
                        "min":1,
                        "max":quantityAvailable
                    });
                }
                else
                {
                    this.sendBuyItemRequestRequest3(item.iQty);
                };
            };
        }

        public function sendBuyItemRequestRequest4(params:Object):void
        {
            var multiple:int;
            if (params.accept)
            {
                multiple = 1;
                if (params.iQty != null)
                {
                    multiple = params.iQty;
                };
                this.sendBuyItemRequestRequest3(multiple);
            };
        }

        public function sendBuyItemRequestRequest3(quantity:int):void
        {
            this.rootClass.network.send("buyItem", [this.shopBuyItem.ItemID, this.shopinfo.ShopID, this.shopBuyItem.ShopItemID, quantity]);
        }

        public function sendBuyAuctionItemRequest(item:Item):void
        {
            if (this.buyItemCheck(item))
            {
                this.rootClass.network.send("buyAuctionItem", [item.AuctionID, this.rootClass.vendingOwner]);
            };
        }

        public function sendSellItemRequest(data:Object, quantity:int=1):void
        {
            if (this.coolDown("sellItem"))
            {
                this.rootClass.network.send("sellItem", [data.ItemID, quantity, data.CharItemID]);
            };
        }

        public function sendRemoveItemRequest(item:Item, quantity:int=1):void
        {
            this.rootClass.network.send("removeItem", [item.ItemID, item.CharItemID, quantity]);
        }

        public function sendRemoveTempItemRequest(item:Item, quantity:int=1):void
        {
            this.rootClass.network.send("removeTempItem", [item.ItemID, quantity]);
        }

        public function sendEquipItemRequest(item:Item):Boolean
        {
            var b:Boolean = true;
            if (((!(item == null)) && (!(this.myAvatar.isItemEquipped(item.ItemID)))))
            {
                if (this.coolDown("equipItem"))
                {
                    this.rootClass.network.send("equipItem", [item.ItemID]);
                }
                else
                {
                    b = false;
                };
            }
            else
            {
                b = false;
            };
            return (b);
        }

        public function sendForceEquipRequest(_arg1:int):void
        {
            this.rootClass.network.send("forceEquipItem", [_arg1]);
        }

        public function sendUnequipItemRequest(_arg1:Object):void
        {
            if (((!(_arg1 == null)) && (this.myAvatar.isItemEquipped(_arg1.ItemID))))
            {
                if (this.coolDown("unequipItem"))
                {
                    this.rootClass.network.send("unequipItem", [_arg1.ItemID]);
                };
            };
        }

        public function sendChangeClassRequest(_arg1:int):void
        {
            this.rootClass.network.send("changeClass", [_arg1]);
        }

        public function selfMute(_arg1:int=1):void
        {
            this.rootClass.network.send("cmd", ["mute", _arg1, this.myAvatar.objData.strUsername.toLowerCase()]);
        }

        public function equipUseableItem(itemToUse:Item):void
        {
            var skill:Skill;
            var action:Skill;
            var item:Object;
            for each (action in this.actions.active)
            {
                if (action.ref == "i1")
                {
                    skill = action;
                    skill.icon = itemToUse.sFile;
                };
            };
            skill.sArg1 = String(itemToUse.ItemID);
            skill.sArg2 = itemToUse.sDesc;
            this.rootClass.updateIcons(this.getActIcons(skill), [itemToUse.sFile], itemToUse);
            this.rootClass.updateActionObjIcon(skill);
            for each (item in this.myAvatar.items)
            {
                if (((item.sType.toLowerCase() == "item") && (!(item.sLink.toLowerCase() == "none"))))
                {
                    if (item.ItemID == itemToUse.ItemID)
                    {
                        item.bEquip = true;
                        this.rootClass.network.send("geia", [item.ItemID]);
                    }
                    else
                    {
                        item.bEquip = false;
                    };
                };
            };
            if (LPFLayoutInvShopEnh(mcPopup_323(this.rootClass.ui.mcPopup).getChildByName("mcInventory")) != null)
            {
                LPFLayoutInvShopEnh(mcPopup_323(this.rootClass.ui.mcPopup).getChildByName("mcInventory")).update({"eventType":"refreshItems"});
            };
        }

        public function unequipUseableItem(item:Item=null):void
        {
            var skill:Skill;
            var item2:Item;
            var i:int;
            while (i < this.actions.active.length)
            {
                if (this.actions.active[i].ref == "i1")
                {
                    skill = this.actions.active[i];
                    skill.icon = "icu1";
                };
                i++;
            };
            skill.sArg1 = "";
            skill.sArg2 = "";
            this.rootClass.updateIcons(this.getActIcons(skill), ["icu1"], null);
            if (item == null)
            {
                i = 0;
                while (i < this.myAvatar.items.length)
                {
                    item2 = this.myAvatar.items[i];
                    if (String(item2.ItemID) == skill.sArg1)
                    {
                        item = item2;
                    };
                    i++;
                };
            };
            item.bEquip = false;
            if (this.rootClass.ui.mcPopup.mcInventory != null)
            {
                this.rootClass.ui.mcPopup.mcInventory.mcItemList.refreshList();
                this.rootClass.ui.mcPopup.mcInventory.refreshDetail();
            };
        }

        public function sendUseItemRequest(item:Object, quantity:uint=1):void
        {
            if (this.coolDown("serverUseItem"))
            {
                this.rootClass.network.send("serverUseItem", ["+", item.ItemID, quantity]);
            };
        }

        public function bankHasRequested(_arg1:Array):Boolean
        {
            var _local2:String;
            for each (_local2 in _arg1)
            {
                if (!(_local2 in this.bankinfo.hasRequested))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function addItemsToBank(items:Vector.<Item>):void
        {
            var item:Item;
            var itemAlreadyInBank:Boolean;
            var item2:Item;
            for each (item in items)
            {
                itemAlreadyInBank = true;
                for each (item2 in this.bankinfo.items)
                {
                    if (item2.ItemID == item.ItemID)
                    {
                        item2.CharItemID = item.CharItemID;
                        item2.iQty = (item2.iQty + item.iQty);
                        itemAlreadyInBank = false;
                        break;
                    };
                };
                if (itemAlreadyInBank)
                {
                    this.bankinfo.items.push(item);
                };
            };
        }

        public function toggleBank():void
        {
            if (this.rootClass.ui.mcPopup.currentLabel == "Bank")
            {
                MovieClip(this.rootClass.ui.mcPopup.getChildByName("mcBank")).fClose();
            }
            else
            {
                this.rootClass.ui.mcPopup.fOpen("Bank");
            };
        }

        public function sendReport(_arg1:Array):void
        {
            this.rootClass.network.send("cmd", _arg1);
        }

        public function sendWhoRequest(event:MouseEvent=null):void
        {
            if (this.coolDown("who"))
            {
                this.rootClass.network.send("cmd", ["who"]);
            };
        }

        public function sendRewardReferralRequest(_arg1:*):void
        {
            this.rootClass.network.send("rewardReferral", []);
        }

        public function sendGetAdDataRequest():void
        {
            if (this.rootClass.world.myAvatar == null)
            {
                this.rootClass.chatF.pushMsg("warning", "Rejoin the map to reload the ad's data.", "SERVER", "", 0);
            };
            if (this.rootClass.world.myAvatar.objData.iDailyAds < this.rootClass.world.myAvatar.objData.iDailyAdCap)
            {
                this.rootClass.network.send("getAdData", []);
            };
        }

        public function sendGetAdRewardRequest():void
        {
            if (this.rootClass.world.myAvatar.objData.iDailyAds < this.rootClass.world.myAvatar.objData.iDailyAdCap)
            {
                this.rootClass.network.send("getAdReward", []);
            };
        }

        public function sendWarVarsRequest():void
        {
            this.rootClass.network.send("loadWarVars", []);
        }

        public function loadQuestStringData():void
        {
            this.rootClass.network.send("loadQuestStringData", []);
        }

        public function buyBagSlots(_arg1:int):void
        {
            this.rootClass.network.send("buyBagSlots", [_arg1]);
        }

        public function buyBankSlots(_arg1:int):void
        {
            this.rootClass.network.send("buyBankSlots", [_arg1]);
        }

        public function buyHouseSlots(_arg1:int):void
        {
            this.rootClass.network.send("buyHouseSlots", [_arg1]);
        }

        public function buyAuctionSlots(_arg1:int):void
        {
            this.rootClass.network.send("buyAuctionSlots", [_arg1]);
        }

        public function buyVendingSlots(_arg1:int):void
        {
            this.rootClass.network.send("buyVendingSlots", [_arg1]);
        }

        public function sendLoadFriendsListRequest():*
        {
            this.rootClass.network.send("loadFriendsList", []);
        }

        public function sendLoadFactionRequest():*
        {
            this.rootClass.network.send("loadFactions", []);
        }

        public function initAchievements():void
        {
            var _local2:* = this.myAvatar.objData;
            var _local_2:* = _local2;
            with (_local_2)
            {
                ip0 = uint(ip0);
                ia0 = uint(ia0);
                ia1 = uint(ia1);
                id0 = uint(id0);
                id1 = uint(id1);
                id2 = uint(id2);
                im0 = uint(im0);
                iq0 = uint(iq0);
            };
        }

        public function getAchievement(value:String, index:int):int
        {
            return (Achievement.getAchievement(value, index));
        }

        public function setAchievement(_arg1:String, _arg2:int, _arg3:int=1):void
        {
            var _local4:* = ["ia0", "iq0"];
            if (((((_local4.indexOf(_arg1) >= 0) && (_arg2 >= 0)) && (_arg2 < 32)) && (!(Achievement.getAchievement(_arg1, _arg2) == _arg3))))
            {
                this.rootClass.network.send("setAchievement", [_arg1, _arg2, _arg3]);
            };
        }

        public function updateAchievement(_arg1:String, _arg2:int, _arg3:int):void
        {
            if (_arg3 == 0)
            {
                this.myAvatar.objData[_arg1] = (this.myAvatar.objData[_arg1] & (~(Math.pow(2, _arg2))));
            }
            else
            {
                if (_arg3 == 1)
                {
                    this.myAvatar.objData[_arg1] = (this.myAvatar.objData[_arg1] | Math.pow(2, _arg2));
                };
            };
            this.rootClass.readIA1Preferences();
        }

        public function showFriendsList():void
        {
            var _local1:*;
            if (((!(this.myAvatar.friends == null)) && (this.myAvatar.friendsLoaded)))
            {
                _local1 = {};
                _local1.typ = "userListFriends";
                _local1.ul = this.myAvatar.friends;
                this.rootClass.ui.mcOFrame.fOpenWith(_local1);
            }
            else
            {
                this.myAvatar.friendsLoaded = true;
                this.rootClass.network.send("getfriendlist", []);
            };
        }

        public function showIgnoreList():void
        {
            var _local1:Object;
            if (((!(this.rootClass.chatF.ignoreList.data.users == null)) && (this.rootClass.chatF.ignoreList.data.users.length > 0)))
            {
                _local1 = {};
                _local1.typ = "userListIgnore";
                this.rootClass.ui.mcOFrame.fOpenWith(_local1);
            }
            else
            {
                this.rootClass.chatF.pushMsg("warning", "Your ignore list is empty.", "SERVER", "", 0);
            };
        }

        public function isModerator(_arg1:String):void
        {
            this.rootClass.network.send("isModerator", [_arg1]);
        }

        public function toggleName(_arg1:*, _arg2:String):*
        {
            if (_arg2 == "on")
            {
                this.getMCByUserID(_arg1).pname.visible = true;
            };
            if (_arg2 == "off")
            {
                this.getMCByUserID(_arg1).pname.visible = false;
            };
        }

        public function toggleHPBar():void
        {
            var _local1:String;
            var _local2:MovieClip;
            var _local3:Avatar;
            this.showHPBar = (!(this.showHPBar));
            for (_local1 in this.avatars)
            {
                _local3 = this.avatars[_local1];
                if (_local3.pMC != null)
                {
                    _local2 = _local3.pMC;
                    if (this.showHPBar)
                    {
                        _local2.showHPBar();
                    }
                    else
                    {
                        _local2.hideHPBar();
                    };
                };
            };
        }

        public function showResCounter():*
        {
            var _loc1_:* = MovieClip(this.rootClass.ui.mcRes);
            if (_loc1_.currentLabel == "in")
            {
                return;
            };
            _loc1_.gotoAndPlay("in");
            _loc1_.resC = 10;
            if (_loc1_.resTimer == null)
            {
                _loc1_.resTimer = new Timer(1000);
                _loc1_.resTimer.addEventListener("timer", this.resTimer);
            }
            else
            {
                _loc1_.resTimer.reset();
            };
            _loc1_.resTimer.start();
        }

        public function resTimer(param1:TimerEvent):*
        {
            var _loc2_:* = MovieClip(this.rootClass.ui.mcRes);
            _loc2_.resC--;
            if (_loc2_.resC > 0)
            {
                _loc2_.mcTomb.ti.text = ("0" + _loc2_.resC);
            }
            else
            {
                _loc2_.mcTomb.ti.text = "00";
                param1.target.reset();
                _loc2_.visible = false;
                _loc2_.gotoAndStop(1);
                this.resPlayer();
            };
        }

        public function resPlayer():*
        {
            this.afkPostpone();
            this.rootClass.sfc.sendXtMessage("zm", "resPlayerTimed", [this.rootClass.sfc.myUserId], "str", this.curRoom);
        }

        public function rest():void
        {
            if (!this.restTimer.running)
            {
                this.myAvatar.pMC.mcChar.gotoAndPlay("Rest");
                this.rootClass.network.send("emotea", ["rest"]);
                this.restStart();
            };
        }

        public function restStart():*
        {
            this.afkPostpone();
            this.restTimer.reset();
            this.restTimer.start();
        }

        public function flyToggle():void
        {
            var _local1:* = this.uoTree[this.rootClass.network.myUserName];
            if (_local1 != null)
            {
                if (((_local1.fly) && (this.myAvatar.pMC.isInCollision())))
                {
                    this.rootClass.chatF.pushMsg("warning", "Unable to land, Cannot find a landing point.", "SERVER", "", 0);
                    return;
                };
                this.rootClass.network.send("fly", [(!(_local1.fly))]);
            };
        }

        public function afkToggle():void
        {
            var _local1:* = this.uoTree[this.rootClass.network.myUserName];
            if (_local1 != null)
            {
                this.rootClass.network.send("afk", [(!(_local1.afk))]);
            };
        }

        public function vendingToggle():void
        {
            var _local1:* = this.uoTree[this.rootClass.network.myUserName.toLowerCase()];
            if (_local1 != null)
            {
                this.rootClass.network.send("vend", [(!(_local1.vending))]);
            };
        }

        public function afkPostpone():void
        {
            this.afkTimer.reset();
            this.afkTimer.start();
            var _local1:* = new Date().getTime();
            var _local2:* = this.uoTree[this.rootClass.network.myUserName];
            if ((((!(_local2 == null)) && (_local2.afk)) && ((_local2.afkts == null) || (_local1 > (_local2.afkts + 500)))))
            {
                this.rootClass.network.send("afk", [false]);
                _local2.afkts = _local1;
            };
        }

        public function vendingStart():void
        {
            var _local2:* = this.uoTree[this.rootClass.network.myUserName];
            if (_local2 != null)
            {
                this.rootClass.network.send("vend", [true]);
            };
        }

        public function vendingPostpone():void
        {
            var _local2:* = this.uoTree[this.rootClass.network.myUserName];
            if (_local2 != null)
            {
                this.rootClass.network.send("vend", [false]);
            };
        }

        public function hideOthersPets():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).unloadPet();
                };
            };
        }

        public function showOthersPets():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).loadPet();
                };
            };
        }

        public function hideOtherHelms():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setHelmVisibility(false);
                };
            };
        }

        public function disableMonsterAnimation():void
        {
            var monster:Avatar;
            for each (monster in this.monsters)
            {
                if (monster.pMC != null)
                {
                    Game.movieClipStopAll(monster.pMC);
                };
            };
        }

        public function disableOtherPlayerAnimation():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    Game.movieClipStopAll(avatar.pMC);
                };
            };
        }

        public function disableNPCsAnimation():void
        {
            var avatar:Avatar;
            for each (avatar in this.npcs)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).disableAnimations();
                };
            };
        }

        public function showOtherHelms():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setHelmVisibility(true);
                };
            };
        }

        public function hideOtherCloaks():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setCloakVisibility(false);
                };
            };
        }

        public function showOtherCloaks():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setCloakVisibility(true);
                };
            };
        }

        public function hideOtherRunes():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setGroundVisibility(false);
                };
            };
        }

        public function showOtherRunes():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setGroundVisibility(true);
                };
            };
        }

        public function hideOtherTitles():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setTitleVisibility(false);
                };
            };
        }

        public function showOtherTitles():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setTitleVisibility(true);
                };
            };
        }

        public function hideOtherEntities():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setEntityVisibility(false);
                };
            };
        }

        public function showOtherEntities():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setEntityVisibility(true);
                };
            };
        }

        public function hideOtherUsernames():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setUsernameVisibility(false);
                };
            };
        }

        public function showOtherUsernames():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setUsernameVisibility(true);
                };
            };
        }

        public function hideOtherGuilds():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setGuildVisibility(false);
                };
            };
        }

        public function showOtherGuilds():void
        {
            var avatar:Avatar;
            for each (avatar in this.avatars)
            {
                if (((!(avatar == this.myAvatar)) && (avatar.dataLeaf.strFrame == this.strFrame)))
                {
                    AvatarMC(avatar.pMC).setGuildVisibility(true);
                };
            };
        }

        public function hideSelfAuras():void
        {
            if (this.rootClass.playerAuras != null)
            {
                this.rootClass.playerAuras.onClose();
                this.rootClass.playerAuras = null;
            };
        }

        public function showSelfAuras():void
        {
            if (this.rootClass.playerAuras == null)
            {
                this.rootClass.playerAuras = new PlayerAuras();
            };
        }

        public function hideTargetAuras():void
        {
            if (this.rootClass.targetAuras != null)
            {
                this.rootClass.targetAuras.onClose();
                this.rootClass.targetAuras = null;
            };
        }

        public function showTargetAuras():void
        {
            if (this.rootClass.targetAuras == null)
            {
                this.rootClass.targetAuras = new TargetAuras();
            };
        }

        public function updateNpcs():void
        {
            var npc:Object;
            if (((this.myAvatar == null) || (this.myAvatar.objData == null)))
            {
                return;
            };
            var i:int;
            for each (npc in this.npcmap)
            {
                if (((npc.frame == this.strFrame) && ((!(npc.isStaffOnly)) || ((npc.isStaffOnly) && (this.myAvatar.isStaff())))))
                {
                    npc.avatarMC = ((npc.avatarMC == null) ? new AvatarMC() : npc.avatarMC);
                    new CoreNPC(this, this.npcs[i], npc, i);
                };
                i++;
            };
        }

        public function updateMonsters():void
        {
            var _local1:int;
            if (this.monmap != null)
            {
                _local1 = 0;
                while (_local1 < this.monmap.length)
                {
                    if (this.monmap[_local1].strFrame == this.strFrame)
                    {
                        this.updateMonster(this.monmap[_local1]);
                    };
                    _local1++;
                };
            };
        }

        public function updateMonster(monsterData:Object):void
        {
            var monster:Avatar = this.getMonster(monsterData.MonMapID);
            if (monster == null)
            {
                return;
            };
            if (monster.pMC == null)
            {
                return;
            };
            var monTreeElement:* = this.monTree[monsterData.MonMapID];
            if (((!(monTreeElement.MonID == monster.objData.MonID)) || (monTreeElement.intState == 0)))
            {
                monster.pMC.visible = false;
            };
            if (monster.pMC.displayObject.scaleX < 0)
            {
                monster.pMC.displayObject.scaleX = (monster.pMC.displayObject.scaleX * -1);
            };
            if ((monster.pMC.x - this.myAvatar.pMC.x) >= 0)
            {
                monster.pMC.turn("left");
            };
            monster.pMC.updateNamePlate();
        }

        public function createMonsterMC(monsterPad:Object, monID:int):MonsterMC
        {
            var monster:Object;
            var data:Object;
            monster = this.getMonsterDefinition(monID);
            monsterPad.isGenerated = true;
            var monsterMC:MonsterMC = new MonsterMC(monster.strMonName);
            this.CHARS.addChild(monsterMC);
            monsterMC.x = monsterPad.x;
            monsterMC.y = monsterPad.y;
            monsterMC.ox = monsterMC.x;
            monsterMC.oy = monsterMC.y;
            if (this.objExtra.bChar === 1)
            {
                monsterMC.removeChildAt(1);
                monsterMC.addChildAt(new dummyMC(), 1);
                this.copyAvatarMC(MovieClip(monsterMC.getChildAt(1)));
            }
            else
            {
                monsterMC.removeChildAt(1);
                monsterMC.displayObject = new (LoadController.singleton.applicationDomainMap.getDefinition(monster["strLinkage"]))();
                monsterMC.addChildAt(monsterMC.displayObject, 1);
            };
            monsterMC.mouseEnabled = false;
            monsterMC.bubble.mouseEnabled = (monsterMC.bubble.mouseChildren = false);
            monsterMC.init();
            if (((!(monsterPad.strDir === undefined)) && (monsterPad.strDir === "static")))
            {
                monsterMC.isStatic = true;
            };
            if (monsterPad.intScale !== undefined)
            {
                monsterMC.scale(monsterPad.intScale);
            }
            else
            {
                data = this.mapController.find(this.frames, this.map.currentLabel);
                monsterMC.scale(((data != null) ? data.scale : this.SCALE));
            };
            if (monsterPad.noMove !== undefined)
            {
                monsterMC.noMove = monsterPad.noMove;
            };
            if (monster.isWorldBoss)
            {
                monsterMC.isStatic = true;
                monsterMC.noMove = true;
                this.CELL_MODE = "WorldBoss";
            };
            this.updateMonsterPosition(monsterPad.MonMapID, monsterPad.x, monsterPad.y);
            return (monsterMC);
        }

        public function getNpc(npcMapID:int):Avatar
        {
            var npc:Avatar;
            for each (npc in this.npcs)
            {
                if (((npc.objData.NpcMapID == npcMapID) && (npc.objData.NpcID == this.npcTree[npcMapID].NpcID)))
                {
                    return (npc);
                };
            };
            return (null);
        }

        public function getMonster(monMapID:int):Avatar
        {
            var monster:Avatar;
            for each (monster in this.monsters)
            {
                if (((monster.objData.MonMapID == monMapID) && (monster.objData.MonID == this.monTree[monMapID].MonID)))
                {
                    return (monster);
                };
            };
            return (null);
        }

        public function getMonsters(_arg1:int):Array
        {
            var _local3:int;
            var _local2:Array = [];
            while (_local3 < this.monsters.length)
            {
                if (this.monsters[_local3].objData.MonMapID == _arg1)
                {
                    _local2.push(this.monsters[_local3]);
                };
                _local3++;
            };
            if (_local2.length > 0)
            {
                return (_local2);
            };
            return (null);
        }

        public function getMonsterCluster(_arg1:int):Array
        {
            var _local3:int;
            var _local2:* = [];
            while (_local3 < this.monsters.length)
            {
                if (this.monsters[_local3].objData.MonMapID == _arg1)
                {
                    _local2.push(this.monsters[_local3]);
                };
                _local3++;
            };
            return (_local2);
        }

        public function getMonstersByCell(frame:String):Array
        {
            var monster:Avatar;
            var avatars:Array = [];
            for each (monster in this.monsters)
            {
                if (monster.dataLeaf.strFrame == frame)
                {
                    avatars.push(monster);
                };
            };
            return (avatars);
        }

        public function initNpcs():void
        {
            var prop:Object;
            var currentNPCDefinition:Object;
            var npcTreeNode:Object;
            var npc:Avatar;
            var i:int;
            var innerIndex:int;
            this.npcs = [];
            if (((!(this.npcdef == null)) && (!(this.npcmap == null))))
            {
                currentNPCDefinition = null;
                npcTreeNode = null;
                i = 0;
                while (i < this.npcmap.length)
                {
                    innerIndex = 0;
                    while (innerIndex < this.npcdef.length)
                    {
                        if (this.npcmap[i].MonID == this.npcdef[innerIndex].MonID)
                        {
                            currentNPCDefinition = this.npcdef[innerIndex];
                            break;
                        };
                        innerIndex++;
                    };
                    npc = new Avatar(Game.root);
                    npc.npcType = "npc";
                    if (npc.objData == null)
                    {
                        npc.objData = {};
                    };
                    for (prop in currentNPCDefinition)
                    {
                        npc.objData[prop] = currentNPCDefinition[prop];
                    };
                    for (prop in this.npcmap[i])
                    {
                        npc.objData[prop] = this.npcmap[i][prop];
                    };
                    npcTreeNode = this.npcTree[String(npc.objData.NpcMapID)];
                    npcTreeNode.strFrame = ((Game.root.frameCheck(this.map, npc.objData.strFrame)) ? npc.objData.strFrame : "Enter");
                    npc.dataLeaf = ((npcTreeNode.NpcID == npc.objData.NpcID) ? this.npcTree[npc.objData.NpcMapID] : null);
                    this.npcs.push(npc);
                    i++;
                };
            };
            this.enterMap();
        }

        public function initMonsters():void
        {
            var i:int;
            var prop:Object;
            var monster:Avatar;
            var innerIndex:int;
            this.monsters = [];
            if (((this.mondef == null) || (this.monmap == null)))
            {
                return;
            };
            var currentMonsterDefinition:Object;
            var monsterTreeNode:Object;
            i = 0;
            while (i < this.monmap.length)
            {
                innerIndex = 0;
                while (innerIndex < this.mondef.length)
                {
                    if (this.monmap[i].MonID == this.mondef[innerIndex].MonID)
                    {
                        currentMonsterDefinition = this.mondef[innerIndex];
                        break;
                    };
                    innerIndex++;
                };
                monster = new Avatar(Game.root);
                monster.npcType = "monster";
                if (monster.objData == null)
                {
                    monster.objData = {};
                };
                for (prop in currentMonsterDefinition)
                {
                    monster.objData[prop] = currentMonsterDefinition[prop];
                };
                for (prop in this.monmap[i])
                {
                    monster.objData[prop] = this.monmap[i][prop];
                };
                monsterTreeNode = this.monTree[String(monster.objData.MonMapID)];
                monsterTreeNode.strFrame = String(monster.objData.strFrame);
                monster.dataLeaf = ((monsterTreeNode.MonID == monster.objData.MonID) ? this.monTree[monster.objData.MonMapID] : null);
                this.monsters.push(monster);
                i++;
            };
            var loadedMonsters:Array = [];
            i = 0;
            while (i < this.mondef.length)
            {
                if (loadedMonsters.indexOf(this.mondef[i].strMonFileName) < 0)
                {
                    this.mapMonsterToLoad++;
                    loadedMonsters.push(this.mondef[i].strMonFileName);
                    LoadController.singleton.addLoadMap(("mon/" + this.mondef[i].strMonFileName), (this.mondef[i].MonID + "_monster"), this.onMonsterLoad);
                };
                i++;
            };
        }

        private function onMonsterLoad(event:Event):void
        {
            this.mapMonsterLoaded++;
            if (this.mapMonsterLoaded >= this.mapMonsterToLoad)
            {
                this.initNpcs();
            };
        }

        public function setTarget(avatar:Avatar):void
        {
            var targetColor:*;
            if (((!(this.myAvatar == null)) && (!(this.myAvatar.target == avatar))))
            {
                targetColor = this.avtMCT;
                if (this.myAvatar.target != null)
                {
                    if (this.myAvatar.target.npcType === "monster")
                    {
                        if ((((this.bPvP) && (!(this.myAvatar.target.dataLeaf.react == null))) && (this.myAvatar.target.dataLeaf.react[this.myAvatar.dataLeaf.pvpTeam] == 1)))
                        {
                            targetColor = this.avtPCT;
                        }
                        else
                        {
                            targetColor = this.avtMCT;
                        };
                    }
                    else
                    {
                        if (((this.bPvP) && (!(this.myAvatar.target.dataLeaf.pvpTeam == this.myAvatar.dataLeaf.pvpTeam))))
                        {
                            targetColor = this.avtMCT;
                        }
                        else
                        {
                            targetColor = this.avtPCT;
                        };
                    };
                    if (this.myAvatar.target.pMC)
                    {
                        this.myAvatar.target.pMC.modulateColor(targetColor, "-");
                    };
                };
                if (avatar != null)
                {
                    if ((((!(this.bPvP)) && (avatar.npcType == "player")) && (!(this.autoActionTimer == null))))
                    {
                        this.cancelAutoAttack();
                    };
                    this.myAvatar.target = avatar;
                    if (this.myAvatar.target.npcType === "monster")
                    {
                        if ((((this.bPvP) && (!(this.myAvatar.target.dataLeaf.react == null))) && (this.myAvatar.target.dataLeaf.react[this.myAvatar.dataLeaf.pvpTeam] == 1)))
                        {
                            targetColor = this.avtPCT;
                        }
                        else
                        {
                            targetColor = this.avtMCT;
                        };
                    }
                    else
                    {
                        if (((this.bPvP) && (!(this.myAvatar.target.dataLeaf.pvpTeam == this.myAvatar.dataLeaf.pvpTeam))))
                        {
                            targetColor = this.avtMCT;
                        }
                        else
                        {
                            targetColor = this.avtPCT;
                        };
                    };
                    if (this.myAvatar.target.pMC)
                    {
                        this.myAvatar.target.pMC.modulateColor(targetColor, "+");
                    };
                    this.rootClass.showPortraitTarget(avatar);
                }
                else
                {
                    this.rootClass.hidePortraitTarget();
                    if (this.myAvatar.dataLeaf.intState > 0)
                    {
                        this.exitCombat();
                    };
                    this.myAvatar.target = null;
                };
            };
        }

        public function cancelTarget():void
        {
            if (((!(this.autoActionTimer == null)) && (this.autoActionTimer.running)))
            {
                this.cancelAutoAttack();
                this.myAvatar.pMC.mcChar.gotoAndStop("Idle");
                return;
            };
            if (this.myAvatar.target != null)
            {
                this.setTarget(null);
            };
        }

        public function approachTarget():void
        {
            var _local8:Number;
            var _local9:Number;
            var _local10:int;
            var _local11:int;
            var _local12:int;
            var _local13:int;
            var _local14:int;
            var _local15:int;
            var _local17:*;
            var _local18:*;
            var _local22:Array;
            var targetData:Object;
            var cReg:Point;
            var tReg:Point;
            var tries:*;
            var moveOK:*;
            var xBuffer:*;
            var yBuffer:*;
            var xTarget:*;
            var yTarget:*;
            var _local1:Boolean = true;
            var _local2:Object = this.uoTree[this.rootClass.network.myUserName];
            var skill:Skill = this.getAutoAttack();
            if (this.myAvatar.target != null)
            {
                switch (this.myAvatar.target.npcType)
                {
                    case "monster":
                        targetData = this.monTree[this.myAvatar.target.objData.MonMapID];
                        break;
                    case "npc":
                        targetData = this.npcTree[this.myAvatar.target.objData.NpcMapID];
                        break;
                    case "player":
                        targetData = this.myAvatar.target.dataLeaf;
                        break;
                };
                if ((((targetData == null) || (_local2.intState == 0)) || (targetData.intState == 0)))
                {
                    _local1 = false;
                };
                if ((((this.bPvP) && (((!(targetData.react == null)) && (targetData.react[_local2.pvpTeam] == 1)) || (_local2.pvpTeam == targetData.pvpTeam))) || ((!(this.bPvP)) && (this.myAvatar.target.npcType == "player"))))
                {
                    _local1 = false;
                };
                if (((((this.myAvatar.target.npcType == "player") && (this.bPK)) || (((this.myAvatar.target.npcType == "player") && (this.aTarget == this.myAvatar.target)) && (!(this.aTarget == this.myAvatar)))) || (this.myAvatar.target.npcType == "npc")))
                {
                    _local1 = true;
                };
                if (_local1)
                {
                    this.rootClass.mixer.playSound("ClickBig");
                    if (skill != null)
                    {
                        if (this.actionRangeCheck(skill))
                        {
                            this.combatAction(skill);
                        }
                        else
                        {
                            this.actionReady = true;
                            cReg = this.myAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                            tReg = this.myAvatar.target.pMC.mcChar.localToGlobal(new Point(0, 0));
                            tries = 0;
                            moveOK = false;
                            while (((tries < 100) && (!(moveOK))))
                            {
                                buffer = int((150 + (Math.random() * 20)));
                                if (tries > 50)
                                {
                                    buffer = (buffer * -1);
                                };
                                xBuffer = (((tReg.x - cReg.x) >= 0) ? -(buffer) : buffer);
                                yBuffer = ((Math.random() * 40) - 20);
                                xBuffer = Math.ceil((xBuffer * this.SCALE));
                                yBuffer = Math.floor((yBuffer * this.SCALE));
                                xTarget = (tReg.x + xBuffer);
                                yTarget = (tReg.y + yBuffer);
                                moveOK = (!(this.padHit(xTarget, yTarget, this.myAvatar.pMC.shadow.getBounds(stage))));
                                tries++;
                            };
                            if (moveOK)
                            {
                                this.myAvatar.pMC.walkTo((this.myAvatar.target.pMC.x + xBuffer), (this.myAvatar.target.pMC.y + yBuffer), 32);
                                this.pushMove(this.myAvatar.pMC, (this.myAvatar.target.pMC.x + xBuffer), (this.myAvatar.target.pMC.y + yBuffer), 32);
                            }
                            else
                            {
                                this.rootClass.chatF.pushMsg("server", "No path found!", "SERVER", "", 0);
                            };
                        };
                    };
                };
            }
            else
            {
                _local17 = null;
                _local18 = null;
                _local22 = this.getAllAvatarsInCell();
                for each (_local17 in _local22)
                {
                    targetData = _local17.dataLeaf;
                    if ((((_local17 == this.aTarget) || ((this.bPK) && (!(_local17 == this.myAvatar)))) || (((!(targetData == null)) && (((((!(this.bPvP)) && (_local17.npcType == "monster")) || (_local17.npcType == "npc")) || (((this.bPvP) && (_local17.npcType == "player")) && (!(_local2.pvpTeam == targetData.pvpTeam)))) || ((((this.bPvP) && (_local17.npcType == "monster")) && (!(targetData.react == null))) && (targetData.react[_local2.pvpTeam] == 0)))) && (this.actionRangeCheck(skill, _local17)))))
                    {
                        this.setTarget(_local17);
                        this.combatAction(skill);
                        return;
                    };
                };
                this.rootClass.chatF.pushMsg("warning", "No target selected!", "SERVER", "", 0);
            };
        }

        public function padHit(_arg1:int, _arg2:int, _arg3:Rectangle):Boolean
        {
            var _local5:Rectangle;
            var _local6:MovieClip;
            var _local4:int;
            if (((((_arg1 < 0) || (_arg1 > 960)) || (_arg2 < 10)) || (_arg2 > 530)))
            {
                return (false);
            };
            _arg3.x = int((_arg1 - (_arg3.width / 2)));
            _arg3.y = int((_arg2 - (_arg3.height / 2)));
            _local4 = 0;
            while (_local4 < this.arrEvent.length)
            {
                _local6 = this.arrEvent[_local4];
                if ((("strSpawnCell" in _local6) || ("tCell" in _local6)))
                {
                    _local5 = this.arrEventR[_local4];
                    if (_arg3.intersects(_local5))
                    {
                        return (true);
                    };
                };
                _local4++;
            };
            return (false);
        }

        public function drawRects(_arg1:Array):void
        {
            var _local5:Rectangle;
            var _local6:int;
            var _local2:Array = [0xFF0000, 0xFF00, 0xFF];
            var _local3:Sprite = new Sprite();
            var _local4:Graphics = _local3.graphics;
            _local6 = 0;
            while (_local6 < _arg1.length)
            {
                _local5 = _arg1[_local6];
                _local4.moveTo(_local5.x, _local5.y);
                _local4.beginFill(_local2[_local6], 0.3);
                _local4.lineTo((_local5.x + _local5.width), _local5.y);
                _local4.lineTo((_local5.x + _local5.width), (_local5.y + _local5.height));
                _local4.lineTo(_local5.x, (_local5.y + _local5.height));
                _local4.lineTo(_local5.x, _local5.y);
                _local4.endFill();
                _local6++;
            };
        }

        public function combatAction(action:Skill, forceAARangeError:Boolean=false):void
        {
            var tLeaf:Object;
            var tAvt:Avatar;
            var forceAALoop:Boolean;
            var pAvt:Avatar;
            var tgtOK:Boolean;
            var aura:Object;
            var now:Number;
            var sAvt:Avatar;
            var b:int;
            var c:int;
            var too:Object;
            var cLeaf:Object = this.uoTreeLeaf(this.rootClass.network.myUserName);
            var targets:Array = [];
            var scan:Vector.<Avatar> = this.getAllAvatarsInCell2();
            tAvt = null;
            var a:int;
            while (a < scan.length)
            {
                tAvt = scan[a];
                if ((((tAvt.dataLeaf == null) || (tAvt.dataLeaf.intState == 0)) || (tAvt.pMC == null)))
                {
                    scan.splice(a, 1);
                    a--;
                    if (tAvt == this.myAvatar.target)
                    {
                        this.setTarget(null);
                    };
                };
                a++;
            };
            a = 0;
            tAvt = null;
            if (((!(this.myAvatar.target == null)) && (scan.indexOf(this.myAvatar.target) > -1)))
            {
                scan.unshift(scan.splice(scan.indexOf(this.myAvatar.target), 1)[0]);
            };
            this.afkPostpone();
            switch (true)
            {
                case (!(this.actionTimeCheck(action))):
                    break;
                case (!(action.skillLock == null)):
                    this.rootClass.chatF.pushMsg("warning", (("The ability '" + action.nam) + "' is locked and not ready for use yet."), "SERVER", "", 0);
                    break;
                case (Math.round((action.mp * cLeaf.sta["$cmc"])) > cLeaf.intMP):
                    this.rootClass.chatF.pushMsg("warning", "Not enough mana!", "SERVER", "", 0);
                    break;
                case (((action.ref == "i1") && (action.typ == "i")) && (action.sArg1 == "")):
                    this.rootClass.chatF.pushMsg("warning", "No item assigned to that slot!", "SERVER", "", 0);
                    break;
                case ((((!(this.myAvatar.target == null)) && (!(action.filter == null))) && ("sRace" in this.myAvatar.target.objData)) && (!(this.myAvatar.target.objData.sRace.toLowerCase() == action.filter.toLowerCase()))):
                    this.rootClass.chatF.pushMsg("warning", (("Target is not a " + action.filter) + "!"), "SERVER", "", 0);
                    break;
                default:
                    for each (aura in cLeaf.auras)
                    {
                        if (aura.cat != null)
                        {
                            switch (aura.cat)
                            {
                                case "stun":
                                    this.rootClass.chatF.pushMsg("warning", "Cannot act while stunned!", "SERVER", "", 0);
                                    return;
                                case "stone":
                                    this.rootClass.chatF.pushMsg("warning", "Cannot act while petrified!", "SERVER", "", 0);
                                    return;
                                case "disabled":
                                    this.rootClass.chatF.pushMsg("warning", "Cannot act while disabled!", "SERVER", "", 0);
                                    return;
                                case "freeze":
                                    this.rootClass.chatF.pushMsg("warning", "Cannot act while frozen!", "SERVER", "", 0);
                                    return;
                                default:
                                    forceAALoop = true;
                            };
                        };
                    };
                    if (action.pet != 0)
                    {
                        if (this.myAvatar.getItemByEquipSlot("pe") == null)
                        {
                            this.summonPet(action.pet, this.myAvatar.checkTempItem(action.pet, 1));
                        };
                    }
                    else
                    {
                        if (((action.checkPet) && (this.myAvatar.getItemByEquipSlot("pe").sMeta.indexOf(action.checkPet) == -1)))
                        {
                            this.rootClass.chatF.pushMsg("warning", "No battle pet equipped.", "SERVER", "", 0);
                            return;
                        };
                    };
                    if (this.myAvatar.target != null)
                    {
                        tAvt = this.myAvatar.target;
                        switch (true)
                        {
                            case (this.myAvatar.target.npcType == "monster"):
                                tLeaf = this.monTree[tAvt.objData.MonMapID];
                                break;
                            case (this.myAvatar.target.npcType == "npc"):
                                tLeaf = this.npcTree[tAvt.objData.NpcMapID];
                                break;
                            case (tAvt.npcType == "player"):
                                tLeaf = tAvt.dataLeaf;
                                break;
                        };
                    };
                    switch (action.tgt)
                    {
                        case "h":
                            if (tAvt == null)
                            {
                                for each (tAvt in scan)
                                {
                                    tLeaf = tAvt.dataLeaf;
                                    if (((((tAvt == this.aTarget) && (!(this.aTarget == this.myAvatar))) || ((this.bPK) && (!(tAvt == this.myAvatar)))) || (((!(tLeaf == null)) && (((((!(this.bPvP)) && (tAvt.npcType == "npc")) || ((!(this.bPvP)) && (tAvt.npcType == "monster"))) || (((this.bPvP) && (tAvt.npcType == "player")) && (!(cLeaf.pvpTeam == tLeaf.pvpTeam)))) || ((((this.bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 0)))) && (this.actionRangeCheck(action, tAvt)))))
                                    {
                                        this.setTarget(tAvt);
                                        this.combatAction(action);
                                        return;
                                    };
                                };
                                this.rootClass.chatF.pushMsg("warning", "No target selected!", "SERVER", "", 0);
                                if (action.typ == "aa")
                                {
                                    this.cancelAutoAttack();
                                };
                                return;
                            };
                            if ((((((((((!(tAvt == this.aTarget)) && (!(this.aTarget == this.myAvatar))) && (!(this.bPvP))) && (tAvt.npcType == "player")) && (!(tAvt.npcType == "npc"))) && (!(this.bPK))) && (!(tAvt == this.myAvatar))) || (((this.bPvP) && (tAvt.npcType == "player")) && (cLeaf.pvpTeam == tLeaf.pvpTeam))) || ((((this.bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1))))
                            {
                                this.rootClass.chatF.pushMsg("warning", "Can't attack that target!", "SERVER", "", 0);
                                if (action.typ == "aa")
                                {
                                    this.cancelAutoAttack();
                                };
                                return;
                            };
                            if (tAvt.dataLeaf.intState == 0)
                            {
                                this.rootClass.chatF.pushMsg("warning", "Your target is dead!", "SERVER", "", 0);
                                return;
                            };
                            break;
                        case "f":
                            if (tAvt == null)
                            {
                                tAvt = this.myAvatar;
                                tLeaf = this.myAvatar.dataLeaf;
                            };
                            if ((((((!(this.bPvP)) && (tAvt.npcType == "npc")) || ((!(this.bPvP)) && (tAvt.npcType == "monster"))) || ((this.bPvP) && (!(cLeaf.pvpTeam == tLeaf.pvpTeam)))) || ((((this.bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1))))
                            {
                                tAvt = this.myAvatar;
                            };
                            tLeaf = tAvt.dataLeaf;
                            break;
                        case "s":
                            tAvt = this.myAvatar;
                            tLeaf = tAvt.dataLeaf;
                            break;
                    };
                    pAvt = tAvt;
                    if (((!(this.actionRangeCheck(action, pAvt))) || (forceAALoop)))
                    {
                        if (((!(forceAALoop)) && ((!(action.typ == "aa")) || (forceAARangeError))))
                        {
                            now = new Date().getTime();
                            if ((now - this.actionRangeSpamTS) > 3000)
                            {
                                this.actionRangeSpamTS = now;
                                this.rootClass.chatF.pushMsg("warning", "You are out of range! Move closer to your target!", "SERVER", "", 0);
                                return;
                            };
                        };
                        if (action.typ == "aa")
                        {
                            this.autoActionTimer.delay = 500;
                            this.autoActionTimer.reset();
                            this.autoActionTimer.start();
                        };
                    };
                    tgtOK = true;
                    while (scan.length > 0)
                    {
                        tAvt = scan[0];
                        tLeaf = tAvt.dataLeaf;
                        tgtOK = (!(tLeaf.intState == 0));
                        if (((((!(tAvt == null)) && (!(action.filter == null))) && ("sRace" in tAvt.objData)) && (!(tAvt.objData.sRace.toLowerCase() == action.filter.toLowerCase()))))
                        {
                            tgtOK = false;
                        };
                        switch (action.tgt)
                        {
                            case "h":
                                if ((((this.bPK) && (tAvt == this.myAvatar)) || ((((!(this.bPvP)) && (tAvt.npcType == "player")) || (((this.bPvP) && (tAvt.npcType == "player")) && (cLeaf.pvpTeam == tLeaf.pvpTeam))) || ((((this.bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1)))))
                                {
                                    tgtOK = false;
                                };
                                if (tAvt.npcType == "npc")
                                {
                                    tgtOK = true;
                                };
                                if (((this.bPK) && (!(tAvt == this.myAvatar))))
                                {
                                    tgtOK = true;
                                };
                                if (((tAvt == this.aTarget) && (!(this.aTarget == this.myAvatar))))
                                {
                                    tgtOK = true;
                                };
                                break;
                            case "f":
                                if ((((((this.aTarget == tAvt) && (!(this.aTarget == this.myAvatar))) || ((!(this.bPvP)) && (tAvt.npcType == "monster"))) || ((this.bPvP) && (!(cLeaf.pvpTeam == tLeaf.pvpTeam)))) || ((((this.bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1))))
                                {
                                    tgtOK = false;
                                };
                                break;
                            case "s":
                                if (((!(tAvt == null)) && (!(tAvt == this.myAvatar))))
                                {
                                    tgtOK = false;
                                };
                                break;
                        };
                        if (tgtOK)
                        {
                            sAvt = this.myAvatar;
                            if (((action.fx == "c") && (targets.length > 0)))
                            {
                                sAvt = targets[(targets.length - 1)].avt;
                            };
                            a = Math.abs((tAvt.pMC.x - sAvt.pMC.x));
                            b = Math.abs((tAvt.pMC.y - sAvt.pMC.y));
                            c = Math.pow(((a * a) + (b * b)), 0.5);
                            if (this.actionRangeCheck(action, tAvt))
                            {
                                targets.push({
                                    "avt":tAvt,
                                    "d":c,
                                    "hp":tLeaf.intHP
                                });
                            };
                        };
                        scan.shift();
                    };
                    targets.sortOn("hp", Array.NUMERIC);
                    if (pAvt != null)
                    {
                        a = 0;
                        while (a < targets.length)
                        {
                            too = targets[a];
                            if (too.avt == pAvt)
                            {
                                targets.unshift(targets.splice(a, 1)[0]);
                            };
                            a++;
                        };
                    };
                    if (targets.length > action.tgtMax)
                    {
                        targets = targets.splice(0, action.tgtMax);
                    };
                    if (targets.length > 0)
                    {
                        if (pAvt != null)
                        {
                            if (((!(targets[0].avt == null)) && (!(targets[0].avt.dataLeaf == null))))
                            {
                                tAvt = targets[0].avt;
                                tLeaf = tAvt.dataLeaf;
                            }
                            else
                            {
                                tAvt = null;
                                tLeaf = null;
                            };
                        }
                        else
                        {
                            tAvt = null;
                            tLeaf = null;
                        };
                    };
                    if (cLeaf.intState != 0)
                    {
                        if ((((!(action.lock)) && ((tLeaf == null) || (!(tLeaf.intState == 0)))) && (targets.length >= action.tgtMin)))
                        {
                            this.doAction(action, targets);
                        };
                        if ((((this.myAvatar.target == null) || (tLeaf == null)) || (tLeaf.intState == 0)))
                        {
                            this.exitCombat();
                        };
                    };
            };
        }

        public function summonPet(petId:int, equip:Boolean):void
        {
            this.rootClass.network.send(((equip) ? "equipItem" : "summonPet"), [petId]);
        }

        public function getAutoAttack():Skill
        {
            return (this.actions.auto);
        }

        public function healByIcon(avatar:Avatar):void
        {
            var action:Skill = this.getFirstHeal();
            if (action != null)
            {
                this.setTarget(avatar);
                this.combatAction(action);
            };
        }

        public function getFirstHeal():Skill
        {
            var action:Skill;
            for each (action in this.actions.active)
            {
                if (((action.damage < 0) && (action.isOK)))
                {
                    return (action);
                };
            };
            return (null);
        }

        public function exitCombat():*
        {
            var _local1:int;
            this.actionReady = false;
            if (((!(this.actions == null)) && (!(this.actions.active == null))))
            {
                _local1 = 0;
                while (_local1 < this.actions.active.length)
                {
                    this.actions.active[_local1].lock = false;
                    _local1++;
                };
            };
            if (this.myAvatar != null)
            {
                if (((((!(this.myAvatar.pMC == null)) && (!(this.myAvatar.pMC.mcChar == null))) && (!(this.myAvatar.pMC.mcChar.onMove))) && (!(this.myAvatar.pMC.mcChar.currentLabel == "Rest"))))
                {
                    this.myAvatar.pMC.mcChar.gotoAndStop("Idle");
                };
                if (this.myAvatar.dataLeaf != null)
                {
                    this.myAvatar.dataLeaf.targets = {};
                };
                this.cancelAutoAttack();
            };
        }

        public function cancelAutoAttack():*
        {
            var icon:MovieClip;
            if (this.autoActionTimer != null)
            {
                this.autoActionTimer.reset();
            };
            var i:* = 0;
            while (i < this.actionMap.length)
            {
                try
                {
                    if (this.actionMap[i] == "aa")
                    {
                        icon = MovieClip(this.rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i + 1))));
                        icon.bg.gotoAndStop(1);
                    };
                }
                catch(e:Error)
                {
                    if (Config.isDebug)
                    {
                        trace(("world 14 " + e));
                    };
                };
                i++;
            };
        }

        public function doAction(action:Skill, targets:Array):void
        {
            var avatar:Avatar;
            var avatar2:Avatar;
            this.afkPostpone();
            if (targets.length > 0)
            {
                avatar = targets[0].avt;
                if (avatar != this.myAvatar)
                {
                    if ((avatar.pMC.x - this.myAvatar.pMC.x) >= 0)
                    {
                        this.myAvatar.pMC.turn("right");
                    }
                    else
                    {
                        this.myAvatar.pMC.turn("left");
                    };
                };
            };
            var i:int;
            while (i < targets.length)
            {
                avatar2 = targets[i].avt;
                switch (avatar2.npcType)
                {
                    case "monster":
                        if (this.myAvatar.dataLeaf.targets[avatar2.objData.MonMapID] == null)
                        {
                            this.myAvatar.dataLeaf.targets[avatar2.objData.MonMapID] = "m";
                        };
                        break;
                    case "npc":
                        if (this.myAvatar.dataLeaf.targets[avatar2.objData.NpcMapID] == null)
                        {
                            this.myAvatar.dataLeaf.targets[avatar2.objData.NpcMapID] = "n";
                        };
                        break;
                    case "player":
                        if (this.myAvatar.dataLeaf.targets[avatar2.objData.uid] == null)
                        {
                            this.myAvatar.dataLeaf.targets[avatar2.objData.uid] = "p";
                        };
                        break;
                };
                i++;
            };
            this.getActionResult(action, targets);
        }

        public function aggroMap(_arg1:String, _arg2:String, _arg3:*):void
        {
            var _local12:*;
            var _local13:*;
            var _local4:String = _arg1.split(":")[0];
            var _local5:String = _arg1.split(":")[1];
            var _local6:String = _arg2.split(":")[0];
            var _local7:String = _arg2.split(":")[1];
            var _local8:* = "";
            var _local9:* = "";
            var _local10:Object = {};
            var _local11:Object = {};
            switch (_local4)
            {
                case "p":
                    _local10 = this.getUoLeafById(_local5);
                    break;
                case "m":
                    _local10 = this.monTree[_local5];
                    break;
                case "n":
                    _local10 = this.npcTree[_local5];
                    break;
            };
            switch (_local6)
            {
                case "p":
                    _local11 = this.getUoLeafById(_local7);
                    break;
                case "m":
                    _local11 = this.monTree[_local7];
                    break;
                case "n":
                    _local11 = this.npcTree[_local7];
                    break;
            };
            if (!("targets" in _local10))
            {
                _local10.targets = {};
            };
            if (!("targets" in _local11))
            {
                _local11.targets = {};
            };
            if (((_local6 == "m") || (_local6 == "n")))
            {
                if (!(_local7 in _local10.targets))
                {
                    _local10.targets[_local7] = _local6;
                };
                if (!(_local5 in _local11.targets))
                {
                    _local11.targets[_local5] = _local4;
                };
            };
            if ((((_local4 == "p") && (_local6 == "p")) && (_arg3)))
            {
                for (_local12 in this.monTree)
                {
                    _local13 = this.monTree[_local12];
                    if (((!(_local13.targets[_local7] == null)) && (!(_local5 in _local13.targets))))
                    {
                        _local13.targets[_local5] = _local4;
                    };
                };
            };
        }

        public function aggroAllMon():*
        {
            var _local2:*;
            var _local1:* = [];
            for (_local2 in this.monTree)
            {
                if (this.monTree[_local2].strFrame == this.strFrame)
                {
                    _local1.push(_local2);
                };
            };
            this.aggroMons(_local1);
        }

        public function aggroMon(_arg1:*):*
        {
            var _local2:* = [];
            _local2.push(_arg1);
            this.aggroMons(_local2);
        }

        public function aggroMons(_arg1:*):*
        {
            if (_arg1.length)
            {
                this.rootClass.network.send("aggroMon", _arg1);
            };
        }

        public function aggroAllNpc():*
        {
            var _local2:*;
            var _local1:* = [];
            for (_local2 in this.npcTree)
            {
                if (this.npcTree[_local2].strFrame == this.strFrame)
                {
                    _local1.push(_local2);
                };
            };
            this.aggroNpcs(_local1);
        }

        public function aggroNpc(_arg1:*):*
        {
            var _local2:* = [];
            _local2.push(_arg1);
            this.aggroNpcs(_local2);
        }

        public function aggroNpcs(_arg1:*):*
        {
            if (_arg1.length)
            {
                this.rootClass.network.send("aggroNpc", _arg1);
            };
        }

        public function castSpellFX(avatar1:Avatar, spFX:Object, cmd:*, spellDur:int=0):void
        {
            var spell:MovieClip;
            var mcChars:Array;
            var firstAvatar:Avatar;
            var avt:Avatar;
            var sp_C1Cls:Class;
            var avatar:Avatar;
            var cls:Class;
            if (avatar1 != null)
            {
                if ((((avatar1.npcType == "player") && (avatar1.pMC == this.myAvatar.pMC)) && (Game.root.userPreference.data.combatHideSelfSkillAnimations)))
                {
                    return;
                };
                if ((((avatar1.npcType == "player") && (!(avatar1.pMC == this.myAvatar.pMC))) && (Game.root.userPreference.data.combatHideOthersSkillAnimations)))
                {
                    return;
                };
                if (((avatar1.npcType == "monster") && (Game.root.userPreference.data.combatHideMonstersSkillAnimations)))
                {
                    return;
                };
                if (((avatar1.npcType == "npc") && (Game.root.userPreference.data.combatHideNPCsSkillAnimations)))
                {
                    return;
                };
            };
            if ((((!(spFX.strl == null)) && (!(spFX.strl == ""))) && (!(spFX.avts == null))))
            {
                mcChars = [];
                switch (spFX.fx)
                {
                    case "c":
                        if (spFX.strl == "lit1")
                        {
                            mcChars.push(avatar1.pMC.mcChar);
                            for each (avt in spFX.avts)
                            {
                                if ((((!(avt == null)) && (!(avt.pMC == null))) && (!(avt.pMC.mcChar == null))))
                                {
                                    mcChars.push(avt.pMC.mcChar);
                                };
                            };
                            if (mcChars.length > 1)
                            {
                                sp_C1Cls = this.getClass("sp_C1");
                                if (sp_C1Cls != null)
                                {
                                    spell = new (sp_C1Cls)();
                                    spell.mouseEnabled = false;
                                    spell.mouseChildren = false;
                                    spell.visible = true;
                                    spell.world = this.rootClass.world;
                                    spell.strl = spFX.strl;
                                    this.rootClass.drawChainsLinear(mcChars, 33, MovieClip(this.CHARS.addChild(spell)));
                                };
                            };
                        };
                        break;
                    case "f":
                        mcChars.push(avatar1.pMC.mcChar);
                        firstAvatar = spFX.avts[0];
                        if ((((!(firstAvatar == null)) && (!(firstAvatar.pMC == null))) && (!(firstAvatar.pMC.mcChar == null))))
                        {
                            mcChars.push(firstAvatar.pMC.mcChar);
                        };
                        if (mcChars.length > 1)
                        {
                            spell = new MovieClip();
                            spell.mouseEnabled = false;
                            spell.mouseChildren = false;
                            spell.visible = true;
                            spell.world = this.rootClass.world;
                            spell.strl = spFX.strl;
                            this.rootClass.drawFunnel(mcChars, MovieClip(this.CHARS.addChild(spell)));
                        };
                        break;
                    default:
                        for each (avatar in spFX.avts)
                        {
                            cls = this.getClass(spFX.strl);
                            if (cls != null)
                            {
                                spell = new (cls)();
                                spell.spellDur = spellDur;
                                if (cmd != null)
                                {
                                    spell.transform = cmd.transform;
                                };
                                this.CHARS.addChild(spell);
                                spell.mouseEnabled = false;
                                spell.mouseChildren = false;
                                spell.visible = true;
                                spell.world = this.rootClass.world;
                                spell.strl = spFX.strl;
                                spell.tMC = avatar.pMC;
                                switch (spFX.fx)
                                {
                                    case "p":
                                        spell.x = avatar1.pMC.x;
                                        spell.y = (avatar1.pMC.y - (avatar1.pMC.mcChar.height * 0.5));
                                        spell.dir = (((avatar.pMC.x - avatar1.pMC.x) >= 0) ? 1 : -1);
                                        break;
                                    case "w":
                                        spell.x = spell.tMC.x;
                                        spell.y = (spell.tMC.y + 3);
                                        if (avatar1 != null)
                                        {
                                            if (spell.tMC.x < avatar1.pMC.x)
                                            {
                                                spell.scaleX = (spell.scaleX * -1);
                                            };
                                        };
                                        break;
                                };
                            };
                        };
                };
            };
        }

        public function showSpellFXHit(spellInfo:Object):void
        {
            var newSpellInfo:Object = {
                "fx":"w",
                "avts":[spellInfo.tMC.pAV]
            };
            switch (spellInfo.strl)
            {
                case "sp_ice1":
                    newSpellInfo.strl = "sp_ice2";
                    break;
                case "sp_el3":
                    newSpellInfo.strl = "sp_el2";
                    break;
                case "sp_ed3":
                    newSpellInfo.strl = "sp_ed1";
                    break;
                case "sp_ef1":
                case "sp_ef6":
                    newSpellInfo.strl = "sp_ef2";
                    break;
            };
            newSpellInfo.fx = "w";
            newSpellInfo.avts = [spellInfo.tMC.pAV];
            this.castSpellFX(null, newSpellInfo, null);
        }

        public function doCastIA(_arg1:Object):void
        {
        }

        public function getActionByActID(actID:Number):Skill
        {
            var action:Skill;
            for each (action in this.actions.active)
            {
                if (action.actID == actID)
                {
                    return (action);
                };
            };
            return (null);
        }

        public function getActionByRef(reference:String):Skill
        {
            var action:Skill;
            var action2:Skill;
            for each (action in this.actions.active)
            {
                if (action.ref == reference)
                {
                    return (action);
                };
            };
            for each (action2 in this.actions.passive)
            {
                if (action2.ref == reference)
                {
                    return (action2);
                };
            };
            return (null);
        }

        public function handleSAR(data:Object):void
        {
            var aR:Object;
            var targetType:String;
            var targetID:int;
            var actionResult2:Object;
            if (data.iRes == 1)
            {
                aR = this.rootClass.copyObj(data.actionResult);
                if (data.actionResult.typ == "d")
                {
                    this.showAuraImpact(data.actionResult);
                }
                else
                {
                    this.aggroMap(data.actionResult.cInf, data.actionResult.tInf, (data.actionResult.hp >= 0));
                    targetType = data.actionResult.cInf.split(":")[0];
                    targetID = int(data.actionResult.cInf.split(":")[1]);
                    actionResult2 = aR;
                    actionResult2.a = [aR];
                    if (((targetType == "p") && (targetID == this.rootClass.network.myUserId)))
                    {
                        this.showActionResult(actionResult2, actionResult2.actID);
                    }
                    else
                    {
                        this.showIncomingAttackResult(actionResult2);
                    };
                };
            };
            if (((data.iRes == 0) && (data.actionResult.cInf.split(":")[0] === "p")))
            {
                this.showActionResult(null, data.actID);
            };
        }

        public function handleSARS(sarsa:Object):void
        {
            var i:int;
            var aElement:Object;
            var _local3:String = sarsa.cInf.split(":")[0];
            var _local4:int = int(sarsa.cInf.split(":")[1]);
            if (sarsa.iRes == 1)
            {
                i = 0;
                while (i < sarsa.a.length)
                {
                    aElement = sarsa.a[i];
                    this.aggroMap(sarsa.cInf, aElement.tInf, (aElement.hp >= 0));
                    i++;
                };
                if (((_local3 == "p") && (_local4 == this.rootClass.network.myUserId)))
                {
                    this.showActionResult(this.rootClass.copyObj(sarsa), sarsa.actID);
                }
                else
                {
                    this.showIncomingAttackResult(this.rootClass.copyObj(sarsa));
                };
            };
            if (sarsa.iRes == 0)
            {
                switch (sarsa.cInf.split(":")[0])
                {
                    case "p":
                        this.showActionResult(null, sarsa.actID);
                        return;
                };
            };
        }

        public function getActionResult(action:Skill, _arg2:Array):void
        {
            var i:int;
            var avatar:Avatar;
            var ii:int;
            var _local9:MovieClip;
            var _local3:Array = [];
            var _local5:String = "";
            _local3.push(this.actionID);
            if (_arg2.length > 0)
            {
                i = 0;
                while (i < _arg2.length)
                {
                    if (i > 0)
                    {
                        _local5 = (_local5 + ",");
                    };
                    _local5 = (_local5 + (action.ref + ">"));
                    avatar = _arg2[i].avt;
                    switch (avatar.npcType)
                    {
                        case "monster":
                            _local5 = (_local5 + ("m:" + avatar.objData.MonMapID));
                            break;
                        case "npc":
                            _local5 = (_local5 + ("n:" + avatar.objData.NpcMapID));
                            break;
                        case "player":
                            _local5 = (_local5 + ("p:" + avatar.uid));
                            break;
                    };
                    i = (i + 1);
                };
            }
            else
            {
                _local5 = (_local5 + (action.ref + ">"));
            };
            _local3.push(_local5);
            if (action.ref == "i1")
            {
                _local3.push(action.sArg1);
            };
            _local3.push("wvz");
            this.rootClass.network.send("gar", _local3);
            if (((!(this.map.getAction == null)) && (this.map.getAction)))
            {
                try
                {
                    this.map.sendAction(action.ref);
                }
                catch(e:Error)
                {
                    if (Config.isDebug)
                    {
                        trace(("world 15 " + e));
                    };
                };
            };
            action.lock = true;
            action.actID = this.actionID;
            this.actionID++;
            if (this.actionID > this.actionIDLimit)
            {
                this.actionID = 0;
            };
            action.lastTS = action.ts;
            action.ts = new Date().getTime();
            if (action.typ != "aa")
            {
                this.coolDownAct(action);
                this.globalCoolDownExcept(action);
                if (((!(this.autoActionTimer.running)) && (action.tgt == "h")))
                {
                    this.combatAction(this.getAutoAttack());
                };
            }
            else
            {
                ii = 0;
                while (ii < this.actionMap.length)
                {
                    if (this.actionMap[ii] == action.ref)
                    {
                        _local9 = MovieClip(this.rootClass.ui.mcInterface.actBar.getChildByName(("i" + (ii + 1))));
                        if (_local9.bg.currentLabel != "pulse")
                        {
                            _local9.bg.gotoAndPlay("pulse");
                        };
                    };
                    ii = (ii + 1);
                };
                this.actionReady = false;
            };
            this.actionResults[this.actionResultID] = {};
        }

        public function showActionResult(data:Object, actID:Number):void
        {
            var time:Number;
            var hasteFinal:Number;
            var hasteFinalFinal:Number;
            var timeTS:int;
            var action:Skill = this.getActionByActID(actID);
            if (action != null)
            {
                time = new Date().getTime();
                action.lock = false;
                action.actID = -1;
                if (action.typ == "aa")
                {
                    hasteFinal = Math.round((action.cd * this.myAvatar.haste));
                    hasteFinalFinal = (hasteFinal - int((time - action.ts)));
                    if (hasteFinalFinal > hasteFinal)
                    {
                        hasteFinalFinal = hasteFinal;
                    };
                    if (hasteFinalFinal < (hasteFinal - 100))
                    {
                        hasteFinalFinal = (hasteFinal - 100);
                    };
                    this.autoActionTimer.delay = hasteFinalFinal;
                    this.autoActionTimer.reset();
                    this.autoActionTimer.start();
                };
                if (data == null)
                {
                    action.ts = action.lastTS;
                }
                else
                {
                    timeTS = int(int(((time - action.ts) / 2)));
                    action.ts = Math.max(int((time - timeTS)), (action.ts + this.minLatencyOneWay));
                    this.unlockActionsExcept(action);
                    this.rootClass.updateActionObjIcon(action);
                };
            };
            if (data != null)
            {
                this.playActionSound(data);
                if (data.type != "none")
                {
                    this.actionResults[this.actionResultID] = new ActionImpactTimer();
                    this.actionResults[this.actionResultID].actionResult = data;
                    this.actionResults[this.actionResultID].showImpact(250);
                    if (++this.actionResultID > this.actionResultIDLimit)
                    {
                        this.actionResultID = 0;
                    };
                };
            };
        }

        public function showIncomingAttackResult(_arg1:Object):void
        {
            this.playActionSound(_arg1);
            this.actionResultsMon[this.actionIDMon] = new ActionImpactTimer();
            this.actionResultsMon[this.actionIDMon].actionResult = _arg1;
            this.actionResultsMon[this.actionIDMon].showImpact(350);
            this.actionIDMon++;
            if (this.actionIDMon > this.actionIDLimitMon)
            {
                this.actionIDMon = 0;
            };
        }

        public function playActionSound(data:Object):void
        {
            var a:Object;
            if (((data.a.length > 0) && (!(data.a[0].type == null))))
            {
                a = data.a[0];
                switch (a.type)
                {
                    case "hit":
                        this.rootClass.mixer.playSound(((a.hp >= 0) ? ((Math.random() < 0.5) ? "Hit1" : "Hit2") : "Heal"));
                        return;
                    case "crit":
                        this.rootClass.mixer.playSound(((a.hp >= 0) ? "Hit3" : "Heal"));
                        return;
                    case "miss":
                        this.rootClass.mixer.playSound("Miss");
                        return;
                    case "none":
                        this.rootClass.mixer.playSound("Good");
                        return;
                };
            };
        }

        public function showActionImpact(actionResult:Object):void
        {
            var value:Object;
            var targetID:int;
            var avatar:AbstractAvatarMC;
            var display:MovieClip;
            var damageDisplay:String;
            var i:uint;
            while (i < actionResult.a.length)
            {
                value = actionResult.a[i];
                targetID = int(value.tInf.split(":")[1]);
                switch (value.tInf.split(":")[0])
                {
                    case "p":
                        avatar = AbstractAvatarMC(this.avatars[targetID].pMC);
                        if (((avatar == this.myAvatar.pMC) && (Game.root.userPreference.data.combatHideSelfDamage)))
                        {
                            return;
                        };
                        if (((!(avatar == this.myAvatar.pMC)) && (Game.root.userPreference.data.combatHideOthersDamage)))
                        {
                            return;
                        };
                        break;
                    case "m":
                        avatar = AbstractAvatarMC(this.getMonster(targetID).pMC);
                        if (Game.root.userPreference.data.combatHideMonstersDamage)
                        {
                            return;
                        };
                        break;
                    case "n":
                        avatar = AbstractAvatarMC(this.getNpc(targetID).pMC);
                        if (Game.root.userPreference.data.combatHideNPCsDamage)
                        {
                            return;
                        };
                        break;
                };
                if ((((!(avatar == null)) && (!(avatar.pAV == null))) && (!(avatar.pAV.dataLeaf == null))))
                {
                    display = null;
                    damageDisplay = value.hp;
                    switch (value.type)
                    {
                        case "hit":
                            display = new hitDisplay();
                            display.t.ti.autoSize = "center";
                            if (Game.root.userPreference.data.combatShowCommaDamageDisplay)
                            {
                                damageDisplay = MainController.formatNumber(value.hp);
                            };
                            if (!Game.root.userPreference.data.combatShowFullDamageDisplay)
                            {
                                damageDisplay = MainController.formatNumberWithSuffix(value.hp);
                            };
                            if (value.hp >= 0)
                            {
                                display.t.ti.text = damageDisplay;
                                display.t.ti.textColor = 0xFFFFFF;
                                display.t.ti.filters = [showActionImpactGlow1];
                                display.t.ti.setTextFormat(new TextFormat());
                            }
                            else
                            {
                                display.t.ti.text = (("+" + String(damageDisplay).replace("-", "")) + "+");
                                display.t.ti.textColor = 65450;
                            };
                            if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                            {
                                Game.spriteToBitmap(display.t);
                            };
                            this.wound(avatar, "damage");
                            break;
                        case "crit":
                            display = new critDisplay();
                            display.t.ti.autoSize = "center";
                            if (Game.root.userPreference.data.combatShowCommaDamageDisplay)
                            {
                                damageDisplay = MainController.formatNumber(value.hp);
                            };
                            if (!Game.root.userPreference.data.combatShowFullDamageDisplay)
                            {
                                damageDisplay = MainController.formatNumberWithSuffix(value.hp);
                            };
                            if (value.hp > 0)
                            {
                                display.t.ti.text = damageDisplay;
                                display.t.ti.textColor = 16750916;
                                display.t.ti.filters = [showActionImpactGlow2];
                            }
                            else
                            {
                                display.t.ti.text = (("+" + String(damageDisplay).replace("-", "")) + "+");
                                display.t.ti.textColor = 65450;
                            };
                            if (this.isMoveOK(avatar.pAV.dataLeaf))
                            {
                                avatar.queueAnim("Hit");
                            };
                            if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                            {
                                Game.spriteToBitmap(display.t);
                            };
                            this.wound(avatar, "damage");
                            break;
                        case "miss":
                            display = new avoidDisplay();
                            display.t.ti.text = "Miss!";
                            if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                            {
                                Game.spriteToBitmap(display.t);
                            };
                            break;
                        case "dodge":
                            display = new avoidDisplay();
                            display.t.ti.text = "Dodge!";
                            if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                            {
                                Game.spriteToBitmap(display.t);
                            };
                            if (this.isMoveOK(avatar.pAV.dataLeaf))
                            {
                                avatar.queueAnim("Dodge");
                            };
                            break;
                        case "block":
                            display = new avoidDisplay();
                            display.t.ti.text = "Block!";
                            if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                            {
                                Game.spriteToBitmap(display.t);
                            };
                            if (this.isMoveOK(avatar.pAV.dataLeaf))
                            {
                                avatar.queueAnim("Block");
                            };
                            break;
                        case "none":
                            break;
                    };
                    if (display != null)
                    {
                        avatar.addChild(display);
                        display.x = MovieClip(avatar).mcChar.x;
                        display.y = (avatar.pname.y + 10);
                    };
                };
                i++;
            };
        }

        public function showAuraImpact(actionResult:Object):void
        {
            var mc:MovieClip;
            var target:String;
            var id:int;
            var damageDisplay:String;
            var dot:dotDisplay;
            target = actionResult.tInf.split(":")[0];
            id = int(actionResult.tInf.split(":")[1]);
            if (target === "p")
            {
                if ((((!(this.avatars[id] == null)) && ("pMC" in this.avatars[id])) && (!(this.avatars[id].pMC == null))))
                {
                    mc = this.avatars[id].pMC;
                };
            }
            else
            {
                if ((((!(this.getMonster(id) == null)) && ("pMC" in this.getMonster(id))) && (!(this.getMonster(id).pMC == null))))
                {
                    mc = this.getMonster(id).pMC;
                };
            };
            if (mc != null)
            {
                if ((((target == "p") && (mc == this.myAvatar.pMC)) && (Game.root.userPreference.data.combatHideSelfDamageOverTime)))
                {
                    return;
                };
                if ((((target == "p") && (!(mc == this.myAvatar.pMC))) && (Game.root.userPreference.data.combatHideOthersDamageOverTime)))
                {
                    return;
                };
                if (((target == "m") && (Game.root.userPreference.data.combatHideMonstersDamageOverTime)))
                {
                    return;
                };
                if (((target == "n") && (Game.root.userPreference.data.combatHideNPCsDamageOverTime)))
                {
                    return;
                };
                damageDisplay = actionResult.hp;
                if (Game.root.userPreference.data.combatShowCommaOverTimeDisplay)
                {
                    damageDisplay = MainController.formatNumber(actionResult.hp);
                };
                if (Game.root.userPreference.data.combatShowAbbreviatedDoTDisplay)
                {
                    damageDisplay = MainController.formatNumberWithSuffix(actionResult.hp);
                };
                dot = new dotDisplay();
                dot.hpDisplay = damageDisplay;
                dot.init();
                mc.addChild(dot);
                dot.x = mc.mcChar.x;
                dot.y = (mc.pname.y + 10);
            };
        }

        public function showAuraChange(data:Object, targetAvatar:Avatar, dataLeaf:Object):void
        {
            var auras:Array;
            var filterIndex:int;
            var gap:int;
            var i:int;
            var targetChildren:int;
            var child:DisplayObject;
            var isOK:Boolean;
            var aura:Object;
            var existingAura:Object;
            var dateObj:Date;
            var actionDamage:auraDisplay;
            if (targetAvatar.pMC != null)
            {
                auras = undefined;
                gap = 1;
                if (data.auras != null)
                {
                    gap = data.auras.length;
                };
                targetChildren = targetAvatar.pMC.numChildren;
                i = 0;
                while (i < targetChildren)
                {
                    child = targetAvatar.pMC.getChildAt(i);
                    if ((((!(child == null)) && (!(child.toString() == null))) && (child.toString().indexOf("auraDisplay") > -1)))
                    {
                        child.y = (child.y - (int((child.height + 3)) * gap));
                    };
                    i++;
                };
                isOK = true;
                if (dataLeaf.auras == null)
                {
                    dataLeaf.auras = [];
                };
                if (dataLeaf.passives == null)
                {
                    dataLeaf.passives = [];
                };
                aura = {};
                existingAura = {};
                dateObj = new Date();
                actionDamage = null;
                switch (data.cmd)
                {
                    case "aura+":
                    case "aura++":
                    case "aura+p":
                        i = 0;
                        while (i < data.auras.length)
                        {
                            aura = data.auras[i];
                            aura.cLeaf = Game.root.copyObj(dataLeaf);
                            aura.passive = (data.cmd == "aura+p");
                            if (aura.passive)
                            {
                                dataLeaf.passives.push(aura);
                                return;
                            };
                            if (aura.t != null)
                            {
                                aura.ts = dateObj.getTime();
                            };
                            if (((((targetAvatar == this.myAvatar) || (targetAvatar == this.myAvatar.target)) || ((!(dataLeaf.targets == null)) && (!(dataLeaf.targets[this.rootClass.network.myUserId] == null)))) || (data.cmd == "aura++")))
                            {
                                actionDamage = new auraDisplay();
                                actionDamage.visible = (!(data.isHidden));
                                actionDamage.t.ti.text = (aura.nam + "!");
                                targetAvatar.pMC.addChild(actionDamage);
                                actionDamage.x = ((targetAvatar.pMC.mcChar.scaleX < 0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                                actionDamage.y = ((targetAvatar.pMC.pname.y + 25) + ((actionDamage.height + 3) * i));
                                if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                                {
                                    Game.spriteToBitmap(actionDamage.t);
                                };
                                if (aura.fx != null)
                                {
                                    this.addAuraFX(AbstractAvatarMC(targetAvatar.pMC), aura.fx);
                                };
                            };
                            if ((((!(aura.s == null)) && (aura.s === "s")) && (!(targetAvatar.pMC.mcChar.currentLabel == "Fall"))))
                            {
                                AvatarMC(targetAvatar.pMC).clearQueue();
                                targetAvatar.pMC.mcChar.gotoAndPlay("Fall");
                            };
                            if (aura.cat != null)
                            {
                                isOK = true;
                                for each (existingAura in dataLeaf.auras)
                                {
                                    if (((!(existingAura.cat == null)) && (existingAura.cat == aura.cat)))
                                    {
                                        isOK = false;
                                    };
                                };
                                if (isOK)
                                {
                                    this.applyAuraCategory(aura, targetAvatar);
                                };
                            };
                            if (aura.isNew)
                            {
                                dataLeaf.auras.push(aura);
                            }
                            else
                            {
                                this.updateAuraData(dataLeaf, aura, dataLeaf);
                            };
                            i++;
                        };
                        return;
                    case "aura-":
                    case "aura--":
                        auras = [];
                        if (data.auras != null)
                        {
                            auras = data.auras;
                        }
                        else
                        {
                            if (data.aura != null)
                            {
                                auras = [data.aura];
                            };
                        };
                        i = 0;
                        while (i < auras.length)
                        {
                            aura = auras[i];
                            if (this.removeAura(aura, dataLeaf, AbstractAvatarMC(targetAvatar.pMC)))
                            {
                                if (((((targetAvatar == this.myAvatar) || (targetAvatar == this.myAvatar.target)) || ((!(dataLeaf.targets == null)) && (!(dataLeaf.targets[this.rootClass.network.myUserId] == null)))) || (data.cmd == "aura--")))
                                {
                                    actionDamage = new auraDisplay();
                                    actionDamage.visible = (!(data.isHidden));
                                    actionDamage.t.ti.text = (("*" + aura.nam) + " fades*");
                                    actionDamage.t.ti.textColor = 0x999999;
                                    if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                                    {
                                        Game.spriteToBitmap(actionDamage.t);
                                    };
                                    targetAvatar.pMC.addChild(actionDamage);
                                    actionDamage.x = ((targetAvatar.pMC.mcChar.scaleX < 0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                                    actionDamage.y = (targetAvatar.pMC.pname.y + 25);
                                };
                                if ((((((!(Game.root.userPreference.data["disableMonsterAnimation"])) && (!(aura.s == null))) && (aura.s === "s")) && (targetAvatar.pMC.mcChar.currentLabel == "Fall")) && (this.isStatusGone("s", dataLeaf))))
                                {
                                    targetAvatar.pMC.mcChar.gotoAndPlay("Getup");
                                };
                                if (aura.cat != null)
                                {
                                    isOK = true;
                                    for each (existingAura in dataLeaf.auras)
                                    {
                                        if (((!(existingAura.cat == null)) && (existingAura.cat == aura.cat)))
                                        {
                                            isOK = false;
                                        };
                                    };
                                    if (isOK)
                                    {
                                        this.removeAuraCategory(aura, targetAvatar);
                                    };
                                };
                            };
                            i++;
                        };
                        return;
                    case "aura*":
                        actionDamage = new auraDisplay();
                        actionDamage.t.ti.text = "* IMMUNE *";
                        actionDamage.t.ti.textColor = 16724273;
                        targetAvatar.pMC.addChild(actionDamage);
                        actionDamage.x = ((targetAvatar.pMC.mcChar.scaleX < 0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                        actionDamage.y = ((targetAvatar.pMC.pname.y + 25) + ((actionDamage.height + 3) * i));
                        if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                        {
                            Game.spriteToBitmap(actionDamage.t);
                        };
                        break;
                };
            };
        }

        public function removeAuraCategory(aura:Object, targetAvatar:Avatar):void
        {
            var tFilters:Array;
            var filterIndex:int;
            var filterLength:uint;
            var tFilter:*;
            var i2:int;
            var actObj:Skill;
            switch (aura.cat)
            {
                case "stun":
                    targetAvatar.pMC.mcChar.gotoAndPlay("Getup");
                    break;
                case "freeze":
                    AbstractAvatarMC(targetAvatar.pMC).modulateColor(statusFreezeCT, "-");
                    targetAvatar.pMC.mcChar.play();
                    break;
                case "invi":
                    targetAvatar.pMC.visible = true;
                    if (targetAvatar.petMC != null)
                    {
                        targetAvatar.petMC.visible = true;
                    };
                    break;
                case "paralyze":
                case "disabled":
                    targetAvatar.pMC.mcChar.play();
                    break;
                case "stone":
                    AbstractAvatarMC(targetAvatar.pMC).modulateColor(statusStoneCT, "-");
                    targetAvatar.pMC.mcChar.play();
                    break;
                case "color":
                    tFilters = targetAvatar.pMC.mcChar.filters;
                    filterIndex = 0;
                    filterLength = tFilters.length;
                    while (filterIndex < filterLength)
                    {
                        tFilter = tFilters[filterIndex];
                        if (((tFilter is GlowFilter) && (GlowFilter(tFilter).color == aura.val)))
                        {
                            tFilters.splice(filterIndex, 1);
                            filterIndex--;
                        };
                        filterIndex = (filterIndex + 1);
                    };
                    targetAvatar.pMC.mcChar.filters = tFilters;
                    break;
                case "skill_lock":
                    if (targetAvatar == this.myAvatar)
                    {
                        i2 = 0;
                        while (i2 < this.actions.active.length)
                        {
                            actObj = this.actions.active[i2];
                            if (((actObj.ref == aura.val) && (!(actObj.skillLock == null))))
                            {
                                actObj.skillLock.parent.removeChild(actObj.skillLock);
                                actObj.skillLock = null;
                                break;
                            };
                            i2++;
                        };
                    };
                    break;
            };
        }

        public function applyAuraCategory(aura:Object, targetAvatar:Avatar):void
        {
            var tFilters:Array;
            var i2:int;
            var actObj:Skill;
            var iLock:Sprite;
            switch (aura.cat)
            {
                case "s":
                case "stun":
                    targetAvatar.pMC.mcChar.gotoAndStop("Facepalm");
                    break;
                case "freeze":
                    AbstractAvatarMC(targetAvatar.pMC).modulateColor(statusFreezeCT, "+");
                    targetAvatar.pMC.mcChar.stop();
                    break;
                case "invi":
                    targetAvatar.pMC.visible = false;
                    if (targetAvatar.petMC != null)
                    {
                        targetAvatar.petMC.visible = false;
                    };
                    break;
                case "disabled":
                case "paralyze":
                    targetAvatar.pMC.mcChar.stop();
                    break;
                case "stone":
                    AbstractAvatarMC(targetAvatar.pMC).modulateColor(statusStoneCT, "+");
                    targetAvatar.pMC.mcChar.stop();
                    break;
                case "color":
                    tFilters = targetAvatar.pMC.mcChar.filters;
                    tFilters.push(new GlowFilter(aura.val, 1, 30, 30, 2, 2));
                    targetAvatar.pMC.mcChar.filters = tFilters;
                    break;
                case "skill_lock":
                    if (targetAvatar == this.myAvatar)
                    {
                        i2 = 0;
                        while (i2 < this.actions.active.length)
                        {
                            actObj = this.actions.active[i2];
                            if (((actObj.ref == aura.val) && (actObj.skillLock == null)))
                            {
                                iLock = new (this.getClass("iLock"))();
                                iLock.name = "lock";
                                iLock.x = 8;
                                iLock.y = 3.5;
                                iLock.width = 27;
                                iLock.height = 35.35;
                                actObj.skillLock = this.rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i2 + 1))).cnt.addChild(iLock);
                            };
                            i2++;
                        };
                    };
                    break;
            };
        }

        public function loadAuraByDataLeaf(dataLeaf:Object, targetAvatar:Avatar):void
        {
            var aura:Object;
            for each (aura in dataLeaf.auras)
            {
                if (((!(aura == null)) && (targetAvatar.pMC)))
                {
                    this.applyAuraCategory(aura, targetAvatar);
                };
            };
        }

        public function removeAuraByDataLeaf(dataLeaf:Object, targetAvatar:Avatar):void
        {
            var aura:Object;
            for each (aura in dataLeaf.auras)
            {
                if (((!(aura == null)) && (targetAvatar.pMC)))
                {
                    this.removeAuraCategory(aura, targetAvatar);
                };
                if (aura != null)
                {
                    trace("REMOVED");
                    this.removeAura(aura, dataLeaf, targetAvatar.pMC);
                };
            };
        }

        public function updateAuraData(cLeaf:Object, aura:Object, tLeaf:Object):void
        {
            var aura2:Object;
            for each (aura2 in tLeaf.auras)
            {
                if (((aura2.nam == aura.nam) && (aura2.cLeaf == cLeaf)))
                {
                    aura2.dur = aura.dur;
                    aura2.val = aura.val;
                };
            };
        }

        public function handleAuraEvent(cmd:String, data:Object):void
        {
            var cLeaf:Object;
            var tLeaf:Object;
            var cAvt:Avatar;
            var tAvt:Avatar;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            var forceAura:Boolean;
            if (this.rootClass.sfcSocial)
            {
                forceAura = ((cmd.indexOf("++") > -1) || (cmd.indexOf("--") > -1));
                cAvt = null;
                tAvt = null;
                if (data.cInf != null)
                {
                    cTyp = String(data.cInf.split(":")[0]);
                    cID = int(data.cInf.split(":")[1]);
                    switch (cTyp)
                    {
                        case "p":
                            cAvt = this.getAvatarByUserID(cID);
                            cLeaf = this.getUoLeafById(cID);
                            break;
                        case "m":
                            cAvt = this.getMonster(cID);
                            cLeaf = this.monTree[cID];
                            break;
                        case "n":
                            cAvt = this.getNpc(cID);
                            cLeaf = this.npcTree[cID];
                            break;
                    };
                };
                if (data.tInf != null)
                {
                    tTyp = String(data.tInf.split(":")[0]);
                    tID = int(data.tInf.split(":")[1]);
                    switch (tTyp)
                    {
                        case "p":
                            try
                            {
                                tAvt = this.getAvatarByUserID(tID);
                                tLeaf = this.getUoLeafById(tID);
                                if (((forceAura) || (tLeaf.strFrame == this.strFrame)))
                                {
                                    if (this.rootClass.sfcSocial)
                                    {
                                        this.showAuraChange(data, tAvt, tLeaf);
                                    };
                                }
                                else
                                {
                                    if ((((data.cmd == "aura-") || (data.cmd == "aura--")) && (!(tLeaf.strFrame == this.strFrame))))
                                    {
                                        this.removeAuraByDataLeaf(tLeaf, tAvt);
                                    };
                                };
                            }
                            catch(e:Error)
                            {
                                if (Config.isDebug)
                                {
                                    trace(("world 18 " + e));
                                };
                            };
                            return;
                        case "m":
                            try
                            {
                                tAvt = this.getMonster(tID);
                                tLeaf = this.monTree[tID];
                                if (((((forceAura) || (cLeaf == null)) || ((!(cLeaf.targets[tID] == null)) && (tLeaf.strFrame == this.strFrame))) && (this.rootClass.sfcSocial)))
                                {
                                    this.showAuraChange(data, tAvt, tLeaf);
                                };
                            }
                            catch(e:Error)
                            {
                                if (Config.isDebug)
                                {
                                    trace(("world 19 " + e));
                                };
                            };
                            return;
                        case "n":
                            try
                            {
                                tAvt = this.getNpc(tID);
                                tLeaf = this.npcTree[tID];
                                if (((((forceAura) || (cLeaf == null)) || ((!(cLeaf.targets[tID] == null)) && (tLeaf.strFrame == this.strFrame))) && (this.rootClass.sfcSocial)))
                                {
                                    this.showAuraChange(data, tAvt, tLeaf);
                                };
                            }
                            catch(e:Error)
                            {
                                if (Config.isDebug)
                                {
                                    trace(("world 19-2 " + e));
                                };
                            };
                            return;
                    };
                };
            };
        }

        public function removeAura(aura:Object, dataLeaf:Object, avatarMC:AbstractAvatarMC):Boolean
        {
            var isNotPassive:Boolean;
            var i:int;
            if (!this.rootClass.sfcSocial)
            {
                return (false);
            };
            isNotPassive = false;
            i = (dataLeaf.auras.length - 1);
            while (i >= 0)
            {
                if (dataLeaf.auras[i].nam == aura.nam)
                {
                    if (((avatarMC) && (dataLeaf.auras[i].fx)))
                    {
                        this.removeAuraFX(avatarMC, dataLeaf.auras[i].fx, "fade");
                    };
                    dataLeaf.auras.splice(i, 1);
                    isNotPassive = true;
                    break;
                };
                i--;
            };
            i = (dataLeaf.passives.length - 1);
            while (i >= 0)
            {
                if (dataLeaf.passives[i].nam == aura.nam)
                {
                    dataLeaf.passives.splice(i, 1);
                    isNotPassive = false;
                    break;
                };
                i--;
            };
            return (isNotPassive);
        }

        public function addAuraFX(pMC:AbstractAvatarMC, fx:String):void
        {
            var cls:Class;
            var effect:DisplayObject;
            if (pMC.fx.getChildByName(fx) == null)
            {
                cls = this.getClass(fx);
                if (cls != null)
                {
                    effect = pMC.fx.addChild(new (cls)());
                    effect.name = fx;
                    effect.y = -30;
                };
            };
        }

        public function removeAuraFX(avatarMC:AbstractAvatarMC, fxName:String, fxLabel:String=null):void
        {
            var fxMC:MovieClip;
            var inner:MovieClip;
            var i:int;
            inner = null;
            i = (avatarMC.fx.numChildren - 1);
            while (i >= 0)
            {
                fxMC = MovieClip(avatarMC.fx.getChildAt(i));
                if (((fxName == "all") || (fxMC.name == fxName)))
                {
                    if (fxLabel != null)
                    {
                        inner = MovieClip(fxMC.getChildByName("inner"));
                        if (inner != null)
                        {
                            inner.gotoAndPlay(fxLabel);
                        };
                    }
                    else
                    {
                        MovieClip(avatarMC.fx.removeChildAt(i)).stop();
                    };
                };
                i--;
            };
        }

        public function isStatusGone(status:String, dataLeaf:Object):Boolean
        {
            var aura:Object;
            for each (aura in dataLeaf.auras)
            {
                if (((!(aura.s == undefined)) && (aura.s === status)))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function isMoveOK(tLeaf:Object):Boolean
        {
            var aura:Object;
            if (tLeaf.auras != null)
            {
                for each (aura in tLeaf.auras)
                {
                    if (((!(aura.cat == undefined)) && ((((aura.cat === "stun") || (aura.cat === "stone")) || (aura.cat === "disabled")) || (aura.cat === "freeze"))))
                    {
                        return (false);
                    };
                };
            };
            return (true);
        }

        public function wound(_arg1:*, _arg2:*):*
        {
            var _local3:*;
            if (!Game.root.userPreference.data.enableTargetFlicker)
            {
                return;
            };
            if (_arg2 == "damage")
            {
                _local3 = new MovieClip();
                _local3.name = "flickermc";
                _local3.maxF = 3;
                _local3.curF = 0;
                _local3.addEventListener(Event.ENTER_FRAME, this.flickerFrame);
                if (_arg1.contains(_local3))
                {
                    _arg1.flickermc.removeEventListener(Event.ENTER_FRAME, this.flickerFrame);
                    _arg1.removeChild(_local3);
                };
                _arg1.addChild(_local3);
            };
        }

        public function unlockActionsExcept(action:Skill):void
        {
            var slot:Array;
            var _local4:*;
            var _local7:*;
            var action2:Skill;
            var i:int;
            slot = [];
            for each (action2 in this.actions.active)
            {
                if ((((!(action2.ref == action.ref)) && (action2.lock)) && (action2.ts < action.ts)))
                {
                    i = 0;
                    while (i < this.actionMap.length)
                    {
                        if (this.actionMap[i] == action.ref)
                        {
                            slot.push(("i" + (i + 1)));
                        };
                        i++;
                    };
                };
            };
            _local4 = 0;
            while (_local4 < slot.length)
            {
                _local7 = this.rootClass.ui.mcInterface.actBar.getChildByName(slot[_local4]);
                if (_local7.actObj != null)
                {
                    _local7.actObj.lock = false;
                };
                _local4++;
            };
        }

        public function unlockActions():*
        {
            var _local1:*;
            var _local2:*;
            _local1 = 0;
            while (_local1 < this.actions.active.length)
            {
                _local2 = this.actions.active[_local1];
                _local2.lock = false;
                _local1++;
            };
        }

        public function updateActBar():void
        {
            var child:*;
            var i:int;
            if ((((!(this.myAvatar == null)) && (!(this.myAvatar.dataLeaf == null))) && (!(this.myAvatar.dataLeaf.sta == null))))
            {
                i = 0;
                while (i < this.rootClass.ui.mcInterface.actBar.numChildren)
                {
                    child = MovieClip(this.rootClass.ui.mcInterface.actBar).getChildAt(i);
                    if (("actObj" in child))
                    {
                        if (((this.myAvatar.dataLeaf.intMP >= Math.round((Skill(child.actObj).mp * this.myAvatar.dataLeaf.sta["$cmc"]))) && (Skill(child.actObj).skillLock == null)))
                        {
                            if (child.cnt.alpha < 1)
                            {
                                child.cnt.alpha = 1;
                            };
                        }
                        else
                        {
                            if (child.cnt.alpha == 1)
                            {
                                child.cnt.alpha = 0.4;
                            };
                        };
                    };
                    i++;
                };
            };
        }

        public function getActIcons(action:Skill):Array
        {
            var _local2:Array;
            var _local4:*;
            var _local3:MovieClip;
            _local2 = [];
            _local4 = 0;
            while (_local4 < this.actionMap.length)
            {
                if (this.actionMap[_local4] == action.ref)
                {
                    _local3 = (this.rootClass.ui.mcInterface.actBar.getChildByName(("i" + (_local4 + 1))) as MovieClip);
                    if (_local3 != null)
                    {
                        _local2.push(_local3);
                    };
                };
                _local4++;
            };
            return (_local2);
        }

        public function globalCoolDownExcept(action:Skill):void
        {
            var time:Number;
            var action2:Skill;
            var _local3:MovieClip;
            time = new Date().getTime();
            for each (action2 in this.actions.active)
            {
                if (action2.isOK)
                {
                    _local3 = this.getActIcons(action2)[0];
                    if (_local3 != null)
                    {
                        try
                        {
                            if ((((!(action2 == action)) && (!(action2.ref == "aa"))) && (((!("icon2" in _local3)) || (_local3.icon2 == null)) || (((action2.ts + action2.cd) > time) && (((action2.ts + action2.cd) - time) < this.GCD)))))
                            {
                                this.coolDownAct(action2, this.GCD, time);
                            };
                        }
                        catch(e:Error)
                        {
                            if (Config.isDebug)
                            {
                                trace(("world 23 " + e));
                            };
                        };
                    };
                };
            };
            this.GCDTS = time;
        }

        public function coolDownAct(action:Skill, cd:int=-1, ts:Number=-1):void
        {
            var icon:MovieClip;
            var icon2:*;
            var actBarChild:MovieClip;
            var bitmapData:BitmapData;
            var iconFlare_:DisplayObject;
            for each (icon in this.getActIcons(action))
            {
                icon2 = null;
                actBarChild = null;
                if (icon.icon2 == null)
                {
                    bitmapData = new BitmapData(50, 50, true, 0);
                    bitmapData.draw(icon, null, this.iconCT);
                    icon2 = this.rootClass.ui.mcInterface.actBar.addChild(new Bitmap(bitmapData));
                    icon.icon2 = icon2;
                    if (cd == -1)
                    {
                        iconFlare_ = this.rootClass.ui.mcInterface.actBar.addChild(new iconFlare());
                        icon2.transform = (iconFlare_.transform = icon.transform);
                        icon.ts = action.ts;
                        icon.cd = action.cd;
                    }
                    else
                    {
                        icon2.transform = icon.transform;
                        icon.ts = ts;
                        icon.cd = cd;
                    };
                    actBarChild = this.rootClass.ui.mcInterface.actBar.addChild(new ActMask());
                    actBarChild.scaleX = 0.33;
                    actBarChild.scaleY = 0.33;
                    actBarChild.x = int(((icon2.x + (icon2.width >> 1)) - (actBarChild.width >> 1)));
                    actBarChild.y = int(((icon2.y + (icon2.height >> 1)) - (actBarChild.height >> 1)));
                    actBarChild.e0oy = actBarChild.e0.y;
                    actBarChild.e1oy = actBarChild.e1.y;
                    actBarChild.e2oy = actBarChild.e2.y;
                    actBarChild.e3oy = actBarChild.e3.y;
                    icon2.mask = actBarChild;
                }
                else
                {
                    icon2 = icon.icon2;
                    actBarChild = icon2.mask;
                    if (cd == -1)
                    {
                        icon.ts = action.ts;
                        icon.cd = action.cd;
                    }
                    else
                    {
                        icon.ts = ts;
                        icon.cd = cd;
                    };
                };
                actBarChild.e0.stop();
                actBarChild.e1.stop();
                actBarChild.e2.stop();
                actBarChild.e3.stop();
                icon.removeEventListener(Event.ENTER_FRAME, this.countDownAct);
                icon.addEventListener(Event.ENTER_FRAME, this.countDownAct, false, 0, true);
            };
        }

        public function acceptQuest(questId:int, isRetrieve:Boolean=false, isBot:Boolean=false):void
        {
            var qTrackerMC:QTrackerMC;
            var questPopup:QFrameMC;
            if (isRetrieve)
            {
                if (this.questTree[questId] == null)
                {
                    this.getQuests([questId]);
                };
                qTrackerMC = QTrackerMC(this.rootClass.ui.mcQTracker);
                if (this.questTree[questId].status == null)
                {
                    this.questTree[questId].status = "p";
                    qTrackerMC.updateQuest();
                };
                if (!qTrackerMC.visible)
                {
                    qTrackerMC.toggle();
                };
                questPopup = QFrameMC(UIController.getByName("quest_frame"));
                if (questPopup != null)
                {
                    questPopup.cnt.gotoAndPlay("back");
                };
                return;
            };
            this.rootClass.network.send("acceptQuest", [questId, isBot]);
        }

        public function tryQuestComplete(questId:int, choiceId:int=-1, ignored:Boolean=false, multiple:int=1):void
        {
            this.rootClass.network.send("tryQuestComplete", [questId, choiceId, multiple]);
        }

        public function tryQuestCompleteMulti(params:Object):void
        {
            var multiple:int;
            if (params.accept)
            {
                multiple = 1;
                if (params.iQty != null)
                {
                    multiple = params.iQty;
                };
                this.tryQuestComplete(params.questId, params.choiceId, false, multiple);
            };
        }

        public function getMapItem(_arg1:int):void
        {
            if (this.coolDown("getMapItem"))
            {
                this.rootClass.network.send("getMapItem", [_arg1]);
            };
        }

        public function isQuestInProgress(_arg1:int):Boolean
        {
            return ((!(this.questTree[_arg1] == null)) && (!(this.questTree[_arg1].status == null)));
        }

        public function getQuests(quests:Array):void
        {
            this.rootClass.network.send("getQuests", quests);
        }

        public function showQuestList(mode:String, quest1:String, quest2:String):void
        {
            var questPopup:QFrameMC;
            var questArr1:Array;
            var questArr2:Array;
            var quests:Array;
            var i:int;
            var quest:String;
            if (!this.rootClass.isGreedyModalInStack())
            {
                this.rootClass.clearPopupsQ();
                questPopup = QFrameMC(UIController.getByNameOrShow("quest_frame"));
                questArr1 = quest1.split(",");
                questArr2 = quest2.split(",");
                questPopup.sIDs = questArr1;
                questPopup.tIDs = questArr2;
                questPopup.world = this;
                questPopup.game = this.rootClass;
                questPopup.qMode = mode;
                quests = [];
                i = 0;
                while (i < questArr1.length)
                {
                    quest = questArr1[i];
                    if (this.questTree[quest] == null)
                    {
                        quests.push(quest);
                    }
                    else
                    {
                        if (this.questTree[quest].strDynamic != null)
                        {
                            this.questTree[quest] = null;
                            delete this.questTree[quest];
                            quests.push(quest);
                        };
                    };
                    i++;
                };
                if (((quests.length > 0) && (!(quest1 == ""))))
                {
                    this.getQuests(quests);
                }
                else
                {
                    questPopup.open();
                };
            };
        }

        public function getApop(_arg1:String):void
        {
            var _local2:Object;
            var _local3:*;
            var _local4:Object;
            var _local5:uint;
            var _local6:Array;
            var _local7:uint;
            if (int(_arg1) < 1)
            {
                return;
            };
            if (this.rootClass.curID != _arg1)
            {
                this.rootClass.curID = _arg1;
                this.rootClass.network.send("getApop", [_arg1]);
                return;
            };
            _local2 = this.rootClass.apopTree[_arg1];
            _local3 = [];
            _local5 = 0;
            while (_local5 < _local2.arrScenes.length)
            {
                _local4 = _local2.arrScenes[_local5];
                if (_local4.qID == null)
                {
                    if (_local4.arrQuests != null)
                    {
                        _local6 = String(_local4.arrQuests).split(",");
                        _local7 = 0;
                        while (_local7 < _local6.length)
                        {
                            if (this.questTree[_local6[_local7]] == null)
                            {
                                _local3.push(_local6[_local7]);
                                this.rootClass.quests = true;
                            }
                            else
                            {
                                if (this.questTree[_local6[_local7]].strDynamic != null)
                                {
                                    this.questTree[_local6[_local7]] = null;
                                    delete this.questTree[_local6[_local7]];
                                    _local3.push(_local6[_local7]);
                                    this.rootClass.quests = true;
                                };
                            };
                            _local7++;
                        };
                    };
                }
                else
                {
                    if (this.questTree[_local4.qID] == null)
                    {
                        _local3.push(_local4.qID);
                        this.rootClass.quests = true;
                    }
                    else
                    {
                        if (this.questTree[_local4.qID].strDynamic != null)
                        {
                            this.questTree[_local4.qID] = null;
                            delete this.questTree[_local4.qID];
                            _local3.push(_local4.qID);
                            this.rootClass.quests = true;
                        };
                    };
                };
                _local5++;
            };
            if (_local3.length > 0)
            {
                this.rootClass.quests = true;
                this.rootClass.network.send("getQuests2", _local3);
            }
            else
            {
                this.rootClass.quests = false;
                this.rootClass.createApop();
            };
        }

        public function showQuests(_arg1:String, _arg2:String):void
        {
            this.showQuestList(_arg2, _arg1, _arg1);
        }

        public function showQuestLink(_arg1:Object):void
        {
            var _local4:String;
            _local4 = "";
            if (_arg1.unm.toLowerCase() != this.rootClass.network.myUserName)
            {
                _local4 = (_local4 + ((_arg1.unm + " issues a Call to Arms for ") + Chat.openTag));
                _local4 = (_local4 + ["quest", _arg1.quest.sName, _arg1.quest.QuestID, _arg1.quest.iLvl, _arg1.unm].toString());
                _local4 = (_local4 + (Chat.closeTag + "!"));
            }
            else
            {
                _local4 = (_local4 + (("You issue a Call to Arms for " + _arg1.quest.sName) + "!"));
            };
            this.rootClass.chatF.pushMsg("event", _local4, "SERVER", "", 0);
        }

        public function getActiveQuests():String
        {
            var _local1:String;
            var _local2:*;
            var _local3:*;
            _local1 = "";
            for (_local2 in this.questTree)
            {
                _local3 = this.questTree[_local2];
                if (_local3.status != null)
                {
                    if (_local1.length)
                    {
                        _local1 = (_local1 + ("," + _local2));
                    }
                    else
                    {
                        _local1 = (_local1 + _local2);
                    };
                };
            };
            return (_local1);
        }

        public function checkAllQuestStatus(_arg1:*=null):*
        {
            var _local2:Array;
            var _local3:String;
            var _local4:*;
            var _local5:*;
            var _local6:*;
            var _local7:int;
            var _local8:*;
            var _local9:*;
            var _local10:*;
            _local2 = [];
            if (_arg1 != null)
            {
                _local2 = [String(_arg1)];
            }
            else
            {
                for (_local3 in this.questTree)
                {
                    _local2.push(_local3);
                };
            };
            for each (_local3 in _local2)
            {
                _local4 = this.questTree[_local3];
                _local5 = {};
                if (_local4.status != null)
                {
                    if (((!(_local4.turnin == null)) && (_local4.turnin.length > 0)))
                    {
                        _local5.sItems = true;
                        _local7 = 0;
                        while (_local7 < _local4.turnin.length)
                        {
                            _local8 = _local4.turnin[_local7].ItemID;
                            _local9 = _local4.turnin[_local7].iQty;
                            if (((this.invTree[_local8] == null) || (this.invTree[_local8].iQty < _local9)))
                            {
                                _local5.sItems = false;
                                break;
                            };
                            _local7++;
                        };
                    };
                    if (_local4.iTime != null)
                    {
                        _local5.iTime = false;
                        if (_local4.ts != null)
                        {
                            _local10 = new Date();
                            if ((_local10.getTime() - _local4.ts) <= _local4.iTime)
                            {
                                _local5.iTime = true;
                            };
                        };
                    };
                    _local4.status = "c";
                    for (_local6 in _local5)
                    {
                        if (!_local5[_local6])
                        {
                            _local4.status = "p";
                        };
                    };
                };
            };
            this.rootClass.ui.mcQTracker.updateQuest();
        }

        public function updateQuestProgress(questType:String, item:Object):void
        {
            var questTreeKey:String;
            var quest:Object;
            var i:int;
            var itemTurn:Object;
            for (questTreeKey in this.questTree)
            {
                quest = this.questTree[questTreeKey];
                if (((!(quest.status == null)) && (quest.status == "p")))
                {
                    if (((questType == "item") && (!(quest.turnin == null))))
                    {
                        i = 0;
                        while (i < quest.turnin.length)
                        {
                            itemTurn = quest.turnin[i];
                            if (((((item.ItemID == itemTurn.ItemID) && (!(this.invTree[itemTurn.ItemID] == null))) && (this.invTree[itemTurn.ItemID].iQty <= itemTurn.iQty)) && (!(Game.root.userPreference.data.questProgressNotification))))
                            {
                                this.rootClass.addUpdate(((((((quest.sName + ": ") + this.invTree[itemTurn.ItemID].sName) + " ") + this.invTree[itemTurn.ItemID].iQty) + "/") + itemTurn.iQty));
                            };
                            i++;
                        };
                    };
                    if (quest.status == "c")
                    {
                        if (!Game.root.userPreference.data.questProgressNotification)
                        {
                            this.rootClass.addUpdate((quest.sName + " complete!"));
                        };
                        this.rootClass.mixer.playSound("Good");
                    };
                };
                this.checkAllQuestStatus(questTreeKey);
            };
        }

        public function canTurnInQuest(questId:int, multiple:int=1):Boolean
        {
            var quest:*;
            var i:int;
            var itemId:int;
            var itemQty:int;
            quest = this.questTree[questId];
            if (((!(quest.turnin == null)) && (quest.turnin.length > 0)))
            {
                i = 0;
                while (i < quest.turnin.length)
                {
                    itemId = quest.turnin[i].ItemID;
                    itemQty = (quest.turnin[i].iQty * multiple);
                    if (((this.invTree[itemId] == null) || (this.invTree[itemId].iQty < itemQty)))
                    {
                        return (false);
                    };
                    if (this.myAvatar.isItemEquipped(itemId))
                    {
                        this.rootClass.MsgBox.notify("Cannot turn in equipped item(s)!");
                        return (false);
                    };
                    i++;
                };
            };
            return (true);
        }

        public function quantityToTurn(questId:int):int
        {
            var quest:*;
            var quantityTurn:int;
            var j:int;
            var i:int;
            var itemId:int;
            var itemQty:int;
            var item:*;
            quest = this.questTree[questId];
            quantityTurn = 0;
            if (((!(quest.turnin == null)) && (quest.turnin.length > 0)))
            {
                j = 1;
                while (j < 250)
                {
                    i = 0;
                    while (i < quest.turnin.length)
                    {
                        itemId = quest.turnin[i].ItemID;
                        itemQty = (quest.turnin[i].iQty * j);
                        item = this.invTree[itemId];
                        if (((item == null) || (item.iQty < itemQty)))
                        {
                            return (quantityTurn);
                        };
                        i++;
                    };
                    quantityTurn++;
                    j++;
                };
            };
            return (quantityTurn);
        }

        public function completeQuest(questID:int):void
        {
            if (this.questTree[questID] != null)
            {
                this.questTree[questID].status = null;
                this.rootClass.ui.mcQTracker.updateQuest();
            };
        }

        public function toggleQuestLog():void
        {
            var questPopup:QFrameMC;
            questPopup = QFrameMC(UIController.getByName("quest_frame"));
            if (questPopup == null)
            {
                this.showQuests("", "l");
            }
            else
            {
                questPopup.open();
            };
        }

        public function doCTAAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("gp", ["ctaa", _arg1.unm]);
                this.showQuests(_arg1.QuestID, "q");
            };
        }

        public function _SafeStr_1(_arg1:*):*
        {
            var _local2:*;
            var _local3:*;
            _arg1 = _arg1.toLowerCase();
            _local2 = this.uoTree[this.rootClass.network.myUserName];
            _local3 = this.uoTree[String(_arg1).toLowerCase()];
            if (((_local2.intState == 1) && ((_local2.pvpTeam == null) || (_local2.pvpTeam == -1))))
            {
                if (((!(_local3 == null)) && (!(_local2.uoName == _local3.uoName))))
                {
                    if ((("nogoto" in this.map) && (this.map.nogoto)))
                    {
                        this.rootClass.chatF.pushMsg("warning", "/goto can't target players within this map.", "SERVER", "", 0);
                        return;
                    };
                    if (_local2.strFrame != _local3.strFrame)
                    {
                        this.moveToCell(_local3.strFrame, _local3.strPad);
                    };
                }
                else
                {
                    this.rootClass.network.send("cmd", ["goto", _arg1]);
                };
            };
        }

        public function pull(_arg1:String):void
        {
            _arg1 = _arg1.toLowerCase();
            this.rootClass.network.send("cmd", ["pull", _arg1]);
        }

        public function requestFriend(_arg1:String):void
        {
            this.rootClass.network.send("requestFriend", [_arg1]);
        }

        public function addFriend(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("addFriend", [_arg1.unm]);
            }
            else
            {
                this.rootClass.network.send("declineFriend", [_arg1.unm]);
            };
        }

        public function deleteFriend(_arg1:int, _arg2:String):void
        {
            this.rootClass.network.send("deleteFriend", [_arg1, _arg2]);
        }

        public function declareAlliance(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["declareAlliance", _arg1]);
        }

        public function guildInvite(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["gi", _arg1]);
        }

        public function guildRemove(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("guild", ["gr", _arg1.userName]);
            };
        }

        public function guildKick(players:Array):void
        {
            if (players.accept)
            {
                this.rootClass.network.send("guild", players);
            };
        }

        public function guildPromote(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["gp", _arg1]);
        }

        public function guildDemote(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["gd", _arg1]);
        }

        public function doGuildAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("guild", ["ga", _arg1.guildID, _arg1.owner]);
            }
            else
            {
                this.rootClass.network.send("guild", ["gdi", _arg1.guildID, _arg1.owner]);
            };
        }

        public function setGuildMOTD(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["motd", _arg1]);
        }

        public function setGuildDescription(description:String):void
        {
            this.rootClass.network.send("guild", ["guildDescription", description]);
        }

        public function createGuild(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("guild", ["gc", _arg1.guildName]);
            };
        }

        public function addMemSlots(quantity_obj:Object):void
        {
            var quantity:int;
            quantity = quantity_obj.quantity;
            if (quantity_obj.accept)
            {
                this.rootClass.network.send("guild", ["slots", quantity]);
            };
        }

        public function renameGuild(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("guild", ["rename", _arg1.guildName]);
            };
        }

        public function requestPVPQueue(_arg1:String, _arg2:int=-1):void
        {
            this.rootClass.network.send("PVPQr", [_arg1, _arg2]);
        }

        public function handlePVPQueue(_arg1:Object):void
        {
            var _local2:MovieClip;
            if (_arg1.bitSuccess == 1)
            {
                this.PVPQueue.warzone = _arg1.warzone;
                this.PVPQueue.ts = new Date().getTime();
                this.PVPQueue.avgWait = _arg1.avgWait;
                this.rootClass.showMCPVPQueue();
            }
            else
            {
                this.PVPQueue.warzone = "";
                this.PVPQueue.ts = -1;
                this.PVPQueue.avgWait = -1;
                this.rootClass.hideMCPVPQueue();
            };
            _local2 = this.rootClass.ui.mcPopup;
            if (((_local2.currentLabel == "PVPPanel") && (!(_local2.mcPVPPanel == null))))
            {
                _local2.mcPVPPanel.updateBody();
            };
            this.rootClass.closeModalByStrBody("A new Warzone battle has started!");
        }

        public function updatePVPAvgWait(_arg1:int):void
        {
            this.PVPQueue.avgWait = _arg1;
        }

        public function duelExpire():*
        {
            this.rootClass.closeModalByStrBody("has challenged you to a duel.");
        }

        public function receivePVPInvite(data:Object):void
        {
            this.rootClass.mixer.playSound("PvPPopup");
            MainController.modal((("A new War zone battle has started!\nWill you join " + this.getWarZoneByWarZoneName(data.warzone).nam) + "?"), this.replyToPVPInvite, {}, null, "dual", true);
            mcPopup_323(this.rootClass.ui.mcPopup).onClose();
            this.rootClass.hideMCPVPQueue();
        }

        public function replyToPVPInvite(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.sendPVPInviteAccept();
            }
            else
            {
                this.sendPVPInviteDecline();
            };
        }

        public function sendPVPInviteAccept():void
        {
            this.rootClass.network.send("PVPIr", ["1"]);
        }

        public function sendPVPInviteDecline():void
        {
            this.rootClass.network.send("PVPIr", ["0"]);
        }

        public function sendDuelInvite(_arg1:String):void
        {
            this.rootClass.toggleBetPanel(_arg1);
        }

        public function doDuelAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("da", [_arg1.unm]);
            }
            else
            {
                this.rootClass.network.send("dd", [_arg1.unm]);
            };
        }

        public function doPsrAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("psra", [_arg1.unm]);
            }
            else
            {
                this.rootClass.network.send("psrd", [_arg1.unm]);
            };
        }

        public function updateGuildStatus(_arg1:int):void
        {
            this.rootClass.network.send("guild", ["updateGuildStatus", _arg1]);
        }

        public function acceptGuildAlliance(_arg1:int):void
        {
            this.rootClass.network.send("guild", ["allianceAccept", _arg1]);
        }

        public function declineGuildAlliance(_arg1:int):void
        {
            this.rootClass.network.send("guild", ["allianceDecline", _arg1]);
        }

        public function disbandGuildAlliance(_arg1:int):void
        {
            this.rootClass.network.send("guild", ["allianceDisband", _arg1]);
        }

        public function approveGuildRecruitment(_arg1:int):void
        {
            this.rootClass.network.send("guild", ["joinGuildAccept", _arg1]);
        }

        public function declineGuildRecruitment(_arg1:int):void
        {
            this.rootClass.network.send("guild", ["joinGuildDecline", _arg1]);
        }

        public function sendGuildWarInvite(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["guildWarDuel", _arg1]);
        }

        public function doGuildWarInvite(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("guild", ["guildWarAccept", _arg1.unm]);
            }
            else
            {
                this.rootClass.network.send("guild", ["guildWarDecline", _arg1.unm]);
            };
        }

        public function loadGuildList(_arg1:String, _arg2:int):void
        {
            this.rootClass.network.send("guild", ["loadGuildList", _arg1, _arg2]);
        }

        public function joinGuild(_arg1:String):void
        {
            this.rootClass.network.send("guild", ["joinGuild", _arg1]);
        }

        public function sendMarryInvite(_arg1:String):void
        {
            this.rootClass.network.send("marry", [_arg1]);
        }

        public function doMarryAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("ma", [_arg1.unm]);
            }
            else
            {
                this.rootClass.network.send("md", [_arg1.unm]);
            };
        }

        public function divorceMarry(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.network.send("marryDivorce", []);
            };
        }

        public function sendAdoptInvite(_arg1:String):void
        {
            this.rootClass.network.send("adi", [_arg1]);
        }

        public function doAdoptAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("ada", [_arg1.unm]);
            }
            else
            {
                this.rootClass.network.send("add", [_arg1.unm]);
            };
        }

        public function getWarzoneByName(_arg1:String):*
        {
            var _local2:int;
            _local2 = 0;
            while (_local2 < this.PVPMaps.length)
            {
                if (this.PVPMaps[_local2].nam == _arg1)
                {
                    return (this.PVPMaps[_local2]);
                };
                _local2++;
            };
            return (null);
        }

        public function getWarZoneByWarZoneName(_arg1:String):PvPMap
        {
            var map:PvPMap;
            for each (map in this.PVPMaps)
            {
                if (map.warzone == _arg1)
                {
                    return (map);
                };
            };
            return (null);
        }

        public function setPVPFactionData(_arg1:Array):void
        {
            if (_arg1 != null)
            {
                this.PVPFactions = _arg1;
            }
            else
            {
                this.PVPFactions = [];
            };
        }

        public function attachMovieFront(_arg1:*):MovieClip
        {
            var _local2:MovieClip;
            var _local3:Class;
            var _local4:*;
            var _local5:*;
            _local3 = (this.getClass(_arg1) as Class);
            _local4 = true;
            if (this.FG.numChildren)
            {
                _local2 = MovieClip(this.FG.getChildAt(0));
                _local5 = (_local2.constructor as Class);
                if (_local5 == _local3)
                {
                    _local4 = false;
                };
            };
            if (_local4)
            {
                this.removeMovieFront();
                _local2 = MovieClip(this.FG.addChild(new (_local3)()));
                this.FG.mouseChildren = true;
            };
            return (_local2);
        }

        public function attachMovieFrontMenu(_arg1:*):MovieClip
        {
            var _local2:MovieClip;
            var _local3:Class;
            var _local4:*;
            var _local5:*;
            _local3 = (this.getClass(_arg1) as Class);
            _local4 = true;
            if (this.FG.numChildren)
            {
                _local2 = MovieClip(this.FG.getChildAt(0));
                _local5 = (_local2.constructor as Class);
                if (_local5 == _local3)
                {
                    _local4 = false;
                };
            };
            if (_local4)
            {
                this.removeMovieFront();
                _local2 = MovieClip(this.FG.addChild(new (_local3)()));
                this.FG.mouseChildren = true;
            };
            return (_local2);
        }

        public function removeMovieFront():void
        {
            var _local1:int;
            _local1 = 0;
            while (((this.FG.numChildren > 0) && (_local1 < 100)))
            {
                _local1++;
                this.FG.removeChildAt(0);
            };
            this.rootClass.ldrMC.closeHistory();
            this.rootClass.stage.focus = null;
        }

        public function getMovieFront():*
        {
            if (((this.FG.numChildren > 0) && (!(this.FG.getChildAt(0) == null))))
            {
                return (this.FG.getChildAt(0));
            };
            return (null);
        }

        public function isMovieFront(_arg1:String):Boolean
        {
            var _local2:MovieClip;
            var _local3:Class;
            var _local4:*;
            var _local5:*;
            _local3 = (this.getClass(_arg1) as Class);
            _local4 = false;
            if (this.FG.numChildren)
            {
                _local2 = MovieClip(this.FG.getChildAt(0));
                _local5 = (_local2.constructor as Class);
                if (_local5 == _local3)
                {
                    _local4 = true;
                };
            };
            return (_local4);
        }

        public function loadMovieFront(_arg1:String, _arg2:String="Game Files"):void
        {
            this.removeMovieFront();
            this.rootClass.ldrMC.loadFile(this.FG, _arg1, _arg2);
        }

        public function toggleFPS():void
        {
            this.rootClass.ui.mcFPS.visible = (!(this.rootClass.ui.mcFPS.visible));
        }

        public function iaTrigger(_arg1:MovieClip):void
        {
            var args:Array;
            if (this.coolDown("doIA"))
            {
                args = [];
                args.push(_arg1.iaType);
                args.push(_arg1.name);
                if (("iaPathMC" in _arg1))
                {
                    args.push(this.myAvatar.dataLeaf.strFrame);
                }
                else
                {
                    args.push(_arg1.iaFrame);
                };
                if (("iaStr" in _arg1))
                {
                    args.push(_arg1.iaStr);
                };
                if (("iaPathMC" in _arg1))
                {
                    args.push(_arg1.iaPathMC);
                };
                this.rootClass.network.send("ia", args);
            };
        }

        public function actCastRequest(_arg1:Object):void
        {
            var _local2:Array;
            var _local3:Array;
            var _local4:Object;
            _local2 = ["castr"];
            _local3 = [];
            if (((_arg1.typ === "sia") && (this.coolDown("doIA"))))
            {
                _local4 = {};
                _local4.typ = "sia";
                _local4.callback = this.actCastTrigger;
                _local4.args = _arg1;
                _local4.dur = Number(_arg1.sAccessCD);
                _local4.txt = _arg1.sMsg;
                this.rootClass.ui.mcCastBar.fOpenWith(_local4);
                _local3.push(1);
                _local3.push(_arg1.ID);
            };
            if (_local3.length > 0)
            {
                this.rootClass.network.send(_local2.toString(), _local3);
            };
        }

        public function actCastTrigger(_arg1:Object):void
        {
            if (_arg1.typ === "sia")
            {
                this.siaTrigger(_arg1);
            };
        }

        public function siaTrigger(_arg1:Object):void
        {
            this.rootClass.network.send(["castt"].toString(), []);
        }

        public function uoTreeLeaf(_arg1:String):Object
        {
            if (this.uoTree[_arg1.toLowerCase()] == null)
            {
                this.uoTree[_arg1.toLowerCase()] = {};
            };
            return (this.uoTree[_arg1.toLowerCase()]);
        }

        public function myLeaf():Object
        {
            return (this.uoTreeLeaf(this.rootClass.network.myUserName));
        }

        public function uoTreeLeafSet(username:String, uoLeaf:Object):void
        {
            var uoTree:Object;
            var key:String;
            var avatar:Avatar;
            if (this.uoTree[username.toLowerCase()] == null)
            {
                this.uoTree[username.toLowerCase()] = {};
            };
            uoTree = this.uoTree[username.toLowerCase()];
            for (key in uoLeaf)
            {
                uoTree[key] = uoLeaf[key];
                avatar = this.getAvatarByUserName(username);
                if (((!(avatar == null)) && (!(avatar.objData == null))))
                {
                    avatar.objData[key] = uoLeaf[key];
                };
            };
        }

        public function manageAreaUser(_arg1:String, _arg2:String):void
        {
            var _local3:int;
            _arg1 = _arg1.toLowerCase();
            if (_arg2 == "+")
            {
                if (this.areaUsers.indexOf(_arg1) == -1)
                {
                    this.areaUsers.push(_arg1);
                };
            }
            else
            {
                _local3 = this.areaUsers.indexOf(_arg1);
                if (_local3 > -1)
                {
                    this.areaUsers.splice(_local3, 1);
                };
            };
            this.rootClass.updateAreaName();
            this.rootClass.discord.update("status");
        }

        public function setAllCloakVisibility():void
        {
            var arr:Array;
            var avatar:Avatar;
            arr = this.getUsersByCell(this.myAvatar.dataLeaf.strFrame);
            for each (avatar in arr)
            {
                if (!avatar.isMyAvatar)
                {
                    AvatarMC(avatar.pMC).setCloakVisibility(avatar.dataLeaf.showCloak);
                };
            };
        }

        public function setAllEntityVisibility():void
        {
            var isVisible:Boolean;
            var arr:Array;
            var avatar:Avatar;
            isVisible = (!(Game.root.userPreference.data.hideAllEntity));
            arr = this.getUsersByCell(this.myAvatar.dataLeaf.strFrame);
            for each (avatar in arr)
            {
                AvatarMC(avatar.pMC).setEntityVisibility(isVisible);
            };
        }

        public function setAllGroundVisibility():void
        {
            var hide:Boolean;
            var arr:Array;
            var avatar:Avatar;
            hide = (!(Game.root.userPreference.data.hideAllGround));
            arr = this.getUsersByCell(this.myAvatar.dataLeaf.strFrame);
            for each (avatar in arr)
            {
                AvatarMC(avatar.pMC).setGroundVisibility(hide);
            };
        }

        public function setAllTitleVisibility():void
        {
            var hide:Boolean;
            var arr:Array;
            var avatar:Avatar;
            hide = (!(Game.root.userPreference.data.hideAllTitle));
            arr = this.getUsersByCell(this.myAvatar.dataLeaf.strFrame);
            for each (avatar in arr)
            {
                AvatarMC(avatar.pMC).setTitleVisibility(hide);
            };
        }

        public function coolDown(action:String):Boolean
        {
            var actionData:Object;
            var currentTime:Number;
            var timeDifference:Number;
            actionData = this.lock[action];
            if (!actionData)
            {
                trace(("COOLDOWN LOCK NOT FOUND: " + action));
                return (true);
            };
            currentTime = new Date().getTime();
            timeDifference = (currentTime - actionData.ts);
            if (timeDifference < actionData.cd)
            {
                this.rootClass.chatF.pushMsg("warning", "Action taken too soon, please try again later.", "SERVER", "", 0);
                return (false);
            };
            actionData.ts = currentTime;
            return (true);
        }

        public function copyAvatarMC(movieClip:MovieClip):void
        {
            new AvatarMCCopier(this).copyTo(movieClip);
        }

        public function sendTradeInviteAccept():void
        {
            this.rootClass.network.send("ti", ["1"]);
        }

        public function sendTradeInviteDecline():void
        {
            this.rootClass.network.send("ti", ["0"]);
        }

        public function sendTradeInvite(_arg1:String):void
        {
            this.rootClass.network.send("ti", [_arg1]);
        }

        public function doTradeAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.network.send("tia", [_arg1.unm]);
            }
            else
            {
                this.rootClass.network.send("tid", [_arg1.unm]);
            };
        }

        public function sendTradeFromInvRequest(item:Object):void
        {
            var modal:ModalMC;
            var modalObj:Object;
            if (item.bEquip == 1)
            {
                modal = new ModalMC();
                modalObj = {};
                modalObj.strBody = "You must unequip the item before offering it!";
                modalObj.params = {};
                modalObj.glow = "red,medium";
                modalObj.btns = "mono";
                this.rootClass.ui.ModalStack.addChild(modal);
                modal.init(modalObj);
            }
            else
            {
                this.rootClass.network.send("tradeFromInv", [item.ItemID, item.CharItemID, item.TradeID, item.Quantity]);
            };
        }

        public function sendTradeToInvRequest(_arg1:Object):void
        {
            this.rootClass.network.send("tradeToInv", [_arg1.ItemID, _arg1.CharItemID, _arg1.TradeID]);
        }

        public function sendTradeSwapInvRequest(_arg1:Object, item:Object):void
        {
            var modal:ModalMC;
            var modalObj:Object;
            if (item.bEquip == 1)
            {
                modal = new ModalMC();
                modalObj = {};
                modalObj.strBody = "You must unequip the item before offering it!";
                modalObj.params = {};
                modalObj.glow = "red,medium";
                modalObj.btns = "mono";
                this.rootClass.ui.ModalStack.addChild(modal);
                modal.init(modalObj);
            }
            else
            {
                this.rootClass.network.send("tradeSwapInv", [item.ItemID, item.CharItemID, _arg1.ItemID, _arg1.CharItemID, _arg1.TradeID]);
            };
        }

        public function tradeHasRequested(_arg1:Array):Boolean
        {
            var _local2:String;
            for each (_local2 in _arg1)
            {
                if (!(_local2 in this.tradeInfo.hasRequested))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function sendConvertToCoinsRequest(_arg1:Number):void
        {
            this.rootClass.network.send("convertToCoins", [_arg1]);
        }

        public function abandonQuest(_arg_1:int):void
        {
            this.questTree[_arg_1].status = null;
            if (this.rootClass.ui.mcQTracker.currentLabel == "Open")
            {
                this.rootClass.ui.mcQTracker.updateQuest();
            };
            this.rootClass.network.send("abandonQuest", [_arg_1]);
        }

        public function redeemCode(_arg1:String):void
        {
            this.rootClass.network.send("redeemCode", [_arg1]);
        }

        public function renameCharacter(_arg1:String):void
        {
            this.rootClass.network.send("renameCharacter", [_arg1]);
        }

        public function migrateServer(_arg1:String):void
        {
            this.rootClass.network.send("migrateServer", [_arg1]);
        }

        private function buildBoundingRects():void
        {
            var _local2:Rectangle;
            var _local3:MovieClip;
            var _local1:int;
            this.arrEventR = [];
            this.arrSolidR = [];
            _local1 = 0;
            while (_local1 < this.arrEvent.length)
            {
                _local3 = this.arrEvent[_local1];
                _local2 = _local3.getBounds(this.rootClass.stage);
                this.arrEventR.push(_local2);
                _local1++;
            };
            _local1 = 0;
            while (_local1 < this.arrSolid.length)
            {
                _local3 = this.arrSolid[_local1];
                _local2 = _local3.getBounds(this.rootClass.stage);
                this.arrSolidR.push(_local2);
                _local1++;
            };
        }

        private function solveTxTy(_arg1:Point, _arg2:MovieClip):Point
        {
            var _local6:Point;
            var _local7:Point;
            var _local10:int;
            var _local3:int;
            var _local4:int;
            var _local5:int;
            var _local8:Array;
            var _local9:int;
            _local3 = 20;
            _local4 = int((960 / _local3));
            _local5 = int((550 / _local3));
            _local8 = [];
            while (_local9 <= _local4)
            {
                _local10 = 0;
                while (_local10 <= _local5)
                {
                    _local6 = new Point((_local9 * _local3), (_local10 * _local3));
                    if (this.testTxTy(_local6, _arg2))
                    {
                        _local8.push({
                            "x":_local6.x,
                            "y":_local6.y,
                            "d":Math.abs(Point.distance(_arg1, _local6))
                        });
                    };
                    _local10++;
                };
                _local9++;
            };
            if (_local8.length)
            {
                _local8.sortOn(["d"], [Array.NUMERIC]);
                _local7 = new Point(((_local8[0].x + int((Math.random() * 10))) - 5), ((_local8[0].y + int((Math.random() * 10))) - 5));
                while ((!(this.testTxTy(_local7, _arg2))))
                {
                    _local7 = new Point(((_local8[0].x + int((Math.random() * 10))) - 5), ((_local8[0].y + int((Math.random() * 10))) - 5));
                };
                return (_local7);
            };
            return (null);
        }

        private function testTxTy(_arg1:Point, _arg2:MovieClip):Boolean
        {
            var _local3:int;
            var _local4:int;
            var _local5:int;
            var _local6:int;
            var _local7:Rectangle;
            var _local8:Rectangle;
            var _local9:MovieClip;
            var _local10:Boolean;
            var _local11:int;
            _local3 = _arg2.shadow.width;
            _local4 = _arg2.shadow.height;
            _local5 = int((_arg1.x - (_local3 / 2)));
            _local6 = int((_arg1.y - (_local4 / 2)));
            _local7 = new Rectangle(_local5, _local6, _local3, _local4);
            while (_local11 < this.arrSolid.length)
            {
                _local9 = MovieClip(this.arrSolid[_local11].shadow);
                _local8 = new Rectangle(_local9.x, _local9.y, _local9.width, _local9.height);
                _local10 = (!(_local8.intersects(_local7)));
                _local11++;
            };
            return (_local10);
        }

        private function getMonID(_arg1:int):int
        {
            var _local2:String;
            var _local3:*;
            for (_local2 in this.monTree)
            {
                _local3 = this.monTree[_local2];
                if (_local3.MonMapID == _arg1)
                {
                    return (_local3.MonID);
                };
            };
            return (-1);
        }

        private function getMonsterDefinition(monsterID:int):Object
        {
            var monsterDefLength:int;
            var j:int;
            monsterDefLength = this.mondef.length;
            j = 0;
            while (j < monsterDefLength)
            {
                if (this.mondef[j].MonID == monsterID)
                {
                    return (this.mondef[j]);
                };
                j++;
            };
            return (null);
        }

        private function removeDuplicates(a:Array):Array
        {
            var i:int;
            a.sortOn(["strMonFileName"], [Array.DESCENDING]);
            i = 0;
            try
            {
                while (i < a.length)
                {
                    while (((i < (a.length + 1)) && (a[i].strMonFileName == a[(i + 1)].strMonFileName)))
                    {
                        a.splice(i, 1);
                    };
                    i = (i + 1);
                };
            }
            catch(e:Error)
            {
                trace(e);
            };
            return (a);
        }

        public function actionTimeCheck(action:Skill):Boolean
        {
            var time:Number;
            var haste:Number;
            var cd:int;
            time = new Date().getTime();
            haste = this.myAvatar.haste;
            if (action.auto)
            {
                return (!(this.autoActionTimer.running));
            };
            if ((time - this.GCDTS) < this.GCD)
            {
                return (false);
            };
            cd = Math.round((action.cd * haste));
            return ((time - action.ts) >= cd);
        }

        private function actionRangeCheck(skill:Skill, target:Avatar=null):Boolean
        {
            var avatarPos:Point;
            var targetPos:Point;
            var deltaX:Number;
            var deltaY:Number;
            var distance:Number;
            var rangeScaled:Number;
            if (((target == null) && (!(this.myAvatar.target == null))))
            {
                target = this.myAvatar.target;
            };
            if (target == this.myAvatar)
            {
                return (true);
            };
            if (target == null)
            {
                return (false);
            };
            avatarPos = this.myAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
            targetPos = target.pMC.mcChar.localToGlobal(new Point(0, 0));
            deltaX = Math.abs((targetPos.x - avatarPos.x));
            deltaY = Math.abs((targetPos.y - avatarPos.y));
            distance = Math.sqrt(((deltaX * deltaX) + (deltaY * deltaY)));
            rangeScaled = (skill.range * this.SCALE);
            return ((skill.range <= 301) ? ((deltaX <= rangeScaled) && (deltaY <= (30 * this.SCALE))) : (distance <= rangeScaled));
        }

        private function calculateFPS():void
        {
            var fpsTime:int;
            var x:Number;
            var tickFinal:Number;
            var quality:Number;
            var i:int;
            var qualityFinal:Number;
            var qualityIndex:int;
            if (((this.rootClass.ui == null) || (!(this.rootClass.ui.mcFPS.visible))))
            {
                return;
            };
            if (this.fpsTS != 0)
            {
                fpsTime = (new Date().getTime() - this.fpsTS);
                x = 0;
                if (this.ticklist.length == World.TICK_MAX)
                {
                    x = this.ticklist.shift();
                };
                this.ticklist.push(fpsTime);
                this.ticksum = ((this.ticksum + fpsTime) - x);
                tickFinal = (1000 / (this.ticksum / this.ticklist.length));
                if (this.rootClass.ui.mcFPS.visible)
                {
                    this.rootClass.ui.mcFPS.txtFPS.text = tickFinal.toPrecision(3);
                };
                if (((((++this.fpsQualityCounter % 24) == 0) && (this.ticklist.length == World.TICK_MAX)) && (this.rootClass.userPreference.data.quality == "AUTO")))
                {
                    this.fpsArrayQuality.push(tickFinal);
                    if (this.fpsArrayQuality.length == 5)
                    {
                        quality = 0;
                        i = 0;
                        while (i < this.fpsArrayQuality.length)
                        {
                            quality = (quality + this.fpsArrayQuality[i]);
                            i++;
                        };
                        qualityFinal = (quality / this.fpsArrayQuality.length);
                        qualityIndex = this.rootClass.arrQuality.indexOf(this.rootClass.stage.quality);
                        if (((qualityFinal < 12) && (qualityIndex > 0)))
                        {
                            this.rootClass.stage.quality = this.rootClass.arrQuality[(qualityIndex - 1)];
                        };
                        if (((qualityFinal >= 12) && (qualityIndex < 2)))
                        {
                            this.rootClass.stage.quality = this.rootClass.arrQuality[(qualityIndex + 1)];
                        };
                        this.fpsArrayQuality = [];
                    };
                };
            };
            this.fpsTS = new Date().getTime();
        }

        public function countDownAct(_arg1:Event):void
        {
            var icon:MovieClip;
            var action:Skill;
            var time:Number;
            var icon2:Bitmap;
            var hasteFinal:Number;
            var _local7:Number;
            var _local8:Number;
            var _local9:int;
            var mask:*;
            var displayObject:DisplayObject;
            icon = MovieClip(_arg1.target);
            action = icon.actObj;
            time = new Date().getTime();
            icon2 = icon.icon2;
            hasteFinal = Math.round((icon.cd * this.myAvatar.haste));
            _local7 = ((time - icon.ts) / hasteFinal);
            _local8 = Math.floor((_local7 * 4));
            _local9 = (int(((_local7 * 360) % 90)) + 1);
            if (!action.lock)
            {
                if (_local7 < 0.99)
                {
                    if (icon2)
                    {
                        countDownActSkill(icon2, 0, _local8);
                        countDownActSkill(icon2, 1, _local8);
                        countDownActSkill(icon2, 2, _local8);
                        countDownActSkill(icon2, 3, _local8);
                        mask = MovieClip(icon2.mask[("e" + _local8)]);
                        if (mask != null)
                        {
                            mask.gotoAndStop(_local9);
                        };
                    };
                }
                else
                {
                    displayObject = icon2.mask;
                    icon2.mask = null;
                    icon2.parent.removeChild(displayObject);
                    icon.removeEventListener(Event.ENTER_FRAME, this.countDownAct);
                    icon2.parent.removeChild(icon2);
                    icon2.bitmapData.dispose();
                    icon.icon2 = null;
                };
            };
        }

        public function mvTimerHandler(_arg1:TimerEvent):void
        {
            if (this.mvTimerObj != null)
            {
                this.pushMove(this.mvTimerObj.mc, this.mvTimerObj.tx, this.mvTimerObj.ty, this.mvTimerObj.sp);
                this.mvTimerObj = null;
                this.mvTimer.reset();
                this.mvTimer.start();
            };
        }

        public function onHouseOptionsDesignClick(_arg1:MouseEvent):void
        {
            this.toggleHouseEdit();
        }

        public function onHouseOptionsSaveClick(_arg1:MouseEvent):void
        {
            this.saveHouseSetup();
        }

        public function onHouseOptionsHideClick(_arg1:MouseEvent):void
        {
            this.showHouseOptions("hide");
        }

        public function onHouseOptionsExpandClick(_arg1:MouseEvent):void
        {
            this.showHouseOptions("default");
        }

        public function onHouseOptionsFloorClick(_arg1:MouseEvent):void
        {
            this.showHouseInventory(70);
        }

        public function onHouseOptionsWallClick(_arg1:MouseEvent):void
        {
            this.showHouseInventory(72);
        }

        public function onHouseOptionsMiscClick(_arg1:MouseEvent):void
        {
            this.showHouseInventory(73);
        }

        public function onHouseOptionsHouseClick(_arg1:MouseEvent):void
        {
            this.gotoTown("buyhouse", "Enter", "Spawn");
        }

        public function onHouseItemClick(_arg1:Event):void
        {
            var _local2:MovieClip;
            _local2 = (_arg1.currentTarget as MovieClip);
            if (((this.isMyHouse()) && (this.rootClass.ui.mcPopup.mcHouseMenu.visible)))
            {
                this.rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(MovieClip(_arg1.currentTarget));
                this.rootClass.ui.mcPopup.mcHouseMenu.onHandleMoveClick(_arg1.clone());
            }
            else
            {
                if (((_local2.btnButton == null) || (!(_local2.btnButton.hasEventListener(MouseEvent.CLICK)))))
                {
                    this.onWalkClick();
                };
            };
        }

        public function onHouseItemEnterFrame(_arg1:Event):void
        {
            var _local4:DisplayObject;
            var _local5:Rectangle;
            var _local2:MovieClip;
            var _local3:int;
            _local2 = (_arg1.currentTarget as MovieClip);
            while (_local3 < this.map.numChildren)
            {
                _local4 = this.map.getChildAt(_local3);
                if ((((_local4 is MovieClip) && (MovieClip(_local4).isFloor)) && (MovieClip(_local4).hitTestPoint(_local2.x, _local2.y))))
                {
                    _local2.removeEventListener(Event.ENTER_FRAME, this.onHouseItemEnterFrame);
                    _local2.isStable = true;
                    break;
                };
                _local3++;
            };
            if (!_local2.isStable)
            {
                _local5 = _local2.getBounds(this.rootClass.stage);
                if ((_local5.y + (_local5.height / 2)) > 495)
                {
                    _local2.isStable = true;
                    _local2.y = Math.ceil((_local5.y - (_local5.y - _local2.y)));
                    _local2.removeEventListener(Event.ENTER_FRAME, this.onHouseItemEnterFrame);
                }
                else
                {
                    _local2.y = (_local2.y + 10);
                };
                if (this.rootClass.ui.mcPopup.mcHouseMenu.visible)
                {
                    this.rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(_local2);
                };
            };
        }

        public function onHouseItemComplete(_arg1:Event):void
        {
            var _local2:*;
            _local2 = this.arrHouseItemQueue[0];
            if (_local2.typ == "A")
            {
                this.attachHouseItem(_local2);
                this.arrHouseItemQueue.splice(0, 1);
                if (this.arrHouseItemQueue.length > 0)
                {
                    this.loadNextHouseItem();
                };
            }
            else
            {
                this.rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem(_local2);
                this.arrHouseItemQueue.splice(0, 1);
                if (this.arrHouseItemQueue.length > 0)
                {
                    this.loadNextHouseItemB();
                };
            };
        }

        public function restRequest(_arg1:TimerEvent):void
        {
            var _local2:*;
            _local2 = this.getUoLeafById(this.myAvatar.uid);
            if (((((!(_local2.intHP == _local2.intHPMax)) || (!(_local2.intMP == _local2.intMPMax))) && (this.myAvatar.pMC.mcChar.currentLabel == "Rest")) && (_local2.intState == 1)))
            {
                if (this.coolDown("rest"))
                {
                    this.rootClass.network.send("restRequest", [""]);
                    this.restTimer.reset();
                    this.restTimer.start();
                }
                else
                {
                    this.restStart();
                };
            }
            else
            {
                this.restTimer.reset();
            };
        }

        public function afkTimerHandler(_arg1:Event):void
        {
            if (this.uoTree[this.rootClass.network.myUserName] != null)
            {
                this.rootClass.network.send("afk", [true]);
            };
        }

        public function autoActionHandler(_arg1:TimerEvent):void
        {
            if ((((((!(this.myAvatar.dataLeaf == null)) && (!(this.myAvatar.dataLeaf.intState == 0))) && (!(this.myAvatar.target == null))) && (!(this.myAvatar.target.dataLeaf == null))) && (!(this.myAvatar.target.dataLeaf.intState == 0))))
            {
                this.combatAction(this.getAutoAttack(), true);
            }
            else
            {
                this.exitCombat();
            };
        }

        public function flickerFrame(_arg1:Event):void
        {
            var _local2:*;
            _local2 = MovieClip(_arg1.currentTarget);
            if (((!(_local2.parent == null)) && (!(_local2.parent.stage == null))))
            {
                switch (_local2.curF)
                {
                    case 0:
                        _local2.parent.modulateColor(this.avtWCT, "+");
                        break;
                    case 1:
                        _local2.parent.modulateColor(this.avtWCT, "-");
                        break;
                    case 2:
                        _local2.parent.modulateColor(this.avtWCT, "+");
                        break;
                };
                if (_local2.curF >= _local2.maxF)
                {
                    _local2.parent.modulateColor(this.avtWCT, "-");
                    _local2.removeEventListener(Event.ENTER_FRAME, this.flickerFrame);
                    _local2.parent.removeChild(_local2);
                };
                _local2.curF++;
            }
            else
            {
                _local2.removeEventListener(Event.ENTER_FRAME, this.flickerFrame);
            };
        }

        public function doCTAClick(_arg1:MouseEvent):void
        {
            var _local2:MovieClip;
            var _local3:ModalMC;
            var _local4:Object;
            _local2 = (_arg1.currentTarget as MovieClip);
            _local3 = new ModalMC();
            _local4 = {};
            _local4.strBody = (("Would you like to join the next available party for " + _local2.sName) + "?");
            _local4.callback = this.doCTAAccept;
            _local4.params = {
                "QuestID":_local2.QuestID,
                "unm":_local2.unm
            };
            _local4.btns = "dual";
            this.rootClass.ui.ModalStack.addChild(_local3);
            _local3.init(_local4);
        }

        public function setupCellData(frame:String):void
        {
            var data:*;
            data = this.mapController.find(this.frames, frame);
            if (data != null)
            {
                this.bPK = data.isPK;
                this.cellSetup(data.scale, data.speed, data.mode);
            };
        }

        public function onManagerEnterFrame(event:Event):void
        {
            var zSortArr:Array;
            var i:int;
            var displayObject:DisplayObject;
            var index:int;
            this.calculateFPS();
            zSortArr = [];
            i = 0;
            while (i < this.CHARS.numChildren)
            {
                displayObject = this.CHARS.getChildAt(i);
                zSortArr.push({
                    "dio":displayObject,
                    "dioY":displayObject.y
                });
                i++;
            };
            zSortArr.sortOn("dioY", Array.NUMERIC);
            i = 0;
            while (i < zSortArr.length)
            {
                index = this.CHARS.getChildIndex(zSortArr[i].dio);
                if (index != i)
                {
                    this.CHARS.swapChildrenAt(index, i);
                };
                i++;
            };
            zSortArr = null;
        }

        private function onMapLoadProgress(event:ProgressEvent):void
        {
            var progress:int;
            progress = int(Math.floor(((event.bytesLoaded / event.bytesTotal) * 100)));
            this.rootClass.mcConnDetail.showConn((("Loading Map... " + progress) + "%"));
        }

        private function onMapLoadError(_arg1:IOErrorEvent):void
        {
            this.mapLoadInProgress = false;
            this.rootClass.chatF.pushMsg("warning", (("Loading Map Files... Failed, Respawning you back to " + this.strMap) + "."), "SERVER", "", 0);
            this.gotoTown(this.strMap, this.strFrame, this.strPad, true);
        }

        private function onMapLoadComplete(event:Event):void
        {
            this.clearMap();
            this.isJoined = false;
            this.rootClass.ui.visible = true;
            this.mapLoadInProgress = false;
            this.map = MovieClip(event.target.content);
            addChildAt(this.map, 0).x = 0;
            this.CHARS.x = 0;
            this.setSpawnPoint("", "");
            this.mapMonsterToLoad = 0;
            this.mapMonsterLoaded = 0;
            this.mapObjectToLoad = 0;
            this.mapObjectLoaded = 0;
            this.objSession.objMapItem = [];
            if (this.objectmap != null)
            {
                this.initObject();
            }
            else
            {
                if (((!(this.mondef == null)) && (this.mondef.length > 0)))
                {
                    this.initMonsters();
                }
                else
                {
                    this.initNpcs();
                };
            };
            if (this.isMyHouse())
            {
                this.rootClass.toggleHousePanel();
            };
            if (((!(this.myAvatar == null)) && (this.myAvatar)))
            {
                this.rootClass.discord.update("status");
            };
            UIController.close("spectate");
            if (this.bSpectate)
            {
                UIController.toggle("spectate");
            };
        }

        public function initObject():void
        {
            var loadedObjects:Array;
            var i:int;
            var obj:Object;
            this.mapController.strFrame = "";
            loadedObjects = [];
            i = 0;
            while (i < this.objectmap.length)
            {
                obj = this.objectmap[i];
                if (loadedObjects.indexOf(obj.file) < 0)
                {
                    this.mapObjectToLoad++;
                    loadedObjects.push(obj.file);
                    LoadController.singleton.addLoadMap(obj.file, ("object_" + obj.id), this.onMapObjectComplete, this.onMapObjectError, this.onMapObjectProgress);
                };
                i++;
            };
        }

        private function onMapObjectProgress(event:ProgressEvent):void
        {
            var progress:int;
            progress = int(Math.floor(((event.bytesLoaded / event.bytesTotal) * 100)));
            trace((("Loading Map Object... " + progress) + "%"));
        }

        private function onMapObjectError(_arg1:IOErrorEvent):void
        {
            this.onMapObjectComplete(null);
            trace("Failed to load map object.");
        }

        public function onMapObjectComplete(event:Event):void
        {
            this.mapObjectLoaded++;
            if (this.mapObjectLoaded >= this.mapObjectToLoad)
            {
                if (((!(this.mondef == null)) && (this.mondef.length > 0)))
                {
                    this.initMonsters();
                }
                else
                {
                    this.initNpcs();
                };
            };
        }

        public function updateMapObjects():void
        {
            var i:int;
            var obj:Object;
            var cls:Class;
            var movieClip:MovieClip;
            var layout:* = undefined;
            if (this.mapController.strFrame == this.map.currentLabel)
            {
                return;
            };
            this.mapController.strFrame = this.map.currentLabel;
            if (this.objectmap == null)
            {
                return;
            };
            i = 0;
            while (i < this.objectmap.length)
            {
                obj = this.objectmap[i];
                if ((((this.strFrame == obj.frame) || (obj.frame == "All")) || (obj.frame == "Interface")))
                {
                    try
                    {
                        cls = Class(LoadController.singleton.applicationDomainMap.getDefinition(obj.linkage));
                        if (cls == null)
                        {
                            return;
                        };
                        movieClip = new (cls)();
                        movieClip.name = obj.name;
                        movieClip.x = obj.x;
                        movieClip.y = obj.y;
                        movieClip.scaleX = (movieClip.scaleY = obj.scale);
                        if (obj.face == "Left")
                        {
                            movieClip.scaleX = (movieClip.scaleX * -1);
                        };
                        movieClip.data = obj;
                        movieClip.isProp = true;
                        if (obj.frame == "Interface")
                        {
                            layout = this.rootClass.ui.mapsTrash.getChildByName(obj.name);
                            if (layout == null)
                            {
                                this.rootClass.ui.mapsTrash.addChild(movieClip);
                            };
                        }
                        else
                        {
                            if (!this.isRemoveProps)
                            {
                                this.CHARS.addChild(movieClip);
                            };
                        };
                        if (movieClip.init != undefined)
                        {
                            movieClip.init(Game.root);
                        };
                    }
                    catch(e:Error)
                    {
                        trace(("updateMapObjects " + e.getStackTrace()));
                        trace(("Map Object: " + JSON.stringify(obj)));
                    };
                };
                i = (i + 1);
            };
        }

        public function loadMenu(_arg1:String):void
        {
            this.rootClass.network.send("loadMenu", [_arg1]);
        }

        public function loadAttriute(categoryId:int):void
        {
            this.rootClass.network.send("guild", ["attributeLoad", categoryId]);
        }

        public function getMoonPhase():int
        {
            var year:Number;
            var month:Number;
            var day:Number;
            var c:Number;
            var e:Number;
            var jd:Number;
            var b:int;
            year = this.rootClass.date_server.fullYear;
            month = (this.rootClass.date_server.month + 1);
            day = this.rootClass.date_server.date;
            c = 0;
            e = 0;
            jd = 0;
            b = 0;
            if (month < 3)
            {
                year--;
                month = (month + 12);
            };
            month++;
            c = (365.25 * year);
            e = (30.6 * month);
            jd = (((c + e) + day) - 694039.09);
            jd = (jd / 29.5305882);
            b = parseInt(String(jd));
            jd = (jd - b);
            b = Math.round((jd * 8));
            if (b >= 8)
            {
                b = 0;
            };
            return (b);
        }

        public function updateMonsterPosition(monMapID:int, x:Number, y:Number):void
        {
            this.rootClass.network.send("updateMonsterPosition", [monMapID, x, y]);
        }

        public function gatherResource(_arg1:int):void
        {
            this.rootClass.network.send("gatherResource", [_arg1]);
        }

        public function updateResource(data:Object):Object
        {
            var i:int;
            var key:String;
            i = 0;
            while (i < this.resourcemap.length)
            {
                if (this.resourcemap[i].id == data.id)
                {
                    data.display = this.resourcemap[i].display;
                    for (key in data)
                    {
                        this.resourcemap[i][key] = data[key];
                    };
                    return (this.resourcemap[i]);
                };
                i++;
            };
            return (null);
        }

        public function getResource(id:int):Object
        {
            var i:int;
            var object:Object;
            i = 0;
            while (i < this.resourcemap.length)
            {
                object = this.resourcemap[i];
                if (object.id == id)
                {
                    return (object);
                };
                i++;
            };
            return (null);
        }

        public function rebuildFrame():void
        {
            var mapBuild:Array;
            var padNames:Array;
            var i:*;
            var child:DisplayObject;
            var mapMovieClip:MovieClip;
            var isFlipped:Boolean;
            var keysCount:int;
            var parameters:Array;
            mapBuild = [];
            padNames = ["Spawn", "Spawn0", "Spawn1", "Up", "Down", "Left", "Right"];
            i = 0;
            for (;i < this.map.numChildren;i++)
            {
                child = this.map.getChildAt(i);
                if ((child is MovieClip))
                {
                    mapMovieClip = MovieClip(child);
                    isFlipped = (mapMovieClip.transform.matrix.a < 0);
                    if (mapMovieClip.name.toLowerCase().indexOf("walk") !== -1)
                    {
                        mapBuild.push({
                            "type":"Walkable",
                            "parameters":mapMovieClip.name,
                            "height":mapMovieClip.height,
                            "width":mapMovieClip.width,
                            "x":mapMovieClip.x,
                            "y":mapMovieClip.y,
                            "isFlipped":isFlipped
                        });
                    };
                    if (padNames.indexOf(mapMovieClip.name) !== -1)
                    {
                        mapBuild.push({
                            "type":"Pad",
                            "parameters":mapMovieClip.name,
                            "height":mapMovieClip.height,
                            "width":mapMovieClip.width,
                            "x":mapMovieClip.x,
                            "y":mapMovieClip.y,
                            "isFlipped":isFlipped
                        });
                    };
                    if (mapMovieClip.isEvent)
                    {
                        if ((((mapMovieClip.strNewMap) && (mapMovieClip.strSpawnCell)) && (mapMovieClip.strSpawnPad)))
                        {
                            mapBuild.push({
                                "type":"Navigator",
                                "parameters":((((mapMovieClip.strNewMap + "|") + mapMovieClip.strSpawnCell) + "|") + mapMovieClip.strSpawnPad),
                                "height":mapMovieClip.height,
                                "width":mapMovieClip.width,
                                "x":mapMovieClip.x,
                                "y":mapMovieClip.y,
                                "isFlipped":isFlipped
                            });
                            continue;
                        };
                        if (((mapMovieClip.tCell) && (mapMovieClip.tPad)))
                        {
                            mapBuild.push({
                                "type":"Navigator",
                                "parameters":((mapMovieClip.tCell + "|") + mapMovieClip.tPad),
                                "height":mapMovieClip.height,
                                "width":mapMovieClip.width,
                                "x":mapMovieClip.x,
                                "y":mapMovieClip.y,
                                "isFlipped":isFlipped
                            });
                            continue;
                        };
                        keysCount = mapMovieClip.name.split("_").length;
                        parameters = mapMovieClip.name.split("_");
                        if (((keysCount == 4) && (parameters[0] == "join")))
                        {
                            mapBuild.push({
                                "type":"Navigator",
                                "parameters":((((parameters[1] + "|") + parameters[2]) + "|") + parameters[3]),
                                "height":mapMovieClip.height,
                                "width":mapMovieClip.width,
                                "x":mapMovieClip.x,
                                "y":mapMovieClip.y,
                                "isFlipped":isFlipped
                            });
                            continue;
                        };
                        if (((keysCount == 3) && (parameters[0] == "move")))
                        {
                            mapBuild.push({
                                "type":"Navigation",
                                "parameters":((parameters[1] + "|") + parameters[2]),
                                "height":mapMovieClip.height,
                                "width":mapMovieClip.width,
                                "x":mapMovieClip.x,
                                "y":mapMovieClip.y,
                                "isFlipped":isFlipped
                            });
                            continue;
                        };
                    };
                    if (mapMovieClip.isSolid)
                    {
                        mapBuild.push({
                            "type":"Collision",
                            "parameters":"",
                            "height":mapMovieClip.height,
                            "width":mapMovieClip.width,
                            "x":mapMovieClip.x,
                            "y":mapMovieClip.y,
                            "isFlipped":isFlipped
                        });
                    }
                    else
                    {
                        if (mapMovieClip.isMonster)
                        {
                            mapBuild.push({
                                "type":"Monster",
                                "parameters":((((mapMovieClip.strDir) ? mapMovieClip.strDir : "Left") + "|") + mapMovieClip.MonMapID),
                                "height":mapMovieClip.height,
                                "width":mapMovieClip.width,
                                "x":mapMovieClip.x,
                                "y":mapMovieClip.y,
                                "isFlipped":isFlipped
                            });
                        };
                    };
                };
            };
            MainController.modal("Would you like to rebuild this frame in Map Builder?", this.rebuildMap, {"mapBuild":mapBuild}, null, "dual", true);
            trace(JSON.stringify(mapBuild));
        }

        public function rebuildMap(data:Object):void
        {
            if (data.accept)
            {
                this.rootClass.network.send("frameRebuild", [this.SCALE, this.WALKSPEED, this.CELL_MODE, data.mapBuild]);
            };
        }

        public function mapScrollCheck(reset:Boolean=false):void
        {
            var screenWidth:int;
            var screenHeight:int;
            var halfScreenWidth:int;
            var halfScreenHeight:int;
            var bounds:Rectangle;
            var mapWidth:int;
            var mapHeight:int;
            var left:int;
            var right:int;
            var bottom:int;
            var avatarX:int;
            var avatarY:int;
            var xd:int;
            var xdy:int;
            screenWidth = 960;
            screenHeight = 550;
            halfScreenWidth = int((screenWidth / 2));
            halfScreenHeight = int(((screenHeight / 2) - 50));
            if (((((this.map) && (this.map.Walkable)) && (this.map.Walkable.width > 0)) && (this.map.Walkable.height > 0)))
            {
                bounds = this.map.Walkable.getRect(stage);
                mapWidth = bounds.width;
                mapHeight = bounds.height;
                left = 0;
                right = Math.round((screenWidth - mapWidth));
                bottom = Math.floor((screenHeight - mapHeight));
                avatarX = this.myAvatar.pMC.x;
                if (((avatarX > halfScreenWidth) && (avatarX < (mapWidth - halfScreenWidth))))
                {
                    xd = Math.round((halfScreenWidth - (bounds.x + avatarX)));
                    if (xd != 0)
                    {
                        this.map.x = (this.map.x + xd);
                        this.CHARS.x = (this.CHARS.x + xd);
                    };
                }
                else
                {
                    if (avatarX < halfScreenWidth)
                    {
                        if (this.map.x != left)
                        {
                            this.map.x = left;
                            this.CHARS.x = left;
                        };
                    }
                    else
                    {
                        if (avatarX > (mapWidth - halfScreenWidth))
                        {
                            if (this.map.x != right)
                            {
                                this.map.x = right;
                                this.CHARS.x = right;
                            };
                        };
                    };
                };
                avatarY = this.myAvatar.pMC.y;
                if (((avatarY > halfScreenHeight) && (avatarY < (mapHeight - (screenHeight - halfScreenHeight)))))
                {
                    xdy = Math.round((halfScreenHeight - (bounds.y + avatarY)));
                    if (xdy != 0)
                    {
                        this.map.y = (this.map.y + xdy);
                        this.CHARS.y = (this.CHARS.y + xdy);
                    };
                }
                else
                {
                    if (avatarY < halfScreenHeight)
                    {
                        if (this.map.y != 0)
                        {
                            this.map.y = 0;
                            this.CHARS.y = 0;
                        };
                    }
                    else
                    {
                        if (avatarY > (mapHeight - (screenHeight - halfScreenHeight)))
                        {
                            if (this.map.y != bottom)
                            {
                                this.map.y = bottom;
                                this.CHARS.y = bottom;
                            };
                        };
                    };
                };
            };
        }


    }
}//package 

// _SafeStr_1 = "goto" (String#9324)


