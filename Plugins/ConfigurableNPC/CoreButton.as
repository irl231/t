// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.ConfigurableNPC.CoreButton

package Plugins.ConfigurableNPC
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.net.*;

    public class CoreButton extends MovieClip 
    {

        public var txtName:TextField;
        public var txtSubtitle:TextField;
        public var btnButton:SimpleButton;
        public var rootClass:Game = Game.root;
        private var sName:String;
        private var sNameColor:String;
        private var sSubtitle:String;
        private var sSubtitleColor:String;
        private var sAction:String;
        private var sValue:*;
        private var sIcon:String;

        public function CoreButton(sName:String="", sNameColor:String="", sSubtitle:String="", sSubtitleColor:String="", sAction:String="", sValue:*=null, sIcon:String="")
        {
            this.Name = sName;
            this.NameColor = sNameColor;
            this.Subtitle = sSubtitle;
            this.SubtitleColor = sSubtitleColor;
            this.Action = sAction;
            this.Value = sValue;
        }

        public function get Name():String
        {
            return (this.sName);
        }

        public function set Name(value:String):*
        {
            this.sName = value;
        }

        public function get NameColor():String
        {
            return (this.sNameColor);
        }

        public function set NameColor(value:String):*
        {
            this.sNameColor = value;
            this.txtName.htmlText = (((("<font color='#" + value) + "'>") + this.Name) + "</font>");
            this.txtName.mouseEnabled = false;
        }

        public function get Subtitle():String
        {
            return (this.sSubtitle);
        }

        public function set Subtitle(value:String):*
        {
            this.sSubtitle = value;
        }

        public function get SubtitleColor():String
        {
            return (this.sSubtitleColor);
        }

        public function set SubtitleColor(value:String):*
        {
            this.sSubtitleColor = value;
            this.txtSubtitle.htmlText = (((("<font color='#" + value) + "'>") + this.Subtitle.toUpperCase()) + "</font>");
            this.txtSubtitle.mouseEnabled = false;
        }

        public function get Action():String
        {
            return (this.sAction);
        }

        public function set Action(value:String):*
        {
            this.sAction = value;
            this.btnButton.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        public function get Value():*
        {
            return (this.sValue);
        }

        public function set Value(value:*):*
        {
            this.sValue = value;
        }

        public function get Icon():String
        {
            return (this.sIcon);
        }

        public function onClick(event:MouseEvent):void
        {
            var join:Array;
            var frame:String;
            var pad:String;
            switch (this.Action)
            {
                case "Shop":
                    this.rootClass.world.sendLoadShopRequest(this.Value);
                    break;
                case "HairShop":
                    this.rootClass.world.sendLoadHairShopRequest(this.Value);
                    break;
                case "Map":
                    join = this.Value.split("|");
                    frame = ((join[1]) ? join[1] : "Enter");
                    pad = ((join[2]) ? join[2] : "Spawn");
                    if (join[0] == "same_room")
                    {
                        this.rootClass.world.moveToCell(frame, pad);
                        return;
                    };
                    this.rootClass.world.gotoTown(join[0], frame, pad);
                    break;
                case "Quest":
                    this.rootClass.world.showQuests(this.Value, "q");
                    break;
                case "Link":
                    navigateToURL(new URLRequest(this.Value), "_blank");
                    break;
                case "Auction":
                    this.rootClass.toggleAuction();
                    break;
                case "Bank":
                    this.rootClass.world.toggleBank();
                    break;
                case "Guild":
                    this.rootClass.toggleGuildPanel();
                    break;
                case "Cook":
                    this.rootClass.toggleCookingPanel();
                    break;
                case "Function":
                    var _local_5:* = this.rootClass;
                    (_local_5[this.Value]());
                    break;
                case "Chat":
                    this.rootClass.chatF.submitMsg(this.Value, this.rootClass.chatF.chn.cur.typ, this.rootClass.chatF.pmNm);
                    break;
                case "GuildList":
                    this.rootClass.toggleGuildList();
                    break;
                case "Bagspace":
                    this.rootClass.toggleBuyHousePanel();
                    break;
                case "Relationship":
                    this.rootClass.toggleRelationship();
                    break;
                case "Drop":
                    this.rootClass.world.getMapItem(this.Value);
                    break;
                case "WorldBoss":
                    this.rootClass.toggleWorldBossBoard();
                    break;
                case "ShowAttribute":
                    GuildPanelRewrite(this.rootClass.ui.mcPopup.GuildRewrite).showAttribute(this.Value);
                    break;
                case "":
                    return;
                default:
                    this.rootClass.MsgBox.notify("Action is not yet implemented.");
            };
        }


    }
}//package Plugins.ConfigurableNPC

