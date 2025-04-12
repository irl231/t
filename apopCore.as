// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//apopCore

package 
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;

    public class apopCore extends Sprite 
    {

        public var mcBG:MovieClip;
        public var btnClose:SimpleButton;
        public var txtName:TextField;
        public var txtTitle:TextField;
        private var rootClass:Game;
        private var apopData:Object;
        private var apopScenes:Object;
        private var currentScene:apopScene;
        private var nullScene:apopScene;
        private var questArray:Array;
        private var mcNPC:MovieClip;
        private var finalX:Number;

        public function apopCore(_arg1:MovieClip, _arg2:Object)
        {
            var _local3:apopScene;
            var _local4:Array;
            var _local7:uint;
            var _local5:uint;
            this.apopScenes = {};
            this.questArray = [];
            super();
            this.rootClass = _arg1;
            this.txtName.text = _arg2.strName;
            this.txtTitle.text = _arg2.strTitle;
            while (_local5 < _arg2.arrScenes.length)
            {
                _local3 = new apopScene(this.rootClass, _arg2.arrScenes[_local5], this);
                if (_local3.ID != -1)
                {
                    this.apopScenes[_local3.ID] = _local3;
                    if (_arg2.arrScenes[_local5].arrQuests != null)
                    {
                        _local4 = String(_arg2.arrScenes[_local5].arrQuests).split(",");
                        _local7 = 0;
                        while (_local7 < _local4.length)
                        {
                            _local3 = new apopScene(this.rootClass, {
                                "bType":true,
                                "sceneID":_local4[_local7],
                                "bStart":false,
                                "qID":_local4[_local7]
                            }, this);
                            if (_local3.ID != -1)
                            {
                                this.apopScenes[("q" + String(_local3.ID))] = _local3;
                            };
                            _local7++;
                        };
                    };
                };
                _local5++;
            };
            this.nullScene = new apopScene(this.rootClass, {
                "bType":false,
                "strText":"This text is broken, please report this bug using the bug tracker. http://www.artix.com/bugs",
                "ID":-1,
                "bStart":false
            }, this);
            this.nullScene.x = 5;
            this.nullScene.y = 60;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.showScene(this.getStartScene());
            var _local6:Class = this.rootClass.world.map.getNPC(_arg2.strNpc);
            this.mcNPC = (this.addChildAt((new (_local6)() as MovieClip), 0) as MovieClip);
            this.finalX = (this.mcNPC.x - 80);
            this.mcNPC.y = (this.mcNPC.y + 130);
            this.mcNPC.x = (this.mcNPC.x - 160);
            this.addEventListener(Event.ENTER_FRAME, this.animateNPC, false, 0, true);
        }

        public function showScene(_arg1:int, _arg2:Boolean=false, _arg3:Boolean=false):void
        {
            var _local4:int = -1;
            if (this.currentScene != null)
            {
                _local4 = ((_arg2) ? -1 : this.currentScene.ID);
                this.removeChild(this.currentScene);
            };
            this.currentScene = ((_arg3) ? this.apopScenes[("q" + String(_arg1))] : this.apopScenes[_arg1]);
            if (this.currentScene != null)
            {
                this.currentScene.x = 15;
                this.currentScene.y = 60;
                this.currentScene.init(_local4);
                this.addChild(this.currentScene);
                this.mcBG.height = (this.currentScene.mcGold.height + 80);
            }
            else
            {
                this.currentScene = this.nullScene;
                this.addChild(this.nullScene);
            };
        }

        public function questComplete(questID:int):void
        {
            if (this.currentScene.ID == questID)
            {
                this.currentScene.Back();
            };
        }

        public function getScene(_arg1:int):*
        {
            return (this.apopScenes[_arg1]);
        }

        public function getQuestScene(_arg1:String):*
        {
            return (this.apopScenes[_arg1]);
        }

        private function getStartScene():int
        {
            var _local1:apopScene;
            var _local2:apopScene;
            var _local3:*;
            for (_local3 in this.apopScenes)
            {
                if (this.apopScenes[_local3].Start)
                {
                    _local2 = this.apopScenes[_local3];
                    if (!_local2.Locked)
                    {
                        if (_local1 == null)
                        {
                            _local1 = _local2;
                        }
                        else
                        {
                            if (_local2.ID > _local1.ID)
                            {
                                _local1 = _local2;
                            };
                        };
                    };
                };
            };
            return ((_local1 != null) ? _local1.ID : -1);
        }

        private function onClick(_arg1:MouseEvent):void
        {
            this.rootClass.removeApop();
        }

        private function animateNPC(_arg1:Event):void
        {
            this.mcNPC.x = (this.mcNPC.x + 10);
            if (this.mcNPC.x >= this.finalX)
            {
                this.mcNPC.x = this.finalX;
                this.removeEventListener(Event.ENTER_FRAME, this.animateNPC);
            };
        }


    }
}//package 

