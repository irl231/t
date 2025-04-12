// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildLoader

package 
{
    import flash.display.MovieClip;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.display.*;
    import flash.net.*;
    import Main.Controller.*;

    public class GuildLoader 
    {

        private var lContent:MovieClip;
        private var lClass:Class;
        private var fct:Function;
        private var fctError:Function;
        private var fileName:String;
        private var Linkage:String;
        private var ItemID:int;
        private var bLoaded:Boolean = false;
        private var swfLoader:URLLoader = new URLLoader();
        private var game:Game;

        public function GuildLoader(callback:Function, fileName:String, game:Game, linkage:String, itemID:int=-1, callbackError:Function=null)
        {
            this.game = game;
            this.fct = callback;
            this.fctError = callbackError;
            this.fileName = fileName;
            this.Linkage = linkage;
            this.ItemID = itemID;
            LoadController.singleton.addLoadMap(fileName, "map", this.onswfLoadComplete, this.onswfLoadError);
        }

        public function get Loaded():Boolean
        {
            return (this.bLoaded);
        }

        public function get swfClass():Class
        {
            return (this.lClass);
        }

        public function get swfContent():MovieClip
        {
            return (this.lContent);
        }

        public function get ID():int
        {
            return (this.ItemID);
        }

        public function getClass(_arg_1:String):Class
        {
            return (this.game.world.getClass(_arg_1));
        }

        private function onswfLoadComplete(_arg_1:Event):void
        {
            this.lClass = this.game.world.getClass(this.Linkage);
            this.lContent = MovieClip(_arg_1.target.content);
            this.bLoaded = true;
            this.fct(this);
        }

        private function onswfLoadError(_arg_1:IOErrorEvent):void
        {
            if (this.fctError != null)
            {
                this.fctError();
            };
        }


    }
}//package 

