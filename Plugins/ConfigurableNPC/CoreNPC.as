// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.ConfigurableNPC.CoreNPC

package Plugins.ConfigurableNPC
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Avatar.*;
    import Main.Controller.*;
    import Main.*;

    public class CoreNPC extends MovieClip 
    {

        public var isProp:Boolean = true;
        public var objSettings:Object;
        public var btnButton:SimpleButton;
        public var objAvatar:Avatar;

        public function CoreNPC(world:World, avatar:Avatar, characterData:Object, index:int)
        {
            var avatarMC:AvatarMC;
            var button:DisplayObject;
            super();
            this.objSettings = characterData;
            this.objAvatar = avatar;
            if (this.objAvatar == null)
            {
                return;
            };
            avatarMC = AvatarUtil.buildAvatar("npc", world.CHARS, this.objAvatar, this.objSettings, this.objSettings.avatarMC);
            var i:int;
            while (i < avatarMC.numChildren)
            {
                if (avatarMC.getChildAt(i).name == "CoreNPCButton")
                {
                    avatarMC.removeChildAt(i);
                };
                i = (i + 1);
            };
            if (!Config.isDebug)
            {
                avatarMC.mcChar.mouseEnabled = false;
                avatarMC.mcChar.mouseChildren = false;
            };
            button = avatarMC.addChildAt(new CoreNPCButton(), 8);
            button.y = avatarMC.bubble.y;
            button.x = (avatarMC.fx.x - 10);
            button.name = "CoreNPCButton";
            button.addEventListener(MouseEvent.MOUSE_DOWN, this.onClick);
            world.npcs[index].pMC = avatarMC;
            avatarMC.apopbutton = MovieClip(button);
            avatarMC.pname.ti.text = "";
            avatarMC.name = (characterData.strUsername + "_CORE_NPC");
            if (characterData.scale !== undefined)
            {
                avatarMC.scale((characterData.scale / 10));
            }
            else
            {
                avatarMC.scale(world.SCALE);
            };
            avatarMC.turn(characterData.face.toLowerCase());
            avatarMC.disablePNameMouse();
            if (characterData.face.toLowerCase() == "right")
            {
                avatarMC.mcChar.x = 5;
                button.x = (avatarMC.fx.x - 7);
            };
            var npcUoLeaf:* = world.npcTree[characterData.NpcMapID];
            avatarMC.apopbutton.visible = npcUoLeaf.intState;
            var animation:* = characterData.animation;
            if (isNaN(characterData.animation))
            {
                animation = ((Game.root.frameCheck(avatarMC.mcChar, characterData.animation)) ? characterData.animation : "Idle");
            };
            if (characterData.state == "Play")
            {
                avatarMC.mcChar.gotoAndPlay(((npcUoLeaf.intState) ? animation : "Dead"));
            }
            else
            {
                avatarMC.mcChar.gotoAndStop(((npcUoLeaf.intState) ? animation : "Dead"));
            };
            if (Config.isDebug)
            {
                avatarMC.addEventListener(MouseEvent.CLICK, function (mouseEvent:MouseEvent):void
                {
                    var npcTool:mcNPCTool = mcNPCTool(UIController.show("npc_tool"));
                    npcTool.target = avatarMC;
                    npcTool.targetName.text = (characterData.strUsername + " (NPC)");
                    avatarMC.mouseEnabled = true;
                    avatarMC.mouseChildren = true;
                    avatarMC.mcChar.mouseEnabled = true;
                    avatarMC.mcChar.mouseChildren = true;
                    avatarMC.buttonMode = true;
                    new Drag(avatarMC, avatarMC, npcTool.onPositionChange);
                }, false, 0, true);
                avatarMC.addEventListener(MouseEvent.MOUSE_DOWN, function (e:MouseEvent):void
                {
                    Game.root.chatF.pushMsg("game", "avatarMC MOUSE DOWN", "SERVER", "", 0);
                });
            };
        }

        public function onClick(event:MouseEvent):void
        {
            Game.root.world.openApop({
                "npcLinkage":"AvatarMC",
                "cnt":"Plugins.ConfigurableNPC.CoreAPOP",
                "npcEntry":((this.objSettings.face.toLowerCase() == "left") ? "right" : "left"),
                "scene":"None"
            }, this.objSettings);
        }

        private function checkTime(event:TimerEvent):void
        {
            var Time:Object;
            var gameTime:Number = Game.root.date_server.hours;
            for each (Time in this.objSettings.Time)
            {
                visible = (!((gameTime >= Time.Start) && (gameTime < Time.End)));
            };
        }


    }
}//package Plugins.ConfigurableNPC

