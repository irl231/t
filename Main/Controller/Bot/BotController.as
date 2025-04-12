// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.Bot.BotController

package Main.Controller.Bot
{
    import Main.Bot.Data.BotData;
    import flash.utils.Timer;
    import Game_fla.mcPopup_323;
    import Main.Model.Item;
    import flash.display.DisplayObject;
    import flash.events.TimerEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import Main.Bot.Data.*;
    import Game_fla.*;

    public class BotController 
    {

        public static const data:BotData = new BotData();
        public static var isBotting:Boolean = false;
        public static var taskBot:Timer = null;
        public static var listCurrentIndex:uint = 0;
        public static var attackController:BotAttackController = null;


        public static function debug(name:String, message:String):void
        {
            if (!data.debug)
            {
                return;
            };
            trace(name, message);
            var game:Game = Game.root;
            if (((game.currentLabel == "Game") || (game.currentLabel == "Mobile")))
            {
                game.chatF.pushMsg("event", message, name, "", 0);
            };
        }

        public static function start():void
        {
            var quest:Object;
            var mcPopup:mcPopup_323;
            BotController.debug("Bot", "Initiated");
            data.attempt = 0;
            var game:Game = Game.root;
            game.chatF.pushMsg("server", "[BOT] started.", "SERVER", "", 0);
            isBotting = true;
            taskBot = new Timer(2000, 0);
            taskBot.addEventListener(TimerEvent.TIMER, task);
            taskBot.start();
            listCurrentIndex = 0;
            var arrQuests:Array = [];
            var j:* = 3000;
            for each (quest in data.quests)
            {
                arrQuests.push(quest.value);
                if (!game.world.isQuestInProgress(quest.value))
                {
                    setTimeout(game.world.acceptQuest, j, quest.value, false, true);
                    j = (j + 1000);
                };
            };
            game.world.getQuests(arrQuests);
            if (Game.root.ui)
            {
                mcPopup = mcPopup_323(Game.root.ui.mcPopup);
                if (mcPopup.botPanel != null)
                {
                    mcPopup.botPanel.listCurrentIndex = 0;
                    mcPopup.botPanel.txtButton.text = "Stop";
                    BotController.data.debug = mcPopup.botPanel.chkDebug.bitChecked;
                };
            };
        }

        public static function stop():void
        {
            var mcPopup:mcPopup_323;
            BotController.debug("Bot", "Stopped");
            var game:Game = Game.root;
            if (((game.currentLabel == "Game") || (game.currentLabel == "Mobile")))
            {
                game.chatF.pushMsg("warning", "[BOT] stopped.", "SERVER", "", 0);
            };
            isBotting = false;
            if (((BotController.attackController) && (BotController.attackController.taskCombat)))
            {
                BotController.attackController.taskCombat.reset();
                BotController.attackController.taskCombat = null;
            };
            BotController.attackController = null;
            if (taskBot)
            {
                taskBot.reset();
                taskBot.removeEventListener(TimerEvent.TIMER, task);
                taskBot = null;
            };
            if (Game.root.ui)
            {
                mcPopup = mcPopup_323(Game.root.ui.mcPopup);
                if (mcPopup.botPanel != null)
                {
                    mcPopup.botPanel.txtButton.text = "Start";
                    BotController.data.debug = mcPopup.botPanel.chkDebug.bitChecked;
                };
            };
        }

        public static function sleep(sleep:uint, callback:Function=null):void
        {
            taskBot.reset();
            setTimeout(function ():void
            {
                if (callback != null)
                {
                    callback();
                };
                taskBot.start();
            }, sleep);
        }

        public static function useEnergizer(force:Boolean=false):void
        {
            var item:Item;
            var game:Game = Game.root;
            if (((game.world.myAvatar.objData.intEnergy > 10) && (!(force))))
            {
                return;
            };
            for each (item in game.world.myAvatar.items)
            {
                if (item.sMeta == "energy")
                {
                    BotController.debug("Bot", ((('Using "' + "BotController] Using ") + item.sName) + '"'));
                    game.world.sendUseItemRequest({"ItemID":item.ItemID});
                    game.mixer.playSound("Good");
                    return;
                };
            };
            game.openBotPanel();
        }

        public static function pickUpItems():void
        {
            var game:Game;
            var displayObject:DisplayObject;
            var item:Item;
            var drop:DFrame2MC;
            BotController.debug("Bot", "Pick all items.");
            game = Game.root;
            var dropStackNumChildren:int = MovieClip(game.ui.dropStack).numChildren;
            var j:* = 500;
            var i:int;
            while (i < dropStackNumChildren)
            {
                displayObject = MovieClip(game.ui.dropStack).getChildAt(i);
                if ((displayObject is DFrame2MC))
                {
                    item = DFrame2MC(displayObject).fData;
                    if (item.bTemp == 0)
                    {
                        drop = DFrame2MC(displayObject);
                        BotController.debug("Bot", (((((('Obtained "' + item.sName) + " ") + item.iQty) + 'x" drop in ') + j) + "ms."));
                        setTimeout(drop.cnt.ybtn.dispatchEvent, j, new MouseEvent(MouseEvent.CLICK));
                        j = (j + 250);
                    };
                };
                i++;
            };
        }

        public static function pickUpItem(name:String):void
        {
            var game:Game;
            var displayObject:DisplayObject;
            var item:Item;
            var drop:DFrame2MC;
            BotController.debug("Bot", "Pick one item.");
            game = Game.root;
            var dropStackNumChildren:int = MovieClip(game.ui.dropStack).numChildren;
            var i:int;
            while (i < dropStackNumChildren)
            {
                displayObject = MovieClip(game.ui.dropStack).getChildAt(i);
                if ((displayObject is DFrame2MC))
                {
                    item = DFrame2MC(displayObject).fData;
                    if (((item.sName.toUpperCase() == name.toUpperCase()) && (item.bTemp == 0)))
                    {
                        drop = DFrame2MC(displayObject);
                        BotController.debug("Bot", (((('Obtained "' + item.sName) + " ") + item.iQty) + 'x" drop.'));
                        drop.cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                };
                i++;
            };
        }

        public static function denyItems():void
        {
            var game:Game;
            var displayObject:DisplayObject;
            var item:Item;
            var drop:DFrame2MC;
            game = Game.root;
            var dropStackNumChildren:int = MovieClip(game.ui.dropStack).numChildren;
            var i:int;
            while (i < dropStackNumChildren)
            {
                displayObject = MovieClip(game.ui.dropStack).getChildAt(i);
                if ((displayObject is DFrame2MC))
                {
                    item = DFrame2MC(displayObject).fData;
                    if (((game.world.invTree[item.ItemID] == null) && (item.bTemp == 0)))
                    {
                        drop = DFrame2MC(displayObject);
                        BotController.debug("Bot", (('Drop "' + item.sName) + '" denied.'));
                        drop.cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                };
                i++;
            };
        }

        public static function onMonsterDead():void
        {
            var game:Game;
            BotController.debug("Bot", "Monster defeated.");
            game = Game.root;
            game.world.exitCombat();
            game.world.cancelTarget();
            var HPPercentage:Number = (game.world.myAvatar.dataLeaf.intHP / game.world.myAvatar.dataLeaf.intHPMax);
            var MPPercentage:Number = (game.world.myAvatar.dataLeaf.intMP / game.world.myAvatar.dataLeaf.intMPMax);
            if (((HPPercentage <= 0.05) || (MPPercentage <= 0.03)))
            {
                BotController.debug("Bot", "Resting.");
                game.network.send("botProcess", [false]);
                game.world.rest();
                sleep(30000, function ():void
                {
                    Game.root.network.send("botProcess", [true]);
                });
            };
            checkStatus();
        }

        public static function checkStatus():void
        {
            var item:*;
            var quest:Object;
            var canTurnInQuest:Boolean;
            BotController.debug("Bot", (((((("Check status: Use energy? " + ((data.energy) ? "yes" : "no")) + ", Reject items? ") + ((data.reject) ? "yes" : "no")) + ", Pick items? ") + ((data.pickup) ? "yes" : "no")) + ", "));
            var game:Game = Game.root;
            for each (item in data.items)
            {
                pickUpItem(item.value);
            };
            if (data.energy)
            {
                useEnergizer();
            };
            if (data.reject)
            {
                denyItems();
            };
            if (data.pickup)
            {
                pickUpItems();
            };
            for each (quest in data.quests)
            {
                canTurnInQuest = game.world.canTurnInQuest(quest.value);
                BotController.debug("Bot", (((("Can turn in quest #" + quest.value) + "? ") + canTurnInQuest) ? "yes" : "no"));
                if (canTurnInQuest)
                {
                    BotController.debug("Bot", ("Turn in quest #" + quest.value));
                    game.world.tryQuestComplete(quest.value, -1);
                };
            };
        }

        public static function task(event:TimerEvent):void
        {
            var command:* = undefined;
            var mcPopup:mcPopup_323;
            var roomName:String;
            var timer:Timer;
            var game:Game = Game.root;
            switch (game.currentLabel)
            {
                case "Login":
                    if (!data.relogin)
                    {
                        BotController.debug("Bot", "Relogin not on");
                        stop();
                        return;
                    };
                    BotController.debug("Bot", "Relogin on");
                    data.attempt++;
                    if (data.attempt > 10)
                    {
                        stop();
                        return;
                    };
                    switch (game.mcLogin.currentLabel)
                    {
                        case "Init":
                            game.login();
                            break;
                        case "Characters":
                            game.mcLogin.onPlayClick();
                            break;
                    };
                    sleep(30000);
                    break;
                case "Game":
                case "Mobile":
                    if (((game.world.myAvatar.dataLeaf.intState <= 0) && (game.world.myAvatar.dataLeaf.intHP <= 0)))
                    {
                        return;
                    };
                    command = data.commands[listCurrentIndex];
                    if (Game.root.ui)
                    {
                        mcPopup = mcPopup_323(Game.root.ui.mcPopup);
                        if (mcPopup.botPanel != null)
                        {
                            mcPopup.botPanel.listCommand.scrollToIndex(listCurrentIndex);
                            mcPopup.botPanel.listCommand.selectedIndex = listCurrentIndex;
                        };
                    };
                    try
                    {
                        checkStatus();
                    }
                    catch(e:Error)
                    {
                        BotController.debug("Bot", ("Error on check status " + e.message));
                    };
                    switch (command.command)
                    {
                        case "AttackM":
                            BotController.debug("Bot", ("Task attack monster " + command.value));
                            taskBot.reset();
                            attackController = null;
                            attackController = new BotAttackController(((command.value == "*") ? null : command.value));
                            attackController.start();
                            break;
                        case "JoinR":
                            BotController.debug("Bot", ("Task join room " + command.value));
                            roomName = ((command.value.indexOf("-") > 0) ? command.value.split("-")[0] : command.value);
                            if (((!(game.world.mapLoadInProgress)) && (!(game.world.strMapName.toUpperCase() == roomName.toUpperCase()))))
                            {
                                game.world.gotoTown(command.value, "Enter", "Spawn");
                                return;
                            };
                            break;
                        case "MoveC":
                            BotController.debug("Bot", ((("Task move to frame " + command.value.cell) + " and pad ") + command.value.pad));
                            if (((!(game.world.strFrame == command.value.cell)) || (!(game.world.strPad == command.value.pad))))
                            {
                                if (((!(command.value.cell == "Enter")) && (!(game.frameCheck(game.world.map, command.value.cell)))))
                                {
                                    game.chatF.pushMsg("warning", (("The map frame/room <font color='#FFFFFF'>" + command.value.cell) + "</font> does not exist."), "SERVER", "", 0);
                                    command.value.cell = "Enter";
                                };
                                game.world.moveToCell(command.value.cell, command.value.pad);
                            };
                            break;
                        case "MoveU":
                            BotController.debug("Bot", (((("Task move to (" + command.value.tx) + ", ") + command.value.ty) + ") coordinate"));
                            game.world.myAvatar.pMC.walkTo(command.value.tx, command.value.ty, game.world.WALKSPEED);
                            game.world.moveRequest({
                                "mc":game.world.myAvatar.pMC,
                                "tx":command.value.tx,
                                "ty":command.value.ty,
                                "sp":game.world.WALKSPEED
                            });
                            break;
                        case "DelayM":
                            BotController.debug("Bot", ("Task delay " + command.value));
                            taskBot.reset();
                            timer = new Timer(command.value);
                            timer.addEventListener(TimerEvent.TIMER, function (event:TimerEvent):void
                            {
                                taskBot.start();
                                timer.reset();
                            });
                            timer.start();
                            break;
                        case "GetD":
                            BotController.debug("Bot", (('Task get drop "' + command.value) + '"'));
                            pickUpItem(command.value);
                            break;
                        default:
                            BotController.debug("Bot", "Task undefined");
                    };
                    listCurrentIndex++;
                    if (listCurrentIndex == data.commands.length)
                    {
                        listCurrentIndex = 0;
                    };
                    break;
            };
        }


    }
}//package Main.Controller.Bot

