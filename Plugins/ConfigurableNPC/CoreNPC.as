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

    public class CoreNPC extends MovieClip 
    {

        public var isProp:Boolean = true;
        public var objSettings:Object;
        public var btnButton:SimpleButton;
        public var objAvatar:Avatar;

        public function CoreNPC(world:World, avatar:Avatar, characterData:Object, index:int)
        {
            var button:DisplayObject;
            super();
            this.objSettings = characterData;
            this.objAvatar = avatar;
            if (this.objAvatar == null)
            {
                return;
            };
            var avatarMC:AvatarMC = AvatarUtil.buildAvatar("npc", world.CHARS, this.objAvatar, this.objSettings, this.objSettings.avatarMC);
            var i:int;
            while (i < avatarMC.numChildren)
            {
                if (avatarMC.getChildAt(i).name == "CoreNPCButton")
                {
                    avatarMC.removeChildAt(i);
                };
                i++;
            };
            avatarMC.mcChar.mouseEnabled = false;
            avatarMC.mcChar.mouseChildren = false;
            button = avatarMC.addChildAt(new CoreNPCButton(), 8);
            button.y = avatarMC.bubble.y;
            button.x = (avatarMC.fx.x - 10);
            button.name = "CoreNPCButton";
            button.addEventListener(MouseEvent.MOUSE_DOWN, this.onClick);
            world.npcs[index].pMC = avatarMC;
            avatarMC.apopbutton = MovieClip(button);
            avatarMC.pname.ti.text = "";
            avatarMC.name = (characterData.strUsername + "_CORE_NPC");
            avatarMC.scale(world.SCALE);
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

