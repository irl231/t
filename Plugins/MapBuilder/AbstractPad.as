// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.AbstractPad

package Plugins.MapBuilder
{
    import flash.display.MovieClip;
    import Main.Drag;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import Main.*;

    public class AbstractPad extends MovieClip 
    {

        private var rootClass:Game = Game.root;
        private var container:MovieClip = new MovieClip();
        protected var drag:Drag;
        protected var parameters:Object;
        protected var value:Object;
        public var hasPads:Boolean = false;
        public var isEvent:Boolean = false;
        public var isProp:Boolean = false;
        public var isSolid:Boolean = false;
        public var isMonster:Boolean = false;

        public function AbstractPad(data:Object)
        {
            this.value = data;
            this.mouseEnabled = false;
            if (this.value)
            {
                this.parameters = this.parseParameters(this.value.parameters);
                this.visible = false;
                this.enableInteraction();
                this.rootClass.world.mapController.mapping.push(this);
            };
        }

        public function setPosition(x:Number, y:Number):void
        {
            this.x = x;
            this.y = y;
        }

        public function setSize(height:Number, width:Number):void
        {
            this.height = height;
            this.width = width;
            this.applyFlip();
        }

        public function isLock():Boolean
        {
            return (this.value.isLock == 1);
        }

        public function isFlip():Boolean
        {
            return (this.value.isFlip == 1);
        }

        public function isHide():Boolean
        {
            return (this.value.isHide == 1);
        }

        public function setVisible(value:Boolean):void
        {
            if ((this is Walkable))
            {
                this.alpha = ((value) ? 0.5 : 0);
                this.visible = true;
            }
            else
            {
                this.visible = ((this.value.parameters == "visible") || (value));
            };
            if (value)
            {
                if (!this.isLock())
                {
                    this.drag = new Drag(this, this);
                };
                this.initInputs();
            }
            else
            {
                this.removeContainer();
                if (this.drag)
                {
                    this.drag.destroy();
                };
            };
        }

        public function remove():void
        {
            this.removeContainer();
            if (parent.contains(this))
            {
                parent.removeChild(this);
            };
        }

        private function save():void
        {
            this.rootClass.network.send("frameSave", [this.value.id, this.value.parameters, this.value.height, this.value.width, this.value.x, this.value.y]);
        }

        private function lock():void
        {
            this.rootClass.network.send("frameLock", [this.value.id, this.value.parameters, this.value.height, this.value.width, this.value.x, this.value.y]);
        }

        private function initInputs():void
        {
            var spacing:Number;
            var inputY:Number;
            this.removeContainer();
            this.container = new MovieClip();
            parent.addChild(this.container);
            spacing = 5;
            var buttons:Array = this.createButtons(spacing);
            var buttonsBottomY:Number = 0;
            if (buttons.length > 0)
            {
                buttonsBottomY = (buttons[0].y + buttons[0].height);
            };
            if (((!(this.isLock())) && (!(this.isHide()))))
            {
                inputY = (buttonsBottomY + spacing);
                this.addInput("value", this.value.parameters, this.x, inputY, this.handleValueChange);
                inputY = (inputY + (new Input().height + spacing));
                this.addInput("height", this.height.toString(), this.x, inputY, this.handleHeightChange);
                inputY = (inputY + (new Input().height + spacing));
                this.addInput("width", this.width.toString(), this.x, inputY, this.handleWidthChange);
                this.container.y = -(this.container.height);
            };
            if (((this.isLock()) || (this.isHide())))
            {
                this.container.x = 0;
                this.container.y = 0;
            };
            this.enforceStageBoundaries(this.container);
        }

        private function enforceStageBoundaries(displayObject:MovieClip):void
        {
            var stageBounds:Object;
            var bounds:*;
            stageBounds = {
                "width":stage.stageWidth,
                "height":stage.stageHeight
            };
            bounds = displayObject.getBounds(parent);
            var isInsideStage:Boolean = ((((bounds.left >= 0) && (bounds.right <= stageBounds.width)) && (bounds.top >= 0)) && (bounds.bottom <= stageBounds.height));
            if ((((this.isLock()) || (this.isHide())) && (isInsideStage)))
            {
                displayObject.x = 0;
                displayObject.y = 0;
                return;
            };
            if (bounds.left < 0)
            {
                displayObject.x = (displayObject.x - bounds.left);
            }
            else
            {
                if (bounds.right > stageBounds.width)
                {
                    displayObject.x = (displayObject.x - (bounds.right - stageBounds.width));
                };
            };
            if (bounds.top < 0)
            {
                displayObject.y = (displayObject.y - bounds.top);
            }
            else
            {
                if (bounds.bottom > stageBounds.height)
                {
                    displayObject.y = (displayObject.y - (bounds.bottom - stageBounds.height));
                };
            };
        }

        private function parseParameters(param:String):Object
        {
            return ((param.indexOf("|") >= 0) ? param.split("|") : "");
        }

        private function applyFlip():void
        {
            if (this.isFlip())
            {
                this.scaleX = -(Math.abs(this.scaleX));
            };
        }

        private function enableInteraction():void
        {
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            if (!this.isLock())
            {
                this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            };
            this.mouseEnabled = true;
        }

        private function removeContainer():void
        {
            if (parent.contains(this.container))
            {
                parent.removeChild(this.container);
            };
        }

        private function addInput(label:String, text:String, x:Number, y:Number, onChange:Function):void
        {
            var input:Input = new Input();
            input.value.text = text;
            input.x = x;
            input.y = y;
            input.visible = ((!(this.isLock())) && (!(this.isHide())));
            input.value.addEventListener(Event.CHANGE, function (event:Event):void
            {
                onChange(TextField(event.target).text);
            });
            this.container.addChild(input);
        }

        private function createButtons(spacing:Number):Array
        {
            var config:Object;
            var button:MovieClip;
            var buttonConfigs:Array = [{
                "classRef":btnDelete,
                "xMultiplier":0,
                "label":"Hide",
                "action":this.hideConfirm,
                "visible":(!(this.isLock()))
            }, {
                "classRef":btnRemove,
                "xMultiplier":1,
                "label":"Delete",
                "action":this.deleteConfirm,
                "visible":(!(this.isLock()))
            }, {
                "classRef":btnAdd,
                "xMultiplier":2,
                "label":"Duplicate",
                "action":this.duplicateConfirm,
                "visible":(!(this.isLock()))
            }, {
                "classRef":btnLock,
                "xMultiplier":3,
                "label":((this.isLock()) ? "Unlock" : "Lock"),
                "action":this.lockConfirm,
                "visible":true
            }, {
                "classRef":btnFlip,
                "xMultiplier":4,
                "label":"Flip",
                "action":this.flipConfirm,
                "visible":(!(this.isLock()))
            }, {
                "classRef":btnSave,
                "xMultiplier":5,
                "label":"Save",
                "action":this.saveConfirm,
                "visible":(!(this.isLock()))
            }];
            var buttons:Array = [];
            for each (config in buttonConfigs)
            {
                button = new config.classRef();
                button.x = ((this.isLock()) ? this.x : (this.x + ((button.width + spacing) * config.xMultiplier)));
                button.y = (this.y - button.height);
                button.buttonMode = true;
                button.visible = config.visible;
                if (button.visible)
                {
                    this.addButtonClickListener(button, config.label, config.action);
                };
                this.container.addChild(button);
                buttons.push(button);
            };
            return (buttons);
        }

        private function addButtonClickListener(button:MovieClip, label:String, action:Function):void
        {
            button.addEventListener(MouseEvent.CLICK, function (event:MouseEvent):void
            {
                if (label == "Hide")
                {
                    action();
                }
                else
                {
                    MainController.modal((("Would you like to " + label) + " this frame build?"), action, {}, "white,medium", "dual");
                };
            });
        }

        private function deleteConfirm(event:Object):void
        {
            if (event.accept)
            {
                this.rootClass.network.send("frameDelete", [this.value.id]);
            };
        }

        private function duplicateConfirm(event:Object):void
        {
            if (event.accept)
            {
                this.rootClass.network.send("frameDuplicate", [this.value.id]);
            };
        }

        private function hideConfirm():void
        {
            this.rootClass.network.send("frameHide", [this.value.id]);
        }

        private function lockConfirm(event:Object):void
        {
            if (event.accept)
            {
                this.lock();
            };
        }

        private function flipConfirm(event:Object):void
        {
            if (event.accept)
            {
                this.rootClass.network.send("frameFlip", [this.value.id]);
            };
        }

        private function saveConfirm(event:Object):void
        {
            if (event.accept)
            {
                this.save();
            };
        }

        private function handleValueChange(newValue:String):void
        {
            this.value.parameters = newValue;
        }

        private function handleHeightChange(newValue:String):void
        {
            this.height = parseFloat(newValue);
            this.value.height = this.height;
            this.applyFlip();
        }

        private function handleWidthChange(newValue:String):void
        {
            this.width = parseFloat(newValue);
            this.value.width = this.width;
            this.applyFlip();
        }

        private function onMouseDown(event:MouseEvent):void
        {
            if (!this.isLock())
            {
                this.removeContainer();
            }
            else
            {
                this.rootClass.world.onWalkClick();
            };
        }

        private function onMouseUp(event:MouseEvent):void
        {
            if (((!(this.value.x == this.x)) || (!(this.value.y == this.y))))
            {
                this.value.x = this.x;
                this.value.y = this.y;
                this.initInputs();
                this.save();
            };
        }


    }
}//package Plugins.MapBuilder

