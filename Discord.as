// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Discord

package 
{
    import flash.display.MovieClip;

    public class Discord extends MovieClip 
    {

        public var rootClass:Game;

        public function Discord(root:Game)
        {
            this.rootClass = root;
        }

        public function update(_type:String):void
        {
            var caption:String;
            var request:Object = {};
            if (this.rootClass.loaderDomain == null)
            {
                return;
            };
            switch (_type)
            {
                case "status":
                    if (this.rootClass.world.myAvatar == null)
                    {
                        return;
                    };
                    request = {
                        "Command":"initPlayer",
                        "Properties":{
                            "Name":this.rootClass.world.myAvatar.objData.strUsername,
                            "Level":this.rootClass.world.myAvatar.objData.intLevel,
                            "Status":this.getAvatarStatus(),
                            "Server":this.rootClass.objServerInfo.sName
                        },
                        "Room":{
                            "Room":this.rootClass.strToProperCase(this.rootClass.world.strAreaName),
                            "Users":this.rootClass.world.areaUsers.length,
                            "Cap":this.rootClass.world.strAreaCap
                        }
                    };
                    break;
                case "stage":
                    switch (this.rootClass.mcLogin.currentLabel)
                    {
                        default:
                            caption = this.rootClass.mcLogin.currentLabel;
                            break;
                        case "Init":
                            caption = "Login Screen";
                            break;
                        case "Characters":
                            caption = "Character Select";
                    };
                    request = {
                        "Command":"stageUpdate",
                        "Frame":caption
                    };
                    break;
                case "destroy":
                    request = {"Command":"destroyPlayer"};
                    break;
            };
            this.rootClass.loaderDomain.setDiscordStatus(request);
        }

        public function getAvatarStatus():String
        {
            var avatarLeaf:* = this.rootClass.world.getUoLeafById(this.rootClass.world.myAvatar.uid);
            if (avatarLeaf == null)
            {
                return ("Loading");
            };
            if (avatarLeaf.vend)
            {
                return ("Vending");
            };
            if (avatarLeaf.afk)
            {
                return ("Idle");
            };
            return ("Playing");
        }


    }
}//package 

