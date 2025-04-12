// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//MCRelationship

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class MCRelationship extends MovieClip 
    {

        public var rootClass:Game = Game.root;
        public var btnButton:SimpleButton;
        public var btnClose:SimpleButton;
        public var txtName:TextField;
        public var chkMarry:MovieClip;
        public var chkAdopt:MovieClip;

        public function MCRelationship()
        {
            addFrameScript(0, this.frame1);
        }

        private function frame1():void
        {
            this.btnButton.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            stop();
        }

        private function sendMarry(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.world.sendMarryInvite(obj.name);
            };
        }

        private function sendAdopt(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.world.sendAdoptInvite(obj.name);
            };
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnButton":
                    if (this.txtName.text == "")
                    {
                        this.rootClass.MsgBox.notify("Please insert a name!");
                        return;
                    };
                    if ((((this.chkMarry.bitChecked) && (this.chkAdopt.bitChecked)) || ((!(this.chkMarry.bitChecked)) && (!(this.chkAdopt.bitChecked)))))
                    {
                        this.rootClass.MsgBox.notify("Please select at least one option!");
                        return;
                    };
                    if (this.chkMarry.bitChecked)
                    {
                        MainController.modal((("Are you really going to marry " + this.txtName.text) + "?"), this.sendMarry, {"name":this.txtName.text}, "red,medium", "dual");
                        return;
                    };
                    if (this.chkAdopt.bitChecked)
                    {
                        MainController.modal((("Are you really going to adopt " + this.txtName.text) + "?"), this.sendAdopt, {"name":this.txtName.text}, "red,medium", "dual");
                        return;
                    };
                    this.txtName.text = "";
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }


    }
}//package 

