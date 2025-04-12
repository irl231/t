// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//CouplePageMC

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
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

    public class CouplePageMC extends MovieClip 
    {

        public var btnClose:SimpleButton;
        public var btnDivorce:SimpleButton;
        public var txtCouple:TextField;
        public var txtDivorce:TextField;
        public var txtTitle1:TextField;
        public var mcMap:MovieClip;
        public var mcCharacter:MovieClip;
        public var mcCharacterDisplay:MovieClip;
        public var mcPartner:MovieClip;
        public var mcPartnerDisplay:MovieClip;
        public var mcFeather:MovieClip;
        public var cntMask:MovieClip;
        public var avatar:Avatar;
        private var imageLoader1:Loader;
        private var imageLoader2:Loader;
        private var mainCharacter:String;
        private var avatarMC1:AvatarMC;
        private var avatarMC2:AvatarMC;

        public function CouplePageMC()
        {
            addFrameScript(0, this.profile);
        }

        private function clear():void
        {
            if (this.avatarMC1 != null)
            {
                this.avatarMC1.fClose();
                this.avatarMC1 = null;
            };
            if (this.avatarMC2 != null)
            {
                this.avatarMC2.fClose();
                this.avatarMC2 = null;
            };
        }

        private function profile():void
        {
            this.clear();
            this.mainCharacter = mcPopup_323(parent).fData.strUsername;
            this.avatar = Game.root.world.getAvatarByUserName(this.mainCharacter);
            if (this.avatar == null)
            {
                Game.root.MsgBox.notify("Player not found!");
                this.fClose();
                return;
            };
            if (this.avatar.objData.partner == null)
            {
                Game.root.MsgBox.notify("This player does not have any relationship!");
                this.fClose();
                return;
            };
            this.onSearchClick(this.mainCharacter);
            this.onSearchClick(((this.mainCharacter.toLowerCase() != this.avatar.objData.partner.PartnerName.toLowerCase()) ? this.avatar.objData.partner.PartnerName : this.avatar.objData.partner.UserName));
            this.txtTitle1.text = (((this.avatar.objData.partner.UserName + " and ") + this.avatar.objData.partner.PartnerName) + "'s Bond");
            this.btnClose.addEventListener(MouseEvent.CLICK, this.fClose, false, 0, true);
            this.btnDivorce.addEventListener(MouseEvent.CLICK, this.onClickDivorce, false, 0, true);
            this.txtDivorce.visible = (this.btnDivorce.visible = (Game.root.world.myAvatar.objData.strUsername.toLowerCase() == this.mainCharacter.toLowerCase()));
            this.txtDivorce.mouseEnabled = false;
            this.imageLoader1 = new Loader();
            this.imageLoader1.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onBackgroundImageCompleteLoad, false, 0, true);
            this.imageLoader1.load(new URLRequest((Config.serverMainImageURL + "map/original/105?frame=room3")));
            stop();
        }

        public function fClose(event:MouseEvent=null):void
        {
            this.clear();
            mcPopup_323(parent).onClose();
        }

        private function onViewProfile(username:String):Function
        {
            return (function (event:MouseEvent):void
            {
                navigateToURL(new URLRequest((Config.serverProfileCharacterURL + username)), "_blank");
            });
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

        public function onSearchComplete(event:Event):void
        {
            var data:Object = JSON.parse(event.target.data);
            if (data.status != "Success")
            {
                Game.root.MsgBox.notify(data.strReason);
                return;
            };
            if (this.mainCharacter.toLowerCase() == data.objData.strUsername.toLowerCase())
            {
                this.avatarMC1 = AvatarUtil.createAvatar("couple_page", this.mcCharacter, data.objData);
                this.avatarMC1.scale(2.5);
                this.avatarMC1.scaleX = (this.avatarMC1.scaleX * ((this.avatarMC1.parent != this.mcCharacter) ? -1 : 1));
                if (this.avatarMC1.parent == this.mcCharacter)
                {
                    this.avatarMC1.mcChar.gotoAndPlay("Kneel");
                };
            }
            else
            {
                this.avatarMC2 = AvatarUtil.createAvatar("couple_page", this.mcPartner, data.objData);
                this.avatarMC2.scale(2.5);
                this.avatarMC2.scaleX = (this.avatarMC2.scaleX * ((this.avatarMC2.parent != this.mcCharacter) ? -1 : 1));
                if (this.avatarMC2.parent == this.mcCharacter)
                {
                    this.avatarMC2.mcChar.gotoAndPlay("Kneel");
                };
            };
            var mcDisplay:MovieClip = ((this.mainCharacter.toLowerCase() == data.objData.strUsername.toLowerCase()) ? this.mcCharacterDisplay : this.mcPartnerDisplay);
            mcDisplay.txtUsername.htmlText = data.objData.strUsername;
            mcDisplay.txtLevel.htmlText = data.objData.intLevel;
            mcDisplay.txtWeapon.htmlText = ((data.objData.eqp.Weapon == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + data.objData.eqp.Weapon.ItemID) + "' target='_blank'>") + data.objData.eqp.Weapon.sName) + "</a>"));
            mcDisplay.txtArmor.htmlText = ((data.objData.eqp.co == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + data.objData.eqp.co.ItemID) + "' target='_blank'>") + data.objData.eqp.co.sName) + "</a>"));
            mcDisplay.txtClassName.htmlText = ((data.objData.eqp.ar == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + data.objData.eqp.ar.ItemID) + "' target='_blank'>") + data.objData.eqp.ar.sName) + "</a>"));
            mcDisplay.txtHelm.htmlText = ((data.objData.eqp.he == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + data.objData.eqp.he.ItemID) + "' target='_blank'>") + data.objData.eqp.he.sName) + "</a>"));
            mcDisplay.txtCape.htmlText = ((data.objData.eqp.ba == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + data.objData.eqp.ba.ItemID) + "' target='_blank'>") + data.objData.eqp.ba.sName) + "</a>"));
            mcDisplay.txtMisc.htmlText = ((data.objData.eqp.mi == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + data.objData.eqp.mi.ItemID) + "' target='_blank'>") + data.objData.eqp.mi.sName) + "</a>"));
            mcDisplay.txtPet.htmlText = ((data.objData.eqp.pe == null) ? "None" : ((((("<a href='" + Config.serverWikiItemURL) + data.objData.eqp.pe.ItemID) + "' target='_blank'>") + data.objData.eqp.pe.sName) + "</a>"));
            mcDisplay.btnProfile.addEventListener(MouseEvent.CLICK, this.onViewProfile(data.objData.strUsername), false, 0, true);
        }

        private function onSearchError(errorEvent:IOErrorEvent):void
        {
            Game.root.MsgBox.notify(("Unable to load URL: " + errorEvent["text"]));
        }

        public function onBackgroundImageCompleteLoad(event:Event):void
        {
            this.mcMap.addChild(this.imageLoader1);
            this.mcMap.scaleX = (this.mcMap.scaleY = (this.cntMask.height / this.mcMap.height));
            this.mcMap.x = ((this.cntMask.width - this.mcMap.width) / 2);
        }

        private function onClickDivorce(event:MouseEvent):void
        {
            MainController.modal("Do you want to Divorce?", Game.root.world.divorceMarry, {}, "red,medium", "dual");
        }


    }
}//package 

