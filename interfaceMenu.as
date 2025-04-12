// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//interfaceMenu

package 
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import Main.Menu.AbstractMenuButton;
    import Main.Menu.MenuItem;
    import __AS3__.vec.Vector;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Game_fla.*;

    public class interfaceMenu extends MovieClip 
    {

        public var mcMenu:Sprite;
        public var currentMenu:AbstractMenuButton = null;

        public function interfaceMenu(buttons:Vector.<MenuItem>, currentMenu:AbstractMenuButton)
        {
            var h:Number;
            var w:Number;
            var button:MenuItem;
            var mc3:menuTop;
            var listItem:menuListItem;
            super();
            this.currentMenu = currentMenu;
            this.mcMenu = new Sprite();
            var mc:menuBottom = new menuBottom();
            mc.height--;
            mc.width = 116.4;
            mc.x = (mc.x - 41);
            mc.y = (mc.y - 10.7);
            var currentPos:Number = (mc.y + 11);
            this.mcMenu.addChild(mc);
            h = 25.2;
            w = 118.25;
            for each (button in buttons)
            {
                if (button.callback == null)
                {
                }
                else
                {
                    listItem = new menuListItem();
                    listItem.x = (listItem.x + 17);
                    listItem.height = h;
                    listItem.width = w;
                    listItem.y = ((currentPos - h) + 1);
                    currentPos = listItem.y;
                    listItem.addEventListener(MouseEvent.CLICK, button.callback, false, 0, true);
                    listItem.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
                    listItem.buttonMode = true;
                    listItem.mouseChildren = false;
                    listItem.mTxt.text = button.txt;
                    this.mcMenu.addChild(listItem);
                };
            };
            mc3 = new menuTop();
            mc3.height--;
            mc3.width--;
            mc3.y = (currentPos - mc3.height);
            mc3.txt.text = buttons[0].txt;
            mc3.x = (mc3.x + 17);
            this.mcMenu.addChild(mc3);
            mcPopup_323(Game.root.ui.mcPopup).fClose();
            this.currentMenu.addChild(this.mcMenu);
        }

        private static function onClick(mouseEvent:MouseEvent):void
        {
        }


    }
}//package 

