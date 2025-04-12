// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Option.CheckBoxMC

package Main.Option
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CheckBoxMC extends MovieClip 
    {

        public var game:Game = Game.root;
        public var txtName:TextField;
        public var chkActive:MovieClip;
        public var objData:Object;
        public var mcBackground:MovieClip;

        public function CheckBoxMC()
        {
            super();
            this.chkActive.checkmark.visible = false;
            this.chkActive.addEventListener(MouseEvent.CLICK, this.onToggle);
            this.addEventListener(MouseEvent.MOUSE_OVER, function (event:MouseEvent):void
            {
                game.ui.ToolTip.openWith({"str":objData.strDescription});
            });
            this.addEventListener(MouseEvent.MOUSE_OUT, function (event:MouseEvent):void
            {
                game.ui.ToolTip.close();
            });
        }

        public function set(data:Object, width:Number):*
        {
            this.objData = data;
            this.txtName.text = this.objData.strName;
            this.mcBackground.width = width;
            this.chkActive.x = (this.mcBackground.width - this.chkActive.width);
            this.chkActive.checkmark.visible = this.objData.bEnabled;
        }

        private function onToggle(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "chkActive":
                    this.chkActive.checkmark.visible = (!(this.chkActive.checkmark.visible));
                    this.objData.callback();
                    break;
            };
        }


    }
}//package Main.Option

