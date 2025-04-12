// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Pet.PetPanel

package Main.Pet
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.display.Sprite;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.geom.ColorTransform;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import Main.Controller.*;

    public class PetPanel extends MovieClip 
    {

        public var currentData:Object;
        public var loaders:Array = [];
        public var btnClose:SimpleButton;
        public var progressTotal:MovieClip;
        public var txtSearch:TextField;
        public var txtLoading:TextField;
        public var listMask:Sprite;
        public var listDisplay:Sprite;
        public var listScroll:LPFElementScrollBar;
        public var viewMask:Sprite;
        public var viewDisplay:PetViewDisplay;
        public var viewScroll:LPFElementScrollBar;
        public var viewHead:MovieClip;
        public var btnBack:SimpleButton;
        public var btnReward:SimpleButton;
        public var list2Mask:Sprite;
        public var list2Display:Sprite;
        public var list2Scroll:LPFElementScrollBar;

        public function PetPanel()
        {
            addFrameScript(0, this.list, 1, this.view);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
        }

        public static function setProgress(progressBar:Sprite, progressText:TextField, percentage:Number):void
        {
            percentage = ((percentage > 100) ? 100 : percentage);
            progressBar.scaleX = (percentage / 100);
            progressText.text = (Math.round(percentage) + "%");
            var colorTransform:ColorTransform = progressBar.transform.colorTransform;
            var color:uint = 0xFF0000;
            if (((percentage >= 50) && (percentage < 100)))
            {
                color = 0xFFA500;
            }
            else
            {
                if (percentage >= 100)
                {
                    color = 0xFF00;
                };
            };
            colorTransform.redMultiplier = (((color >> 16) & 0xFF) / 0xFF);
            colorTransform.greenMultiplier = (((color >> 8) & 0xFF) / 0xFF);
            colorTransform.blueMultiplier = ((color & 0xFF) / 0xFF);
            progressBar.transform.colorTransform = colorTransform;
        }

        public static function sortData(data:Object):Array
        {
            var object:Object;
            var arr:Array = [];
            var zeroArr:Array = [];
            var hundredArr:Array = [];
            for each (object in data)
            {
                if (object.Percentage === 0)
                {
                    zeroArr.push(object);
                }
                else
                {
                    if (object.Percentage >= 100)
                    {
                        hundredArr.push(object);
                    }
                    else
                    {
                        arr.push(object);
                    };
                };
            };
            arr.sortOn("Percentage", (Array.NUMERIC | Array.DESCENDING));
            return (arr.concat(zeroArr, hundredArr));
        }


        private function list():void
        {
            var urlRequest:URLRequest;
            var urlLoader:URLLoader;
            this.clearLoader();
            if (this.listDisplay.numChildren == 0)
            {
                this.listMask.visible = false;
                this.listDisplay.visible = false;
                this.listScroll.visible = false;
                urlRequest = new URLRequest("https://redhero.online/api/user/chronicles/217835");
                urlRequest.method = URLRequestMethod.GET;
                urlLoader = new URLLoader();
                urlLoader.addEventListener(Event.COMPLETE, this.onComplete);
                urlLoader.load(urlRequest);
            };
            stop();
        }

        private function view():void
        {
            this.viewDisplay.txtDescription.autoSize = "left";
            this.btnBack.addEventListener(MouseEvent.CLICK, this.onBackClick, false, 0, true);
            this.btnReward.addEventListener(MouseEvent.CLICK, this.onRewardClick, false, 0, true);
            stop();
        }

        private function clearLoader():void
        {
            var key:String;
            for each (key in this.loaders)
            {
                LoadController.singleton.clearLoader(key);
            };
            this.loaders = [];
        }

        public function onBackClick(event:Event=null):void
        {
            this.gotoAndStop("List");
            this.listMask.visible = false;
            this.listDisplay.visible = false;
            this.listScroll.visible = false;
            this.txtLoading.visible = true;
        }

        public function onRewardClick(event:Event=null):void
        {
            if (this.currentData.Percentage < 100)
            {
                Game.root.MsgBox.notify("Your pet reward is not claimable yet.");
                return;
            };
            Game.root.network.send("claimPet", [this.currentData.id]);
            this.btnReward.filters = [new ColorMatrixFilter([0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0, 0, 0, 1, 0])];
        }

        private function onComplete(event:Event):void
        {
            var pet2:Object;
            var petElement:PetElement;
            var sortedPets:Array = PetPanel.sortData(JSON.parse(event.target.data));
            var i:int;
            var petElementHeight:Number = 45;
            var chainValueCurrent:int;
            var chainValueRequired:int;
            for each (pet2 in sortedPets)
            {
                petElement = PetElement(this.listDisplay.addChild(new PetElement(this, pet2)));
                petElement.y = (petElementHeight * i);
                chainValueCurrent = (chainValueCurrent + pet2.ChainValueCurrent);
                chainValueRequired = (chainValueRequired + pet2.ChainValueRequired);
                i++;
            };
            Game.configureScroll(this.listDisplay, this.listMask, this.listScroll);
            PetPanel.setProgress(this.progressTotal.progressBar, this.progressTotal.progressText, (Math.round((((chainValueCurrent / chainValueRequired) * 100) * 100)) / 100));
            this.listMask.visible = true;
            this.listDisplay.visible = true;
            this.listScroll.visible = true;
            this.txtLoading.visible = false;
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            this.clearLoader();
            UIController.close("pet");
        }


    }
}//package Main.Pet

