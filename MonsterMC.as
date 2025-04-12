// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//MonsterMC

package 
{
    import Main.Avatar.AbstractAvatarMC;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.geom.Rectangle;
    import flash.utils.Timer;
    import flash.filters.GlowFilter;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.filters.*;
    import flash.utils.*;
    import Main.Avatar.*;
    import Main.*;

    public class MonsterMC extends AbstractAvatarMC 
    {

        private static const attacks:Array = ["Attack1", "Attack2", "Buff", "Cast"];

        public var displayObject:DisplayObject;
        public var mc:MovieClip;
        public var hitbox:Rectangle;
        public var hitboxDO:DisplayObject;
        public var isMonster:Boolean = true;
        public var isGenerated:Boolean = false;
        public var isStatic:Boolean = false;
        public var noMove:Boolean = false;
        public var ox:Number;
        public var oy:Number;
        public var mcChar:MovieClip;
        private var world:World;
        private var despawnTimer:Timer = new Timer(1000, 1);

        public function MonsterMC(_name:String)
        {
            this.bubble.visible = false;
            this.bubble.t = "";
            this.pname.ti.text = _name.toUpperCase();
        }

        public function get Animation():String
        {
            return (MonsterMC.attacks[Math.round(Math.random())]);
        }

        override public function queueAnim(animation:String):void
        {
            if ((((!(animation)) == "Walk") && ((!(animation)) == "Idle")))
            {
                return;
            };
            if (Game.root.userPreference.data["disableMonsterAnimation"])
            {
                return;
            };
            if ((((MainController.hasLabel(animation, this.mcChar)) && (this.pAV.dataLeaf.intState > 0)) && (AvatarUtil.staticAnims.indexOf(this.mcChar.currentLabel) == -1)))
            {
                if (((AvatarUtil.combatAnims.indexOf(animation) > -1) && (AvatarUtil.combatAnims.indexOf(this.mcChar.currentLabel) > -1)))
                {
                    this.animQueue.push(animation);
                }
                else
                {
                    this.mcChar.gotoAndPlay(animation);
                };
            };
        }

        override public function walkTo(_arg1:int, _arg2:int, _arg3:int):void
        {
            if ((((!(this.noMove)) && (!(this.world.hideAvatars))) && (this.world.CELL_MODE == "normal")))
            {
                if (((!(this.pAV.petMC == null)) && (!(this.pAV.petMC.mcChar == null))))
                {
                    this.pAV.petMC.walkTo((_arg1 - 20), (_arg2 + 5), (_arg3 - 3));
                };
                this.op = new Point(this.x, this.y);
                this.tp = new Point(_arg1, _arg2);
                this.walkTS = new Date().getTime();
                this.walkD = Math.round((1000 * (Point.distance(this.op, this.tp) / (_arg3 * 22))));
                if (this.walkD > 0)
                {
                    if ((this.op.x - this.tp.x) < 0)
                    {
                        this.turn("right");
                    }
                    else
                    {
                        this.turn("left");
                    };
                    if (!this.mcChar.onMove)
                    {
                        this.mcChar.onMove = true;
                        if (this.mcChar.currentLabel != "Walk")
                        {
                            this.mcChar.gotoAndPlay("Walk");
                        };
                    };
                    this.addEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
                };
            };
        }

        override public function stopWalking():void
        {
            if (this.mcChar.onMove)
            {
                this.mcChar.onMove = false;
                if (this.pAV.dataLeaf.intState != 2)
                {
                    this.mcChar.gotoAndPlay("Idle");
                };
                this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
            };
        }

        override public function turn(_arg1:String):void
        {
            if (((!(this.isStatic)) && (((_arg1 == "right") && (this.mcChar.scaleX < 0)) || ((_arg1 == "left") && (this.mcChar.scaleX > 0)))))
            {
                this.mcChar.scaleX = (this.mcChar.scaleX * -1);
            };
        }

        override public function fClose():void
        {
            this.mcChar.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.pname.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.despawnTimer.removeEventListener(TimerEvent.TIMER, this.despawn);
            this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
            this.removeEventListener(Event.ENTER_FRAME, this.onDespawn);
            this.removeEventListener(Event.ENTER_FRAME, this.checkQueue);
            if (this.world.CHARS.contains(this))
            {
                this.world.CHARS.removeChild(this);
            };
            if (this.world.TRASH.contains(this))
            {
                this.world.TRASH.removeChild(this);
            };
        }

        public function init():void
        {
            this.world = World(parent.parent);
            this.mcChar = MovieClip(this.getChildAt(1));
            this.mcChar.addEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.pname.addEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.despawnTimer.addEventListener(TimerEvent.TIMER, this.despawn);
            this.addEventListener(Event.ENTER_FRAME, this.checkQueue, false, 0, true);
            this.pname.mouseChildren = false;
            this.mcChar.buttonMode = true;
            this.pname.buttonMode = true;
            this.shadow.mouseEnabled = (this.shadow.mouseChildren = false);
            this.mcChar.cacheAsBitmap = true;
            if (this.world.monstersHidden)
            {
                this.visible = false;
            };
        }

        public function setData():void
        {
            var glow:GlowFilter;
            this.pAV.objData.strMonName = this.pname.ti.text;
            this.pname.ti.textColor = this.pAV.objData.strColorName;
            var filters:Array = ((this.pname.ti.filters) ? this.pname.ti.filters.slice() : []);
            if (this.pAV.objData.strColorNameGlow != 0)
            {
                glow = new GlowFilter();
                glow.color = this.pAV.objData.strColorNameGlow;
                glow.alpha = 0.5;
                glow.blurX = 10;
                glow.blurY = 10;
                glow.strength = 1;
                glow.quality = BitmapFilterQuality.HIGH;
                filters.push(glow);
            };
            this.pname.ti.filters = filters;
        }

        public function updateNamePlate():void
        {
            if (((((Game.root.world.bPvP) && (!(this.pAV.dataLeaf == null))) && (!(this.pAV.dataLeaf.react == null))) && (this.pAV.dataLeaf.react[Game.root.world.myAvatar.dataLeaf.pvpTeam] == 1)))
            {
                this.pname.ti.textColor = 0xFFFFFF;
            };
        }

        public function toggleMonster():void
        {
            this.visible = (!(this.visible));
        }

        public function scale(_arg1:Number):void
        {
            if (this.mcChar.scaleX >= 0)
            {
                this.mcChar.scaleX = _arg1;
            }
            else
            {
                this.mcChar.scaleX = -(_arg1);
            };
            this.mcChar.scaleY = _arg1;
            this.shadow.scaleX = (this.shadow.scaleY = _arg1);
            this.bubble.y = (-(this.mcChar.height) - 10);
            this.pname.y = (-(this.mcChar.height) - 10);
            var _local2:Point = new Point(0, (-(this.mcChar.height) - 10));
            var _local3:Point = this.localToGlobal(_local2);
            if (_local3.y < 50)
            {
                _local3.y = 50;
            };
            _local2 = this.globalToLocal(_local3);
            this.pname.y = _local2.y;
            this.drawHitBox();
        }

        public function die():void
        {
            this.animQueue = [];
            MovieClip(this.getChildAt(1)).gotoAndPlay("Die");
            this.mcChar.mouseEnabled = false;
            this.mcChar.mouseChildren = false;
            this.despawnTimer.reset();
            this.despawnTimer.start();
        }

        public function respawn():void
        {
            this.despawnTimer.reset();
            this.removeEventListener(Event.ENTER_FRAME, this.onDespawn);
            var movieClip:MovieClip = MovieClip(this.getChildAt(1));
            if (MainController.hasLabel("Start", this.mcChar))
            {
                movieClip.gotoAndPlay("Start");
            }
            else
            {
                if (movieClip.currentLabel != "Walk")
                {
                    movieClip.gotoAndStop("Idle");
                };
            };
            this.alpha = 1;
            this.visible = (!(this.world.monstersHidden));
            this.mcChar.mouseEnabled = true;
            this.mcChar.mouseChildren = true;
        }

        private function emoteLoopFrame():int
        {
            var _local2:int;
            var _local1:Array = this.mcChar.currentLabels;
            while (_local2 < _local1.length)
            {
                if (_local1[_local2].name == currentLabel)
                {
                    return (_local1[_local2].frame);
                };
                _local2++;
            };
            return (8);
        }

        private function drawHitBox():void
        {
            if (this.hitboxDO != null)
            {
                this.mcChar.removeChild(this.hitboxDO);
            };
            this.hitboxDO = null;
            var _local1:Rectangle = this.mcChar.getBounds(stage);
            var _local2:Point = _local1.topLeft;
            var _local3:Point = _local1.bottomRight;
            _local2 = this.mcChar.globalToLocal(_local2);
            _local3 = this.mcChar.globalToLocal(_local3);
            _local1 = new Rectangle(_local2.x, _local2.y, (_local3.x - _local2.x), (_local3.y - _local2.y));
            var _local4:int = (_local1.x + (_local1.width * 0.2));
            if (_local4 > (this.shadow.x - this.shadow.width))
            {
                _local4 = (this.shadow.x - this.shadow.width);
            };
            var _local5:int = (_local1.width * 0.6);
            if (_local5 < (2 * this.shadow.width))
            {
                _local5 = (2 * this.shadow.width);
            };
            var _local6:int = (_local1.y + (_local1.height * 0.2));
            var _local7:int = (_local1.height * 0.6);
            this.hitbox = new Rectangle(_local4, _local6, _local5, _local7);
            var _local8:Sprite = new Sprite();
            var _local9:Graphics = _local8.graphics;
            _local9.lineStyle(0, 0xFFFFFF, 0);
            _local9.beginFill(0xAA00FF, 0);
            _local9.moveTo(_local4, _local6);
            _local9.lineTo((_local4 + _local5), _local6);
            _local9.lineTo((_local4 + _local5), (_local6 + _local7));
            _local9.lineTo(_local4, (_local6 + _local7));
            _local9.lineTo(_local4, _local6);
            _local9.endFill();
            this.hitboxDO = this.mcChar.addChild(_local8);
        }

        public function onClickHandler(_arg1:MouseEvent):void
        {
            if (_arg1.shiftKey)
            {
                this.world.onWalkClick();
            }
            else
            {
                if (_arg1.ctrlKey)
                {
                    if (this.world.myAvatar.objData.intAccessLevel >= 40)
                    {
                        if (this.pAV.npcType == "monster")
                        {
                            this.world.rootClass.network.send("cmd", ["km", ("m:" + this.pAV.objData.MonMapID)]);
                        };
                        if (this.pAV.npcType == "player")
                        {
                            this.world.rootClass.network.send("cmd", ["km", ("p:" + this.pAV.objData.unm.toLowerCase())]);
                        };
                    };
                }
                else
                {
                    if (_arg1.currentTarget.parent == this)
                    {
                        if (this.world.myAvatar.target != this.pAV)
                        {
                            this.world.setTarget(this.pAV);
                        }
                        else
                        {
                            if ((((!(this.world.bPvP)) || (this.pAV.dataLeaf.react == null)) || (this.pAV.dataLeaf.react[this.world.myAvatar.dataLeaf.pvpTeam] == 0)))
                            {
                                this.world.approachTarget();
                            };
                        };
                    };
                };
            };
        }

        private function checkQueue(_arg1:Event):Boolean
        {
            var cl:String;
            var _local4:int;
            if (this.animQueue.length > 0)
            {
                cl = this.mcChar.currentLabel;
                _local4 = this.emoteLoopFrame();
                if (((AvatarUtil.combatAnims.indexOf(cl) > -1) && (this.mcChar.currentFrame >= (_local4 + 4))))
                {
                    this.mcChar.gotoAndPlay(this.animQueue[0]);
                    this.animQueue.shift();
                    return (true);
                };
            };
            return (false);
        }

        private function onEnterFrameWalk(_arg1:Event):void
        {
            var _local4:*;
            var _local5:*;
            var _local6:Boolean;
            var _local7:*;
            var _local8:*;
            var _local9:*;
            var _local10:*;
            var _local2:Number = new Date().getTime();
            var _local3:Number = ((_local2 - this.walkTS) / this.walkD);
            if (_local3 > 1)
            {
                _local3 = 1;
            };
            if (((Point.distance(this.op, this.tp) > 0.5) && (this.mcChar.onMove)))
            {
                _local4 = this.x;
                _local5 = this.y;
                this.x = Point.interpolate(this.tp, this.op, _local3).x;
                this.y = Point.interpolate(this.tp, this.op, _local3).y;
                _local6 = false;
                _local7 = 0;
                while (_local7 < this.world.arrSolid.length)
                {
                    if (this.shadow.hitTestObject(this.world.arrSolid[_local7].shadow))
                    {
                        _local6 = true;
                        _local7 = this.world.arrSolid.length;
                    };
                    _local7++;
                };
                if (_local6)
                {
                    _local8 = this.y;
                    this.y = _local5;
                    _local6 = false;
                    _local9 = 0;
                    while (_local9 < this.world.arrSolid.length)
                    {
                        if (this.shadow.hitTestObject(this.world.arrSolid[_local9].shadow))
                        {
                            this.y = _local8;
                            _local6 = true;
                            break;
                        };
                        _local9++;
                    };
                    if (_local6)
                    {
                        this.x = _local4;
                        _local6 = false;
                        _local10 = 0;
                        while (_local10 < this.world.arrSolid.length)
                        {
                            if (this.shadow.hitTestObject(this.world.arrSolid[_local10].shadow))
                            {
                                _local6 = true;
                                break;
                            };
                            _local10++;
                        };
                        if (_local6)
                        {
                            this.x = _local4;
                            this.y = _local5;
                            this.stopWalking();
                        };
                    };
                };
                if ((((Math.round(_local4) == Math.round(this.x)) && (Math.round(_local5) == Math.round(this.y))) && (_local2 > (this.walkTS + 50))))
                {
                    this.stopWalking();
                };
            }
            else
            {
                this.stopWalking();
            };
        }

        private function despawn(_arg1:TimerEvent):void
        {
            if (Game.root.world.myAvatar.target == this.pAV)
            {
                Game.root.world.setTarget(null);
            };
            this.addEventListener(Event.ENTER_FRAME, this.onDespawn);
        }

        private function onDespawn(_arg1:Event):void
        {
            this.alpha = (this.alpha - 0.05);
            if (this.alpha < 0)
            {
                this.visible = false;
                this.alpha = 1;
                this.removeEventListener(Event.ENTER_FRAME, this.onDespawn);
            };
        }


    }
}//package 

