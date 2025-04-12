// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Chronicle.ChronicleChainElement

package Main.Chronicle
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.*;

    public class ChronicleChainElement extends Sprite 
    {

        public var txtName:TextField;
        public var progress:MovieClip;
        public var txtJoin:TextField;
        public var btnJoin:SimpleButton;
        private var chroniclePanel:ChroniclePanel;
        private var data:Object;

        public function ChronicleChainElement(chroniclePanel:ChroniclePanel, data:Object)
        {
            this.chroniclePanel = chroniclePanel;
            this.data = data;
            this.txtName.text = this.data.Name;
            ChroniclePanel.setProgress(this.progress.progressBar, this.progress.progressText, this.data.Percentage);
            this.txtJoin.mouseEnabled = false;
            if (this.data.Join == null)
            {
                this.txtJoin.visible = false;
                this.btnJoin.visible = false;
            }
            else
            {
                this.btnJoin.addEventListener(MouseEvent.CLICK, this.onJoinClick, false, 0, true);
            };
        }

        private function onJoinClick(event:Event):void
        {
            if (!this.data.IsReleased)
            {
                Game.root.MsgBox.notify("This chronicle is not released yet. Please come back later.");
                return;
            };
            this.chroniclePanel.onClose();
            this.btnJoin.removeEventListener(MouseEvent.CLICK, this.onJoinClick);
            Game.root.world.gotoTown(this.data.Join, "Enter", "Spawn");
        }


    }
}//package Main.Chronicle

