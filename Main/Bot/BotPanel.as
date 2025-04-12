// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Bot.BotPanel

package Main.Bot
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import Main.Bot.UI.BotInput;
    import flash.display.SimpleButton;
    import fl.controls.List;
    import Game_fla.chkBox_32;
    import flash.net.FileReference;
    import flash.net.FileFilter;
    import flash.utils.ByteArray;
    import Main.Model.Skill;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import fl.controls.*;
    import flash.events.*;
    import fl.data.*;
    import flash.utils.*;
    import flash.net.*;
    import Main.*;
    import Main.Controller.Bot.*;
    import Game_fla.*;

    public class BotPanel extends MovieClip 
    {

        private const game:Game = Game.root;

        public var txtButton:TextField;
        public var skill:BotInput;
        public var item:BotInput;
        public var quest:BotInput;
        public var delay:BotInput;
        public var monster:BotInput;
        public var xAxis:BotInput;
        public var yAxis:BotInput;
        public var map:BotInput;
        public var frame:BotInput;
        public var pad:BotInput;
        public var btnCommands:SimpleButton;
        public var btnQuests:SimpleButton;
        public var btnSkills:SimpleButton;
        public var btnItems:SimpleButton;
        public var listCommand:List;
        public var listSkills:List;
        public var listQuests:List;
        public var listItems:List;
        public var btnClose:SimpleButton;
        public var btnActivate:SimpleButton;
        public var btnUp:SimpleButton;
        public var btnDown:SimpleButton;
        public var btnCurCellPad:SimpleButton;
        public var btnLoad:SimpleButton;
        public var btnSave:SimpleButton;
        public var btnCurCoordinate:SimpleButton;
        public var btnRemove:SimpleButton;
        public var btnClear:SimpleButton;
        public var btnEnergyShop:SimpleButton;
        public var chkPickup:chkBox_32;
        public var chkSkip:chkBox_32;
        public var chkEnergy:chkBox_32;
        public var chkRelogin:chkBox_32;
        public var chkReject:chkBox_32;
        public var chkDebug:chkBox_32;
        public var energyMeter:MovieClip;
        public var botFile:FileReference = new FileReference();
        public var botFilter:FileFilter = new FileFilter("Explosion (*.adbot)", "*.adbot;*.;");
        public var listCurrentIndex:uint = 0;

        public function BotPanel()
        {
            this.listCommand = List(this.addChild(new List()));
            this.listCommand.x = 38.45;
            this.listCommand.y = 60;
            this.listCommand.width = 336;
            this.listCommand.height = 191;
            this.listSkills = List(this.addChild(new List()));
            this.listSkills.x = 38.45;
            this.listSkills.y = 60;
            this.listSkills.width = 336;
            this.listSkills.height = 191;
            this.listQuests = List(this.addChild(new List()));
            this.listQuests.x = 38.45;
            this.listQuests.y = 60;
            this.listQuests.width = 336;
            this.listQuests.height = 191;
            this.listItems = List(this.addChild(new List()));
            this.listItems.x = 38.45;
            this.listItems.y = 60;
            this.listItems.width = 336;
            this.listItems.height = 191;
            this.initData("Load");
            this.skill.title.text = "Skill name";
            this.skill.button.addEventListener(MouseEvent.CLICK, this.onClickSkill);
            this.item.title.text = "Item name";
            this.item.button.addEventListener(MouseEvent.CLICK, this.onClickItem);
            this.quest.title.text = "Quest ID";
            this.quest.button.addEventListener(MouseEvent.CLICK, this.onClickQuest);
            this.delay.title.text = "Delay";
            this.delay.button.addEventListener(MouseEvent.CLICK, this.onClickDelay);
            this.monster.title.text = "Monster name or *";
            this.monster.button.addEventListener(MouseEvent.CLICK, this.onClickMonster);
            this.xAxis.title.text = "X coordinate";
            this.xAxis.hideButton();
            this.yAxis.title.text = "Y coordinate";
            this.yAxis.button.addEventListener(MouseEvent.CLICK, this.onClickYAxis);
            this.map.title.text = "Map name";
            this.map.button.addEventListener(MouseEvent.CLICK, this.onClickMap);
            this.frame.title.text = "Frame";
            this.frame.hideButton();
            this.pad.title.text = "Pad";
            this.pad.button.addEventListener(MouseEvent.CLICK, this.onClickPad);
            this.txtButton.text = ((BotController.isBotting) ? "Stop" : "Start");
            this.txtButton.mouseEnabled = false;
            this.btnCommands.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnSkills.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnItems.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnQuests.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnActivate.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnRemove.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnClear.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnLoad.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnSave.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnUp.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnDown.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnCurCellPad.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnCurCoordinate.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.btnEnergyShop.addEventListener(MouseEvent.CLICK, this.onMouseEventClick);
            this.listCommand.visible = true;
            this.listSkills.visible = false;
            this.listQuests.visible = false;
            this.listItems.visible = false;
            this.onUpdateEnergy();
            stop();
        }

        private static function moveItem(list:List, Method:Boolean):void
        {
            var obj:Object = list.selectedItem;
            var index:uint = ((Method) ? (list.selectedIndex + 1) : (list.selectedIndex - 1));
            list.dataProvider.removeItem(list.selectedItem);
            list.dataProvider.addItemAt(obj, index);
            list.selectedIndex = index;
        }


        public function onUpdateEnergy():void
        {
            this.energyMeter.t1.text = ((this.game.strNumWithCommas(this.game.world.myAvatar.objData.intEnergy) + " / ") + this.game.strNumWithCommas(this.game.world.myAvatar.objData.intEnergyMax));
            this.energyMeter.fill.scaleX = (this.game.world.myAvatar.objData.intEnergy / this.game.world.myAvatar.objData.intEnergyMax);
        }

        private function buttonHandler(button:String):void
        {
            var botData:ByteArray;
            switch (button)
            {
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    mcPopup_323(this.parent).onClose();
                    this.initData("Save");
                    break;
                case "btnEnergyShop":
                    this.buttonHandler("btnClose");
                    this.game.world.sendLoadShopRequest(Config.getInt("shop_energy"));
                    break;
                case "btnLoad":
                    Game.root.chatF.pushMsg("server", "btnLoad", "SERVER", "", 0);
                    try
                    {
                        this.botFile = new FileReference();
                        this.botFile.addEventListener(Event.SELECT, this.onBotFileSelected);
                        this.botFile.addEventListener(IOErrorEvent.IO_ERROR, this.onFileLoadError);
                        this.botFile.browse([this.botFilter]);
                    }
                    catch(e:Error)
                    {
                        Game.root.chatF.pushMsg("server", e.getStackTrace(), "SERVER", "", 0);
                    };
                    break;
                case "btnSave":
                    botData = new ByteArray();
                    botData.writeObject({
                        "skip":this.chkSkip.bitChecked,
                        "pickup":this.chkPickup.bitChecked,
                        "reject":this.chkReject.bitChecked,
                        "energy":this.chkEnergy.bitChecked,
                        "relogin":this.chkRelogin.bitChecked
                    });
                    botData.writeObject(this.listCommand.dataProvider.toArray());
                    botData.writeObject(this.listSkills.dataProvider.toArray());
                    botData.writeObject(this.listQuests.dataProvider.toArray());
                    botData.writeObject(this.listItems.dataProvider.toArray());
                    this.botFile = new FileReference();
                    this.botFile.save(botData, "My Bot.adbot");
                    break;
                case "btnCommands":
                    this.listCommand.visible = true;
                    this.listSkills.visible = false;
                    this.listQuests.visible = false;
                    this.listItems.visible = false;
                    break;
                case "btnSkills":
                    this.listCommand.visible = false;
                    this.listSkills.visible = true;
                    this.listQuests.visible = false;
                    this.listItems.visible = false;
                    break;
                case "btnQuests":
                    this.listCommand.visible = false;
                    this.listSkills.visible = false;
                    this.listQuests.visible = true;
                    this.listItems.visible = false;
                    break;
                case "btnItems":
                    this.listCommand.visible = false;
                    this.listSkills.visible = false;
                    this.listQuests.visible = false;
                    this.listItems.visible = true;
                    break;
                case "btnActivate":
                    if (BotController.isBotting)
                    {
                        this.game.network.send("botProcess", [false]);
                        return;
                    };
                    if (this.listCommand.dataProvider.toArray().length == 0)
                    {
                        this.game.MsgBox.notify("Command List can't be empty.");
                        return;
                    };
                    this.game.network.send("botProcess", [true]);
                    this.initData("Save");
                    break;
                case "btnUp":
                    if (this.listSkills.visible)
                    {
                        moveItem(this.listSkills, false);
                    };
                    if (this.listCommand.visible)
                    {
                        moveItem(this.listCommand, false);
                    };
                    if (this.listQuests.visible)
                    {
                        moveItem(this.listQuests, false);
                    };
                    if (this.listItems.visible)
                    {
                        moveItem(this.listItems, false);
                    };
                    this.initData("Save");
                    BotController.stop();
                    break;
                case "btnDown":
                    if (this.listSkills.visible)
                    {
                        moveItem(this.listSkills, true);
                    };
                    if (this.listCommand.visible)
                    {
                        moveItem(this.listCommand, true);
                    };
                    if (this.listQuests.visible)
                    {
                        moveItem(this.listQuests, true);
                    };
                    if (this.listItems.visible)
                    {
                        moveItem(this.listItems, true);
                    };
                    this.initData("Save");
                    BotController.stop();
                    break;
                case "btnClear":
                    if (this.listSkills.visible)
                    {
                        this.listSkills.dataProvider.removeAll();
                    };
                    if (this.listCommand.visible)
                    {
                        this.listCommand.dataProvider.removeAll();
                    };
                    if (this.listQuests.visible)
                    {
                        this.listQuests.dataProvider.removeAll();
                    };
                    if (this.listItems.visible)
                    {
                        this.listItems.dataProvider.removeAll();
                    };
                    this.initData("Save");
                    BotController.stop();
                    break;
                case "btnRemove":
                    if (this.listSkills.visible)
                    {
                        this.listSkills.dataProvider.removeItemAt(this.listSkills.selectedIndex);
                    };
                    if (this.listCommand.visible)
                    {
                        this.listCommand.dataProvider.removeItemAt(this.listCommand.selectedIndex);
                    };
                    if (this.listQuests.visible)
                    {
                        this.listQuests.dataProvider.removeItemAt(this.listQuests.selectedIndex);
                    };
                    if (this.listItems.visible)
                    {
                        this.listItems.dataProvider.removeItemAt(this.listItems.selectedIndex);
                    };
                    this.initData("Save");
                    BotController.stop();
                    break;
                case "btnCurCellPad":
                    this.frame.input.text = this.game.world.strFrame;
                    this.pad.input.text = this.game.world.strPad;
                    break;
                case "btnCurCoordinate":
                    this.xAxis.input.text = String(this.game.world.myAvatar.pMC.x);
                    this.yAxis.input.text = String(this.game.world.myAvatar.pMC.y);
                    break;
            };
        }

        private function addItemList(name:String):void
        {
            this.listItems.dataProvider.addItem({
                "label":("Pick up Item: " + name),
                "value":name
            });
        }

        private function addQuestList(id:String):void
        {
            this.listQuests.dataProvider.addItem({
                "label":("Quest: " + id),
                "value":id
            });
        }

        private function addSkillItem(name:String):void
        {
            var skill1:Skill;
            for each (skill1 in this.game.world.actions.active)
            {
                if (((!(skill1.nam == null)) && (skill1.nam.toUpperCase() == name.toUpperCase())))
                {
                    this.listSkills.dataProvider.addItem({
                        "label":("Use Skill: " + skill1.nam),
                        "value":skill1,
                        "name":skill1.nam
                    });
                    return;
                };
            };
            this.game.MsgBox.notify((("There is no skill named " + name) + " in your equipped skill slots."));
        }

        private function addCommandItem(command:String, obj:Object):void
        {
            switch (command)
            {
                case "JoinR":
                    this.listCommand.dataProvider.addItem({
                        "label":("Join Room: " + obj),
                        "value":obj,
                        "command":"JoinR"
                    });
                    break;
                case "GetD":
                    this.listCommand.dataProvider.addItem({
                        "label":("Get Drop: " + obj),
                        "value":obj,
                        "command":"GetD"
                    });
                    break;
                case "MoveC":
                    this.listCommand.dataProvider.addItem({
                        "label":(((("Move: (" + obj.cell) + ", ") + obj.pad) + ")"),
                        "value":obj,
                        "command":"MoveC"
                    });
                    break;
                case "MoveU":
                    this.listCommand.dataProvider.addItem({
                        "label":(((("Move: (" + obj.tx) + ", ") + obj.ty) + ")"),
                        "value":obj,
                        "command":"MoveU"
                    });
                    break;
                case "DelayM":
                    this.listCommand.dataProvider.addItem({
                        "label":(("Delay: " + obj) + "ms"),
                        "value":obj,
                        "command":"DelayM"
                    });
                    break;
                case "AttackM":
                    this.listCommand.dataProvider.addItem({
                        "label":("Attack till Dead: " + obj),
                        "value":obj,
                        "command":"AttackM"
                    });
                    break;
                default:
                    throw (new Error("Unknown Command", 1047));
            };
            this.initData("Save");
            BotController.stop();
        }

        private function initData(mode:String="Save"):void
        {
            var actObj:*;
            switch (mode)
            {
                case "Save":
                    BotController.data.skip = this.chkSkip.bitChecked;
                    BotController.data.pickup = this.chkPickup.bitChecked;
                    BotController.data.reject = this.chkReject.bitChecked;
                    BotController.data.energy = this.chkEnergy.bitChecked;
                    BotController.data.relogin = this.chkRelogin.bitChecked;
                    BotController.data.debug = this.chkDebug.bitChecked;
                    BotController.data.commands = this.listCommand.dataProvider.toArray();
                    BotController.data.skills = this.listSkills.dataProvider.toArray();
                    BotController.data.quests = this.listQuests.dataProvider.toArray();
                    BotController.data.items = this.listItems.dataProvider.toArray();
                    break;
                case "Load":
                    this.chkSkip.reCheck(BotController.data.skip);
                    this.chkPickup.reCheck(BotController.data.pickup);
                    this.chkReject.reCheck(BotController.data.reject);
                    this.chkEnergy.reCheck(BotController.data.energy);
                    this.chkRelogin.reCheck(BotController.data.relogin);
                    this.listCommand.dataProvider = new DataProvider(BotController.data.commands);
                    for each (actObj in BotController.data.skills)
                    {
                        this.addSkillItem(actObj.name);
                    };
                    this.listQuests.dataProvider = new DataProvider(BotController.data.quests);
                    this.listItems.dataProvider = new DataProvider(BotController.data.items);
                    break;
            };
        }

        private function onClickSkill(mouseEvent:MouseEvent):void
        {
            if (this.skill.input.text == "")
            {
                this.game.MsgBox.notify("Must Enter a skill name.");
                return;
            };
            this.addSkillItem(this.skill.input.text);
            this.skill.input.text = "";
            this.buttonHandler("btnSkills");
        }

        private function onClickItem(mouseEvent:MouseEvent):void
        {
            if (this.item.input.text == "")
            {
                this.game.MsgBox.notify("Must Enter a item name.");
                return;
            };
            this.addItemList(this.item.input.text);
            this.item.input.text = "";
            this.buttonHandler("btnItems");
        }

        private function onClickQuest(mouseEvent:MouseEvent):void
        {
            if (this.quest.input.text == "")
            {
                this.game.MsgBox.notify("Must Enter a quest id.");
                return;
            };
            this.addQuestList(this.quest.input.text);
            this.quest.input.text = "";
            this.buttonHandler("btnQuests");
        }

        private function onClickDelay(mouseEvent:MouseEvent):void
        {
            if (this.delay.input.text == "")
            {
                this.game.MsgBox.notify("Must Enter a delay.");
                return;
            };
            if (isNaN(Number(this.delay.input.text)))
            {
                this.game.MsgBox.notify("Must enter a numeric value.");
                return;
            };
            this.addCommandItem("DelayM", parseInt(this.delay.input.text));
            this.delay.input.text = "";
            this.buttonHandler("btnCommands");
        }

        private function onClickMonster(mouseEvent:MouseEvent):void
        {
            if (this.monster.input.text == "")
            {
                this.game.MsgBox.notify("Must Enter a monster name.");
                return;
            };
            this.addCommandItem("AttackM", this.monster.input.text.toUpperCase());
            this.monster.input.text = "";
            this.buttonHandler("btnCommands");
        }

        private function onClickYAxis(mouseEvent:MouseEvent):void
        {
            if (((this.xAxis.input.text == "") || (this.yAxis.input.text == "")))
            {
                this.game.MsgBox.notify("Must enter both Coordinate X and Y.");
                return;
            };
            if (((isNaN(Number(this.xAxis.input.text))) || (isNaN(Number(this.yAxis.input.text)))))
            {
                this.game.MsgBox.notify("Must enter a numeric value.");
                return;
            };
            this.addCommandItem("MoveU", {
                "tx":this.xAxis.input.text,
                "ty":this.yAxis.input.text
            });
            this.xAxis.input.text = "";
            this.buttonHandler("btnCommands");
        }

        private function onClickMap(mouseEvent:MouseEvent):void
        {
            if (this.map.input.text == "")
            {
                this.game.MsgBox.notify("Must Enter a map name.");
                return;
            };
            this.addCommandItem("JoinR", this.map.input.text);
            this.map.input.text = "";
            this.buttonHandler("btnCommands");
        }

        private function onClickPad(mouseEvent:MouseEvent):void
        {
            if (((this.frame.input.text == "") || (this.pad.input.text == "")))
            {
                this.game.MsgBox.notify("Must enter both Frame and Pad.");
                return;
            };
            this.addCommandItem("MoveC", {
                "cell":this.frame.input.text,
                "pad":this.pad.input.text
            });
            this.frame.input.text = "";
            this.pad.input.text = "";
            this.buttonHandler("btnCommands");
        }

        private function onMouseEventClick(mouseEvent:MouseEvent):void
        {
            this.buttonHandler(mouseEvent.currentTarget.name);
        }

        private function onBotFileSelected(event:Event):void
        {
            Game.root.chatF.pushMsg("server", "onBotFileSelected", "SERVER", "", 0);
            try
            {
                this.botFile.addEventListener(Event.COMPLETE, this.onBotFileLoaded);
                this.botFile.load();
            }
            catch(e:Error)
            {
                Game.root.chatF.pushMsg("server", e.getStackTrace(), "SERVER", "", 0);
            };
        }

        private function onFileLoadError(event:IOErrorEvent):void
        {
            Game.root.chatF.pushMsg("server", event.text, "SERVER", "", 0);
            Game.root.chatF.pushMsg("server", event.type, "SERVER", "", 0);
            Game.root.chatF.pushMsg("server", event.toString(), "SERVER", "", 0);
        }

        private function onBotFileLoaded(event:Event):void
        {
            var botData:ByteArray;
            var botProperties:* = undefined;
            Game.root.chatF.pushMsg("server", "onBotFileLoaded", "SERVER", "", 0);
            try
            {
                botData = event.target.data;
                botProperties = botData.readObject();
                BotController.data.skip = (botProperties.skip as Boolean);
                BotController.data.pickup = (botProperties.pickup as Boolean);
                BotController.data.reject = (botProperties.reject as Boolean);
                BotController.data.energy = (botProperties.energy as Boolean);
                BotController.data.relogin = (botProperties.relogin as Boolean);
                BotController.data.commands = (botData.readObject() as Array);
                BotController.data.skills = (botData.readObject() as Array);
                BotController.data.quests = (botData.readObject() as Array);
                BotController.data.items = (botData.readObject() as Array);
                this.initData("Load");
                BotController.stop();
            }
            catch(e:Error)
            {
                Game.root.chatF.pushMsg("server", e.getStackTrace(), "SERVER", "", 0);
            };
        }


    }
}//package Main.Bot

