// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Network.Network

package Main.Network
{
    import flash.net.Socket;
    import Main.Request;
    import flash.utils.ByteArray;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.Event;
    import flash.events.*;
    import flash.utils.*;
    import Main.*;
    import com.hurlant.util.*;

    public class Network extends Socket 
    {

        private var game:Game;
        private var request:Request;
        private var _myUserId:Number;
        private var _myUserName:String;
        private var _room:Room = null;
        private var _byteArray:ByteArray = new ByteArray();
        private var key:uint = 0;

        public function Network(game:Game)
        {
            this.game = game;
            this.request = new Request(game);
            this.listeners();
        }

        private static function onIoErrorHandler(event:IOErrorEvent):void
        {
            trace("[Network] onIoErrorHandler", event);
        }

        private static function onSecurityErrorHandler(event:SecurityErrorEvent):void
        {
            trace("[Network] onSecurityErrorHandler", event);
        }


        public function get myUserId():Number
        {
            return (this._myUserId);
        }

        public function set myUserId(value:Number):void
        {
            this._myUserId = value;
        }

        public function get myUserName():String
        {
            return (this._myUserName);
        }

        public function set myUserName(value:String):void
        {
            this._myUserName = value;
        }

        public function get room():Room
        {
            return (this._room);
        }

        public function set room(value:Room):void
        {
            this._room = value;
        }

        public function get byteArray():ByteArray
        {
            return (this._byteArray);
        }

        public function set byteArray(value:ByteArray):void
        {
            this._byteArray = value;
        }

        public function send(cmd:String, args:Array):void
        {
            if (Config.isDebugNetwork)
            {
                trace("[Network] send", cmd, args.toString());
            };
            this.writeToSocket(Base64.encode(JSON.stringify({
                "type":"request",
                "body":{
                    "key":this.key,
                    "cmd":cmd,
                    "args":args
                }
            })));
            this.key++;
        }

        public function sendEvent(cmd:String, ... args):void
        {
            if (Config.isDebugNetwork)
            {
                trace("[Network] sendEvent", cmd, args.toString());
            };
            this.writeToSocket(Base64.encode(JSON.stringify({
                "type":"event",
                "body":{
                    "cmd":cmd,
                    "args":args
                }
            })));
        }

        private function writeToSocket(message:String):void
        {
            var constructArray:ByteArray = new ByteArray();
            constructArray.writeUTFBytes(message);
            constructArray.writeByte(0);
            this.writeBytes(constructArray);
            this.flush();
        }

        private function listeners():void
        {
            removeEventListener(Event.CONNECT, this.onConnect);
            removeEventListener(Event.CLOSE, this.onCloseHandler);
            removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketDataHandler);
            removeEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
            removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
            addEventListener(Event.CONNECT, this.onConnect);
            addEventListener(Event.CLOSE, this.onCloseHandler);
            addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketDataHandler);
            addEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
        }

        private function onConnect(event:Event):void
        {
            trace("[Network] onConnect", event);
            this.byteArray = new ByteArray();
            this.key = 0;
            if (((Game.root.objServerInfo.strUsername) && (Game.root.objServerInfo.strPassword)))
            {
                this.sendEvent("login", Game.root.objServerInfo.strUsername, Game.root.objServerInfo.strPassword);
                Game.root.objServerInfo.strUsername = null;
                Game.root.objServerInfo.strPassword = null;
                return;
            };
            this.sendEvent("login", User.CHARACTER.Username, User.TOKEN);
        }

        private function onCloseHandler(event:Event):void
        {
            trace("[Network] onCloseHandler", event);
            this.byteArray = new ByteArray();
            this.game.logout();
            this.game.gotoAndPlay("Login");
            this.game.discord.update("destroy");
            this.game.mcConnDetail.showDisconnect("Communication with server has been lost. Please check your internet connection and try again.");
        }

        private function onSocketDataHandler(event:Event):void
        {
            var b:int;
            var response:String;
            var json:Object;
            var arr:Array;
            var bytes:int = bytesAvailable;
            while (--bytes >= 0)
            {
                b = readByte();
                if (b != 0)
                {
                    this.byteArray.writeByte(b);
                }
                else
                {
                    try
                    {
                        response = this.byteArray.toString();
                        json = JSON.parse(response);
                        if (Config.isDebugNetwork)
                        {
                            trace("[network] onSocketDataHandler", response);
                        };
                        this.request.handlerJSON(json);
                        if (((!(this.game.world.map == null)) && (!(this.game.world.map.Events == undefined))))
                        {
                            if (json.cmd == "internal")
                            {
                                arr = json.args;
                                if (this.game.world.map.Events[arr[0]] != undefined)
                                {
                                    this.game.world.map.responseEvent(arr[0], arr);
                                };
                            }
                            else
                            {
                                if (this.game.world.map.Events[json.cmd] != undefined)
                                {
                                    this.game.world.map.responseEvent(json.cmd, json);
                                };
                            };
                        };
                    }
                    catch(err:Error)
                    {
                        trace("[Network] onSocketDataHandler", err.getStackTrace());
                    };
                    this.byteArray = new ByteArray();
                };
            };
        }


    }
}//package Main.Network

