// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Building

package 
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Building 
    {

        public var bLoaded:Boolean = false;
        public var bLoading:Boolean = false;
        private var Lot:int = -1;
        private var Linkage:String;
        private var enterPad:String;
        private var buildSize:int;
        private var strFileName:String;
        private var buildingLoader:GuildLoader;
        private var parent:Object;
        private var buildingExt:MovieClip;
        private var rootClass:Game;
        private var bc:Class;
        private var buildingInterior:Interior;
        private var Setup:Boolean = false;
        private var mcBuilding:MovieClip;
        private var checkLoad:Timer;
        private var buildingError:Boolean = false;

        public function Building(_arg_1:String, _arg_2:String, _arg_3:Object, _arg_4:Game)
        {
            var _local_7:uint;
            super();
            this.parent = _arg_3;
            this.rootClass = _arg_4;
            var _local_5:Array = _arg_1.split(",");
            var _local_6:Array = [];
            while (_local_7 < _local_5.length)
            {
                _local_6 = _local_5[_local_7].split(":");
                switch (_local_6[0])
                {
                    case "slot":
                        this.Lot = int(_local_6[1]);
                        break;
                    case "linkage":
                        this.Linkage = _local_6[1];
                        break;
                    case "pad":
                        this.enterPad = _local_6[1];
                        break;
                    case "size":
                        this.buildSize = _local_6[1];
                        break;
                    case "file":
                        this.strFileName = _local_6[1];
                        break;
                };
                _local_7++;
            };
        }

        public function get BuildingExt():MovieClip
        {
            return (this.buildingExt);
        }

        public function get lot():int
        {
            return (this.Lot);
        }

        public function get BuildingMap():MovieClip
        {
            return (this.mcBuilding);
        }

        public function get BuildingCopy():MovieClip
        {
            return (new this.bc() as MovieClip);
        }

        public function get interior():Interior
        {
            return (this.buildingInterior);
        }

        public function set interior(_arg_1:Interior):*
        {
            this.buildingInterior = _arg_1;
        }

        public function get cellSetup():Boolean
        {
            return (this.Setup);
        }

        public function set cellSetup(_arg_1:Boolean):*
        {
            this.Setup = _arg_1;
        }

        public function get Link():String
        {
            return (this.Linkage);
        }

        public function get Size():int
        {
            return (this.buildSize);
        }

        public function loadBuildingFile():int
        {
            this.buildingLoader = new GuildLoader(this.onBuildLoadComplete, ("maps/" + this.strFileName), this.rootClass, this.Linkage, -1, this.onBuildLoadError);
            this.bLoading = true;
            return (1);
        }

        public function Load():void
        {
            if (((!(this.bLoaded)) && (!(this.buildingError))))
            {
                this.checkLoad = new Timer(1000, 1);
                this.checkLoad.addEventListener(TimerEvent.TIMER, this.onTimer, false, 0, true);
                this.checkLoad.start();
            };
        }

        private function onBuildLoadComplete(_arg_1:GuildLoader):void
        {
            this.bLoaded = true;
            this.mcBuilding = _arg_1.swfContent;
            this.rootClass.world.addChildAt(this.mcBuilding, 0).x = 0;
            this.buildingExt = MovieClip(new _arg_1.swfClass());
            this.parent.parent.updateBuildingLoad();
        }

        private function onBuildLoadError():void
        {
            this.buildingError = true;
            this.parent.parent.updateBuildingLoad();
        }

        private function onTimer(_arg_1:TimerEvent):void
        {
            if (((this.bLoaded) && (!(this.buildingError))))
            {
                this.checkLoad.stop();
                this.checkLoad.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this.parent.addBuildingToMap(("Lot" + String(this.Lot)));
            }
            else
            {
                this.checkLoad.stop();
                this.checkLoad.reset();
                this.checkLoad.start();
            };
        }


    }
}//package 

