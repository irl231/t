// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.Bot.BotAttackController

package Main.Controller.Bot
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import Game_fla.mcPopup_323;
    import Main.Model.Skill;
    import Game_fla.Respawn;
    import flash.events.TimerEvent;
    import flash.events.*;
    import flash.utils.*;
    import Game_fla.*;

    public class BotAttackController 
    {

        public static const events:EventDispatcher = new EventDispatcher();

        public var target:String = null;
        public var taskCombat:Timer = null;
        private var skillCurrentIndex:uint = 0;

        public function BotAttackController(target:String)
        {
            this.target = target;
        }

        public function start():void
        {
            BotController.debug("BotAttack", "Initiated.");
            this.taskCombat = new Timer(100, 0);
            this.taskCombat.addEventListener(TimerEvent.TIMER, this.action);
            this.taskCombat.start();
        }

        public function stop():void
        {
            BotController.debug("BotAttack", "Stopped.");
            this.taskCombat.reset();
            this.taskCombat.removeEventListener(TimerEvent.TIMER, this.action);
            this.taskCombat = null;
            BotController.taskBot.start();
        }

        private function getRandomMonster(game:Game):Avatar
        {
            var monster:Avatar;
            var monsters:Array = game.world.getMonstersByCell(game.world.strFrame);
            var monsterFound:Avatar;
            for each (monster in monsters)
            {
                if (monster.dataLeaf.intState > 0)
                {
                    monsterFound = monster;
                };
            };
            if (monsterFound == null)
            {
                BotController.onMonsterDead();
            };
            return (monsterFound);
        }

        private function getMonsterByName(name:String, game:Game):Avatar
        {
            var monster:Avatar;
            var monsters:Array = game.world.getMonstersByCell(game.world.strFrame);
            var monsterFound:Avatar;
            for each (monster in monsters)
            {
                if (((monster.pMC.pname.ti.text.toUpperCase() == name.toUpperCase()) && (monster.dataLeaf.intState > 0)))
                {
                    monsterFound = monster;
                };
            };
            if (monsterFound == null)
            {
                BotController.onMonsterDead();
            };
            return (monsterFound);
        }

        private function useSkill():void
        {
            var action:*;
            var mcPopup:mcPopup_323;
            var game:Game = Game.root;
            var skill:Skill = ((BotController.data.skills.length == 0) ? game.world.actions.active[Math.floor((Math.random() * game.world.actions.active.length))] : BotController.data.skills[this.skillCurrentIndex].value);
            if ((((((skill.ref == "a1") || (skill.ref == "a2")) || (skill.ref == "a3")) || (skill.ref == "a4")) || (((!(((skill.ref == "i1") && (skill.typ == "i")) && (skill.sArg1 == ""))) && (Game.root.world.actionTimeCheck(skill))) && (game.world.myAvatar.dataLeaf.intMP >= skill.mp))))
            {
                if (Game.root.ui)
                {
                    mcPopup = mcPopup_323(game.ui.mcPopup);
                    if (mcPopup.botPanel != null)
                    {
                        mcPopup.botPanel.listSkills.scrollToIndex(this.skillCurrentIndex);
                        mcPopup.botPanel.listSkills.selectedIndex = this.skillCurrentIndex;
                    };
                };
                action = game.world.getActionByRef(skill.ref);
                if (action.isOK)
                {
                    game.world.combatAction(skill);
                };
                this.skillCurrentIndex++;
            };
            if (this.skillCurrentIndex == BotController.data.skills.length)
            {
                this.skillCurrentIndex = 0;
            };
        }

        private function action(event:TimerEvent):void
        {
            var monster:Avatar;
            var game:Game = Game.root;
            if (((!(game.currentLabel == "Game")) && (!(game.currentLabel == "Mobile"))))
            {
                BotController.debug("BotAttack", "Wrong currentLabel");
                this.stop();
                return;
            };
            if (game.world.myAvatar.objData.intEnergy <= 0)
            {
                BotController.debug("BotAttack", "No Energy");
                this.stop();
                return;
            };
            try
            {
                if (((game.world.myAvatar.dataLeaf.intState <= 0) && (game.world.myAvatar.dataLeaf.intHP <= 0)))
                {
                    this.stop();
                    setTimeout(function ():void
                    {
                        BotController.debug("BotRespawn", "Checking Respawn");
                        var respawn:Respawn = Respawn(Game.root.ui.getChildByName("respawn"));
                        if (respawn)
                        {
                            BotController.debug("BotRespawn", "Respawning");
                            respawn.btnRes.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        }
                        else
                        {
                            BotController.debug("BotRespawn", "Failed to Respawn");
                        };
                    }, ((Game.root.world.myAvatar.isUpgraded()) ? 3000 : 10000));
                    return;
                };
                if (game.world.myAvatar.target == null)
                {
                    monster = ((this.target) ? this.getMonsterByName(this.target, game) : this.getRandomMonster(game));
                    if (monster == null)
                    {
                        this.stop();
                        return;
                    };
                    game.world.setTarget(monster);
                    game.world.approachTarget();
                    game.world.combatAction(game.world.getAutoAttack());
                };
                if (((!(game.world.myAvatar.target == null)) && (game.world.myAvatar.target.npcType == "monster")))
                {
                    this.useSkill();
                }
                else
                {
                    game.world.cancelTarget();
                };
                if (((!(game.world.myAvatar.target == null)) && (game.world.myAvatar.target.dataLeaf.intState == 1)))
                {
                    game.world.cancelTarget();
                };
            }
            catch(err:Error)
            {
                trace("An unknown error occurred", err.getStackTrace());
                stop();
            };
        }


    }
}//package Main.Controller.Bot

