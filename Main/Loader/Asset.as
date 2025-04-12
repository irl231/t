// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Loader.Asset

package Main.Loader
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import Main.Controller.*;

    public class Asset extends AbstractLoader 
    {


        override public function init():void
        {
            if (this.domain == null)
            {
                this.load();
                return;
            };
            Game.root.gameMenu.init();
        }

        override protected function load():void
        {
            this.path = Game.root.version.setting.file_assets;
            super.load();
            LoadController.singleton.addLoadGlobal(path, "asset", this.callback, this.loaderError, loaderProgress, context);
        }

        override protected function callback(event:Event):void
        {
            Game.root.gameMenu.init();
        }

        override protected function loaderError(error:IOErrorEvent):void
        {
            Game.root.mcConnDetail.showError("Engine preparation Failed!\nResume login without Asset.");
            Game.root.gameMenu.init();
        }


    }
}//package Main.Loader

