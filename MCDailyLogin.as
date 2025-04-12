// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//MCDailyLogin

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import Main.*;

    public dynamic class MCDailyLogin extends MovieClip 
    {

        public var btnClaim:SimpleButton;
        public var btnClose:SimpleButton;
        public var isClaimable:Boolean = false;
        public var mcDay1:MovieClip;
        public var mcDay2:MovieClip;
        public var mcDay3:MovieClip;
        public var mcDay4:MovieClip;
        public var mcDay5:MovieClip;
        public var mcDay6:MovieClip;
        public var mcDay7:MovieClip;
        public var btnChestOpen1:MovieClip;
        public var btnChestOpen2:MovieClip;
        public var btnChestOpen3:MovieClip;
        public var btnChestOpen4:MovieClip;
        public var btnChestOpen5:MovieClip;
        public var btnChestOpen6:MovieClip;
        public var btnChestOpen7:MovieClip;
        public var btnChestClose1:MovieClip;
        public var btnChestClose2:MovieClip;
        public var btnChestClose3:MovieClip;
        public var btnChestClose4:MovieClip;
        public var btnChestClose5:MovieClip;
        public var btnChestClose6:MovieClip;
        public var btnChestClose7:MovieClip;
        public var btnChestAvailable1:SimpleButton;
        public var btnChestAvailable2:SimpleButton;
        public var btnChestAvailable3:SimpleButton;
        public var btnChestAvailable4:SimpleButton;
        public var btnChestAvailable5:SimpleButton;
        public var btnChestAvailable6:SimpleButton;
        public var btnChestAvailable7:SimpleButton;

        public function MCDailyLogin()
        {
            addFrameScript(0, this.frame1);
        }

        public function initChests():void
        {
            var maxDays:int = 7;
            var loginDay:int = Game.root.world.myAvatar.objData.daily.Day;
            var claimDate:Date = Game.root.stringToDate(Game.root.world.myAvatar.objData.daily.Date);
            var todayDate:Date = Game.root.date_server;
            todayDate.date--;
            this.isClaimable = (todayDate > claimDate);
            if (this.isClaimable)
            {
                this.btnClaim.filters = [];
            }
            else
            {
                this.btnClaim.filters = [new ColorMatrixFilter([0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0, 0, 0, 1, 0])];
            };
            var currentDay:int = 1;
            while (currentDay <= maxDays)
            {
                if (((this.isClaimable) && (currentDay == loginDay)))
                {
                    this[("btnChestOpen" + currentDay)].visible = false;
                    this[("btnChestAvailable" + currentDay)].visible = true;
                    this[("btnChestClose" + currentDay)].visible = false;
                }
                else
                {
                    if (currentDay < loginDay)
                    {
                        this[("btnChestAvailable" + currentDay)].visible = false;
                        this[("btnChestClose" + currentDay)].visible = false;
                        this[("btnChestOpen" + currentDay)].visible = true;
                    }
                    else
                    {
                        if (((loginDay == 1) && (!(this.isClaimable))))
                        {
                            this[("btnChestOpen" + currentDay)].visible = true;
                            this[("btnChestAvailable" + currentDay)].visible = false;
                            this[("btnChestClose" + currentDay)].visible = false;
                        }
                        else
                        {
                            this[("btnChestOpen" + currentDay)].visible = false;
                            this[("btnChestAvailable" + currentDay)].visible = false;
                            this[("btnChestClose" + currentDay)].visible = true;
                        };
                    };
                };
                currentDay++;
            };
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }

        private function frame1():void
        {
            this.mcDay1.strTitle.htmlText = "Day 1";
            this.mcDay1.strDesc.htmlText = "Coins Guaranteed.";
            this.mcDay1.strAmount.htmlText = Config.getString("daily_coins_1");
            this.mcDay1.mcDragon.visible = false;
            this.mcDay2.strTitle.htmlText = "Day 2";
            this.mcDay2.strDesc.htmlText = "Coins Guaranteed.";
            this.mcDay2.strAmount.htmlText = Config.getString("daily_coins_2");
            this.mcDay2.mcDragon.visible = false;
            this.mcDay3.strTitle.htmlText = "Day 3";
            this.mcDay3.strDesc.htmlText = "Coins Guaranteed.";
            this.mcDay3.strAmount.htmlText = Config.getString("daily_coins_3");
            this.mcDay3.mcDragon.visible = false;
            this.mcDay4.strTitle.htmlText = "Day 4";
            this.mcDay4.strDesc.htmlText = "Coins Guaranteed.";
            this.mcDay4.strAmount.htmlText = Config.getString("daily_coins_4");
            this.mcDay4.mcDragon.visible = false;
            this.mcDay5.strTitle.htmlText = "Day 5";
            this.mcDay5.strDesc.htmlText = "Coins Guaranteed.";
            this.mcDay5.strAmount.htmlText = Config.getString("daily_coins_5");
            this.mcDay5.mcDragon.visible = false;
            this.mcDay6.strTitle.htmlText = "Day 6";
            this.mcDay6.strDesc.htmlText = "Coins Guaranteed.";
            this.mcDay6.strAmount.htmlText = Config.getString("daily_coins_6");
            this.mcDay6.mcDragon.visible = false;
            this.mcDay7.strTitle.htmlText = "Day 7";
            this.mcDay7.strDesc.htmlText = "Coins Guaranteed.";
            this.mcDay7.strAmount.htmlText = Config.getString("daily_coins_7");
            this.mcDay7.mcCoin.visible = false;
            this.btnClaim.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.initChests();
            stop();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnClaim":
                    if (this.isClaimable)
                    {
                        Game.root.network.send("claimDailyLogin", []);
                        MovieClip(parent).onClose();
                        return;
                    };
                    Game.root.MsgBox.notify("Your daily login reward is not claimable yet, come back later.");
                    return;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    return;
            };
        }


    }
}//package 

