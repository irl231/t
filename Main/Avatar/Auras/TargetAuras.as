// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Avatar.Auras.TargetAuras

package Main.Avatar.Auras
{
    import flash.events.Event;
    import flash.display.*;

    public class TargetAuras extends PlayerAuras 
    {

        public function TargetAuras()
        {
            this.name = "targetAuras";
            this.visible = true;
            aurasStack = {};
            auraContainer = new MovieClip();
            auraContainer.mouseEnabled = (auraContainer.mouseChildren = false);
            game.ui.targetAura.display.addChild(auraContainer);
            game.ui.targetAura.display.setChildIndex(auraContainer, 0);
            auraContainer.name = "tAuraContainer";
            auraContainer.x = this.x;
            auraContainer.y = this.y;
        }

        override protected function createIconMC(auraName:String, auraStack:Number, auraIcon:String):void
        {
            if (!game.world.myAvatar.target)
            {
                return;
            };
            super.createIconMC(auraName, auraStack, auraIcon);
        }

        override public function handleAura(auraData:Object):void
        {
            if (((!(game.world.myAvatar)) || (!(game.world.myAvatar.target))))
            {
                return;
            };
            if (auraData == null)
            {
                return;
            };
            switch (game.world.myAvatar.target.npcType)
            {
                case "player":
                    if (auraData.tInf != ("p:" + game.world.myAvatar.target.dataLeaf.entID.toString()))
                    {
                        return;
                    };
                    break;
                case "monster":
                    if (auraData.tInf != ("m:" + game.world.myAvatar.target.dataLeaf.MonMapID.toString()))
                    {
                        return;
                    };
                    break;
                case "npc":
                    if (auraData.tInf != ("n:" + game.world.myAvatar.target.dataLeaf.NpcMapID.toString()))
                    {
                        return;
                    };
                    break;
            };
            handleAuraCreation(auraData, game.world.myAvatar.target);
        }

        override protected function coolDownAct(_ib2:ib2, cooldown:int=-1, alpha:Number=127):void
        {
            if (!game.world.myAvatar.target)
            {
                aurasStack = {};
                onReset();
                return;
            };
            super.coolDownAct(_ib2, cooldown, alpha);
        }

        override protected function countDownAct(e:Event):void
        {
            if (((!(game.world)) || (!(game.world.myAvatar.target))))
            {
                aurasStack = {};
                onReset();
                return;
            };
            super.countDownAct(e);
        }


    }
}//package Main.Avatar.Auras

