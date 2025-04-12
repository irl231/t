// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//LoaderMC

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Controller.*;

    public class LoaderMC extends MovieClip 
    {

        public var mcPct:TextField;
        public var btnCancel:SimpleButton;
        public var strLoad:TextField;
        private var mcDest:MovieClip;
        private var isEvent:Boolean = false;
        private var file:String;
        private var fileType:String;
        public var mcTitle:MovieClip;

        public function LoaderMC()
        {
            this.btnCancel.addEventListener(MouseEvent.CLICK, this.onCancelClick);
        }

        public function loadFile(mcDest:MovieClip, file:String, fileType:String, isEvent:Boolean=false):void
        {
            this.mcDest = mcDest;
            this.file = file;
            this.fileType = fileType;
            this.isEvent = isEvent;
            if (fileType != "Inline Asset")
            {
                Game.root.addChild(this);
            };
            LoadController.singleton.addLoadMap(file, "loader_mc", this.onFileLoadFinal, this.onFileLoadError, this.onFileLoadProgress);
        }

        public function closeHistory():void
        {
            LoadController.singleton.clearLoader("loader_mc_junk");
        }

        private function onFileLoadFinal(event:Event):void
        {
            this.mcDest.addChild(MovieClip(event.target.content));
            if (((this.isEvent) && ("eventTrigger" in Game.root.world.map)))
            {
                Game.root.world.map.eventTrigger({
                    "cmd":"fileLoaded",
                    "args":{"loc":"default"}
                });
            };
            this.mcDest = null;
            if (parent.contains(this))
            {
                parent.removeChild(this);
            };
        }

        private function onFileLoadError(_arg1:IOErrorEvent):void
        {
            this.btnCancel.removeEventListener(MouseEvent.CLICK, this.onCancelClick);
            this.btnCancel.addEventListener(MouseEvent.CLICK, this.onReloadClick);
            this.strLoad.text = (("File Not Found: " + this.file) + "<br> Click back to reload.");
        }

        private function onFileLoadProgress(progressEvent:ProgressEvent):void
        {
            var mathFloor:int = ((progressEvent.bytesTotal <= 0) ? 0 : int(Math.floor(((progressEvent.bytesLoaded / progressEvent.bytesTotal) * 100))));
            this.strLoad.text = "Loading!";
            this.mcPct.text = (mathFloor + "%");
        }

        private function onCancelClick(_arg1:MouseEvent):void
        {
            Game.root.logout();
            parent.removeChild(this);
        }

        private function onReloadClick(_arg1:MouseEvent):void
        {
            this.loadFile(this.mcDest, this.file, this.fileType, this.isEvent);
        }


    }
}//package 

