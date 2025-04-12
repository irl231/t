// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcNPCTool

package 
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.Controller.*;
    import Main.*;

    public class mcNPCTool extends Sprite 
    {

        public var targetName:TextField;
        public var txtFrame:TextField;
        public var txtCell:TextField;
        public var txtX:TextField;
        public var txtY:TextField;
        public var txtScale:TextField;
        public var btnClose:SimpleButton;
        public var target:AvatarMC = null;
        public var currentScale:Number;

        public function mcNPCTool()
        {
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            Game.root.stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelWorld);
            new Drag(this, this);
        }

        private function onMouseWheelWorld(e:MouseEvent):void
        {
            if (((!(this.target)) || (!(this.target.mcChar))))
            {
                return;
            };
            this.currentScale = this.target.mcChar.scaleX;
            if (e.delta > 0)
            {
                this.zoomIn();
            }
            else
            {
                this.zoomOut();
            };
        }

        private function zoomIn():void
        {
            var scale:Number = (this.currentScale * 2);
            if (scale >= 100)
            {
                scale = 100;
            };
            this.setScale(scale);
        }

        private function zoomOut():void
        {
            var scale:Number = (this.currentScale * 0.9);
            if (scale <= 0.1)
            {
                scale = 0.1;
            };
            this.setScale(scale);
        }

        private function setScale(value:Number):void
        {
            this.currentScale = value;
            this.target.scale(this.currentScale);
            if (this.target.name.indexOf("_CORE_NPC") > -1)
            {
                this.onPositionChange();
            }
            else
            {
                if (this.target.name.indexOf("previewMCB") > -1)
                {
                    this.onPositionChange();
                };
            };
        }

        public function onPositionChange():void
        {
            this.txtFrame.text = Game.root.world.strFrame;
            this.txtCell.text = Game.root.world.strPad;
            this.txtX.text = this.target.x;
            this.txtY.text = this.target.y;
            if (this.target.name.indexOf("_CORE_NPC") > -1)
            {
                this.txtScale.text = (this.currentScale * 10);
            }
            else
            {
                if (this.target.name.indexOf("previewMCB") > -1)
                {
                    this.txtScale.text = this.currentScale;
                };
            };
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            Game.root.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelWorld);
            if (this.target.name.indexOf("_CORE_NPC") > -1)
            {
                Game.root.network.send("npcSave", [1, this.target.pAV.objData.NpcMapID, this.target.x, this.target.y, (this.currentScale * 10)]);
            }
            else
            {
                if (this.target.name.indexOf("previewMCB") > -1)
                {
                    Game.root.network.send("npcSave", [2, this.target.pAV.objData.NpcMapID, this.target.x, this.target.y, this.currentScale]);
                };
            };
            UIController.close("npc_tool");
        }


    }
}//package 

