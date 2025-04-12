// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Party.PartyPanelPortrait

package Main.Party
{
    import Main.UI.AbstractPortrait;
    import flash.display.MovieClip;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.*;
    import Main.Avatar.*;
    import flash.net.*;
    import Main.*;

    public class PartyPanelPortrait extends AbstractPortrait 
    {

        public var mcSlot:MovieClip;
        public var mcLeaderFeather:MovieClip;
        public var mcLeaderIcon:MovieClip;
        public var party:Object;
        public var data:Object;

        public function PartyPanelPortrait()
        {
            this.mcLeaderIcon.visible = false;
            strName.text = "";
            strLevel.text = "";
        }

        public function createMember(party:Object, data:Object):void
        {
            this.party = party;
            this.data = data;
            strName.text = data.strUsername;
            strLevel.text = data.intLevel;
            this.mcLeaderIcon.visible = (data.strUsername == party.leader);
            this.mcSlot.visible = false;
            this.createAvatar();
        }

        public function createAvatar():void
        {
            var urlRequest:URLRequest = new URLRequest(((Config.serverApiURL + "user/character/data/") + this.data.id));
            urlRequest.method = URLRequestMethod.GET;
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, this.onAvatarComplete);
            urlLoader.load(urlRequest);
        }

        public function onAvatarComplete(event:Event):void
        {
            var userData:Object = JSON.parse(event.target.data);
            var avatar:Avatar = new Avatar(Game.root);
            var avatarMC:AvatarMC = new AvatarMC();
            avatar.isMyAvatar = false;
            avatar.pMC = avatarMC;
            avatar.objData = userData;
            avatar.dataLeaf.showEntity = true;
            avatar.dataLeaf.showTitle = true;
            avatar.dataLeaf.showRune = true;
            avatar.dataLeaf.showCloak = true;
            avatar.dataLeaf.showHelm = (!(userData.eqp.he == null));
            avatar.dataLeaf.isAdopted = userData.isAdopted;
            avatarMC.pAV = avatar;
            AvatarUtil.showPortraitBox(avatar, this);
        }


    }
}//package Main.Party

