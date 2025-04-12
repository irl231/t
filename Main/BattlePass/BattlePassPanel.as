// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.BattlePass.BattlePassPanel

package Main.BattlePass
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.text.TextField;
    import Main.Controller.LoadController;
    import flash.display.DisplayObject;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import com.greensock.*;
    import Main.Controller.*;

    public class BattlePassPanel extends MovieClip 
    {

        private const rewardsPerPage:int = 10;

        public var game:Game = Game.root;
        public var data:Array;
        public var filteredData:Array = [];
        public var loaders:Array = [];
        private var currentPage:int = 0;
        public var btnClose:SimpleButton;
        public var btnView:SimpleButton;
        public var btnPrevious:SimpleButton;
        public var btnNext:SimpleButton;
        public var btnBack:SimpleButton;
        public var btnQuest:SimpleButton;
        public var loadingDisplay:Sprite;
        public var selectedBattlePass:Object;
        public var rarityGlowDisplay:Sprite;
        public var rewardsDisplay:Sprite;
        public var backgroundDisplay:Sprite;
        public var txtName:TextField;
        public var txtTimeRemaining:TextField;
        public var txtItemName:TextField;
        public var txtItemRarity:TextField;
        public var battlePassPreview:BattlePassPreview;
        public var chkActive:MovieClip;
        public var progressTotal:MovieClip;
        public var loadController:LoadController;

        public function BattlePassPanel()
        {
            this.game.network.send("loadBattlePass", []);
            addFrameScript(0, this.list, 1, this.show);
        }

        public function list():void
        {
            stop();
            this.chkActive.reCheck(true);
            this.chkActive.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnView.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnNext.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnPrevious.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        public function distributeList(list:Array):void
        {
            this.data = list;
            this.applyFilter();
            if (this.filteredData.length > 0)
            {
                this.select(this.filteredData[0]);
            }
            else
            {
                this.showNoBattlePassMessage();
            };
        }

        private function applyFilter():void
        {
            this.filteredData = ((this.chkActive.bitChecked) ? this.data : this.data.filter(function (item:Object, index:int, array:Array):Boolean
{
    return (!(item.isExpired));
}));
        }

        private function showNoBattlePassMessage():void
        {
            this.loadingDisplay.txtLoading.text = "No Battle Pass Available";
            this.clearLoader();
        }

        public function select(data:Object):void
        {
            this.selectedBattlePass = data;
            this.txtName.text = this.selectedBattlePass.name;
            this.clearLoader();
            var key:* = (("battle_pass_" + data.id) + "_junk");
            this.loadController = new LoadController();
            this.loadController.addLoadJunk(data.assets, key, this.onAssetLoadComplete, this.onAssetLoadComplete);
            this.loaders.push(key);
        }

        private function transitionBackground(newBackgroundClass:Class):void
        {
            var newBackground:MovieClip = this.addNewBackground(newBackgroundClass);
            var currentBackground:DisplayObject = this.backgroundDisplay.getChildAt(0);
            this.animateBackgrounds(currentBackground, newBackground);
        }

        private function addNewBackground(newBackgroundClass:Class):MovieClip
        {
            var newBackground:MovieClip;
            newBackground = new (newBackgroundClass)();
            newBackground.x = 0;
            newBackground.y = 0;
            newBackground.mouseChildren = false;
            newBackground.mouseEnabled = false;
            this.backgroundDisplay.addChild(newBackground);
            return (newBackground);
        }

        private function animateBackgrounds(currentBackground:DisplayObject, newBackground:MovieClip):void
        {
            var currentBitmap:Bitmap;
            var currentMovieClip:MovieClip;
            var newBitmap:Bitmap;
            var newMovieClip:MovieClip;
            currentBitmap = this.convertToBitmap(currentBackground);
            currentMovieClip = this.wrapBitmapInMovieClip(currentBitmap);
            var currentIndex:int = this.backgroundDisplay.getChildIndex(currentBackground);
            this.backgroundDisplay.removeChild(currentBackground);
            this.backgroundDisplay.addChildAt(currentMovieClip, currentIndex);
            newBitmap = this.convertToBitmap(newBackground);
            newMovieClip = this.wrapBitmapInMovieClip(newBitmap);
            if (this.backgroundDisplay.contains(newBackground))
            {
                this.backgroundDisplay.removeChild(newBackground);
            };
            newMovieClip.alpha = 0;
            this.backgroundDisplay.addChild(newMovieClip);
            TweenLite.to(currentMovieClip, 1, {
                "alpha":0,
                "onComplete":function ():void
                {
                    if (backgroundDisplay.contains(currentMovieClip))
                    {
                        backgroundDisplay.removeChild(currentMovieClip);
                    };
                    if (currentBitmap.bitmapData)
                    {
                        currentBitmap.bitmapData.dispose();
                    };
                }
            });
            TweenLite.to(newMovieClip, 1, {
                "alpha":1,
                "onComplete":function ():void
                {
                    newMovieClip.alpha = 1;
                    var restoredMovieClip:* = new newBackground.constructor();
                    restoredMovieClip.alpha = 1;
                    var newMovieClipIndex:* = backgroundDisplay.getChildIndex(newMovieClip);
                    backgroundDisplay.removeChild(newMovieClip);
                    backgroundDisplay.addChildAt(restoredMovieClip, newMovieClipIndex);
                    if (newBitmap.bitmapData)
                    {
                        newBitmap.bitmapData.dispose();
                    };
                }
            });
        }

        private function wrapBitmapInMovieClip(bitmap:Bitmap):MovieClip
        {
            var wrapper:MovieClip = new MovieClip();
            wrapper.addChild(bitmap);
            bitmap.x = 0;
            bitmap.y = 0;
            return (wrapper);
        }

        private function convertToBitmap(displayObject:DisplayObject):Bitmap
        {
            var bitmapData:BitmapData = new BitmapData(displayObject.width, displayObject.height, true, 0);
            bitmapData.draw(displayObject);
            return (new Bitmap(bitmapData));
        }

        public function show():void
        {
            stop();
            this.btnNext.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnPrevious.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnBack.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnQuest.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        private function showPage(page:int, immediate:Boolean=false):void
        {
            this.hideRewardDetails();
            if (immediate)
            {
                this.populatePage(page);
                return;
            };
            TweenLite.to(this.rewardsDisplay, 0.2, {
                "alpha":0,
                "onComplete":function ():void
                {
                    populatePage(page);
                    TweenLite.to(rewardsDisplay, 0.2, {"alpha":1});
                }
            });
        }

        private function hideRewardDetails():void
        {
            this.battlePassPreview.visible = false;
            this.battlePassPreview.preview.clearPreview();
            this.rarityGlowDisplay.visible = false;
            this.txtItemName.visible = false;
            this.txtItemRarity.visible = false;
        }

        private function populatePage(page:int):void
        {
            var startIndex:int;
            var reward:Object;
            var battlePassReward:BattlePassReward;
            Game.root.onRemoveChildrens(this.rewardsDisplay);
            startIndex = (page * this.rewardsPerPage);
            var endIndex:int = Math.min((startIndex + this.rewardsPerPage), this.selectedBattlePass.items.length);
            var userBattlePass:Object = this.game.world.myAvatar.getBattlePass(this.selectedBattlePass);
            var i:int = startIndex;
            while (i < endIndex)
            {
                reward = this.selectedBattlePass.items[i];
                battlePassReward = new BattlePassReward(this, reward, ((userBattlePass != null) ? userBattlePass.level : 0));
                battlePassReward.x = ((i - startIndex) * (battlePassReward.width + 11));
                this.rewardsDisplay.addChild(battlePassReward);
                i++;
            };
            this.updateNavigationButtons(page);
        }

        private function updateNavigationButtons(page:int):void
        {
            this.currentPage = page;
            this.btnPrevious.visible = (this.currentPage > 0);
            this.btnNext.visible = (this.currentPage < (Math.ceil((this.selectedBattlePass.items.length / this.rewardsPerPage)) - 1));
        }

        private function clearLoader():void
        {
            this.loaders.forEach(function (key:String, index:int, array:Array):void
            {
                loadController.clearLoader(key);
            });
            this.loaders = [];
        }

        private function onAssetLoadComplete(event:Event=null):void
        {
            var backgroundClass:Class;
            if (this.loadController.applicationDomainJunk.hasDefinition("BattlePassBackground"))
            {
                backgroundClass = Class(this.loadController.applicationDomainJunk.getDefinition("BattlePassBackground"));
                this.transitionBackground(backgroundClass);
            };
            if (contains(this.loadingDisplay))
            {
                removeChild(this.loadingDisplay);
            };
        }

        private function onClick(event:MouseEvent):void
        {
            var userBattlePass1:Object;
            switch (event.currentTarget.name)
            {
                case "btnQuest":
                    if (this.selectedBattlePass.isExpired)
                    {
                        this.game.MsgBox.notify("This Battle Pass Season has already Ended.");
                        return;
                    };
                    userBattlePass1 = this.game.world.myAvatar.getBattlePass(this.selectedBattlePass);
                    if (userBattlePass1 == null)
                    {
                        this.game.MsgBox.notify("Purchase to participate Battle Pass challenges.");
                        return;
                    };
                    this.game.world.showQuests(userBattlePass1.quests.join(","), "q");
                    break;
                case "chkActive":
                    this.distributeList(this.data);
                    this.game.MsgBox.notify((((this.chkActive.bitChecked) ? "Showing" : "Hiding") + " expired Battle Pass."));
                    break;
                case "btnView":
                    gotoAndStop("Show");
                    this.update();
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    this.closePanel();
                    break;
                case "btnBack":
                    gotoAndStop("List");
                    if (contains(this.loadingDisplay))
                    {
                        removeChild(this.loadingDisplay);
                    };
                    this.distributeList(this.data);
                    break;
                case "btnNext":
                    if (currentLabel == "List")
                    {
                        this.navigateToNext();
                    }
                    else
                    {
                        if (currentLabel == "Show")
                        {
                            this.navigateToNextPage();
                        };
                    };
                    break;
                case "btnPrevious":
                    if (currentLabel == "List")
                    {
                        this.navigateToPrevious();
                    }
                    else
                    {
                        if (currentLabel == "Show")
                        {
                            this.navigateToPreviousPage();
                        };
                    };
                    break;
            };
        }

        private function closePanel():void
        {
            if (currentLabel == "Show")
            {
                this.battlePassPreview.preview.item = null;
                this.battlePassPreview.preview.clearPreview();
            };
            this.clearLoader();
            UIController.close("battle_pass");
        }

        public function update():void
        {
            this.showPage(0, true);
            this.txtTimeRemaining.htmlText = ((this.selectedBattlePass.isExpired) ? "<font color='#FF0000'>BATTLE PASS IS OVER</font>" : (("TIME REMAINING: " + this.selectedBattlePass.remainingDays) + " DAYS"));
            this.txtName.text = this.selectedBattlePass.name;
            var userBattlePass2:Object = this.game.world.myAvatar.getBattlePass(this.selectedBattlePass);
            if (((userBattlePass2 == null) || (this.selectedBattlePass.isExpired)))
            {
                this.btnQuest.filters = [new ColorMatrixFilter([0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0.2989, 0.587, 0.114, 0, 0, 0, 0, 0, 1, 0])];
            };
            if (userBattlePass2 == null)
            {
                this.progressTotal.txtProgress.text = "Battle Pass Locked.";
                this.progressTotal.mcRep.scaleX = 0;
                return;
            };
            this.progressTotal.txtProgress.text = (((((userBattlePass2.experience + "/") + userBattlePass2.requiredExperience) + " (Level ") + userBattlePass2.level) + ")");
            this.progressTotal.mcRep.scaleX = (userBattlePass2.experience / userBattlePass2.requiredExperience);
        }

        private function navigateToNext():void
        {
            var nextIndex:int = (this.filteredData.indexOf(this.selectedBattlePass) + 1);
            this.select(this.filteredData[((nextIndex < this.filteredData.length) ? nextIndex : 0)]);
        }

        private function navigateToPrevious():void
        {
            var prevIndex:int = (this.filteredData.indexOf(this.selectedBattlePass) - 1);
            this.select(this.filteredData[((prevIndex >= 0) ? prevIndex : (this.filteredData.length - 1))]);
        }

        private function navigateToNextPage():void
        {
            if (this.currentPage < (Math.ceil((this.selectedBattlePass.items.length / this.rewardsPerPage)) - 1))
            {
                this.showPage((this.currentPage + 1));
            };
        }

        private function navigateToPreviousPage():void
        {
            if (this.currentPage > 0)
            {
                this.showPage((this.currentPage - 1));
            };
        }


    }
}//package Main.BattlePass

