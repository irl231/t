// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Loader.GameMenu

package Main.Loader
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.display.*;
    import Main.Controller.*;
    import Game_fla.*;

    public class GameMenu extends AbstractLoader 
    {

        public var mcGameMenu:MovieClip = null;


        override public function init():void
        {
            this.load();
        }

        override protected function load():void
        {
            this.path = Game.root.version.setting.file_menu;
            super.load();
            LoadController.singleton.addLoadGlobal(path, "menu", this.callback, this.loaderError, this.loaderProgress, context);
        }

        override protected function callback(event:Event):void
        {
            Game.root.mcConnDetail.showError("Ready to launch!");
            Game.root.resumeOnLoginResponse();
        }

        override protected function loaderProgress(event:ProgressEvent):void
        {
            Game.root.mcConnDetail.showConn((("Making the Pyrotechnic Mixture... " + Math.floor(((event.currentTarget.bytesLoaded / event.currentTarget.bytesTotal) * 100))) + "%"), true);
        }

        override protected function loaderError(error:IOErrorEvent):void
        {
            Game.root.mcConnDetail.showError("Game Menu load Failed!\nResume login without Game Menu.");
            Game.root.resumeOnLoginResponse();
        }

        public function open():void
        {
            mcMenu_281.isGameMenuOpen = true;
            this.displayGameMenu();
        }

        public function close():void
        {
            mcMenu_281.isGameMenuOpen = false;
            if (this.mcGameMenu == null)
            {
                return;
            };
            if (this.mcGameMenu.parent.contains(this.mcGameMenu))
            {
                this.mcGameMenu.parent.removeChild(this.mcGameMenu);
            };
            this.mcGameMenu = null;
        }

        public function toggle():void
        {
            if (this.mcGameMenu == null)
            {
                this.close();
            }
            else
            {
                this.open();
            };
        }

        private function displayGameMenu():void
        {
            var gameMenuClass:Class;
            if (domain.hasDefinition("GameMenu"))
            {
                gameMenuClass = (domain.getDefinition("GameMenu") as Class);
                this.mcGameMenu = MovieClip(new (gameMenuClass)());
                this.mcGameMenu.name = "gameMenu";
                this.mcGameMenu.visible = true;
                this.mcGameMenu.x = 780;
                this.mcGameMenu.y = 29;
                Game.root.ui.addChild(this.mcGameMenu);
            };
        }


    }
}//package Main.Loader

