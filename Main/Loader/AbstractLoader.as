// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Loader.AbstractLoader

package Main.Loader
{
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.system.*;
    import flash.errors.*;

    public class AbstractLoader 
    {

        public var domain:ApplicationDomain = null;
        public var context:LoaderContext = null;
        protected var path:String = "";


        public function init():void
        {
            throw (new IllegalOperationError("Must override callback Function"));
        }

        protected function load():void
        {
            this.domain = new ApplicationDomain();
            this.context = new LoaderContext(false, this.domain);
            this.context.checkPolicyFile = false;
            this.context.allowCodeImport = true;
            Game.root.mcConnDetail.showConn("Initializing Client...");
        }

        protected function callback(event:Event):void
        {
            throw (new IllegalOperationError("Must override callback Function"));
        }

        protected function loaderProgress(event:ProgressEvent):void
        {
            Game.root.mcConnDetail.showConn((("Initializing Client..." + Math.floor(((event.currentTarget.bytesLoaded / event.currentTarget.bytesTotal) * 100))) + "%"), true);
        }

        protected function loaderError(error:IOErrorEvent):void
        {
            Game.root.mcConnDetail.showError("Client Initialization Failed!");
        }


    }
}//package Main.Loader

