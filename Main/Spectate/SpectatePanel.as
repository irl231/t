// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Spectate.SpectatePanel

package Main.Spectate
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class SpectatePanel extends MovieClip 
    {

        public var btnClose:SimpleButton;
        public var txtTitle:TextField;
        public var listMenu:MovieClip;
        public var maskMenu:MovieClip;
        public var mcExpand:MovieClip;
        public var scrollMenu:LPFElementScrollBar;
        public var rootClass:Game = Game.root;
        public var excludeList:Array = ["Wait", "Blank"];

        public function SpectatePanel()
        {
            addFrameScript(0, this.Show, 1, this.Hide);
        }

        public function Show():*
        {
            stop();
            this.txtTitle.text = "Navigation";
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.buildMenu();
        }

        public function Hide():*
        {
            this.mcExpand.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcExpand.buttonMode = true;
            stop();
        }

        public function buildMenu():*
        {
            var label:Object;
            var mcMenu:*;
            var menuCounter:int;
            for each (label in this.rootClass.world.map.currentLabels)
            {
                if (this.excludeList.indexOf(label.name) >= 0)
                {
                }
                else
                {
                    mcMenu = this.listMenu.addChild(new MCStaffPanelMenuButton());
                    mcMenu.txtTitle.text = label.name;
                    mcMenu.txtTitle.mouseEnabled = false;
                    mcMenu.addEventListener(MouseEvent.CLICK, this.onClick);
                    mcMenu.name = "btnMenu";
                    mcMenu.title = label.name;
                    mcMenu.frame = label.name;
                    mcMenu.y = ((menuCounter * mcMenu.height) + 5);
                    menuCounter++;
                };
            };
            Game.configureScroll(this.listMenu, this.maskMenu, this.scrollMenu, 270);
        }

        public function onClick(event:MouseEvent):void
        {
            var target:* = event.currentTarget;
            switch (target.name)
            {
                case "btnClose":
                    gotoAndStop("Hide");
                    return;
                case "mcExpand":
                    gotoAndStop("Show");
                    break;
                case "btnMenu":
                    this.rootClass.world.moveToCell(target.frame, "Spectator");
                    break;
            };
        }


    }
}//package Main.Spectate

