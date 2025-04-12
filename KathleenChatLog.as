// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//KathleenChatLog

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.*;

    public dynamic class KathleenChatLog extends MovieClip 
    {

        public var btnAll:SimpleButton;
        public var btnZone:SimpleButton;
        public var btnWorld:SimpleButton;
        public var btnParty:SimpleButton;
        public var btnGuild:SimpleButton;
        public var btnTrade:SimpleButton;
        public var channel:int = 1;

        public function KathleenChatLog()
        {
            addFrameScript(0, this.frame1);
            Game.root.chatLog = this;
        }

        public function changeChannel(newChannel:int):void
        {
            this.channel = newChannel;
            switch (this.channel)
            {
                case 1:
                    Game.root.chatF.pushMsg("server", "You have switched to general channel.", "SERVER", "", 0);
                    Game.root.chatF.mode = 1;
                    if (Game.root.chatF.chn.zone.act)
                    {
                        Game.root.chatF.chn.cur = Game.root.chatF.chn.zone;
                        Game.root.chatF.chn.lastPublic = Game.root.chatF.chn.zone;
                        Game.root.ui.mcInterface.te.text = Game.root.ui.mcInterface.te.text.substr((Game.root.ui.mcInterface.te.text.split(" ")[0].substr(1).length + 2));
                    };
                    Game.root.chatF.formatMsgEntry("");
                    Game.root.chatF.updateMsgEntry();
                    break;
                case 2:
                    Game.root.chatF.pushMsg("server", "You have switched to zone channel", "SERVER", "", 0);
                    Game.root.chatF.mode = 2;
                    if (Game.root.chatF.chn.zone.act)
                    {
                        Game.root.chatF.chn.cur = Game.root.chatF.chn.zone;
                        Game.root.chatF.chn.lastPublic = Game.root.chatF.chn.zone;
                        Game.root.ui.mcInterface.te.text = Game.root.ui.mcInterface.te.text.substr((Game.root.ui.mcInterface.te.text.split(" ")[0].substr(1).length + 2));
                    };
                    Game.root.chatF.formatMsgEntry("");
                    Game.root.chatF.updateMsgEntry();
                    break;
                case 3:
                    Game.root.chatF.pushMsg("server", "You have switched to world channel", "SERVER", "", 0);
                    Game.root.chatF.mode = 3;
                    Game.root.chatF.chn.cur = Game.root.chatF.chn.world;
                    Game.root.chatF.chn.lastPublic = Game.root.chatF.chn.world;
                    Game.root.ui.mcInterface.te.text = Game.root.ui.mcInterface.te.text.substr(5);
                    Game.root.chatF.formatMsgEntry("");
                    Game.root.chatF.updateMsgEntry();
                    break;
                case 4:
                    Game.root.chatF.pushMsg("server", "You have switched to party channel", "SERVER", "", 0);
                    Game.root.chatF.mode = 4;
                    Game.root.chatF.chn.cur = Game.root.chatF.chn.party;
                    Game.root.chatF.chn.lastPublic = Game.root.chatF.chn.party;
                    Game.root.ui.mcInterface.te.text = Game.root.ui.mcInterface.te.text.substr(5);
                    Game.root.chatF.formatMsgEntry("");
                    Game.root.chatF.updateMsgEntry();
                    break;
                case 5:
                    Game.root.chatF.pushMsg("server", "You have switched to guild channel", "SERVER", "", 0);
                    Game.root.chatF.mode = 5;
                    Game.root.chatF.chn.cur = Game.root.chatF.chn.guild;
                    Game.root.chatF.chn.lastPublic = Game.root.chatF.chn.guild;
                    Game.root.ui.mcInterface.te.text = Game.root.ui.mcInterface.te.text.substr(5);
                    Game.root.chatF.formatMsgEntry("");
                    Game.root.chatF.updateMsgEntry();
                    break;
                case 6:
                    Game.root.chatF.pushMsg("server", "You have switched to trade channel", "SERVER", "", 0);
                    Game.root.chatF.mode = 6;
                    Game.root.chatF.chn.cur = Game.root.chatF.chn.trade;
                    Game.root.chatF.chn.lastPublic = Game.root.chatF.chn.trade;
                    Game.root.ui.mcInterface.te.text = Game.root.ui.mcInterface.te.text.substr(5);
                    Game.root.chatF.formatMsgEntry("");
                    Game.root.chatF.updateMsgEntry();
                    break;
                case 7:
                    Game.root.chatF.pushMsg("server", "You have switched to cross server channel", "SERVER", "", 0);
                    Game.root.chatF.mode = 7;
                    Game.root.chatF.chn.cur = Game.root.chatF.chn.crosschat;
                    Game.root.chatF.chn.lastPublic = Game.root.chatF.chn.crosschat;
                    Game.root.ui.mcInterface.te.text = Game.root.ui.mcInterface.te.text.substr(5);
                    Game.root.chatF.formatMsgEntry("");
                    Game.root.chatF.updateMsgEntry();
                    break;
            };
        }

        public function onMouseClick(btnEvent:MouseEvent):void
        {
            switch (btnEvent.currentTarget.name)
            {
                case "btnAll":
                    this.changeChannel(1);
                    break;
                case "btnZone":
                    this.changeChannel(2);
                    break;
                case "btnWorld":
                    this.changeChannel(3);
                    break;
                case "btnParty":
                    this.changeChannel(4);
                    break;
                case "btnGuild":
                    this.changeChannel(5);
                    break;
                case "btnTrade":
                    this.changeChannel(6);
                    break;
                case "btnCross":
                    this.changeChannel(7);
                    break;
            };
        }

        private function frame1():void
        {
            this.btnAll.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.btnZone.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.btnWorld.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.btnParty.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.btnGuild.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.btnTrade.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            stop();
        }


    }
}//package 

