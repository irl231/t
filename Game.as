// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game

package 
{
    import flash.display.MovieClip;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import Main.Network.Network;
    import flash.utils.Dictionary;
    import Main.Aqw.LPF.LPFLayoutAuction;
    import Main.Aqw.LPF.LPFFrameListViewTabbed;
    import Game_fla.game_1_mcNotificationWrapper_2;
    import Main.Login.Login;
    import flash.net.SharedObject;
    import flash.net.URLLoader;
    import Main.Chat.ChatSession;
    import Main.Avatar.Auras.PlayerAuras;
    import Main.Avatar.Auras.TargetAuras;
    import Main.Loader.Asset;
    import Main.Loader.GameMenu;
    import flash.system.ApplicationDomain;
    import flash.display.DisplayObject;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.media.Sound;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.display.Bitmap;
    import flash.display.DisplayObjectContainer;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import Main.Model.Item;
    import Main.Model.Skill;
    import Main.Model.ShopModel;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import Main.UI.AbstractDropFrame;
    import Main.UI.DropMenu;
    import Game_fla.mcPopup_323;
    import Main.UI.MapMenu;
    import flash.events.TextEvent;
    import flash.text.TextField;
    import flash.events.KeyboardEvent;
    import flash.events.FocusEvent;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import Main.UI.*;
    import Main.Network.*;
    import flash.media.*;
    import flash.filters.*;
    import flash.utils.*;
    import Main.Aqw.LPF.*;
    import Main.Loader.*;
    import Main.Chat.*;
    import Main.Avatar.*;
    import Main.Aqw.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;
    import Main.Avatar.Auras.*;
    import Main.Option.*;
    import flash.ui.*;
    import flash.external.*;

    public class Game extends MovieClip 
    {

        public static var SCALE:Number = 1;
        public static var root:Game;
        public static var mcUpgradeWindow:MCUpgradeWindow;
        public static var mcACWindow:MovieClip;
        public static var Song:Boolean = true;
        public static var BGMChannel:SoundChannel = new SoundChannel();
        public static var BGMTransform:SoundTransform = new SoundTransform(0.7, 0);
        public static var BGMArray:Object = {};

        public const network:Network = new Network(Game);
        public const arrFPS:Array = ["24", "30", "60", "75", "120"];
        public const arrQuality:Array = ["AUTO", "LOW", "MEDIUM", "HIGH", "BEST"];
        public const arrVolume:Array = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
        public const sfc:Object = {
            "myUserId":network.myUserId,
            "myUserName":network.myUserName,
            "getRoom":network.room,
            "sendXtMessage":function (xtName:String, cmd:String, paramObj:Array, _type:String="xml", roomId:int=-1):void
            {
                Game.root.network.send(cmd, paramObj);
            }
        };

        public var keyboardDictionary:Dictionary;
        public var version:Object = {};
        public var firstLogin:Boolean = true;
        public var isMobile:Boolean = false;
        public var chatLog:KathleenChatLog;
        public var ctrlTrade:MovieClip;
        public var tradeItem1:MovieClip;
        public var tradeItem2:MovieClip;
        public var tradeItem3:MovieClip;
        public var mcCooking:MovieClip;
        public var vendingOwner:String = "";
        public var auctionLabels:int;
        public var auctionItem1:MovieClip;
        public var auctionItem2:MovieClip;
        public var auctionItem3:MovieClip;
        public var auctionLayout:LPFLayoutAuction;
        public var auctionTabs:LPFFrameListViewTabbed;
        public var tradeTabs:Object = {};
        public var MsgBox:game_1_mcNotificationWrapper_2;
        public var mcAccount:MovieClip;
        public var mcExtSWF:MovieClip;
        public var ui:MovieClip;
        public var mcLogin:Login;
        public var mcO:mcOption2;
        public var mixer:SoundFX = new SoundFX();
        public var chatF:Chat;
        public var params:Object = {};
        public var userPreference:SharedObject;
        public var uoPref:Object = {};
        public var litePref:Array = [];
        public var loginLoader:URLLoader = new URLLoader();
        public var objServerInfo:Object;
        public var sfcSocial:Boolean = false;
        public var ldrMC:LoaderMC = new LoaderMC();
        public var discord:Discord;
        public var mcConnDetail:ConnDetailMC;
        public var chatSession:ChatSession;
        public var ts_login_server:Number;
        public var ts_login_client:Number;
        public var intLevelCap:int;
        public var PCstBase:int;
        public var PCstRatio:Number;
        public var PCstGoal:int;
        public var GstBase:int;
        public var GstRatio:Number;
        public var GstGoal:int;
        public var PChpBase1:int;
        public var PChpBase100:int;
        public var PChpGoal1:int;
        public var PChpGoal100:int;
        public var PChpDelta:int;
        public var intHPperEND:int;
        public var intAPtoDPS:int;
        public var intSPtoDPS:int;
        public var bigNumberBase:int;
        public var resistRating:Number;
        public var modRating:Number;
        public var baseDodge:Number;
        public var baseBlock:Number;
        public var baseParry:Number;
        public var baseCrit:Number;
        public var baseHit:Number;
        public var baseHaste:Number;
        public var baseMiss:Number;
        public var baseResist:Number;
        public var baseCritValue:Number;
        public var baseBlockValue:Number;
        public var baseResistValue:Number;
        public var baseEventValue:Number;
        public var PCDPSMod:Number = 0.85;
        public var curveExponent:Number = 0.66;
        public var statsExponent:Number = 1.33;
        public var ratiosBySlot:Object;
        public var classCatMap:Object;
        public var apopTree:Object;
        public var curID:String;
        public var confirmTime:int = 0;
        public var quests:Boolean = false;
        public var loaderDomain:* = null;
        private var rn:RandomNumber;
        private var apop_:apopCore;
        public var pinnedQuests:String = "";
        public var baseClassStats:Object;
        public var statsNewClass:Boolean = false;
        public var playerAuras:PlayerAuras;
        public var targetAuras:TargetAuras;
        public var _world:World = null;
        private var _asset:Asset;
        private var _gameMenu:GameMenu;
        private var _titleDomain:ApplicationDomain = null;
        private var worldMap:DisplayObject = null;
        public var onAutoCombat:Boolean = false;
        public var isAutoCombatResting:Boolean = false;
        public var autoCombatTimer:Timer;
        public var autoCombatInterval:int = 100;

        public function Game()
        {
            this.discord = new Discord(this);
            this.chatSession = new ChatSession();
            this.ratiosBySlot = {
                "he":0.25,
                "ar":0.25,
                "ba":0.2,
                "Weapon":0.33
            };
            this.classCatMap = {
                "M1":{"ratios":[0.27, 0.3, 0.22, 0.05, 0.1, 0.06]},
                "M2":{"ratios":[0.2, 0.22, 0.33, 0.05, 0.1, 0.1]},
                "M3":{"ratios":[0.24, 0.2, 0.2, 0.24, 0.07, 0.05]},
                "M4":{"ratios":[0.3, 0.18, 0.3, 0.02, 0.06, 0.14]},
                "C1":{"ratios":[0.06, 0.2, 0.11, 0.33, 0.15, 0.15]},
                "C2":{"ratios":[0.08, 0.27, 0.1, 0.3, 0.1, 0.15]},
                "C3":{"ratios":[0.06, 0.23, 0.05, 0.28, 0.28, 0.1]},
                "S1":{"ratios":[0.22, 0.18, 0.21, 0.08, 0.08, 0.23]}
            };
            this.apopTree = {};
            this.rn = new RandomNumber();
            this._asset = new Asset();
            this._gameMenu = new GameMenu();
            super();
            addFrameScript(3, this.frameLogin, 5, this.frameGame, 7, this.frameGame);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.userPreference = SharedObject.getLocal("LoveLottePref", "/");
            this.uoPref.bSoundOn = this.mixer.bSoundOn;
            this.chatF = new Chat(this);
            Rank.init();
        }

        public static function trim(_arg1:String):String
        {
            return ((_arg1 == null) ? "" : _arg1.replace(/^\s+|\s+$/g, ""));
        }

        public static function XMLtoObject(_arg1:XML):Object
        {
            var _local3:*;
            var _local4:*;
            var _local5:*;
            var _local2:* = {};
            for (_local3 in _arg1.attributes())
            {
                _local2[String(_arg1.attributes()[_local3].name())] = String(_arg1.attributes()[_local3]);
            };
            for (_local4 in _arg1.children())
            {
                _local5 = _arg1.children()[_local4].name();
                if (_local2[_local5] == undefined)
                {
                    _local2[_local5] = [];
                };
                _local2[_local5].push(XMLtoObject(_arg1.children()[_local4]));
            };
            return (_local2);
        }

        public static function convertXMLtoObject(_arg1:XML):Object
        {
            var _local3:*;
            var _local4:*;
            var _local5:XML;
            var _local6:*;
            var _local2:* = {};
            for (_local3 in _arg1.attributes())
            {
                _local2[String(_arg1.attributes()[_local3].name())] = String(_arg1.attributes()[_local3]);
            };
            for (_local4 in _arg1.children())
            {
                _local5 = _arg1.children()[_local4];
                if (_local5.nodeKind() == "text")
                {
                    if (_local5 == parseFloat(_local5).toString())
                    {
                        return (parseFloat(_local5));
                    };
                    return (_local5);
                };
                if (_local5.nodeKind() == "element")
                {
                    _local6 = _arg1.children()[_local4].name();
                    if (_local2[_local6] == null)
                    {
                        _local2[_local6] = convertXMLtoObject(_arg1.children()[_local4]);
                    }
                    else
                    {
                        if (!(_local2[_local6] is Array))
                        {
                            _local2[_local6] = [_local2[_local6]];
                        };
                        _local2[_local6].push(convertXMLtoObject(_arg1.children()[_local4]));
                    };
                };
            };
            return (_local2);
        }

        private static function isAlphaChar(_arg1:String):Boolean
        {
            var _local2:uint = _arg1.charCodeAt(0);
            return (((_local2 >= 65) && (_local2 < 123)) || ((_local2 >= 48) && (_local2 < 58)));
        }

        private static function duplicateDisplayObject(target:DisplayObject, autoAdd:Boolean=false):DisplayObject
        {
            var targetClass:Class = Object(target).constructor;
            var duplicate:DisplayObject = new (targetClass)();
            return (duplicate);
        }

        private static function funnelEF(_arg1:Event):void
        {
            var _local3:MovieClip;
            var _local8:Number;
            var _local9:Number;
            var _local17:Point;
            var _local18:Point;
            var _local19:Point;
            var _local20:Point;
            var _local21:Point;
            var _local22:Point;
            var _local26:Number;
            var _local29:Number;
            var _local30:Number;
            var _local24:int;
            var _local25:int;
            var _local28:int;
            var _local2:MovieClip = MovieClip(_arg1.currentTarget);
            var _local4:Number = new Date().getTime();
            var _local5:Point = new Point();
            var _local6:Point = new Point();
            var _local7:Point = new Point();
            var _local10:int = 1;
            var _local11:MovieClip = _local2.targetMCs[0];
            var _local12:MovieClip = _local2.targetMCs[1];
            var _local13:Point = _local11.localToGlobal(new Point(0, (-(_local11.height) / 2)));
            var _local14:Point = _local12.localToGlobal(new Point(0, (-(_local12.height) / 2)));
            var _local15:* = _local12.width;
            var _local16:* = _local12.height;
            var _local23:int = -1;
            var _local27:Number = Math.atan2((_local13.y - _local14.y), (_local13.x - _local14.x));
            _local27 = (_local27 - (Math.PI / 2));
            while (_local28 < _local2.fxArr.length)
            {
                _local3 = _local2.fxArr[_local28];
                _local9 = _local2.ts;
                _local8 = (_local4 - (_local28 * _local2.del));
                if (_local8 > (_local9 + _local2.dur))
                {
                    if (_local3.visible)
                    {
                        _local3.visible = false;
                        _local3.graphics.clear();
                    };
                    if (_local28 == (_local2.fxArr.length - 1))
                    {
                        _local2.removeEventListener(Event.ENTER_FRAME, funnelEF);
                        if (_local2.parent != null)
                        {
                            _local2.parent.removeChild(_local2);
                        };
                    };
                }
                else
                {
                    if (_local8 >= _local2.ts)
                    {
                        _local29 = ((_local8 - _local9) / _local2.dur);
                        _local29 = Math.pow((1 - _local29), _local2.easingExponent);
                        _local10 = (((_local28 % 2) == 0) ? 1 : -1);
                        _local17 = new Point((Point.interpolate(_local13, _local14, _local2.p1StartingValue).x + Point.polar((_local10 * (_local12.height / _local2.p1ScaleFactor)), _local27).x), (Point.interpolate(_local13, _local14, _local2.p1StartingValue).y + Point.polar((_local10 * (_local12.height / _local2.p1ScaleFactor)), _local27).y));
                        _local18 = new Point(Point.interpolate(_local13, _local14, _local2.p1EndingValue).x, Point.interpolate(_local13, _local14, _local2.p1EndingValue).y);
                        _local19 = new Point(Point.interpolate(_local13, _local14, _local2.p2StartingValue).x, _local14.y);
                        _local20 = new Point(Point.interpolate(_local13, _local14, _local2.p2EndingValue).x, Point.interpolate(_local13, _local14, _local2.p2EndingValue).y);
                        _local21 = new Point((Point.interpolate(_local13, _local14, _local2.p3StartingValue).x + Point.polar((-(_local10) * (_local12.height / _local2.p3ScaleFactor)), _local27).x), (Point.interpolate(_local13, _local14, _local2.p3StartingValue).y + Point.polar((-(_local10) * (_local12.height / _local2.p3ScaleFactor)), _local27).y));
                        _local22 = new Point(Point.interpolate(_local13, _local14, _local2.p3EndingValue).x, Point.interpolate(_local13, _local14, _local2.p3EndingValue).y);
                        _local5 = Point.interpolate(_local17, _local18, _local29);
                        _local6 = Point.interpolate(_local19, _local20, _local29);
                        _local7 = Point.interpolate(_local21, _local22, _local29);
                        _local26 = _local3.lineColor;
                        _local3.graphics.clear();
                        _local3.graphics.lineStyle(_local2.lineThickness, _local26, 1);
                        _local3.graphics.moveTo(_local14.x, _local14.y);
                        _local3.graphics.curveTo(_local5.x, _local5.y, _local6.x, _local6.y);
                        _local3.graphics.curveTo(_local7.x, _local7.y, _local13.x, _local13.y);
                        _local30 = Math.cos(((((_local8 - _local9) / _local2.dur) * Math.PI) * 2));
                        _local30 = ((_local30 / 2) + 0.5);
                        _local30 = (1 - _local30);
                        _local3.alpha = _local30;
                    };
                };
                _local28++;
            };
        }

        public static function configureScroll(list:Sprite, mask:Sprite, scroll:MovieClip, resizeScrollHeight:Number=0, isReset:*=true, scrollFromBottom:*=false):void
        {
            var distance:Number;
            list.mask = mask;
            list.y = mask.y;
            scroll.hit.height = scroll.b.height;
            scroll.hit.alpha = 0;
            if (resizeScrollHeight != 0)
            {
                scroll.a2.y = resizeScrollHeight;
                distance = ((scroll.a2.y - scroll.a1.y) - (scroll.a2.height + scroll.a1.height));
                scroll.hit.height = distance;
                scroll.b.height = distance;
            };
            scroll.fOpen({
                "subject":list,
                "subjectMask":mask,
                "reset":isReset,
                "scrollFromBottom":scrollFromBottom
            });
            if (!list.hasEventListener(MouseEvent.MOUSE_WHEEL))
            {
                list.addEventListener(MouseEvent.MOUSE_WHEEL, Game.onWheel(scroll));
            };
            if (!scroll.hasEventListener(MouseEvent.MOUSE_WHEEL))
            {
                scroll.addEventListener(MouseEvent.MOUSE_WHEEL, Game.onWheel(scroll));
            };
        }

        public static function excludeLeader(members:Array, username:String):Array
        {
            var memberList:Array = [];
            var i:int;
            while (i < members.length)
            {
                if (members[i].strUsername != username)
                {
                    memberList.push(members[i]);
                };
                i++;
            };
            return (memberList);
        }

        public static function loadBGM(url:String):void
        {
            var bgm:Sound;
            if (!BGMArray.hasOwnProperty(url))
            {
                bgm = new Sound();
                bgm.load(new URLRequest(url));
                bgm.addEventListener(Event.COMPLETE, function (event:Event):void
                {
                    BGMArray[url] = bgm;
                    loadBGM(url);
                }, false, 0, true);
            }
            else
            {
                BGMChannel = BGMArray[url].play(0, 9999, BGMTransform);
            };
        }

        private static function onWheel(scroll:MovieClip):Function
        {
            return (function (e:MouseEvent):void
            {
                var j:*;
                if (e.delta <= 0)
                {
                    j = 0;
                    while (j < (e.delta * -1))
                    {
                        MovieClip(scroll).a2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        j++;
                    };
                    return;
                };
                var oldY:* = scroll.h.y;
                var i:* = 0;
                while (i < e.delta)
                {
                    MovieClip(scroll).a1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    i++;
                };
                if (oldY == scroll.h.y)
                {
                    scroll.h.y = (scroll.h.y - (e.delta * 1.1));
                    if ((scroll.h.y + scroll.h.height) > scroll.b.height)
                    {
                        scroll.h.y = int((scroll.b.height - scroll.h.height));
                    };
                    if (scroll.h.y < 0)
                    {
                        scroll.h.y = 0;
                    };
                };
            });
        }

        public static function isRuffle():Boolean
        {
            if (((!(Game.root.loaderDomain == null)) && (Game.root.loaderDomain.hasOwnProperty("isRuffle"))))
            {
                if (Game.root.loaderDomain.isRuffle)
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function consoleLog(msg:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("console.log", msg);
            }
            else
            {
                trace(("ExternalInterface is not available: " + msg));
            };
        }

        public static function animateAndExecute(display:MovieClip, animation:String, callback:Function=null):void
        {
            display.gotoAndPlay(animation);
            display.addEventListener(Event.ENTER_FRAME, function (event:Event):void
            {
                checkAnimationLabel(display, animation, callback);
            });
        }

        public static function executeAtFrame(display:MovieClip, targetFrame:String, callback:Function=null):void
        {
            var onEnterFrame:* = undefined;
            onEnterFrame = function (event:Event):void
            {
                if (display.currentLabel == targetFrame)
                {
                    display.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                    if (callback != null)
                    {
                        callback();
                    };
                };
            };
            display.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        public static function checkAnimationLabel(display:MovieClip, animation:String, callback:Function=null):void
        {
            if (display.currentLabel == animation)
            {
                if (display.currentFrame == currentFrameLabelEnd(display, animation))
                {
                    display.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                    if (callback != null)
                    {
                        (callback());
                    };
                };
            };
        }

        public static function currentFrameLabelEnd(display:MovieClip, label:String):int
        {
            var labels:Array = display.currentLabels;
            var i:int;
            while (i < labels.length)
            {
                if (labels[i].name == label)
                {
                    if (i == (labels.length - 1))
                    {
                        return (display.totalFrames);
                    };
                    return (labels[(i + 1)].frame - 1);
                };
                i++;
            };
            return (-1);
        }

        public static function removeTrailingComma(input:String):String
        {
            if (input.charAt((input.length - 1)) == ",")
            {
                return (input.substring(0, (input.length - 1)));
            };
            return (input);
        }

        public static function movieClipStopAll(target:MovieClip):void
        {
            var i:int;
            var child:DisplayObject;
            var childMovieClip:MovieClip;
            if (((!(target)) || (target.numChildren == 0)))
            {
                return;
            };
            i = 0;
            while (i < target.numChildren)
            {
                try
                {
                    child = target.getChildAt(i);
                    if ((child is MovieClip))
                    {
                        childMovieClip = MovieClip(child);
                        if (childMovieClip.totalFrames > 0)
                        {
                            childMovieClip.gotoAndStop(1);
                        };
                        if (childMovieClip !== target)
                        {
                            movieClipStopAll(childMovieClip);
                        };
                    };
                }
                catch(e:Error)
                {
                    trace(((("Error processing child at index " + i) + ": ") + e.message));
                };
                i = (i + 1);
            };
        }

        public static function getTierColor(tier:String):String
        {
            switch (tier)
            {
                case "?":
                    return (("<font color='#C0C0C0'>[Rank " + tier) + "]</font>");
                case "X":
                    return (("<font color='#A0EFFF'>[Rank " + tier) + "]</font>");
                case "SS":
                    return (("<font color='#FFD700'>[Rank " + tier) + "]</font>");
                case "S+":
                    return (("<font color='#FFB6C1'>[Rank " + tier) + "]</font>");
                case "S-":
                    return (("<font color='#FFC0CB'>[Rank " + tier) + "]</font>");
                case "S":
                    return (("<font color='#FFA07A'>[Rank " + tier) + "]</font>");
                case "P":
                    return (Game.getRainbowText((("[Rank " + tier) + "]")));
                case "A":
                    return (("<font color='#DDA0DD'>[Rank " + tier) + "]</font>");
                case "B":
                    return (("<font color='#ADD8E6'>[Rank " + tier) + "]</font>");
                case "C":
                    return (("<font color='#B0E0E6'>[Rank " + tier) + "]</font>");
                case "D":
                    return (("<font color='#98FB98'>[Rank " + tier) + "]</font>");
                case "F":
                    return (("<font color='#F8F8FF'>[Rank " + tier) + "]</font>");
                default:
                    return (("<font color='#F8F8FF'>[Rank " + tier) + "]</font>");
            };
        }

        public static function getRainbowText(text:String):String
        {
            var color:String;
            var rainbowText:* = "";
            var i:* = 0;
            while (i < text.length)
            {
                switch ((i % 7))
                {
                    case 0:
                        color = "#FFB3B3";
                        break;
                    case 1:
                        color = "#FFD9B3";
                        break;
                    case 2:
                        color = "#FFFFB3";
                        break;
                    case 3:
                        color = "#B3FFB3";
                        break;
                    case 4:
                        color = "#B3D9FF";
                        break;
                    case 5:
                        color = "#D1B3FF";
                        break;
                    case 6:
                        color = "#FFB3FF";
                        break;
                    default:
                        color = "#FFFFFF";
                };
                rainbowText = (rainbowText + (((("<font color='" + color) + "'>") + text.charAt(i)) + "</font>"));
                i++;
            };
            return (rainbowText);
        }

        public static function hueToRGB(hue:Number, saturation:Number=1, lightness:Number=0.5):uint
        {
            var r:Number = (Math.abs((((hue / 60) % 6) - 3)) - 1);
            var g:Number = ((2 - Math.abs((((hue / 60) % 6) - 3))) - 1);
            var b:Number = ((2 - Math.abs((((hue / 60) % 6) - 4))) - 1);
            r = Math.max(0, Math.min(1, r));
            g = Math.max(0, Math.min(1, g));
            b = Math.max(0, Math.min(1, b));
            return ((((r * 0xFF) << 16) | ((g * 0xFF) << 8)) | (b * 0xFF));
        }

        public static function spriteToBitmap(container:MovieClip):void
        {
            var bounds:Rectangle = container.getBounds(container);
            var adjustedWidth:Number = Math.ceil(Math.max(container.width, bounds.width));
            var adjustedHeight:Number = Math.ceil(Math.max(container.height, bounds.height));
            var snapshot:BitmapData = new BitmapData(adjustedWidth, adjustedHeight, true, 0);
            var drawMatrix:Matrix = new Matrix();
            drawMatrix.translate(-(bounds.x), -(bounds.y));
            snapshot.draw(container, drawMatrix);
            var bitmap:Bitmap = new Bitmap(snapshot);
            bitmap.x = bounds.x;
            bitmap.y = bounds.y;
            while (container.numChildren > 0)
            {
                container.removeChildAt(0);
            };
            container.addChild(bitmap);
        }


        public function get world():World
        {
            return (this._world);
        }

        public function set world(value:World):void
        {
            this._world = value;
        }

        public function get asset():Asset
        {
            return (this._asset);
        }

        public function get gameMenu():GameMenu
        {
            return (this._gameMenu);
        }

        public function get titleDomain():ApplicationDomain
        {
            return (this._titleDomain);
        }

        public function set titleDomain(value:ApplicationDomain):void
        {
            this._titleDomain = value;
        }

        public function get date_server():Date
        {
            return (this.getServerTime());
        }

        public function get apop():apopCore
        {
            return (this.apop_);
        }

        public function get assetsDomain():ApplicationDomain
        {
            return (this.asset.domain);
        }

        public function set assetsDomain(value:ApplicationDomain):void
        {
            this.asset.domain = value;
        }

        public function get menuDomain():ApplicationDomain
        {
            return (this.gameMenu.domain);
        }

        public function set menuDomain(value:ApplicationDomain):void
        {
            this.gameMenu.domain = value;
        }

        public function get isGameLabel():Boolean
        {
            return ((currentLabel == "Game") || (currentLabel == "Mobile"));
        }

        public function getGuildLoadPath(guildId:int):String
        {
            return (((Config.serverGuildImageURL + guildId) + "/?ran=") + this.rn.rand());
        }

        public function getPlayerLoadPath(username:String):String
        {
            return (((Config.serverPlayerImageURL + username) + "/?ran=") + this.rn.rand());
        }

        public function onRemoveChildrens(displayObjectContainer:DisplayObjectContainer):void
        {
            if (displayObjectContainer == null)
            {
                return;
            };
            while (displayObjectContainer.numChildren > 0)
            {
                displayObjectContainer.removeChildAt(0);
            };
        }

        private function frameLogin():void
        {
            this.loadTitle();
            this.playBGM();
            if (((!(this.loaderDomain == null)) && (this.loaderDomain.isAndroid)))
            {
                this.isMobile = true;
            };
            if (this.loaderDomain != null)
            {
                this.loaderDomain.visible = false;
                this.loaderDomain.parent.removeChild(this.loaderDomain);
            };
            this.discord.update("stage");
            stop();
        }

        private function frameGame():void
        {
            this.initInterface();
            this.initWorld();
            stop();
        }

        public function loadAccountCreation(_arg1:String):void
        {
            this.mcAccount.removeChildAt(0);
        }

        public function monsterTreeWrite(_arg1:int, _arg2:Object):void
        {
            var _local6:String;
            var _local7:*;
            var _local10:Avatar;
            var _local17:String;
            var _local18:int;
            var _local19:*;
            var _local20:*;
            var _local13:String;
            var _local14:Object = {};
            var _local15:Object = this.world.monTree[_arg1];
            if (_local15 != null)
            {
                for (_local17 in _arg2)
                {
                    _local6 = _local17;
                    _local7 = _arg2[_local17];
                    _local14[_local6] = _local7;
                    if (_local6.toLowerCase().indexOf("int") > -1)
                    {
                        _local7 = ((_local6.toLowerCase().indexOf("hp") > -1) ? Number(_local7) : int(_local7));
                    };
                    if (_local6 == "react")
                    {
                        _local7 = _local7.split(",");
                        _local18 = 0;
                        while (_local18 < _local7.length)
                        {
                            _local7[_local18] = int(_local7[_local18]);
                            _local18++;
                        };
                    };
                    _local15[_local6] = _local7;
                };
                for (_local13 in _local14)
                {
                    _local6 = _local13;
                    _local7 = _local14[_local13];
                    if (_local6.toLowerCase().indexOf("evt:") < 0)
                    {
                        _local10 = this.world.getMonster(_arg1);
                        if (_local10 != null)
                        {
                            if ((((_local6.toLowerCase().indexOf("hp") > -1) && (!(_local10 == null))) && (!(_local10.objData == null))))
                            {
                                _local7 = Number(_local7);
                                _local10.objData[_local13] = _local7;
                                if (this.world.myAvatar.target == _local10)
                                {
                                    this.world.updatePortrait(_local10);
                                };
                                if ((((!(this.world.objLock == null)) && (_local6 == "intHP")) && (_local7 <= 0)))
                                {
                                    this.world.intKillCount++;
                                    this.world.updatePadNames();
                                };
                                if (((((!(_local10.objData == null)) && ("boolean")) && (_local10.objData.strFrame == this.world.strFrame)) && (_local7 <= 0)))
                                {
                                    _local10.pMC.stopWalking();
                                    this.world.removeAuraFX(_local10.pMC, "all");
                                    _local10.pMC.die();
                                    _local15.auras = [];
                                    _local15.targets = {};
                                    _local10.target = null;
                                    if (("eventTrigger" in MovieClip(this.world.map)))
                                    {
                                        this.world.map.eventTrigger({
                                            "cmd":"monDeath",
                                            "args":_arg1,
                                            "targets":_arg2.targets
                                        });
                                    };
                                    if (this.world.myAvatar.dataLeaf.targets[_local10.objData.MonMapID] != null)
                                    {
                                        delete this.world.myAvatar.dataLeaf.targets[_local10.objData.MonMapID];
                                    };
                                };
                            };
                            if (_local6.toLowerCase().indexOf("mp") > -1)
                            {
                                _local7 = Number(_local7);
                                _local10.objData[_local13] = _local7;
                                if (this.world.myAvatar.target == _local10)
                                {
                                    this.world.updatePortrait(_local10);
                                };
                            };
                            if (_local6.toLowerCase().indexOf("state") > -1)
                            {
                                if (((!(_local10 == null)) && (!(_local10.objData == null))))
                                {
                                    _local7 = int(_local7);
                                    _local10.objData[_local13] = _local7;
                                    if (_local7 != 2)
                                    {
                                        this.world.removeAuraByDataLeaf(_local15, _local10);
                                        _local10.dataLeaf.auras = [];
                                    };
                                    if ((((((!(_local10.objData.strFrame == null)) && (_local10.objData.strFrame == this.world.strFrame)) && (_local7 == 1)) && (!(_local10.pMC == null))) && ((!(_local10.pMC.x == _local10.pMC.ox)) || (!(_local10.pMC.y == _local10.pMC.oy)))))
                                    {
                                        _local10.pMC.walkTo(_local10.pMC.ox, _local10.pMC.oy, this.world.WALKSPEED);
                                    };
                                    if (_local7 != 2)
                                    {
                                        _local15.targets = {};
                                    };
                                };
                            };
                            if (_local6.toLowerCase() == "tx")
                            {
                                _local7 = int(_local7);
                                if ((((!(_local10.objData == null)) && (!(_local10.objData.strFrame == null))) && (_local10.objData.strFrame == this.world.strFrame)))
                                {
                                    this.world.monTree[_arg1].dx = _local14.tx;
                                    this.world.monTree[_arg1].dy = _local14.ty;
                                    _local10.pMC.walkTo(this.world.monTree[_arg1].dx, this.world.monTree[_arg1].dy, this.world.WALKSPEED);
                                };
                            };
                            if (_local6.toLowerCase().indexOf("dx") > -1)
                            {
                                _local7 = int(_local7);
                                if ((((!(_local10.objData == null)) && (!(_local10.objData.strFrame == null))) && (_local10.objData.strFrame == this.world.strFrame)))
                                {
                                    _local19 = int(this.world.monTree[_arg1].dx);
                                    _local20 = int(this.world.monTree[_arg1].dy);
                                    _local10.pMC.walkTo(_local19, _local20, this.world.WALKSPEED);
                                };
                            };
                        };
                    };
                };
            };
        }

        public function npcTreeWrite(_arg1:int, _arg2:Object):void
        {
            var _local6:String;
            var _local7:*;
            var _local10:Avatar;
            var _local17:String;
            var _local18:int;
            var _local19:*;
            var _local20:*;
            var _local13:String;
            var animation:*;
            var _local14:Object = {};
            var _local15:Object = this.world.npcTree[_arg1];
            if (_local15 != null)
            {
                for (_local17 in _arg2)
                {
                    _local6 = _local17;
                    _local7 = _arg2[_local17];
                    _local14[_local6] = _local7;
                    if (_local6.toLowerCase().indexOf("int") > -1)
                    {
                        _local7 = int(_local7);
                    };
                    if (_local6 == "react")
                    {
                        _local7 = _local7.split(",");
                        _local18 = 0;
                        while (_local18 < _local7.length)
                        {
                            _local7[_local18] = int(_local7[_local18]);
                            _local18++;
                        };
                    };
                    _local15[_local6] = _local7;
                };
                for (_local13 in _local14)
                {
                    _local6 = _local13;
                    _local7 = _local14[_local13];
                    if (_local6.toLowerCase().indexOf("evt:") < 0)
                    {
                        _local10 = this.world.getNpc(_arg1);
                        if (_local10 != null)
                        {
                            if ((((_local6.toLowerCase().indexOf("hp") > -1) && (!(_local10 == null))) && (!(_local10.objData == null))))
                            {
                                _local7 = int(_local7);
                                _local10.objData[_local13] = _local7;
                                if (this.world.myAvatar.target == _local10)
                                {
                                    this.world.updatePortrait(_local10);
                                };
                                if ((((!(this.world.objLock == null)) && (_local6 == "intHP")) && (_local7 <= 0)))
                                {
                                    this.world.intKillCount++;
                                    this.world.updatePadNames();
                                };
                                if (((((!(_local10.objData == null)) && ("boolean")) && (_local10.objData.strFrame == this.world.strFrame)) && (_local7 <= 0)))
                                {
                                    _local10.pMC.stopWalking();
                                    if (_local10.objData.eqp.en != null)
                                    {
                                        MovieClip(_local10.pMC.getChildAt(1)).gotoAndPlay("Die");
                                    }
                                    else
                                    {
                                        _local10.pMC.mcChar.gotoAndPlay("Feign");
                                    };
                                    _local10.pMC.apopbutton.visible = false;
                                    this.world.removeAuraFX(_local10.pMC, "all");
                                    _local15.auras = [];
                                    _local15.targets = {};
                                    _local10.target = null;
                                    if (("eventTrigger" in MovieClip(this.world.map)))
                                    {
                                        this.world.map.eventTrigger({
                                            "cmd":"npcDeath",
                                            "args":_arg1,
                                            "targets":_arg2.targets
                                        });
                                    };
                                    if (this.world.myAvatar.dataLeaf.targets[_local10.objData.NpcMapID] != null)
                                    {
                                        delete this.world.myAvatar.dataLeaf.targets[_local10.objData.NpcMapID];
                                    };
                                };
                            };
                            if (_local6.toLowerCase().indexOf("state") > -1)
                            {
                                if (((!(_local10 == null)) && (!(_local10.objData == null))))
                                {
                                    _local7 = int(_local7);
                                    _local10.objData[_local13] = _local7;
                                    if (_local7 != 2)
                                    {
                                        this.world.removeAuraByDataLeaf(_local15, _local10);
                                        _local10.dataLeaf.auras = [];
                                    };
                                    if ((((((!(_local10.objData.strFrame == null)) && (_local10.objData.strFrame == this.world.strFrame)) && (_local7 == 1)) && (!(_local10.pMC == null))) && ((!(_local10.pMC.x == _local10.objData.X)) || (!(_local10.pMC.y == _local10.objData.Y)))))
                                    {
                                        _local10.pMC.walkTo(_local10.objData.X, _local10.objData.Y, this.world.WALKSPEED);
                                        animation = ((this.frameCheck(_local10.pMC.mcChar, _local10.objData.animation)) ? _local10.objData.animation : "Idle");
                                        if (isNaN(_local10.objData.animation))
                                        {
                                            _local10.pMC.mcChar.gotoAndPlay(animation);
                                        };
                                    };
                                    if (_local7 != 2)
                                    {
                                        _local15.targets = {};
                                    };
                                };
                            };
                            if (_local6.toLowerCase().indexOf("dx") > -1)
                            {
                                _local7 = int(_local7);
                                if ((((!(_local10.objData == null)) && (!(_local10.objData.strFrame == null))) && (_local10.objData.strFrame == this.world.strFrame)))
                                {
                                    _local19 = int(this.world.npcTree[_arg1].dx);
                                    _local20 = int(this.world.npcTree[_arg1].dy);
                                    _local10.pMC.walkTo(_local19, _local20, this.world.WALKSPEED);
                                };
                            };
                        };
                    };
                };
            };
        }

        public function userTreeWrite(username:String, data:Object):void
        {
            var _local5:String;
            var _local6:* = undefined;
            var _local11:MovieClip;
            var _local16:String;
            var state:int;
            var user:* = undefined;
            var user2:* = undefined;
            var initialSpeed:* = undefined;
            var targetData:* = undefined;
            var entityMC:* = undefined;
            var avatar:Avatar = this.world.getAvatarByUserName(username);
            var _local12:* = "";
            var _local13:Object = {};
            var _local14:Object = {};
            var userData:Object = this.world.uoTree[username.toLowerCase()];
            for (_local16 in data)
            {
                _local5 = _local16;
                _local6 = data[_local16];
                if ((((((_local5.toLowerCase().indexOf("int") > -1) || (_local5.toLowerCase() == "tx")) || (_local5.toLowerCase() == "ty")) || (_local5.toLowerCase() == "sp")) || (_local5.toLowerCase() == "pvpTeam")))
                {
                    _local6 = int(_local6);
                };
                if ((((((((((this.sfcSocial) && (!(userData == null))) && (!(this.world.myAvatar.dataLeaf == null))) && (_local5.toLowerCase() == "inthp")) && (!(username.toLowerCase() == this.network.myUserName))) && (userData.strFrame == this.world.myAvatar.dataLeaf.strFrame)) && ((!(this.world.bPvP)) || (userData.pvpTeam == this.world.myAvatar.dataLeaf.pvpTeam))) && (_local6 > 0)) && (!(this.world.getFirstHeal() == null))))
                {
                    if (((_local6 <= userData.intHP) && (((userData.intHP - _local6) >= (userData.intHPMax * 0.15)) || (_local6 <= (userData.intHPMax * 0.5)))))
                    {
                        try
                        {
                            AvatarMC(avatar.pMC).showHealIcon();
                        }
                        catch(e:Error)
                        {
                        };
                    };
                    if (_local6 > Math.round((userData.intHPMax * 0.5)))
                    {
                        try
                        {
                            if (avatar.pMC.getChildByName("HealIconMC") != null)
                            {
                                HealIconMC(avatar.pMC.getChildByName("HealIconMC")).fClose();
                            };
                        }
                        catch(e:Error)
                        {
                        };
                    };
                };
                if ((((_local5.toLowerCase() == "afk") || (_local5.toLowerCase() == "vend")) || (_local5.toLowerCase() == "fly")))
                {
                    _local6 = (_local6 == "true");
                };
                _local13[_local5] = _local6;
                _local14[_local5] = _local6;
            };
            state = -1;
            if (this.world.uoTree[username.toLowerCase()] != null)
            {
                state = this.world.uoTree[username.toLowerCase()].intState;
            };
            this.world.uoTreeLeafSet(username, _local14);
            userData = this.world.uoTree[username.toLowerCase()];
            _local12 = "";
            for (_local12 in _local13)
            {
                _local6 = _local13[_local12];
                if (_local12.toLowerCase() == "strframe")
                {
                    this.world.manageAreaUser(username, "+");
                    if (_local13[_local12] != this.world.strFrame)
                    {
                        user = this.network.room.getUser(username);
                        if (user == null)
                        {
                            continue;
                        };
                        _local11 = this.world.getMCByUserID(user.getId());
                        if (((!(_local11 == null)) && (!(_local11.stage == null))))
                        {
                            _local11.pAV.hideMC();
                            if (_local11.pAV == this.world.myAvatar.target)
                            {
                                this.world.setTarget(null);
                            };
                        };
                    }
                    else
                    {
                        if (_local13.sp != null)
                        {
                            user2 = this.network.room.getUser(username);
                            if (user2 == null)
                            {
                                continue;
                            };
                            _local11 = this.world.getMCByUserID(user2.getId());
                            if (_local11 != null)
                            {
                                initialSpeed = this.world.WALKSPEED;
                                targetData = this.world.uoTree[username.toLowerCase()];
                                if (targetData.fly)
                                {
                                    initialSpeed = (initialSpeed + 10);
                                };
                                _local11.walkTo(_local13.tx, _local13.ty, initialSpeed);
                            };
                        }
                        else
                        {
                            this.world.objectByID(userData.entID);
                        };
                    };
                }
                else
                {
                    if (_local12.toLowerCase() == "sp")
                    {
                        if (_local13.strFrame == this.world.strFrame)
                        {
                        };
                    };
                };
                if (avatar != null)
                {
                    try
                    {
                        avatar.pMC.updateName();
                    }
                    catch(e:Error)
                    {
                    };
                    if (((_local12.toLowerCase().indexOf("inthp") > -1) || (_local12.toLowerCase().indexOf("intmp") > -1)))
                    {
                        _local6 = int(_local6);
                        if (avatar.objData != null)
                        {
                            avatar.objData[_local12] = _local6;
                        };
                        if (((avatar.isMyAvatar) || (this.world.myAvatar.target == avatar)))
                        {
                            this.world.updatePortrait(avatar);
                        };
                        if (avatar.isMyAvatar)
                        {
                            this.world.updateActBar();
                        };
                        if (((!(avatar.pMC == null)) && (this.world.showHPBar)))
                        {
                            avatar.pMC.updateHPBar();
                        };
                    };
                    if (_local12.toLowerCase().indexOf("intlevel") > -1)
                    {
                        _local6 = int(_local6);
                        if (avatar.objData != null)
                        {
                            avatar.objData[_local12] = _local6;
                            if (((!(avatar.isMyAvatar)) && (this.world.myAvatar.target == avatar)))
                            {
                                AvatarUtil.showPortraitBox(avatar, this.ui.mcPortraitTarget);
                            };
                        };
                    };
                    if (_local12.toLowerCase().indexOf("intstate") > -1)
                    {
                        _local6 = int(_local6);
                        if (((((!(avatar.objData == null)) && (this.world.uoTree[username.toLowerCase()].strFrame == this.world.strFrame)) && (_local6 == 1)) && (state == 0)))
                        {
                            if (this.checkForFrame(avatar.pMC, "Idle"))
                            {
                                avatar.pMC.gotoAndStop("Idle");
                            };
                            avatar.pMC.scale(this.world.SCALE);
                        };
                        if (avatar.objData != null)
                        {
                            avatar.objData[_local12] = _local6;
                        };
                        if ((((_local6 == 0) && (this.world.uoTree[username.toLowerCase()].strFrame == this.world.strFrame)) && (!(avatar.pMC == null))))
                        {
                            avatar.pMC.stopWalking();
                            try
                            {
                                if (avatar.objData.eqp.en != null)
                                {
                                    entityMC = MovieClip(avatar.pMC.getChildAt(1));
                                    if (MainController.hasLabel("Die", entityMC))
                                    {
                                        entityMC.gotoAndPlay("Die");
                                    };
                                }
                                else
                                {
                                    avatar.pMC.mcChar.gotoAndPlay("Feign");
                                };
                            }
                            catch(error:Error)
                            {
                                if (Config.isDebug)
                                {
                                    trace("userTreeWrite gotoAndPlay", error.getStackTrace());
                                };
                            };
                            this.world.removeAuraByDataLeaf(avatar.dataLeaf, avatar);
                            this.world.removeAuraFX(avatar.pMC, "all");
                            if (avatar.pMC.getChildByName("HealIconMC") != null)
                            {
                                HealIconMC(avatar.pMC.getChildByName("HealIconMC")).fClose();
                            };
                            if (avatar.isMyAvatar)
                            {
                                this.world.cancelAutoAttack();
                                this.world.actionReady = false;
                                this.world.bitWalk = false;
                                this.world.map.transform.colorTransform = this.world.deathCT;
                                this.world.CHARS.transform.colorTransform = this.world.deathCT;
                                avatar.pMC.transform.colorTransform = this.world.defaultCT;
                                this.world.showResCounter();
                            };
                        };
                        if (_local6 != 2)
                        {
                            userData.targets = {};
                        };
                    };
                    if (avatar.pMC != null)
                    {
                        avatar.pMC.updateName();
                    };
                    if ((((_local12.toLowerCase().indexOf("afk") > -1) || (_local12.toLowerCase().indexOf("vend") > -1)) || (_local12.toLowerCase().indexOf("fly") > -1)))
                    {
                        if (avatar.pMC != null)
                        {
                            avatar.pMC.updateName();
                        };
                    };
                    if (_local12 == "showCloak")
                    {
                        if (avatar.pMC != null)
                        {
                            avatar.pMC.setCloakVisibility(_local6);
                        };
                    };
                    if (_local12 == "showHelm")
                    {
                        if (avatar.pMC != null)
                        {
                            avatar.pMC.setHelmVisibility(_local6);
                        };
                    };
                    if (_local12 == "showTitle")
                    {
                        if (avatar.pMC != null)
                        {
                            avatar.pMC.setTitleVisibility(_local6);
                        };
                    };
                    if (_local12 == "showEntity")
                    {
                        if (avatar.pMC != null)
                        {
                            avatar.pMC.setEntityVisibility(_local6);
                        };
                    };
                    if (_local12 == "showRune")
                    {
                        if (avatar.pMC != null)
                        {
                            avatar.pMC.setGroundVisibility(_local6);
                        };
                    };
                    if (_local12.toLowerCase().indexOf("cast") > -1)
                    {
                        if (avatar.pMC != null)
                        {
                            if (_local6.t > -1)
                            {
                                avatar.pMC.stopWalking();
                                avatar.pMC.queueAnim("Use");
                            }
                            else
                            {
                                avatar.pMC.endAction();
                                if (avatar == this.world.myAvatar)
                                {
                                    this.ui.mcCastBar.fClose();
                                };
                            };
                        };
                    };
                };
            };
        }

        public function doAnim(anim:Object, isProc:Boolean=false, duration:String=null):void
        {
            var anims:Array;
            var animIndex:uint;
            var animString:String;
            var clientType:String;
            var clientID:int;
            var clientAvatar:Avatar;
            var clientLeaf:Object;
            var targetsArr:Array;
            var targetsArrLength:int;
            var i:int;
            var targetAvatar:Avatar;
            var targetValues:Array;
            var targetType:String;
            var targetID:int;
            var animStr:String;
            var cReg:Point;
            var tReg:Point;
            var animFx:*;
            var distanceX:*;
            var distanceY:*;
            var buffer:* = undefined;
            var xBuffer:* = undefined;
            var yBuffer:* = undefined;
            var targetAvatars:Vector.<Avatar> = new Vector.<Avatar>();
            if (((!(anim.cInf == null)) && (!(anim.tInf == null))))
            {
                clientType = String(anim.cInf.split(":")[0]);
                clientID = int(anim.cInf.split(":")[1]);
                clientAvatar = null;
                switch (clientType)
                {
                    case "p":
                        clientAvatar = this.world.getAvatarByUserID(clientID);
                        clientLeaf = this.world.getUoLeafById(clientID);
                        break;
                    case "m":
                        clientAvatar = this.world.getMonster(clientID);
                        clientLeaf = this.world.monTree[clientID];
                        if (anim.msg != null)
                        {
                            if (anim.msg.indexOf("<mon>") > -1)
                            {
                                anim.msg = anim.msg.split("<mon>").join(clientAvatar.objData.strMonName);
                            };
                            this.addUpdate(anim.msg);
                        };
                        break;
                    case "n":
                        clientAvatar = this.world.getNpc(clientID);
                        clientLeaf = this.world.npcTree[clientID];
                        if (anim.msg != null)
                        {
                            if (anim.msg.indexOf("<mon>") > -1)
                            {
                                anim.msg = anim.msg.split("<mon>").join(clientAvatar.objData.strUsername);
                            };
                            this.addUpdate(anim.msg);
                        };
                        break;
                };
                targetsArr = anim.tInf.split(",");
                targetsArrLength = targetsArr.length;
                i = 0;
                while (i < targetsArrLength)
                {
                    targetValues = targetsArr[i].split(":");
                    targetType = targetValues[0];
                    targetID = targetValues[1];
                    switch (targetType)
                    {
                        case "p":
                            targetAvatars.push(this.world.getAvatarByUserID(targetID));
                            break;
                        case "m":
                            targetAvatars.push(this.world.getMonster(targetID));
                            break;
                        case "n":
                            targetAvatars.push(this.world.getNpc(targetID));
                            break;
                    };
                    i++;
                };
                targetAvatar = targetAvatars[0];
                if ((((((((targetAvatars.length > 0) && (!(targetAvatar == null))) && (!(targetAvatar.pMC == null))) && (!(targetAvatar.dataLeaf == null))) && (!(clientAvatar == null))) && (!(clientAvatar.pMC == null))) && (!(clientLeaf == null))))
                {
                    if (!this.world.isMoveOK(clientLeaf))
                    {
                        return;
                    };
                    animStr = anim.animStr;
                    cReg = new Point(0, 0);
                    tReg = new Point(0, 0);
                    switch (clientType)
                    {
                        case "p":
                            if (clientAvatar.objData != null)
                            {
                                if (clientAvatar != this.world.myAvatar)
                                {
                                    clientAvatar.target = targetAvatar;
                                };
                                clientAvatar.pMC.spFX.strl = "";
                                if ((((!(clientLeaf.strFrame == null)) && (clientLeaf.strFrame == this.world.strFrame)) && (clientLeaf.intState > 0)))
                                {
                                    if (clientAvatar != targetAvatar)
                                    {
                                        clientAvatar.pMC.turn((((targetAvatar.pMC.x - clientAvatar.pMC.x) >= 0) ? "right" : "left"));
                                    };
                                    if (anim.strl != null)
                                    {
                                        clientAvatar.pMC.spFX.strl = anim.strl;
                                    };
                                    if (anim.fx != null)
                                    {
                                        clientAvatar.pMC.spFX.fx = anim.fx;
                                    };
                                    if (targetAvatars != null)
                                    {
                                        clientAvatar.pMC.spFX.avts = targetAvatars;
                                    };
                                    if (!isNaN(Number(duration)))
                                    {
                                        clientAvatar.pMC.spellDur = duration;
                                    };
                                    if (animStr.indexOf(",") > -1)
                                    {
                                        animStr = animStr.split(",")[Math.round((Math.random() * (animStr.split(",").length - 1)))];
                                    };
                                    if (((!(animStr == "Thrash")) || (!(clientAvatar.pMC.mcChar.currentLabel == "Thrash"))))
                                    {
                                        clientAvatar.pMC.queueAnim(animStr);
                                    };
                                    if (((isProc) && (clientAvatar.pMC.mcChar.weapon.mcWeapon.isProc)))
                                    {
                                        clientAvatar.pMC.mcChar.weapon.mcWeapon.gotoAndPlay("Proc");
                                    };
                                };
                            };
                            return;
                        case "m":
                            if (clientAvatar.objData != null)
                            {
                                if (clientAvatar != this.world.myAvatar)
                                {
                                    clientAvatar.target = targetAvatar;
                                };
                                cReg = clientAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                tReg = targetAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                cReg = this.world.CHARS.globalToLocal(cReg);
                                tReg = this.world.CHARS.globalToLocal(tReg);
                                if ((((!(clientLeaf.strFrame == null)) && (clientLeaf.strFrame == this.world.strFrame)) && (clientLeaf.intState > 0)))
                                {
                                    if (clientAvatar != targetAvatar)
                                    {
                                        clientAvatar.pMC.turn((((tReg.x - cReg.x) >= 0) ? "right" : "left"));
                                    };
                                    animFx = anim.fx;
                                    distanceX = (Math.abs((cReg.x - tReg.x)) * this.world.SCALE);
                                    distanceY = (Math.abs((cReg.y - tReg.y)) * this.world.SCALE);
                                    if (((((!(animFx === "p")) && (!(animFx === "w"))) && (!(animFx === ""))) && ((distanceX > 160) || (distanceY > 15))))
                                    {
                                        buffer = int((110 + (Math.random() * 50)));
                                        xBuffer = (((tReg.x - cReg.x) >= 0) ? -(buffer) : buffer);
                                        xBuffer = int((xBuffer * this.world.SCALE));
                                        if ((((tReg.x + xBuffer) < 0) || ((tReg.x + xBuffer) > 960)))
                                        {
                                            xBuffer = (xBuffer * -1);
                                        };
                                        buffer = int(((Math.random() * 30) - 15));
                                        yBuffer = (((tReg.y - cReg.y) >= 0) ? -(buffer) : buffer);
                                        yBuffer = int((yBuffer * this.world.SCALE));
                                        clientAvatar.pMC.walkTo((tReg.x + xBuffer), (tReg.y + yBuffer), 32);
                                    };
                                    if (clientAvatar.pMC.spFX != null)
                                    {
                                        clientAvatar.pMC.spFX.avt = clientAvatar.target;
                                    };
                                    cReg = clientAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    tReg = targetAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    if (clientAvatar != targetAvatar)
                                    {
                                        clientAvatar.pMC.turn((((tReg.x - cReg.x) >= 0) ? "right" : "left"));
                                    };
                                    if (((Game.root.userPreference.data["disableMonsterAnimation"]) || (Game.root.userPreference.data["combatHideMonstersAttackAnimations"])))
                                    {
                                        return;
                                    };
                                    if (animStr.length > 1)
                                    {
                                        if (animStr.indexOf(",") > -1)
                                        {
                                            if (this.world.objExtra["bChar"] == 1)
                                            {
                                                animString = clientAvatar.pMC.Animation;
                                                MovieClip(clientAvatar.pMC.getChildAt(1)).gotoAndPlay(animString);
                                            }
                                            else
                                            {
                                                anims = animStr.split(",");
                                                animIndex = uint(Math.round((Math.random() * (anims.length - 1))));
                                                MovieClip(clientAvatar.pMC.getChildAt(1)).gotoAndPlay(anims[animIndex]);
                                            };
                                        }
                                        else
                                        {
                                            if (this.world.objExtra["bChar"] == 1)
                                            {
                                                animString = clientAvatar.pMC.Animation;
                                                MovieClip(clientAvatar.pMC.getChildAt(1)).gotoAndPlay(animString);
                                            }
                                            else
                                            {
                                                MovieClip(clientAvatar.pMC.getChildAt(1)).gotoAndPlay(animStr);
                                            };
                                        };
                                    };
                                };
                            };
                            return;
                        case "n":
                            if (clientAvatar.objData != null)
                            {
                                if (clientAvatar != this.world.myAvatar)
                                {
                                    clientAvatar.target = targetAvatar;
                                };
                                cReg = clientAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                tReg = targetAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                cReg = this.world.CHARS.globalToLocal(cReg);
                                tReg = this.world.CHARS.globalToLocal(tReg);
                                if ((((!(clientLeaf.strFrame == null)) && (clientLeaf.strFrame == this.world.strFrame)) && (clientLeaf.intState > 0)))
                                {
                                    if (clientAvatar != targetAvatar)
                                    {
                                        clientAvatar.pMC.turn((((tReg.x - cReg.x) >= 0) ? "right" : "left"));
                                    };
                                    if (anim.strl != null)
                                    {
                                        clientAvatar.pMC.spFX.strl = anim.strl;
                                    };
                                    if (anim.fx != null)
                                    {
                                        clientAvatar.pMC.spFX.fx = anim.fx;
                                    };
                                    if (targetAvatars != null)
                                    {
                                        clientAvatar.pMC.spFX.avts = targetAvatars;
                                    };
                                    if (((((!(anim.fx == "p")) && (!(anim.fx == "w"))) && (!(anim.fx == ""))) && (((Math.abs((cReg.x - tReg.x)) * this.world.SCALE) > 160) || ((Math.abs((cReg.y - tReg.y)) * this.world.SCALE) > 15))))
                                    {
                                        buffer = int((110 + (Math.random() * 50)));
                                        xBuffer = (((tReg.x - cReg.x) >= 0) ? -(buffer) : buffer);
                                        xBuffer = int((xBuffer * this.world.SCALE));
                                        if ((((tReg.x + xBuffer) < 0) || ((tReg.x + xBuffer) > 960)))
                                        {
                                            xBuffer = (xBuffer * -1);
                                        };
                                        buffer = int(((Math.random() * 30) - 15));
                                        yBuffer = (((tReg.y - cReg.y) >= 0) ? -(buffer) : buffer);
                                        yBuffer = int((yBuffer * this.world.SCALE));
                                        clientAvatar.pMC.walkTo((tReg.x + xBuffer), (tReg.y + yBuffer), 32);
                                    };
                                    if (clientAvatar.pMC.spFX != null)
                                    {
                                        clientAvatar.pMC.spFX.avt = clientAvatar.target;
                                    };
                                    cReg = clientAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    tReg = targetAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    if (clientAvatar != targetAvatar)
                                    {
                                        clientAvatar.pMC.turn((((tReg.x - cReg.x) >= 0) ? "right" : "left"));
                                    };
                                    if (!isNaN(Number(duration)))
                                    {
                                        clientAvatar.pMC.spellDur = duration;
                                    };
                                    if (animStr.indexOf(",") > -1)
                                    {
                                        animStr = animStr.split(",")[Math.round((Math.random() * (animStr.split(",").length - 1)))];
                                    };
                                    if (((!(animStr == "Thrash")) || (!(clientAvatar.pMC.mcChar.currentLabel == "Thrash"))))
                                    {
                                        clientAvatar.pMC.queueAnim(animStr);
                                    };
                                    if (((isProc) && (clientAvatar.pMC.mcChar.weapon.mcWeapon.isProc)))
                                    {
                                        clientAvatar.pMC.mcChar.weapon.mcWeapon.gotoAndPlay("Proc");
                                    };
                                };
                            };
                            return;
                    };
                };
            };
        }

        public function talk(_arg1:*):void
        {
            if (_arg1.accept)
            {
                this.chatF.submitMsg(_arg1.emote1, "emote", this.network.myUserName);
            }
            else
            {
                this.chatF.submitMsg(_arg1.emote2, "emote", this.network.myUserName);
            };
        }

        public function decHex(_arg1:*):String
        {
            return (_arg1.toString(16));
        }

        public function hexDec(_arg1:*):int
        {
            return (parseInt(_arg1, 16));
        }

        public function modColor(_arg1:*, _arg2:*, _arg3:*):*
        {
            var _local5:*;
            var _local6:*;
            var _local7:*;
            var _local4:* = "";
            var _local8:* = 0;
            while (_local8 < 3)
            {
                _local5 = this.hexDec(_arg1.substr((_local8 * 2), 2));
                _local6 = this.hexDec(_arg2.substr((_local8 * 2), 2));
                switch (_arg3)
                {
                    case "-":
                    default:
                        _local7 = (_local5 - _local6);
                        if (_local7 < 0)
                        {
                            _local7 = 0;
                        };
                        _local7 = this.decHex(_local7);
                        break;
                    case "+":
                        _local7 = (_local5 + _local6);
                        if (_local7 > 0xFF)
                        {
                            _local7 = 0xFF;
                        };
                        _local7 = this.decHex(_local7);
                };
                _local4 = (_local4 + String(((_local7.length < 2) ? ("0" + _local7) : _local7)));
                _local8++;
            };
            return (_local4);
        }

        public function maskStringBetween(_arg1:String, _arg2:Array):String
        {
            var _local4:int;
            var _local5:int;
            var _local3:* = "";
            if (((_arg2.length > 0) && ((_arg2.length % 2) == 0)))
            {
                _local4 = 0;
                _local5 = 0;
                while (_local5 < _arg1.length)
                {
                    if (((_local5 >= _arg2[_local4]) && (_local5 <= _arg2[(_local4 + 1)])))
                    {
                        if (_arg1.charAt(_local5) == " ")
                        {
                            _local3 = (_local3 + " ");
                        }
                        else
                        {
                            _local3 = (_local3 + "*");
                        };
                        if (_local5 == _arg2[(_local4 + 1)])
                        {
                            _local4 = (_local4 + 2);
                        };
                    }
                    else
                    {
                        _local3 = (_local3 + _arg1.charAt(_local5));
                    };
                    _local5++;
                };
            };
            return (_local3);
        }

        public function arraySort(_arg1:String, _arg2:String):int
        {
            if (_arg1 > _arg2)
            {
                return (1);
            };
            if (_arg1 < _arg2)
            {
                return (-1);
            };
            return (0);
        }

        public function strToProperCase(value:String):String
        {
            if (value.length == 0)
            {
                return (value);
            };
            return (value.charAt(0).toUpperCase() + value.substring(1).toLowerCase());
        }

        public function strNumWithCommas(value:Number):String
        {
            var _local4:int;
            var _local2:String = "";
            var _local3:String = value.toString();
            var _local5:int;
            _local4 = (_local3.length - 1);
            while (_local4 > -1)
            {
                if (_local5 == 3)
                {
                    _local5 = 0;
                    _local2 = ((_local3.charAt(_local4) + ",") + _local2);
                }
                else
                {
                    _local2 = (_local3.charAt(_local4) + _local2);
                };
                _local5++;
                _local4--;
            };
            return (_local2);
        }

        public function numToStr(_arg1:Number, _arg2:int=2):String
        {
            var _local3:String = _arg1.toString();
            if (_local3.indexOf(".") == -1)
            {
                _local3 = (_local3 + ".");
            };
            var _local4:Array = _local3.split(".");
            while (_local4[1].length < _arg2)
            {
                _local4[1] = (_local4[1] + "0");
            };
            if (_local4[1].length > _arg2)
            {
                _local4[1] = _local4[1].substr(0, _arg2);
            };
            if (_arg2 > 0)
            {
                _local3 = ((_local4[0] + ".") + _local4[1]);
            }
            else
            {
                _local3 = _local4[0];
            };
            return (_local3);
        }

        public function copyObj(obj:Object):Object
        {
            var ba:ByteArray = new ByteArray();
            ba.writeObject(obj);
            ba.position = 0;
            return (ba.readObject());
        }

        public function copyConstructor(_arg1:*):*
        {
            var _local2:ByteArray = new ByteArray();
            _local2.writeObject(_arg1);
            _local2.position = 0;
            return (_local2.readObject() as Class);
        }

        public function distanceO(_arg1:*, _arg2:*):Number
        {
            return (Math.sqrt((Math.pow(int((_arg2.x - _arg1.x)), 2) + Math.pow(int((_arg2.y - _arg1.y)), 2))));
        }

        public function distanceP(_arg1:*, _arg2:*, _arg3:*, _arg4:*):Number
        {
            return (Math.sqrt((Math.pow((_arg3 - _arg1), 2) + Math.pow((_arg4 - _arg2), 2))));
        }

        public function distanceXY(_arg1:*, _arg2:*, _arg3:*, _arg4:*):Object
        {
            return ({
                "dx":(_arg3 - _arg1),
                "dy":(_arg4 - _arg2)
            });
        }

        public function isHouseItem(item:Item):Boolean
        {
            return (((item.sType == "House") || (item.sType == "Floor Item")) || (item.sType == "Wall Item"));
        }

        public function validateArmor(item:Item):Boolean
        {
            return (!((Number(item.iClass) > 0) && (this.world.myAvatar.getCPByID(item.iClass) < item.iReqCP)));
        }

        public function getItemInfoString(item:Item):String
        {
            var range:Number;
            var baseLvl:Number;
            var minDamage:Number;
            var maxDamage:Number;
            var parts:Array = [];
            parts.push((("<font size='14'><b>" + item.sName) + "</b></font><br>"));
            if ((((!(this.validateArmor(item))) && (item.iClass > 0)) && (item.iReqCP > 0)))
            {
                parts.push((((("<font size='11' color='#CC0000'>Requires " + item.sClass) + ", Rank ") + Rank.getRankFromPoints(item.iReqCP)) + ".</font><br>"));
            };
            if (((item.FactionID > 1) && (item.iReqRep > 0)))
            {
                parts.push((((("<font size='11' color='#CC0000'>Requires " + item.sFaction) + ", Rank ") + Rank.getRankFromPoints(item.iReqRep)) + ".</font><br>"));
            };
            if (((item.iQSindex >= 0) && (this.world.getQuestValue(item.iQSindex) < int(item.iQSvalue))))
            {
                parts.push((("<font size='11' color='#CC0000'>Requires completion of quest \"" + item.sQuest) + '".</font><br>'));
            };
            parts.push(("<font color='#009900'><b>" + this.getDisplaysType(item)));
            if ((((!(item.sES == "None")) && (!(item.sES == "co"))) && (!(item.sES == "mi"))))
            {
                if (item.EnhID > 0)
                {
                    parts.push((", Lvl " + item.EnhLvl));
                    if (item.sES == "Weapon")
                    {
                        range = (item.iRng / 100);
                        baseLvl = (Math.round((this.getBaseHPByLevel(item.EnhLvl) / 20)) << 1);
                        minDamage = Math.floor((baseLvl - (baseLvl * range)));
                        maxDamage = Math.ceil((baseLvl + (baseLvl * range)));
                        parts.push(((((("<br>" + minDamage) + " - ") + maxDamage) + " ") + item.sElmt));
                    };
                }
                else
                {
                    parts.push(" Design");
                };
            };
            parts.push((("</b></font><br>" + item.sDesc) + "<br>"));
            return (parts.join(""));
        }

        public function getItemInfoStringB(item:Item):String
        {
            var parts:Array = [];
            parts.push((("<font size='12'><b>" + item.sName) + "</b></font><br>"));
            var displayType:String = this.getDisplaysType(item);
            if (((!(this.validateArmor(item))) && (item.iClass > 0)))
            {
                parts.push((((("<font size='10' color='#CC0000'>Requires " + item.sClass) + ", Rank ") + Rank.getRankFromPoints(item.iReqCP)) + ".</font><br>"));
            };
            if (((item.FactionID > 1) && (this.world.myAvatar.getRep(item.FactionID) < item.iReqRep)))
            {
                parts.push((((("<font size='10' color='#CC0000'>Requires " + item.sFaction) + ", Rank ") + Rank.getRankFromPoints(item.iReqRep)) + ".</font><br>"));
            };
            if (((item.iQSindex >= 0) && (this.world.getQuestValue(item.iQSindex) < item.iQSvalue)))
            {
                parts.push((("<font size='11' color='#CC0000'>Requires completion of quest \"" + item.sQuest) + '".</font><br>'));
            };
            if (((item.iReqGuildLevel > 0) && ((this.world.myAvatar.objData.guild == null) || (item.iReqGuildLevel > this.world.myAvatar.objData.guild.Level))))
            {
                parts.push((("<font size='11' color='#CC0000'>Requires guild level " + item.iReqGuildLevel) + ".</font><br>"));
            };
            parts.push(((((!(item.sMeta == null)) && (displayType == "Pet")) && (item.sMeta.indexOf("BattlePet") > -1)) ? ("<font color='#00CCFF'><b>Battle " + displayType) : ("<font color='#00CCFF'><b>" + displayType)));
            if (item.sType.toLowerCase() == "enhancement")
            {
                parts.push((", Level " + item.iLvl));
            };
            if (((((!(item.sES == "None")) && (!(item.sES == "co"))) && (!(item.sES == "pe"))) && (!(item.sES == "mi"))))
            {
                if (((item.EnhID > 0) || (item.sES == "ar")))
                {
                    parts.push((", Level " + item.EnhLvl));
                    if (item.sES == "ar")
                    {
                        parts.push(("<br>Rank " + Rank.getRankFromPoints(item.iQty)));
                    };
                }
                else
                {
                    if (item.sType.toLowerCase() != "enhancement")
                    {
                        parts.push(" Design");
                    };
                };
            };
            if (((((((((item.sES == "Weapon") || (item.sES == "co")) || (item.sES == "he")) || (item.sES == "ba")) || (item.sES == "pe")) || (item.sES == "am")) || (item.sES == "mi")) && (!(item.sType.toLowerCase() == "enhancement"))))
            {
                parts.push((("<br>" + item.rarity) + " Rarity"));
            };
            if (item.sType.toLowerCase() != "enhancement")
            {
                parts.push((("</b></font><br><font size='10' color='#FFFFFF'>" + item.sDesc) + "<br></font>"));
            }
            else
            {
                parts.push("</b></font><br><font size='10' color='#FFFFFF'>Enhancements are special items which can apply stats to your weapons and armor. Select a weapon or armor item from the list on the right, and click the <font color='#00CCFF'>\"Enhancements\"</font> button that appears below its preview.");
            };
            return (parts.join(""));
        }

        public function getIconByType(_arg1:String):String
        {
            switch (_arg1.toLowerCase())
            {
                case "axe":
                case "bow":
                case "dagger":
                case "gun":
                case "mace":
                case "polearm":
                case "staff":
                case "sword":
                case "wand":
                case "armor":
                    return ("iw" + _arg1.toLowerCase());
                case "cape":
                case "helm":
                case "pet":
                case "class":
                    return ("ii" + _arg1.toLowerCase());
                default:
                    return ("iibag");
            };
        }

        public function getIconBySlot(_arg1:String):String
        {
            switch (_arg1.toLowerCase())
            {
                case "weapon":
                    return ("iwsword");
                case "back":
                case "ba":
                    return ("iicape");
                case "head":
                case "he":
                    return ("iihelm");
                case "armor":
                case "ar":
                    return ("iiclass");
                case "class":
                    return ("iiclass");
                case "pet":
                case "pe":
                    return ("iipet");
                default:
                    return ("iibag");
            };
        }

        public function getDisplaysType(item:Object):String
        {
            var _type:String = ((item.sType != null) ? item.sType : "Unknown");
            var _typeLower:String = _type.toLowerCase();
            if (((_typeLower == "clientuse") || (_typeLower == "serveruse")))
            {
                return ("Item");
            };
            if (_typeLower == "misc")
            {
                return ("Ground");
            };
            return (_type);
        }

        public function stringToDate(dateString:String):Date
        {
            var _local2:Number = Number(dateString.substr(0, 4));
            var _local3:Number = (Number(dateString.substr(5, 2)) - 1);
            var _local4:Number = Number(dateString.substr(8, 2));
            var _local5:Number = Number(dateString.substr(11, 2));
            var _local6:Number = Number(dateString.substr(14, 2));
            var _local7:Number = Number(dateString.substr(17));
            return (new Date(_local2, _local3, _local4, _local5, _local6, _local7));
        }

        public function max(_arg1:int, _arg2:int):int
        {
            return ((_arg1 > _arg2) ? _arg1 : _arg2);
        }

        public function clamp(_arg1:Number, _arg2:Number, _arg3:Number):Number
        {
            if (_arg1 < _arg2)
            {
                return (_arg2);
            };
            if (_arg1 > _arg3)
            {
                return (_arg3);
            };
            return (_arg1);
        }

        public function isValidEmail(_arg1:String):Boolean
        {
            return (Boolean(_arg1.match(/^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i)));
        }

        public function closeToolTip():void
        {
            var _local1:*;
            try
            {
                _local1 = MovieClip(stage.getChildAt(0)).ui.ToolTip;
                _local1.close();
            }
            catch(e:Error)
            {
            };
        }

        public function updateIcons(iconList:Array, classList:Array, item:Item=null):void
        {
            var icon:ib2;
            var iconBgWidth:Number;
            var iconBgHeight:Number;
            var j:int;
            var offset:Number;
            var cls:Class;
            var iconInstance:DisplayObject;
            var iconWidth:Number;
            var iconHeight:Number;
            var value:Number;
            var i:int;
            while (i < iconList.length)
            {
                icon = iconList[i];
                icon.cnt.removeChildren();
                if (item == null)
                {
                    icon.tQty.visible = false;
                }
                else
                {
                    icon.item = item;
                };
                iconBgWidth = (icon.bg.width >> 1);
                iconBgHeight = (icon.bg.height >> 1);
                j = 0;
                while (j < classList.length)
                {
                    offset = int((31 + (j << 2)));
                    cls = this.world.getClass(classList[j]);
                    if (cls == null)
                    {
                    }
                    else
                    {
                        iconInstance = icon.cnt.addChild(new (cls)());
                        iconWidth = iconInstance.width;
                        iconHeight = iconInstance.height;
                        value = Math.min((offset / iconWidth), (offset / iconHeight));
                        iconInstance.scaleX = value;
                        iconInstance.scaleY = value;
                        iconInstance.x = (iconBgWidth - (iconInstance.width >> 1));
                        iconInstance.y = (iconBgHeight - (iconInstance.height >> 1));
                    };
                    j++;
                };
                i++;
            };
        }

        public function updateActionObjIcon(action:Skill):void
        {
            var _local3:MovieClip;
            var _local4:Object;
            var _local6:int;
            var _local7:int;
            var _local2:Array = this.world.getActIcons(action);
            var _local5:* = 0;
            while (_local5 < _local2.length)
            {
                _local3 = _local2[_local5];
                _local4 = _local3.item;
                if (_local4 != null)
                {
                    _local6 = 0;
                    while (_local7 < this.world.myAvatar.items.length)
                    {
                        if (this.world.myAvatar.items[_local7].ItemID == _local4.ItemID)
                        {
                            _local6 = int(this.world.myAvatar.items[_local7].iQty);
                        };
                        _local7++;
                    };
                    if (_local6 > 0)
                    {
                        _local3.tQty.visible = true;
                        _local3.tQty.text = _local6;
                    }
                    else
                    {
                        this.world.unequipUseableItem(_local4);
                    };
                };
                _local5++;
            };
        }

        public function drawChainsSmooth(_arg1:Array, _arg2:int, _arg3:MovieClip):void
        {
            var _local4:Point;
            var _local5:Point;
            var _local6:int;
            var _local7:Array;
            var _local8:int;
            var _local9:int;
            var _local10:int;
            var _local11:Point;
            var _local12:Array;
            var _local13:MovieClip;
            var _local14:int;
            var _local15:int;
            _local6 = 1;
            while (_local6 < _arg1.length)
            {
                _local4 = new Point(0, 0);
                _local5 = new Point(0, 0);
                _local4 = _arg1[(_local6 - 1)].localToGlobal(_local4);
                _local5 = _arg1[_local6].localToGlobal(_local5);
                _local7 = [];
                _local8 = 0;
                _local9 = 0;
                _local10 = int(Math.ceil((Point.distance(_local4, _local5) / _arg2)));
                if ((_local10 % 2) == 1)
                {
                    _local10++;
                };
                _local11 = new Point();
                _local12 = [_arg3.fx0, _arg3.fx1, _arg3.fx2];
                _local14 = -1;
                _local8 = 0;
                while (_local8 < _local12.length)
                {
                    _local7 = [];
                    _local14 = int(((Math.random() > 0.5) ? 1 : -1));
                    _local15 = 0;
                    _local9 = 1;
                    while (_local9 < _local10)
                    {
                        _local11 = Point.interpolate(_local4, _local5, (1 - (_local9 / _local10)));
                        _local15++;
                        if ((_local15 % 2) == 1)
                        {
                            _local11.x = (_local11.x + (_local14 * Math.round((Math.random() * 30))));
                            _local11.y = (_local11.y + (_local14 * Math.round((Math.random() * 30))));
                            _local14 = -(_local14);
                        };
                        _local7.push(_local11);
                        _local9++;
                    };
                    _local7.push(_local5);
                    _local13 = _local12[_local8];
                    _local13.graphics.lineStyle(2, 0xFFFFFF, 1);
                    _local13.graphics.moveTo(_local4.x, _local4.y);
                    _local9 = 0;
                    while (_local9 < _local7.length)
                    {
                        _local13.graphics.curveTo(_local7[_local9].x, _local7[_local9].y, _local7[(_local9 + 1)].x, _local7[(_local9 + 1)].y);
                        _local9 = (_local9 + 2);
                    };
                    _local8++;
                };
                _local6++;
            };
        }

        public function drawChainsLinear(_arg1:Array, _arg2:int, _arg3:MovieClip):void
        {
            var _local4:Point;
            var _local5:Point;
            var _local6:MovieClip;
            var _local7:MovieClip;
            var _local8:int;
            var _local9:Array;
            var _local10:int;
            var _local11:int;
            var _local12:int;
            var _local13:Point;
            var _local14:Array;
            var _local15:MovieClip;
            _local8 = 1;
            while (_local8 < _arg1.length)
            {
                _local6 = _arg1[(_local8 - 1)];
                _local7 = _arg1[_local8];
                _local4 = new Point(0, (-(_local6.height) * 0.5));
                _local5 = new Point(0, (-(_local7.height) * 0.5));
                _local4 = _local6.localToGlobal(_local4);
                _local5 = _local7.localToGlobal(_local5);
                _local9 = [];
                _local10 = 0;
                _local11 = 0;
                _local12 = int(Math.ceil((Point.distance(_local4, _local5) / _arg2)));
                _local13 = new Point();
                _local14 = [_arg3.fx0, _arg3.fx1, _arg3.fx2];
                _local10 = 0;
                while (_local10 < _local14.length)
                {
                    _local9 = [];
                    _local11 = 1;
                    while (_local11 < _local12)
                    {
                        _local13 = Point.interpolate(_local4, _local5, (1 - (_local11 / (_local12 + 1))));
                        _local13.x = (_local13.x + Math.round(((Math.random() * 25) - 13)));
                        _local13.y = (_local13.y + Math.round(((Math.random() * 25) - 13)));
                        _local9.push(_local13);
                        _local11++;
                    };
                    _local15 = _local14[_local10];
                    _local15.graphics.lineStyle(5, 0xFFFFFF, 1);
                    _local15.graphics.moveTo(_local4.x, _local4.y);
                    _local11 = 0;
                    while (_local11 < _local9.length)
                    {
                        _local15.graphics.lineTo(_local9[_local11].x, _local9[_local11].y);
                        _local11++;
                    };
                    _local15.graphics.lineTo(_local5.x, _local5.y);
                    _local10++;
                };
                _local8++;
            };
        }

        public function drawFunnel(_arg1:Array, _arg2:MovieClip):void
        {
            var _local3:MovieClip;
            var _local4:int;
            var _local5:int;
            var _local6:int;
            _arg2.numLines = 3;
            _arg2.lineThickness = 3;
            _arg2.lineColors = [0x9900AA, 0, 0x220066];
            _arg2.glowColors = [0];
            _arg2.glowStrength = 4;
            _arg2.glowSize = 4;
            _arg2.dur = 500;
            _arg2.del = 100;
            _arg2.p1StartingValue = 0.12;
            _arg2.p2StartingValue = 0.24;
            _arg2.p3StartingValue = 0.36;
            _arg2.p1EndingValue = 0.66;
            _arg2.p2EndingValue = 0.825;
            _arg2.p3EndingValue = 0.99;
            _arg2.p1ScaleFactor = 0.5;
            _arg2.p3ScaleFactor = 0.5;
            _arg2.easingExponent = 1.5;
            _arg2.targetMCs = _arg1;
            _arg2.filterArr = [];
            _arg2.fxArr = [];
            _arg2.ts = new Date().getTime();
            _local4 = 0;
            while (_local4 < _arg2.glowColors.length)
            {
                _arg2.filterArr.push([new GlowFilter(_arg2.glowColors[_local4], 1, _arg2.glowSize, _arg2.glowSize, _arg2.glowStrength, 1, false, false)]);
                _local4++;
            };
            _local4 = 0;
            _local5 = 0;
            while (_local6 < _arg2.numLines)
            {
                _local3 = (_arg2.addChild(new MovieClip()) as MovieClip);
                _local3.filters = _arg2.filterArr[_local4];
                _local4++;
                if (_local4 >= _arg2.glowColors.length)
                {
                    _local4 = 0;
                };
                _local3.lineColor = _arg2.lineColors[_local5];
                _local5++;
                if (_local5 >= _arg2.lineColors.length)
                {
                    _local5 = 0;
                };
                _arg2.fxArr.push(_local3);
                _local6++;
            };
            _arg2.addEventListener(Event.ENTER_FRAME, funnelEF, false, 0, true);
        }

        public function updateCoreValues(_arg1:Object):void
        {
            if (_arg1.intLevelCap != null)
            {
                this.intLevelCap = _arg1.intLevelCap;
            };
            if (_arg1.PCstBase != null)
            {
                this.PCstBase = _arg1.PCstBase;
            };
            if (_arg1.PCstRatio != null)
            {
                this.PCstRatio = _arg1.PCstRatio;
            };
            if (_arg1.PCstGoal != null)
            {
                this.PCstGoal = _arg1.PCstGoal;
            };
            if (_arg1.GstBase != null)
            {
                this.GstBase = _arg1.GstBase;
            };
            if (_arg1.GstRatio != null)
            {
                this.GstRatio = _arg1.GstRatio;
            };
            if (_arg1.GstGoal != null)
            {
                this.GstGoal = _arg1.GstGoal;
            };
            if (_arg1.PChpBase1 != null)
            {
                this.PChpBase1 = _arg1.PChpBase1;
            };
            if (_arg1.PChpBase100 != null)
            {
                this.PChpBase100 = _arg1.PChpBase100;
            };
            if (_arg1.PChpGoal1 != null)
            {
                this.PChpGoal1 = _arg1.PChpGoal1;
            };
            if (_arg1.PChpGoal100 != null)
            {
                this.PChpGoal100 = _arg1.PChpGoal100;
            };
            if (_arg1.PChpDelta != null)
            {
                this.PChpDelta = _arg1.PChpDelta;
            };
            if (_arg1.intHPperEND != null)
            {
                this.intHPperEND = _arg1.intHPperEND;
            };
            if (_arg1.intAPtoDPS != null)
            {
                this.intAPtoDPS = _arg1.intAPtoDPS;
            };
            if (_arg1.intSPtoDPS != null)
            {
                this.intSPtoDPS = _arg1.intSPtoDPS;
            };
            if (_arg1.bigNumberBase != null)
            {
                this.bigNumberBase = _arg1.bigNumberBase;
            };
            if (_arg1.resistRating != null)
            {
                this.resistRating = _arg1.resistRating;
            };
            if (_arg1.modRating != null)
            {
                this.modRating = _arg1.modRating;
            };
            if (_arg1.baseDodge != null)
            {
                this.baseDodge = _arg1.baseDodge;
            };
            if (_arg1.baseBlock != null)
            {
                this.baseBlock = _arg1.baseBlock;
            };
            if (_arg1.baseParry != null)
            {
                this.baseParry = _arg1.baseParry;
            };
            if (_arg1.baseCrit != null)
            {
                this.baseCrit = _arg1.baseCrit;
            };
            if (_arg1.baseHit != null)
            {
                this.baseHit = _arg1.baseHit;
            };
            if (_arg1.baseHaste != null)
            {
                this.baseHaste = _arg1.baseHaste;
            };
            if (_arg1.baseMiss != null)
            {
                this.baseMiss = _arg1.baseMiss;
            };
            if (_arg1.baseResist != null)
            {
                this.baseResist = _arg1.baseResist;
            };
            if (_arg1.baseCritValue != null)
            {
                this.baseCritValue = _arg1.baseCritValue;
            };
            if (_arg1.baseBlockValue != null)
            {
                this.baseBlockValue = _arg1.baseBlockValue;
            };
            if (_arg1.baseResistValue != null)
            {
                this.baseResistValue = _arg1.baseResistValue;
            };
            if (_arg1.baseEventValue != null)
            {
                this.baseEventValue = _arg1.baseEventValue;
            };
            if (_arg1.PCDPSMod != null)
            {
                this.PCDPSMod = _arg1.PCDPSMod;
            };
            if (_arg1.curveExponent != null)
            {
                this.curveExponent = _arg1.curveExponent;
            };
            if (_arg1.statsExponent != null)
            {
                this.statsExponent = _arg1.statsExponent;
            };
        }

        public function applyCoreStatRatings(_arg1:Object, _arg2:Object):void
        {
            var _local18:int;
            var _local3:int = 1;
            var _local4:* = 100;
            var _local5:Object = this.world.myAvatar.getEquippedItemBySlot("Weapon");
            if (_local5 != null)
            {
                if (_local5.EnhLvl != null)
                {
                    _local3 = _local5.EnhLvl;
                };
                if (_local5.EnhDPS != null)
                {
                    _local4 = Number(_local5.EnhDPS);
                };
                if (_local4 == 0)
                {
                    _local4 = 100;
                };
            };
            _local4 = (_local4 / 100);
            var _local6:int = _arg2.intLevel;
            var _local7:* = "";
            var _local8:int = this.getInnateStats(_local6);
            var _local9:Number = -1;
            var _local10:Number = -1;
            var _local11:Number = -1;
            var _local12:int = -1;
            var _local13:String = this.world.myAvatar.objData.sClassCat;
            var _local14:int = this.getBaseHPByLevel(_local6);
            var _local15:int = 20;
            var _local16:* = ((_local14 / 20) * 0.7);
            var _local17:Number = (((2.25 * _local16) / (100 / this.intAPtoDPS)) / 2);
            this.resetTableValues(_arg1);
            while (_local18 < MainController.stats.length)
            {
                _local7 = MainController.stats[_local18];
                _local12 = (_arg1[("_" + _local7)] + _arg1[("^" + _local7)]);
                switch (_local7)
                {
                    case "STR":
                        _local9 = _local17;
                        if (_local13 == "M1")
                        {
                            _arg1.$sbm = (_arg1.$sbm - (((_local12 / _local9) / 100) * 0.3));
                        };
                        if (_local13 == "S1")
                        {
                            _arg1.$ap = (_arg1.$ap + Math.round((_local12 * 1.4)));
                        }
                        else
                        {
                            _arg1.$ap = (_arg1.$ap + (_local12 * 2));
                        };
                        if ((((((_local13 == "M1") || (_local13 == "M2")) || (_local13 == "M3")) || (_local13 == "M4")) || (_local13 == "S1")))
                        {
                            if (_local13 == "M4")
                            {
                                _arg1.$tcr = (_arg1.$tcr + (((_local12 / _local9) / 100) * 0.7));
                            }
                            else
                            {
                                _arg1.$tcr = (_arg1.$tcr + (((_local12 / _local9) / 100) * 0.4));
                            };
                        };
                        break;
                    case "INT":
                        _local9 = _local17;
                        _arg1.$cmi = (_arg1.$cmi - ((_local12 / _local9) / 100));
                        if (((_local13.substr(0, 1) == "C") || (_local13 == "M3")))
                        {
                            _arg1.$cmo = (_arg1.$cmo + ((_local12 / _local9) / 100));
                        };
                        if (_local13 == "S1")
                        {
                            _arg1.$sp = (_arg1.$sp + Math.round((_local12 * 1.4)));
                        }
                        else
                        {
                            _arg1.$sp = (_arg1.$sp + (_local12 * 2));
                        };
                        if ((((((_local13 == "C1") || (_local13 == "C2")) || (_local13 == "C3")) || (_local13 == "M3")) || (_local13 == "S1")))
                        {
                            if (_local13 == "C2")
                            {
                                _arg1.$tha = (_arg1.$tha + (((_local12 / _local9) / 100) * 0.5));
                            }
                            else
                            {
                                _arg1.$tha = (_arg1.$tha + (((_local12 / _local9) / 100) * 0.3));
                            };
                        };
                        break;
                    case "DEX":
                        _local9 = _local17;
                        if ((((((_local13 == "M1") || (_local13 == "M2")) || (_local13 == "M3")) || (_local13 == "M4")) || (_local13 == "S1")))
                        {
                            if (_local13.substr(0, 1) != "C")
                            {
                                _arg1.$thi = (_arg1.$thi + (((_local12 / _local9) / 100) * 0.2));
                            };
                            if (((_local13 == "M2") || (_local13 == "M4")))
                            {
                                _arg1.$tha = (_arg1.$tha + (((_local12 / _local9) / 100) * 0.5));
                            }
                            else
                            {
                                _arg1.$tha = (_arg1.$tha + (((_local12 / _local9) / 100) * 0.3));
                            };
                            if (_local13 == "M1")
                            {
                                if (_arg1._tbl > 0.01)
                                {
                                    _arg1.$tbl = (_arg1.$tbl + (((_local12 / _local9) / 100) * 0.5));
                                };
                            };
                        };
                        if (((!(_local13 == "M2")) && (!(_local13 == "M3"))))
                        {
                            _arg1.$tdo = (_arg1.$tdo + (((_local12 / _local9) / 100) * 0.3));
                        }
                        else
                        {
                            _arg1.$tdo = (_arg1.$tdo + (((_local12 / _local9) / 100) * 0.5));
                        };
                        break;
                    case "WIS":
                        _local9 = _local17;
                        if (((((_local13 == "C1") || (_local13 == "C2")) || (_local13 == "C3")) || (_local13 == "S1")))
                        {
                            if (_local13 == "C1")
                            {
                                _arg1.$tcr = (_arg1.$tcr + (((_local12 / _local9) / 100) * 0.7));
                            }
                            else
                            {
                                _arg1.$tcr = (_arg1.$tcr + (((_local12 / _local9) / 100) * 0.4));
                            };
                            _arg1.$thi = (_arg1.$thi + (((_local12 / _local9) / 100) * 0.2));
                        };
                        _arg1.$tdo = (_arg1.$tdo + (((_local12 / _local9) / 100) * 0.3));
                        break;
                    case "LCK":
                        _local9 = _local17;
                        _arg1.$sem = (_arg1.$sem + (((_local12 / _local9) / 100) * 2));
                        if (_local13 == "S1")
                        {
                            _arg1.$ap = (_arg1.$ap + Math.round((_local12 * 1)));
                            _arg1.$sp = (_arg1.$sp + Math.round((_local12 * 1)));
                            _arg1.$tcr = (_arg1.$tcr + (((_local12 / _local9) / 100) * 0.3));
                            _arg1.$thi = (_arg1.$thi + (((_local12 / _local9) / 100) * 0.1));
                            _arg1.$tha = (_arg1.$tha + (((_local12 / _local9) / 100) * 0.3));
                            _arg1.$tdo = (_arg1.$tdo + (((_local12 / _local9) / 100) * 0.25));
                            _arg1.$scm = (_arg1.$scm + (((_local12 / _local9) / 100) * 2.5));
                        }
                        else
                        {
                            if (((((_local13 == "M1") || (_local13 == "M2")) || (_local13 == "M3")) || (_local13 == "M4")))
                            {
                                _arg1.$ap = (_arg1.$ap + Math.round((_local12 * 0.7)));
                            };
                            if (((((_local13 == "C1") || (_local13 == "C2")) || (_local13 == "C3")) || (_local13 == "M3")))
                            {
                                _arg1.$sp = (_arg1.$sp + Math.round((_local12 * 0.7)));
                            };
                            _arg1.$tcr = (_arg1.$tcr + (((_local12 / _local9) / 100) * 0.2));
                            _arg1.$thi = (_arg1.$thi + (((_local12 / _local9) / 100) * 0.1));
                            _arg1.$tha = (_arg1.$tha + (((_local12 / _local9) / 100) * 0.1));
                            _arg1.$tdo = (_arg1.$tdo + (((_local12 / _local9) / 100) * 0.1));
                            _arg1.$scm = (_arg1.$scm + (((_local12 / _local9) / 100) * 5));
                        };
                        break;
                };
                _local18++;
            };
            _arg1.wDPS = (Math.round((((this.getBaseHPByLevel(_local3) / _local15) * _local4) * this.PCDPSMod)) + Math.round((_arg1.$ap / this.intAPtoDPS)));
            _arg1.mDPS = (Math.round((((this.getBaseHPByLevel(_local3) / _local15) * _local4) * this.PCDPSMod)) + Math.round((_arg1.$sp / this.intSPtoDPS)));
        }

        public function coeffToPct(_arg1:Number):String
        {
            return (Number((_arg1 * 100)).toFixed(2));
        }

        public function resetTableValues(_arg1:Object):void
        {
            _arg1._ap = 0;
            _arg1.$ap = 0;
            _arg1._sp = 0;
            _arg1.$sp = 0;
            _arg1._tbl = 0;
            _arg1._tpa = 0;
            _arg1._tdo = 0;
            _arg1._tcr = 0;
            _arg1._thi = 0;
            _arg1._tha = 0;
            _arg1._tre = 0;
            _arg1.$tbl = this.baseBlock;
            _arg1.$tpa = this.baseParry;
            _arg1.$tdo = this.baseDodge;
            _arg1.$tcr = this.baseCrit;
            _arg1.$thi = this.baseHit;
            _arg1.$tha = this.baseHaste;
            _arg1.$tre = this.baseResist;
            _arg1._cpo = 1;
            _arg1._cpi = 1;
            _arg1._cao = 1;
            _arg1._cai = 1;
            _arg1._cmo = 1;
            _arg1._cmi = 1;
            _arg1._cdo = 1;
            _arg1._cdi = 1;
            _arg1._cho = 1;
            _arg1._chi = 1;
            _arg1._cmc = 1;
            _arg1.$cpo = 1;
            _arg1.$cpi = 1;
            _arg1.$cao = 1;
            _arg1.$cai = 1;
            _arg1.$cmo = 1;
            _arg1.$cmi = 1;
            _arg1.$cdo = 1;
            _arg1.$cdi = 1;
            _arg1.$cho = 1;
            _arg1.$chi = 1;
            _arg1.$cmc = 1;
            _arg1._scm = this.baseCritValue;
            _arg1._sbm = this.baseBlockValue;
            _arg1._srm = this.baseResistValue;
            _arg1._sem = this.baseEventValue;
            _arg1.$scm = this.baseCritValue;
            _arg1.$sbm = this.baseBlockValue;
            _arg1.$srm = this.baseResistValue;
            _arg1.$sem = this.baseEventValue;
            _arg1._shb = 0;
            _arg1._smb = 0;
            _arg1.$shb = 0;
            _arg1.$smb = 0;
        }

        public function getCategoryStats(_arg1:String, _arg2:int):Object
        {
            var _local7:int;
            var _local3:* = this.getInnateStats(_arg2);
            var _local4:* = this.classCatMap[_arg1].ratios;
            var _local5:* = {};
            var _local6:* = "";
            while (_local7 < MainController.stats.length)
            {
                _local6 = MainController.stats[_local7];
                _local5[_local6] = Math.round((_local4[_local7] * _local3));
                _local7++;
            };
            return (_local5);
        }

        public function applyAuraEffect(_arg1:*, _arg2:*):*
        {
            switch (_arg1.typ)
            {
                case "+":
                    _arg2[("$" + _arg1.sta)] = (_arg2[("$" + _arg1.sta)] + Number(_arg1.val));
                    return;
                case "-":
                    _arg2[("$" + _arg1.sta)] = (_arg2[("$" + _arg1.sta)] - Number(_arg1.val));
                    return;
                case "*":
                    _arg2[("$" + _arg1.sta)] = Math.round((_arg2[("$" + _arg1.sta)] * Number(_arg1.val)));
                    return;
            };
        }

        public function removeAuraEffect(_arg1:*, _arg2:*):*
        {
            switch (_arg1.typ)
            {
                case "+":
                    _arg2[("$" + _arg1.sta)] = (_arg2[("$" + _arg1.sta)] - Number(_arg1.val));
                    return;
                case "-":
                    _arg2[("$" + _arg1.sta)] = (_arg2[("$" + _arg1.sta)] + Number(_arg1.val));
                    return;
                case "*":
                    _arg2[("$" + _arg1.sta)] = Math.round((_arg2[("$" + _arg1.sta)] / Number(_arg1.val)));
            };
        }

        public function getStatsA(_arg1:Object, _arg2:String):Object
        {
            var _local6:Object;
            var _local13:int;
            var _local15:*;
            var _local16:*;
            var _local17:*;
            _arg1 = ((_arg1 is Item) ? Item(_arg1) : new Item(_arg1));
            var _local3:int = ((_arg1.sType.toLowerCase() == "enhancement") ? _arg1.iLvl : _arg1.EnhLvl);
            var _local4:int = ((_arg1.sType.toLowerCase() == "enhancement") ? _arg1.iRty : _arg1.EnhRty);
            var _local5:int = Math.round((this.getIBudget(_local3, _local4) * this.ratiosBySlot[_arg2]));
            var _local7:* = -1;
            var _local8:* = ["iEND", "iSTR", "iINT", "iDEX", "iWIS", "iLCK"];
            var _local9:* = 0;
            var _local10:* = "";
            var _local11:* = {};
            var _local12:* = 0;
            var _local14:Object = {};
            if (_arg1.PatternID != -1)
            {
                _local6 = this.world.enhPatternTree[_arg1.PatternID];
            };
            if (_arg1.EnhPatternID != -1)
            {
                _local6 = this.world.enhPatternTree[_arg1.EnhPatternID];
            };
            if (_local6 != null)
            {
                _local13 = 0;
                while (_local13 < MainController.stats.length)
                {
                    _local10 = ("i" + MainController.stats[_local13]);
                    if (_local6[_local10] != null)
                    {
                        _local11[_local10] = Math.round(((_local5 * _local6[_local10]) / 100));
                        _local12 = (_local12 + _local11[_local10]);
                    };
                    _local13++;
                };
                _local9 = 0;
                while (_local12 < _local5)
                {
                    _local10 = _local8[_local9];
                    if (_local11[_local10] != null)
                    {
                        _local15 = _local11;
                        _local16 = _local10;
                        _local17 = (_local15[_local16] + 1);
                        _local15[_local16] = _local17;
                        _local12++;
                    };
                    _local9++;
                    if (_local9 > (_local8.length - 1))
                    {
                        _local9 = 0;
                    };
                };
                _local13 = 0;
                while (_local13 < MainController.stats.length)
                {
                    _local7 = _local11[("i" + MainController.stats[_local13])];
                    if (((!(_local7 == null)) && (!(_local7 == "0"))))
                    {
                        _local14[("$" + MainController.stats[_local13])] = _local7;
                    };
                    _local13++;
                };
            };
            return (_local14);
        }

        public function tryEnhance(_arg1:Object, _arg2:Object, _arg3:Boolean=false):void
        {
            if (((!(_arg1 == null)) && (!(_arg2 == null))))
            {
                if (_arg2.iLvl > this.world.myAvatar.objData.intLevel)
                {
                    this.MsgBox.notify("Level requirement not met!");
                }
                else
                {
                    if (_arg1.EnhID == _arg2.ItemID)
                    {
                        this.MsgBox.notify("Selected Enhancement already applied to item!");
                    }
                    else
                    {
                        if (_arg3)
                        {
                            this.world.sendEnhItemRequestShop(_arg1, _arg2);
                        }
                        else
                        {
                            this.world.sendEnhItemRequestLocal(_arg1, _arg2);
                        };
                    };
                };
            };
        }

        public function doIHaveEnhancements():Boolean
        {
            var _local1:Object;
            for each (_local1 in this.world.myAvatar.items)
            {
                if (_local1.sType.toLowerCase() == "enhancement")
                {
                    return (true);
                };
            };
            return (false);
        }

        public function resetInvTreeByItemID(_arg1:int):void
        {
            var ItemID:int = _arg1;
            var item:Object = this.world.invTree[ItemID];
            if (("EnhID" in item))
            {
                item.EnhID = -1;
            };
            if (("EnhRty" in item))
            {
                item.EnhRty = -1;
            };
            if (("EnhDPS" in item))
            {
                item.EnhDPS = -1;
            };
            if (("EnhRng" in item))
            {
                item.EnhRng = -1;
            };
            if (("EnhLvl" in item))
            {
                item.EnhLvl = -1;
            };
            if (("EnhPatternID" in item))
            {
                item.EnhPatternID = -1;
            };
        }

        public function isMergeShop(shop:ShopModel):Boolean
        {
            var item:Item;
            for each (item in shop.items)
            {
                if (item.turnin.length > 0)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function initWorld():void
        {
            this.logoutFinal();
            this.world = new World(this);
            this.addChildAt(this.world, getChildIndex(this.ui));
        }

        public function initLogin():void
        {
            var curTS:Number;
            var iDiff:Number;
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.key_StageLogin);
            this.mcLogin.ni.tabIndex = 1;
            this.mcLogin.pi.tabIndex = 2;
            this.mcLogin.ni.removeEventListener(FocusEvent.FOCUS_IN, this.onUserFocus);
            this.mcLogin.ni.removeEventListener(KeyboardEvent.KEY_DOWN, this.key_TextLogin);
            this.mcLogin.pi.removeEventListener(KeyboardEvent.KEY_DOWN, this.key_TextLogin);
            this.mcLogin.btnLogin.removeEventListener(MouseEvent.CLICK, this.onLoginClick);
            this.mcLogin.mcForgotPassword.removeEventListener(MouseEvent.CLICK, this.onForgotPassword);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.key_StageLogin);
            this.mcLogin.ni.addEventListener(FocusEvent.FOCUS_IN, this.onUserFocus);
            this.mcLogin.ni.addEventListener(KeyboardEvent.KEY_DOWN, this.key_TextLogin);
            this.mcLogin.pi.addEventListener(KeyboardEvent.KEY_DOWN, this.key_TextLogin);
            this.mcLogin.btnLogin.addEventListener(MouseEvent.CLICK, this.onLoginClick);
            this.mcLogin.mcForgotPassword.addEventListener(MouseEvent.CLICK, this.onForgotPassword);
            this.mcLogin.mcManageAccount.addEventListener(MouseEvent.CLICK, this.onManageClick);
            this.loadUserPreference();
            OptionMC.preferenceKeybind();
            this.mcLogin.WarningCounter.s = String("Sorry! You have been disconnected. \n You will be able to login after $s seconds.");
            this.mcLogin.WarningCounter.visible = false;
            if ((("logoutWarningTS" in this.userPreference.data) && (!(this.userPreference.data.logoutWarningTS == 0))))
            {
                curTS = new Date().getTime();
                iDiff = ((this.userPreference.data.logoutWarningTS + (this.userPreference.data.logoutWarningDur * 1000)) - curTS);
                if (iDiff > 1000)
                {
                    if (iDiff > 30000)
                    {
                        this.userPreference.data.logoutWarningDur = 60;
                        this.userPreference.data.logoutWarningTS = curTS;
                        try
                        {
                            this.userPreference.flush();
                        }
                        catch(e:Error)
                        {
                        };
                    };
                    this.initLoginWarning();
                };
            };
            if (((this.userPreference.data.bitCheckedUsername) && (this.firstLogin)))
            {
                this.firstLogin = false;
                this.login(this.userPreference.data.strUsername.toLowerCase(), this.userPreference.data.strPassword);
            };
        }

        public function getKeyboardDict():Dictionary
        {
            var keyName:String;
            var name:String;
            var keyboardInfo:XML = describeType(Keyboard);
            var keyNames:XMLList = keyboardInfo.constant.@name;
            var keyboardDict:Dictionary = new Dictionary();
            for each (name in keyNames)
            {
                keyName = name;
                if ((((name.indexOf("NUMBER_") > -1) || (name.indexOf("STRING_") > -1)) || (name.indexOf("KEYNAME_") > -1)))
                {
                    keyName = name.split("_")[1];
                };
                keyboardDict[Keyboard[name]] = keyName;
            };
            return (keyboardDict);
        }

        public function loadTitle():void
        {
            var cls:Class;
            if (((!(this._titleDomain == null)) && (this._titleDomain.hasDefinition("TitleScreen"))))
            {
                cls = (this._titleDomain.getDefinition("TitleScreen") as Class);
                this.mcLogin.mcTitle.removeChildAt(0);
                this.mcLogin.mcTitle.addChild(new (cls)());
                this.mcConnDetail.mcTitle.removeChildAt(0);
                this.mcConnDetail.mcTitle.addChild(new (cls)());
            };
        }

        public function onDisconnectTimer(context:MovieClip):Function
        {
            return (function (_arg_1:TimerEvent):void
            {
                if (context.WarningCounter.n-- < 1)
                {
                    context.WarningCounter.visible = false;
                    context.btnLogin.visible = true;
                    userPreference.data.logoutWarningTS = 0;
                    try
                    {
                        userPreference.flush();
                    }
                    catch(e:Error)
                    {
                    };
                    context.WarningCounter.timer.removeEventListener(TimerEvent.TIMER, onDisconnectTimer(context));
                    context.WarningCounter.timer.stop();
                }
                else
                {
                    context.WarningCounter.ti.text = ((context.WarningCounter.s.split("$s")[0] + context.WarningCounter.n) + context.WarningCounter.s.split("$s")[1]);
                    context.WarningCounter.timer.reset();
                    context.WarningCounter.timer.start();
                };
            });
        }

        public function login(username:String=null, password:String=null):void
        {
            var url:String;
            this.mcConnDetail.showConn("Authenticating Account Info...");
            url = Config.serverLoginFunctionURL;
            var request:URLRequest = new URLRequest(url);
            var variables:URLVariables = new URLVariables();
            variables._token = this.params.token;
            if (username == null)
            {
                variables.game = true;
            }
            else
            {
                variables.username = username;
                variables.password = password;
            };
            request.data = variables;
            request.method = URLRequestMethod.POST;
            this.loginLoader.removeEventListener(Event.COMPLETE, this.onLoginComplete);
            this.loginLoader.addEventListener(Event.COMPLETE, this.onLoginComplete);
            this.loginLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoginError, false, 0, true);
            try
            {
                this.loginLoader.load(request);
            }
            catch(error:Error)
            {
                trace("Unable to load URL", error);
            };
        }

        public function createItemObject(sFile:String, sLink:String):*
        {
            var object:Object = {};
            object.sLink = sLink;
            object.sFile = sFile;
            return (object);
        }

        public function getClientPlatform():int
        {
            if (this.loaderDomain == null)
            {
                return (3);
            };
            if (this.loaderDomain.isAndroid)
            {
                return (1);
            };
            if (this.loaderDomain.isDesktop)
            {
                return (2);
            };
            return (3);
        }

        public function connectTo(ip:String, port:int):void
        {
            this.mcConnDetail.showConn("Connecting to game server...");
            this.network.connect(ip, port);
            gotoAndPlay(((this.userPreference.data.bitCheckedMobile) ? "Mobile" : "Game"));
        }

        public function readIA1Preferences():void
        {
            this.uoPref.bCloak = (Achievement.getAchievement("ia1", 0) == 0);
            this.uoPref.bHelm = (Achievement.getAchievement("ia1", 1) == 0);
            this.uoPref.bPet = (Achievement.getAchievement("ia1", 2) == 0);
            this.uoPref.bRune = (Achievement.getAchievement("ia1", 15) == 0);
            this.uoPref.bTitle = (Achievement.getAchievement("ia1", 21) == 0);
            this.uoPref.bGoto = (Achievement.getAchievement("ia1", 4) == 0);
            this.uoPref.bSoundOn = (Achievement.getAchievement("ia1", 5) == 0);
            this.uoPref.bMusicOn = (Achievement.getAchievement("ia1", 6) == 0);
            this.uoPref.bFriend = (Achievement.getAchievement("ia1", 7) == 0);
            this.uoPref.bParty = (Achievement.getAchievement("ia1", 8) == 0);
            this.uoPref.bGuild = (Achievement.getAchievement("ia1", 9) == 0);
            this.uoPref.bWhisper = (Achievement.getAchievement("ia1", 10) == 0);
            this.uoPref.bTT = (Achievement.getAchievement("ia1", 11) == 0);
            this.uoPref.bDuel = (Achievement.getAchievement("ia1", 13) == 0);
            this.uoPref.bTrade = (Achievement.getAchievement("ia1", 14) == 0);
            this.uoPref.bWorldBoss = (Achievement.getAchievement("ia1", 20) == 0);
            this.uoPref.bQuestAccept = (Achievement.getAchievement("ia1", 22) == 0);
            this.uoPref.bGuildRaid = (Achievement.getAchievement("ia1", 27) == 0);
            this.uoPref.bDropInterface = (Achievement.getAchievement("ia1", 24) == 0);
            this.uoPref.bCrossChat = (Achievement.getAchievement("ia1", 25) == 0);
            this.uoPref.bEntity = (Achievement.getAchievement("ia1", 26) == 0);
            this.ui.mcInterface.mcMenu.btnSound.checkmark.visible = (!(!(this.userPreference.data["audioSettingsOverall"])));
            this.ui.mcPortrait.mcDrop.visible = this.uoPref.bDropInterface;
        }

        public function antiLagCheck():void
        {
            this.hideMonsterCheck();
            this.hideNpcCheck();
            this.hidePlayerCheck();
            this.hidePlayerOldCheck();
            this.hideMapCheck();
            this.hideUserInterfaceCheck();
            this.disableOtherPlayerAnimationCheck();
            this.disableMonsterAnimationCheck();
            this.hideOtherPetsCheck();
            this.hideOtherHelmsCheck();
            this.hideOtherCapesCheck();
            this.hideOtherRunesCheck();
            this.hideOtherTitlesCheck();
            this.hideOtherEntitiesCheck();
            this.hideOtherUsernamesCheck();
            this.hideOtherGuildsCheck();
            this.hideMyGuildCheck();
            this.hideMyUsernameCheck();
            this.hideSelfAurasCheck();
            this.hideTargetAurasCheck();
        }

        public function hideTargetAurasCheck():void
        {
            if (Game.root.userPreference.data.combatHideTargetAuras)
            {
                this.world.hideTargetAuras();
                return;
            };
            this.world.showTargetAuras();
        }

        public function hideSelfAurasCheck():void
        {
            if (Game.root.userPreference.data.combatHideSelfAuras)
            {
                this.world.hideSelfAuras();
                return;
            };
            this.world.showSelfAuras();
        }

        public function hideOtherEntitiesCheck():void
        {
            if (Game.root.userPreference.data.hideOtherEntities)
            {
                this.world.hideOtherEntities();
                return;
            };
            this.world.showOtherEntities();
        }

        public function hideOtherUsernamesCheck():void
        {
            if (!Game.root.userPreference.data.hideOtherUsername)
            {
                this.world.hideOtherUsernames();
                return;
            };
            this.world.showOtherUsernames();
        }

        public function hideOtherGuildsCheck():void
        {
            if (!Game.root.userPreference.data.hideOtherGuild)
            {
                this.world.hideOtherGuilds();
                return;
            };
            this.world.showOtherGuilds();
        }

        public function hideMyGuildCheck():void
        {
            this.world.myAvatar.pMC.setGuildVisibility(this.userPreference.data["hideMyGuild"]);
        }

        public function hideMyUsernameCheck():void
        {
            this.world.myAvatar.pMC.setUsernameVisibility(this.userPreference.data["hideMyUsername"]);
        }

        public function hideOtherTitlesCheck():void
        {
            if (Game.root.userPreference.data.hideOtherTitles)
            {
                this.world.hideOtherTitles();
                return;
            };
            this.world.showOtherTitles();
        }

        public function hideOtherRunesCheck():void
        {
            if (Game.root.userPreference.data.hideOtherRunes)
            {
                this.world.hideOtherRunes();
                return;
            };
            this.world.showOtherRunes();
        }

        public function hideOtherCapesCheck():void
        {
            if (Game.root.userPreference.data.hideOtherCapes)
            {
                this.world.hideOtherCloaks();
                return;
            };
            this.world.showOtherCloaks();
        }

        public function hideOtherHelmsCheck():void
        {
            if (Game.root.userPreference.data.hideOtherHelms)
            {
                this.world.hideOtherHelms();
                return;
            };
            this.world.showOtherHelms();
        }

        public function disableOtherPlayerAnimationCheck():void
        {
            if (Game.root.userPreference.data.disableOtherPlayerAnimation)
            {
                this.world.disableOtherPlayerAnimation();
                return;
            };
        }

        public function disableMonsterAnimationCheck():void
        {
            if (Game.root.userPreference.data.disableMonsterAnimation)
            {
                this.world.disableMonsterAnimation();
                return;
            };
        }

        public function disableNPCAnimationCheck():void
        {
            if (Game.root.userPreference.data.disableNPCsAnimation)
            {
                this.world.disableNPCsAnimation();
                return;
            };
        }

        public function hideOtherPetsCheck():void
        {
            if (Game.root.userPreference.data.hideOtherPets)
            {
                this.world.hideOthersPets();
                return;
            };
            this.world.showOthersPets();
        }

        public function hideMonsterCheck():void
        {
            if (Game.root.userPreference.data.hideAllMon)
            {
                this.world.hideMonsters();
                return;
            };
            this.world.showMonsters();
        }

        public function hideNpcCheck():void
        {
            if (Game.root.userPreference.data.hideAllNpc)
            {
                this.world.hideNPCS();
                return;
            };
            this.world.showNPCS();
        }

        public function hidePlayerCheck():void
        {
            if (Game.root.userPreference.data.hideAllPlayer)
            {
                this.world.hidePlayers();
                return;
            };
            this.world.showPlayers();
        }

        public function hidePlayerOldCheck():void
        {
            if (Game.root.userPreference.data.hideAllPlayerOld)
            {
                this.world.hideAvatars = true;
            }
            else
            {
                this.world.hideAvatars = false;
            };
            this.world.playerInit();
        }

        public function hideMapCheck():void
        {
            if (Game.root.userPreference.data.hideMap)
            {
                this.world.hideMap();
                return;
            };
            this.world.showMap();
        }

        public function showServerLatencyCheck():void
        {
            this.ui.mcPing.visible = Game.root.userPreference.data.showServerLatency;
        }

        public function hideServerTimeCheck():void
        {
            this.ui.mcTime.visible = (!(Game.root.userPreference.data.hideServerTime));
        }

        public function hideUserInterfaceCheck():void
        {
            var button:LibraryButton;
            var buttonOld:DisplayObject = this.getChildByName("showUI");
            if (Game.root.userPreference.data.hideUserInterface)
            {
                if (buttonOld == null)
                {
                    button = new LibraryButton();
                    button.x = 2.35;
                    button.y = 1.95;
                    button.name = "showUI";
                    button.addEventListener(MouseEvent.CLICK, function ():*
                    {
                        toggleUIVisibility(null);
                        if (((currentLabel == "Game") && (ui.mcPopup.currentLabel == "OptionPanel")))
                        {
                            ui.mcPopup.mcOptionPanel.gotoAndPlay("Options");
                        };
                    });
                    addChild(button);
                };
                this.ui.visible = false;
                return;
            };
            if (buttonOld != null)
            {
                removeChild(buttonOld);
            };
            this.ui.visible = true;
        }

        public function toggleAvatarVisibilityOld():void
        {
            OptionMC.preferenceCache("hideAllPlayerOld");
            this.hidePlayerOldCheck();
        }

        public function toggleAvatarVisibility():void
        {
            OptionMC.preferenceCache("hideAllPlayer");
            this.hidePlayerCheck();
        }

        public function toggleWorldVisibility():void
        {
            OptionMC.preferenceCache("hideMap");
            this.hideMapCheck();
        }

        public function toggleUIVisibility(event:Event):void
        {
            OptionMC.preferenceCache("hideUserInterface");
            this.hideUserInterfaceCheck();
        }

        public function showPortrait(_arg1:Avatar):void
        {
            if (!this.isGameLabel)
            {
                return;
            };
            AvatarUtil.showPortraitBox(_arg1, this.ui.mcPortrait);
            this.world.updatePortrait(_arg1);
            this.ui.iconQuest.visible = true;
        }

        public function showPortraitTarget(avatar:Avatar):void
        {
            if (Number(this.world.objExtra["bChar"]) == 1)
            {
                AvatarUtil.showPortraitBox(this.world.myAvatar, this.ui.mcPortraitTarget);
            }
            else
            {
                AvatarUtil.showPortraitBox(avatar, this.ui.mcPortraitTarget);
            };
            this.ui.mcPortraitTarget.pvpIcon.visible = this.world.bPvP;
            this.world.updatePortrait(avatar);
            this.ui.btnTargetPortraitClose.visible = true;
        }

        public function hidePortraitTarget():void
        {
            var _local1:MovieClip;
            var _local2:DisplayObject;
            _local1 = (this.ui.mcPortraitTarget.mcHead as MovieClip);
            _local2 = _local1.head.getChildByName("face");
            if (_local2 != null)
            {
                _local1.head.removeChild(_local2);
            };
            while (_local1.backhair.numChildren > 0)
            {
                _local1.backhair.removeChildAt(0);
            };
            while (_local1.head.hair.numChildren > 0)
            {
                _local1.head.hair.removeChildAt(0);
            };
            while (_local1.head.helm.numChildren > 0)
            {
                _local1.head.helm.removeChildAt(0);
            };
            this.ui.mcPortraitTarget.visible = false;
            this.ui.btnTargetPortraitClose.visible = false;
        }

        public function manageXPBoost(data:Object):void
        {
            this.ui.mcPortrait.iconBoostXP.visible = (data.op == "+");
            if (data.op == "+")
            {
                this.world.myAvatar.objData.iBoostXP = data.iSecsLeft;
                this.ui.mcPortrait.iconBoostXP.boostTS = new Date().getTime();
                this.ui.mcPortrait.iconBoostXP.iBoostXP = data.iSecsLeft;
                this.addUpdate("You have activated the Experience Boost! All Experience rewards are doubled while the effect holds.");
                this.chatF.pushMsg("server", (("You have activated the Experience Boost! All Experience rewards are doubled while the effect holds. " + Math.ceil((data.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete this.world.myAvatar.objData.iBoostXP;
                delete this.ui.mcPortrait.iconBoostXP.boostTS;
                delete this.ui.mcPortrait.iconBoostXP.iBoostXP;
                this.addUpdate("The Experience Boost has faded! Experience rewards are no longer doubled.");
                this.chatF.pushMsg("server", "The Experience Boost has faded! Experience rewards are no longer doubled.", "SERVER", "", 0);
                MainController.modal("Your Experience Boost has faded! Experience rewards are no longer doubled.", null, {}, "white,medium", "mono");
            };
        }

        public function manageGBoost(data:Object):void
        {
            this.ui.mcPortrait.iconBoostG.visible = (data.op == "+");
            if (data.op == "+")
            {
                this.world.myAvatar.objData.iBoostG = data.iSecsLeft;
                this.ui.mcPortrait.iconBoostG.boostTS = new Date().getTime();
                this.ui.mcPortrait.iconBoostG.iBoostG = data.iSecsLeft;
                this.addUpdate("You have activated the Gold Boost! All Gold rewards are doubled while the effect holds.");
                this.chatF.pushMsg("server", (("You have activated the Gold Boost! All Gold rewards are doubled while the effect holds. " + Math.ceil((data.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete this.world.myAvatar.objData.iBoostG;
                delete this.ui.mcPortrait.iconBoostG.boostTS;
                delete this.ui.mcPortrait.iconBoostG.iBoostG;
                this.addUpdate("The Gold Boost has faded! Gold rewards are no longer doubled.");
                this.chatF.pushMsg("server", "The Gold Boost has faded! Gold rewards are no longer doubled.", "SERVER", "", 0);
                MainController.modal("Your Gold Boost has faded! Gold rewards are no longer doubled.", null, {}, "white,medium", "mono");
            };
        }

        public function manageRepBoost(data:Object):void
        {
            this.ui.mcPortrait.iconBoostRep.visible = (data.op == "+");
            if (data.op == "+")
            {
                this.world.myAvatar.objData.iBoostRep = data.iSecsLeft;
                this.ui.mcPortrait.iconBoostRep.boostTS = new Date().getTime();
                this.ui.mcPortrait.iconBoostRep.iBoostRep = data.iSecsLeft;
                this.addUpdate("You have activated the Reputation Boost! All Reputation rewards are doubled while the effect holds.");
                this.chatF.pushMsg("server", (("You have activated the Reputation Boost! All Reputation rewards are doubled while the effect holds. " + Math.ceil((data.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete this.world.myAvatar.objData.iBoostRep;
                delete this.ui.mcPortrait.iconBoostRep.boostTS;
                delete this.ui.mcPortrait.iconBoostRep.iBoostRep;
                this.addUpdate("The Reputation has faded! Reputation rewards are no longer doubled.");
                this.chatF.pushMsg("server", "The Reputation Boost has faded! Reputation rewards are no longer doubled.", "SERVER", "", 0);
                MainController.modal("Your Reputation Boost has faded! Reputation rewards are no longer doubled.", null, {}, "white,medium", "mono");
            };
        }

        public function manageCPBoost(data:Object):void
        {
            this.ui.mcPortrait.iconBoostCP.visible = (data.op == "+");
            if (data.op == "+")
            {
                this.world.myAvatar.objData.iBoostCP = data.iSecsLeft;
                this.ui.mcPortrait.iconBoostCP.boostTS = new Date().getTime();
                this.ui.mcPortrait.iconBoostCP.iBoostCP = data.iSecsLeft;
                this.addUpdate("You have activated the ClassPoint Boost! All ClassPoint rewards are doubled while the effect holds.");
                this.chatF.pushMsg("server", (("You have activated the ClassPoint Boost! All ClassPoint rewards are doubled while the effect holds. " + Math.ceil((data.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete this.world.myAvatar.objData.iBoostCP;
                delete this.ui.mcPortrait.iconBoostCP.boostTS;
                delete this.ui.mcPortrait.iconBoostCP.iBoostCP;
                this.addUpdate("The ClassPoint has faded! ClassPoint rewards are no longer doubled.");
                this.chatF.pushMsg("server", "The ClassPoint Boost has faded! ClassPoint rewards are no longer doubled.", "SERVER", "", 0);
                MainController.modal("Your ClassPoint Boost has faded! ClassPoint rewards are no longer doubled.", null, {}, "white,medium", "mono");
            };
        }

        public function manageCoinBoost(data:Object):void
        {
            this.ui.mcPortrait.iconBoostC.visible = (data.op == "+");
            if (data.op == "+")
            {
                this.world.myAvatar.objData.iBoostC = data.iSecsLeft;
                this.ui.mcPortrait.iconBoostC.boostTS = new Date().getTime();
                this.ui.mcPortrait.iconBoostC.iBoostC = data.iSecsLeft;
                this.addUpdate((("You have activated the " + Config.getString("coins_name")) + " Boost! All Coins rewards are doubled while the effect holds."));
                this.chatF.pushMsg("server", (((("You have activated the " + Config.getString("coins_name")) + " Boost! All Coins rewards are doubled while the effect holds. ") + Math.ceil((data.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete this.world.myAvatar.objData.iBoostC;
                delete this.ui.mcPortrait.iconBoostC.boostTS;
                delete this.ui.mcPortrait.iconBoostC.iBoostC;
                this.addUpdate((("The " + Config.getString("coins_name")) + " has faded! Coins rewards are no longer doubled."));
                this.chatF.pushMsg("server", (("The " + Config.getString("coins_name")) + " Boost has faded! Coins rewards are no longer doubled."), "SERVER", "", 0);
                MainController.modal((("Your " + Config.getString("coins_name")) + " Boost has faded! Coins rewards are no longer doubled."), null, {}, "white,medium", "mono");
            };
        }

        public function updateRepBar():void
        {
            var repPercentage:int;
            var currentCP:int = this.world.myAvatar.objData.iCurCP;
            var cpToRank:int = this.world.myAvatar.objData.iCPToRank;
            if (cpToRank <= 0)
            {
                this.ui.mcInterface.mcRepBar.mcRep.scaleX = 0.1;
                this.ui.mcInterface.mcRepBar.mcRep.visible = false;
                this.ui.mcInterface.mcRepBar.strRep.text = ((this.world.myAvatar.objData.strClassName + ", Rank ") + this.world.myAvatar.objData.iRank);
            }
            else
            {
                repPercentage = int(int(((currentCP / cpToRank) * 100)));
                repPercentage = Math.min(repPercentage, 100);
                this.ui.mcInterface.mcRepBar.mcRep.scaleX = (currentCP / cpToRank);
                this.ui.mcInterface.mcRepBar.mcRep.visible = true;
                this.ui.mcInterface.mcRepBar.strRep.text = (((((((((this.world.myAvatar.objData.strClassName + ", Rank ") + this.world.myAvatar.objData.iRank) + " : ") + currentCP) + "/") + cpToRank) + "  (") + repPercentage) + "%)");
            };
        }

        public function updateXPBar():void
        {
            var exp:Number = this.world.myAvatar.objData.intExp;
            var expToLevel:Number = this.world.myAvatar.objData.intExpToLevel;
            var xpPercentage:int = int(int(((exp / expToLevel) * 100)));
            xpPercentage = Math.min(xpPercentage, 100);
            this.ui.mcInterface.mcXPBar.mcXP.scaleX = Math.min((exp / expToLevel), 1);
            this.ui.mcInterface.mcXPBar.strXP.text = (((((((("Level " + this.world.myAvatar.objData.intLevel) + " : ") + exp) + " / ") + expToLevel) + "  (") + xpPercentage) + "%)");
        }

        public function showMap():void
        {
            this.ui.mcInterface.mcMenu.mcMenuButtons.visible = true;
            this.ui.mcPopup.fOpen("Map");
        }

        public function logout():void
        {
            this.discord.update("destroy");
            this.logoutFinal();
            if (this.currentLabel != "Login")
            {
                SoundMixer.stopAll();
            };
            if (this.network.connected)
            {
                this.network.close();
            };
            if (this.currentLabel != "Login")
            {
                gotoAndPlay("Login");
            };
        }

        public function showUpgradeWindow(_arg1:Object=null):void
        {
            var _local2:MovieClip;
            if (mcUpgradeWindow == null)
            {
                mcUpgradeWindow = new MCUpgradeWindow();
            };
            _local2 = (mcUpgradeWindow as MovieClip);
            var _local3:* = ((_arg1 != null) ? _arg1 : this.world.myAvatar.objData);
            _local2.btnClose.addEventListener(MouseEvent.CLICK, this.hideUpgradeWindow, false, 0, true);
            _local2.btnClose2.addEventListener(MouseEvent.CLICK, this.hideUpgradeWindow, false, 0, true);
            _local2.btnBuy.addEventListener(MouseEvent.CLICK, this.onUpgradeClick, false, 0, true);
            addChild(mcUpgradeWindow);
            try
            {
                this.ui.mouseChildren = false;
                this.world.mouseChildren = false;
            }
            catch(e:Error)
            {
            };
            try
            {
                this.mcLogin.sl.mouseChildren = false;
            }
            catch(e:Error)
            {
            };
        }

        public function showHelpWindow(o:Object=null):void
        {
        }

        public function showACWindow():void
        {
        }

        public function isDialoqueUp():Boolean
        {
            var _local1:int;
            var _local2:*;
            var _local3:*;
            _local1 = 0;
            while (_local1 < this.world.FG.numChildren)
            {
                _local2 = this.world.FG.getChildAt(_local1);
                _local3 = String((_local2 as MovieClip));
                if (_local3.indexOf("dlg_") > -1)
                {
                    return (true);
                };
                _local1++;
            };
            return (false);
        }

        public function clearModalStack():Boolean
        {
            var modalMC:ModalMC;
            if (this.isGreedyModalInStack())
            {
                return (false);
            };
            var modalChildrenCount:int = this.ui.ModalStack.numChildren;
            var i:int;
            while (i < modalChildrenCount)
            {
                modalMC = ModalMC(this.ui.ModalStack.getChildAt(i));
                modalMC.fClose();
                i++;
            };
            stage.focus = null;
            return (true);
        }

        public function closeModalByStrBody(strBody:String):void
        {
            var modalMC:ModalMC;
            var modalChildrenCount:int = this.ui.ModalStack.numChildren;
            var i:int;
            while (i < modalChildrenCount)
            {
                modalMC = ModalMC(this.ui.ModalStack.getChildAt(i));
                if (((String(modalMC.cnt.strBody.htmlText).indexOf(strBody) > -1) && (!(modalMC.currentLabel == "out"))))
                {
                    modalMC.fClose();
                };
                i++;
            };
        }

        public function isGreedyModalInStack():Boolean
        {
            var modalMC:ModalMC;
            var modalChildrenCount:int = this.ui.ModalStack.numChildren;
            var i:int;
            while (i < modalChildrenCount)
            {
                modalMC = ModalMC(this.ui.ModalStack.getChildAt(i));
                if (modalMC.greedy)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function clearPopups(_arg1:Array=null):void
        {
            if (this.ui.mcPopup.currentLabel == "House")
            {
                this.ui.mcPopup.mcHouseMenu.hideItemHandle();
            };
            if (((_arg1 == null) || (_arg1.indexOf(this.ui.mcPopup.currentLabel) < 0)))
            {
                this.ui.mcPopup.onClose();
            };
            this.world.removeMovieFront();
            this.clearModalStack();
        }

        public function clearPopupsQ():void
        {
            if (((!(this.ui.mcPopup.currentLabel == "House")) && (!(this.ui.mcPopup.currentLabel == "HouseShop"))))
            {
                this.ui.mcPopup.onClose();
            };
        }

        public function addUpdate(message:String, isError:Boolean=false):void
        {
            var updates:MovieClip = this.ui.mcUpdates;
            var newMessage:uProto = new uProto();
            updates.addChildAt(newMessage, 1);
            newMessage.y = 0;
            newMessage.x = updates.uproto.x;
            newMessage.t1.ti.htmlText = message;
            if (isError)
            {
                newMessage.t1.ti.textColor = 0xFF0000;
            };
            newMessage.gotoAndPlay("in");
            var i:int = 2;
            if (updates.numChildren > 2)
            {
                i = 2;
                while (i < updates.numChildren)
                {
                    if (i < 4)
                    {
                        updates.getChildAt(i).y = (updates.getChildAt(i).y - 18);
                    }
                    else
                    {
                        MovieClip(updates.getChildAt(i)).stop();
                        updates.removeChildAt(i);
                        i--;
                    };
                    i++;
                };
            };
        }

        public function clearUpdates():void
        {
            var _local1:MovieClip;
            _local1 = this.ui.mcUpdates;
            while (_local1.numChildren > 1)
            {
                _local1.removeChildAt(1);
            };
        }

        public function showItemDrop(itemObj:Object, showYesNo:Boolean, sum:Boolean=true):void
        {
            var drop:AbstractDropFrame;
            var movieClip:MovieClip;
            var item:Item = ((itemObj is Item) ? Item(itemObj) : new Item(itemObj));
            var exist:Boolean;
            var i:int;
            while (i < this.ui.dropStack.numChildren)
            {
                movieClip = MovieClip(this.ui.dropStack.getChildAt(i));
                if ((movieClip is DFrame2MC))
                {
                    drop = DFrame2MC(movieClip);
                    if (drop.fData.ItemID == item.ItemID)
                    {
                        if (sum)
                        {
                            drop.fData.iQty = (drop.fData.iQty + item.iQty);
                        }
                        else
                        {
                            drop.fData.iQty = item.iQty;
                        };
                        drop.cnt.strName.text = ((drop.fData.sName + " x") + drop.fData.iQty);
                        exist = true;
                    };
                };
                i++;
            };
            if (!exist)
            {
                if (((item.bTemp) || (!(showYesNo))))
                {
                    drop = new DFrameMC(item);
                    drop.cnt.strRate.visible = false;
                }
                else
                {
                    drop = new DFrame2MC(item);
                };
                this.ui.dropStack.addChild(drop);
                drop.init();
                drop.fY = (drop.y = -(drop.fHeight + 8));
                drop.fX = (drop.x = -(drop.fWidth >> 1));
            };
            this.cleanDropStack();
        }

        public function cleanDropStack():void
        {
            var clip:MovieClip;
            var clip1:MovieClip;
            var dropChildren:Number = (this.ui.dropStack.numChildren - 2);
            while (dropChildren > -1)
            {
                clip = (this.ui.dropStack.getChildAt(dropChildren) as MovieClip);
                clip1 = (this.ui.dropStack.getChildAt((dropChildren + 1)) as MovieClip);
                clip.fY = (clip.y = (clip1.fY - (clip1.fHeight + 8)));
                dropChildren--;
            };
        }

        public function showAchievement(_arg1:String, _arg2:int):void
        {
            var _local3:mcAchievement;
            var _local4:MovieClip;
            _local3 = new mcAchievement();
            _local4 = (this.ui.dropStack.addChild(_local3) as MovieClip);
            _local4.cnt.tBody.text = _arg1;
            _local4.cnt.tPts.text = _arg2;
            _local4.fWidth = 348;
            _local4.fHeight = 90;
            _local4.fX = (_local4.x = -(_local4.fWidth / 2));
            _local4.fY = (_local4.y = -(_local4.fHeight + 8));
            this.cleanDropStack();
        }

        public function showQuestpopup(data:Object):void
        {
            var questPopup:mcQuestpopup = mcQuestpopup(UIController.show("quest_popup"));
            questPopup.cnt.tName.text = data.sName;
            questPopup.cnt.rewards.tRewards.htmlText = "";
            questPopup.cnt.mcAC.visible = false;
            var rewardText:String = "";
            if (((!(data.rewardObj.intCoins == undefined)) && (data.rewardObj.intCoins > 0)))
            {
                if (rewardText.length > 0)
                {
                    rewardText = (rewardText + "<font color='#FFFFFF'>, </font>");
                };
                rewardText = (rewardText + (((("<font color='#FFFFFF'>" + data.rewardObj.intCoins) + "</font> <font color='#FF9900'> ") + Config.getString("coins_name_short")) + "</font>"));
                questPopup.cnt.mcAC.visible = true;
            };
            if (((!(data.rewardObj.intExp == undefined)) && (data.rewardObj.intExp > 0)))
            {
                if (rewardText.length > 0)
                {
                    rewardText = (rewardText + "<font color='#FFFFFF'>, </font>");
                };
                rewardText = (rewardText + (("<font color='#FFFFFF'>" + data.rewardObj.intExp) + "</font> <font color='#FF00FF'>XP</font>"));
            };
            if (((!(data.rewardObj.iRep == undefined)) && (data.rewardObj.iRep > 0)))
            {
                if (rewardText.length > 0)
                {
                    rewardText = (rewardText + "<font color='#FFFFFF'>, </font>");
                };
                rewardText = (rewardText + (("<font color='#FFFFFF'>" + data.rewardObj.iRep) + "</font> <font color='#00CCFF'>REP</font>"));
            };
            if (((!(data.rewardObj.guildRep == undefined)) && (data.rewardObj.guildRep > 0)))
            {
                if (rewardText.length > 0)
                {
                    rewardText = (rewardText + "<font color='#FFFFFF'>, </font>");
                };
                rewardText = (rewardText + (("<font color='#FFFFFF'>" + data.rewardObj.guildRep) + "</font> <font color='#00CCFF'>Guild Rep</font>"));
            };
            questPopup.cnt.rewards.tRewards.htmlText = rewardText;
        }

        public function toggleDropInterface():void
        {
            var dropMenu:DropMenu = DropMenu(this.ui.getChildByName("dropMenu"));
            if (this.uoPref.bDropInterface)
            {
                this.ui.dropStack.visible = false;
                if (dropMenu == null)
                {
                    dropMenu = DropMenu(this.ui.addChild(new DropMenu(this)));
                    dropMenu.name = "dropMenu";
                    dropMenu.x = 335;
                    dropMenu.y = 300;
                    dropMenu.onShow();
                    this.ui.mcPortrait.mcDrop.visible = true;
                };
            }
            else
            {
                this.ui.dropStack.visible = true;
                this.ui.mcPortrait.mcDrop.visible = false;
                if (dropMenu != null)
                {
                    dropMenu.onDestroy();
                };
            };
        }

        public function toggleItemEquip(item:Item):Boolean
        {
            var b:Boolean;
            switch (true)
            {
                case (!(this.world.getUoLeafById(this.world.myAvatar.uid).intState == 1)):
                    this.MsgBox.notify("Action cannot be performed during combat!");
                    break;
                case this.world.bPvP:
                    this.MsgBox.notify("Items may not be equipped or unequipped during a PvP match!");
                    break;
                case item.bEquip:
                    if (((item.sES == "Weapon") || (item.sES == "ar")))
                    {
                        this.MsgBox.notify("Selected Item cannot be unequipped!");
                    }
                    else
                    {
                        b = true;
                        if (item.sType.toLowerCase() != "item")
                        {
                            this.world.sendUnequipItemRequest(item);
                        }
                        else
                        {
                            this.world.unequipUseableItem(item);
                        };
                    };
                    break;
                case ((item.bUpg == 1) && (!(this.world.myAvatar.isUpgraded()))):
                    this.showUpgradeWindow();
                    break;
                case (item.EnhLvl > int(this.world.myAvatar.objData.intLevel)):
                    this.MsgBox.notify("Level requirement not met!");
                    break;
                case ((item.iReqGuildLevel > 0) && ((this.world.myAvatar.objData.guild == null) || (item.iReqGuildLevel > this.world.myAvatar.objData.guild.Level))):
                    this.MsgBox.notify("Guild Level requirement not met!");
                    break;
                case (((((((!(item.sType.toLowerCase() == "item")) && (!(item.sES == "mi"))) && (!(item.sES == "co"))) && (!(item.sES == "pe"))) && (!(item.sES == "am"))) && (!(item.sES == "en"))) && (item.EnhID <= 0)):
                    this.MsgBox.notify("Selected item requires enhancement!");
                    break;
                case (!(item.sType.toLowerCase() == "item")):
                    b = this.world.sendEquipItemRequest(item);
                    break;
                default:
                    b = true;
                    this.world.equipUseableItem(item);
            };
            return (b);
        }

        public function toggleFullScreen():void
        {
            if (stage.displayState == StageDisplayState.NORMAL)
            {
                try
                {
                    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
                }
                catch(error:Error)
                {
                    trace("toggleFullScreen", error);
                };
            }
            else
            {
                stage.displayState = StageDisplayState.NORMAL;
            };
        }

        public function toggleTradePanel(userId:int=-1, username:String=""):void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "TradePanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.tradeId = userId;
                    mcPopup.tradeUser = username;
                    mcPopup.visible = true;
                    mcPopup.gotoAndPlay("TradePanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleBetPanel(username:String):void
        {
            if (this.isGreedyModalInStack())
            {
                return;
            };
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (mcPopup.currentLabel == "DuelBetPanel")
            {
                mcPopup.onClose();
                return;
            };
            this.clearPopups();
            this.clearPopupsQ();
            mcPopup.visible = true;
            mcPopup.gotoAndStop("DuelBetPanel");
            mcPopup.DuelMC.strUsername = username;
            mcPopup.DuelMC.txtDescription.htmlText = (("You are about to duel <b><font color='#FF9900'>" + username) + "</font></b><br> Place your bet!");
        }

        public function toggleCookingPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "CookingPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndPlay("CookingPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleRedeemPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "RedeemPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("RedeemPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleOptionPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "OptionPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("OptionPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleOption2Panel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "Option")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("Option");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleBotPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "BotPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("BotPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function openBotPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (mcPopup.currentLabel != "BotPanel")
            {
                this.clearPopups();
                this.clearPopupsQ();
                mcPopup.visible = true;
                mcPopup.gotoAndStop("BotPanel");
            };
        }

        public function toggleDailyLogin():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "DailyLogin")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("DailyLogin");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleWorldMapPanel():void
        {
            if (this.worldMap == null)
            {
                LoadController.singleton.addLoadJunk(this.version.setting.file_map, "junk", function (event:Event):void
                {
                    worldMap = ui.addChild(MovieClip(event.target.content));
                });
                return;
            };
            this.ui.removeChild(this.worldMap);
            this.worldMap = null;
        }

        public function toggleBuySlotPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "SpacePanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("SpacePanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleBuyHousePanel():void
        {
            if (this.world.isHouseEquipped())
            {
                this.world.gotoHouse(this.network.myUserName);
            }
            else
            {
                this.world.gotoTown("buyhouse", "Enter", "Spawn");
            };
        }

        public function toggleCouplePanel(username:String):void
        {
            var avatar:Avatar = this.world.getAvatarByUserName(username);
            if (avatar == null)
            {
                this.MsgBox.notify("Player not found!");
                return;
            };
            if (avatar.objData.partner == null)
            {
                this.MsgBox.notify("This player does not have any relationship!");
                return;
            };
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "CouplePanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.fData = {"strUsername":username};
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("CouplePanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleCharPage(username:String=""):void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "CharacterPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.fData = {"strUsername":username};
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("CharacterPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleRelationship():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "RelationshipPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("RelationshipPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleAuction(strUsername:String=""):void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            this.vendingOwner = strUsername;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "AuctionPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndPlay("AuctionPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleStaffPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "StaffPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("StaffPanel");
                }
                else
                {
                    mcPopup.fClose();
                };
            };
        }

        public function toggleCoreStatPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "CoreStatPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("CoreStatPanel");
                }
                else
                {
                    mcPopup.fClose();
                };
            };
        }

        public function toggleModifierStatPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "ModifierStatPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("ModifierStatPanel");
                }
                else
                {
                    mcPopup.fClose();
                };
            };
        }

        public function toggleJoystick():void
        {
            if (!this.userPreference.data.bitCheckedMobile)
            {
                this.chatF.pushMsg("warning", "Joystick is only Available to Mobile Users.", "SERVER", "", 0);
                return;
            };
            this.ui.joystick.visible = (!(this.ui.joystick.visible));
            if (this.ui.joystick.visible)
            {
                this.chatF.pushMsg("server", "Showing joystick.", "SERVER", "", 0);
            }
            else
            {
                this.chatF.pushMsg("server", "Hiding joystick.", "SERVER", "", 0);
            };
        }

        public function toggleCharpanel(typ:String=""):void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "Charpanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.fData = {"typ":typ};
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("Charpanel");
                }
                else
                {
                    mcPopup.mcCharpanel.fClose();
                };
            };
        }

        public function toggleRebirthPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "RebirthPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("RebirthPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function togglePartyPanel():void
        {
            var mcPopup:MovieClip;
            if (this.world.myAvatar.objData.party == null)
            {
                this.MsgBox.notify("You need to create or join a party first.");
            }
            else
            {
                mcPopup = this.ui.mcPopup;
                if (!this.isGreedyModalInStack())
                {
                    if (mcPopup.currentLabel != "PartyPanel")
                    {
                        this.clearPopups();
                        this.clearPopupsQ();
                        mcPopup.visible = true;
                        mcPopup.gotoAndStop("PartyPanel");
                    }
                    else
                    {
                        mcPopup.onClose();
                    };
                };
            };
        }

        public function toggleGuildPanel():void
        {
            var mcPopup:MovieClip;
            if (this.world.myAvatar.objData.guild == null)
            {
                this.MsgBox.notify("You need to create or join a guild first.");
            }
            else
            {
                mcPopup = this.ui.mcPopup;
                if (!this.isGreedyModalInStack())
                {
                    if (mcPopup.currentLabel != "GuildPanel")
                    {
                        this.clearPopups();
                        this.clearPopupsQ();
                        mcPopup.visible = true;
                        mcPopup.gotoAndStop("GuildPanel");
                    }
                    else
                    {
                        mcPopup.onClose();
                    };
                };
            };
        }

        public function toggleGuildList():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "GuildListPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("GuildListPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function togglePvPOperationPanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "PvPOperationPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("PvPOperationPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleHousePanel():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "House")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("House");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function togglePVPPanelinMap():void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "PVPPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.fData = {"typ":"maps"};
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("PVPPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleCustomizationPanel(item:Item):void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "CustomizationPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.fData = {"item":item};
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("CustomizationPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function togglePVPPanel(typ:String):void
        {
            var mcPopup:mcPopup_323 = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "PVPPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.fData = {"typ":typ};
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("PVPPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }

        public function toggleHideRemoveProps():void
        {
            if (this.world.myAvatar.isStaff())
            {
                if (!this.world.isRemoveProps)
                {
                    this.world.isRemoveProps = true;
                    this.chatF.pushMsg("server", "Successfully removed props.", "SERVER", "", 0);
                }
                else
                {
                    this.world.isRemoveProps = false;
                    this.chatF.pushMsg("server", "Successfully added props.", "SERVER", "", 0);
                };
                this.world.mapController.destroy();
                this.world.updateMonstersAndProps();
                this.world.mapController.build(this.world.frames, this.world.strFrame);
                this.world.setupCellData(this.world.strFrame);
                this.world.updateMapObjects();
            };
        }

        public function toggleMCNPCBuilder():void
        {
            UIController.toggle("npc_tool");
        }

        public function toggleChronicle():void
        {
            UIController.toggle("chronicle");
        }

        public function toggleWorldBossBoard():void
        {
            UIController.toggle("boss_board");
        }

        public function toggleStatsPanel():void
        {
            UIController.toggle("stats_panel");
        }

        public function toggleBattlePass():void
        {
            if (!Config.getBoolean("feature_battle_pass"))
            {
                this.MsgBox.notify("Feature Battle Pass is not enabled for this server.");
                return;
            };
            UIController.toggle("battle_pass");
        }

        public function toggleOutfit():void
        {
            if (!Config.getBoolean("feature_outfit"))
            {
                this.MsgBox.notify("Feature Outfit is not enabled for this server.");
                return;
            };
            UIController.toggle("outfit");
        }

        public function isMapBuilderToggled():Boolean
        {
            return (!(MapMenu(this.ui.getChildByName("mapMenu")) == null));
        }

        public function toggleMCMapBuilder(event:*=null):void
        {
            var mapMenu:MapMenu = MapMenu(this.ui.getChildByName("mapMenu"));
            if (mapMenu == null)
            {
                mapMenu = MapMenu(this.ui.addChild(new MapMenu(this)));
                mapMenu.name = "mapMenu";
                mapMenu.x = 335;
                mapMenu.y = 300;
                mapMenu.onShow();
                this.chatF.pushMsg("server", "To show or hide monsters and props type (/props)", "SERVER", "", 0);
            }
            else
            {
                mapMenu.onHide();
            };
        }

        public function showPVPScore():void
        {
            var bar:MovieClip;
            var i:int;
            var o:Object;
            var bx:int;
            var xxxxxxx:*;
            var yyyyyy:*;
            var a:Array = ((this.world.PVPFactions.length > 0) ? this.world.PVPFactions : ([{"sName":"Team A"}, {"sName":"Team B"}]));
            var factions:Array = ((this.world.PVPFactions.length > 0) ? this.world.PVPFactions : ([{"sName":"Team A"}, {"sName":"Team B"}]));
            this.ui.mcPVPScore.visible = true;
            this.ui.mcPVPScore.y = 29.9;
            i = 0;
            bx = 200;
            i = 0;
            while (i < a.length)
            {
                xxxxxxx = a[i];
                o = xxxxxxx;
                try
                {
                    xxxxxxx = this.ui.mcPVPScore.getChildByName(("bar" + i));
                    bar = xxxxxxx;
                    bar.tTeam.text = o.sName;
                    if ((((bar.tTeam.x + bar.tTeam.width) - bar.tTeam.textWidth) - 6) < bx)
                    {
                        xxxxxxx = Math.round((((bar.tTeam.x + bar.tTeam.width) - bar.tTeam.textWidth) - 6));
                        bx = xxxxxxx;
                    };
                }
                catch(e:Error)
                {
                };
                i++;
            };
            i = 0;
            while (i < a.length)
            {
                yyyyyy = a[i];
                o = yyyyyy;
                try
                {
                    yyyyyy = this.ui.mcPVPScore.getChildByName(("bar" + i));
                    bar = yyyyyy;
                    bar.cap.x = bx;
                }
                catch(e:Error)
                {
                };
                i++;
            };
        }

        public function hidePVPScore():void
        {
            this.ui.mcPVPScore.visible = false;
            this.ui.mcPVPScore.y = -300;
        }

        public function showMCPVPQueue():void
        {
            var _local1:Object;
            _local1 = this.world.getWarZoneByWarZoneName(this.world.PVPQueue.warzone);
            this.ui.mcPVPQueue.t1.text = _local1.nam;
            this.ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME, this.MCPVPQueueEF);
            this.ui.mcPVPQueue.t2label.visible = false;
            this.ui.mcPVPQueue.t2.visible = false;
            if (this.world.PVPQueue.avgWait > -1)
            {
                this.ui.mcPVPQueue.t2label.visible = true;
                this.ui.mcPVPQueue.t2.visible = true;
                this.ui.mcPVPQueue.addEventListener(Event.ENTER_FRAME, this.MCPVPQueueEF, false, 0, true);
            };
            this.ui.mcPVPQueue.visible = true;
            this.ui.mcPVPQueue.y = 138.2;
        }

        public function hideMCPVPQueue():void
        {
            this.ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME, this.MCPVPQueueEF);
            this.ui.mcPVPQueue.visible = false;
            this.ui.mcPVPQueue.y = -300;
        }

        public function updatePVPScore(_arg1:Array):void
        {
            var _local2:Object;
            var _local3:MovieClip;
            var _local4:int;
            var _local5:int;
            _local2 = {};
            _local4 = 0;
            while (_local4 < _arg1.length)
            {
                _local2 = _arg1[_local4];
                _local3 = (this.ui.mcPVPScore.getChildByName(("bar" + _local4)) as MovieClip);
                if (_local3 != null)
                {
                    _local3.ti.text = (_local2.v + "/1000");
                    _local5 = int(int(((_local2.v / 1000) * _local3.bar.width)));
                    _local5 = Math.max(Math.min(_local5, _local3.bar.width), 0);
                    _local3.bar.x = (-(_local3.bar.width) + _local5);
                };
                _local4++;
            };
        }

        public function relayPVPEvent(_arg1:Object):void
        {
            if (_arg1.typ == "kill")
            {
                if (_arg1.team == this.world.myAvatar.dataLeaf.pvpTeam)
                {
                    if (_arg1.val == "Restorer")
                    {
                        this.addUpdate(this.getPVPMessage(_arg1.val, true));
                    };
                    if (_arg1.val == "Brawler")
                    {
                        this.addUpdate(this.getPVPMessage(_arg1.val, true));
                    };
                    if (_arg1.val == "Captain")
                    {
                        this.addUpdate(this.getPVPMessage(_arg1.val, true));
                    };
                    if (_arg1.val == "General")
                    {
                        this.addUpdate("Victory! The enemy general has been defeated!");
                    };
                    if (_arg1.val == "Knight")
                    {
                        this.addUpdate("A knight of the enemy has fallen! Victory draws closer!");
                    };
                }
                else
                {
                    if (_arg1.val == "Restorer")
                    {
                        this.addUpdate(this.getPVPMessage(_arg1.val, false), true);
                    };
                    if (_arg1.val == "Brawler")
                    {
                        this.addUpdate(this.getPVPMessage(_arg1.val, false), true);
                    };
                    if (_arg1.val == "Captain")
                    {
                        this.addUpdate(this.getPVPMessage(_arg1.val, false), true);
                    };
                    if (_arg1.val == "General")
                    {
                        this.addUpdate("Oh no!  Our general has been defeated!", true);
                    };
                    if (_arg1.val == "Knight")
                    {
                        this.addUpdate("A knight has fallen to the enemy!");
                    };
                };
            };
        }

        public function mcSetColor(part:MovieClip, location:String, shade:String):void
        {
            var lastParent:DisplayObjectContainer = part;
            while ((((!(lastParent == null)) && (!(lastParent.parent == null))) && (!(lastParent.parent == lastParent.stage))))
            {
                if (((lastParent is AvatarMC) || (lastParent is AbstractPortrait)))
                {
                    AvatarMC(MovieClip(lastParent).pAV.pMC).setColor(part, "none", location, shade);
                    break;
                };
                if (lastParent.name == "mcPreview")
                {
                    this.world.myAvatar.pMC.setColor(part, "none", location, shade);
                    break;
                };
                lastParent = lastParent.parent;
            };
        }

        public function updateAreaName():void
        {
            var playerCount:int;
            playerCount = this.world.areaUsers.length;
            var baseName:String = this.world.strAreaName.split(":")[0];
            var areaText:* = ((((((playerCount + " player") + ((playerCount > 1) ? "s" : "")) + " in <font color='#FFFF00'>") + baseName) + ((this.world.strAreaName.indexOf(":") > -1) ? " (party)" : "")) + "</font>");
            this.ui.mcInterface.areaList.title.t1.htmlText = areaText;
        }

        internal function onLinkClick(event:TextEvent):void
        {
            switch (event.text)
            {
                case "dangerOpen":
                    MainController.modal("Warning: You have entered a danger zone. Player-vs-Player combat is permitted here. Proceed with caution!", null, {}, "red,medium", "mono");
                    break;
                case "safeOpen":
                    MainController.modal("You are now in a safe zone. Player-vs-Player combat is restricted, ensuring a peaceful environment.", null, {}, "green,medium", "mono");
                    break;
            };
        }

        public function areaListGet():void
        {
            var _local1:Object;
            var _local2:Object;
            var _local3:String;
            var _local4:*;
            var _local7:String;
            _local1 = {};
            _local2 = this.network.room.getUserList();
            for (_local7 in _local2)
            {
                _local4 = this.world.uoTree[_local2[_local7].getName()];
                if (_local4 != null)
                {
                    _local1[_local7] = {
                        "strUsername":_local4.strUsername,
                        "intLevel":_local4.intLevel
                    };
                };
            };
            this.areaListShow(_local1);
        }

        public function areaListShow(_arg1:Object):void
        {
            var _local2:MovieClip;
            var _local3:int;
            var _local4:String;
            var _local5:*;
            var _local8:String;
            _local2 = this.ui.mcInterface.areaList;
            _local3 = 0;
            for (_local8 in _arg1)
            {
                _local5 = _local2.cnt.addChild(((this.userPreference.data.bitCheckedMobile) ? new aProtoMobile() : new aProto()));
                _local5.objData = _arg1[_local8];
                _local5.txtName.text = _arg1[_local8].strUsername;
                _local5.txtLevel.text = _arg1[_local8].intLevel;
                _local5.addEventListener(MouseEvent.CLICK, this.areaListNameClick, false, 0, true);
                _local5.buttonMode = true;
                _local5.y = -(int((_local3 * 14)));
                _local3++;
            };
            _local2.cnt.iproto.visible = false;
            _local2.visible = true;
        }

        public function getUserName():String
        {
            if (((((!(this.world == null)) && (!(this.world.myAvatar == null))) && (!(this.world.myAvatar.objData == null))) && ("strUserName" in this.world.myAvatar.objData)))
            {
                return (this.world.myAvatar.objData.strUserName);
            };
            return ("");
        }

        public function hideInterface():void
        {
            this.ui.visible = false;
        }

        public function showInterface():void
        {
            this.ui.visible = true;
        }

        public function loadExternalSWF(_arg1:String):void
        {
            this.ldrMC.loadFile(this.mcExtSWF, _arg1, "Game Files");
            this.hideInterface();
            this.world.visible = false;
        }

        public function clearExternamSWF():void
        {
            while (this.mcExtSWF.numChildren > 0)
            {
                this.mcExtSWF.removeChildAt(0);
            };
            this.world.visible = true;
            this.showInterface();
        }

        public function openCharacterCustomize():void
        {
            this.ui.mcPopup.fOpen("Customize");
        }

        public function openArmorCustomize():void
        {
            this.ui.mcPopup.fOpen("ArmorColor");
        }

        public function showFactionInterface():void
        {
            this.ui.mcPopup.fOpen("Faction");
        }

        public function showConfirmtaionBox(sMsg:String, fHandler:Function):void
        {
            var modal:ModalMC = new ModalMC();
            var modalO:Object = {};
            modalO.strBody = sMsg;
            modalO.btns = "dual";
            modalO.params = {};
            modalO.callback = function (sMsg:Object):void
            {
                fHandler(sMsg.accept);
            };
            this.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function showMessageBox(sMsg:String, fHandler:Function=null):void
        {
            var modal:ModalMC = new ModalMC();
            var modalO:Object = {};
            modalO.strBody = sMsg;
            modalO.btns = "mono";
            modalO.params = {};
            modalO.callback = function (sMsg:Object):void
            {
                if (fHandler != null)
                {
                    fHandler();
                };
            };
            this.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function getServerTime():Date
        {
            return (new Date((this.ts_login_server + (new Date().getTime() - this.ts_login_client))));
        }

        public function removeApop():void
        {
            if (this.apop == null)
            {
                return;
            };
            this.apop_ = null;
            this.world.removeMovieFront();
        }

        public function createApop():void
        {
            if (this.apop_ != null)
            {
                this.removeApop();
            };
            this.apop_ = new apopCore((this as MovieClip), this.apopTree[this.curID]);
            this.apop_.x = 270;
            this.apop_.y = 20;
            this.world.FG.addChild(this.apop_);
            this.world.FG.mouseChildren = true;
        }

        public function rand(_arg1:Number=0, _arg2:Number=1):Number
        {
            return (this.rn.rand(_arg1, _arg2));
        }

        public function traceHack(_arg1:String):void
        {
            this.chatF.pushMsg("server", _arg1, "SERVER", "", 0);
        }

        public function isRecent(_arg1:String):Boolean
        {
            var d:Date;
            var now:Date;
            var s:String;
            s = _arg1;
            if (((s == null) || (s == "")))
            {
                return (false);
            };
            d = new Date();
            try
            {
                d.setTime(Date.parse(s));
            }
            catch(e)
            {
                return (false);
            };
            d.setDate((d.getDate() + 1));
            now = new Date();
            return (d.getTime() > now.getTime());
        }

        public function getStaticData(data:String):String
        {
            switch (data)
            {
                case "account":
                    return (Config.serverAccountURL);
                case "social":
                    return (Config.serverSocialURL);
                case "redirect":
                    return (Config.serverRedirectURL);
                case "discord":
                    return (Config.serverDiscordURL);
            };
            return ("");
        }

        public function frameCheck(part:MovieClip, specifiedLabel:String):Boolean
        {
            var i:uint;
            i = 0;
            while (i < part.currentLabels.length)
            {
                if (part.currentLabels[i].name == specifiedLabel)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function getGamefilesURL():String
        {
            return (Config.serverNormalGamefilesURL);
        }

        public function dateCompare(date1:Date, date2:Date):*
        {
            var ClaimDate:*;
            var ServerDate:*;
            ClaimDate = ((((date1.getFullYear() + "/") + date1.getMonth()) + "/") + date1.getDate());
            ServerDate = ((((date2.getFullYear() + "/") + date2.getMonth()) + "/") + date2.getDate());
            return (ClaimDate == ServerDate);
        }

        public function playBGM(event:*=null):void
        {
            if (this.version.setting == null)
            {
                return;
            };
            loadBGM(Config.getLoadPath(this.version.setting.file_song));
        }

        public function drawBankFilters():void
        {
            var mcFocus:MovieClip;
            var bankfiltersMC:BankFilter;
            if (!this.ui.mcPopup.getChildByName("mcBank"))
            {
                return;
            };
            mcFocus = MovieClip(this.ui.mcPopup.getChildByName("mcBank")).bankPanel.frames[8].mc;
            if (mcFocus.getChildByName("bankFiltersMC"))
            {
                return;
            };
            mcFocus.ti.visible = false;
            bankfiltersMC = new BankFilter(this);
            mcFocus.addChild(bankfiltersMC);
            bankfiltersMC.y = (bankfiltersMC.y + 5);
            bankfiltersMC.name = "bankFiltersMC";
        }

        public function getBaseHPByLevel(_arg1:*):*
        {
            if (_arg1 < 1)
            {
                _arg1 = 1;
            };
            if (_arg1 > this.intLevelCap)
            {
                _arg1 = this.intLevelCap;
            };
            return (Math.round((this.PChpBase1 + (Math.pow(((_arg1 - 1) / (this.intLevelCap - 1)), this.curveExponent) * this.PChpDelta))));
        }

        public function resumeOnLoginResponse():void
        {
            this.mcConnDetail.showConn("Welcome to Astrista!");
            this.network.send("firstJoin", [this.getClientPlatform()]);
            if (this.chatF.ignoreList.data.users.length > 0)
            {
                this.network.send("cmd", ["ignoreList", this.chatF.ignoreList.data.users]);
            }
            else
            {
                this.network.send("cmd", ["ignoreList", "$clearAll"]);
            };
        }

        public function sActAdd(blanki:int):void
        {
            var actBar:MovieClip;
            var delIcon:MovieClip;
            actBar = this.ui.mcInterface.actBar;
            delIcon = MovieClip(actBar.getChildByName(("i" + (blanki + 1))));
            actBar.getChildByName(("blank" + blanki)).visible = true;
            if (delIcon != null)
            {
                delIcon.removeEventListener(MouseEvent.CLICK, this.actIconClick);
                delIcon.removeEventListener(MouseEvent.MOUSE_OVER, this.actIconOver);
                delIcon.removeEventListener(MouseEvent.MOUSE_OUT, this.actIconOut);
                if (delIcon.icon2 != null)
                {
                    delIcon.removeEventListener(Event.ENTER_FRAME, this.world.countDownAct);
                    if (delIcon.icon2.mask != null)
                    {
                        actBar.removeChild(delIcon.icon2.mask);
                        delIcon.icon2.mask = null;
                    };
                    actBar.removeChild(delIcon.icon2);
                };
                actBar.removeChild(delIcon);
            };
            blanki++;
        }

        public function checkForFrame(mc:MovieClip, frame:String):*
        {
            var label:Object;
            for each (label in mc.currentLabels)
            {
                if (label.name == frame)
                {
                    return (true);
                };
            };
        }

        internal function replaceString(_arg1:String, _arg2:String, _arg3:String):String
        {
            var _local4:Number;
            var _local5:Number;
            var _local6:*;
            _local4 = 0;
            _local5 = 0;
            _local6 = "";
            while ((_local4 = _arg1.indexOf(_arg2, _local4)) != -1)
            {
                _local6 = (_local6 + (_arg1.substring(_local5, _local4) + _arg3));
                _local4 = (_local4 + _arg2.length);
                _local5 = _local4;
            };
            return ((_local6 == "") ? _arg1 : _local6);
        }

        internal function traceObject(_arg1:*, _arg2:*=1):*
        {
            var _local4:*;
            var _local5:*;
            var _local3:*;
            _local3 = "";
            while (_local3.length < _arg2)
            {
                _local3 = (_local3 + " ");
            };
            _arg2++;
            if (((typeof(_arg1) == "object") && (!(_arg1.length == null))))
            {
                _local4 = 0;
                while (_local4 < _arg1.length)
                {
                    _local4++;
                };
            }
            else
            {
                for (_local5 in _arg1)
                {
                    if (typeof(_arg1[_local5]) == "object")
                    {
                        this.traceObject(_arg1[_local5], _arg2);
                    };
                };
            };
        }

        internal function spaceBy(_arg1:int, _arg2:int):String
        {
            var _local3:String;
            _local3 = String(_arg1);
            while (_local3.length < _arg2)
            {
                _local3 = (_local3 + " ");
            };
            return (_local3);
        }

        internal function spaceNumBy(_arg1:Number, _arg2:int):String
        {
            var _local3:String;
            _local3 = _arg1.toString();
            _local3 = _local3.substr(0, _arg2);
            while (_local3.length < _arg2)
            {
                _local3 = (_local3 + " ");
            };
            return (_local3);
        }

        internal function showRatings():void
        {
            var _local6:*;
            var _local7:*;
            var _local8:*;
            var _local9:*;
            var _local10:*;
            var _local11:*;
            var _local12:*;
            var _local13:*;
            var _local14:*;
            var _local15:*;
            var _local16:*;
            var _local1:*;
            var _local2:*;
            var _local3:*;
            var _local4:*;
            _local1 = this.world.myAvatar.dataLeaf;
            _local2 = "";
            _local3 = 1;
            _local4 = 0;
            var _local5:* = 0;
            _local3 = 1;
            while (_local3 <= 35)
            {
                if (_local3 == 0)
                {
                    _local3 = 1;
                };
                _local6 = this.getInnateStats(_local3);
                _local7 = this.getIBudget(_local3, 1);
                _local8 = -1;
                _local9 = -1;
                _local10 = -1;
                _local11 = -1;
                _local12 = _local1.sCat;
                _local13 = this.copyObj(_local1.sta);
                this.resetTableValues(_local13);
                _local14 = this.getBaseHPByLevel(_local3);
                _local15 = ((_local14 / 20) * 0.7);
                _local16 = (((2.25 * _local15) / (100 / this.intAPtoDPS)) / 2);
                _local4 = 0;
                while (_local4 < MainController.stats.length)
                {
                    _local2 = MainController.stats[_local4];
                    _local11 = _local13[("$" + _local2)];
                    switch (_local2)
                    {
                        case "STR":
                            _local8 = _local16;
                            _local13.$ap = (_local13.$ap + (_local11 * 2));
                            _local13.$tcr = (_local13.$tcr + (((_local11 / _local8) / 100) * 0.4));
                            break;
                    };
                    _local4++;
                };
                _local3++;
            };
        }

        internal function getIBudget(_arg1:int, _arg2:int):int
        {
            var _local3:int;
            if (_arg1 < 1)
            {
                _arg1 = 1;
            };
            if (_arg1 > this.intLevelCap)
            {
                _arg1 = this.intLevelCap;
            };
            if (_arg2 < 1)
            {
                _arg2 = 1;
            };
            _arg1 = Math.round(((_arg1 + _arg2) - 1));
            _local3 = Math.round((this.GstBase + (Math.pow(((_arg1 - 1) / (this.intLevelCap - 1)), this.statsExponent) * (this.GstGoal - this.GstBase))));
            return (_local3);
        }

        internal function getInnateStats(_arg1:int):int
        {
            if (_arg1 < 1)
            {
                _arg1 = 1;
            };
            if (_arg1 > this.intLevelCap)
            {
                _arg1 = this.intLevelCap;
            };
            return (Math.round((this.PCstBase + (Math.pow(((_arg1 - 1) / (this.intLevelCap - 1)), this.statsExponent) * (this.PCstGoal - this.PCstBase)))));
        }

        private function initLoginWarning():void
        {
            var warning:MovieClip;
            var _local2:Number;
            var _local3:Number;
            var _local4:Number;
            warning = (this.mcLogin.WarningCounter as MovieClip);
            warning.visible = true;
            this.mcLogin.btnLogin.visible = false;
            _local2 = new Date().getTime();
            _local3 = this.userPreference.data.logoutWarningTS;
            _local4 = this.userPreference.data.logoutWarningDur;
            warning.n = Math.round((((_local3 + (_local4 * 1000)) - _local2) / 1000));
            warning.ti.text = ((warning.s.split("$s")[0] + warning.n) + warning.s.split("$s")[1]);
            warning.timer = new Timer(1000);
            warning.timer.addEventListener(TimerEvent.TIMER, this.onDisconnectTimer(this.mcLogin));
            warning.timer.start();
        }

        private function logoutFinal():void
        {
            if (this.world != null)
            {
                try
                {
                    this.world.exitCombat();
                    this.world.setTarget(null);
                    this.world.killWorld();
                    this.onRemoveChildrens(this.world);
                    if (((!(this.world.map == null)) && (this.world.contains(this.world.map))))
                    {
                        this.world.removeChild(this.world.map);
                    };
                    this.world = null;
                }
                catch(error:Error)
                {
                    trace("[Game] logoutFinal", error.getStackTrace());
                };
            };
        }

        private function initInterface():void
        {
            var i:int;
            var keyName:String;
            var keyText:String;
            var keyField:TextField;
            this.ui.mcFPS.visible = false;
            this.ui.mcRes.visible = false;
            this.ui.mcPopup.visible = false;
            this.ui.mcPortrait.visible = false;
            this.ui.mcPortrait.iconBoostXP.visible = false;
            this.ui.mcPortrait.iconBoostG.visible = false;
            this.ui.mcPortrait.iconBoostRep.visible = false;
            this.ui.mcPortrait.iconBoostCP.visible = false;
            this.ui.mcPopup.visible = false;
            this.hidePortraitTarget();
            this.ui.visible = false;
            this.ui.mcInterface.mcXPBar.mcXP.scaleX = 0;
            this.ui.mcInterface.mcRepBar.mcRep.scaleX = 0;
            this.ui.mcUpdates.uproto.mouseEnabled = false;
            this.ui.mcUpdates.uproto.visible = false;
            this.ui.mcUpdates.uproto.y = -400;
            this.hideMCPVPQueue();
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.key_actBar);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.key_StageLogin);
            this.ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OVER, this.xpBarMouseOver);
            this.ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OUT, this.xpBarMouseOut);
            this.ui.mcInterface.mcRepBar.removeEventListener(MouseEvent.MOUSE_OVER, this.onRepBarMouseOver);
            this.ui.mcInterface.mcRepBar.removeEventListener(MouseEvent.MOUSE_OUT, this.onRepBarMouseOut);
            this.ui.mcPortraitTarget.removeEventListener(MouseEvent.CLICK, this.portraitClick);
            this.ui.mcPortrait.removeEventListener(MouseEvent.CLICK, this.portraitClick);
            this.ui.mcPortrait.iconBoostXP.removeEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostXPOver);
            this.ui.mcPortrait.iconBoostXP.removeEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.mcPortrait.iconBoostG.removeEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostGoldOver);
            this.ui.mcPortrait.iconBoostG.removeEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.mcPortrait.iconBoostRep.removeEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostRepOver);
            this.ui.mcPortrait.iconBoostRep.removeEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.mcPortrait.iconBoostCP.removeEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostCPOver);
            this.ui.mcPortrait.iconBoostCP.removeEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.btnTargetPortraitClose.removeEventListener(MouseEvent.CLICK, this.onTargetPortraitCloseClick);
            this.ui.mcPVPQueue.removeEventListener(MouseEvent.CLICK, this.onMCPVPQueueClick);
            this.ui.mcInterface.tl.mouseEnabled = false;
            this.chatF.init();
            stage.addEventListener(KeyboardEvent.KEY_UP, this.key_actBar);
            this.ui.mcInterface.mcXPBar.strXP.visible = false;
            this.ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OVER, this.xpBarMouseOver);
            this.ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OUT, this.xpBarMouseOut);
            this.ui.mcInterface.mcRepBar.strRep.visible = false;
            this.ui.mcInterface.mcRepBar.addEventListener(MouseEvent.MOUSE_OVER, this.onRepBarMouseOver);
            this.ui.mcInterface.mcRepBar.addEventListener(MouseEvent.MOUSE_OUT, this.onRepBarMouseOut);
            this.ui.mcPortraitTarget.addEventListener(MouseEvent.CLICK, this.portraitClick);
            this.ui.mcPortrait.addEventListener(MouseEvent.CLICK, this.portraitClick);
            this.ui.mcPortrait.iconBoostXP.addEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostXPOver);
            this.ui.mcPortrait.iconBoostXP.addEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.mcPortrait.iconBoostG.addEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostGoldOver);
            this.ui.mcPortrait.iconBoostG.addEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.mcPortrait.iconBoostRep.addEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostRepOver);
            this.ui.mcPortrait.iconBoostRep.addEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.mcPortrait.iconBoostCP.addEventListener(MouseEvent.MOUSE_OVER, this.oniconBoostCPOver);
            this.ui.mcPortrait.iconBoostCP.addEventListener(MouseEvent.MOUSE_OUT, this.oniconBoostOut);
            this.ui.btnTargetPortraitClose.addEventListener(MouseEvent.CLICK, this.onTargetPortraitCloseClick);
            this.ui.mcPVPQueue.addEventListener(MouseEvent.CLICK, this.onMCPVPQueueClick);
            this.ui.iconQuest.visible = false;
            this.ui.iconQuest.buttonMode = true;
            this.ui.iconQuest.addEventListener(MouseEvent.CLICK, this.oniconQuestClick);
            this.ui.mcInterface.tl.mouseEnabled = false;
            this.ui.mcInterface.areaList.mouseEnabled = false;
            this.ui.mcInterface.areaList.title.mouseEnabled = false;
            this.ui.mcInterface.areaList.title.bMinMax.addEventListener(MouseEvent.CLICK, this.areaListClick);
            this.ui.mcInterface.txtCombat.mouseEnabled = false;
            this.ui.mcInterface.btnCombat.addEventListener(MouseEvent.CLICK, this.toggleAutoCombat, false, 0, true);
            if (this.userPreference.data.bitCheckedMobile)
            {
                this.uoPref.bTT = false;
                this.ui.mcInterface.actBar.btnToggle.addEventListener(MouseEvent.CLICK, this.toggleSkill, false, 0, true);
                this.ui.joystick.visible = false;
            };
            if (!Game.root.userPreference.data["combatHideSelfAuras"])
            {
                this.playerAuras = new PlayerAuras();
                this.ui.mcPortrait.addChild(this.playerAuras);
            };
            if (!Game.root.userPreference.data["combatHideTargetAuras"])
            {
                this.targetAuras = new TargetAuras();
                this.ui.mcPortraitTarget.addChild(this.targetAuras);
            };
            this.showServerLatencyCheck();
            this.hideServerTimeCheck();
            this.keyboardDictionary = this.getKeyboardDict();
            i = 0;
            while (i < 6)
            {
                keyName = ("Skill " + i);
                if (i == 0)
                {
                    keyName = "Auto Attack";
                }
                else
                {
                    if (i == 5)
                    {
                        keyName = "Item";
                    };
                };
                keyText = ((this.userPreference.data.keys[keyName]) ? this.keyboardDictionary[this.userPreference.data["keys"][keyName]] : " ");
                keyField = (this.ui.mcInterface.getChildByName(("keyA" + i)) as TextField);
                keyField.text = keyText;
                keyField.mouseEnabled = false;
                i++;
            };
        }

        public function toggleAutoCombat(event:MouseEvent):void
        {
            this.mixer.playSound("Click");
            this.onAutoCombat = (!(this.onAutoCombat));
            this.ui.mcInterface.txtCombat.text = ((this.onAutoCombat) ? "Stop Auto Combat" : "Start Auto Combat");
            this.chatF.pushMsg("server", ((this.onAutoCombat) ? "Auto combat has started." : "Auto combat has been stopped."), "SERVER", "", 0);
            if (this.onAutoCombat)
            {
                MainController.modal("Auto combat has started. Please claim your drops promptly to ensure the safety of your items.", null, {}, "red,medium", "mono");
                this.world.approachTarget();
                if (!this.autoCombatTimer)
                {
                    this.autoCombatTimer = new Timer(this.autoCombatInterval);
                };
                this.autoCombatTimer.addEventListener(TimerEvent.TIMER, this.onAutoCombatTick);
                this.autoCombatTimer.start();
            }
            else
            {
                if (((this.autoCombatTimer) && (this.autoCombatTimer.running)))
                {
                    this.autoCombatTimer.stop();
                    this.autoCombatTimer.removeEventListener(TimerEvent.TIMER, this.onAutoCombatTick);
                };
            };
        }

        private function onAutoCombatTick(event:TimerEvent):void
        {
            var HPPercentage:Number;
            var MPPercentage:Number;
            var skill:Skill;
            if (((!(Game.root.currentLabel == "Game")) && (!(Game.root.currentLabel == "Mobile"))))
            {
                this.autoCombatTimer.stop();
                return;
            };
            if (this.world.myAvatar == null)
            {
                return;
            };
            if (this.world.myAvatar.dataLeaf.intState == 0)
            {
                return;
            };
            HPPercentage = (this.world.myAvatar.dataLeaf.intHP / this.world.myAvatar.dataLeaf.intHPMax);
            MPPercentage = (this.world.myAvatar.dataLeaf.intMP / this.world.myAvatar.dataLeaf.intMPMax);
            if (((this.world.myAvatar.dataLeaf.intState == 1) && ((HPPercentage <= 0.05) || (MPPercentage <= 0.03))))
            {
                this.world.exitCombat();
                this.world.cancelTarget();
                this.isAutoCombatResting = true;
                this.world.rest();
                return;
            };
            skill = this.world.actions.active[Math.floor((Math.random() * this.world.actions.active.length))];
            if ((((((skill.ref == "a1") || (skill.ref == "a2")) || (skill.ref == "a3")) || (skill.ref == "a4")) || (((!(((skill.ref == "i1") && (skill.typ == "i")) && (skill.sArg1 == ""))) && (this.world.actionTimeCheck(skill))) && (this.world.myAvatar.dataLeaf.intMP >= skill.mp))))
            {
                if (skill.isOK)
                {
                    this.world.combatAction(skill);
                };
                this.world.approachTarget();
            };
        }

        private function loadUserPreference():void
        {
            var TempLoginName:String;
            var TempLoginPass:String;
            if (this.userPreference.data.bitCheckedUsername)
            {
                TempLoginName = "";
                this.mcLogin.ni.text = ((TempLoginName != "") ? TempLoginName : this.userPreference.data.strUsername);
                TempLoginPass = "";
                this.mcLogin.pi.text = ((TempLoginPass != "") ? TempLoginPass : this.userPreference.data.strPassword);
                this.mcLogin.chkUserName.bitChecked = true;
            };
            if (this.userPreference.data.bitCheckedMobile)
            {
                this.mcLogin.chkMobile.bitChecked = true;
            };
            this.mcLogin.chkUserName.checkmark.visible = this.mcLogin.chkUserName.bitChecked;
            this.mcLogin.chkMobile.checkmark.visible = this.mcLogin.chkMobile.bitChecked;
            this.videoSettingsQualityCheck();
            this.videoSettingsFPSCheck();
            this.audioSettingsOverallCheck();
            this.audioSettingsSoundEffectCheck();
            this.audioSettingsBackgroundMusicCheck();
        }

        public function videoSettingsQualityCheck():void
        {
            this.userPreference.data["videoSettingsQuality"] = ((this.userPreference.data["videoSettingsQuality"] != null) ? this.userPreference.data["videoSettingsQuality"] : 4);
            stage.quality = this.arrQuality[this.userPreference.data["videoSettingsQuality"]];
        }

        public function videoSettingsFPSCheck():void
        {
            this.userPreference.data["videoSettingsFPS"] = ((this.userPreference.data["videoSettingsFPS"] != null) ? this.userPreference.data["videoSettingsFPS"] : 0);
            stage.frameRate = this.arrFPS[this.userPreference.data["videoSettingsFPS"]];
            World.TICK_MAX = stage.frameRate;
        }

        public function audioSettingsOverallCheck():void
        {
            this.userPreference.data["audioSettingsOverall"] = ((this.userPreference.data["audioSettingsOverall"] != null) ? this.userPreference.data["audioSettingsOverall"] : 10);
            SoundMixer.soundTransform = new SoundTransform(this.arrVolume[this.userPreference.data["audioSettingsOverall"]]);
        }

        public function audioSettingsSoundEffectCheck():void
        {
            this.userPreference.data["audioSettingsSoundEffect"] = ((this.userPreference.data["audioSettingsSoundEffect"] != null) ? this.userPreference.data["audioSettingsSoundEffect"] : 10);
            this.mixer.stf = new SoundTransform(this.arrVolume[this.userPreference.data["audioSettingsSoundEffect"]]);
        }

        public function audioSettingsBackgroundMusicCheck():void
        {
            this.userPreference.data["audioSettingsBackgroundMusic"] = ((this.userPreference.data["audioSettingsBackgroundMusic"] != null) ? this.userPreference.data["audioSettingsBackgroundMusic"] : 10);
            BGMTransform.volume = this.arrVolume[this.userPreference.data["audioSettingsBackgroundMusic"]];
            if (BGMChannel != null)
            {
                BGMChannel.soundTransform = BGMTransform;
            };
        }

        private function saveUserPreference():*
        {
            this.userPreference.data.bitCheckedUsername = this.mcLogin.chkUserName.bitChecked;
            if (this.mcLogin.chkUserName.bitChecked)
            {
                this.userPreference.data.strUsername = this.mcLogin.ni.text;
                this.userPreference.data.strPassword = this.mcLogin.pi.text;
            }
            else
            {
                this.userPreference.data.strUsername = "";
                this.userPreference.data.strPassword = "";
            };
            this.userPreference.data.bitCheckedMobile = this.mcLogin.chkMobile.bitChecked;
            this.userPreference.flush();
        }

        private function getPVPMessage(_arg1:String, _arg2:Boolean):String
        {
            switch (_arg1)
            {
                case "Restorer":
                    return ((_arg2) ? ((this.world.strMapName == "dagepvp") ? "An enemy Blade Master has been defeated! Dage's healing powers are waning!" : "An enemy Restorer has been defeated! The Captain's healing powers are waning!") : ((this.world.strMapName == "dagepvp") ? "A Blade Master has been defeated!\t Dage's healing powers are waning!" : "A Restorer has been defeated!\t Our Captain's healing powers are waning!"));
                case "Brawler":
                    return ((_arg2) ? ((this.world.strMapName == "dagepvp") ? "An enemy Legion Guard has been defeated!  Dage's attacks grow weaker!" : "An enemy Brawler has been defeated!  The Captain's attacks grow weaker!") : ((this.world.strMapName == "dagepvp") ? "A Legion Guard has been defeated!\tRally to Dage's defense!" : "A Brawler has been defeated!\tRally to the Captain's defense!"));
                case "Captain":
                    return ((_arg2) ? ((this.world.strMapName == "dagepvp") ? "Dage has been defeated!" : "The enemy captain has been defeated!") : ((this.world.strMapName == "dagepvp") ? "Dage has been fallen to the enemy!" : "Our Captain has been fallen to the enemy!"));
                default:
                    return ("");
            };
        }

        public function hideHelpWindow(event:MouseEvent):void
        {
        }

        public function toggleSkill(mouseEvent:MouseEvent):void
        {
            var btnY:int;
            var blanki2:Number;
            var blanki:Number;
            btnY = 29;
            if (this.ui.mcInterface.actBar.btnToggle.y != btnY)
            {
                this.ui.mcInterface.actBar.btnToggle.y = btnY;
                blanki = 0;
                while (blanki < this.ui.mcInterface.actBar.numChildren)
                {
                    if ((this.ui.mcInterface.actBar.getChildAt(blanki) is MovieClip))
                    {
                        this.ui.mcInterface.actBar.getChildAt(blanki).visible = false;
                    };
                    blanki++;
                };
                return;
            };
            this.ui.mcInterface.actBar.btnToggle.y = -166.2;
            blanki2 = 0;
            while (blanki2 < this.ui.mcInterface.actBar.numChildren)
            {
                if ((this.ui.mcInterface.actBar.getChildAt(blanki2) is MovieClip))
                {
                    this.ui.mcInterface.actBar.getChildAt(blanki2).visible = true;
                };
                blanki2++;
            };
        }

        public function key_StageLogin(_arg1:KeyboardEvent):void
        {
            if (((_arg1.target == stage) && (_arg1.charCode == Keyboard.ENTER)))
            {
                stage.focus = this.mcLogin.ni;
            };
        }

        private function handleRandomMonsterTarget():void
        {
            var monsters:Array;
            var randomIndex:uint;
            var monster:*;
            if (!this.isActionAllowed())
            {
                return;
            };
            monsters = this.world.getMonstersByCell(this.world.strFrame);
            if (monsters.length > 0)
            {
                randomIndex = uint(uint((Math.random() * (monsters.length - 1))));
                monster = monsters[randomIndex];
                if (((((monster) && (monster.pMC)) && (monster.dataLeaf.strFrame == this.world.strFrame)) && (!(monster.dataLeaf.intState == 0))))
                {
                    this.world.setTarget(monster);
                };
            };
        }

        private function isKeybindActive():Boolean
        {
            return (this.ui.mcPopup.currentLabel == "OptionPanel");
        }

        private function isTextInput(event:KeyboardEvent):Boolean
        {
            return ((event.target is TextField) || (event.currentTarget is TextField));
        }

        private function isActionAllowed():Boolean
        {
            return ((stage.focus == null) || (("text" in stage.focus) == false));
        }

        public function key_StageGame(event:KeyboardEvent):*
        {
            if (((this.isKeybindActive()) || (this.isTextInput(event))))
            {
                return;
            };
            switch (event.keyCode)
            {
                case Keyboard.ENTER:
                case (String.fromCharCode(event.charCode) == "/"):
                    if (this.chatSession.panel())
                    {
                        this.chatSession.panel().toggleChat();
                    }
                    else
                    {
                        this.chatF.openMsgEntry();
                    };
                    return;
                case this.userPreference.data.keys["Change Target"]:
                    this.handleRandomMonsterTarget();
                    return;
                case this.userPreference.data.keys["Cancel Target"]:
                    this.onTargetPortraitCloseClick(null);
                    return;
                case this.userPreference.data.keys["Area Information"]:
                    if (this.ui.mcOFrame.isOpen)
                    {
                        this.ui.mcOFrame.fClose();
                    }
                    else
                    {
                        this.world.sendWhoRequest();
                    };
                    break;
                case this.userPreference.data.keys["Bank"]:
                    if (this.world.myAvatar.isUpgraded())
                    {
                        this.world.toggleBank();
                    };
                    break;
                case this.userPreference.data.keys["Auction"]:
                    if (this.world.myAvatar.isStaff())
                    {
                        this.toggleAuction();
                    };
                    return;
                case this.userPreference.data.keys["World Boss"]:
                    if (this.world.myAvatar.isStaff())
                    {
                        this.toggleWorldBossBoard();
                    };
                    return;
                case this.userPreference.data.keys["Map Builder"]:
                    if (this.world.myAvatar.isStaff())
                    {
                        this.toggleMCMapBuilder();
                    };
                    return;
                case this.userPreference.data.keys["Npc Builder"]:
                    if (this.world.myAvatar.isStaff())
                    {
                        this.toggleMCNPCBuilder();
                    };
                    return;
                case this.userPreference.data.keys["Staff Panel"]:
                    if (this.world.myAvatar.isStaff())
                    {
                        this.toggleStaffPanel();
                    };
                    return;
                case this.userPreference.data.keys["Battle Pass"]:
                    if (this.world.myAvatar.isStaff())
                    {
                        this.toggleBattlePass();
                    };
                    return;
                case this.userPreference.data.keys["Character"]:
                    this.toggleCharpanel("overview");
                    break;
                case this.userPreference.data.keys["Friends"]:
                    if (this.ui.mcOFrame.isOpen)
                    {
                        this.ui.mcOFrame.fClose();
                    }
                    else
                    {
                        this.world.showFriendsList();
                    };
                    break;
                case this.userPreference.data.keys["Guild"]:
                    this.toggleGuildPanel();
                    break;
                case this.userPreference.data.keys["Inventory"]:
                    this.ui.mcInterface.mcMenu.toggleInventory();
                    return;
                case this.userPreference.data.keys["World Map"]:
                    this.toggleWorldMapPanel();
                    return;
                case this.userPreference.data.keys["Settings"]:
                    this.toggleOptionPanel();
                    return;
                case this.userPreference.data.keys["Option"]:
                    this.toggleOption2Panel();
                    return;
                case this.userPreference.data.keys["Player Vs Player"]:
                    this.togglePVPPanelinMap();
                    return;
                case this.userPreference.data.keys["Quests"]:
                    if (stage.focus != this.ui.mcInterface.te)
                    {
                        this.world.toggleQuestLog();
                    };
                    return;
                case this.userPreference.data.keys["Bot"]:
                    this.toggleBotPanel();
                    return;
                case this.userPreference.data.keys["Rest"]:
                    this.world.rest();
                    return;
                case this.userPreference.data.keys["Toggle Avatar HP Bar"]:
                    this.world.toggleHPBar();
                    return;
                case this.userPreference.data.keys["Inner Force"]:
                    this.toggleCoreStatPanel();
                    return;
                case this.userPreference.data.keys["Ignore"]:
                    this.world.showIgnoreList();
                    return;
                case this.userPreference.data.keys["Toggle Party Panel"]:
                    this.ui.mcPartyFrame.visible = (!(this.ui.mcPartyFrame.visible));
                    return;
                case this.userPreference.data.keys["Toggle Quest Tracker"]:
                    this.ui.mcQTracker.toggle();
                    return;
                case this.userPreference.data.keys["Change Quality"]:
                    this.userPreference.data["videoSettingsQuality"] = (this.userPreference.data["videoSettingsQuality"] + ((this.userPreference.data["videoSettingsQuality"] == 4) ? 0 : 1));
                    this.videoSettingsQualityCheck();
                    return;
                case this.userPreference.data.keys["Change FPS"]:
                    this.userPreference.data["videoSettingsFPS"] = (this.userPreference.data["videoSettingsFPS"] + ((this.userPreference.data["videoSettingsFPS"] == 4) ? 0 : 1));
                    this.videoSettingsFPSCheck();
                    return;
                case this.userPreference.data.keys["Toggle Overall Sounds"]:
                    this.toggleAudioSetting("audioSettingsOverall", "audioSettingsOverallBackup", this.audioSettingsOverallCheck);
                    return;
                case this.userPreference.data.keys["Toggle Sound Effects"]:
                    this.toggleAudioSetting("audioSettingsSoundEffect", "audioSettingsSoundEffectBackup", this.audioSettingsOverallCheck);
                    return;
                case this.userPreference.data.keys["Toggle Background Music"]:
                    this.toggleAudioSetting("audioSettingsBackgroundMusic", "audioSettingsBackgroundMusicBackup", this.audioSettingsOverallCheck);
                    return;
                case this.userPreference.data.keys["Titles"]:
                    this.network.send("loadTitles", []);
                    return;
                case this.userPreference.data.keys["Party"]:
                    this.togglePartyPanel();
                    return;
                case this.userPreference.data.keys["Vending"]:
                    this.toggleAuction(this.world.myAvatar.objData.strUsername);
                    return;
                case this.userPreference.data.keys["Rebirth"]:
                    this.toggleRebirthPanel();
                    return;
                case this.userPreference.data.keys["Daily Login"]:
                    this.toggleDailyLogin();
                    return;
                case this.userPreference.data.keys["Redeem Code"]:
                    this.toggleRedeemPanel();
                    return;
                case this.userPreference.data.keys["Inspect User"]:
                    this.toggleCharPage();
                    return;
                case this.userPreference.data.keys["Toggle World"]:
                    this.toggleWorldVisibility();
                    return;
                case this.userPreference.data.keys["Toggle Players"]:
                    this.toggleAvatarVisibilityOld();
                    return;
                case this.userPreference.data.keys["Toggle User Interface"]:
                    this.toggleUIVisibility(null);
                    return;
                case this.userPreference.data.keys["Toggle Props"]:
                    this.toggleHideRemoveProps();
                    return;
                case this.userPreference.data.keys["Fly"]:
                    this.world.flyToggle();
                    return;
                default:
                    trace(("Event Code: " + event.keyCode));
                    return;
            };
        }

        public function toggleAudioSetting(settingKey:String, backupKey:String, checkFunction:Function):void
        {
            if (this.userPreference.data[settingKey] != 0)
            {
                this.userPreference.data[backupKey] = this.userPreference.data[settingKey];
                this.userPreference.data[settingKey] = 0;
            }
            else
            {
                this.userPreference.data[settingKey] = this.userPreference.data[backupKey];
            };
            (checkFunction());
        }

        public function key_TextLogin(_arg1:KeyboardEvent):void
        {
            if (((!(_arg1.target == stage)) && (_arg1.charCode == Keyboard.ENTER)))
            {
                this.onLoginClick(null);
            };
        }

        public function key_ChatEntry(_arg1:KeyboardEvent):void
        {
            var chatText:String;
            if (_arg1.charCode == Keyboard.ENTER)
            {
                chatText = this.ui.mcInterface.te.htmlText;
                chatText = chatText.replace(Chat.regExpLinking1, "$1");
                chatText = chatText.replace(Chat.regExpLinking2, "$1");
                chatText = chatText.replace(Chat.regExpLinking3, '<A HREF="$1">$2</A>');
                this.chatF.submitMsg(chatText, this.chatF.chn.cur.typ, this.chatF.pmNm);
            };
            if (_arg1.charCode == Keyboard.ESCAPE)
            {
                this.chatF.closeMsgEntry();
            };
        }

        private function isNumpadKey(keyCode:int):Boolean
        {
            return ((keyCode >= 96) && (keyCode <= 105));
        }

        public function key_actBar(event:KeyboardEvent):void
        {
            var keyCode:int;
            var keyActions:Object;
            var actionIndex:String;
            var index:int;
            var action:String;
            var actionRef:Skill;
            if (this.isKeybindActive())
            {
                return;
            };
            if (((!(stage.focus)) || (!(stage.focus.hasOwnProperty("text")))))
            {
                keyCode = ((this.isNumpadKey(event.keyCode)) ? (event.keyCode - 96) : event.keyCode);
                keyActions = {
                    "0":this.userPreference.data.keys["Auto Attack"],
                    "1":this.userPreference.data.keys["Skill 1"],
                    "2":this.userPreference.data.keys["Skill 2"],
                    "3":this.userPreference.data.keys["Skill 3"],
                    "4":this.userPreference.data.keys["Skill 4"],
                    "5":this.userPreference.data.keys["Item"]
                };
                for (actionIndex in keyActions)
                {
                    index = int(actionIndex);
                    if (keyActions[index] == keyCode)
                    {
                        if (index == 0)
                        {
                            this.world.approachTarget();
                        }
                        else
                        {
                            action = this.world.actionMap[index];
                            if (action != null)
                            {
                                actionRef = this.world.getActionByRef(action);
                                if (actionRef.isOK)
                                {
                                    this.world.combatAction(actionRef);
                                };
                            };
                        };
                        return;
                    };
                };
            };
        }

        public function onAddedToStage(_arg1:Event):void
        {
            Game.root = this;
            stage.showDefaultContextMenu = false;
            stage.stageFocusRect = false;
            this.mcConnDetail = new ConnDetailMC();
            gotoAndPlay("Login");
        }

        public function onLoginError(event:Event):void
        {
            trace("Login Failed!", event);
        }

        public function onLoginComplete(_arg1:Event):void
        {
            var login:Object;
            login = JSON.parse(_arg1.target.data);
            this.loginLoader.removeEventListener(Event.COMPLETE, this.onLoginComplete);
            if (login.success != 1)
            {
                this.mcConnDetail.showError(login.sMsg);
                return;
            };
            User.TOKEN = login.user.Hash;
            User.CHARACTERS = login.characters;
            User.SERVERS = login.servers;
            this.chatF.chn = login.chat;
            Rarity.init(login.rarities);
            this.mcConnDetail.hideConn();
            this.mcLogin.gotoAndStop("Characters");
        }

        public function oniconQuestClick(mouseEvent:MouseEvent):void
        {
            if (((this.userPreference.data["questPinner"]) && (!(this.pinnedQuests == ""))))
            {
                if (mouseEvent.shiftKey)
                {
                    this.ui.mcQTracker.toggle();
                    return;
                };
                this.world.showQuests(Game.removeTrailingComma(this.pinnedQuests), "q");
            }
            else
            {
                this.ui.mcQTracker.toggle();
            };
        }

        public function oniconBoostXPOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip;
            var _local3:Number;
            var _local4:Number;
            var _local5:int;
            var _local6:String;
            _local2 = MovieClip(_arg1.currentTarget);
            _local3 = new Date().getTime();
            _local4 = Math.max(((_local2.boostTS + (_local2.iBoostXP * 1000)) - _local3), 0);
            _local5 = 0;
            _local6 = "All Experience gains are doubled.\n";
            if (_local4 < 120000)
            {
                _local5 = int(Math.floor((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minute(s), ")));
                _local5 = int(Math.round(((_local4 % 60000) / 1000)));
                _local6 = (_local6 + String((_local5 + " second(s) remaining.")));
            }
            else
            {
                _local5 = int(Math.round((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minutes remaining.")));
            };
            this.ui.ToolTip.openWith({"str":_local6});
        }

        public function oniconBoostGoldOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip;
            var _local3:Number;
            var _local4:Number;
            var _local5:int;
            var _local6:String;
            _local2 = MovieClip(_arg1.currentTarget);
            _local3 = new Date().getTime();
            _local4 = Math.max(((_local2.boostTS + (_local2.iBoostG * 1000)) - _local3), 0);
            _local5 = 0;
            _local6 = "All Gold gains are doubled.\n";
            if (_local4 < 120000)
            {
                _local5 = int(Math.floor((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minute(s), ")));
                _local5 = int(Math.round(((_local4 % 60000) / 1000)));
                _local6 = (_local6 + String((_local5 + " second(s) remaining.")));
            }
            else
            {
                _local5 = int(Math.round((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minutes remaining.")));
            };
            this.ui.ToolTip.openWith({"str":_local6});
        }

        public function oniconBoostRepOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip;
            var _local3:Number;
            var _local4:Number;
            var _local5:int;
            var _local6:String;
            _local2 = MovieClip(_arg1.currentTarget);
            _local3 = new Date().getTime();
            _local4 = Math.max(((_local2.boostTS + (_local2.iBoostRep * 1000)) - _local3), 0);
            _local5 = 0;
            _local6 = "All Reputation gains are doubled.\n";
            if (_local4 < 120000)
            {
                _local5 = int(Math.floor((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minute(s), ")));
                _local5 = int(Math.round(((_local4 % 60000) / 1000)));
                _local6 = (_local6 + String((_local5 + " second(s) remaining.")));
            }
            else
            {
                _local5 = int(Math.round((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minutes remaining.")));
            };
            this.ui.ToolTip.openWith({"str":_local6});
        }

        public function oniconBoostCPOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip;
            var _local3:Number;
            var _local4:Number;
            var _local5:int;
            var _local6:String;
            _local2 = MovieClip(_arg1.currentTarget);
            _local3 = new Date().getTime();
            _local4 = Math.max(((_local2.boostTS + (_local2.iBoostCP * 1000)) - _local3), 0);
            _local5 = 0;
            _local6 = "All ClassPoint gains are doubled.\n";
            if (_local4 < 120000)
            {
                _local5 = int(Math.floor((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minute(s), ")));
                _local5 = int(Math.round(((_local4 % 60000) / 1000)));
                _local6 = (_local6 + String((_local5 + " second(s) remaining.")));
            }
            else
            {
                _local5 = int(Math.round((_local4 / 60000)));
                _local6 = (_local6 + String((_local5 + " minutes remaining.")));
            };
            this.ui.ToolTip.openWith({"str":_local6});
        }

        public function oniconBoostOut(_arg1:MouseEvent):void
        {
            this.ui.ToolTip.close();
        }

        public function xpBarMouseOver(_arg1:MouseEvent):void
        {
            MovieClip(_arg1.currentTarget).strXP.visible = true;
        }

        public function xpBarMouseOut(_arg1:MouseEvent):void
        {
            MovieClip(_arg1.currentTarget).strXP.visible = false;
        }

        public function onRepBarMouseOver(_arg1:MouseEvent):void
        {
            MovieClip(_arg1.currentTarget).strRep.visible = true;
        }

        public function onRepBarMouseOut(_arg1:MouseEvent):void
        {
            MovieClip(_arg1.currentTarget).strRep.visible = false;
        }

        public function actIconClick(_arg1:MouseEvent):void
        {
            var action:Skill;
            action = Skill(MovieClip(_arg1.currentTarget).actObj);
            if (action.auto)
            {
                this.world.approachTarget();
            }
            else
            {
                this.world.combatAction(action);
            };
        }

        public function actIconOver(_arg1:MouseEvent):void
        {
            var actIconMC:ib2;
            var skill:Skill;
            var text:String;
            actIconMC = ib2(_arg1.currentTarget);
            if (this.uoPref.bTT)
            {
                if (actIconMC.item == null)
                {
                    skill = actIconMC.actObj;
                    if (skill != null)
                    {
                        text = (("<b>" + skill.nam) + "</b>\n");
                        if (!skill.isOK)
                        {
                            text = (text + (("<font color='#FF0000'>Unlocks at Rank " + ((actIconMC.actionIndex < 4) ? actIconMC.actionIndex : 5)) + "!</font>\n"));
                        };
                        if (skill.typ != "passive")
                        {
                            if (skill.mp > 0)
                            {
                                text = (text + (("<font color='#0033AA'>" + skill.mp) + "</font> mana, "));
                            };
                            text = (text + ((("<font color='#AA3300'>" + (skill.cd / 1000)) + "</font> sec cooldown") + "\n"));
                        };
                        switch (skill.typ)
                        {
                            case "p":
                            case "ph":
                            case "aa":
                                text = (text + "Physical");
                                break;
                            case "m":
                            case "ma":
                                text = (text + "Magical");
                                break;
                            case "mp":
                                text = (text + "Magical / Physical");
                                break;
                            case "pm":
                                text = (text + "Physical / Magical");
                                break;
                            case "passive":
                                text = (text + "<font color='#0033AA'>Passive Ability</font>");
                                break;
                        };
                        text = (text + "\n");
                        text = (text + ((skill.sArg2 != "") ? skill.sArg2 : skill.desc));
                        this.ui.ToolTip.openWith({"str":text});
                    };
                }
                else
                {
                    this.ui.ToolTip.openWith({"str":((actIconMC.item.sName + "\n") + actIconMC.item.sDesc)});
                };
            };
        }

        public function actIconOut(_arg1:MouseEvent):void
        {
            var _local2:*;
            _local2 = MovieClip(stage.getChildAt(0)).ui.ToolTip;
            _local2.close();
        }

        public function portraitClick(_arg_1:MouseEvent):*
        {
            var _local_2:*;
            var _local_3:*;
            _local_2 = MovieClip(_arg_1.currentTarget);
            if (_local_2.state == "Pet")
            {
                _local_3 = {};
                _local_3.ID = this.world.myAvatar.objData.CharID;
                _local_3.strUsername = this.world.myAvatar.objData.strUsername;
                this.ui.cMenu.fOpenWith("pet", _local_3);
            }
            else
            {
                if (_local_2.pAV.npcType == "npc")
                {
                    _local_3 = {};
                    _local_3.ID = _local_2.pAV.objData.NpcID;
                    _local_3.strUsername = _local_2.pAV.objData.strUsername;
                    _local_3.NpcID = _local_2.pAV.objData.NpcID;
                    this.ui.cMenu.fOpenWith("npc", _local_3);
                }
                else
                {
                    if (_local_2.pAV.npcType == "player")
                    {
                        _local_3 = {};
                        _local_3.ID = _local_2.pAV.objData.CharID;
                        _local_3.strUsername = _local_2.pAV.objData.strUsername;
                        if (_local_2.pAV != this.world.myAvatar)
                        {
                            this.ui.cMenu.fOpenWith("user", _local_3);
                        }
                        else
                        {
                            this.ui.cMenu.fOpenWith("self", _local_3);
                        };
                    }
                    else
                    {
                        if (_local_2.pAV.npcType == "monster")
                        {
                            _local_3 = {};
                            _local_3.ID = this.world.myAvatar.objData.CharID;
                            _local_3.strUsername = this.world.myAvatar.objData.strUsername;
                            _local_3.MonID = _local_2.pAV.objData.MonID;
                            this.ui.cMenu.fOpenWith("monster", _local_3);
                        };
                    };
                };
            };
        }

        public function hideUpgradeWindow(_arg1:MouseEvent):void
        {
            removeChild(mcUpgradeWindow);
            try
            {
                this.ui.mouseChildren = true;
                this.world.mouseChildren = true;
            }
            catch(e:Error)
            {
            };
            try
            {
                this.mcLogin.sl.mouseChildren = true;
            }
            catch(e:Error)
            {
            };
        }

        public function onUpgradeClick(_arg1:Event):void
        {
            var _local2:String;
            this.mcConnDetail.showConn("We are now redirecting you to our forgot password page.");
            navigateToURL(new URLRequest(Config.serverStoreURL), "_blank");
        }

        public function hideACWindow(_arg1:MouseEvent):void
        {
            removeChild(mcACWindow);
            try
            {
                this.ui.mouseChildren = true;
                this.world.mouseChildren = true;
            }
            catch(e:Error)
            {
            };
            try
            {
                this.mcLogin.sl.mouseChildren = true;
            }
            catch(e:Error)
            {
            };
        }

        public function onMCPVPQueueClick(_arg1:MouseEvent):void
        {
            var _local2:*;
            _local2 = {};
            try
            {
                _local2.strUsername = this.world.myAvatar.objData.strUsername;
                this.ui.cMenu.fOpenWith("pvpqueue", _local2);
            }
            catch(e:Error)
            {
            };
        }

        public function MCPVPQueueEF(_arg1:Event):void
        {
            var _local2:Number;
            var _local3:*;
            _local2 = new Date().getTime();
            _local3 = Math.ceil(((((this.world.PVPQueue.avgWait * 1000) - (_local2 - this.world.PVPQueue.ts)) / 1000) / 60));
            this.ui.mcPVPQueue.t2.htmlText = (('<font color="#FFFFFF"' + _local3) + '</font><font color="#999999"m</font>');
            if (_local3 <= 1)
            {
                this.ui.mcPVPQueue.t2.htmlText = ("<" + this.ui.mcPVPQueue.t2.htmlText);
            };
        }

        public function areaListClick(_arg1:MouseEvent):void
        {
            var _local2:*;
            _local2 = MovieClip(_arg1.currentTarget.parent.parent);
            switch (_local2.currentLabel)
            {
                case "init":
                    _local2.gotoAndPlay("in");
                    return;
                case "hold":
                    _local2.gotoAndPlay("out");
                    return;
            };
        }

        public function areaListNameClick(_arg1:MouseEvent):void
        {
            var _local2:*;
            var _local3:*;
            _local2 = MovieClip(_arg1.currentTarget);
            _local3 = {};
            _local3.ID = _local2.objData.ID;
            _local3.strUsername = _local2.objData.strUsername;
            if (_local2.objData.strUsername == this.world.myAvatar.objData.strUsername)
            {
                this.ui.cMenu.fOpenWith("self", _local3);
            }
            else
            {
                this.ui.cMenu.fOpenWith("user", _local3);
            };
        }

        private function reseFocusPosition(_arg1:FocusEvent):void
        {
            this.mcLogin.btnLogin.visible = true;
            this.mcLogin.mcForgotPassword.visible = true;
            this.mcLogin.mcManageAccount.visible = true;
            y = 0;
        }

        private function resetFocusPosition2(_arg1:FocusEvent):void
        {
            y = 0;
        }

        private function chatFocus(_arg1:FocusEvent):void
        {
            this.ui.mcInterface.te.needsSoftKeyboard = true;
            this.ui.mcInterface.te.requestSoftKeyboard();
            y = -400;
        }

        private function loginNiFocus(_arg1:FocusEvent):void
        {
            this.mcLogin.btnLogin.visible = false;
            this.mcLogin.mcForgotPassword.visible = false;
            this.mcLogin.mcManageAccount.visible = false;
            this.mcLogin.ni.needsSoftKeyboard = true;
            this.mcLogin.ni.requestSoftKeyboard();
            y = -135;
        }

        private function loginPiFocus(_arg1:FocusEvent):void
        {
            this.mcLogin.btnLogin.visible = false;
            this.mcLogin.mcForgotPassword.visible = false;
            this.mcLogin.mcManageAccount.visible = false;
            this.mcLogin.pi.needsSoftKeyboard = true;
            this.mcLogin.pi.requestSoftKeyboard();
            y = -150;
        }

        private function onUserFocus(_arg1:FocusEvent):void
        {
            if (this.mcLogin.ni.text == "click here")
            {
                this.mcLogin.ni.text = "";
            };
        }

        private function onForgotPassword(_arg1:MouseEvent):void
        {
            this.mcConnDetail.showConn("We are now redirecting you to our forgot password page.");
            navigateToURL(new URLRequest(Config.serverRetrieveURL), "_blank");
        }

        private function onManageClick(_arg1:MouseEvent):void
        {
            this.mcConnDetail.showConn("We are now redirecting you to our forgot password page.");
            navigateToURL(new URLRequest(Config.serverAccountURL), "_blank");
        }

        private function onAccountRecovery(_arg1:MouseEvent):void
        {
            this.mcConnDetail.showConn("We are now redirecting you to our forgot password page.");
            navigateToURL(new URLRequest(Config.serverRetrieveURL), "_blank");
        }

        private function onLoginClick(_arg1:MouseEvent):void
        {
            this.mixer.playSound("ClickBig");
            if ((((("btnLogin" in this.mcLogin) && (this.mcLogin.btnLogin.visible)) && (!(this.mcLogin.ni.text == ""))) && (!(this.mcLogin.pi.text == ""))))
            {
                this.saveUserPreference();
                this.login(this.mcLogin.ni.text.toLowerCase(), this.mcLogin.pi.text);
            };
        }

        private function onTargetPortraitCloseClick(_arg1:MouseEvent):void
        {
            if (this.world.coolDown("closeTarget"))
            {
                this.world.cancelTarget();
            };
        }

        public function getEmojiLoadPath(image:String):String
        {
            return (Config.serverEmojiImageURL + image);
        }

        public function toggleCrossPanel():void
        {
            var mcPopup:mcPopup_323;
            mcPopup = this.ui.mcPopup;
            if (!this.isGreedyModalInStack())
            {
                if (mcPopup.currentLabel != "CrossPanel")
                {
                    this.clearPopups();
                    this.clearPopupsQ();
                    mcPopup.visible = true;
                    mcPopup.gotoAndStop("CrossPanel");
                }
                else
                {
                    mcPopup.onClose();
                };
            };
        }


    }
}//package 

