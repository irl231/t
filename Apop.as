// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Apop

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import Main.Avatar.*;
    import Main.Controller.*;
    import Main.*;

    public class Apop extends MovieClip 
    {

        public var npc:MovieClip;
        public var btnClose:MovieClip;
        public var cnt:MovieClip;
        public var rootClass:Game = Game.root;
        public var o:Object = null;
        public var objSettings:Object = null;
        public var nMask:MovieClip;
        public var placement:MovieClip;

        public function Apop():void
        {
            addFrameScript(5, this.frame6);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.xClick, false, 0, true);
        }

        public function update(data:Object, settings:Object):void
        {
            this.o = data;
            this.objSettings = settings;
            var npcLinkage:String = ((this.o.npcLinkage) || ("none"));
            var npcEntry:String = ((this.o.npcEntry) || ("none"));
            var scene:String = ((this.o.scene) || ("none"));
            var cnt:String = ((this.o.cnt) || ("none"));
            var frame:String = ((this.o.frame) || ("none"));
            this.updateNPC(npcLinkage, npcEntry, settings);
            this.updateContent(cnt, scene);
            this.updateFrame(frame);
            if (this.currentLabel == "init")
            {
                this.gotoAndPlay("in");
            };
        }

        private function updateNPC(npcLinkage:String, npcEntry:String, settings:Object):void
        {
            var npcRight:MovieClip;
            var npcLeft:MovieClip;
            var avatarMC:AvatarMC;
            if (npcLinkage == "none")
            {
                this.npc.npcRight.visible = false;
                this.npc.npcLeft.visible = false;
                return;
            };
            var cls:Class = this.rootClass.world.getClass(npcLinkage);
            if (cls)
            {
                npcRight = ((npcEntry == "right") ? this.npc.npcRight : this.npc.npcLeft);
                npcLeft = ((npcEntry == "right") ? this.npc.npcLeft : this.npc.npcRight);
                if (npcLeft.currentLabel != "init")
                {
                    npcLeft.gotoAndPlay("slide-out");
                }
                else
                {
                    npcLeft.visible = false;
                };
                npcRight.visible = true;
                npcRight.npc.removeChildAt(0);
                if (npcLinkage == "AvatarMC")
                {
                    avatarMC = AvatarUtil.createAvatar("npc_apop", npcRight.npc, settings);
                    if (settings.scaleApop !== undefined)
                    {
                        avatarMC.scale(settings.scaleApop);
                    }
                    else
                    {
                        avatarMC.scale(5);
                    };
                    if (settings.xApop !== undefined)
                    {
                        avatarMC.x = settings.xApop;
                    }
                    else
                    {
                        avatarMC.x = -100;
                    };
                    if (settings.yApop !== undefined)
                    {
                        avatarMC.y = settings.yApop;
                    }
                    else
                    {
                        avatarMC.y = ((this.npc.height >> 1) - 100);
                    };
                    if (avatarMC.pAV.objData.eqp.en)
                    {
                        avatarMC.scaleX = (avatarMC.scaleY = 2.85);
                    };
                    avatarMC.disableAnimations();
                    if (Config.isDebug)
                    {
                        avatarMC.addEventListener(MouseEvent.CLICK, function (mouseEvent:MouseEvent):void
                        {
                            trace("Double Click", name);
                            var npcTool:mcNPCTool = mcNPCTool(UIController.show("npc_tool"));
                            npcTool.target = avatarMC;
                            npcTool.targetName.text = (avatarMC.pAV.objData.strUsername + " (APOP)");
                            new Drag(avatarMC, avatarMC, npcTool.onPositionChange);
                        }, false, 0, true);
                    };
                }
                else
                {
                    npcRight.npc.addChild(new (cls)());
                };
                npcRight.gotoAndPlay(((npcRight.currentLabel != "init") ? "slide-hook" : "slide-in"));
            };
        }

        private function updateContent(cnt:String, scene:String):void
        {
            var contentInstance:*;
            if (cnt == "none")
            {
                return;
            };
            var cntClass:Class = (this.rootClass.world.getClass(cnt) as Class);
            if (cntClass)
            {
                this.cnt.removeChildAt(0);
                contentInstance = ((cnt == "Plugins.ConfigurableNPC.CoreAPOP") ? new cntClass(this.objSettings, this.rootClass) : new (cntClass)());
                this.cnt.addChild(contentInstance);
                contentInstance.name = "cnt";
                if (((!(scene == "none")) && (this.rootClass.checkForFrame(contentInstance, scene))))
                {
                    contentInstance.gotoAndPlay(scene);
                };
            };
        }

        private function updateFrame(frame:String):void
        {
            if (frame == "none")
            {
                return;
            };
            var cntInstance:MovieClip = MovieClip(this.cnt.getChildByName("cnt"));
            var labelExists:Boolean = cntInstance.currentLabels.some(function (label:*, ... rest):Boolean
            {
                return (label.name == frame);
            });
            if (labelExists)
            {
                cntInstance.gotoAndPlay(frame);
            }
            else
            {
                this.rootClass.addUpdate((("Label " + frame) + " not found!"));
            };
        }

        public function fClose():void
        {
            if (this.o.cnt == "Plugins.ConfigurableNPC.CoreAPOP")
            {
                this.rootClass.world.closeAPOP(this.objSettings.NpcMapID);
            };
            var content:MovieClip = MovieClip(this.cnt.getChildByName("cnt"));
            content.soundTransform = new SoundTransform(0);
            content.stop();
            this.btnClose.removeEventListener(MouseEvent.CLICK, this.xClick);
            this.parent.removeChild(this);
        }

        public function exit():void
        {
            this.fClose();
        }

        private function frame6():void
        {
            stop();
        }

        private function xClick(event:MouseEvent):void
        {
            this.fClose();
        }


    }
}//package 

