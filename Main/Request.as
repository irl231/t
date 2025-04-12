// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Request

package Main
{
    import Main.Aqw.LPF.LPFLayoutInvShopEnh;
    import Main.Aqw.LPF.LPFLayoutAuction;
    import Main.Aqw.LPF.LPFLayoutBank;
    import Main.Aqw.LPF.LPFLayoutTrade;
    import Main.Network.User;
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import Main.Model.ShopModel;
    import flash.events.Event;
    import Main.Stats.StatsPanel;
    import Main.UI.AbstractDropFrame;
    import Main.Model.Skill;
    import fl.motion.Color;
    import Main.WorldBoss.WorldBossPanel;
    import Main.BattlePass.BattlePassPanel;
    import Main.WorldBoss.WorldBossInvite;
    import Game_fla.mcPopup_323;
    import flash.geom.ColorTransform;
    import Main.Aqw.Outfit.OutfitPanel;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import Main.UI.*;
    import Main.Network.*;
    import fl.motion.*;
    import flash.utils.*;
    import Main.Aqw.Outfit.*;
    import Main.BattlePass.*;
    import Main.Aqw.LPF.*;
    import Main.Controller.*;
    import Main.Controller.Bot.*;
    import Game_fla.*;
    import Main.WorldBoss.*;
    import Main.Customization.*;
    import Main.Stats.*;
    import Main.War.*;

    public class Request 
    {

        private var game:Game;
        private var s:String = "";
        private var o:Object;
        private var nam:String;
        private var item:*;
        private var qi:String;
        private var qr:String;
        private var qj:String;
        private var qk:String;
        private var qat:Array;
        private var ri:*;
        private var m:*;
        private var stuS:String;
        private var cd:*;
        private var pst:Number = NaN;
        private var pct:Number = NaN;

        public function Request(game:Game)
        {
            this.game = game;
        }

        private static function onAssetLoadComplete(avatar:Avatar):void
        {
            if (avatar.isMyAvatar)
            {
                setTimeout(function ():void
                {
                    Game.root.network.send("sAct", []);
                }, 700);
            };
        }

        private static function inventoryRefresh():void
        {
            var lpfLayoutInvShopEnh:LPFLayoutInvShopEnh = LPFLayoutInvShopEnh(mcPopup_323(Game.root.ui.mcPopup).getChildByName("mcInventory"));
            if (lpfLayoutInvShopEnh == null)
            {
                return;
            };
            lpfLayoutInvShopEnh.update({"eventType":"refreshItems"});
        }

        private static function marketRefresh():void
        {
            var lpfLayoutAuction:LPFLayoutAuction = LPFLayoutAuction(Game.root.ui.mcPopup.getChildByName("mcAuction"));
            lpfLayoutAuction.update({"eventType":"refreshItems"});
            lpfLayoutAuction.update({"eventType":"refreshBank"});
            lpfLayoutAuction.update({"eventType":"refreshInventory"});
        }

        private static function bankRefresh():void
        {
            var lpfLayoutBank:LPFLayoutBank = LPFLayoutBank(Game.root.ui.mcPopup.getChildByName("mcBank"));
            lpfLayoutBank.update({"eventType":"refreshItems"});
            lpfLayoutBank.update({"eventType":"refreshBank"});
            lpfLayoutBank.update({"eventType":"refreshInventory"});
        }

        private static function tradeRefresh():void
        {
            var lpfLayoutTrade:LPFLayoutTrade = LPFLayoutTrade(Game.root.ui.mcPopup.getChildByName("mcTrade"));
            lpfLayoutTrade.update({"eventType":"refreshItems"});
            lpfLayoutTrade.update({"eventType":"refreshBank"});
            lpfLayoutTrade.update({"eventType":"refreshInventory"});
        }


        public function handlerSTR(array:Array):void
        {
            switch (array[0])
            {
                case "iterator":
                    this.iterator();
                    break;
                case "loginMulti":
                    this.loginMulti(array);
                    break;
                case "notify":
                    this.notify(array);
                    break;
                case "notifyBox":
                    this.notifyBox(array);
                    break;
                case "logoutWarning":
                    this.logoutWarning(array);
                    break;
                case "multiLoginWarning":
                    this.multiLoginWarning();
                    break;
                case "serverf":
                    this.serverf(array);
                    break;
                case "server":
                case "moderator":
                case "guardian":
                case "game":
                case "wheel":
                case "daily":
                case "warning":
                    this.defaultMessage(array);
                    break;
                case "administrator":
                case "admin":
                    this.administrator(array);
                    break;
                case "gsupdate":
                    this.gsupdate(array);
                    break;
                case "frostupdate":
                    this.frostupdate(array);
                    break;
                case "respawnMon":
                    this.respawnMon(array);
                    break;
                case "respawnNpc":
                    this.respawnNpc(array);
                    break;
                case "resSkill":
                    this.resSkill(array);
                    break;
                case "resTimed":
                    this.resTimed(array);
                    break;
                case "exitArea":
                    this.exitArea(array);
                    break;
                case "uotls":
                    this.uotlsSTR(array);
                    break;
                case "mtls":
                    this.mtlsSTR(array);
                    break;
                case "spcs":
                    this.spcs(array);
                    break;
                case "cc":
                    this.cc(array);
                    break;
                case "emotea":
                    this.emotea(array);
                    break;
                case "em":
                    this.em(array);
                    break;
                case "chatm":
                    this.chatm(array);
                    break;
                case "whisper":
                    this.whisper(array);
                    break;
                case "alliance":
                    this.alliance(array);
                    break;
                case "mute":
                    this.mute(array);
                    break;
                case "unmute":
                    this.unmute();
                    break;
                case "mvna":
                    this.mvna();
                    break;
                case "mvnb":
                    this.mvnb();
                    break;
                case "gtc":
                    this.gtc(array);
                    break;
                case "mtcid":
                    this.mtcid(array);
                    break;
                case "hi":
                    this.hi();
                    break;
                case "Dragon Buff":
                    this.DragonBuff();
                    break;
                case "trap door":
                    this.trapDoor(array);
                    break;
                case "gMOTD":
                    this.gMOTDSTR(array);
                    break;
            };
        }

        public function handlerJSON(data:Object):void
        {
            switch (data.cmd)
            {
                case "internal":
                    this.handlerSTR(data.args);
                    break;
                case "joinRoom":
                    this.joinRoom(data);
                    break;
                case "enterRoom":
                    this.enterRoom(data);
                    break;
                case "userGone":
                    this.userGone(data);
                    break;
                case "loginResponse":
                    this.loginResponse(data);
                    break;
                case "who":
                    this.who(data);
                    break;
                case "al":
                    this.al(data);
                    break;
                case "ds":
                    this.ds(data);
                    break;
                case "reloadmap":
                    this.reloadmap(data);
                    break;
                case "convertToCoins":
                    this.convertToCoins(data);
                    break;
                case "moveToArea":
                    this.moveToArea(data);
                    break;
                case "initUserData":
                    this.initUserData(data);
                    break;
                case "saveHouse":
                    this.saveHouse(data);
                    break;
                case "initUserDatas":
                    this.initUserDatas(data);
                    break;
                case "changeChatColor":
                    this.changeChatColor(data);
                    break;
                case "increaseVip":
                    this.increaseVip(data);
                    break;
                case "changeColor":
                    this.changeColor(data);
                    break;
                case "changeArmorColor":
                    this.changeArmorColor(data);
                    break;
                case "killStreak":
                    this.killStreak(data);
                    break;
                case "addGoldExp":
                    this.addGoldExp(data);
                    break;
                case "levelUp":
                    this.levelUp(data);
                    break;
                case "loadInventoryBig":
                    this.loadInventoryBig(data);
                    break;
                case "friends":
                    this.friends(data);
                    break;
                case "initInventory":
                    this.initInventory(data);
                    break;
                case "house":
                    this.house(data);
                    break;
                case "buyBagSlots":
                    this.buyBagSlots(data);
                    break;
                case "buyBankSlots":
                    this.buyBankSlots(data);
                    break;
                case "buyHouseSlots":
                    this.buyHouseSlots(data);
                    break;
                case "claimDailyLogin":
                    this.claimDailyLogin(data);
                    break;
                case "buyAuctionSlots":
                    this.buyAuctionSlots(data);
                    break;
                case "buyVendingSlots":
                    this.buyVendingSlots(data);
                    break;
                case "callfct":
                    this.callfct(data);
                    break;
                case "genderSwap":
                    this.genderSwap(data);
                    break;
                case "renameCharacter":
                    this.renameCharacter(data);
                    break;
                case "loadBank":
                    this.loadBank(data);
                    break;
                case "bankFromInv":
                    this.bankFromInv(data);
                    break;
                case "bankToInv":
                    this.bankToInv(data);
                    break;
                case "bankSwapInv":
                    this.bankSwapInv(data);
                    break;
                case "loadShop":
                    this.loadShop(data);
                    break;
                case "loadEnhShop":
                    this.loadEnhShop(data);
                    break;
                case "enhanceItemShop":
                    this.enhanceItemShop(data);
                    break;
                case "enhanceItemLocal":
                    this.enhanceItemLocal(data);
                    break;
                case "loadHairShop":
                    this.loadHairShop(data);
                    break;
                case "buyItem":
                    this.buyItem(data);
                    break;
                case "sellItem":
                    this.sellItem(data);
                    break;
                case "removeItem":
                    this.removeItem(data);
                    break;
                case "updateClass":
                    this.updateClass(data);
                    break;
                case "equipItem":
                    this.equipItem(data);
                    break;
                case "customizeItem":
                    this.customizeItem(data);
                    break;
                case "unequipItem":
                    this.unequipItem(data);
                    break;
                case "dropItem":
                    this.dropItem(data);
                    break;
                case "referralReward":
                    this.referralReward(data);
                    break;
                case "denyDrop":
                    this.denyDrop(data);
                    break;
                case "getDrop":
                    this.getDrop(data);
                    break;
                case "loadConfig":
                    this.loadConfig(data);
                    break;
                case "addItems":
                    this.addItems(data);
                    break;
                case "Wheel":
                    this.Wheel(data);
                    break;
                case "powerGem":
                    this.powerGem(data);
                    break;
                case "forceAddItem":
                    this.forceAddItem(data);
                    break;
                case "warvalues":
                    this.warvalues(data);
                    break;
                case "enhp":
                    this.enhp(data);
                    break;
                case "mtc":
                    this.mtc(data);
                    break;
                case "turnIn":
                    this.turnIn(data);
                    break;
                case "acceptQuest":
                    this.acceptQuest(data);
                    break;
                case "retrieveQuests":
                    this.retrieveQuests(data);
                    break;
                case "getQuests":
                    this.getQuests(data);
                    break;
                case "getQuests2":
                    this.getQuests2(data);
                    break;
                case "ccqr":
                    this.ccqr(data);
                    break;
                case "updateQuest":
                    this.updateQuest(data);
                    break;
                case "showQuestLink":
                    this.showQuestLink(data);
                    break;
                case "frameUpdate":
                    this.frameUpdate(data);
                    break;
                case "initMonData":
                    this.initMonData(data);
                    break;
                case "aura+":
                case "aura*":
                case "aura-":
                case "aura--":
                case "aura++":
                case "aura+p":
                    this.aura(data);
                    break;
                case "clearAuras":
                    this.clearAuras();
                    break;
                case "uotls":
                    this.uotls(data);
                    break;
                case "mtls":
                    this.mtls(data);
                    break;
                case "ntls":
                    this.ntls(data);
                    break;
                case "cb":
                    this.cb(data);
                    break;
                case "ct":
                    this.ct(data);
                    break;
                case "updateTemporaryItems":
                    this.updateTemporaryItems(data);
                    break;
                case "sar":
                    this.sar(data);
                    break;
                case "sars":
                    this.sars(data);
                    break;
                case "showAuraResult":
                    this.showAuraResult(data);
                    break;
                case "anim":
                    this.anim(data);
                    break;
                case "sAct":
                    this.sAct(data);
                    break;
                case "seia":
                    this.seia(data);
                    break;
                case "stu":
                    this.stu(data);
                    break;
                case "cvu":
                    this.cvu(data);
                    break;
                case "event":
                    this.event(data);
                    break;
                case "ia":
                    this.ia(data);
                    break;
                case "siau":
                    this.siau(data);
                    break;
                case "umsg":
                    this.umsg(data);
                    break;
                case "gi":
                    this.gi(data);
                    break;
                case "gd":
                    this.gd(data);
                    break;
                case "ga":
                    this.ga(data);
                    break;
                case "gr":
                    this.gr(data);
                    break;
                case "setRank":
                    this.setRank(data);
                    break;
                case "guildLeave":
                    this.guildLeave(data);
                    break;
                case "guildDelete":
                    this.guildDelete(data);
                    break;
                case "gMOTD":
                    this.gMOTD(data);
                    break;
                case "gDescription":
                    this.gDescription(data);
                    break;
                case "updateGuild":
                    this.updateGuild(data);
                    break;
                case "updateParty":
                    this.updateParty(data);
                    break;
                case "updatePartyRank":
                    this.updatePartyRank(data);
                    break;
                case "gc":
                    this.gc(data);
                    break;
                case "buyGSlots":
                    this.buyGSlots(data);
                    break;
                case "gRename":
                    this.gRename(data);
                    break;
                case "interior":
                    this.interior(data);
                    break;
                case "guildhall":
                    this.guildhall(data);
                    break;
                case "guildinv":
                    this.guildinv(data);
                    break;
                case "psri":
                    this.psri(data);
                    break;
                case "pi":
                    this.pi(data);
                    break;
                case "pr":
                    this.pr(data);
                    break;
                case "pp":
                    this.pp(data);
                    break;
                case "ps":
                    this.ps(data);
                    break;
                case "pd":
                    this.pd(data);
                    break;
                case "pc":
                    this.pc();
                    break;
                case "PVPQ":
                    this.PVPQ(data);
                    break;
                case "PVPI":
                    this.PVPI(data);
                    break;
                case "PVPE":
                    this.PVPE(data);
                    break;
                case "PVPS":
                    this.PVPS(data);
                    break;
                case "PVPC":
                    this.PVPC(data);
                    break;
                case "pvpbreakdown":
                    this.pvpbreakdown();
                    break;
                case "di":
                    this.di(data);
                    break;
                case "guildWarInvite":
                    this.guildWarInvite(data);
                    break;
                case "mi":
                    this.mi(data);
                    break;
                case "adi":
                    this.adi(data);
                    break;
                case "DuelEX":
                    this.DuelEX();
                    break;
                case "loadFactions":
                    this.loadFactions(data);
                    break;
                case "addFaction":
                    this.addFaction(data);
                    break;
                case "loadFriendsList":
                    this.loadFriendsList(data);
                    break;
                case "requestFriend":
                    this.requestFriend(data);
                    break;
                case "addFriend":
                    this.addFriend(data);
                    break;
                case "updateFriend":
                    this.updateFriend(data);
                    break;
                case "deleteFriend":
                    this.deleteFriend(data);
                    break;
                case "serverRate":
                    this.serverRate(data);
                    break;
                case "isModerator":
                    this.isModerator(data);
                    break;
                case "loadWarVars":
                    this.loadWarVars(data);
                    break;
                case "setAchievement":
                    this.setAchievement(data);
                    break;
                case "loadQuestStringData":
                    this.loadQuestStringData(data);
                    break;
                case "getAdData":
                    this.getAdData(data);
                    break;
                case "getAdReward":
                    this.getAdReward(data);
                    break;
                case "xpboost":
                    this.game.manageXPBoost(data);
                    break;
                case "gboost":
                    this.game.manageGBoost(data);
                    break;
                case "repboost":
                    this.game.manageRepBoost(data);
                    break;
                case "cpboost":
                    this.game.manageCPBoost(data);
                    break;
                case "cboost":
                    this.game.manageCoinBoost(data);
                    break;
                case "gettimes":
                    this.gettimes(data);
                    break;
                case "clockTick":
                    this.clockTick(data);
                    break;
                case "castWait":
                    this.castWait(data);
                    break;
                case "alchOnStart":
                    this.alchOnStart(data);
                    break;
                case "alchComplete":
                    this.alchComplete(data);
                    break;
                case "bookInfo":
                    this.bookInfo(data);
                    break;
                case "titleInfo":
                    this.titleInfo(data);
                    break;
                case "chatInfo":
                    this.chatInfo(data);
                    break;
                case "spellOnStart":
                    this.spellOnStart(data);
                    break;
                case "spellComplete":
                    this.spellComplete(data);
                    break;
                case "spellWaitTimer":
                    this.spellWaitTimer(data);
                    break;
                case "playerDeath":
                    this.playerDeath(data);
                    break;
                case "getScrolls":
                    this.getScrolls(data);
                    break;
                case "turninscroll":
                    this.turninscroll(data);
                    break;
                case "getapop":
                    this.getapop(data);
                    break;
                case "startTrade":
                    this.startTrade(data);
                    break;
                case "ti":
                    this.ti(data);
                    break;
                case "loadOffer":
                    this.loadOffer(data);
                    break;
                case "tradeDeal":
                    this.tradeDeal(data);
                    break;
                case "tradeCancel":
                    this.tradeCancel(data);
                    break;
                case "tradeLock":
                    this.tradeLock(data);
                    break;
                case "tradeUnlock":
                    this.tradeUnlock(data);
                    break;
                case "tradeFromInv":
                    this.tradeFromInv(data);
                    break;
                case "tradeToInv":
                    this.tradeToInv(data);
                    break;
                case "tradeSwapInv":
                    this.tradeSwapInv(data);
                    break;
                case "updateTitle":
                    this.updateTitle(data);
                    break;
                case "updateChat":
                    this.updateChat(data);
                    break;
                case "updateGoldCoins":
                    this.updateGoldCoins(data);
                    break;
                case "buyAuctionItem":
                    this.buyAuctionItem(data);
                    break;
                case "sellAuctionItem":
                    this.sellAuctionItem(data);
                    break;
                case "retrieveAuctionItem":
                    this.retrieveAuctionItem(data);
                    break;
                case "retrieveAuctionItems":
                    this.retrieveAuctionItems(data);
                    break;
                case "loadAuction":
                    this.loadAuction(data);
                    break;
                case "loadRetrieve":
                    this.loadRetrieve(data);
                    break;
                case "searchItem":
                    this.searchItem(data);
                    break;
                case "sendLinkedItems":
                    this.sendLinkedItems(data);
                    break;
                case "sendLinkedEmojis":
                    this.sendLinkedEmojis(data);
                    break;
                case "loadWorldBoss":
                    this.loadWorldBoss(data);
                    break;
                case "updateBattlePass":
                    this.updateBattlePass(data);
                    break;
                case "loadBattlePass":
                    this.loadBattlePass(data);
                    break;
                case "loadGuildAttribute":
                    this.loadGuildAttribute(data);
                    break;
                case "WorldBossInvite":
                    this.worldBossInvite(data);
                    break;
                case "loadMenu":
                    this.loadMenu(data);
                    break;
                case "raidInvite":
                    this.raidInvite(data);
                    break;
                case "raidUpdate":
                    this.raidUpdate(data);
                    break;
                case "loadCookBook":
                    this.loadCookBook(data);
                    break;
                case "cookResult":
                    this.cookResult(data);
                    break;
                case "consumeFood":
                    this.consumeFood(data);
                    break;
                case "queueUpdate":
                    this.queueUpdate(data);
                    break;
                case "loadGuildList":
                    this.loadGuildList(data);
                    break;
                case "updatePartner":
                    this.updatePartner(data);
                    break;
                case "rebirthPlayer":
                    this.rebirthPlayer();
                    break;
                case "botProcess":
                    this.botProcess(data);
                    break;
                case "updateEnergy":
                    this.updateEnergy(data);
                    break;
                case "coreStatUpdate":
                    this.coreStatUpdate(data);
                    break;
                case "unpackEmoji":
                    this.unpackEmoji(data);
                    break;
                case "serverTime":
                    this.serverTime(data);
                    break;
                case "wearItem":
                    this.wearItem(data);
                    break;
                case "unwearItem":
                    this.unwearItem(data);
                    break;
                case "crossLogin":
                    this.crossLogin(data);
                    break;
                case "updateResource":
                    this.updateResource(data);
                    break;
                case "loadPrefs":
                    this.loadPrefs(data);
                    break;
                case "addLoadout":
                    this.addLoadout(data);
                    break;
                case "removeLoadout":
                    this.removeLoadout(data);
                    break;
                case "buyLoadoutSlots":
                    this.buyLoadoutSlots(data);
                    break;
                default:
                    trace("[Requests] Unhandled CMD", data.cmd);
                    this.game.chatF.pushMsg("warning", ("Unhandled CMD " + data.cmd), "SERVER", "", 0);
            };
            data = null;
        }

        private function joinRoom(data:Object):void
        {
            var user:Object;
            var u:User;
            this.game.network.room = new Room();
            for each (user in data.users)
            {
                u = new User(user.networkId, user.username);
                u.setPlayerId(user.networkId);
                this.game.network.room.addUser(u, user.networkId);
            };
        }

        private function enterRoom(data:Object):void
        {
            var u2:User = new User(data.networkId, data.username);
            u2.setPlayerId(data.networkId);
            this.game.network.room.addUser(u2, data.networkId);
        }

        private function userGone(data:Object):void
        {
            this.game.network.room.removeUser(data.networkId);
        }

        private function loginResponse(data:Object):void
        {
            if (data.success)
            {
                this.game.mcConnDetail.showConn("Loading Character Data...");
                this.game.network.myUserId = data.networkId;
                this.game.network.myUserName = data.username;
                this.game.ts_login_client = new Date().getTime();
                this.game.ts_login_server = this.game.stringToDate(data.time).getTime();
                this.game.confirmTime = getTimer();
                this.game.version.setting = data.setting;
                this.game.asset.init();
            }
            else
            {
                this.game.mcConnDetail.showError(data.message);
            };
        }

        private function iterator():void
        {
            this.game.network.close();
        }

        private function loginMulti(data:Array):void
        {
            if (!((data[2] == 1) || (data[2] == "true")))
            {
                this.game.mcConnDetail.showError("Login Failed!");
            };
        }

        private function notify(data:Array):void
        {
            this.game.chatF.pushMsg("server", Chat.cleanStr(data[2]), "SERVER", "", 0);
            this.game.MsgBox.notify(Chat.cleanStr(data[2]));
        }

        private function notifyBox(data:Array):void
        {
            MainController.modal(data[3], null, {}, data[2], "mono", true);
        }

        private function logoutWarning(data:Array):void
        {
            this.game.userPreference.data.logoutWarning = String(data[2]);
            this.game.userPreference.data.logoutWarningDur = 60;
            this.game.userPreference.data.logoutWarningTS = new Date().getTime();
            try
            {
                this.game.userPreference.flush();
            }
            catch(e:Error)
            {
                trace("[Request] logoutWarning", e.getStackTrace());
            };
        }

        private function multiLoginWarning():void
        {
            this.game.mcConnDetail.showError((((("Your account has been logged on from another computer. Please log back in to play. If you cannot login, please contact Staff via our help page:<br/> <u><a href='" + Config.serverRetrieveURL) + "' target='_blank'>") + Config.serverRetrieveURL) + "</a></u>"));
        }

        private function serverf(data:Array):void
        {
            this.game.chatF.pushMsg("server", String(data[2]), "SERVER", "", 0);
        }

        private function defaultMessage(data:Array):void
        {
            this.game.chatF.pushMsg(data[0], Chat.cleanStr(data[2]), "SERVER", "", 0);
        }

        private function administrator(data:Array):void
        {
            this.game.chatF.pushMsg("administrator", Chat.cleanStr(data[2]), "SERVER", "", 0);
        }

        private function gsupdate(data:Array):void
        {
            try
            {
                this.game.world.map.killCount(data[2]);
            }
            catch(e:Error)
            {
            };
        }

        private function frostupdate(data:Array):void
        {
            try
            {
                this.game.world.map.frostWar(data[2], data[3]);
            }
            catch(e:Error)
            {
            };
        }

        private function respawnMon(data:Array):void
        {
            var monMapId:int;
            var monster:Avatar;
            var monLeaf:Object;
            var pMC:MonsterMC;
            if (this.game.sfcSocial)
            {
                monMapId = data[2];
                monster = this.game.world.getMonster(monMapId);
                monLeaf = this.game.world.monTree[monMapId];
                if ((((!(monLeaf == null)) && (!(monster.objData == null))) && (monster.objData.strFrame == this.game.world.strFrame)))
                {
                    monLeaf.targets = {};
                    pMC = MonsterMC(monster.pMC);
                    pMC.respawn();
                    pMC.x = pMC.ox;
                    pMC.y = pMC.oy;
                    if (((Boolean(monster.objData.bRed)) && (this.game.world.myAvatar.dataLeaf.intState > 0)))
                    {
                        this.game.world.aggroMon(monMapId);
                    };
                    if (("eventTrigger" in this.game.world.map))
                    {
                        this.game.world.map.eventTrigger({
                            "cmd":"monRespawn",
                            "monMapId":monMapId
                        });
                    };
                };
            };
        }

        private function respawnNpc(data:Array):void
        {
            var npcMapId:int;
            var npc:Avatar;
            var npcLeaf:Object;
            if (this.game.sfcSocial)
            {
                npcMapId = data[2];
                npc = this.game.world.getNpc(npcMapId);
                npcLeaf = this.game.world.npcTree[npcMapId];
                if ((((!(npcLeaf == null)) && (!(npc.objData == null))) && (npc.objData.strFrame == this.game.world.strFrame)))
                {
                    npcLeaf.targets = {};
                    if (npc.objData.eqp.en != null)
                    {
                        MovieClip(npc.pMC.getChildAt(1)).gotoAndPlay("Idle");
                    }
                    else
                    {
                        npc.pMC.mcChar.gotoAndPlay("Getup");
                    };
                    npc.pMC.apopbutton.visible = true;
                    npc.pMC.walkTo(npc.objData.X, npc.objData.Y, this.game.world.WALKSPEED);
                };
            };
        }

        private function resSkill(data:Array):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (avt != null)
            {
                if (avt.isMyAvatar)
                {
                    this.game.world.map.transform.colorTransform = this.game.world.defaultCT;
                    this.game.world.CHARS.transform.colorTransform = this.game.world.defaultCT;
                };
                avt.pMC.mcChar.gotoAndPlay("Getup");
            };
        }

        private function resTimed(data:Array):void
        {
            if ((((((this.game.world.spawnPoint.strFrame == "") && (this.game.world.spawnPoint.strPad == "")) && (data.length > 2)) && (!(String(data[2]) == null))) && (!(String(data[3]) == null))))
            {
                this.game.world.moveToCell(String(data[2]), String(data[3]));
            }
            else
            {
                this.game.world.moveToCell(this.game.world.spawnPoint.strFrame, this.game.world.spawnPoint.strPad);
            };
            this.game.world.map.transform.colorTransform = this.game.world.defaultCT;
            this.game.world.CHARS.transform.colorTransform = this.game.world.defaultCT;
        }

        private function exitArea(data:Array):void
        {
            var uid:int;
            uid = int(data[2]);
            this.game.world.manageAreaUser(String(data[3]), "-");
            var avt:Avatar = this.game.world.avatars[uid];
            if (avt != null)
            {
                if (avt == this.game.world.myAvatar.target)
                {
                    this.game.world.setTarget(null);
                };
                this.game.world.destroyAvatar(uid);
                delete this.game.world.uoTree[data[3]];
            };
        }

        private function uotlsSTR(data:Array):void
        {
            this.o = {};
            var a:Array = data[3].split(",");
            var i:int;
            while (i < a.length)
            {
                this.o[a[i].split(":")[0]] = a[i].split(":")[1];
                i++;
            };
            this.game.userTreeWrite(String(data[2]), this.o);
        }

        private function mtlsSTR(data:Array):void
        {
            this.o = {};
            var a:Array = data[3].split(",");
            var i:int;
            while (i < a.length)
            {
                this.o[a[i].split(":")[0]] = a[i].split(":")[1];
                i++;
            };
            this.game.monsterTreeWrite(int(data[2]), this.o);
        }

        private function spcs(data:Array):void
        {
            var clMon:*;
            var MonMapID:int = int(data[2]);
            var MonID:int = int(data[3]);
            var monLeaf:Object = this.game.world.monTree[MonMapID];
            var newmon:Object = {};
            var i:int;
            while (i < this.game.world.mondef.length)
            {
                if (this.game.world.mondef[i].MonID == MonID)
                {
                    newmon = this.game.world.mondef[i];
                    i = this.game.world.mondef.length;
                };
                i++;
            };
            monLeaf.intHP = 0;
            monLeaf.intMP = 0;
            monLeaf.intHPMax = newmon.intHPMax;
            monLeaf.intMPMax = newmon.intMPMax;
            monLeaf.intState = 0;
            monLeaf.iLvl = newmon.iLvl;
            monLeaf.MonID = MonID;
            var cluster:* = this.game.world.getMonsterCluster(MonMapID);
            i = 0;
            while (i < cluster.length)
            {
                clMon = cluster[i];
                if (monLeaf.MonID == clMon.objData.MonID)
                {
                    if (monLeaf.strFrame == this.game.world.strFrame)
                    {
                        this.game.world.CHARS.addChild(clMon.pMC);
                    };
                    clMon.dataLeaf = monLeaf;
                }
                else
                {
                    if (monLeaf.strFrame == this.game.world.strFrame)
                    {
                        this.game.world.TRASH.addChild(clMon.pMC);
                    };
                    clMon.dataLeaf = null;
                };
                i++;
            };
        }

        private function cc(data:Array):void
        {
            var filter:Boolean;
            var strMsg:String = Chat.getCCText(data[2]);
            var username:String = data[3];
            if (((!(this.game.chatF.ignoreList.data.users == undefined)) && (this.game.chatF.ignoreList.data.users.indexOf(username) > -1)))
            {
                filter = true;
            };
            if (!filter)
            {
                this.game.chatF.pushMsg("zone", strMsg, username, "", 0);
            };
        }

        private function emotea(data:Array):void
        {
            var strLabel:* = String(data[2]);
            var uid:int = int(data[3]);
            var pMC:MovieClip = this.game.world.getMCByUserID(uid);
            if (pMC != null)
            {
                pMC.mcChar.gotoAndPlay(this.game.strToProperCase(strLabel));
            };
        }

        private function em(data:Array):void
        {
            this.game.chatF.pushMsg("event", Chat.cleanStr(String(data[3])), data[2], "", 0);
        }

        private function chatm(data:Array):void
        {
            var filter:Boolean;
            var message:String = Chat.cleanStr(data[2], true, false, Boolean(int(data[6])));
            var username:String = String(data[3]);
            if (((!(this.game.chatF.ignoreList.data.users == undefined)) && (this.game.chatF.ignoreList.data.users.indexOf(username.toLowerCase()) > -1)))
            {
                filter = true;
            };
            if (!filter)
            {
                this.game.chatF.pushMsg(message.substr(0, message.indexOf("~")), message.substr((message.indexOf("~") + 1)), username, data[4], 0, int(data[6]));
            };
        }

        private function alliance(data:Array):void
        {
            var identity:String;
            var HighH:int;
            var HighW:int;
            var LowH:int;
            var LowW:int;
            var chatBoxMCNew:ChatBoxMC;
            var filter:Boolean;
            var guild:String = String(data[3]);
            var alliance:String = String(data[4]);
            var sender:String = String(data[5]);
            var message:String = Chat.cleanStr(data[2]);
            if (message.indexOf(":=sm") > -1)
            {
                message = message.substr(0, message.indexOf(":=sm"));
            };
            if (((!(this.game.chatF.ignoreList.data.users == undefined)) && (this.game.chatF.ignoreList.data.users.indexOf(guild.toLowerCase()) > -1)))
            {
                filter = true;
            };
            if (!filter)
            {
                if (guild.toLowerCase() != this.game.network.myUserName.toLowerCase())
                {
                    this.game.chatF.pmSourceA = [guild];
                    if (this.game.chatF.pmSourceA.length > 20)
                    {
                        this.game.chatF.pmSourceA.splice(0, (this.game.chatF.pmSourceA.length - 20));
                    };
                };
                if (data[5] == 1)
                {
                    this.game.chatF.pushMsg("alliance", message, guild, alliance, sender, 0);
                    this.game.chatF.pushMsg("alliance", message, guild, alliance, sender, 1);
                }
                else
                {
                    if (alliance == guild)
                    {
                        return;
                    };
                    identity = ((alliance.toLowerCase() == this.game.world.myAvatar.objData.guild.Name.toLowerCase()) ? guild : alliance);
                    HighH = 352;
                    HighW = 718.6;
                    LowH = 0;
                    LowW = 0;
                    if (this.game.ui.chatbox.getChildByName(("chat_alliance_" + identity)))
                    {
                        ChatBoxMC(this.game.ui.chatbox.getChildByName(("chat_alliance_" + identity))).updateMessage(((("<font color='#00FF00'>[" + this.game.strToProperCase(guild)) + "]</font> ") + this.game.strToProperCase(sender)), message);
                        return;
                    };
                    chatBoxMCNew = ChatBoxMC(this.game.ui.chatbox.addChild(new ChatBoxMC(this.game)));
                    chatBoxMCNew.name = ("chat_alliance_" + identity);
                    chatBoxMCNew.x = (Math.floor((Math.random() * ((1 + HighW) - LowW))) + LowW);
                    chatBoxMCNew.y = (Math.floor((Math.random() * ((1 + HighH) - LowH))) + LowH);
                    chatBoxMCNew.sAlliance = identity;
                    chatBoxMCNew.txtCharacter.htmlText = ("<font color='#00FF00'>[Alliance]</font> " + this.game.strToProperCase(identity));
                    chatBoxMCNew.txtCharacter.mouseEnabled = false;
                    chatBoxMCNew.updateMessage(((("<font color='#00FF00'>[" + this.game.strToProperCase(guild)) + "]</font> ") + this.game.strToProperCase(sender)), message);
                };
            };
        }

        private function whisper(data:Array):void
        {
            var identity:String;
            var chatPanel:*;
            var filter:Boolean;
            var username1:String = String(data[3]);
            var username2:String = String(data[4]);
            var message:String = Chat.cleanStr(data[2]);
            if (message.indexOf(":=sm") > -1)
            {
                message = message.substr(0, message.indexOf(":=sm"));
            };
            if (((!(this.game.chatF.ignoreList.data.users == undefined)) && (this.game.chatF.ignoreList.data.users.indexOf(username1.toLowerCase()) > -1)))
            {
                filter = true;
            };
            if (!filter)
            {
                if (username1.toLowerCase() != this.game.network.myUserName.toLowerCase())
                {
                    this.game.chatF.pmSourceA = [username1];
                    if (this.game.chatF.pmSourceA.length > 20)
                    {
                        this.game.chatF.pmSourceA.splice(0, (this.game.chatF.pmSourceA.length - 20));
                    };
                };
                if (data[5] == 1)
                {
                    this.game.chatF.pushMsg("whisper", message, username1, username2, 0);
                    this.game.chatF.pushMsg("whisper", message, username1, username2, 1);
                }
                else
                {
                    if (username2 == username1)
                    {
                        return;
                    };
                    identity = ((username2.toLowerCase() == this.game.world.myAvatar.objData.strUsername.toLowerCase()) ? username1 : username2);
                    this.game.chatF.pushMsg("whisper", message, username1, username2, 1, 1);
                    this.game.chatSession.addTab({
                        "id":null,
                        "label":identity,
                        "name":identity,
                        "icon":"",
                        "type":"whisper",
                        "isChannel":false,
                        "unread":0
                    });
                    this.game.chatSession.addChatHistory({
                        "channel":identity,
                        "message":message,
                        "username":username1,
                        "time":(("(" + this.game.date_server.toLocaleTimeString()) + ")"),
                        "target":"whisper"
                    });
                    chatPanel = this.game.chatSession.panel();
                    if (chatPanel)
                    {
                        chatPanel.configureTabScroll(false);
                    };
                };
            };
        }

        private function mute(data:Array):void
        {
            this.game.chatF.muteMe(int(data[2]));
        }

        private function unmute():void
        {
            this.game.chatF.unmuteMe();
        }

        private function mvna():void
        {
            if (((this.game.world.uoTree[this.game.network.myUserName].freeze == null) || (!(this.game.world.uoTree[this.game.network.myUserName].freeze))))
            {
                this.game.world.uoTree[this.game.network.myUserName].freeze = true;
            };
        }

        private function mvnb():void
        {
            if (this.game.world.uoTree[this.game.network.myUserName].freeze != null)
            {
                delete this.game.world.uoTree[this.game.network.myUserName].freeze;
            };
        }

        private function gtc(data:Array):void
        {
            this.game.world.moveToCell(String(data[2]), String(data[3]));
        }

        private function mtcid(data:Array):void
        {
            if (data.length > 2)
            {
                this.game.world.moveToCellByIDb(Number(data[2]));
            };
        }

        private function hi():void
        {
            this.game.world.connMsgOut = false;
            this.game.world.unlockActions();
        }

        private function DragonBuff():void
        {
            this.game.world.map.doDragonBuff();
        }

        private function trapDoor(data:Array):void
        {
            this.game.world.map.doTrapDoor(data[2]);
        }

        private function gMOTDSTR(data:Array):void
        {
            this.game.world.myAvatar.objData.guild.MOTD = data[2];
        }

        private function loadBank(data:Object):void
        {
            var items:Vector.<Item>;
            var itemObj:Object;
            if (data.bitSuccess)
            {
                this.game.world.bankinfo.items.splice(0, this.game.world.bankinfo.items.length);
                this.game.auctionTabs.fRefresh({"filter":"All"});
                if (((!(data.items == undefined)) && (this.game.world.bankinfo.items.length == 0)))
                {
                    items = new Vector.<Item>();
                    for each (itemObj in data.items)
                    {
                        items.push(new Item(itemObj));
                    };
                    this.game.world.addItemsToBank(items);
                };
                if (this.game.ui.mcPopup.currentLabel == "Bank")
                {
                    bankRefresh();
                }
                else
                {
                    this.game.ui.mcPopup.fOpen("Bank");
                };
            }
            else
            {
                MainController.modal("Error loading bank items! Try logging out and back in to fix this problem.", null, {}, "red,medium", "mono");
            };
        }

        private function bankFromInv(data:Object):void
        {
            if (((!(data.bSuccess == undefined)) && (data.bSuccess == 1)))
            {
                this.game.world.bankController.bankFromInv(data.ItemID, data.CharItemID);
                this.game.world.checkAllQuestStatus();
                if (this.game.ui.mcPopup.currentLabel == "Bank")
                {
                    bankRefresh();
                };
            }
            else
            {
                MainController.modal(data.msg, null, {}, "red,medium", "mono");
            };
        }

        private function bankToInv(data:Object):void
        {
            this.game.world.bankController.bankToInv(data.ItemID, data.CharItemID);
            this.game.world.checkAllQuestStatus();
            if (this.game.ui.mcPopup.currentLabel == "Bank")
            {
                bankRefresh();
            };
        }

        private function bankSwapInv(data:Object):void
        {
            this.game.world.bankController.bankSwapInv(data.invItemID, data.bankItemID, data.invCharItemID, data.bankCharItemID);
            this.game.world.checkAllQuestStatus();
            if (this.game.ui.mcPopup.currentLabel == "Bank")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshItems"});
            };
        }

        private function buyAuctionItem(data:Object):void
        {
            if (!data.bitSuccess)
            {
                this.game.MsgBox.notify(data.strMessage);
                return;
            };
            this.game.showItemDrop(data.item, false);
            this.game.world.marketController.auctionToInv(data.item);
            var item:Item = this.game.world.invTree[data.item.ItemID];
            marketRefresh();
            this.game.world.updateQuestProgress("item", item);
        }

        private function sellAuctionItem(data:Object):void
        {
            if (!data.bitSuccess)
            {
                this.game.MsgBox.notify(data.strMessage);
                return;
            };
            this.game.world.myAvatar.removeItem(data.CharItemID, data.Quantity);
            this.game.world.checkAllQuestStatus();
            marketRefresh();
        }

        private function retrieveAuctionItem(data:Object):void
        {
            var item:Item;
            if (data.bitSuccess)
            {
                item = new Item(data.item);
                item.CharItemID = data.CharItemID;
                if (!item.bSold)
                {
                    this.game.showItemDrop(item, false);
                    this.game.world.invTree[item.ItemID] = item;
                    this.game.world.myAvatar.addItem(item);
                };
                this.game.world.updateQuestProgress("item", item);
                this.game.world.marketController.removeRetrieve(data.AuctionID);
                marketRefresh();
            }
            else
            {
                this.game.MsgBox.notify(data.strMessage);
            };
        }

        private function retrieveAuctionItems(data:Object):void
        {
            var itemKey:String;
            var item:Object;
            if (data.bitSuccess)
            {
                for (itemKey in data.items)
                {
                    item = this.game.copyObj(data.items[itemKey]);
                    this.game.world.invTree[item.ItemID] = this.game.copyObj(item);
                    if (item.bSold == 0)
                    {
                        this.game.world.myAvatar.addItem(item);
                        this.game.showItemDrop(item, false);
                    };
                    this.game.world.updateQuestProgress("item", item);
                    this.game.world.marketController.removeRetrieve(item.AuctionID);
                };
                marketRefresh();
                return;
            };
            MainController.modal(data.strMessage, null, {}, "red,medium", "mono");
        }

        private function loadAuction(data:Object):void
        {
            if (data.bitSuccess)
            {
                this.game.world.marketController.reset();
                this.game.world.marketController.addItems(data.items);
                if (this.game.ui.mcPopup.currentLabel == "AuctionPanel")
                {
                    marketRefresh();
                }
                else
                {
                    this.game.ui.mcPopup.fOpen("AuctionPanel");
                };
                this.game.world.rootClass.auctionTabs.onSearch = false;
            }
            else
            {
                this.game.MsgBox.notify(data.strMessage);
            };
        }

        private function loadRetrieve(data:Object):void
        {
            if (data.bitSuccess)
            {
                this.game.world.marketController.retrieveReset();
                this.game.world.marketController.addItemsToRetrieve(data.items);
                if (this.game.ui.mcPopup.currentLabel == "AuctionPanel")
                {
                    marketRefresh();
                }
                else
                {
                    this.game.ui.mcPopup.fOpen("AuctionPanel");
                };
            }
            else
            {
                MainController.modal("Error loading auction items! Try logging out and back in to fix this problem.", null, {}, "red,medium", "mono");
            };
        }

        private function dropItem(data:Object):void
        {
            var itemID:int;
            var itemObj:Object;
            for (itemID in data.items)
            {
                itemObj = null;
                if (this.game.world.invTree[itemID] == null)
                {
                    this.game.world.invTree[itemID] = this.game.copyObj(data.items[itemID]);
                    this.game.world.invTree[itemID].iQty = 0;
                    itemObj = data.items[itemID];
                }
                else
                {
                    itemObj = this.game.copyObj(this.game.world.invTree[itemID]);
                    itemObj.iQty = int(data.items[itemID].iQty);
                };
                if (((!(data.Wheel == null)) && (!(this.game.world.map.doWheelDrop == undefined))))
                {
                    this.game.world.map.doWheelDrop(itemObj);
                }
                else
                {
                    this.game.showItemDrop(itemObj, true);
                };
                if (this.game.uoPref.bDropInterface)
                {
                    if (DropMenu(this.game.ui.getChildByName("dropMenu")) == null)
                    {
                        this.game.toggleDropInterface();
                    }
                    else
                    {
                        DropMenu(this.game.ui.getChildByName("dropMenu")).dropItem(itemObj);
                    };
                };
            };
        }

        private function addItems(data:Object):void
        {
            var ItemID:int;
            var itemObj:Object;
            var item:Item;
            for (ItemID in data.items)
            {
                if (this.game.world.invTree[ItemID] == null)
                {
                    itemObj = this.game.copyObj(data.items[ItemID]);
                }
                else
                {
                    itemObj = this.game.copyObj(this.game.world.invTree[ItemID]);
                    itemObj.iQty = int(data.items[ItemID].iQty);
                };
                this.game.showItemDrop(itemObj, true);
                item = new Item(itemObj);
                this.game.world.myAvatar.addItemTemporary(item);
                this.game.world.updateQuestProgress("item", item);
            };
            inventoryRefresh();
        }

        private function buyItem(data:Object):void
        {
            var item:Item;
            if (data.CharItemID == -1)
            {
                if (((!(data.bSoldOut == undefined)) && (Boolean(data.bSoldOut))))
                {
                    if (this.game.world.shopinfo.bLimited)
                    {
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({
                            "eventType":"refreshShop",
                            "sInstruction":"closeWindows"
                        });
                    };
                    MainController.modal((data.strMessage + " is no longer in stock."), null, {}, "red,medium", "mono");
                }
                else
                {
                    if (data.strMessage != null)
                    {
                        this.game.MsgBox.notify(data.strMessage);
                    };
                };
            }
            else
            {
                item = new Item(this.game.copyObj(this.game.world.shopBuyItem));
                item.CharItemID = data.CharItemID;
                item.iQty = data.iQty;
                item.iCost = data.iCost;
                item.bBank = data.bBank;
                item.iHrs = 0;
                this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins - item.iCost);
                this.game.showItemDrop(item, false);
                if (((!(item.bBank)) && (this.game.world.invTree[item.ItemID] == null)))
                {
                    this.game.world.invTree[item.ItemID] = this.game.copyObj(data);
                    this.game.world.invTree[item.ItemID].iQty = 0;
                };
                this.game.world.myAvatar.addItem(item);
                if (item.bBank)
                {
                    this.game.MsgBox.notify("Item has been purchased and is in your bank");
                };
                if (item.bHouse == 1)
                {
                    if (((item.sType == "House") && (!(this.game.world.isHouseEquipped()))))
                    {
                        this.game.world.sendEquipItemRequest(item);
                        this.game.world.myAvatar.getItemByID(item.ItemID).bEquip = true;
                    };
                };
                switch (this.game.ui.mcPopup.currentLabel)
                {
                    case "Shop":
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({
                            "eventType":"refreshItems",
                            "sInstruction":"closeWindows"
                        });
                        if (this.game.world.shopinfo.bLimited)
                        {
                            MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshShop"});
                        };
                        break;
                    case "MergeShop":
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshItems"});
                        break;
                    case "Inventory":
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({
                            "eventType":"refreshItems",
                            "sInstruction":"closeWindows"
                        });
                        break;
                };
                this.game.world.updateQuestProgress("item", item);
            };
            this.game.world.shopBuyItem = null;
        }

        private function turnIn(data:Object):void
        {
            var itemArr:Array;
            var i:int;
            var dropObj:Object;
            var dropID:int;
            var dropQty:int;
            if (((!(data.sItems == null)) && (data.sItems.length >= 3)))
            {
                itemArr = data.sItems.split(",");
                i = 0;
                while (i < itemArr.length)
                {
                    dropObj = itemArr[i];
                    dropID = dropObj.split(":")[0];
                    dropQty = dropObj.split(":")[1];
                    if (Boolean(this.game.world.invTree[dropID].bTemp))
                    {
                        this.game.world.myAvatar.removeItemTemporary(dropID, dropQty);
                    }
                    else
                    {
                        this.game.world.myAvatar.removeItemByID(dropID, dropQty);
                    };
                    i++;
                };
            };
            inventoryRefresh();
        }

        private function enhanceItemShop(data:Object):void
        {
            if (data.iCost != null)
            {
                this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins - data.iCost);
                if (this.game.ui.mcPopup.currentLabel == "Inventory")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                };
                if (this.game.ui.mcPopup.currentLabel == "Shop")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                };
            };
            this.enhanceItemLocal(data);
        }

        private function enhanceItemLocal(data:Object):void
        {
            var item:Item;
            var iSel:Item;
            for each (item in this.game.world.myAvatar.items)
            {
                if (item.ItemID == data.ItemID)
                {
                    iSel = item;
                };
            };
            iSel.iEnh = data.EnhID;
            iSel.EnhID = data.EnhID;
            iSel.EnhPatternID = data.EnhPID;
            iSel.EnhLvl = data.EnhLvl;
            iSel.EnhDPS = data.EnhDPS;
            iSel.EnhRng = data.EnhRng;
            iSel.EnhRty = data.EnhRty;
            this.game.mixer.playSound("Good");
            if (this.game.ui.mcPopup.currentLabel == "Inventory")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({
                    "eventType":"refreshItems",
                    "sInstruction":"previewEquipOnly"
                });
            };
            if (this.game.ui.mcPopup.currentLabel == "Shop")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({
                    "eventType":"refreshItems",
                    "sInstruction":"closeWindows"
                });
            };
            MainController.modal((((((("You have upgraded <b>" + iSel.sName) + "</b> with <b>") + data.EnhName) + "</b>, level <b>") + data.EnhLvl) + "</b>!"), null, {}, "white,medium", "mono");
        }

        private function who(data:Object):void
        {
            this.game.ui.mcOFrame.fOpenWith({
                "typ":"userListA",
                "ul":data.users
            });
        }

        private function al(data:Object):void
        {
            this.game.areaListShow(data);
        }

        private function reloadmap(data:Object):void
        {
            if (this.game.world.strMapName == data.sName)
            {
                this.game.world.setMapEvents(null);
                this.game.world.strMapFileName = data.sFileName;
                this.game.world.reloadCurrentMap();
            };
        }

        private function convertToCoins(data:Object):void
        {
            var modal:ModalMC;
            var modalO:Object;
            if (data.bitSuccess)
            {
                this.game.chatF.pushMsg("server", (("You have gained " + data.Increase) + " Coins."), "SERVER", "", 0);
                this.game.world.myAvatar.objData.intGold = (this.game.world.myAvatar.objData.intGold - data.Decrease);
                this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins + data.Increase);
                this.game.ui.mcInterface.mcGold.strGold.text = this.game.strNumWithCommas(this.game.world.myAvatar.objData.intGold);
                if (this.game.ui.mcPopup.currentLabel == "Inventory")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                };
                this.game.mixer.playSound("Coins");
            }
            else
            {
                modal = new ModalMC();
                modalO = null;
                modalO.strBody = "There is nothing else to convert.";
                modalO.params = {};
                modalO.glow = "red,medium";
                modalO.btns = "mono";
                this.game.ui.ModalStack.addChild(modal);
                modal.init(modalO);
            };
        }

        private function moveToArea(data:Object):void
        {
            var branch:Object;
            var branchKey:String;
            var bi:int;
            var uoLeaf:Object;
            var monLeaf:Object;
            var mID:String;
            var npcLeaf:Object;
            var nID:String;
            this.game.world.mapLoadInProgress = true;
            this.game.world.strAreaName = data.areaName;
            this.game.world.strAreaCap = data.areaCap;
            this.game.world.isCross = data.isCross;
            this.game.world.isCycle = data.isCycle;
            this.game.world.intMapID = data.intMapID;
            this.game.world.initObjExtra(data.sExtra);
            this.game.world.areaUsers = [];
            if (this.game.world.myAvatar != null)
            {
                this.game.world.myAvatar.pMC.updateName();
            };
            var myLeaf:Object;
            if (this.game.world.uoTreeLeaf(this.game.network.myUserName) != null)
            {
                myLeaf = this.game.copyObj(this.game.world.uoTreeLeaf(this.game.network.myUserName));
            };
            this.game.world.uoTree = {};
            if (myLeaf != null)
            {
                this.game.world.uoTree[this.game.network.myUserName] = myLeaf;
            };
            this.game.world.bSpectate = data.isSpectator;
            if (data.pvpTeam != null)
            {
                myLeaf.pvpTeam = data.pvpTeam;
                this.game.world.bPvP = true;
                this.game.ui.mcPortrait.pvpIcon.visible = true;
                this.game.world.setPVPFactionData(data.PVPFactions);
                if (this.game.world.objExtra["bChaos"] == null)
                {
                    this.game.updatePVPScore(data.pvpScore);
                    this.game.showPVPScore();
                };
            }
            else
            {
                this.game.ui.mcPortrait.pvpIcon.visible = false;
                delete myLeaf.pvpTeam;
                this.game.world.bPvP = false;
                this.game.hidePVPScore();
                this.game.world.setPVPFactionData(null);
            };
            if (data.isRaid)
            {
                this.game.ui.RaidBar.visible = true;
                this.raidUpdate(data.raidData);
            }
            else
            {
                this.game.ui.RaidBar.visible = false;
            };
            if (data.pvpScore != null)
            {
                this.game.updatePVPScore(data.pvpScore);
            };
            var val:* = undefined;
            bi = 0;
            while (bi < data.uoBranch.length)
            {
                branch = data.uoBranch[bi];
                uoLeaf = {};
                for (branchKey in branch)
                {
                    val = branch[branchKey];
                    uoLeaf[branchKey] = val;
                };
                if (branch.uoName != this.game.network.myUserName)
                {
                    uoLeaf.auras = [];
                };
                uoLeaf.targets = {};
                this.game.world.uoTreeLeafSet(branch.uoName, uoLeaf);
                this.game.world.manageAreaUser(branch.uoName, "+");
                bi++;
            };
            this.game.world.monTree = {};
            this.game.world.monsters = [];
            this.game.world.npcTree = {};
            this.game.world.npcs = [];
            bi = 0;
            while (bi < data.monBranch.length)
            {
                branch = data.monBranch[bi];
                monLeaf = {};
                mID = "1";
                for (branchKey in branch)
                {
                    val = branch[branchKey];
                    if (branchKey.toLowerCase().indexOf("monmapid") > -1)
                    {
                        mID = val;
                    };
                    monLeaf[branchKey] = val;
                };
                monLeaf.auras = [];
                monLeaf.targets = {};
                monLeaf.strBehave = "walk";
                this.game.world.monTree[mID] = monLeaf;
                bi++;
            };
            bi = 0;
            while (bi < data.npcBranch.length)
            {
                branch = data.npcBranch[bi];
                npcLeaf = {};
                nID = "1";
                for (branchKey in branch)
                {
                    val = branch[branchKey];
                    if (branchKey.toLowerCase().indexOf("npcmapid") > -1)
                    {
                        nID = val;
                    };
                    if (((branchKey.toLowerCase().indexOf("npcid") > -1) || (branchKey.toLowerCase().indexOf("npcmapid") > -1)))
                    {
                        val = int(val);
                    };
                    npcLeaf[branchKey] = val;
                };
                npcLeaf.auras = [];
                npcLeaf.targets = {};
                npcLeaf.strBehave = "walk";
                this.game.world.npcTree[nID] = npcLeaf;
                bi++;
            };
            this.game.world.setMapEvents((("event" in data) ? data.event : null));
            this.game.world.setCellMap((("cellMap" in data) ? data.cellMap : null));
            if (this.game.world.strFrame != "")
            {
                this.game.world.exitCell();
            };
            this.game.world.clearMonstersAndProps();
            this.game.world.clearAllAvatars();
            this.game.world.avatars[this.game.network.myUserId] = this.game.world.myAvatar;
            this.game.world.strMapName = data.strMapName;
            this.game.world.strMapFileName = data.strMapFileName;
            this.game.world.intType = data.intType;
            this.game.world.intKillCount = data.intKillCount;
            this.game.world.objLock = ((data.objLock != null) ? data.objLock : null);
            this.game.world.mondef = data.mondef;
            this.game.world.monmap = data.monmap;
            this.game.world.npcdef = data.npcdef;
            this.game.world.npcmap = data.npcmap;
            this.game.world.objectmap = data.objectmap;
            this.game.world.resourcemap = data.resourcemap;
            this.game.world.curRoom = Number(data.areaId);
            this.game.world.actionResultsMon = {};
            this.game.world.actionResults = {};
            this.game.world.mapBoundsMC = null;
            this.game.chatF.chn.zone.rid = this.game.world.curRoom;
            this.game.world.partyController.updatePartyFrame();
            this.game.world.initHouseData((("houseData" in data) ? data.houseData : null));
            if (this.game.world.guildHallData != null)
            {
                this.game.world.guildHallData.destroyMenu();
                this.game.world.guildHallData = null;
            };
            this.game.world.frames = ((data.frames != null) ? data.frames : null);
            this.game.onRemoveChildrens(this.game.ui.mapsTrash);
            if (data.guildData == undefined)
            {
                this.game.world.loadMap(data.strMapFileName, data.strMusic);
            }
            else
            {
                this.game.world.initGuildhallData(data.guildData);
                this.game.world.guildHallData.loadGuildMap(data.strMapFileName);
                if (this.game.world.myAvatar != null)
                {
                    this.game.world.guildHallData.buildMenu();
                };
            };
        }

        private function initUserData(data:Object):void
        {
            var avt:Avatar;
            var uoLeaf:Object;
            try
            {
                avt = this.game.world.getAvatarByUserID(data.uid);
                uoLeaf = avt.dataLeaf;
                if (((!(avt == null)) && (!(uoLeaf == null))))
                {
                    avt.initAvatar({"data":data.data});
                    if (avt.isMyAvatar)
                    {
                        avt.objData.strHomeTown = avt.objData.strMapName;
                        if (avt.objData.guild != null)
                        {
                            this.game.chatF.chn.guild.act = 1;
                            if (String(avt.objData.guild.MOTD) != "undefined")
                            {
                                this.game.chatF.pushMsg("guild", ("Message of the day: " + String(avt.objData.guild.MOTD)), "SERVER", "", 0);
                            };
                        };
                        if (avt.objData.iUpg > 0)
                        {
                            if (avt.objData.iUpgDays < 0)
                            {
                                this.game.chatF.pushMsg("moderator", "Your membership has expired. Please visit our website to renew your membership.", "SERVER", "", 0);
                            }
                            else
                            {
                                if (avt.objData.iUpgDays < 7)
                                {
                                    this.game.chatF.pushMsg("moderator", (("Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1)) + " days. Please visit our website to renew your membership."), "SERVER", "", 0);
                                };
                            };
                        };
                        this.game.updateXPBar();
                        this.game.updateRepBar();
                        this.game.ui.mcInterface.mcGold.strGold.text = avt.objData.intGold;
                        if (this.game.ui.mcPopup.currentLabel == "Inventory")
                        {
                            LPFLayoutInvShopEnh(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        };
                        this.game.world.getInventory(data.uid);
                        this.game.world.initAchievements();
                        this.game.readIA1Preferences();
                    };
                };
            }
            catch(e:Error)
            {
                trace(e);
            };
            this.game.antiLagCheck();
        }

        private function saveHouse(data:Object):void
        {
            this.game.world.initHouseData(data.houseData);
            this.game.world.updateHouseItems();
        }

        private function loadHairShop(data:Object):void
        {
            this.game.world.hairshopinfo = data;
            this.game.openCharacterCustomize();
        }

        private function initUserDatas(data:Object):void
        {
            var avt:Avatar;
            var uoLeaf:Object;
            var claimDate:Date;
            var todayDate:Date;
            var a:Array = data.a;
            var i:int;
            while (i < a.length)
            {
                this.o = a[i];
                avt = this.game.world.getAvatarByUserID(this.o.uid);
                uoLeaf = avt.dataLeaf;
                if (((!(avt == null)) && (!(uoLeaf == null))))
                {
                    avt.initAvatar({"data":this.o.data});
                    if (((avt.isMyAvatar) && ((avt.items == null) || (avt.items.length < 1))))
                    {
                        avt.objData.strHomeTown = avt.objData.strMapName;
                        if (avt.objData.guild != null)
                        {
                            this.game.chatF.chn.guild.act = 1;
                            if (String(avt.objData.guild.MOTD) != "undefined")
                            {
                                this.game.chatF.pushMsg("guild", ("Message of the day: " + String(avt.objData.guild.MOTD)), "SERVER", "", 0);
                            };
                        };
                        if (avt.objData.iUpg > 0)
                        {
                            if (avt.objData.iUpgDays < 0)
                            {
                                this.game.chatF.pushMsg("moderator", "Your membership has expired. Please visit our website to renew your membership.", "SERVER", "", 0);
                            }
                            else
                            {
                                if (avt.objData.iUpgDays < 7)
                                {
                                    this.game.chatF.pushMsg("moderator", (("Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1)) + " days. Please visit our website to renew your membership."), "SERVER", "", 0);
                                };
                            };
                        };
                        if (this.game.world.isMyHouse())
                        {
                            this.game.toggleHousePanel();
                        };
                        if (this.game.world.guildHallData != null)
                        {
                            this.game.world.guildHallData.buildMenu();
                            this.game.world.guildHallData.HallSize = this.game.world.myAvatar.objData.guild.HallSize;
                        };
                        if (((!(avt.objData.dRefReset == null)) && ((avt.objData.iRefGold > 0) || (avt.objData.iRefExp > 0))))
                        {
                            MainController.modal((((("You earned <font color='#FFCC00'><b>" + Math.ceil(avt.objData.iRefGold)) + " Gold</b></font> and <font color='#990099'><b>") + Math.ceil(avt.objData.iRefExp)) + " XP</b></font><br/> from Referred Friends."), this.game.world.sendRewardReferralRequest, {}, null, "mono");
                        };
                        this.game.updateXPBar();
                        this.game.updateRepBar();
                        this.game.ui.mcInterface.mcGold.strGold.text = avt.objData.intGold;
                        if (this.game.ui.mcPopup.currentLabel == "Inventory")
                        {
                            MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        };
                        this.game.world.getInventory(this.o.uid);
                        this.game.world.initAchievements();
                        this.game.readIA1Preferences();
                        claimDate = this.game.stringToDate(avt.objData.daily.Date);
                        todayDate = this.game.date_server;
                        todayDate.date--;
                        if (todayDate > claimDate)
                        {
                            this.game.toggleDailyLogin();
                        };
                        if (avt.objData.party != null)
                        {
                            this.game.world.partyController.loadParty(avt.objData.party);
                        };
                    };
                };
                i++;
            };
            this.game.antiLagCheck();
        }

        private function changeChatColor(data:Object):void
        {
            this.game.world.getAvatarByUserID(data.uid).objData.strChatColor = data.intChatColor;
        }

        private function increaseVip(data:Object):void
        {
            this.game.world.myAvatar.objData.iUpgDays = data.days;
        }

        private function changeColor(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (((!(avt == null)) && (avt.bitData)))
            {
                if (avt.isMyAvatar)
                {
                    this.game.showPortrait(avt);
                }
                else
                {
                    if (data.HairID != null)
                    {
                        avt.objData.HairID = data.HairID;
                        avt.objData.strHairName = data.strHairName;
                        avt.objData.strHairFilename = data.strHairFilename;
                        if (((!(avt.pMC == null)) && (!(avt.pMC.stage == null))))
                        {
                            avt.pMC.loadHair();
                        };
                    };
                    avt.objData.intColorSkin = data.intColorSkin;
                    avt.objData.intColorHair = data.intColorHair;
                    avt.objData.intColorEye = data.intColorEye;
                    if (((!(avt.pMC == null)) && (!(avt.pMC.stage == null))))
                    {
                        avt.pMC.updateColor();
                    };
                };
            };
        }

        private function changeArmorColor(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (((!(avt == null)) && (avt.bitData)))
            {
                if (!avt.isMyAvatar)
                {
                    avt.objData.intColorBase = data.intColorBase;
                    avt.objData.intColorTrim = data.intColorTrim;
                    avt.objData.intColorAccessory = data.intColorAccessory;
                    if (((!(avt.pMC == null)) && (!(avt.pMC.stage == null))))
                    {
                        avt.pMC.updateColor();
                    };
                };
            };
        }

        private function killStreak(data:Object):void
        {
            var playerAvatar:Avatar = this.game.world.getAvatarByUserID(data.PlayerID);
            var kill:killDisplay = new killDisplay();
            kill.t.ti.text = data.killStreak;
            kill.x = playerAvatar.pMC.mcChar.x;
            kill.y = (playerAvatar.pMC.pname.y - 30);
            if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
            {
                Game.spriteToBitmap(kill.t);
            };
            playerAvatar.pMC.addChild(kill);
        }

        private function addGoldExp(data:Object):void
        {
            var monster:Avatar;
            var pMCTarget:MovieClip;
            var deltaXP:int;
            var xp:xpDisplay;
            var xpBonus:xpDisplayBonus;
            var deltaCoins:int;
            var coins:coinsDisplay;
            var deltaCP:int;
            var iRank:int;
            var txtBonusCP:String;
            var isMonster:Boolean;
            if (((!(data.typ == null)) && (data.typ == "m")))
            {
                monster = this.game.world.getMonster(data.id);
                isMonster = true;
                pMCTarget = monster.pMC;
            }
            else
            {
                pMCTarget = this.game.world.myAvatar.pMC;
            };
            if (((!(data.intExp == null)) && (data.intExp > 0)))
            {
                deltaXP = data.intExp;
                this.game.world.myAvatar.objData.intExp = (this.game.world.myAvatar.objData.intExp + deltaXP);
                this.game.updateXPBar();
                xp = new xpDisplay();
                xp.t.ti.text = (deltaXP + " xp");
                xpBonus = null;
                if (data.bonusExp != undefined)
                {
                    xpBonus = new xpDisplayBonus();
                    xpBonus.t.ti.text = String((("+ " + data.bonusExp) + " xp!"));
                    xp.t.ti.text = ((deltaXP - data.bonusExp) + " xp");
                    if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                    {
                        Game.spriteToBitmap(xp.t);
                    };
                };
                if (isMonster)
                {
                    xp.x = monster.pMC.mcChar.x;
                    xp.y = (monster.pMC.mcChar.y - 40);
                    pMCTarget.addChild(xp);
                    if (xpBonus != null)
                    {
                        xpBonus.x = xp.x;
                        xpBonus.y = xp.y;
                        pMCTarget.addChild(xpBonus);
                    };
                }
                else
                {
                    xp.x = pMCTarget.mcChar.x;
                    xp.y = (pMCTarget.pname.y + 10);
                    pMCTarget.addChild(xp);
                    if (xpBonus != null)
                    {
                        xpBonus.x = xp.x;
                        xpBonus.y = xp.y;
                        pMCTarget.addChild(xpBonus);
                    };
                };
                if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                {
                    Game.spriteToBitmap(xp.t);
                };
            };
            if (((!(data.intCoins == null)) && (data.intCoins > 0)))
            {
                this.game.mixer.playSound("Coins");
                this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins + data.intCoins);
                if (this.game.ui.mcPopup.currentLabel == "Inventory")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                };
                deltaCoins = data.intCoins;
                coins = new coinsDisplay();
                coins.t.ti.text = (deltaCoins + " c");
                coins.tMask.ti.text = (deltaCoins + " c");
                if (((!(data.typ == null)) && (data.typ == "m")))
                {
                    coins.x = monster.pMC.mcChar.x;
                    coins.y = (monster.pMC.mcChar.y - 20);
                    pMCTarget.addChild(coins);
                }
                else
                {
                    coins.x = pMCTarget.mcChar.x;
                    coins.y = (pMCTarget.pname.y - 30);
                    pMCTarget.addChild(coins);
                };
                if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                {
                    Game.spriteToBitmap(coins.t);
                };
            };
            if (data.iCP != null)
            {
                deltaCP = data.iCP;
                this.game.world.myAvatar.objData.iCP = (this.game.world.myAvatar.objData.iCP + deltaCP);
                this.game.world.myAvatar.updateArmorRep();
                iRank = this.game.world.myAvatar.objData.iRank;
                this.game.world.myAvatar.updateRep();
                if (iRank != this.game.world.myAvatar.objData.iRank)
                {
                    this.game.world.myAvatar.rankUp(this.game.world.myAvatar.objData.strClassName, this.game.world.myAvatar.objData.iRank);
                };
                txtBonusCP = "";
                if (data.bonusCP == null)
                {
                    data.bonusCP = 0;
                }
                else
                {
                    txtBonusCP = ((" + " + data.bonusCP) + "(Bonus)");
                };
                this.game.chatF.pushMsg("server", ((((("Class Points for " + this.game.world.myAvatar.objData.strClassName) + " increased by ") + (deltaCP - data.bonusCP)) + txtBonusCP) + "."), "SERVER", "", 0);
            };
            if (data.FactionID != null)
            {
                if (data.bonusRep == null)
                {
                    data.bonusRep = 0;
                };
                this.game.world.myAvatar.addRep(data.FactionID, data.iRep, data.bonusRep);
            };
        }

        private function levelUp(data:Object):void
        {
            this.game.world.myAvatar.objData.intLevel = data.intLevel;
            this.game.world.myAvatar.objData.intExpToLevel = data.intExpToLevel;
            this.game.world.myAvatar.objData.intExp = 0;
            this.game.updateXPBar();
            this.game.world.updatePortrait(this.game.world.myAvatar);
            this.game.world.myAvatar.levelUp();
            if (("updatePStats" in this.game.world.map))
            {
                this.game.world.map.updatePStats();
            };
        }

        private function loadInventoryBig(data:Object):void
        {
            this.game.world.bankController.iBankCount = int(data.bankCount);
            this.game.world.myAvatar.initInventory(data.items);
            this.game.world.myAvatar.initInventoryTemporary(data.titems);
            this.game.world.initHouseInventory(this.game.world.myAvatar.objData.sHouseInfo, data.hitems);
            this.game.world.myAvatar.initEmojis(data.emojis);
            this.game.world.myAvatar.initFactions(data.factions);
            this.game.world.myAvatar.initGuild(data.guild);
            this.game.world.myAvatar.invLoaded = true;
            inventoryRefresh();
            if (("eventTrigger" in this.game.world.map))
            {
                this.game.world.map.eventTrigger({"cmd":"userLoaded"});
            };
        }

        private function friends(data:Object):void
        {
            this.game.world.myAvatar.initFriendsList(data.friends);
            Game.root.world.showFriendsList();
        }

        private function initInventory(data:Object):void
        {
            this.game.world.myAvatar.initInventory(data.items);
            if (("eventTrigger" in MovieClip(this.game.world.map)))
            {
                this.game.world.map.eventTrigger({"cmd":"userLoaded"});
            };
        }

        private function house(data:Object):void
        {
            this.game.MsgBox.notify(data.msg);
        }

        private function buyBagSlots(data:Object):void
        {
            this.game.mixer.playSound("Heal");
            this.game.world.myAvatar.objData.intCoins = data.intCoins;
            this.game.world.myAvatar.objData.iBagSlots = (this.game.world.myAvatar.objData.iBagSlots + Number(data.iSlots));
            this.game.MsgBox.notify((("You now have " + this.game.world.myAvatar.objData.iBagSlots) + " inventory spaces!"));
            this.game.world.dispatchEvent(new Event("buyBagSlots"));
            if (this.game.ui.mcPopup.currentLabel == "Inventory")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
            };
            if (this.game.ui.mcPopup.currentLabel == "Shop")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
            };
        }

        private function buyBankSlots(data:Object):void
        {
            this.game.mixer.playSound("Heal");
            this.game.world.myAvatar.objData.intCoins = data.intCoins;
            this.game.world.myAvatar.objData.iBankSlots = (this.game.world.myAvatar.objData.iBankSlots + Number(data.iSlots));
            this.game.MsgBox.notify((("You now have " + this.game.world.myAvatar.objData.iBankSlots) + " bank spaces!"));
            this.game.world.dispatchEvent(new Event("buyBankSlots"));
            if (this.game.ui.mcPopup.currentLabel == "Inventory")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
            };
            if (this.game.ui.mcPopup.currentLabel == "Shop")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
            };
        }

        private function buyHouseSlots(data:Object):void
        {
            this.game.mixer.playSound("Heal");
            this.game.world.myAvatar.objData.intCoins = data.intCoins;
            this.game.world.myAvatar.objData.iHouseSlots = (this.game.world.myAvatar.objData.iHouseSlots + Number(data.iSlots));
            this.game.MsgBox.notify((("You now have " + this.game.world.myAvatar.objData.iHouseSlots) + " house inventory spaces!"));
            this.game.world.dispatchEvent(new Event("buyHouseSlots"));
            if (this.game.ui.mcPopup.currentLabel == "Inventory")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
            };
            if (this.game.ui.mcPopup.currentLabel == "Shop")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
            };
        }

        private function claimDailyLogin(data:Object):void
        {
            var cnDisplay:coinsDisplay;
            if (data.intCoins != 0)
            {
                this.game.mixer.playSound("Coins");
                cnDisplay = new coinsDisplay();
                cnDisplay.t.ti.text = (data.intCoins + " c");
                cnDisplay.tMask.ti.text = (data.intCoins + " c");
                cnDisplay.x = this.game.world.myAvatar.pMC.mcChar.x;
                cnDisplay.y = (this.game.world.myAvatar.pMC.pname.y - 30);
                if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                {
                    Game.spriteToBitmap(cnDisplay.t);
                };
                this.game.world.myAvatar.pMC.addChild(cnDisplay);
                this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins + data.intCoins);
            }
            else
            {
                if (data.intMembership != 0)
                {
                    this.game.mixer.playSound("Achievement");
                    this.game.world.myAvatar.objData.iUpgDays = data.intMembership;
                }
                else
                {
                    this.game.mixer.playSound("Heal");
                };
            };
            if (this.game.ui.mcPopup.currentLabel == "Inventory")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
            };
            if (this.game.ui.mcPopup.currentLabel == "Shop")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
            };
            this.game.world.myAvatar.objData.daily = data.daily;
            if (this.game.ui.mcPopup.currentLabel == "DailyLogin")
            {
                MCDailyLogin(this.game.ui.mcPopup.DailyBG).initChests();
            };
        }

        private function buyAuctionSlots(data:Object):void
        {
            this.game.world.dispatchEvent(new Event("buyAuctionSlots"));
            if (data.bitSuccess == 1)
            {
                this.game.mixer.playSound("Heal");
                this.game.world.myAvatar.objData.iAuctionSlots = (this.game.world.myAvatar.objData.iAuctionSlots + Number(data.iSlots));
                this.game.world.myAvatar.objData.intGold = (this.game.world.myAvatar.objData.intGold - data.iCost);
                this.game.ui.mcInterface.mcGold.strGold.text = this.game.world.myAvatar.objData.intGold;
                this.game.MsgBox.notify((("You now have " + this.game.world.myAvatar.objData.iAuctionSlots) + " auction spaces!"));
                if (this.game.ui.mcPopup.currentLabel == "Inventory")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
                };
                if (this.game.ui.mcPopup.currentLabel == "Shop")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
                };
            };
        }

        private function buyVendingSlots(data:Object):void
        {
            this.game.world.dispatchEvent(new Event("buyVendingSlots"));
            if (data.bitSuccess == 1)
            {
                this.game.mixer.playSound("Heal");
                this.game.world.myAvatar.objData.iVendingSlots = (this.game.world.myAvatar.objData.iVendingSlots + Number(data.iSlots));
                this.game.world.myAvatar.objData.intGold = (this.game.world.myAvatar.objData.intGold - data.iCost);
                this.game.ui.mcInterface.mcGold.strGold.text = this.game.world.myAvatar.objData.intGold;
                this.game.MsgBox.notify((("You now have " + this.game.world.myAvatar.objData.iVendingSlots) + " vending spaces!"));
                if (this.game.ui.mcPopup.currentLabel == "Inventory")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
                };
                if (this.game.ui.mcPopup.currentLabel == "Shop")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
                };
            };
        }

        private function callfct(data:Object):void
        {
            var fct:Function;
            try
            {
                fct = this.game.world.map[data.fctNam];
                (fct(data.fctParams));
            }
            catch(e:Error)
            {
                trace(e);
            };
        }

        private function genderSwap(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if ((((!(avt == null)) && (avt.bitData)) && (data.bitSuccess == 1)))
            {
                if (avt.isMyAvatar)
                {
                    this.game.MsgBox.notify("Your gender has been successfully changed.");
                    this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins - data.intCoins);
                    if (this.game.ui.mcPopup.currentLabel == "Inventory")
                    {
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
                    };
                    if (this.game.ui.mcPopup.currentLabel == "Shop")
                    {
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
                    };
                };
                avt.objData.strGender = data.gender;
                avt.objData.HairID = data.HairID;
                avt.objData.strHairName = data.strHairName;
                avt.objData.strHairFilename = data.strHairFilename;
                avt.initAvatar({"data":avt.objData});
            };
        }

        private function renameCharacter(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (((!(avt == null)) && (avt.bitData)))
            {
                if (data.bitSuccess == 1)
                {
                    if (avt.isMyAvatar)
                    {
                        this.game.MsgBox.notify("Your name has been successfully changed.");
                        avt.objData.intGold = (avt.objData.intGold - data.intGold);
                        this.game.ui.mcInterface.mcGold.strGold.text = avt.objData.intGold;
                    };
                    avt.objData.strUsername = data.name;
                    avt.initAvatar({"data":avt.objData});
                };
            };
        }

        private function loadShop(data:Object):void
        {
            var shopItem:Item;
            this.game.world.shopinfo = null;
            var shop:ShopModel = new ShopModel(data.shopinfo);
            if ((((!(this.game.world.shopinfo == null)) && (this.game.world.shopinfo.ShopID == shop.ShopID)) && (this.game.world.shopinfo.bLimited)))
            {
                for each (shopItem in shop.items)
                {
                    this.game.world.shopinfo.items.push(shopItem);
                    this.game.world.shopinfo.items.shift();
                };
                if (this.game.ui.mcPopup.currentLabel == "Shop")
                {
                    LPFLayoutInvShopEnh(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshItems"});
                }
                else
                {
                    this.game.ui.mcPopup.fOpen("Shop");
                };
            }
            else
            {
                this.game.world.shopinfo = shop;
                if (this.game.isMergeShop(shop))
                {
                    this.game.ui.mcPopup.fOpen("MergeShop");
                }
                else
                {
                    this.game.ui.mcPopup.fOpen("Shop");
                };
            };
        }

        private function loadEnhShop(data:Object):void
        {
            this.game.world.enhShopID = data.shopinfo.ShopID;
            this.game.world.enhShopItems = data.shopinfo.items;
            this.game.ui.mcPopup.fOpen("EnhShop");
        }

        private function sellItem(data:Object):void
        {
            this.game.world.myAvatar.removeItem(data.CharItemID, data.intQuantity);
            this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins + data.intAmount);
            if (this.game.ui.mcPopup.currentLabel == "Shop")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({
                    "eventType":"refreshItems",
                    "sInstruction":"closeWindows"
                });
            }
            else
            {
                if (this.game.ui.mcPopup.currentLabel == "Inventory")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({
                        "eventType":"refreshItems",
                        "sInstruction":"closeWindows"
                    });
                }
                else
                {
                    if (this.game.ui.mcPopup.currentLabel == "HouseShop")
                    {
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcHouseShop")).reset();
                    };
                };
            };
            this.game.world.checkAllQuestStatus();
        }

        private function removeItem(data:Object):void
        {
            if (data.iQty != null)
            {
                this.game.world.myAvatar.removeItem(data.CharItemID, data.iQty);
            }
            else
            {
                this.game.world.myAvatar.removeItem(data.CharItemID);
            };
            inventoryRefresh();
            this.game.world.checkAllQuestStatus();
        }

        private function updateClass(data:Object):void
        {
            var avatar:Avatar;
            this.game.statsNewClass = true;
            avatar = this.game.world.getAvatarByUserID(data.uid);
            if (((!(avatar == null)) && (!(avatar.objData == null))))
            {
                avatar.objData.strClassName = data.sClassName;
                avatar.objData.strClassRank = "";
                avatar.objData.iCP = data.iCP;
                avatar.objData.sClassCat = data.sClassCat;
                avatar.objData.sAssetPath = data.sAssetPath;
                avatar.updateRep();
                if (data.sAssetPath != null)
                {
                    LoadController.singleton.addLoadAvatar(avatar.objData.sAssetPath, (avatar.LOADER_KEY_PREFIX + "asset"), function (event:Event):void
                    {
                        onAssetLoadComplete(avatar);
                    });
                }
                else
                {
                    onAssetLoadComplete(avatar);
                };
                if (data.uid == this.game.network.myUserId)
                {
                    if (("sDesc" in data))
                    {
                        avatar.objData.sClassDesc = data.sDesc;
                    };
                    if (("sStats" in data))
                    {
                        avatar.objData.sClassStats = data.sStats;
                    };
                    if (("aMRM" in data))
                    {
                        avatar.objData.aClassMRM = data.aMRM;
                    };
                };
            };
        }

        private function wearItem(data:Object):void
        {
            var avatar:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (avatar != null)
            {
                if (((!(avatar.pMC == null)) && (!(avatar.objData == null))))
                {
                    avatar.objData.eqp[data.strES] = {
                        "sName":data.sName,
                        "sFile":data.sFile,
                        "sLink":data.sLink,
                        "sType":data.sType,
                        "ItemID":data.ItemID,
                        "iHue":data.iHue,
                        "iBrightness":data.iBrightness,
                        "iContrast":data.iContrast,
                        "iSaturation":data.iSaturation
                    };
                    avatar.loadMovieAtES(data.strES, data.sFile, data.sLink);
                };
                if (avatar.isMyAvatar)
                {
                    avatar.wearItem(data.ItemID);
                    inventoryRefresh();
                };
            };
            this.game.antiLagCheck();
        }

        private function crossLogin(data:Object):void
        {
            Game.root.objServerInfo.Name = data.server;
            Game.root.objServerInfo.strUsername = data.username;
            Game.root.objServerInfo.strPassword = data.password;
            Game.root.logout();
            Game.root.connectTo(data.host, data.port);
        }

        private function updateResource(data:Object):void
        {
            var resource:Object = this.game.world.updateResource(data.data);
            if (resource == null)
            {
                this.game.MsgBox.notify("Resource not found.");
                return;
            };
            resource.display.onUpdate(data.data);
        }

        private function unwearItem(data:Object):void
        {
            var statsPanel:StatsPanel;
            var avatar:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (avatar != null)
            {
                if (data.hasOwnProperty("bRemove"))
                {
                    delete avatar.objData.eqp[data.strES];
                    avatar.unloadMovieAtES(data.strES);
                }
                else
                {
                    avatar.objData.eqp[data.strES] = {
                        "sFile":data.sFile,
                        "sLink":data.sLink,
                        "sType":data.sType,
                        "ItemID":data.ItemID,
                        "iHue":data.iHue,
                        "iBrightness":data.iBrightness,
                        "iContrast":data.iContrast,
                        "iSaturation":data.iSaturation
                    };
                    avatar.loadMovieAtES(data.strES, data.sFile, data.sLink);
                };
                if (avatar.isMyAvatar)
                {
                    avatar.unwearItem(data.ItemID);
                    inventoryRefresh();
                    statsPanel = StatsPanel(UIController.getByName("stats_panel"));
                    if (statsPanel)
                    {
                        statsPanel.updateBoosts();
                    };
                };
            };
        }

        private function ds(data:Object):void
        {
            var player1:Avatar = this.game.world.getAvatarByUserID(data.uid1);
            var player2:Avatar = this.game.world.getAvatarByUserID(data.uid2);
            this.game.world.aTarget = null;
            this.game.world.aTarget = null;
            if (((!(player1 == null)) && (player1.isMyAvatar)))
            {
                this.game.world.aTarget = player2;
            };
            if (((!(player2 == null)) && (player2.isMyAvatar)))
            {
                this.game.world.aTarget = player1;
            };
        }

        private function customizeItem(data:Object):void
        {
            var key:String;
            var value:Object;
            var item:Item;
            if (data.sMsg)
            {
                this.game.MsgBox.notify(data.sMsg);
                return;
            };
            data.iHue = ((data.iMode == 1) ? (PanelMC.DEFAULT_HUE - 180) : data.iHue);
            data.iBrightness = ((data.iMode == 1) ? (PanelMC.DEFAULT_BRIGHTNESS - 100) : data.iBrightness);
            data.iContrast = ((data.iMode == 1) ? (PanelMC.DEFAULT_CONTRAST - 100) : data.iContrast);
            data.iSaturation = ((data.iMode == 1) ? (PanelMC.DEFAULT_SATURATION - 100) : data.iSaturation);
            var message:* = ((data.iMode == 1) ? "Colors have been successfully reset to their default settings." : "The new color has been applied successfully.");
            var avatar:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (avatar != null)
            {
                if (((!(avatar.pMC == null)) && (!(avatar.objData == null))))
                {
                    for (key in avatar.objData.eqp)
                    {
                        value = avatar.objData.eqp[key];
                        if (value.ItemID == data.ItemID)
                        {
                            value.iHue = data.iHue;
                            value.iBrightness = data.iBrightness;
                            value.iContrast = data.iContrast;
                            value.iSaturation = data.iSaturation;
                            value.iReset = (data.iMode == 1);
                            avatar.pMC.updateColor();
                            break;
                        };
                    };
                };
                if (avatar.isMyAvatar)
                {
                    for each (item in avatar.items)
                    {
                        if (item.ItemID == data.ItemID)
                        {
                            item.iHue = data.iHue;
                            item.iBrightness = data.iBrightness;
                            item.iContrast = data.iContrast;
                            item.iSaturation = data.iSaturation;
                            item.iReset = (data.iMode == 1);
                            break;
                        };
                    };
                };
            };
            MainController.modal(message, null, {}, "green,medium", "mono");
            this.game.antiLagCheck();
        }

        private function equipItem(data:Object):void
        {
            var avatar:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (avatar != null)
            {
                if (((!(avatar.pMC == null)) && (!(avatar.objData == null))))
                {
                    avatar.objData.eqp[data.strES] = {
                        "sFile":data.sFile,
                        "sLink":data.sLink,
                        "sName":data.sName,
                        "sType":data.sType,
                        "ItemID":data.ItemID,
                        "sMeta":data.sMeta,
                        "iHue":data.iHue,
                        "iBrightness":data.iBrightness,
                        "iContrast":data.iContrast,
                        "iSaturation":data.iSaturation
                    };
                    avatar.loadMovieAtES(data.strES, data.sFile, data.sLink);
                };
                if (avatar.isMyAvatar)
                {
                    avatar.equipItem(data.ItemID);
                    inventoryRefresh();
                };
            };
            this.game.antiLagCheck();
        }

        private function unequipItem(data:Object):void
        {
            var statsPanel:StatsPanel;
            var avatar:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (avatar != null)
            {
                if (avatar.pMC != null)
                {
                    delete avatar.objData.eqp[data.strES];
                    avatar.unloadMovieAtES(data.strES);
                };
                if (avatar.isMyAvatar)
                {
                    avatar.unequipItem(data.ItemID);
                    inventoryRefresh();
                    statsPanel = StatsPanel(UIController.getByName("stats_panel"));
                    if (statsPanel)
                    {
                        statsPanel.updateBoosts();
                    };
                };
            };
        }

        private function referralReward(data:Object):void
        {
            var itemID:int;
            var dFrameMC:DFrameMC;
            var itemDropped:Object;
            for (itemID in data.items)
            {
                itemDropped = null;
                if (this.game.world.invTree[itemID] == null)
                {
                    this.game.world.invTree[itemID] = this.game.copyObj(data.items[itemID]);
                    this.game.world.invTree[itemID].iQty = 0;
                    itemDropped = data.items[itemID];
                }
                else
                {
                    itemDropped = this.game.copyObj(this.game.world.invTree[itemID]);
                    itemDropped.iQty = int(data.items[itemID].iQty);
                };
            };
            dFrameMC = DFrameMC(this.game.ui.dropStack.addChild(new DFrameMC(((itemDropped is Item) ? Item(itemDropped) : new Item(itemDropped)))));
            dFrameMC.init();
            dFrameMC.fY = (dFrameMC.y = -(dFrameMC.fHeight + 8));
            dFrameMC.fX = (dFrameMC.x = -(dFrameMC.fWidth >> 1));
            this.game.cleanDropStack();
        }

        private function denyDrop(data:Object):void
        {
            var mc:AbstractDropFrame;
            var i:int;
            while (i < this.game.ui.dropStack.numChildren)
            {
                mc = AbstractDropFrame(this.game.ui.dropStack.getChildAt(i));
                if (((!(mc.fData == null)) && (mc.fData.ItemID == data.ItemID)))
                {
                    if (data.bSuccess == 1)
                    {
                        mc.gotoAndPlay("out");
                        if (DropMenu(this.game.ui.getChildByName("dropMenu")) != null)
                        {
                            DropMenu(this.game.ui.getChildByName("dropMenu")).getDropOrDeny(data);
                        };
                    }
                    else
                    {
                        MainController.modal("Item could not be removed from your dropped list.", null, {}, "red,medium", "mono");
                        mc.cnt.ybtn.mouseEnabled = true;
                        mc.cnt.ybtn.mouseChildren = true;
                    };
                };
                i++;
            };
            this.game.cleanDropStack();
        }

        private function loadConfig(data:Object):void
        {
            Config.Data = data;
        }

        private function getDrop(data:Object):void
        {
            var abstractDropFrame:AbstractDropFrame;
            var itemDropped:Object;
            var i:int;
            while (i < this.game.ui.dropStack.numChildren)
            {
                abstractDropFrame = AbstractDropFrame(this.game.ui.dropStack.getChildAt(i));
                if (((!(abstractDropFrame.fData == null)) && (abstractDropFrame.fData.ItemID == data.ItemID)))
                {
                    if (data.bSuccess)
                    {
                        abstractDropFrame.gotoAndPlay("out");
                    }
                    else
                    {
                        if (data.bBank)
                        {
                            MainController.modal("Item could not be added to your inventory! Please make sure your inventory is not full or the item is already present in your inventory/bank.", null, {}, "red,medium", "mono");
                            abstractDropFrame.cnt.ybtn.mouseEnabled = true;
                            abstractDropFrame.cnt.ybtn.mouseChildren = true;
                        }
                        else
                        {
                            MainController.modal("Item could not be added to your inventory.", null, {}, "red,medium", "mono");
                            abstractDropFrame.gotoAndPlay("out");
                        };
                    };
                };
                i++;
            };
            if (data.bSuccess)
            {
                itemDropped = this.game.copyObj(this.game.world.invTree[data.ItemID]);
                itemDropped.CharItemID = data.CharItemID;
                itemDropped.bBank = data.bBank;
                itemDropped.iHue = data.iHue;
                itemDropped.iBrightness = data.iBrightness;
                itemDropped.iContrast = data.iContrast;
                itemDropped.iSaturation = data.iSaturation;
                itemDropped.iQty = int(data.iQty);
                if (data.EnhID != null)
                {
                    itemDropped.EnhID = int(data.EnhID);
                    itemDropped.EnhLvl = int(data.EnhLvl);
                    itemDropped.EnhPatternID = int(data.EnhPatternID);
                    itemDropped.EnhRty = int(data.EnhRty);
                };
                this.game.world.myAvatar.addItem(itemDropped);
                this.game.world.updateQuestProgress("item", itemDropped);
                if (data.showDrop == 1)
                {
                    this.game.showItemDrop(itemDropped, false, false);
                };
                inventoryRefresh();
                if (((this.game.ui.mcPopup.currentLabel == "Shop") || (this.game.ui.mcPopup.currentLabel == "MergeShop")))
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshItems"});
                };
                if (data.pendingID != null)
                {
                    this.game.world.myAvatar.updatePending(int(data.pendingID));
                };
                if (DropMenu(this.game.ui.getChildByName("dropMenu")) != null)
                {
                    DropMenu(this.game.ui.getChildByName("dropMenu")).getDropOrDeny(data);
                };
            };
        }

        private function Wheel(data:Object):void
        {
            var itemsKey:String;
            var itemObj:Object;
            var itemWheel:Object = this.game.copyObj(data.dropItems[data.wheelBoost]);
            itemWheel.CharItemID = data.charItem1;
            if (this.game.world.invTree[data.wheelBoost] == null)
            {
                itemWheel.bBank = 0;
            };
            itemWheel.iQty = ((data.dropQty != null) ? Number(data.dropQty) : 1);
            this.game.world.myAvatar.addItem(itemWheel);
            itemWheel = this.game.copyObj(data.dropItems[data.wheelPotion]);
            itemWheel.CharItemID = data.charItem2;
            if (this.game.world.invTree[data.wheelPotion] == null)
            {
                itemWheel.bBank = 0;
            };
            itemWheel.iQty = 1;
            this.game.world.myAvatar.addItem(itemWheel);
            if (data.Item != null)
            {
                itemWheel = this.game.copyObj(data.Item);
                itemWheel.CharItemID = data.CharItemID;
                itemWheel.bBank = 0;
                itemWheel.iQty = 1;
                this.game.world.myAvatar.addItem(itemWheel);
            };
            inventoryRefresh();
            try
            {
                this.game.world.map.doWheelDrop(data.Item, data.dropQty);
            }
            catch(e:Error)
            {
                trace(e);
            };
            for (itemsKey in data.items)
            {
                if (this.game.world.invTree[itemsKey] == null)
                {
                    itemObj = this.game.copyObj(data.items[itemsKey]);
                }
                else
                {
                    itemObj = this.game.copyObj(this.game.world.invTree[itemsKey]);
                    itemObj.iQty = int(data.items[itemsKey].iQty);
                };
                this.game.showItemDrop(itemObj, false);
                this.game.world.myAvatar.addItem(itemObj);
            };
        }

        private function powerGem(data:Object):void
        {
            var ItemID:int;
            var itemObj:Object;
            for (ItemID in data.items)
            {
                if (this.game.world.invTree[ItemID] == null)
                {
                    itemObj = this.game.copyObj(data.items[ItemID]);
                }
                else
                {
                    itemObj = this.game.copyObj(this.game.world.invTree[ItemID]);
                    itemObj.iQty = int(data.items[ItemID].iQty);
                };
                this.game.showItemDrop(itemObj, false);
                this.game.world.myAvatar.addItem(itemObj);
            };
        }

        private function forceAddItem(data:Object):void
        {
            var itemKey:String;
            var item:Object;
            for (itemKey in data.items)
            {
                item = this.game.copyObj(data.items[itemKey]);
                this.game.showItemDrop(item, false);
                this.game.world.myAvatar.addItem(item);
            };
            inventoryRefresh();
        }

        private function warvalues(data:Object):void
        {
            this.game.world.map.updateWarValues(data.wars);
        }

        private function enhp(data:Object):void
        {
            for each (this.o in data.o)
            {
                this.game.world.enhPatternTree[this.o.ID] = this.o;
            };
        }

        private function mtc(data:Object):void
        {
            this.game.world.actionReady = false;
            this.game.world.bitWalk = false;
            if ((((!(this.game.world.bPvP)) && (!(data.Frame == "Enter"))) && (!(this.game.frameCheck(this.game.world.map, data.Frame)))))
            {
                Game.root.chatF.pushMsg("warning", (("The map frame/room <font color='#FFFFFF'>" + data.Frame) + "</font> does not exist."), "SERVER", "", 0);
                data.Frame = "Enter";
            };
            if (!this.game.frameCheck(this.game.world.map, data.Frame))
            {
                if (this.game.world.bPvP)
                {
                    data.Frame = "Enter0";
                    data.Pad = "Spawn";
                }
                else
                {
                    data.Frame = "Enter1";
                    data.Pad = "Spawn";
                };
            };
            var property:Object = {
                "strFrame":data.Frame,
                "strPad":data.Pad
            };
            if (this.game.userPreference.data.bitCheckedMobile)
            {
                this.game.ui.joystick.resetController();
            };
            if (data.Pad.toLowerCase() != "none")
            {
                property.tx = 0;
                property.ty = 0;
            };
            this.game.world.uoTreeLeafSet(this.game.network.myUserName, property);
            this.game.world.strFrame = data.Frame;
            this.game.world.strPad = data.Pad;
            this.game.world.bPK = false;
            this.game.world.exitCell();
            Game.executeAtFrame(this.game.world.map, data.Frame, function ():void
            {
                game.world.setupCellData(data.Frame);
                game.updateAreaName();
            });
            if (this.game.frameCheck(this.game.world.map, "Blank"))
            {
                this.game.world.map.gotoAndStop("Blank");
                this.game.world.map.gotoAndStop(data.Frame);
            };
            if (this.game.mcConnDetail.toHide)
            {
                this.game.mcConnDetail.toHide = false;
                this.game.mcConnDetail.hideConn();
            };
        }

        private function acceptQuest(data:Object):void
        {
            if (data.success)
            {
                this.game.world.acceptQuest(data.questId, true);
                return;
            };
            var questPopup:QFrameMC = QFrameMC(UIController.getByName("quest_frame"));
            if (questPopup != null)
            {
                questPopup.cnt.gotoAndPlay("back");
            };
        }

        private function retrieveQuests(data:Object):void
        {
            var Quests:Array;
            var Counter:int;
            if (data.bitSuccess)
            {
                Quests = data.Quests;
                Counter = 0;
                while (Counter < Quests.length)
                {
                    this.game.world.acceptQuest(Quests[Counter], true);
                    Counter++;
                };
            };
        }

        private function getQuests(data:Object):void
        {
            var questPopup:QFrameMC;
            var i:int;
            for (this.qi in data.quests)
            {
                if (this.game.world.questTree[this.qi] == null)
                {
                    this.o = data.quests[this.qi];
                    this.o.reward = [];
                    this.game.world.questTree[this.qi] = this.o;
                    for (this.qr in this.o.oReqd)
                    {
                        if (this.game.world.invTree[this.qr] == null)
                        {
                            this.game.world.invTree[this.qr] = this.o.oReqd[this.qr];
                            this.game.world.invTree[this.qr].iQty = 0;
                        };
                    };
                    for (this.qj in this.o.oItems)
                    {
                        if (this.game.world.invTree[this.qj] == null)
                        {
                            this.game.world.invTree[this.qj] = this.o.oItems[this.qj];
                            this.game.world.invTree[this.qj].iQty = 0;
                        };
                    };
                    this.qk = "";
                    this.qat = ["itemsS", "itemsC", "itemsR", "itemsROLL", "itemsR_ONE"];
                    i = 0;
                    while (i < this.qat.length)
                    {
                        this.s = this.qat[i];
                        if (this.o.oRewards[this.s] != null)
                        {
                            for (this.ri in this.o.oRewards[this.s])
                            {
                                this.qk = ((isNaN(this.ri)) ? this.ri.ItemID : this.o.oRewards[this.s][this.ri].ItemID);
                                if (this.game.world.invTree[this.qk] == null)
                                {
                                    this.game.world.invTree[this.qk] = this.game.copyObj(this.o.oRewards[this.s][this.ri]);
                                    this.game.world.invTree[this.qk].iQty = 0;
                                };
                            };
                        };
                        i++;
                    };
                };
            };
            questPopup = QFrameMC(UIController.getByName("quest_frame"));
            if (questPopup != null)
            {
                questPopup.open();
            };
        }

        private function getQuests2(data:Object):void
        {
            var i:int;
            for (this.qi in data.quests)
            {
                if (this.game.world.questTree[this.qi] == null)
                {
                    this.o = data.quests[this.qi];
                    this.game.world.questTree[this.qi] = this.o;
                    for (this.qr in this.o.oReqd)
                    {
                        if (this.game.world.invTree[this.qr] == null)
                        {
                            this.game.world.invTree[this.qr] = this.o.oReqd[this.qr];
                            this.game.world.invTree[this.qr].iQty = 0;
                        };
                    };
                    for (this.qj in this.o.oItems)
                    {
                        if (this.game.world.invTree[this.qj] == null)
                        {
                            this.game.world.invTree[this.qj] = this.o.oItems[this.qj];
                            this.game.world.invTree[this.qj].iQty = 0;
                        };
                    };
                    this.qk = "";
                    this.qat = ["itemsS", "itemsC", "itemsR", "itemsROLL", "itemsR_ONE"];
                    i = 0;
                    while (i < this.qat.length)
                    {
                        this.s = this.qat[i];
                        if (this.o.oRewards[this.s] != null)
                        {
                            for (this.ri in this.o.oRewards[this.s])
                            {
                                if (isNaN(this.ri))
                                {
                                    this.qk = this.ri.ItemID;
                                }
                                else
                                {
                                    this.qk = this.o.oRewards[this.s][this.ri].ItemID;
                                };
                                if (this.game.world.invTree[this.qk] == null)
                                {
                                    this.game.world.invTree[this.qk] = this.game.copyObj(this.o.oRewards[this.s][this.ri]);
                                    this.game.world.invTree[this.qk].iQty = 0;
                                };
                            };
                        };
                        i++;
                    };
                };
            };
            this.game.createApop();
        }

        private function ccqr(data:Object):void
        {
            if (!data.bSuccess)
            {
                this.game.MsgBox.notify(data.Message);
                return;
            };
            this.game.world.completeQuest(data.QuestID);
            var questPopup:QFrameMC = QFrameMC(UIController.getByName("quest_frame"));
            if (questPopup != null)
            {
                questPopup.turninResult(data.QuestID);
            };
            this.game.showQuestpopup(data);
            if (this.game.apop != null)
            {
                this.game.apop.questComplete(data.QuestID);
            };
            this.game.mixer.playSound("QuestComplete");
            if (MovieClip(this.game.world.map).eventTrigger != undefined)
            {
                this.game.world.map.eventTrigger({
                    "cmd":"questComplete",
                    "args":data.QuestID
                });
            };
        }

        private function updateQuest(data:Object):void
        {
            this.game.world.setQuestValue(data.iIndex, data.iValue);
        }

        private function showQuestLink(data:Object):void
        {
            this.game.world.showQuestLink(data);
        }

        private function frameUpdate(data:Object):void
        {
            this.game.world.frames = data.frames;
            if (this.game.world.strFrame == data.frame)
            {
                this.game.world.mapController.destroy();
                this.game.world.updateMonstersAndProps();
                this.game.world.mapController.build(this.game.world.frames, this.game.world.strFrame);
                this.game.world.setupCellData(data.frame);
            };
        }

        private function initMonData(data:Object):void
        {
            for (this.m in data.mon)
            {
                this.game.world.updateMonster(data.mon[this.m]);
            };
        }

        private function aura(data:Object):void
        {
            this.game.world.handleAuraEvent(data.cmd, data);
            if (((!(Game.root.userPreference.data.hideSelfAuras)) && (!(this.game.playerAuras == null))))
            {
                this.game.playerAuras.handleAura(data);
            };
            if (((!(Game.root.userPreference.data.hideTargetAuras)) && (!(this.game.targetAuras == null))))
            {
                this.game.targetAuras.handleAura(data);
            };
        }

        private function clearAuras():void
        {
            var aura:Object;
            var aurasNonStatic:Array = [];
            var aurasStatic:Array = [];
            for each (aura in this.game.world.myAvatar.dataLeaf.auras)
            {
                if (aura.isStatic)
                {
                    aurasStatic.push(aura);
                }
                else
                {
                    aurasNonStatic.push(aura);
                };
            };
            this.game.world.showAuraChange({
                "cmd":"aura-",
                "auras":aurasNonStatic
            }, this.game.world.myAvatar, this.game.world.myAvatar.dataLeaf);
            this.game.world.myAvatar.dataLeaf.auras = aurasStatic;
        }

        private function uotls(data:Object):void
        {
            this.game.userTreeWrite(data.unm, data.o);
        }

        private function mtls(data:Object):void
        {
            this.game.monsterTreeWrite(data.id, data.o);
        }

        private function ntls(data:Object):void
        {
            this.game.npcTreeWrite(data.id, data.o);
        }

        private function cb(data:Object):void
        {
            var b:int;
            var m:int;
            var p:String;
            var i:int;
            if (data.n != null)
            {
                for (b in data.n)
                {
                    this.game.npcTreeWrite(b, data.n[b]);
                };
            };
            if (data.m != null)
            {
                for (m in data.m)
                {
                    this.game.monsterTreeWrite(m, data.m[m]);
                };
            };
            if (data.p != null)
            {
                for (p in data.p)
                {
                    this.game.userTreeWrite(p, data.p[p]);
                };
            };
            if (((!(data.anims == null)) && (this.game.sfcSocial)))
            {
                for each (this.o in data.anims)
                {
                    this.game.doAnim(this.o, data.isProc);
                };
            };
            if (data.a != null)
            {
                i = 0;
                while (i < data.a.length)
                {
                    this.game.world.handleAuraEvent(data.a[i].cmd, data.a[i]);
                    i++;
                };
            };
        }

        private function ct(data:Object):void
        {
            var username:String;
            var i:int;
            var anim2:Object = {};
            var updateID:int;
            if (data.n != null)
            {
                updateID = 0;
                for (updateID in data.n)
                {
                    this.game.npcTreeWrite(updateID, data.n[updateID]);
                };
            };
            if (data.m != null)
            {
                updateID = 0;
                for (updateID in data.m)
                {
                    this.game.monsterTreeWrite(updateID, data.m[updateID]);
                };
            };
            if (data.p != null)
            {
                for (username in data.p)
                {
                    this.game.userTreeWrite(username, data.p[username]);
                };
            };
            if (data.a != null)
            {
                i = 0;
                while (i < data.a.length)
                {
                    this.game.world.handleAuraEvent(data.a[i].cmd, data.a[i]);
                    i = (i + 1);
                };
            };
            if (data.sara != null)
            {
                for each (this.o in data.sara)
                {
                    this.game.world.handleSAR(this.o);
                };
            };
            if (data.sarsa != null)
            {
                for each (this.o in data.sarsa)
                {
                    this.game.world.handleSARS(this.o);
                };
            };
            if (((!(data.anims == null)) && (this.game.sfcSocial)))
            {
                for each (this.o in data.anims)
                {
                    try
                    {
                        this.game.doAnim(this.o, data.isProc, anim2[this.o.strl]);
                    }
                    catch(e:Error)
                    {
                        if (Config.isDebug)
                        {
                            trace("doAnim", e.getStackTrace());
                        };
                    };
                };
            };
            if (data.pvp != null)
            {
                switch (data.pvp.cmd)
                {
                    case "PVPS":
                        this.game.updatePVPScore(data.pvp.pvpScore);
                        break;
                    case "PVPC":
                        this.game.world.PVPResults.pvpScore = data.pvp.pvpScore;
                        this.game.world.PVPResults.team = data.pvp.team;
                        this.game.updatePVPScore(data.pvp.pvpScore);
                        this.game.togglePVPPanel("results");
                        break;
                };
            };
        }

        private function updateTemporaryItems(data:Object):void
        {
            this.game.world.myAvatar.removeItemTemporary(data.ItemID, data.Quantity);
            inventoryRefresh();
        }

        private function sar(data:Object):void
        {
            this.game.world.handleSAR(data);
        }

        private function sars(data:Object):void
        {
            this.game.world.handleSARS(data);
        }

        private function showAuraResult(data:Object):void
        {
            this.game.world.showAuraImpact(data);
        }

        private function anim(data:Object):void
        {
            if (this.game.sfcSocial)
            {
                this.game.doAnim(data);
            };
        }

        private function sAct(data:Object):void
        {
            var actObj:Object;
            var action:Skill;
            var actIconMC:ib2;
            var slot:int;
            var blankMC:ib1;
            var passiveObj:Object;
            var passive:Skill;
            var aura:Object;
            var color:Color = new Color();
            color.setTint(0x333333, 0.9);
            this.game.world.actions = new Action();
            this.game.world.actionMap = [null, null, null, null, null, null];
            this.game.sActAdd(0);
            this.game.sActAdd(1);
            this.game.sActAdd(2);
            this.game.sActAdd(3);
            this.game.sActAdd(4);
            this.game.sActAdd(5);
            var iai:int;
            while (iai < data.actions.active.length)
            {
                actObj = data.actions.active[iai];
                action = new Skill(actObj);
                action.sArg1 = "";
                action.sArg2 = "";
                this.game.world.actions.active.push(action);
                if (actObj == null)
                {
                }
                else
                {
                    action.ts = 0;
                    action.actID = -1;
                    action.lock = false;
                    this.game.world.actionMap[iai] = action.ref;
                    actIconMC = this.game.ui.mcInterface.actBar.addChild(new ib2());
                    slot = ((iai < (data.actions.active.length - 1)) ? iai : 5);
                    blankMC = this.game.ui.mcInterface.actBar.getChildByName(("blank" + slot));
                    actIconMC.x = blankMC.x;
                    actIconMC.y = blankMC.y;
                    if (this.game.userPreference.data.bitCheckedMobile)
                    {
                        actIconMC.visible = (!(this.game.ui.mcInterface.actBar.btnToggle.y == 29));
                        actIconMC.width = blankMC.width;
                        actIconMC.height = blankMC.height;
                        actIconMC.y = blankMC.y;
                    }
                    else
                    {
                        actIconMC.width = blankMC.width;
                        actIconMC.height = blankMC.height;
                    };
                    actIconMC.name = String(("i" + (iai + 1)));
                    actIconMC.actionIndex = iai;
                    actIconMC.actObj = action;
                    actIconMC.icon2 = null;
                    actIconMC.tQty.visible = false;
                    this.game.updateIcons([actIconMC], action.icon.split(","), null);
                    blankMC.visible = false;
                    actIconMC.addEventListener(MouseEvent.MOUSE_OVER, this.game.actIconOver, false, 0, true);
                    actIconMC.addEventListener(MouseEvent.MOUSE_OUT, this.game.actIconOut, false, 0, true);
                    actIconMC.mouseChildren = false;
                    if (action.auto)
                    {
                        this.game.world.actions.auto = this.game.world.actions.active[iai];
                    }
                    else
                    {
                        this.game.world.actions.active[iai].auto = false;
                    };
                    if (action.isOK)
                    {
                        actIconMC.addEventListener(MouseEvent.CLICK, this.game.actIconClick, false, 0, true);
                        actIconMC.buttonMode = true;
                    }
                    else
                    {
                        actIconMC.cnt.transform.colorTransform = color;
                    };
                };
                iai++;
            };
            this.game.world.myAvatar.dataLeaf.passives = [];
            if (data.actions.passive != null)
            {
                for each (passiveObj in data.actions.passive)
                {
                    passive = new Skill(passiveObj);
                    passive.sArg1 = "";
                    passive.sArg2 = "";
                    this.game.world.actions.passive.push(passive);
                    if (passive.auras != null)
                    {
                        for each (aura in actObj.auras)
                        {
                            this.game.world.myAvatar.dataLeaf.passives.push(aura);
                        };
                    };
                };
            };
            if (((!(Game.root.userPreference.data.hideSelfAuras)) && (!(this.game.playerAuras == null))))
            {
                this.game.playerAuras.onReset();
            };
            if (((!(Game.root.userPreference.data.hideTargetAuras)) && (!(this.game.targetAuras == null))))
            {
                this.game.targetAuras.onReset();
            };
        }

        private function seia(data:Object):void
        {
            var action:Skill;
            if (data.iRes == 1)
            {
                for each (action in this.game.world.actions.active)
                {
                    if (action.ref == "i1")
                    {
                        for (this.s in data.o)
                        {
                            if (((((!(this.s == "nam")) && (!(this.s == "ref"))) && (!(this.s == "desc"))) && (!(this.s == "typ"))))
                            {
                                action[this.s] = data.o[this.s];
                            };
                        };
                    };
                };
            };
        }

        private function stu(data:Object):void
        {
            var autoAttack:Skill;
            var hasteCoeff:Number;
            var now:Number;
            var action:Skill;
            var stu:String;
            var avt:Avatar = this.game.world.myAvatar;
            var unm:String = this.game.network.myUserName;
            var uoLeaf:Object = this.game.world.uoTreeLeaf(unm);
            if (data.wDPS != null)
            {
                uoLeaf.wDPS = data.wDPS;
            };
            if (data.mDPS != null)
            {
                uoLeaf.mDPS = data.mDPS;
            };
            if (uoLeaf.sta == null)
            {
                uoLeaf.sta = {};
            };
            for (this.stuS in data.sta)
            {
                if (data.sta.hasOwnProperty(this.stuS))
                {
                    uoLeaf.sta[this.stuS] = data.sta[this.stuS];
                    if (MainController.stats.indexOf(this.stuS.substr(1)) > -1)
                    {
                        uoLeaf.sta[this.stuS] = int(uoLeaf.sta[this.stuS]);
                    }
                    else
                    {
                        uoLeaf.sta[this.stuS] = Number(uoLeaf.sta[this.stuS]);
                    };
                    if (this.stuS.toLowerCase().indexOf("$tha") > -1)
                    {
                        autoAttack = this.game.world.getAutoAttack();
                        if (!this.game.world.myAvatar)
                        {
                            return;
                        };
                        hasteCoeff = this.game.world.myAvatar.haste;
                        if ((((!(autoAttack == null)) && (!(uoLeaf == null))) && (!(uoLeaf.sta == null))))
                        {
                            this.cd = Math.round((autoAttack.cd * hasteCoeff));
                            if (this.game.world.autoActionTimer.running)
                            {
                                this.game.world.autoActionTimer.delay = (this.game.world.autoActionTimer.delay - (this.game.world.autoActionTimer.delay - this.cd));
                                this.game.world.autoActionTimer.delay = (this.game.world.autoActionTimer.delay + 100);
                                this.game.world.autoActionTimer.reset();
                                this.game.world.autoActionTimer.start();
                            }
                            else
                            {
                                this.game.world.autoActionTimer.delay = this.cd;
                            };
                        };
                        this.game.world.GCD = Math.round((hasteCoeff * this.game.world.GCDO));
                        now = new Date().getTime();
                        for each (action in this.game.world.actions.active)
                        {
                            if (((((action.isOK) && (!(this.game.world.getActIcons(action)[0] == null))) && (this.game.world.getActIcons(action)[0].icon2 == null)) && ((now - action.ts) < (action.cd * hasteCoeff))))
                            {
                                this.game.world.coolDownAct(action, ((action.cd * hasteCoeff) - (now - action.ts)), now);
                            };
                        };
                    };
                    if (this.stuS.toLowerCase().indexOf("$cmc") > -1)
                    {
                        this.game.world.updateActBar();
                    };
                };
            };
            if (data.tempSta != null)
            {
                uoLeaf.tempSta = data.tempSta;
                if (("updatePStats" in this.game.world.map))
                {
                    this.game.world.map.updatePStats();
                };
            };
            if (avt != null)
            {
                this.game.world.updatePortrait(avt);
            };
            var statsPanel:StatsPanel = StatsPanel(UIController.getByName("stats_panel"));
            if (this.game.statsNewClass)
            {
                this.game.baseClassStats = {};
                for (stu in data.sta)
                {
                    this.game.baseClassStats[stu] = data.sta[stu];
                };
                if (statsPanel)
                {
                    statsPanel.updateBase();
                };
                this.game.statsNewClass = false;
            };
            if (statsPanel)
            {
                statsPanel.update();
            };
        }

        private function cvu(data:Object):void
        {
            this.game.updateCoreValues(data.o);
        }

        private function event(data:Object):void
        {
            this.game.world.map.eventTrigger(data);
        }

        private function ia(data:Object):void
        {
            var mc:* = undefined;
            var mcPath:Array;
            var avt:Avatar;
            if (("iaPathMC" in data))
            {
                try
                {
                    mc = this.game.world;
                    mcPath = data.iaPathMC.split(".");
                    while (mcPath.length > 0)
                    {
                        this.s = String(mcPath.shift());
                        mc = ((mc.getChildByName(this.s) != null) ? (mc.getChildByName(this.s) as MovieClip) : mc[this.s]);
                    };
                }
                catch(e:Error)
                {
                    trace(e);
                };
            }
            else
            {
                if (data.str != null)
                {
                    avt = this.game.world.getAvatarByUserID(int(data.str));
                    if (avt != null)
                    {
                        mc = avt.pMC;
                    };
                }
                else
                {
                    mc = MovieClip(this.game.world.CHARS.getChildByName(data.oName));
                };
            };
            if (((!(mc == null)) && (!(mc == this.game.world))))
            {
                try
                {
                    if (data.typ === "rval")
                    {
                        mc.userName = data.unm;
                        mc.iaF(data);
                    }
                    else
                    {
                        if (data.typ === "str")
                        {
                            if (data.str == null)
                            {
                                mc.userName = data.unm;
                            };
                            mc.iaF(data);
                        }
                        else
                        {
                            if (data.typ === "flourish")
                            {
                                mc.userName = data.unm;
                                mc.gotoAndPlay(data.oFrame);
                            };
                        };
                    };
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
        }

        private function siau(data:Object):void
        {
            this.game.world.updateCellMap(data);
        }

        private function umsg(data:Object):void
        {
            this.game.addUpdate(data.s);
        }

        private function gi(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (((data.owner + " has invited you to join the guild ") + data.gName) + ". Do you accept?");
            modalO.callback = this.game.world.doGuildAccept;
            modalO.params = {
                "guildID":data.guildID,
                "owner":data.owner
            };
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", ((data.owner + " has invited you to join the guild ") + data.gName), "SERVER", "", 0);
        }

        private function gd(data:Object):void
        {
            this.game.chatF.pushMsg("server", (data.unm + " has declined your invitation."), "SERVER", "", 0);
        }

        private function ga(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserName(data.unm);
            if (avt != null)
            {
                avt.updateGuild(data.guild);
                if (avt.isMyAvatar)
                {
                    this.game.world.myAvatar.objData.guildRank = data.guildRank;
                    this.game.chatF.chn.guild.act = 1;
                    this.game.chatF.pushMsg("server", "You have joined the guild.", "SERVER", "", 0);
                }
                else
                {
                    if (this.game.world.myAvatar.objData.guild.Name == avt.objData.guild.Name)
                    {
                        this.game.chatF.pushMsg("server", (avt.pnm + " has joined the guild."), "SERVER", "", 0);
                        this.game.world.myAvatar.updateGuild(data.guild);
                    };
                };
            }
            else
            {
                if (data.guild.Name == this.game.world.myAvatar.objData.guild.Name)
                {
                    this.game.chatF.pushMsg("server", (data.unm + " has joined the guild."), "SERVER", "", 0);
                    this.game.world.myAvatar.updateGuild(data.guild);
                };
            };
        }

        private function setRank(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserName(data.unm);
            if (avt != null)
            {
                if (avt.isMyAvatar)
                {
                    this.game.world.myAvatar.objData.guildRank = data.guildRank;
                };
            };
        }

        private function gr(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserName(data.unm);
            if (avt != null)
            {
                avt.updateGuild(null);
                if (avt.isMyAvatar)
                {
                    this.game.world.myAvatar.objData.guildRank = data.guildRank;
                    this.game.chatF.chn.guild.act = 0;
                    this.game.chatF.pushMsg("server", "You have been removed from the guild.", "SERVER", "", 0);
                }
                else
                {
                    if (this.game.world.myAvatar.objData.guild.Name == avt.objData.guild.Name)
                    {
                        this.game.chatF.pushMsg("server", (avt.pnm + " has been removed from the guild."), "SERVER", "", 0);
                        this.game.world.myAvatar.updateGuild(data.guild);
                    };
                };
            };
            if (this.game.world.myAvatar.objData.guild != null)
            {
                if (this.game.world.myAvatar.objData.guild.Name == data.guild.Name)
                {
                    this.game.chatF.pushMsg("server", (data.unm + " has been removed from the guild."), "SERVER", "", 0);
                    this.game.world.myAvatar.updateGuild(data.guild);
                };
            };
        }

        private function guildLeave(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserName(data.unm);
            avt.updateGuild(null);
            if (avt.isMyAvatar)
            {
                this.game.world.myAvatar.objData.guildRank = data.guildRank;
                this.game.chatF.chn.guild.act = 0;
                this.game.chatF.pushMsg("server", "You have been removed from the guild.", "SERVER", "", 0);
                if (this.game.world.myAvatar.objData.guild != null)
                {
                    if (this.game.world.myAvatar.objData.guild.Name == data.guild.Name)
                    {
                        this.game.chatF.pushMsg("server", (data.unm + " left the guild."), "SERVER", "", 0);
                        this.game.world.myAvatar.updateGuild(data.guild);
                    };
                };
            };
        }

        private function guildDelete(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserName(data.unm);
            if (avt != null)
            {
                avt.updateGuild(null);
                if (avt.isMyAvatar)
                {
                    this.game.world.myAvatar.objData.guildRank = data.guildRank;
                    this.game.chatF.pushMsg("server", data.msg, "SERVER", "", 0);
                };
            };
        }

        private function gMOTD(data:Object):void
        {
            this.game.world.myAvatar.objData.guild.MOTD = data.MOTD;
        }

        private function gDescription(data:Object):void
        {
            this.game.world.myAvatar.objData.guild.Description = data.Description;
        }

        private function updateGuild(data:Object):void
        {
            try
            {
                if (this.game.world.myAvatar.objData != null)
                {
                    this.game.world.myAvatar.updateGuild(data.guild);
                };
            }
            catch(e:Error)
            {
                trace(e);
            };
            if (data.msg != null)
            {
                this.game.chatF.pushMsg("server", data.msg, "SERVER", "", 0);
            };
            if (this.game.ui.mcPopup.currentLabel == "GuildPanel")
            {
                this.game.ui.mcPopup.GuildRewrite.refreshData();
            };
        }

        private function updatePartyRank(data:Object):void
        {
            Game.root.world.myAvatar.objData.partyRank = data.rank;
        }

        private function updateParty(data:Object):void
        {
            try
            {
                if (this.game.world.myAvatar.objData != null)
                {
                    this.game.world.myAvatar.updateParty(data.party);
                };
            }
            catch(e:Error)
            {
                trace(e);
            };
            if (data.msg != null)
            {
                this.game.chatF.pushMsg("server", data.msg, "SERVER", "", 0);
            };
        }

        private function gc(data:Object):void
        {
            var avatar:Avatar = this.game.world.getAvatarByUserID(data.uid);
            if (avatar != null)
            {
                avatar.initGuild(data.guild);
                if (avatar.isMyAvatar)
                {
                    this.game.world.myAvatar.objData.guildRank = data.guildRank;
                };
            };
        }

        private function buyGSlots(data:Object):void
        {
            this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins + int(data.cost));
            this.game.ui.mcInterface.mcGold.strGold.text = this.game.world.myAvatar.objData.intCoins;
        }

        private function gRename(data:Object):void
        {
            this.game.world.myAvatar.objData.intGold = (this.game.world.myAvatar.objData.intGold + int(data.cost));
            this.game.ui.mcInterface.mcGold.strGold.text = this.game.world.myAvatar.objData.intGold;
            if (this.game.ui.mcPopup.currentLabel == "GuildPanel")
            {
                this.game.ui.mcPopup.updateGuildWindow();
            };
        }

        private function interior(data:Object):void
        {
            this.game.world.guildHallData.updateItems(data.items);
        }

        private function guildhall(data:Object):void
        {
            this.game.world.guildHallData.handleHallUpdate(data);
        }

        private function guildinv(data:Object):void
        {
            this.game.world.guildHallData.updateInventory(data.guildInventory);
        }

        private function pi(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (((data.owner + " has invited you to join their group (") + data.party.name) + "). Do you accept?");
            modalO.callback = this.game.world.partyController.doPartyAccept;
            modalO.params = {"pid":data.party.id};
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (((data.owner + " has invited you to a group (") + data.party.name) + ")."), "SERVER", "", 0);
        }

        private function pr(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserName(data.unm);
            if (avt != null)
            {
                avt.updateParty(null);
                if (((this.game.ui.mcPopup.currentLabel == "PartyPanel") && (avt.isMyAvatar)))
                {
                    this.game.ui.mcPopup.mcPartyPanel.fClose();
                };
            };
            this.game.world.partyController.removePartyMember(String(data.unm).toLowerCase());
        }

        private function pp(data:Object):void
        {
            this.nam = this.game.world.partyController.partyOwner;
            this.game.world.partyController.partyOwner = data.owner;
            if (this.nam != this.game.world.partyController.partyOwner)
            {
                this.game.chatF.pushMsg("server", (this.game.world.partyController.partyOwner + " is now the party leader."), "SERVER", "", 0);
            };
            this.game.world.partyController.updatePartyFrame();
        }

        private function raidUpdate(data:Object):void
        {
            var GuildRaidBar:MovieClip = this.game.ui.RaidBar;
            GuildRaidBar.t1.mouseEnabled = false;
            GuildRaidBar.t1.text = (((((("Raid: " + data.name) + " (") + data.dead) + "/") + data.total) + ")");
            GuildRaidBar.cnt.fill.scaleX = (data.dead / data.total);
            GuildRaidBar.cnt.tip.x = ((GuildRaidBar.cnt.fill.x + GuildRaidBar.cnt.fill.width) - GuildRaidBar.cnt.tip.width);
        }

        private function raidInvite(data:Object):void
        {
            MainController.modal((((data.unm + " invited you to a raid in ") + data.map) + ". Do you accept?"), function (event:Object):void
            {
                Game.root.network.send(((event.accept) ? "raidAccept" : "raidDecline"), [event.unm]);
            }, data, null, "dual");
            this.game.chatF.pushMsg("server", (((data.unm + " invited you to a Raid in ") + data.map) + ". Do you accept?"), "SERVER", "", 0);
            this.game.mixer.playSound("RaidStart");
        }

        private function ps(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (data.unm + " wants to summon you to them.  Do you accept?");
            modalO.callback = this.game.world.partyController.acceptPartySummon;
            modalO.params = data;
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (data.unm + " is trying to summon you to them."), "SERVER", "", 0);
        }

        private function pd(data:Object):void
        {
            this.game.chatF.pushMsg("server", (data.unm + " has declined your invitation."), "SERVER", "", 0);
        }

        private function pc():void
        {
            if (this.game.world.partyController.partyOwner > -1)
            {
                this.game.chatF.pushMsg("server", "Your party has been disbanded", "SERVER", "", 0);
            };
            this.game.world.partyController.partyOwner = -1;
            this.game.world.partyController.partyOwner = "";
            this.game.world.partyController.partyMembers = [];
            this.game.world.partyController.updatePartyFrame();
            this.game.chatF.chn.party.act = 0;
            if (this.game.chatF.chn.cur == this.game.chatF.chn.party)
            {
                this.game.chatF.chn.cur = this.game.chatF.chn.zone;
            };
            if (this.game.chatF.chn.lastPublic == this.game.chatF.chn.party)
            {
                this.game.chatF.chn.lastPublic = this.game.chatF.chn.zone;
            };
        }

        private function PVPQ(data:Object):void
        {
            this.game.world.handlePVPQueue(data);
        }

        private function PVPI(data:Object):void
        {
            this.game.world.receivePVPInvite(data);
        }

        private function PVPE(data:Object):void
        {
            this.game.relayPVPEvent(data);
        }

        private function PVPS(data:Object):void
        {
            this.game.updatePVPScore(data.pvpScore);
        }

        private function PVPC(data:Object):void
        {
            this.game.world.PVPResults.pvpScore = data.pvpScore;
            this.game.world.PVPResults.team = data.team;
            this.game.updatePVPScore(data.pvpScore);
            this.game.togglePVPPanel("results");
        }

        private function pvpbreakdown():void
        {
        }

        private function psri(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (data.message + ". Do you accept?");
            modalO.callback = this.game.world.doPsrAccept;
            modalO.params = {"unm":data.host};
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (data.message + "."), "SERVER", "", 0);
        }

        private function di(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (((((((data.owner + " has challenged you to a duel with a bet of ") + data.coins) + " ") + Config.getString("coins_name_short")) + " at ") + data.map) + ". Do you accept?");
            modalO.callback = this.game.world.doDuelAccept;
            modalO.params = {"unm":data.owner};
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (((((((data.owner + " has challenged you to a with a bet of ") + data.coins) + " ") + Config.getString("coins_name_short")) + " at ") + data.map) + "."), "SERVER", "", 0);
        }

        private function guildWarInvite(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (data.owner + " has challenged you to a guild war. Do you accept?");
            modalO.callback = this.game.world.doGuildWarInvite;
            modalO.params = {"unm":data.owner};
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (data.owner + " has challenged you to a guild war."), "SERVER", "", 0);
        }

        private function adi(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (data.owner + " has asked you to be their child. Do you accept?");
            modalO.callback = this.game.world.doAdoptAccept;
            modalO.params = {"unm":data.owner};
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (data.owner + " has asked you to be their child."), "SERVER", "", 0);
        }

        private function mi(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (data.owner + " has proposed you to marry. Do you accept?");
            modalO.callback = this.game.world.doMarryAccept;
            modalO.params = {"unm":data.owner};
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (data.owner + " has proposed you to marry."), "SERVER", "", 0);
        }

        private function DuelEX():void
        {
            this.game.world.duelExpire();
        }

        private function loadFactions(data:Object):void
        {
            this.game.world.myAvatar.initFactions(data.factions);
        }

        private function addFaction(data:Object):void
        {
            this.game.world.myAvatar.addFaction(data.faction);
        }

        private function loadFriendsList(data:Object):void
        {
            this.game.world.myAvatar.initFriendsList(data.friends);
        }

        private function requestFriend(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (data.unm + " has invited you to be friends. Do you accept?");
            modalO.callback = this.game.world.addFriend;
            modalO.params = {
                "ID":data.ID,
                "unm":data.unm
            };
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (data.unm + " has invited you to be friends."), "SERVER", "", 0);
        }

        private function addFriend(data:Object):void
        {
            this.game.world.myAvatar.addFriend(data.friend);
        }

        private function updateFriend(data:Object):void
        {
            this.game.world.myAvatar.updateFriend(data.friend);
        }

        private function deleteFriend(data:Object):void
        {
            this.game.world.myAvatar.deleteFriend(data.ID);
        }

        private function serverRate(data:Object):void
        {
            this.game.world.rate = data;
            if (((this.game.ui.mcPopup.currentLabel == "OptionPanel") && (this.game.ui.mcPopup.mcOptionPanel.currentLabel == "Server")))
            {
                this.game.ui.mcPopup.mcOptionPanel.txtReputation.text = this.game.world.rate.rateReputation;
                this.game.ui.mcPopup.mcOptionPanel.txtExperience.text = this.game.world.rate.rateExperience;
                this.game.ui.mcPopup.mcOptionPanel.txtClassPoints.text = this.game.world.rate.rateClassPoints;
                this.game.ui.mcPopup.mcOptionPanel.txtDrop.text = this.game.world.rate.rateDrop;
                this.game.ui.mcPopup.mcOptionPanel.txtCoins.text = this.game.world.rate.rateCoins;
            };
        }

        private function isModerator(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.btns = "mono";
            if (data.val)
            {
                modalO.strBody = (data.unm + " is staff!");
                modalO.glow = "gold,medium";
                this.game.chatF.pushMsg("server", (data.unm + " is staff!"), "SERVER", "", 0);
            }
            else
            {
                modalO.strBody = (data.unm + " is NOT staff!");
                modalO.glow = "red,medium";
                this.game.chatF.pushMsg("warning", (data.unm + " is NOT staff!"), "SERVER", "", 0);
            };
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        private function loadWarVars(data:Object):void
        {
            var name:*;
            var layout:*;
            var hasObject:Boolean;
            var object:Object;
            var i:int;
            while (i < data.wars.length)
            {
                name = ("war_" + data.wars[i].warId);
                layout = this.game.ui.mapsTrash.getChildByName(name);
                hasObject = false;
                for each (object in this.game.world.objectmap)
                {
                    if (object.name == name)
                    {
                        hasObject = true;
                        break;
                    };
                };
                if (!hasObject)
                {
                    layout = this.game.ui.mapsTrash.addChild(new WarPanel(data.wars[i]));
                    layout.name = ("war_" + data.wars[i].warId);
                    layout.x = 580;
                    layout.y = ((i * layout.height) + 5);
                };
                if (layout != null)
                {
                    layout.update(data.wars[i]);
                };
                i++;
            };
        }

        private function setAchievement(data:Object):void
        {
            this.game.world.updateAchievement(data.field, data.index, data.value);
        }

        private function loadQuestStringData(data:Object):void
        {
            this.game.world.objQuestString = data.obj;
            this.game.world.dispatchEvent(new Event("QuestStringData_Complete"));
        }

        private function getAdData(data:Object):void
        {
            if (data.bSuccess == 1)
            {
                this.game.world.adData = data.bh;
                this.game.world.dispatchEvent(new Event("getAdData"));
            };
        }

        private function getAdReward(data:Object):void
        {
            this.game.world.myAvatar.objData.iDailyAds = (this.game.world.myAvatar.objData.iDailyAds + 1);
            this.game.world.adData = null;
            if (this.game.world.myAvatar.objData.iDailyAds < this.game.world.myAvatar.objData.iDailyAdCap)
            {
                this.game.world.sendGetAdDataRequest();
            };
            this.game.world.myAvatar.objData.intGold = (this.game.world.myAvatar.objData.intGold + int(data.iGold));
            this.game.ui.mcInterface.mcGold.strGold.text = this.game.world.myAvatar.objData.intGold;
            if (this.game.ui.mcPopup.currentLabel == "Inventory")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
            };
            this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins + int(data.iCoins));
            var sMsg:* = (("Congratulations! You just received <font color='#FFCC00'><b>" + data.iGold) + " Gold</b></font>");
            if (data.iCoins > 0)
            {
                sMsg = (sMsg + ((((" and <font color='#990099'><b>" + data.iCoins) + " ") + Config.getString("coins_name")) + "</b></font>"));
            };
            sMsg = (sMsg + " from Ballyhoo.");
            this.game.showMessageBox(sMsg);
        }

        private function gettimes(data:Object):void
        {
            var i:int;
            var a:Array = [];
            for (this.s in data.o)
            {
                this.o = data.o[this.s];
                this.o.s = this.s;
                a.push(this.o);
            };
            a.sortOn("t", (Array.NUMERIC | Array.DESCENDING));
            i = 0;
            while (i < a.length)
            {
                this.o = a[i];
                i++;
            };
        }

        private function clockTick(data:Object):void
        {
            if (("eventTrigger" in MovieClip(this.game.world.map)))
            {
                this.game.world.map.eventTrigger(data);
            };
        }

        private function castWait(data:Object):void
        {
            try
            {
                this.game.world.map.fishGame.castingWait(data.wait, data.derp);
            }
            catch(e:Error)
            {
                trace(e);
            };
        }

        private function alchOnStart(data:Object):void
        {
            this.game.world.map.alchemyGame.onStart(data);
        }

        private function alchComplete(data:Object):void
        {
            this.game.world.map.alchemyGame.checkComplete(data);
        }

        private function bookInfo(data:Object):void
        {
            this.game.mcConnDetail.hideConn();
            this.game.world.bookData = data.bookData;
        }

        private function loadCookBook(data:Object):void
        {
            this.game.mcConnDetail.hideConn();
            this.game.world.cookData = data;
            this.game.mcCooking.distributeList(this.game.world.cookData);
        }

        private function cookResult(data:Object):void
        {
            this.game.world.myAvatar.addItemFood(data.Food);
            this.game.world.myAvatar.removeIngredients(data.Food);
            this.game.mcCooking.distributeList(this.game.world.cookData);
            this.game.mcCooking.cookResult(data);
        }

        private function consumeFood(data:Object):void
        {
            this.game.world.myAvatar.removeFood(data.Food);
            this.game.mcCooking.distributeList(this.game.world.cookData);
        }

        private function queueUpdate(data:Object):void
        {
            this.game.ui.mcPVPQueue.t2label.visible = true;
            this.game.ui.mcPVPQueue.t2.visible = true;
            this.game.ui.mcPVPQueue.t2.text = ((data.current + "/") + data.max);
            this.game.chatF.pushMsg("warning", data.message, "SERVER", "", 0);
        }

        private function updatePartner(data:Object):void
        {
            var avt:Avatar = this.game.world.getAvatarByUserName(data.unm);
            if (avt != null)
            {
                avt.objData.partner = ((data.bDivorce) ? null : data.Partner);
                if (((avt.isMyAvatar) && (!(data.Message == null))))
                {
                    this.game.chatF.pushMsg("server", data.Message, "SERVER", "", 0);
                    if (this.game.ui.mcPopup.currentLabel == "CouplePanel")
                    {
                        this.game.ui.mcPopup.CouplePanelMC.fClose();
                    };
                };
                if (data.Partner.ChildName != null)
                {
                    if (avt.objData.strUsername.toLowerCase() == data.Partner.ChildName.toLowerCase())
                    {
                        avt.dataLeaf.isAdopted = (data.bAdoptRevert == null);
                        avt.pMC.scale(this.game.world.SCALE);
                    };
                };
                if (((avt.isMyAvatar) && (!(data.intAmount == null))))
                {
                    this.game.world.myAvatar.objData.intCoins = (this.game.world.myAvatar.objData.intCoins - data.intAmount);
                    if (this.game.ui.mcPopup.currentLabel == "Shop")
                    {
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                        MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({
                            "eventType":"refreshItems",
                            "sInstruction":"closeWindows"
                        });
                    }
                    else
                    {
                        if (this.game.ui.mcPopup.currentLabel == "Inventory")
                        {
                            MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                            MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({
                                "eventType":"refreshItems",
                                "sInstruction":"closeWindows"
                            });
                        }
                        else
                        {
                            if (this.game.ui.mcPopup.currentLabel == "HouseShop")
                            {
                                MovieClip(this.game.ui.mcPopup.getChildByName("mcHouseShop")).reset();
                            };
                        };
                    };
                };
            };
        }

        private function loadGuildList(data:Object):void
        {
            this.game.ui.mcPopup.mcGuildList.distributeList(data);
        }

        private function titleInfo(data:Object):void
        {
            if (mcPopup_323(Game.root.ui.mcPopup).currentLabel != "Titles")
            {
                mcPopup_323(Game.root.ui.mcPopup).fOpen("Titles", data.titleData);
            };
        }

        private function chatInfo(data:Object):void
        {
            if (mcPopup_323(Game.root.ui.mcPopup).currentLabel != "ChatCustomizationPanel")
            {
                mcPopup_323(Game.root.ui.mcPopup).fOpen("ChatCustomizationPanel", data.chatData);
            };
        }

        private function spellOnStart(data:Object):void
        {
            this.game.world.map.mcGame.spellOnStart(data);
        }

        private function spellComplete(data:Object):void
        {
            this.game.world.map.mcGame.spellComplete(data);
        }

        private function spellWaitTimer(data:Object):void
        {
            this.game.world.map.mcGame.spellWaitTimer(data);
        }

        private function playerDeath(data:Object):void
        {
            if (("eventTrigger" in MovieClip(this.game.world.map)))
            {
                this.game.world.map.eventTrigger(data);
            };
        }

        private function getScrolls(data:Object):void
        {
            try
            {
                this.game.world.scrollData = data.scrolls;
                this.game.world.map.initScrollData();
            }
            catch(e:Error)
            {
                trace(e);
            };
        }

        private function turninscroll(data:Object):void
        {
            var i:int;
            var ii:int;
            if (data.IDs != null)
            {
                i = 0;
                while (i < data.IDs.length)
                {
                    this.game.world.myAvatar.updateScrolls(int(data.IDs[i]));
                    i = (i + 1);
                };
                this.s = "";
                ii = 0;
                while (ii < 500)
                {
                    this.s = (this.s + String.fromCharCode(0));
                    ii = (ii + 1);
                };
                this.game.world.myAvatar.objData.pending = this.s;
                try
                {
                    this.game.world.map.displayTurnins(data.IDs);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
        }

        private function getapop(data:Object):void
        {
            if (data.apopData != null)
            {
                this.game.apopTree[String(data.apopData.apopID)] = data.apopData;
                if (!data.bQuests)
                {
                    this.game.createApop();
                };
            };
        }

        private function startTrade(data:Object):void
        {
            this.game.toggleTradePanel(data.userid, data.username);
            this.game.world.tradeInfo = new TradeInfo();
        }

        private function ti(data:Object):void
        {
            var modalO:Object = {};
            var modal:ModalMC = new ModalMC();
            modalO.strBody = (data.owner + " has requested you to trade. Do you accept?");
            modalO.callback = this.game.world.doTradeAccept;
            modalO.params = {"unm":data.owner};
            modalO.btns = "dual";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            this.game.chatF.pushMsg("server", (data.owner + " has requested you to trade."), "SERVER", "", 0);
        }

        private function loadOffer(data:Object):void
        {
            var modal:ModalMC;
            var modalO:Object;
            if (data.bitSuccess)
            {
                if (((!(data.itemsA == null)) && (!(data.itemsA == undefined))))
                {
                    this.game.world.tradeController.addItemsToTradeA(data.itemsA);
                };
                if (((!(data.itemsB == null)) && (!(data.itemsB == undefined))))
                {
                    this.game.world.tradeController.addItemsToTradeB(data.itemsB);
                };
                if (this.game.ui.mcPopup.currentLabel == "TradePanel")
                {
                    tradeRefresh();
                }
                else
                {
                    this.game.ui.mcPopup.fOpen("TradePanel");
                };
            }
            else
            {
                modal = new ModalMC();
                modalO = {};
                modalO.strBody = "Error loading trade items!  Try logging out and back in to fix this problem.";
                modalO.params = {};
                modalO.glow = "red,medium";
                modalO.btns = "mono";
                this.game.ui.ModalStack.addChild(modal);
                modal.init(modalO);
            };
        }

        private function tradeDeal(data:Object):void
        {
            var trade:LPFLayoutTrade;
            if (data.bitSuccess)
            {
                if (((!(data.onHold == undefined)) && (data.onHold == 1)))
                {
                    this.game.ctrlTrade.btnDeal.alpha = 0.5;
                    this.game.ctrlTrade.btnDeal.mouseEnabled = false;
                }
                else
                {
                    if (this.game.ui.mcPopup.currentLabel == "TradePanel")
                    {
                        trade = LPFLayoutTrade(this.game.ui.mcPopup.getChildByName("mcTrade"));
                        trade.notify = false;
                        trade.fClose();
                    };
                };
                if (data.msg != undefined)
                {
                    MainController.modal(data.msg, null, {}, "green,medium", "mono");
                };
            }
            else
            {
                MainController.modal(data.msg, null, {}, "red,medium", "mono");
            };
        }

        private function tradeCancel(data:Object):void
        {
            if (data.bitSuccess)
            {
                this.game.world.tradeController.tradeToInvReset();
                if (this.game.ui.mcPopup.currentLabel == "TradePanel")
                {
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcTrade")).notify = false;
                    MovieClip(this.game.ui.mcPopup.getChildByName("mcTrade")).fClose();
                };
            };
        }

        private function tradeLock(data:Object):void
        {
            var modal:ModalMC;
            var modalO:Object;
            if (data.bitSuccess)
            {
                this.game.ctrlTrade.txtTargetGold.text = data.gold;
                this.game.ctrlTrade.txtTargetCoins.text = data.coins;
                if ((("Deal" in data) && (data.Deal == 1)))
                {
                    this.game.ctrlTrade.btnDeal.alpha = 1;
                    this.game.ctrlTrade.btnDeal.mouseEnabled = true;
                };
                if ((("Self" in data) && (data.Self == 1)))
                {
                    this.game.ctrlTrade.txtMyGold.mouseEnabled = false;
                    this.game.ctrlTrade.txtMyCoins.mouseEnabled = false;
                    this.game.ctrlTrade.txtLock.text = "Unlock";
                    this.game.tradeItem1.alpha = 0.5;
                }
                else
                {
                    this.game.tradeItem2.alpha = 0.5;
                };
            }
            else
            {
                modal = new ModalMC();
                modalO = {};
                modalO.strBody = data.msg;
                modalO.params = {};
                modalO.glow = "red,medium";
                modalO.btns = "mono";
                this.game.ui.ModalStack.addChild(modal);
                modal.init(modalO);
            };
        }

        private function tradeUnlock(data:Object):void
        {
            if (data.bitSuccess)
            {
                this.game.ctrlTrade.txtLock.text = "Lock";
                this.game.ctrlTrade.btnDeal.alpha = 0.5;
                this.game.ctrlTrade.btnDeal.mouseEnabled = false;
                this.game.ctrlTrade.txtMyGold.mouseEnabled = true;
                this.game.ctrlTrade.txtMyCoins.mouseEnabled = true;
                this.game.tradeItem1.alpha = 1;
                this.game.tradeItem2.alpha = 1;
            };
        }

        private function tradeFromInv(data:Object):void
        {
            var modal:ModalMC;
            var modalO:Object;
            if ((("bSuccess" in data) && (data.bSuccess == 1)))
            {
                this.game.world.tradeController.toTrade(data.ItemID, data.Quantity);
                this.game.world.checkAllQuestStatus();
                if (this.game.ui.mcPopup.currentLabel == "TradePanel")
                {
                    tradeRefresh();
                };
            }
            else
            {
                modal = new ModalMC();
                modalO = {};
                modalO.strBody = data.msg;
                modalO.params = {};
                modalO.glow = "red,medium";
                modalO.btns = "mono";
                this.game.ui.ModalStack.addChild(modal);
                modal.init(modalO);
            };
        }

        private function tradeToInv(data:Object):void
        {
            if (data.Type == 1)
            {
                this.game.world.tradeController.toInventory_A(data.ItemID);
            }
            else
            {
                this.game.world.tradeController.tradeToInvB(data.ItemID);
            };
            this.game.world.checkAllQuestStatus();
            if (this.game.ui.mcPopup.currentLabel == "TradePanel")
            {
                tradeRefresh();
            };
        }

        private function tradeSwapInv(data:Object):void
        {
            this.game.world.tradeController.tradeSwapInv(data.invItemID, data.tradeItemID);
            this.game.world.checkAllQuestStatus();
            if (this.game.ui.mcPopup.currentLabel == "TradePanel")
            {
                tradeRefresh();
            };
        }

        private function updateTitle(data:Object):void
        {
            var avatar:Avatar;
            avatar = this.game.world.getAvatarByUserID(data.uid);
            var avatarMC:AvatarMC = AvatarMC(avatar.pMC);
            avatar.objData.title = data;
            this.game.onRemoveChildrens(avatarMC.pname.title);
            if (data.Name == undefined)
            {
                avatarMC.pname.tl.text = "";
            }
            else
            {
                if (avatar.objData.title.File == "")
                {
                    avatarMC.pname.tl.text = (("[ " + avatar.objData.title.Name) + " ]").toUpperCase();
                    avatarMC.pname.tl.textColor = avatar.objData.title.Color;
                }
                else
                {
                    avatarMC.pname.tl.text = "";
                    avatarMC.loadTitle(avatar.objData.title.File, avatar.objData.title.Link);
                };
            };
            var mcPopup:* = mcPopup_323(Game.root.ui.mcPopup);
            if (mcPopup.currentLabel == "Titles")
            {
                mcPopup.TitleBG.filter(mcPopup.TitleBG.txtSearch.text.toLowerCase(), false);
                mcPopup.TitleBG.txtEquip.text = ((mcPopup.TitleBG.mcTarget.Data.id == data.id) ? "Unequip" : "Equip");
            };
        }

        private function updateChat(data:Object):void
        {
            var avatar:Avatar;
            avatar = this.game.world.getAvatarByUserID(data.uid);
            var avatarMC:AvatarMC = AvatarMC(avatar.pMC);
            avatar.objData.chat = data;
            var mcPopup:* = mcPopup_323(Game.root.ui.mcPopup);
            if (mcPopup.currentLabel == "ChatCustomizationPanel")
            {
                mcPopup.ChatBG.filter(mcPopup.ChatBG.txtSearch.text.toLowerCase(), false);
                mcPopup.ChatBG.txtEquip.text = ((mcPopup.ChatBG.mcTarget.Data.id == data.id) ? "Unequip" : "Equip");
            };
        }

        private function updateGoldCoins(data:Object):void
        {
            var cnDisplay:coinsDisplay;
            if (("coins" in data))
            {
                cnDisplay = new coinsDisplay();
                cnDisplay.t.ti.text = ((data.coins - this.game.world.myAvatar.objData.intCoins) + " c");
                cnDisplay.tMask.ti.text = ((data.coins - this.game.world.myAvatar.objData.intCoins) + " c");
                cnDisplay.x = this.game.world.myAvatar.pMC.mcChar.x;
                cnDisplay.y = (this.game.world.myAvatar.pMC.pname.y - 30);
                if (Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
                {
                    Game.spriteToBitmap(cnDisplay.t);
                };
                this.game.world.myAvatar.pMC.addChild(cnDisplay);
                this.game.world.myAvatar.objData.intCoins = data.coins;
            };
            if (this.game.ui.mcPopup.currentLabel == "Inventory")
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
            };
            if (((this.game.ui.mcPopup.currentLabel == "MergeShop") || (this.game.ui.mcPopup.currentLabel == "Shop")))
            {
                MovieClip(this.game.ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
            };
            this.game.mixer.playSound("Coins");
        }

        private function searchItem(data:Object):void
        {
            if (data.bitSuccess)
            {
                this.game.world.myAvatar.initInventory(data.items);
                inventoryRefresh();
            }
            else
            {
                this.game.MsgBox.notify(data.strMessage);
            };
        }

        private function sendLinkedItems(data:Object):void
        {
            var itemKey:String;
            var item:Object;
            if (data.bitSuccess)
            {
                for (itemKey in data.items)
                {
                    item = this.game.copyObj(data.items[itemKey]);
                    this.game.world.linkTree[item.CharItemID] = this.game.copyObj(item);
                };
                return;
            };
            var modal:ModalMC = new ModalMC();
            var modalO:Object = {};
            modalO.strBody = data.strMessage;
            modalO.params = {};
            modalO.glow = "red,medium";
            modalO.btns = "mono";
            this.game.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        private function sendLinkedEmojis(data:Object):void
        {
            var emojiKey:String;
            var emoji:Object;
            if (data.bitSuccess)
            {
                for (emojiKey in data.emojis)
                {
                    emoji = this.game.copyObj(data.emojis[emojiKey]);
                    this.game.world.emojiTree[emoji.id] = this.game.copyObj(emoji);
                };
                return;
            };
        }

        private function loadWorldBoss(data:Object):void
        {
            var worldBossPanel:WorldBossPanel = WorldBossPanel(UIController.getByName("boss_board"));
            if (worldBossPanel == null)
            {
                return;
            };
            worldBossPanel.distributeList(data.lists);
        }

        private function loadBattlePass(data:Object):void
        {
            var battlePassPanel:BattlePassPanel = BattlePassPanel(UIController.getByName("battle_pass"));
            if (battlePassPanel == null)
            {
                return;
            };
            battlePassPanel.distributeList(data.lists);
        }

        private function updateBattlePass(data:Object):void
        {
            this.game.world.myAvatar.objData.battlePasses = data.battlePasses;
            var battlePassPanel:BattlePassPanel = BattlePassPanel(UIController.getByName("battle_pass"));
            if (battlePassPanel == null)
            {
                return;
            };
            battlePassPanel.update();
        }

        private function loadGuildAttribute(data:Object):void
        {
            if (this.game.ui.mcPopup.currentLabel == "GuildPanel")
            {
                this.game.ui.mcPopup.GuildRewrite.buildTech(data);
            };
        }

        private function worldBossInvite(data:Object):void
        {
            var bossInvite:WorldBossInvite;
            var wbTime:Date = new Date((this.game.ts_login_server + (data.spawnTime - this.game.ts_login_client)));
            var timeOut:Date = new Date((this.game.ts_login_server + ((data.spawnTime + data.timeLimit) - this.game.ts_login_client)));
            bossInvite = WorldBossInvite(UIController.getByNameOrShow("boss_invite"));
            Game.root.onRemoveChildrens(bossInvite.mcHead.head);
            bossInvite.strLevel.text = ("Level " + data.monLevel);
            bossInvite.strName.text = data.monName;
            LoadController.singleton.addLoadJunk(("mon/" + data.monFile), "boss_invite_junk", function (event:Event):void
            {
                bossInvite.mcHead.head.addChildAt(new (LoadController.singleton.applicationDomainJunk.getDefinition(("mcHead" + data.monLink)))(), 0).name = "face";
                bossInvite.mcHead.head.hair.visible = false;
                bossInvite.mcHead.head.helm.visible = false;
                bossInvite.mcHead.backhair.visible = false;
            });
            bossInvite.bossID = data.worldBossId;
            bossInvite.setTimer((timeOut.valueOf() - wbTime.valueOf()));
            Game.root.mixer.playSound("WorldBoss");
        }

        private function loadMenu(data:Object):void
        {
            this.game.gameMenu.mcGameMenu.distributeList(data.menu);
        }

        private function rebirthPlayer():void
        {
            this.game.toggleRebirthPanel();
        }

        private function botProcess(data:Object):void
        {
            var mcPopup:mcPopup_323 = mcPopup_323(Game.root.ui.mcPopup);
            if (mcPopup.botPanel != null)
            {
                if (Boolean(data.isBotting))
                {
                    BotController.start();
                    return;
                };
                BotController.stop();
            };
            if (Boolean(data.isEnergyRequired))
            {
                Game.root.mixer.playSound("Bad");
                BotController.useEnergizer(true);
            };
        }

        private function updateEnergy(data:Object):void
        {
            this.game.world.myAvatar.objData.intEnergy = data.intEnergy;
            var mcPopup:mcPopup_323 = mcPopup_323(this.game.ui.mcPopup);
            if (mcPopup.botPanel != null)
            {
                mcPopup.botPanel.onUpdateEnergy();
            };
        }

        private function coreStatUpdate(data:Object):void
        {
            this.game.world.myAvatar.objData.stats = data.stats;
            var mcPopup:mcPopup_323 = mcPopup_323(this.game.ui.mcPopup);
            if (mcPopup.CoreStatPanelMC != null)
            {
                mcPopup.CoreStatPanelMC.buildStat();
                mcPopup.CoreStatPanelMC.animateCharacter();
            };
            MainController.modal("Congratulations! You have successfully updated your stats!", null, {}, "green,medium", "mono");
        }

        private function unpackEmoji(data:Object):void
        {
            var emoji:Object;
            for each (emoji in data.emojis)
            {
                this.game.world.myAvatar.emojis.push(emoji);
            };
        }

        private function serverTime(data:Object):void
        {
            var dateTime:Array;
            var date:String;
            var time:String;
            var dateParts:Array;
            var timeParts:Array;
            var transform:ColorTransform;
            var serverDate:Date;
            var clientTimestamp:Number;
            var latency:Number;
            var serverDiff:Number;
            var clientDiff:Number;
            var hoursAndMinutes:String;
            var fullTime:String;
            dateTime = data.date.split(" ");
            date = dateTime[0];
            time = dateTime[1];
            var abbreviation:String = dateTime[2];
            dateParts = date.split("-");
            var year:int = int(dateParts[0]);
            var month:int = (int(dateParts[1]) - 1);
            var day:int = int(dateParts[2]);
            timeParts = time.split(":");
            var hours:int = int(timeParts[0]);
            var minutes:int = int(timeParts[1]);
            var seconds:int = int(timeParts[2]);
            if (this.game.ui.mcPing.visible)
            {
                if (((abbreviation == "PM") && (hours < 12)))
                {
                    hours = (hours + 12);
                }
                else
                {
                    if (((abbreviation == "AM") && (hours == 12)))
                    {
                        hours = 0;
                    };
                };
                transform = new ColorTransform();
                serverDate = new Date(year, month, day, hours, minutes, seconds);
                if (isNaN(serverDate.getTime()))
                {
                    trace("Error: Unable to parse server date/time.");
                    return;
                };
                clientTimestamp = new Date().getTime();
                latency = 0;
                if (((!(isNaN(this.pst))) && (!(isNaN(this.pct)))))
                {
                    serverDiff = (serverDate.getTime() - this.pst);
                    clientDiff = (clientTimestamp - this.pct);
                    latency = Math.round(Math.abs((clientDiff - serverDiff)));
                };
                this.pst = serverDate.getTime();
                this.pct = clientTimestamp;
                if (latency < 100)
                {
                    transform.color = 0xFF00;
                }
                else
                {
                    if (latency < 500)
                    {
                        transform.color = 0xFFFF00;
                    }
                    else
                    {
                        transform.color = 0xFF0000;
                    };
                };
                this.game.ui.mcPing.display.strPing.text = (latency + " ms");
                this.game.ui.mcPing.display.latencyStatus.transform.colorTransform = transform;
            };
            if (this.game.ui.mcTime.visible)
            {
                hoursAndMinutes = ((timeParts[0] + ":") + timeParts[1]);
                fullTime = ((this.game.userPreference.data.showServerTimeSeconds) ? time : hoursAndMinutes);
                this.game.ui.mcTime.strTime.text = ((fullTime + " ") + abbreviation);
                if (((this.game.ui.mcPopup.currentLabel == "OptionPanel") && (this.game.ui.mcPopup.mcOptionPanel.currentLabel == "Server")))
                {
                    this.game.ui.mcPopup.mcOptionPanel.txtServerTime.text = ((time + " ") + abbreviation);
                };
            };
        }

        private function loadPrefs(data:Object):void
        {
            Game.root.world.objInfo["customs"] = data.result;
        }

        private function addLoadout(data:Object):void
        {
            if (!data.success)
            {
                Game.root.MsgBox.notify(data.msg);
                return;
            };
            OutfitPanel(UIController.getByNameOrShow("outfit")).onServerResponseUpdate();
        }

        private function removeLoadout(data:Object):void
        {
            if (!data.success)
            {
                Game.root.MsgBox.notify(data.msg);
                return;
            };
            OutfitPanel(UIController.getByNameOrShow("outfit")).onServerResponseRemove(data.setName);
        }

        private function buyLoadoutSlots(data:Object):void
        {
            Game.root.mixer.playSound("Heal");
            Game.root.world.myAvatar.objData.iLoadoutSlots = (Game.root.world.myAvatar.objData.iLoadoutSlots + Number(data.iSlots));
            Game.root.world.myAvatar.objData.intCoins = (Game.root.world.myAvatar.objData.intCoins - (Number(data.iSlots) * Config.getInt("slot_outfit_cost")));
            Game.root.world.dispatchEvent(new Event("buyLoadoutSlots"));
            var outfitPanel:OutfitPanel = OutfitPanel(UIController.getByNameOrShow("outfit"));
            outfitPanel.unlockinterface.visible = false;
            outfitPanel.interfaceOutfitSets.drawMenu();
        }


    }
}//package Main

