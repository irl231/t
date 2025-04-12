// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.War.WarPanel

package Main.War
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class WarPanel extends MovieClip 
    {

        private var game:Game = Game.root;
        public var mcMeter:MovieClip;
        public var btnNormal:SimpleButton;
        public var btnMega:SimpleButton;
        public var data:Object;

        public function WarPanel(data:Object)
        {
            this.data = data;
            this.btnNormal.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnMega.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        public function update(data:Object):*
        {
            if (data.warProgress > data.warTotal)
            {
                data.warProgress = data.warTotal;
            };
            var percent:* = (data.warProgress / data.warTotal);
            this.mcMeter.warPcnt.text = (int((percent * 100)) + "%");
            this.mcMeter.warBar.x = (this.mcMeter.warBar.width * (percent - 1));
            this.mcMeter.txtStatus.text = (((((("Turn in Medals to help " + data.warName) + " side win! (") + int(data.warProgress)) + "/") + int(data.warTotal)) + ")");
        }

        private function onClick(event:MouseEvent):void
        {
            var normal:Object;
            var mega:Object;
            switch (event.currentTarget.name)
            {
                case "btnNormal":
                    for each (normal in this.data.questNormalRequirements)
                    {
                        if (!this.game.world.myAvatar.checkTempItem(normal.id, normal.quantity))
                        {
                            this.game.addUpdate((((("You need " + normal.name) + " ") + normal.quantity) + "x."));
                            this.game.mixer.playSound("Bad");
                            return;
                        };
                    };
                    this.game.world.tryQuestComplete(this.data.questNormalId);
                    break;
                case "btnMega":
                    for each (mega in this.data.questMegaRequirements)
                    {
                        if (!this.game.world.myAvatar.checkTempItem(mega.id, mega.quantity))
                        {
                            this.game.addUpdate((((("You need " + mega.name) + " ") + mega.quantity) + "x."));
                            this.game.mixer.playSound("Bad");
                            return;
                        };
                    };
                    this.game.world.tryQuestComplete(this.data.questMegaId);
                    break;
            };
        }


    }
}//package Main.War

