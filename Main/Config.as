// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Config

package Main
{
    public class Config 
    {

        public static const serverBaseURL:String = "https://astrista.com/";
        public static const serverCrossName:String = "Unified";
        public static const serverCrossBaseURL:String = "https://unified.pw/";
        public static const menuMarket:Function = function ():void
        {
            var data:Object = Config.getMap("join_market");
            Game.root.world.gotoTown(data.map, data.frame, data.cell);
        };
        public static const menuWorldBoss:Function = function ():void
        {
            var data:Object = Config.getMap("join_world_boss");
            Game.root.world.gotoTown(data.map, data.frame, data.cell);
        };
        public static const menuGuild:Function = function ():void
        {
            var data:Object = Config.getMap("join_guild");
            Game.root.world.gotoTown(data.map, data.frame, data.cell);
        };
        public static const menuMarry:Function = function ():void
        {
            Game.root.world.gotoTown(Config.getString("join_marry"), "Enter", "Spawn");
        };
        public static const serverApiURL:String = (serverBaseURL + "api/");
        public static const serverNormalGamefilesURL:String = (serverBaseURL + "gamefiles/");
        public static const serverStoreURL:String = (serverBaseURL + "store/");
        public static const serverFunctionsURL:String = (serverApiURL + "game/");
        public static const serverLoginFunctionURL:String = (serverFunctionsURL + "login");
        public static const serverSearchFunctionURL:String = (serverFunctionsURL + "profile");
        public static const serverAccountURL:String = (serverBaseURL + "account/");
        public static const serverRegisterURL:String = (serverBaseURL + "register");
        public static const serverSocialURL:String = (serverAccountURL + "social/");
        public static const serverRedirectURL:String = (serverBaseURL + "redirect/");
        public static const serverDiscordURL:String = (serverBaseURL + "discord");
        public static const serverProfileCharacterURL:String = (serverBaseURL + "char/");
        public static const serverRetrieveURL:String = (serverBaseURL + "recovery");
        public static const serverWikiURL:String = (serverBaseURL + "wiki/");
        public static const serverWikiQuestURL:String = (serverWikiURL + "quest/");
        public static const serverWikiItemURL:String = (serverWikiURL + "item/");
        public static const serverWikiMonsterURL:String = (serverWikiURL + "monster/");
        public static const serverWikiMapURL:String = (serverWikiURL + "map/");
        public static const serverWikiFactionURL:String = (serverWikiURL + "faction/");
        public static const serverWikiNpcURL:String = (serverWikiURL + "npc/");
        public static const serverMigrateURL:String = (serverBaseURL + "migrate/");
        public static const serverGrabberURL:String = (serverMigrateURL + "grabber/");
        public static const serverGrabberItemURL:String = (serverGrabberURL + "item/");
        public static const serverGuildImageURL:String = (serverApiURL + "image/guild/banner/");
        public static const serverEmojiImageURL:String = (serverApiURL + "image/emoji/");
        public static const serverPlayerImageURL:String = (serverApiURL + "image/avatar/player/chat/");
        public static const serverMainImageURL:String = (serverBaseURL + "api/image/assets/");
        public static const serverMapImageURL:String = (serverBaseURL + "api/image/assets/map/big/original/");
        public static var isDebug:Boolean = false;
        public static var isDebugNetwork:Boolean = false;
        public static var Data:Object = null;


        public static function debugToggle():void
        {
            Config.isDebug = (!(Config.isDebug));
            Config.isDebugNetwork = (!(Config.isDebugNetwork));
            if (Config.isDebug)
            {
                Game.root.chatF.pushMsg("warning", "Debug ON", "SERVER", "", 0);
            }
            else
            {
                Game.root.chatF.pushMsg("warning", "Debug OFF", "SERVER", "", 0);
            };
        }

        public static function getMap(key:String):Object
        {
            var value:Array = Data[key].split("|");
            return ({
                "map":value[0],
                "frame":value[1],
                "cell":value[2]
            });
        }

        public static function getString(key:String):String
        {
            return (Data[key]);
        }

        public static function getInt(key:String):int
        {
            return (parseInt(Data[key]));
        }

        public static function getBoolean(key:String):Boolean
        {
            return (Data[key] == "1");
        }

        public static function isCrossServer():Boolean
        {
            return ((Game.root.objServerInfo) && (Game.root.objServerInfo.Name == Config.serverCrossName));
        }

        public static function getLoadPath(request:String):String
        {
            return ((((isCrossServer()) ? serverCrossBaseURL : serverBaseURL) + "gamefiles/") + request.toLowerCase());
        }


    }
}//package Main

