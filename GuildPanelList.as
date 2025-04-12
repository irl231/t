// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildPanelList

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.display.Loader;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.net.*;

    public class GuildPanelList extends MovieClip 
    {

        public var txtTitle:TextField;
        public var txtTitle2:TextField;
        public var txtGuildName:TextField;
        public var txtDescription:TextField;
        public var btnClose:SimpleButton;
        public var maskGuild:MovieClip;
        public var listGuild:MovieClip;
        public var mcPortrait:MovieClip;
        public var imageLoader:Loader = new Loader();
        public var rootClass:Game = Game.root;
        public var scrollGuild:LPFElementScrollBar;
        public var selectedGuild:MovieClip = null;
        public var mcPreloader:MovieClip;
        public var pageId:int = 1;
        public var nameFilter:String = "";
        public var paginationGuild:MovieClip;
        public var bg:MovieClip;
        public var txtSearch:TextField;
        public var btnSearch:SimpleButton;
        public var btnJoin:SimpleButton;

        public function GuildPanelList()
        {
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.refreshData();
        }

        private static function onOver(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnGuild":
                    event.currentTarget.bg.alpha = 0.3;
                    break;
            };
        }

        private static function onOut(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnGuild":
                    event.currentTarget.bg.alpha = 0;
                    break;
            };
        }


        public function refreshData():void
        {
            this.txtTitle.text = "Preview";
            this.txtTitle2.text = "Guild List";
            this.listGuild.mask = this.maskGuild;
            this.rootClass.world.loadGuildList(this.nameFilter, this.pageId);
            this.btnSearch.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnJoin.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        private function loadGuildImage(iID:int):void
        {
            var request:URLRequest;
            request = new URLRequest(this.rootClass.getGuildLoadPath(iID));
            this.mcPreloader.visible = true;
            this.imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function (event:*):void
            {
                var percent:int = int(Math.floor(((event.bytesLoaded / event.bytesTotal) * 100)));
                mcPreloader.mcPct.text = (percent + "%");
            });
            this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:*):void
            {
                mcPreloader.visible = false;
                rootClass.onRemoveChildrens(mcPortrait.icon);
                mcPortrait.icon.addChild(imageLoader);
                mcPortrait.icon.height = 120;
                mcPortrait.icon.width = 190;
            });
            this.imageLoader.load(request);
        }

        public function distributeList(data:*):void
        {
            var guild:Object;
            var start:*;
            var element:GuildListElement;
            this.rootClass.onRemoveChildrens(this.listGuild);
            var position:int;
            for each (guild in data.guilds)
            {
                element = new GuildListElement(guild.id, guild.Name, guild.Description, guild.MOTD, guild.Leader, guild.Level, guild.ul, guild.MaxMembers, guild.Status);
                element.x = 0;
                element.y = position;
                element.name = "btnGuild";
                element.addEventListener(MouseEvent.MOUSE_OVER, onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, onOut);
                element.addEventListener(MouseEvent.CLICK, this.onClick);
                element.bg.alpha = 0;
                element.buttonMode = true;
                if (position == 0)
                {
                    this.displayGuild(element);
                };
                position = (position + 36);
                this.listGuild.addChild(element);
            };
            start = (((data.pageCurrent + 7) >= data.pageCount) ? (data.pageCount - 7) : data.pageCurrent);
            var end:* = (((data.pageCurrent + 7) >= data.pageCount) ? data.pageCount : (data.pageCurrent + 7));
            this.paginationGuild.display(start, 1, data.pageCount, 5, end);
            this.configureScroll(this.listGuild, this.maskGuild, this.scrollGuild);
        }

        private function configureScroll(list:MovieClip, Mask:MovieClip, scroll:MovieClip):void
        {
            list.mask = Mask;
            list.y = 102.3;
            scroll.hit.height = scroll.b.height;
            scroll.hit.alpha = 0;
            scroll.fOpen({
                "subject":list,
                "subjectMask":Mask,
                "reset":true
            });
            if (!list.hasEventListener(MouseEvent.MOUSE_WHEEL))
            {
                list.addEventListener(MouseEvent.MOUSE_WHEEL, this.onWheel(scroll));
            };
            if (!scroll.hasEventListener(MouseEvent.MOUSE_WHEEL))
            {
                scroll.addEventListener(MouseEvent.MOUSE_WHEEL, this.onWheel(scroll));
            };
        }

        private function onWheel(scroll:MovieClip):Function
        {
            return (function (e:Event):void
            {
                var j:*;
                if (e.delta <= 0)
                {
                    j = 0;
                    while (j < (e.delta * -1))
                    {
                        MovieClip(scroll).a2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        j++;
                    };
                    return;
                };
                var oldY:* = scroll.h.y;
                var i:* = 0;
                while (i < e.delta)
                {
                    MovieClip(scroll).a1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    i++;
                };
                if (oldY == scroll.h.y)
                {
                    scroll.h.y = (scroll.h.y - (e.delta * 1.1));
                    if ((scroll.h.y + scroll.h.height) > scroll.b.height)
                    {
                        scroll.h.y = int((scroll.b.height - scroll.h.height));
                    };
                    if (scroll.h.y < 0)
                    {
                        scroll.h.y = 0;
                    };
                };
            });
        }

        public function onClick(event:MouseEvent):void
        {
            var button:MovieClip;
            var display:MovieClip;
            switch (event.currentTarget.name)
            {
                case "btnClose":
                    this.rootClass.ui.mcPopup.onClose();
                    break;
                case "btnSearch":
                    this.pageId = 1;
                    this.nameFilter = this.txtSearch.text;
                    this.rootClass.world.loadGuildList(this.nameFilter, this.pageId);
                    break;
                case "btnJoin":
                    if (this.selectedGuild == null)
                    {
                        this.rootClass.MsgBox.notify("Please select a guild.");
                        return;
                    };
                    if (this.selectedGuild.Status == 0)
                    {
                        this.rootClass.MsgBox.notify("Cannot join guild, guild status is close.");
                        return;
                    };
                    this.rootClass.world.joinGuild(this.selectedGuild.ID);
                    break;
                case "paginationButton":
                    button = MovieClip(event.currentTarget);
                    this.pageId = button.txtPage.text;
                    this.selectedGuild = null;
                    this.rootClass.world.loadGuildList(this.nameFilter, this.pageId);
                    break;
                case "btnGuild":
                    display = MovieClip(event.currentTarget);
                    switch (true)
                    {
                        case (this.selectedGuild == null):
                            display.bg.alpha = 0.3;
                            display.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
                            display.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
                            this.selectedGuild = display;
                            break;
                        case (!(this.selectedGuild == display)):
                            this.selectedGuild.bg.alpha = 0;
                            this.selectedGuild.addEventListener(MouseEvent.MOUSE_OVER, onOver);
                            this.selectedGuild.addEventListener(MouseEvent.MOUSE_OUT, onOut);
                            display.bg.alpha = 0.3;
                            display.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
                            display.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
                            this.selectedGuild = display;
                            break;
                        case (this.selectedGuild == display):
                            display.bg.alpha = 0;
                            display.addEventListener(MouseEvent.MOUSE_OVER, onOver);
                            display.addEventListener(MouseEvent.MOUSE_OUT, onOut);
                            this.selectedGuild = null;
                            break;
                    };
                    this.displayGuild(this.selectedGuild);
                    break;
            };
        }

        public function displayGuild(guild:MovieClip):*
        {
            if (guild == null)
            {
                return;
            };
            this.txtGuildName.htmlText = guild.Name;
            this.txtDescription.htmlText = ((guild.Description == "") ? guild.MOTD : guild.Description);
            this.loadGuildImage(guild.ID);
        }


    }
}//package 

