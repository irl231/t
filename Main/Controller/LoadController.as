// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.LoadController

package Main.Controller
{
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.display.Loader;
    import flash.utils.ByteArray;
    import flash.events.UncaughtErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.net.*;
    import Main.*;

    public class LoadController 
    {

        public static const singleton:LoadController = new (LoadController)();
        private static const maxConcurrent:int = 15;

        public var applicationDomainGlobal:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
        public var loaderContextGlobal:LoaderContext = new LoaderContext(false, applicationDomainGlobal);
        public var applicationDomainJunk:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
        private var loaderContextJunk:LoaderContext = new LoaderContext(false, applicationDomainJunk);
        public var applicationDomainAvatar:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
        private var loaderContextAvatar:LoaderContext = new LoaderContext(false, applicationDomainAvatar);
        public var applicationDomainMap:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
        private var loaderContextMap:LoaderContext = new LoaderContext(false, applicationDomainMap);
        public var applicationDomainEmoji:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
        private var loaderContextEmoji:LoaderContext = new LoaderContext(false, applicationDomainEmoji);
        private var queue:Array = [];
        private var concurrentCount:int = 0;
        private var loaderStack:Dictionary = new Dictionary();

        public function LoadController()
        {
            this.loaderContextGlobal.checkPolicyFile = false;
            this.loaderContextGlobal.allowCodeImport = true;
            this.loaderContextJunk.checkPolicyFile = false;
            this.loaderContextJunk.allowCodeImport = true;
            this.loaderContextAvatar.checkPolicyFile = false;
            this.loaderContextAvatar.allowCodeImport = true;
            this.loaderContextMap.checkPolicyFile = false;
            this.loaderContextMap.allowCodeImport = true;
            this.loaderContextEmoji.checkPolicyFile = false;
            this.loaderContextEmoji.allowCodeImport = true;
        }

        public function addLoadGlobal(file:String, key:String, onComplete:Function, onError:Function=null, onProgress:Function=null, context:LoaderContext=null):void
        {
            this.queue.push({
                "_type":"global",
                "key":key,
                "file":file,
                "onComplete":onComplete,
                "context":((context == null) ? this.loaderContextGlobal : context),
                "onProgress":onProgress,
                "onError":onError
            });
            this.loadNext();
        }

        public function addLoadJunk(file:String, key:String, onComplete:Function, onError:Function=null, onProgress:Function=null, context:LoaderContext=null):void
        {
            this.queue.push({
                "_type":"junk",
                "key":key,
                "file":file,
                "onComplete":onComplete,
                "context":((context == null) ? this.loaderContextJunk : context),
                "onProgress":onProgress,
                "onError":onError
            });
            this.loadNext();
        }

        public function addLoadEmoji(file:String, key:String, onComplete:Function, onError:Function=null):void
        {
            this.queue.push({
                "_type":"emoji",
                "key":key,
                "file":file,
                "onComplete":onComplete,
                "context":this.loaderContextEmoji,
                "onProgress":null,
                "onError":onError
            });
            this.loadNext();
        }

        public function addLoadMap(file:String, key:String, onComplete:Function=null, onError:Function=null, onProgress:Function=null, reset:Boolean=false):void
        {
            if (reset)
            {
                LoadController.singleton.clearLoaderByType("map");
                this.applicationDomainMap = new ApplicationDomain(ApplicationDomain.currentDomain);
                this.loaderContextMap = new LoaderContext(false, this.applicationDomainMap);
                this.loaderContextMap.checkPolicyFile = false;
                this.loaderContextMap.allowCodeImport = true;
            };
            this.queue.push({
                "_type":"map",
                "key":key,
                "file":file,
                "onComplete":onComplete,
                "context":this.loaderContextMap,
                "onProgress":onProgress,
                "onError":onError
            });
            this.loadNext();
        }

        public function addLoadAvatar(file:String, key:String, onComplete:Function, onError:Function=null):void
        {
            this.queue.push({
                "_type":"avatar",
                "key":key,
                "file":file,
                "onComplete":onComplete,
                "context":this.loaderContextAvatar,
                "onProgress":null,
                "onError":onError
            });
            this.loadNext();
        }

        private function onLoadMaster(obj:Object):void
        {
            var urlRequest:URLRequest = new URLRequest(Config.getLoadPath(obj.file));
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            urlLoader.addEventListener(Event.COMPLETE, function (event:Event):void
            {
                var byteLoader:Loader;
                var result:ByteArray = (URLLoader(event.target).data as ByteArray);
                byteLoader = new Loader();
                byteLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, function (e:UncaughtErrorEvent):void
                {
                    e.preventDefault();
                });
                byteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void
                {
                    try
                    {
                        if (obj.onComplete != null)
                        {
                            obj.onComplete(e);
                        };
                        clearLoader(obj.key);
                        loaderStack[obj.key] = {
                            "_type":obj._type,
                            "loader":byteLoader
                        };
                    }
                    catch(error:Error)
                    {
                        trace("byteLoader Event.COMPLETE", error.getStackTrace());
                    };
                    concurrentCount--;
                    loadNext();
                });
                byteLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent):void
                {
                    if (obj.onError != null)
                    {
                        try
                        {
                            obj.onError(event);
                        }
                        catch(error:Error)
                        {
                            trace("byteLoader IOErrorEvent.IO_ERROR", error.getStackTrace());
                        };
                    };
                    concurrentCount--;
                    loadNext();
                });
                byteLoader.loadBytes(result, obj.context);
            });
            if (obj.onProgress != null)
            {
                urlLoader.addEventListener(ProgressEvent.PROGRESS, obj.onProgress);
            };
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent):void
            {
                if (obj.onError != null)
                {
                    try
                    {
                        obj.onError(event);
                    }
                    catch(error:Error)
                    {
                        trace("urlLoader IOErrorEvent.IO_ERROR", error.getStackTrace());
                    };
                };
                concurrentCount--;
                loadNext();
            });
            urlLoader.load(urlRequest);
        }

        public function clearLoader(key:String):void
        {
            if ((key in this.loaderStack))
            {
                Loader(this.loaderStack[key].loader).unloadAndStop();
                delete this.loaderStack[key];
            };
        }

        public function clearLoaderByType(_type:String):void
        {
            var key:String;
            for (key in this.loaderStack)
            {
                if (this.loaderStack[key]._type == _type)
                {
                    Loader(this.loaderStack[key].loader).unloadAndStop();
                    delete this.loaderStack[key];
                };
            };
        }

        private function loadNext():void
        {
            if (((this.queue.length > 0) && (this.concurrentCount < maxConcurrent)))
            {
                this.concurrentCount++;
                this.onLoadMaster(this.queue.shift());
            };
        }


    }
}//package Main.Controller

