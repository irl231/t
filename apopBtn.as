// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//apopBtn

package 
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import fl.motion.Color;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;
    import fl.motion.*;

    public class apopBtn extends Sprite 
    {

        public var txt:TextField;
        public var BG:btnBack;
        private var rootClass:Game;
        private var intAction:int;
        private var locksArr:Array;
        private var intID:int = -1;
        private var strActionData:String;
        private var strAction:*;
        private var strFrame:String;
        private var strMap:String;
        private var strPad:String;
        private var id:int;
        private var tintColor:Color;
        private var parent_:apopScene;
        private var iconClass:Class;
        private var actionParams:Array;

        public function apopBtn(_arg1:MovieClip, _arg2:Object, _arg3:apopScene)
        {
            var _local4:DisplayObject;
            var _local5:Number;
            this.locksArr = [];
            this.tintColor = new Color();
            super();
            this.rootClass = _arg1;
            this.tintColor.setTint(0xFF0000, 0.27);
            this.parent_ = _arg3;
            if (_arg2.width != null)
            {
                this.BG.width = _arg2.width;
            };
            if (_arg2 != null)
            {
                this.intAction = int(_arg2.intAction);
                this.setupLock(String(_arg2.strLocks));
                this.actionParams = String(_arg2.strActionData).split(",");
                this.id = int(_arg2.buttonID);
                this.txt.text = _arg2.buttonText;
                this.txt.mouseEnabled = false;
                if (_arg2.strIcon != null)
                {
                    this.iconClass = this.rootClass.world.getClass(_arg2.strIcon);
                    _local4 = this.addChild(new this.iconClass());
                    _local5 = (25 / _local4.height);
                    _local4.width = (_local4.width * _local5);
                    _local4.height = 25;
                    if (_local4.width < 43)
                    {
                        _local4.x = ((43 - _local4.width) >> 1);
                    };
                    if (_local4.height < 30)
                    {
                        _local4.y = (((30 - _local4.height) >> 1) + 1);
                    };
                };
                this.addEventListener(MouseEvent.MOUSE_UP, this.onClick, false, 0, true);
                this.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                this.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                this.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown, false, 0, true);
                this.buttonMode = true;
            };
        }

        public function get ID():int
        {
            return (this.id);
        }

        private function setupLock(_arg1:String):*
        {
            var _local4:Array;
            var _local3:uint;
            if (_arg1 == null)
            {
                return;
            };
            var _local2:Array = _arg1.split(";");
            while (_local3 < _local2.length)
            {
                _local4 = _local2[_local3].split(",");
                switch (_local4[0])
                {
                    case "QS":
                    case "qs":
                        this.locksArr.push({
                            "strType":_local4[0],
                            "qsIndex":_local4[1],
                            "qsValue":_local4[2]
                        });
                        break;
                    case "mapVar":
                        this.locksArr.push({
                            "strType":_local4[0],
                            "strName":_local4[1]
                        });
                        break;
                    case "rep":
                        this.locksArr.push({
                            "strType":_local4[0],
                            "intRep":_local4[1],
                            "intValue":_local4[2]
                        });
                        break;
                    case "class":
                    case "classor":
                        this.locksArr.push({
                            "strType":_local4[0],
                            "intClass":_local4[1],
                            "intValue":_local4[2]
                        });
                        break;
                    case "item":
                        this.locksArr.push({
                            "strType":_local4[0],
                            "intID":_local4[1]
                        });
                        break;
                    case "upgrade":
                        this.locksArr.push({"strType":"upgrade"});
                        break;
                };
                _local3++;
            };
        }

        private function checkLock():Boolean
        {
            var _local2:uint;
            var _local1:Boolean = true;
            while (_local2 < this.locksArr.length)
            {
                switch (this.locksArr[_local2].strType)
                {
                    case "QS":
                    case "qs":
                        _local1 = ((_local1) && (this.rootClass.getQuestValue(this.locksArr[_local2].qsIndex) >= this.locksArr[_local2].qsValue));
                        break;
                    case "mapVar":
                        _local1 = ((_local1) && (this.rootClass.world.map[this.locksArr[_local2].strName]));
                        break;
                    case "rep":
                        _local1 = ((_local1) && (this.rootClass.world.myAvatar.getRep(this.locksArr[_local2].intRep) >= this.locksArr[_local2].intValue));
                        break;
                    case "class":
                        _local1 = ((_local1) && (this.rootClass.world.myAvatar.getCPByID(this.locksArr[_local2].intClass) >= Number(this.locksArr[_local2].intValue)));
                        break;
                    case "classor":
                        _local1 = ((_local1) || (this.rootClass.world.myAvatar.getCPByID(this.locksArr[_local2].intClass) >= Number(this.locksArr[_local2].intValue)));
                        break;
                    case "item":
                        _local1 = ((_local1) && (this.rootClass.world.myAvatar.isItemInInventory(int(this.locksArr[_local2].intID))));
                        break;
                    case "upgrade":
                        _local1 = ((_local1) && (this.rootClass.world.myAvatar.isUpgraded()));
                        break;
                };
                _local2++;
            };
            return (_local1);
        }

        private function onOut(_arg1:MouseEvent):void
        {
            this.tintColor.setTint(0xFF0000, 0);
            this.transform.colorTransform = this.tintColor;
        }

        private function onOver(_arg1:MouseEvent):void
        {
            this.tintColor.setTint(0xFF0000, 0.27);
            this.transform.colorTransform = this.tintColor;
        }

        private function onDown(_arg1:MouseEvent):void
        {
            this.tintColor.setTint(0xFF0000, 0);
            this.tintColor.brightness = -0.28;
            this.transform.colorTransform = this.tintColor;
        }

        private function onClick(_arg1:MouseEvent):void
        {
            this.tintColor.setTint(0xFF0000, 0);
            this.tintColor.brightness = 0;
            this.transform.colorTransform = this.tintColor;
            if (this.checkLock())
            {
                switch (this.intAction)
                {
                    case 0:
                        this.parent_.Parent.showScene(this.actionParams[0]);
                        return;
                    case 1:
                        this.rootClass.world.sendLoadShopRequest(this.actionParams[0]);
                        return;
                    case 2:
                        this.rootClass.world.sendLoadHairShopRequest(this.actionParams[0]);
                        return;
                    case 3:
                        this.rootClass.world.sendLoadEnhShopRequest(this.actionParams[0]);
                        return;
                    case 4:
                        this.rootClass.world.attachMovieFront(this.actionParams[0]);
                        return;
                    case 5:
                        this.rootClass.loadExternalSWF(this.actionParams[0]);
                        return;
                    case 6:
                        this.rootClass.world.gotoTown(this.actionParams[0], this.actionParams[1], this.actionParams[2]);
                        this.rootClass.removeApop();
                        return;
                    case 7:
                        this.rootClass.world.moveToCell(this.actionParams[0], this.actionParams[1]);
                        return;
                    case 9:
                        this.rootClass.world.acceptQuest(this.parent_.QuestID);
                        this.rootClass.removeApop();
                        return;
                    case 10:
                        this.parent_.Back();
                        return;
                    case 11:
                        this.rootClass.world.tryQuestComplete(this.parent_.QuestID);
                        return;
                    case 12:
                        this.rootClass.world.abandonQuest(this.parent_.QuestID);
                        this.parent_.Back();
                        return;
                };
            };
        }


    }
}//package 

