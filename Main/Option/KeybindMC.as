// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Option.KeybindMC

package Main.Option
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.utils.Dictionary;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.events.*;
    import flash.utils.*;
    import flash.ui.*;

    public class KeybindMC extends MovieClip 
    {

        public var game:Game = Game.root;
        public var txtName:TextField;
        public var txtKey:TextField;
        public var btnSetKeybindActive:MovieClip;
        public var objData:Object;
        public var keyDictionary:Dictionary;
        public var mcBackground:MovieClip;

        public function KeybindMC()
        {
            super();
            this.txtKey.mouseEnabled = false;
            this.btnSetKeybindActive.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OVER, function (event:MouseEvent):void
            {
                game.ui.ToolTip.openWith({"str":objData.strDescription});
            });
            this.addEventListener(MouseEvent.MOUSE_OUT, function (event:MouseEvent):void
            {
                game.ui.ToolTip.close();
            });
        }

        private function getKeyboardDict():Dictionary
        {
            var keyboardInfo:XML = describeType(Keyboard);
            var keyNames:XMLList = keyboardInfo.constant.@name;
            var keyboardDict:Dictionary = new Dictionary();
            var i:int;
            while (i < keyNames.length())
            {
                keyboardDict[Keyboard[keyNames[i]]] = keyNames[i];
                i++;
            };
            return (keyboardDict);
        }

        public function set(data:Object, width:Number):*
        {
            this.objData = data;
            this.keyDictionary = this.getKeyboardDict();
            this.txtName.text = this.objData.strName;
            this.mcBackground.width = width;
            this.btnSetKeybindActive.x = ((this.mcBackground.width - this.btnSetKeybindActive.width) - 5.85);
            this.txtKey.x = ((this.mcBackground.width - this.btnSetKeybindActive.width) - 5.85);
            if (this.game.userPreference.data["keys"])
            {
                this.txtKey.text = ((this.game.userPreference.data["keys"][this.objData.strName]) ? this.keyDictionary[this.game.userPreference.data["keys"][this.objData.strName]] : "NONE");
            };
        }

        private function cleanupEventListeners():void
        {
            if (((this.game.stage) && (this.game.stage.hasEventListener(KeyboardEvent.KEY_DOWN))))
            {
                this.game.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            };
            if (((this.game.stage) && (this.game.stage.hasEventListener(MouseEvent.MOUSE_DOWN))))
            {
                this.game.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseExit);
            };
        }

        public function key(actionName:String, keyCode:uint):void
        {
            var keyLabel:String;
            var skillIndex:String;
            this.game.userPreference.data["keys"][actionName] = keyCode;
            if ((((actionName.indexOf("Auto Attack") > -1) || (actionName.indexOf("Skill ") > -1)) || (actionName.indexOf("Item") > -1)))
            {
                keyLabel = ((keyCode != 0) ? this.game.keyboardDictionary[keyCode] : " ");
                if (actionName == "Auto Attack")
                {
                    this.game.ui.mcInterface.getChildByName("keyA0").text = keyLabel;
                }
                else
                {
                    if (actionName == "Item")
                    {
                        this.game.ui.mcInterface.getChildByName("keyA5").text = keyLabel;
                    }
                    else
                    {
                        skillIndex = actionName.split(" ")[1];
                        this.game.ui.mcInterface.getChildByName(("keyA" + skillIndex)).text = keyLabel;
                    };
                };
            };
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnSetKeybindActive":
                    this.txtKey.text = "...";
                    this.game.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
                    this.game.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseExit);
                    break;
            };
        }

        public function onKeyDown(event:KeyboardEvent):void
        {
            event.preventDefault();
            event.stopPropagation();
            var newKey:uint = event.keyCode;
            this.cleanupEventListeners();
            if (((newKey == Keyboard.ENTER) || (newKey == 191)))
            {
                this.txtKey.text = this.keyDictionary[this.game.userPreference.data["keys"][this.objData.strName]];
                return;
            };
            if (((newKey >= 96) && (newKey <= 105)))
            {
                newKey = (newKey - 48);
            };
            if (newKey == Keyboard.BACKSPACE)
            {
                this.txtKey.text = "NONE";
                newKey = 0;
            }
            else
            {
                this.txtKey.text = this.keyDictionary[newKey];
            };
            this.key(this.objData.strName, newKey);
            this.objData.value = newKey;
        }

        private function onMouseExit(event:MouseEvent):void
        {
            this.cleanupEventListeners();
            this.txtKey.text = this.keyDictionary[this.game.userPreference.data["keys"][this.objData.strName]];
        }


    }
}//package Main.Option

