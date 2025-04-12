// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Emoji.EmojiMC

package Main.Emoji
{
    import flash.display.MovieClip;
    import flash.utils.Dictionary;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import flash.utils.*;
    import Main.Controller.*;
    import Main.*;

    public class EmojiMC extends MovieClip 
    {

        public static var emojiCache:Dictionary = new Dictionary();

        public var game:Game = Game.root;
        public var btnToggle:MovieClip;
        public var mcScroll:MovieClip;
        public var mcMask:MovieClip;
        public var listEmoji:MovieClip;
        public var txtSearch:TextField;
        public var arrEmojis:Array = new Array();

        public function EmojiMC()
        {
            addFrameScript(0, this.hide, 1, this.show);
            this.btnToggle.buttonMode = true;
            this.btnToggle.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        public static function load(emoji:Object, callback:Function):Boolean
        {
            if (EmojiMC.emojiCache[emoji.File])
            {
                (callback(null));
                return (true);
            };
            LoadController.singleton.addLoadEmoji(emoji.File, "emoji", callback);
            return (false);
        }

        public static function display(point:Point, emoji:Object, height:Number, width:Number):Sprite
        {
            var instance:DisplayObject;
            var container:Sprite = new Sprite();
            var emojiMC:Class = Game.root.world.getClass(emoji.Linkage);
            if (emojiMC != null)
            {
                instance = new (emojiMC)();
                container.addChild(instance);
                container.buttonMode = true;
                container.name = emoji.Command;
                container.x = point.x;
                container.y = point.y;
                container.height = height;
                container.width = width;
            };
            return (container);
        }


        internal function hide():void
        {
            stop();
        }

        internal function show():void
        {
            stop();
            this.txtSearch.addEventListener(Event.CHANGE, function (event:Event):void
            {
                list();
            });
            this.list();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnToggle":
                    gotoAndStop(((currentLabel == "Hide") ? "Show" : "Hide"));
                    break;
            };
        }

        private function onEmojiClick(emoji:Object):void
        {
            switch (parent.name)
            {
                case "mcInterface":
                    this.game.ui.mcInterface.te.htmlText = (((((this.game.ui.mcInterface.te.htmlText + "<a href='emoji:") + emoji.id) + "'>&lt;") + emoji.Command) + "&gt;</a> ");
                    this.game.ui.mcInterface.te.htmlText.replace(Chat.regExpSPACE, " ");
                    this.game.chatF.openMsgEntry();
                    break;
            };
        }

        private function reset():*
        {
            new Scroll(this.mcScroll, this.listEmoji, this.mcMask, this.mcScroll.hit, this.mcScroll.h, this.mcScroll.b, false);
            this.listEmoji.y = -129.45;
            this.listEmoji.mask = this.mcMask;
        }

        private function list():void
        {
            var searchTerm:String;
            var emojis:Array = this.game.world.myAvatar.emojis;
            this.arrEmojis = emojis.concat();
            emojis.sortOn("Position", Array.NUMERIC);
            while (this.listEmoji.numChildren > 0)
            {
                this.listEmoji.removeChildAt(0);
            };
            searchTerm = this.txtSearch.text.toLowerCase();
            var filteredEmojis:Array = this.arrEmojis.filter(function (emoji:Object, index:int, array:Array):Boolean
            {
                return (emoji.Name.toLowerCase().indexOf(searchTerm) >= 0);
            });
            this.reset();
            var count:int;
            while (count < filteredEmojis.length)
            {
                ((function (count:int, emoji:Object):void
                {
                    load(emoji, function (event:Event):void
                    {
                        var point:* = undefined;
                        EmojiMC.emojiCache[emoji.File] = emoji;
                        point = new Point((((count % 6) * 30) + 3), (Math.floor((count / 6)) * 30));
                        var container:* = display(point, emoji, 25, 25);
                        listEmoji.addChild(container);
                        var currentRow:* = Math.floor((count / 6));
                        if (currentRow >= 4)
                        {
                            reset();
                        };
                        container.addEventListener(MouseEvent.CLICK, function (event:MouseEvent):void
                        {
                            onEmojiClick(emoji);
                        });
                        container.addEventListener(MouseEvent.MOUSE_OVER, function (event:MouseEvent):void
                        {
                            game.ui.ToolTip.openWith({"str":emoji.Name});
                        });
                        container.addEventListener(MouseEvent.MOUSE_OUT, function (event:MouseEvent):void
                        {
                            game.ui.ToolTip.close();
                        });
                    });
                })(count, filteredEmojis[count]));
                count = (count + 1);
            };
        }


    }
}//package Main.Emoji

