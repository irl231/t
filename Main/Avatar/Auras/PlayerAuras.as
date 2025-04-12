// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Avatar.Auras.PlayerAuras

package Main.Avatar.Auras
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.Shape;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class PlayerAuras extends MovieClip 
    {

        protected const game:Game = Game.root;

        protected var icons:Object;
        protected var aurasStack:Object;
        protected var auraContainer:MovieClip;
        protected var iconPriority:Array;

        public function PlayerAuras()
        {
            this.name = "playerAuras";
            this.visible = true;
            this.aurasStack = {};
            this.auraContainer = new MovieClip();
            this.auraContainer.mouseEnabled = (this.auraContainer.mouseChildren = false);
            this.game.ui.playerAura.display.addChild(this.auraContainer);
            this.game.ui.playerAura.display.setChildIndex(this.auraContainer, 0);
            this.auraContainer.name = "auraContainer";
            this.auraContainer.x = this.x;
            this.auraContainer.y = this.y;
        }

        private static function onOver(mouseEvent:MouseEvent):void
        {
            Game.root.ui.ToolTip.openWith({"str":(((mouseEvent.currentTarget.auraName + " (") + mouseEvent.currentTarget.auraStacks) + ")")});
        }

        private static function onExit(mouseEvent:MouseEvent):void
        {
            Game.root.ui.ToolTip.close();
        }


        public function handleAura(auraData:Object):void
        {
            if (auraData == null)
            {
                return;
            };
            if (auraData.tInf != ("p:" + this.game.network.myUserId))
            {
                return;
            };
            this.handleAuraCreation(auraData, this.game.world.myAvatar);
        }

        protected function handleAuraCreation(auraData:Object, target:Avatar):void
        {
            var aura:Object;
            var avatarAuras:Object;
            switch (auraData.cmd)
            {
                case "aura+":
                case "aura++":
                    for each (aura in auraData.auras)
                    {
                        if (aura.isStatic)
                        {
                        }
                        else
                        {
                            if (!this.aurasStack.hasOwnProperty(aura.nam))
                            {
                                this.aurasStack[aura.nam] = 1;
                                this.createIconMC(aura.nam, 1, aura.icon);
                                this.coolDownAct(this.icons[aura.nam], (aura.dur * 1000), new Date().getTime());
                            }
                            else
                            {
                                this.aurasStack[aura.nam] = (this.aurasStack[aura.nam] + 1);
                                for each (avatarAuras in target.dataLeaf.auras)
                                {
                                    if (avatarAuras.nam == aura.nam)
                                    {
                                        avatarAuras.ts = aura.ts;
                                        this.createIconMC(aura.nam, this.aurasStack[aura.nam], aura.icon);
                                        this.coolDownAct(this.icons[aura.nam], (aura.dur * 1000), avatarAuras.ts);
                                        break;
                                    };
                                };
                            };
                        };
                    };
                    return;
                case "aura-":
                case "aura--":
                    for each (aura in auraData.auras)
                    {
                        delete this.aurasStack[aura.nam];
                    };
                    return;
                case "aura*":
                case "aura+p":
                    break;
            };
        }

        protected function createIconMC(auraName:String, auraStack:Number, auraIcon:String):void
        {
            var hitBox:MovieClip;
            var hitBoxChild:Shape;
            var iconBgWidth:Number;
            var iconBgHeight:Number;
            var cls:Class;
            var iconInstance:DisplayObject;
            var iconWidth:Number;
            var iconHeight:Number;
            var value:Number;
            if (this.icons == null)
            {
                this.icons = {};
                this.iconPriority = [];
            };
            if (!this.icons.hasOwnProperty(auraName))
            {
                this.icons[auraName] = this.auraContainer.addChild(new ib2());
                this.icons[auraName].name = ("aura@" + auraName);
                this.icons[auraName].auraName = auraName;
                hitBox = new MovieClip();
                hitBoxChild = new Shape();
                hitBoxChild.graphics.beginFill(0xFFFFFF);
                hitBoxChild.graphics.drawRect(0, 0, 23, 21);
                hitBoxChild.graphics.endFill();
                hitBox.addChild(hitBoxChild);
                hitBox.alpha = 0;
                addChild(hitBox);
                this.icons[auraName].hitbox = hitBox;
                this.icons[auraName].hitbox.auraName = auraName;
                this.icons[auraName].width = 42;
                this.icons[auraName].height = 39;
                this.icons[auraName].cnt.removeChildAt(0);
                this.icons[auraName].scaleX = 0.6;
                this.icons[auraName].scaleY = 0.6;
                this.icons[auraName].tQty.visible = false;
                iconBgWidth = (this.icons[auraName].bg.width >> 1);
                iconBgHeight = (this.icons[auraName].bg.height >> 1);
                cls = ((auraIcon.indexOf(",") > -1) ? this.game.world.getClass(auraIcon.split(",")[(auraIcon.split(",").length - 1)]) : this.game.world.getClass(auraIcon));
                if (cls == null)
                {
                    cls = this.game.world.getClass("isp2");
                };
                iconInstance = this.icons[auraName].cnt.addChild(new (cls)());
                iconWidth = iconInstance.width;
                iconHeight = iconInstance.height;
                value = Math.min((37 / iconWidth), (37 / iconHeight));
                iconInstance.scaleX = value;
                iconInstance.scaleY = value;
                iconInstance.x = (iconBgWidth - (iconInstance.width >> 1));
                iconInstance.y = (iconBgHeight - (iconInstance.height >> 1));
                this.iconPriority.push(auraName);
                this.icons[auraName].hitbox.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
                this.icons[auraName].hitbox.addEventListener(MouseEvent.MOUSE_OUT, onExit, false, 0, true);
            };
            this.icons[auraName].auraStacks = auraStack;
            this.icons[auraName].hitbox.auraStacks = auraStack;
        }

        protected function coolDownAct(_ib2:ib2, cooldown:int=-1, alpha:Number=127):void
        {
            var icon:DisplayObject;
            var maskMC:MovieClip;
            var stacksTF:TextField;
            var textFormat:TextFormat;
            var bitmapData:BitmapData;
            var bitmap:Bitmap;
            if (_ib2.icon2 == null)
            {
                bitmapData = new BitmapData(50, 50, true, 0);
                bitmapData.draw(_ib2, null, this.game.world.iconCT);
                bitmap = new Bitmap(bitmapData);
                icon = _ib2.addChild(bitmap);
                _ib2.icon2 = icon;
                icon.transform = _ib2.transform;
                icon.scaleX = 1;
                icon.scaleY = 1;
                _ib2.ts = alpha;
                _ib2.cd = cooldown;
                maskMC = MovieClip(_ib2.addChild(new ActMaskReverse()));
                maskMC.scaleX = 1;
                maskMC.scaleY = 1;
                maskMC.x = int(((icon.x + (icon.width >> 1)) - 122));
                maskMC.y = int(((icon.y + (icon.height >> 1)) - 122));
                maskMC.e0oy = maskMC.e0.y;
                maskMC.e1oy = maskMC.e1.y;
                maskMC.e2oy = maskMC.e2.y;
                maskMC.e3oy = maskMC.e3.y;
                icon.mask = maskMC;
                textFormat = new TextFormat();
                textFormat.size = 12;
                textFormat.bold = true;
                textFormat.font = "Arial";
                textFormat.color = 0xFFFFFF;
                textFormat.align = "right";
                stacksTF = new TextField();
                stacksTF.defaultTextFormat = textFormat;
                _ib2.stacks = _ib2.addChild(stacksTF);
                _ib2.stacks.x = 3.25;
                _ib2.stacks.y = 28.1;
                _ib2.stacks.width = 42.7;
                _ib2.stacks.height = 16.25;
                _ib2.stacks.mouseEnabled = false;
            }
            else
            {
                icon = _ib2.icon2;
                maskMC = MovieClip(icon.mask);
                _ib2.ts = alpha;
                _ib2.cd = cooldown;
            };
            _ib2.stacks.text = _ib2.auraStacks;
            maskMC.e0.stop();
            maskMC.e1.stop();
            maskMC.e2.stop();
            maskMC.e3.stop();
            _ib2.removeEventListener(Event.ENTER_FRAME, this.countDownAct);
            _ib2.addEventListener(Event.ENTER_FRAME, this.countDownAct, false, 0, true);
            this.rearrangeIconMC();
        }

        protected function countDownAct(event:Event):void
        {
            var _ib2:ib2;
            var i:int;
            var mask:*;
            var ei:MovieClip;
            if (!this.game.world)
            {
                this.aurasStack = {};
                this.onReset();
                return;
            };
            var ti:Number = new Date().getTime();
            _ib2 = ib2(event.target);
            var cd:Number = (_ib2.cd + 350);
            var tp:Number = ((this.aurasStack[_ib2.auraName] == null) ? 1 : ((ti - _ib2.ts) / cd));
            var mc:Number = Math.floor((tp * 4));
            var fr:int = (int(((tp * 360) % 90)) + 1);
            if (tp < 0.99)
            {
                i = 0;
                while (i < 4)
                {
                    if (i >= mc)
                    {
                        ei = _ib2.icon2.mask[("e" + i)];
                        ei.y = _ib2.icon2.mask[(("e" + i) + "oy")];
                        if (((i > mc) && (!(ei == null))))
                        {
                            ei.gotoAndStop(0);
                        };
                    };
                    i++;
                };
                mask = MovieClip(_ib2.icon2.mask[("e" + mc)]);
                if (mask != null)
                {
                    mask.gotoAndStop(fr);
                };
                return;
            };
            this.removeCountDown(_ib2);
        }

        private function removeCountDown(_ib2:ib2):void
        {
            _ib2.icon2.parent.removeChild(_ib2.icon2.mask);
            _ib2.icon2.mask = null;
            _ib2.removeEventListener(Event.ENTER_FRAME, this.countDownAct);
            _ib2.icon2.parent.removeChild(_ib2.icon2);
            _ib2.icon2.bitmapData.dispose();
            _ib2.icon2 = null;
            removeChild(_ib2.hitbox);
            this.auraContainer.removeChild(_ib2);
            this.iconPriority.splice(this.iconPriority.indexOf(_ib2.auraName), 1);
            delete this.icons[_ib2.auraName];
            delete this.aurasStack[_ib2.auraName];
            this.rearrangeIconMC();
        }

        private function rearrangeIconMC():void
        {
            var _ib2:ib2;
            var iconY:Number = 0;
            var iconX:Number = 0;
            var i:int;
            while (i < this.iconPriority.length)
            {
                if (((!(i == 0)) && ((i % 4) == 0)))
                {
                    iconY = (iconY + 28);
                    iconX++;
                };
                _ib2 = this.icons[this.iconPriority[i]];
                _ib2.x = (((i - (iconX << 2)) << 5) + 3);
                _ib2.y = iconY;
                _ib2.hitbox.x = (_ib2.x + 2);
                _ib2.hitbox.y = (_ib2.y + 1);
                i++;
            };
        }

        public function onReset():void
        {
            var iconKey:String;
            for (iconKey in this.icons)
            {
                this.removeCountDown(this.icons[iconKey]);
            };
            Game.root.onRemoveChildrens(this);
            Game.root.onRemoveChildrens(this.auraContainer);
            this.icons = {};
            this.iconPriority = [];
        }

        public function onClose():void
        {
            var iconKey:String;
            for (iconKey in this.icons)
            {
                this.removeCountDown(this.icons[iconKey]);
            };
            this.game.onRemoveChildrens(this);
            if (((this.auraContainer) && (this.game.ui.contains(this.auraContainer))))
            {
                this.game.ui.removeChild(this.auraContainer);
            };
            if (((!(parent == null)) && (parent.contains(this))))
            {
                parent.removeChild(this);
            };
        }


    }
}//package Main.Avatar.Auras

