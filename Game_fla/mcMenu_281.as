// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcMenu_281

package Game_fla
{
    import flash.display.Sprite;
    import Main.Menu.Quest;
    import flash.display.SimpleButton;
    import Main.Menu.Features;
    import Main.Menu.Character;
    import Main.Menu.AbstractMenuButton;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.Menu.*;

    public dynamic class mcMenu_281 extends Sprite 
    {

        public static var isGameMenuOpen:Boolean = false;

        public var btnQuest:Quest;
        public var btnRest:SimpleButton;
        public var btnFeatures:Features;
        public var btnChar:Character;
        public var btnBook:SimpleButton;
        public var btnBag:Sprite;
        public var btnMap:Sprite;
        public var btnOption:Sprite;
        public var btnMenu:Sprite;
        public var btnHouse:SimpleButton;
        public var menu:interfaceMenu;

        public function mcMenu_281():void
        {
            this.btnQuest.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnQuest.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnQuest.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnRest.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnRest.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnRest.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnFeatures.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnFeatures.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnFeatures.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnChar.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnChar.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnChar.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnBook.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnBook.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnBook.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnBag.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnBag.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnBag.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnMap.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnMap.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnMap.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnOption.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnOption.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnOption.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnMenu.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnMenu.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnMenu.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
            this.btnHouse.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.btnHouse.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            this.btnHouse.addEventListener(MouseEvent.CLICK, this.onMouseClick, false, 0, true);
        }

        public function handleMenu(abstractMenuButton:AbstractMenuButton, closeLPF:Boolean=true):void
        {
            OFrameMC(Game.root.ui.mcOFrame).fClose();
            if (closeLPF)
            {
                mcPopup_323(Game.root.ui.mcPopup).fClose();
            };
            if (abstractMenuButton == null)
            {
                if (this.menu == null)
                {
                    return;
                };
                this.menu.mcMenu.parent.removeChild(this.menu.mcMenu);
                this.menu = null;
                return;
            };
            if (this.menu == null)
            {
                this.openInterfaceMenu(abstractMenuButton);
                return;
            };
            if (this.menu.currentMenu == abstractMenuButton)
            {
                this.menu.mcMenu.parent.removeChild(this.menu.mcMenu);
                this.menu = null;
                return;
            };
            this.menu.mcMenu.parent.removeChild(this.menu.mcMenu);
            this.menu = null;
            this.openInterfaceMenu(abstractMenuButton);
        }

        public function toggleInventory():void
        {
            if (mcPopup_323(Game.root.ui.mcPopup).currentLabel === "Inventory")
            {
                mcPopup_323(Game.root.ui.mcPopup).fClose();
                return;
            };
            mcPopup_323(Game.root.ui.mcPopup).fOpen("Inventory");
        }

        private function openInterfaceMenu(abstractMenuButton:AbstractMenuButton):void
        {
            this.menu = new interfaceMenu(abstractMenuButton.buttons, abstractMenuButton);
        }

        public function onMouseOver(_arg1:MouseEvent):void
        {
            var toolTips:Object = {
                "btnQuest":"Quests",
                "btnRest":"Rest",
                "btnFeatures":"Features",
                "btnChar":((this.menu == null) ? "Character" : null),
                "btnBag":"Inventory",
                "btnBook":"Chronicle",
                "btnMap":"Map",
                "btnOption":"Options",
                "btnMenu":"Game Menu",
                "btnHouse":"Visit House"
            };
            var tip:String = toolTips[_arg1.currentTarget.name];
            if (tip)
            {
                Game.root.ui.ToolTip.openWith({"str":tip});
            };
        }

        public function onMouseOut(_arg1:MouseEvent):void
        {
            Game.root.ui.ToolTip.close();
        }

        public function onMouseClick(event:MouseEvent):void
        {
            if (event.currentTarget.name != "btnMenu")
            {
                Game.root.gameMenu.close();
            };
            Game.root.mixer.playSound("Click");
            switch (event.currentTarget.name)
            {
                case "btnRest":
                    this.handleMenu(null);
                    Game.root.world.rest();
                    return;
                case "btnBag":
                    this.handleMenu(null, false);
                    this.toggleInventory();
                    return;
                case "btnBook":
                    this.handleMenu(null, false);
                    Game.root.toggleChronicle();
                    return;
                case "btnMenu":
                    this.handleMenu(null, false);
                    if (mcMenu_281.isGameMenuOpen)
                    {
                        Game.root.gameMenu.close();
                    }
                    else
                    {
                        Game.root.gameMenu.open();
                    };
                    return;
                case "btnMap":
                    this.handleMenu(null, false);
                    Game.root.toggleWorldMapPanel();
                    return;
                case "btnOption":
                    this.handleMenu(null, false);
                    Game.root.toggleOption2Panel();
                    return;
                case "btnQuest":
                    Game.root.world.toggleQuestLog();
                    return;
                case "btnFeatures":
                    this.handleMenu(AbstractMenuButton(event.currentTarget));
                    return;
                case "btnChar":
                    this.handleMenu(AbstractMenuButton(event.currentTarget));
                    return;
                case "btnHouse":
                    this.handleMenu(null, false);
                    if (Game.root.world.isHouseEquipped())
                    {
                        Game.root.world.gotoHouse(Game.root.network.myUserName);
                    }
                    else
                    {
                        Game.root.world.gotoTown("buyhouse", "Enter", "Spawn");
                    };
                    return;
            };
        }


    }
}//package Game_fla

