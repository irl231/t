// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Menu.MenuPanel

package Main.Menu
{
    import flash.display.MovieClip;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.display.SimpleButton;
    import Main.Chat.ChatTab;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.text.*;
    import flash.filters.*;
    import Main.Chat.*;

    public dynamic class MenuPanel extends MovieClip 
    {

        public var rootClass:Game = Game.root;
        public var listTabs:MovieClip;
        public var maskTabs:MovieClip;
        public var scrollTabs:LPFElementScrollBar;
        public var listMenu:MovieClip;
        public var maskMenu:MovieClip;
        public var scrollMenu:LPFElementScrollBar;
        public var btnClose:SimpleButton;

        public function MenuPanel():void
        {
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        public function renderTab(tab:Object):void
        {
            var mcTab:ChatTab;
            mcTab = this.listTabs.addChild(new ChatTab());
            mcTab.addEventListener(MouseEvent.CLICK, this.onClick);
            mcTab.mcNotification.visible = false;
            mcTab.txtChat.text = tab.label;
            mcTab.txtChat.mouseEnabled = false;
            mcTab.name = "btnTab";
            mcTab.tab = tab.label;
            mcTab.contents = tab.contents;
            mcTab.y = ((this.listTabs.numChildren - 1) * (mcTab.height + 5));
        }

        public function clearTab():void
        {
            while (this.listTabs.numChildren > 0)
            {
                this.listTabs.removeChildAt(0);
            };
        }

        public function configureTabScroll(reset:Boolean=false):void
        {
            Game.configureScroll(this.listTabs, this.maskTabs, this.scrollTabs, this.maskTabs.height, reset);
        }

        public function renderMenu(menu:Object):void
        {
            var mcMenu:MenuButton;
            mcMenu = this.listMenu.addChild(new MenuButton());
            mcMenu.addEventListener(MouseEvent.CLICK, this.onClick);
            mcMenu.addEventListener(MouseEvent.MOUSE_OVER, this.onMenuHover);
            mcMenu.addEventListener(MouseEvent.MOUSE_OUT, this.onMenuOut);
            mcMenu.buttonMode = true;
            mcMenu.txtName.text = menu.label;
            mcMenu.txtName.mouseEnabled = false;
            mcMenu.txtName.wordWrap = true;
            mcMenu.txtName.multiline = true;
            mcMenu.txtName.autoSize = TextFieldAutoSize.CENTER;
            mcMenu.name = "btnMenu";
            mcMenu.callback = menu.callback;
            var index:int = (this.listMenu.numChildren - 1);
            var row:int = int(Math.floor((index / 3)));
            var col:int = (index % 3);
            mcMenu.x = (col * (mcMenu.width - 15));
            mcMenu.y = (row * (mcMenu.background.height + 10));
        }

        private function onMenuHover(event:MouseEvent):void
        {
            var mcMenu:MenuButton = (event.currentTarget as MenuButton);
            if (mcMenu)
            {
                mcMenu.filters = [new ColorMatrixFilter([1.2, 0, 0, 0, 20, 0, 1.2, 0, 0, 20, 0, 0, 1.2, 0, 20, 0, 0, 0, 1, 0])];
            };
        }

        private function onMenuOut(event:MouseEvent):void
        {
            var mcMenu:MenuButton = (event.currentTarget as MenuButton);
            if (mcMenu)
            {
                mcMenu.filters = [];
            };
        }

        public function clearMenu():void
        {
            while (this.listMenu.numChildren > 0)
            {
                this.listMenu.removeChildAt(0);
            };
        }

        public function configureMenuScroll(reset:Boolean=false):void
        {
            Game.configureScroll(this.listMenu, this.maskMenu, this.scrollMenu, this.maskMenu.height, reset);
        }

        public function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnMenu":
                    event.currentTarget.callback();
                    break;
            };
        }


    }
}//package Main.Menu

