// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//CharacterPageMC

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.display.Loader;
    import flash.events.MouseEvent;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Avatar.*;
    import flash.net.*;
    import Main.*;
    import Game_fla.*;

    public class CharacterPageMC extends MovieClip 
    {

        public var txtClassName:TextField;
        public var txtWeapon:TextField;
        public var txtArmor:TextField;
        public var txtHelm:TextField;
        public var txtPet:TextField;
        public var txtCape:TextField;
        public var txtMisc:TextField;
        public var txtName:TextField;
        public var txtUsername:TextField;
        public var txtLevel:TextField;
        public var txtGuild:TextField;
        public var btnClose:SimpleButton;
        public var btnSearch:SimpleButton;
        public var btnProfile:MovieClip;
        public var mcAvatar:MovieClip;
        public var mcBanner:MovieClip;
        public var cntMask:MovieClip;
        private var imageLoader2:Loader;
        private var objData:Object;
        private var avatarMC:AvatarMC;

        public function CharacterPageMC()
        {
            addFrameScript(0, this.init, 1, this.search, 2, this.profile);
        }

        private function clear():void
        {
            if (this.avatarMC != null)
            {
                this.avatarMC.fClose();
                this.avatarMC = null;
            };
        }

        private function init():void
        {
            this.clear();
            if (mcPopup_323(parent).fData.strUsername != "")
            {
                this.onSearchClick(mcPopup_323(parent).fData.strUsername);
                return;
            };
            gotoAndStop("Search");
        }

        private function search():void
        {
            this.clear();
            this.btnSearch.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.fClose, false, 0, true);
            stop();
        }

        private function profile():void
        {
            this.clear();
            this.avatarMC = AvatarUtil.createAvatar("character_page", this.mcAvatar, this.objData);
            this.avatarMC.scaleX = (this.avatarMC.scaleX * -1);
            this.avatarMC.mask = this.cntMask;
            if (this.avatarMC.pAV.petMC != null)
            {
                this.avatarMC.pAV.petMC.scaleY = (this.avatarMC.pAV.petMC.scaleY * -1);
                this.avatarMC.pAV.petMC.scaleX = (this.avatarMC.pAV.petMC.scaleX * -1);
            };
            this.txtUsername.htmlText = this.objData.strUsername;
            this.txtLevel.htmlText = this.objData.intLevel;
            if (this.objData.guild == undefined)
            {
                this.txtGuild.htmlText = "No Guild";
                this.mcBanner.visible = false;
            }
            else
            {
                this.txtGuild.htmlText = (((("<font color='#" + this.objData.guild.Color.substring(2)) + "'>") + this.objData.guild.Name) + "</font>");
                this.imageLoader2 = new Loader();
                this.imageLoader2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onGuildImageCompleteLoad, false, 0, true);
                this.imageLoader2.load(new URLRequest(Game.root.getGuildLoadPath(this.objData.guild.id)));
            };
            this.txtWeapon.htmlText = ((this.objData.eqp.Weapon == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + this.objData.eqp.Weapon.ItemID) + "' target='_blank'>") + this.objData.eqp.Weapon.sName) + "</a>"));
            this.txtArmor.htmlText = ((this.objData.eqp.co == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + this.objData.eqp.co.ItemID) + "' target='_blank'>") + this.objData.eqp.co.sName) + "</a>"));
            this.txtClassName.htmlText = ((this.objData.eqp.ar == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + this.objData.eqp.ar.ItemID) + "' target='_blank'>") + this.objData.eqp.ar.sName) + "</a>"));
            this.txtHelm.htmlText = ((this.objData.eqp.he == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + this.objData.eqp.he.ItemID) + "' target='_blank'>") + this.objData.eqp.he.sName) + "</a>"));
            this.txtCape.htmlText = ((this.objData.eqp.ba == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + this.objData.eqp.ba.ItemID) + "' target='_blank'>") + this.objData.eqp.ba.sName) + "</a>"));
            this.txtMisc.htmlText = ((this.objData.eqp.mi == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + this.objData.eqp.mi.ItemID) + "' target='_blank'>") + this.objData.eqp.mi.sName) + "</a>"));
            this.txtPet.htmlText = ((this.objData.eqp.pe == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + this.objData.eqp.pe.ItemID) + "' target='_blank'>") + this.objData.eqp.pe.sName) + "</a>"));
            this.btnProfile.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.fClose, false, 0, true);
            stop();
        }

        public function fClose(event:MouseEvent=null):void
        {
            this.clear();
            mcPopup_323(parent).onClose();
        }

        private function onSearchClick(strUsername:String):void
        {
            var variables:URLVariables = new URLVariables();
            variables.strUsername = strUsername;
            variables._token = Game.root.params.token;
            var request:URLRequest = new URLRequest(Config.serverSearchFunctionURL);
            request.data = variables;
            request.method = URLRequestMethod.POST;
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(IOErrorEvent.IO_ERROR, this.onSearchError, false, 0, true);
            loader.addEventListener(Event.COMPLETE, this.onSearchComplete, false, 0, true);
            loader.load(request);
        }

        public function onGuildImageCompleteLoad(event:Event):void
        {
            this.mcBanner.addChild(this.imageLoader2);
            var maxSize:Number = 20.9;
            var scale:Number = Math.min((maxSize / this.imageLoader2.width), (maxSize / this.imageLoader2.height));
            this.imageLoader2.width = (this.imageLoader2.width * scale);
            this.imageLoader2.height = (this.imageLoader2.height * scale);
            this.imageLoader2.x = 0;
            this.imageLoader2.y = 0;
        }

        public function onSearchComplete(event:Event):void
        {
            var data:Object = JSON.parse(event.target.data);
            if (data.status != "Success")
            {
                Game.root.MsgBox.notify(data.strReason);
                return;
            };
            this.objData = data.objData;
            gotoAndStop("Profile");
        }

        private function onSearchError(errorEvent:IOErrorEvent):void
        {
            Game.root.MsgBox.notify(("Unable to load URL: " + errorEvent["text"]));
        }

        private function onClick(event:MouseEvent):void
        {
            var strUsername:String;
            switch (event.currentTarget.name)
            {
                case "btnResearch":
                    gotoAndStop("Search");
                    break;
                case "btnProfile":
                    navigateToURL(new URLRequest((Config.serverProfileCharacterURL + this.objData.strUsername)), "_blank");
                    break;
                case "btnSearch":
                    strUsername = this.txtName.text;
                    if (strUsername == "")
                    {
                        Game.root.MsgBox.notify("Please input a valid username.");
                        return;
                    };
                    this.onSearchClick(strUsername);
                    break;
            };
        }


    }
}//package 

