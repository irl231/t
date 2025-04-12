// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.UIController

package Main.Controller
{
    import flash.filters.GlowFilter;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.*;
    import flash.filters.*;
    import Main.Menu.*;
    import Main.Aqw.Outfit.*;
    import Main.BattlePass.*;
    import Main.Chronicle.*;
    import Main.Chat.*;
    import Main.WorldBoss.*;
    import Main.Spectate.*;
    import Main.Stats.*;

    public class UIController 
    {

        private static const glowFilter:GlowFilter = new GlowFilter(0xFFFFFF, 1, 8, 8, 2, 1, false, false);


        public static function addGlow(movieClip:MovieClip):void
        {
            movieClip.filters = [glowFilter];
        }

        public static function show(name:String, sound:Boolean=true):DisplayObject
        {
            var frame:DisplayObject;
            Game.root.gameMenu.close();
            frame = null;
            switch (name)
            {
                case "mobile_menu":
                    frame = new MenuPanel();
                    frame.x = 565.45;
                    frame.y = 0;
                    break;
                case "chat_panel":
                    frame = new ChatPanel();
                    frame.x = 0;
                    frame.y = 0;
                    break;
                case "npc_tool":
                    frame = new mcNPCTool();
                    frame.x = 36.7;
                    frame.y = 157;
                    break;
                case "quest_frame":
                    frame = new QFrameMC();
                    frame.x = 0;
                    frame.y = 65;
                    break;
                case "quest_popup":
                    frame = new mcQuestpopup();
                    break;
                case "guild_slot":
                    frame = new GuildSlot();
                    break;
                case "boss_invite":
                    frame = new WorldBossInvite();
                    frame.x = 350;
                    frame.y = 150;
                    break;
                case "chronicle":
                    frame = new ChroniclePanel();
                    frame.x = 265;
                    frame.y = 106;
                    break;
                case "boss_board":
                    frame = new WorldBossPanel();
                    frame.x = -2.75;
                    frame.y = 42.9;
                    break;
                case "stats_panel":
                    frame = new StatsPanel();
                    frame.x = 480;
                    frame.y = 275;
                    break;
                case "battle_pass":
                    frame = new BattlePassPanel();
                    frame.x = 0;
                    frame.y = 0;
                    break;
                case "spectate":
                    frame = new SpectatePanel();
                    frame.x = 666;
                    frame.y = 108;
                    break;
                case "outfit":
                    frame = new OutfitPanel();
                    frame.x = 0;
                    frame.y = 0;
                    break;
                default:
                    return (null);
            };
            frame.name = name;
            return (DisplayObjectContainer(Game.root.ui.framesTrash).addChild(frame));
        }

        public static function close(name:String, sound:Boolean=true):void
        {
            var frames:DisplayObjectContainer;
            if (Game.root.ui == null)
            {
                return;
            };
            if (sound)
            {
            };
            frames = DisplayObjectContainer(Game.root.ui.framesTrash);
            var displayObject:DisplayObject = frames.getChildByName(name);
            if (displayObject != null)
            {
                frames.removeChild(displayObject);
            };
        }

        public static function closeAll(sound:Boolean=false):void
        {
            var frames:DisplayObjectContainer;
            var i:int;
            var displayObject:DisplayObject;
            if (Game.root.ui == null)
            {
                return;
            };
            frames = DisplayObjectContainer(Game.root.ui.framesTrash);
            var numChildren:int = frames.numChildren;
            try
            {
                i = 0;
                while (i < numChildren)
                {
                    displayObject = frames.getChildAt(i);
                    if (("onClose" in displayObject))
                    {
                        Object(displayObject).onClose();
                    };
                    i = (i + 1);
                };
            }
            catch(e:RangeError)
            {
                trace(("Caught RangeError: " + e.message));
            };
        }

        public static function toggle(name:String):void
        {
            var displayObject:DisplayObject = UIController.getByName(name);
            if (displayObject == null)
            {
                UIController.show(name);
                return;
            };
            UIController.close(name);
        }

        public static function getByName(name:String):DisplayObject
        {
            var frames:DisplayObjectContainer;
            frames = DisplayObjectContainer(Game.root.ui.framesTrash);
            var displayObject:DisplayObject = frames.getChildByName(name);
            return (displayObject);
        }

        public static function getByNameOrShow(name:String):DisplayObject
        {
            var displayObject:DisplayObject = UIController.getByName(name);
            if (displayObject == null)
            {
                displayObject = UIController.show(name);
            };
            return (displayObject);
        }


    }
}//package Main.Controller

