// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//CharpanelMC

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.Graphics;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CharpanelMC extends MovieClip 
    {

        private const game:Game = Game.root;

        public var bg:MovieClip;
        public var cnt:MovieClip;
        private var nextMode:String;

        public function CharpanelMC():void
        {
            addFrameScript(0, this.frame1, 4, this.frame5, 11, this.frame12, 24, this.frame25);
            this.bg.x = 0;
            this.bg.btnClose.addEventListener(MouseEvent.MOUSE_DOWN, this.btnCloseClick, false, 0, true);
            this.bg.tTitle.text = "Class Overview";
        }

        public function openWith(data:Object):void
        {
            var currentLabelWithoutOut:String;
            this.nextMode = data.typ;
            if (this.isValidMode(this.nextMode))
            {
                currentLabelWithoutOut = this.currentLabel.split("-")[0];
                if (((!(currentLabelWithoutOut == "init")) && (this.currentLabel.indexOf("-out") == -1)))
                {
                    this.gotoAndPlay((currentLabelWithoutOut + "-out"));
                }
                else
                {
                    this.gotoAndPlay(this.nextMode);
                };
            };
        }

        public function fClose():void
        {
            var abilityArray:Array;
            var ability:MovieClip;
            var parentClip:MovieClip;
            if (MovieClip(this).currentLabel.indexOf("overview") > -1)
            {
                try
                {
                    abilityArray = [this.cnt.abilities.a1, this.cnt.abilities.a2, this.cnt.abilities.a3, this.cnt.abilities.a4, this.cnt.abilities.p1, this.cnt.abilities.p2, this.cnt.abilities.p3, this.cnt.abilities.pitem];
                    for each (ability in abilityArray)
                    {
                        ability.removeEventListener(MouseEvent.MOUSE_OVER, this.game.actIconOver);
                        ability.addEventListener(MouseEvent.MOUSE_OUT, this.game.actIconOut);
                        ability.actObj = null;
                    };
                }
                catch(e:Error)
                {
                };
            };
            this.bg.btnClose.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnCloseClick);
            if (parent != null)
            {
                parentClip = (parent as MovieClip);
                if (parentClip != null)
                {
                    parentClip.removeChild(this);
                    parentClip.onClose();
                };
            };
            this.game.stage.focus = null;
        }

        internal function frame1():*
        {
            this.openWith(MovieClip(parent).fData);
        }

        internal function frame5():*
        {
            this.update();
        }

        internal function frame12():*
        {
            stop();
        }

        internal function frame25():*
        {
            this.playNextMode();
        }

        private function playNextMode():void
        {
            this.gotoAndPlay(this.nextMode);
        }

        private function isValidMode(mode:String):Boolean
        {
            var i:int;
            while (i < this.currentLabels.length)
            {
                if (this.currentLabels[i].name == mode)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        private function update():void
        {
            if (MovieClip(this).currentLabel.indexOf("overview") > -1)
            {
                this.updateNext();
            };
        }

        private function updateNext():void
        {
            var aClassMRMElement:String;
            var abilityNames:Array;
            var i:int;
            var abilityName:String;
            var mc:MovieClip;
            var action:Object;
            var x:int;
            var color:Number;
            var textColor:String;
            var rankText:TextField;
            this.cnt.tDesc.autoSize = "left";
            this.cnt.tMana.autoSize = "left";
            this.cnt.tClass.htmlText = (((Game.root.world.myAvatar.objData.strClassName + "  (Rank ") + Game.root.world.myAvatar.objData.iRank) + ")");
            this.cnt.tDesc.htmlText = Game.root.world.myAvatar.objData.sClassDesc;
            this.cnt.tMana.text = "";
            for each (aClassMRMElement in Game.root.world.myAvatar.objData.aClassMRM)
            {
                this.cnt.tMana.htmlText = ((aClassMRMElement.charAt(0) == "-") ? (this.cnt.tMana.text + (" * " + aClassMRMElement.substr(1))) : (this.cnt.tMana.text + aClassMRMElement));
            };
            this.cnt.tManaHeader.y = Math.round(((this.cnt.tDesc.y + this.cnt.tDesc.height) + 5));
            this.cnt.tMana.y = Math.round(((this.cnt.tManaHeader.y + this.cnt.tManaHeader.height) + 2));
            this.cnt.abilities.y = Math.min(Math.round(((this.cnt.tMana.y + this.cnt.tMana.height) + (((188 - this.cnt.tMana.y) - this.cnt.tMana.height) / 2))), 188);
            abilityNames = ["a1", "a2", "a3", "a4", "p1", "p2", "p3", "pitem"];
            i = 0;
            while (i < abilityNames.length)
            {
                abilityName = abilityNames[i];
                mc = (this.cnt.abilities.getChildByName(abilityName) as MovieClip);
                if (((abilityName == "p3") && (this.game.world.actions.passive.length < 3)))
                {
                    this.cnt.abilities.x = 46;
                    this.cnt.abilities.getChildByName("tRank6").visible = false;
                    mc.visible = false;
                }
                else
                {
                    action = this.game.world.getActionByRef(abilityName);
                    if (action)
                    {
                        mc.visible = true;
                        mc.tQty.visible = false;
                        this.game.updateIcons([mc], action.icon.split(","), null);
                        mc.alpha = ((action.isOK) ? 1 : 0.33);
                        mc.actObj = action;
                        mc.addEventListener(MouseEvent.MOUSE_OVER, this.game.actIconOver, false, 0, true);
                        mc.addEventListener(MouseEvent.MOUSE_OUT, this.game.actIconOut, false, 0, true);
                    }
                    else
                    {
                        mc.visible = false;
                    };
                };
                i++;
            };
            var g:Graphics = this.cnt.abilities.bg.graphics;
            g.clear();
            g.lineStyle(0, 0, 0);
            var j:int;
            while (j < 6)
            {
                x = (j * 51);
                color = ((Game.root.world.myAvatar.objData.iRank < (j + 1)) ? 0x242424 : 0x666666);
                textColor = ((Game.root.world.myAvatar.objData.iRank < (j + 1)) ? "#999999" : "#FFFFFF");
                g.beginFill(color);
                g.drawRect(x, 0, 50, 18);
                g.drawRect(x, 128, 50, 4);
                g.endFill();
                rankText = TextField(this.cnt.abilities.getChildByName(("tRank" + (j + 1))));
                if (rankText)
                {
                    rankText.htmlText = (((("<font color='" + textColor) + "'>") + rankText.text) + "</font>");
                };
                j++;
            };
        }

        private function btnCloseClick(_arg_1:MouseEvent):void
        {
            this.fClose();
        }


    }
}//package 

