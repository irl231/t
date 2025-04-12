// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.wildtangent.WildTangentAPI

package com.wildtangent
{
    import flash.display.Sprite;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.display.Loader;
    import flash.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class WildTangentAPI extends Sprite 
    {

        public var Ads:*;
        public var BrandBoost:*;
        public var Stats:*;
        public var Vex:*;
        protected var myVex:* = null;
        protected var _vexReady:Boolean = false;
        private var _dpName:String;
        private var _gameName:String;
        private var _adServerGameName:String;
        private var _partnerName:String;
        private var _siteName:String;
        private var _userId:String;
        private var _cipherKey:String;
        private var _vexUrl:String = "http://vex.wildtangent.com";
        private var _sandbox:Boolean = false;
        private var _javascriptReady:Boolean = false;
        private var _adComplete:Function;
        private var _closed:Function;
        private var _error:Function;
        private var _handlePromo:Function;
        private var _redeemCode:Function;
        private var _requireLogin:Function;
        private var _localMode:Boolean = false;
        protected var methodStorage:Array;

        public function WildTangentAPI()
        {
            this.Ads = new this.Ads();
            this.BrandBoost = new this.BrandBoost();
            this.Stats = new this.Stats();
            this.Vex = new this.Vex();
            this.methodStorage = [];
            super();
            addEventListener(Event.ADDED_TO_STAGE, this.loadVex);
        }

        private function loadVex(_arg1:Event):void
        {
            var context:LoaderContext;
            var request:URLRequest;
            var e:Event = _arg1;
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadAPI);
            try
            {
                this._localMode = (loaderInfo.url.indexOf("file") == 0);
            }
            catch(e)
            {
            };
            if (!this._localMode)
            {
                context = new LoaderContext();
                context.securityDomain = SecurityDomain.currentDomain;
                request = new URLRequest((this._vexUrl + "/Vex/swf/VexAPI"));
                request.data = new URLVariables(("cache=" + new Date().time));
                request.method = URLRequestMethod.POST;
                loader.load(request, context);
            }
            else
            {
                loader.load(new URLRequest("VexAPI.swf"));
            };
        }

        private function loadAPI(_arg1:Event):void
        {
            this.myVex = _arg1.target.content;
            addChild(this.myVex);
            if (root.loaderInfo.parameters.canvasSize != null)
            {
                this.myVex.canvasSize = root.loaderInfo.parameters.canvasSize;
            };
            this.vexReady = true;
            this.myVex.loaderParameters = root.loaderInfo.parameters;
            this.myVex.localMode = this._localMode;
            this.sendExistingParameters();
            this.initBrandBoost();
            this.initVex();
            this.initStats();
            this.initAds();
            dispatchEvent(_arg1);
        }

        private function initBrandBoost():void
        {
            this.BrandBoost.myVex = this.myVex;
            this.BrandBoost.launchMethods();
            this.BrandBoost.sendExistingParameters();
        }

        private function initVex():void
        {
            this.Vex.myVex = this.myVex;
            this.Vex.launchMethods();
            this.Vex.sendExistingParameters();
        }

        private function initStats():void
        {
            this.Stats.myVex = this.myVex;
            this.Stats.launchMethods();
            this.Stats.sendExistingParameters();
        }

        private function initAds():void
        {
            this.Ads.myVex = this.myVex;
            this.Ads.launchMethods();
            this.Ads.sendExistingParameters();
        }

        private function sendExistingParameters():void
        {
            if (this._dpName)
            {
                this.myVex.dpName = this._dpName;
            };
            if (this._gameName)
            {
                this.myVex.gameName = this._gameName;
            };
            if (this._adServerGameName)
            {
                this.myVex.adServerGameName = this._adServerGameName;
            };
            if (this._partnerName)
            {
                this.myVex.partnerName = this._partnerName;
            };
            if (this._siteName)
            {
                this.myVex.siteName = this._siteName;
            };
            if (this._userId)
            {
                this.myVex.userId = this._userId;
            };
            if (this._sandbox)
            {
                this.myVex.sandbox = this._sandbox;
            };
            if (this._cipherKey)
            {
                this.myVex.cipherKey = this._cipherKey;
            };
            if (this._adComplete != null)
            {
                this.myVex.adComplete = this._adComplete;
            };
            if (this._closed != null)
            {
                this.myVex.closed = this._closed;
            };
            if (this._error != null)
            {
                this.myVex.error = this._error;
            };
            if (this._redeemCode != null)
            {
                this.myVex.redeemCode = this._redeemCode;
            };
        }

        private function set vexReady(_arg1:Boolean):void
        {
            this.BrandBoost.vexReady = _arg1;
            this.Ads.vexReady = _arg1;
            this.Stats.vexReady = _arg1;
            this.Vex.vexReady = _arg1;
            this._vexReady = _arg1;
        }

        private function get vexReady():Boolean
        {
            return (this._vexReady);
        }

        private function set javascriptReady(_arg1:Boolean):void
        {
            if (this.vexReady)
            {
                this.myVex.javascriptReady = _arg1;
            }
            else
            {
                this._javascriptReady = _arg1;
            };
        }

        public function get userId():String
        {
            return ((this.vexReady) ? this.myVex.userId : this._userId);
        }

        public function set userId(_arg1:String):void
        {
            if (this.vexReady)
            {
                this.myVex.userId = _arg1;
            }
            else
            {
                this._userId = _arg1;
            };
        }

        public function set partnerName(_arg1:String):void
        {
            if (this.vexReady)
            {
                this.myVex.partnerName = _arg1;
            }
            else
            {
                this._partnerName = _arg1;
            };
        }

        public function get partnerName():String
        {
            return ((this.vexReady) ? this.myVex.partnerName : this._partnerName);
        }

        public function set siteName(_arg1:String):void
        {
            if (this.vexReady)
            {
                this.myVex.siteName = _arg1;
            }
            else
            {
                this._siteName = _arg1;
            };
        }

        public function get siteName():String
        {
            return ((this.vexReady) ? this.myVex.siteName : this._siteName);
        }

        public function set gameName(_arg1:String):void
        {
            if (this.vexReady)
            {
                this.myVex.gameName = _arg1;
            }
            else
            {
                this._gameName = _arg1;
            };
        }

        public function get gameName():String
        {
            return ((this.vexReady) ? this.myVex.gameName : this._gameName);
        }

        public function set adServerGameName(_arg1:String):void
        {
            if (this.vexReady)
            {
                this.myVex.adServerGameName = _arg1;
            }
            else
            {
                this._adServerGameName = _arg1;
            };
        }

        public function set dpName(_arg1:String):void
        {
            if (this.vexReady)
            {
                this.myVex.dpName = _arg1;
            }
            else
            {
                this._dpName = _arg1;
            };
        }

        public function get dpName():String
        {
            return ((this.vexReady) ? this.myVex.dpName : this._dpName);
        }

        public function set sandbox(_arg1:Boolean):void
        {
            this._vexUrl = ((_arg1) ? "http://vex.bpi.wildtangent.com" : "http://vex.wildtangent.com");
            this._sandbox = _arg1;
        }

        public function get VERSION():String
        {
            return ((this.vexReady) ? this.myVex.VERSION : "Not yet loaded");
        }


    }
}//package com.wildtangent

