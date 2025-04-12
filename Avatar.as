// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Avatar

package 
{
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import flash.system.ApplicationDomain;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.display.*;
    import Main.Controller.*;
    import Main.*;

    public class Avatar 
    {

        public var rootClass:Game;
        public var uid:int;
        public var pMC:MovieClip;
        public var pnm:String;
        public var objData:Object = null;
        public var dataLeaf:Object = {};
        public var guild:Object = {};
        public var npcType:String = "player";
        public var target:Avatar = null;
        public var targets:Object = {};
        public var isMyAvatar:Boolean = false;
        public var friends:Array = [];
        public var classes:Array;
        public var factions:Array = [];
        public var emojis:Array = [];
        public var bank:Vector.<Item> = new Vector.<Item>();
        public var items:Vector.<Item> = new Vector.<Item>();
        public var houseitems:Vector.<Item> = new Vector.<Item>();
        public var tempitems:Vector.<Item> = new Vector.<Item>();
        public var bitData:Boolean = false;
        public var strFrame:String = "";
        public var friendsLoaded:Boolean = false;
        public var invLoaded:Boolean = false;
        private var loadCount:int = 0;
        private var firstLoad:Boolean = true;
        private var specialAnimation:Object = {};
        public var filtered_list:Vector.<Item>;
        private var _petMC:PetMC;
        public var LOADER_KEY_PREFIX:String = "preview_";

        public function Avatar(game:Game)
        {
            this.rootClass = game;
        }

        private static function isItemStackMaxedCheck(itemID:int, items:Vector.<Item>):Boolean
        {
            var item:Item;
            for each (item in items)
            {
                if (((item.ItemID == itemID) && (item.iQty >= item.iStk)))
                {
                    return (true);
                };
            };
            return (false);
        }


        public function get petMC():PetMC
        {
            return (this._petMC);
        }

        public function set petMC(value:PetMC):void
        {
            this._petMC = value;
        }

        public function get haste():Number
        {
            return (1 - Math.min(Math.max(this.dataLeaf.sta.$tha, -1), 0.85));
        }

        public function get FirstLoad():Boolean
        {
            return (this.firstLoad);
        }

        public function get LoadCount():int
        {
            return (this.loadCount);
        }

        public function get applicationDomain():ApplicationDomain
        {
            return ((this.npcType == "player") ? LoadController.singleton.applicationDomainAvatar : LoadController.singleton.applicationDomainMap);
        }

        public function get addLoad():Function
        {
            return ((this.npcType == "player") ? LoadController.singleton.addLoadAvatar : LoadController.singleton.addLoadMap);
        }

        public function initAvatar(data:Object):void
        {
            var equipmentKey:String;
            var equipment:Object;
            this.objData = data.data;
            var avatarMC:AvatarMC = AvatarMC(this.pMC);
            this.LOADER_KEY_PREFIX = (((this.npcType + "_") + String(this.objData.strUsername)) + "_");
            if (this.objData.intCoins != undefined)
            {
                this.objData.intCoins = Number(this.objData.intCoins);
            };
            if (this.objData.dUpgExp != undefined)
            {
                this.objData.dUpgExp = this.rootClass.stringToDate(this.objData.dUpgExp);
            };
            if (this.objData.dMutedTill != undefined)
            {
                this.objData.dMutedTill = this.rootClass.stringToDate(this.objData.dMutedTill);
            };
            if (this.objData.dCreated != undefined)
            {
                this.objData.dCreated = this.rootClass.stringToDate(this.objData.dCreated);
            };
            avatarMC.strGender = this.objData.strGender;
            this.updateRep();
            if (this.objData.title != null)
            {
                if (this.objData.title.File != "")
                {
                    this.loadCount++;
                    avatarMC.loadTitle(this.objData.title.File, this.objData.title.Link);
                };
                avatarMC.setTitleVisibility(this.dataLeaf.showTitle);
            };
            avatarMC.updateName();
            avatarMC.ignore.visible = this.rootClass.chatF.isIgnored(data.data.strUsername);
            if (this.objData.eqp != null)
            {
                for (equipmentKey in this.objData.eqp)
                {
                    this.loadCount++;
                    equipment = this.objData.eqp[equipmentKey];
                    this.loadMovieAtES(equipmentKey, equipment.sFile, equipment.sLink);
                };
            };
            avatarMC.loadHair();
            this.bitData = true;
            if (this.isMyAvatar)
            {
                this.rootClass.world.updateNpcs();
            };
        }

        public function loadMovieAtES(es:String, file:String, link:String):void
        {
            var avatarMC:AvatarMC;
            if (es != null)
            {
                avatarMC = AvatarMC(this.pMC);
                switch (es)
                {
                    case "Weapon":
                        avatarMC.loadWeapon(file);
                        return;
                    case "he":
                        avatarMC.loadHelm(file);
                        return;
                    case "ba":
                        avatarMC.loadCape(file);
                        return;
                    case "ar":
                        avatarMC.loadClass(file);
                        return;
                    case "co":
                        avatarMC.loadArmor(file, link);
                        return;
                    case "pe":
                        avatarMC.loadPet();
                        return;
                    case "mi":
                        avatarMC.loadMisc(file);
                        return;
                    case "en":
                        avatarMC.loadEntity(file, link);
                        return;
                    case "title":
                        avatarMC.loadTitle(file, link);
                        return;
                };
            };
        }

        public function unloadMovieAtES(es:String):void
        {
            var avatarMC:AvatarMC;
            if (es != null)
            {
                avatarMC = AvatarMC(this.pMC);
                switch (es)
                {
                    case "he":
                        avatarMC.mcChar.head.helm.visible = false;
                        avatarMC.mcChar.head.hair.visible = true;
                        avatarMC.mcChar.backhair.visible = avatarMC.bBackHair;
                        if (this == this.rootClass.world.myAvatar)
                        {
                            this.rootClass.showPortrait(this);
                        };
                        if (this == this.rootClass.world.myAvatar.target)
                        {
                            this.rootClass.showPortraitTarget(this);
                        };
                        break;
                    case "ba":
                        avatarMC.mcChar.cape.visible = false;
                        break;
                    case "pe":
                        avatarMC.unloadPet();
                        break;
                    case "co":
                        avatarMC.loadClass(this.objData.eqp.ar.sFile);
                        break;
                    case "mi":
                        Game.root.onRemoveChildrens(this.pMC.cShadow);
                        this.pMC.cShadow.visible = false;
                        this.pMC.shadow.visible = true;
                        break;
                    case "en":
                        if (avatarMC.entityMC != null)
                        {
                            avatarMC.removeChild(avatarMC.entityMC);
                            avatarMC.mcChar.visible = true;
                            avatarMC.entityMC = null;
                        };
                        avatarMC.scale(this.rootClass.world.SCALE);
                        if (this == this.rootClass.world.myAvatar)
                        {
                            this.rootClass.showPortrait(this);
                        };
                        if (this == this.rootClass.world.myAvatar.target)
                        {
                            this.rootClass.showPortraitTarget(this);
                        };
                        break;
                };
            };
        }

        public function showMC():void
        {
            if (this.pMC != null)
            {
                if (this.rootClass.world.TRASH.contains(this.pMC))
                {
                    this.rootClass.world.CHARS.addChild(this.rootClass.world.TRASH.removeChild(this.pMC));
                }
                else
                {
                    this.rootClass.world.CHARS.addChild(this.pMC);
                };
                this.showPetMC();
            };
        }

        public function hideMC():void
        {
            if (this.pMC != null)
            {
                if (this.rootClass.world.CHARS.contains(this.pMC))
                {
                    this.rootClass.world.TRASH.addChild(this.rootClass.world.CHARS.removeChild(this.pMC));
                }
                else
                {
                    this.rootClass.world.TRASH.addChild(this.pMC);
                };
                this.hidePetMC();
            };
        }

        public function showPetMC():void
        {
            if (this._petMC == null)
            {
                AvatarMC(this.pMC).loadPet();
            }
            else
            {
                if (((this._petMC.stage == null) && (this._petMC.getChildByName("defaultmc") == null)))
                {
                    this.rootClass.world.CHARS.addChild(this._petMC);
                    this._petMC.scale(this.pMC.mcChar.scaleY);
                    this._petMC.x = (this.pMC.x - 20);
                    this._petMC.y = (this.pMC.y + 5);
                };
            };
        }

        public function hidePetMC():void
        {
            if (((!(this._petMC == null)) && (!(this._petMC.stage == null))))
            {
                this.rootClass.world.CHARS.removeChild(this._petMC);
            };
        }

        public function initFactions(factions:Array):void
        {
            if (factions == null)
            {
                this.factions = [];
                return;
            };
            this.factions = factions;
            var i:int;
            while (i < this.factions.length)
            {
                this.initFaction(this.factions[i]);
                i++;
            };
        }

        public function initEmojis(emojis:Array):void
        {
            if (emojis == null)
            {
                this.emojis = [];
                return;
            };
            this.emojis = emojis;
        }

        public function addFaction(faction:Object):void
        {
            if (((!(faction == null)) && (!(this.factions == null))))
            {
                this.factions.push(faction);
                this.initFaction(faction);
            };
        }

        public function addRep(factionID:int, reputation:int, bonus:int=0):void
        {
            var rank:int;
            var faction:Object = this.getFaction(factionID);
            if (faction != null)
            {
                rank = faction.iRank;
                faction.iRep = (faction.iRep + reputation);
                this.initFaction(faction);
                if (faction.iRank > rank)
                {
                    this.rankUp(faction.sName, faction.iRank);
                };
                this.rootClass.chatF.pushMsg("server", ((((("Reputation for " + faction.sName) + " increased by ") + (reputation - bonus)) + ((bonus > 0) ? ((" + " + bonus) + "(Bonus)") : "")) + "."), "SERVER", "", 0);
            };
        }

        public function initFaction(faction:Object):void
        {
            faction.iRank = Rank.getRankFromPoints(faction.iRep);
            faction.iRepToRank = ((faction.iRank < 10) ? (Rank.getPointsFromRank((faction.iRank + 1)) - faction.iRep) : 0);
        }

        public function getRep(_arg1:Object):int
        {
            var _local2:* = this.getFaction(_arg1);
            return ((_local2 == null) ? 0 : _local2.iRep);
        }

        public function getFaction(faction:Object):Object
        {
            return ((isNaN(Number(faction))) ? this.getFactionByName(String(faction)) : this.getFactionByID(int(faction)));
        }

        public function initFriendsList(friends:Array):void
        {
            if (friends != null)
            {
                this.friends = friends;
            };
        }

        public function addFriend(friend:Object):void
        {
            if (friend != null)
            {
                this.friends.push(friend);
                if (this.rootClass.ui.mcOFrame.currentLabel == "Idle")
                {
                    this.rootClass.ui.mcOFrame.update();
                };
            };
        }

        public function updateFriend(friend:Object):void
        {
            var i:int;
            if (friend != null)
            {
                i = 0;
                while (i < this.friends.length)
                {
                    if (this.friends[i].ID == friend.ID)
                    {
                        this.friends[i] = friend;
                        break;
                    };
                    i++;
                };
                if (this.rootClass.ui.mcOFrame.currentLabel == "Idle")
                {
                    this.rootClass.ui.mcOFrame.update();
                };
            };
        }

        public function deleteFriend(id:int):void
        {
            var i:int;
            while (i < this.friends.length)
            {
                if (this.friends[i].ID == id)
                {
                    this.friends.splice(i, 1);
                    break;
                };
                i++;
            };
            if (this.rootClass.ui.mcOFrame.currentLabel == "Idle")
            {
                this.rootClass.ui.mcOFrame.update();
            };
        }

        public function isFriend(_arg1:int):Boolean
        {
            var i:int;
            while (i < this.friends.length)
            {
                if (this.friends[i].ID == _arg1)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function isMarry():Boolean
        {
            return (!(this.objData.PartnerId == 0));
        }

        public function isFriendName(username:String):Boolean
        {
            var i:int;
            while (i < this.friends.length)
            {
                if (this.friends[i].sName.toLowerCase() == username.toLowerCase())
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function initGuild(guildObj:Object):void
        {
            this.guild = guildObj;
            if (guildObj != null)
            {
                this.pMC.pname.tg.text = (("< " + String(guildObj.Name.toUpperCase())) + " >");
                this.pMC.pname.tg.textColor = guildObj.Color;
                this.rootClass.chatF.chn.guild.act = 1;
                this.objData.guild = guildObj;
            };
        }

        public function updateParty(partyObj:Object):void
        {
            this.objData.party = partyObj;
            if (((this.pMC.isLoaded) && (!(this.objData.party == null))))
            {
                this.rootClass.world.partyController.loadParty(this.objData.party);
            };
        }

        public function updateGuild(data:Object):void
        {
            var alliance:Object;
            this.objData.guild = data;
            if (this.objData.guild == null)
            {
                this.pMC.pname.tg.text = "";
                return;
            };
            this.pMC.pname.tg.text = (("< " + String(this.objData.guild.Name.toUpperCase())) + " >").toUpperCase();
            this.pMC.pname.tg.textColor = this.objData.guild.Color;
            if (((this.isMyAvatar) && (!(this.objData.guild.alliances == null))))
            {
                for each (alliance in this.objData.guild.alliances)
                {
                    this.rootClass.chatF.addToCannedChat({
                        "parent":"Alliance",
                        "id":"Alliance Chat",
                        "display":alliance.Alliance.Name,
                        "text":["alliance", alliance.Alliance.Name]
                    }, this.rootClass.chatF.getJsonCannedChatMenu());
                };
            };
        }

        public function initInventory(itemsArr:Array):void
        {
            var itemObj:Object;
            var slots:*;
            var item:*;
            if (itemsArr != null)
            {
                for each (itemObj in itemsArr)
                {
                    this.addItem(new Item(itemObj));
                    slots = ["Weapon", "he", "ba", "co"];
                    for each (slot in slots)
                    {
                        if (this.objData.eqp[slot] == null)
                        {
                            item = this.getWearAtES(slot);
                            if (item != null)
                            {
                                this.objData.eqp[slot] = {};
                                this.objData.eqp[slot].sFile = item.sFile;
                                this.objData.eqp[slot].sLink = item.sLink;
                                this.objData.eqp[slot].sType = item.sType;
                                this.loadMovieAtES(slot, item.sFile, item.sLink);
                            };
                        };
                    };
                };
            };
        }

        public function initInventoryTemporary(itemsArr:Array):void
        {
            var itemObj:Object;
            if (itemsArr != null)
            {
                for each (itemObj in itemsArr)
                {
                    this.addItemTemporary(new Item(itemObj));
                    this.rootClass.world.updateQuestProgress("item", itemObj);
                };
            };
        }

        public function addItem(itemObj:Object):void
        {
            var bankItem:Item;
            var houseItem:Item;
            var item2:Item;
            var item:Item = ((itemObj is Item) ? Item(itemObj) : new Item(itemObj));
            if (item.bBank)
            {
                if (this.bank.length == 0)
                {
                    return;
                };
                for each (bankItem in this.bank)
                {
                    if (bankItem.ItemID == item.ItemID)
                    {
                        bankItem.iQty = (bankItem.iQty + item.iQty);
                        return;
                    };
                };
                return;
            };
            if (item.bHouse)
            {
                for each (houseItem in this.houseitems)
                {
                    if (houseItem.ItemID == item.ItemID)
                    {
                        houseItem.iQty = (houseItem.iQty + item.iQty);
                        return;
                    };
                };
                this.houseitems.push(item);
            }
            else
            {
                for each (item2 in this.items)
                {
                    if (item2.ItemID == item.ItemID)
                    {
                        item2.iQty = (item2.iQty + item.iQty);
                        return;
                    };
                };
                this.items.push(item);
            };
            this.rootClass.world.invTree[item.ItemID] = item;
        }

        public function addItemTemporary(item:Item):void
        {
            var item2:Item;
            for each (item2 in this.tempitems)
            {
                if (item2.ItemID == item.ItemID)
                {
                    item2.iQty = (item2.iQty + item.iQty);
                    return;
                };
            };
            this.tempitems.push(item);
            this.rootClass.world.invTree[item.ItemID] = item;
        }

        public function removeItem(charItemID:int, quantity:int=1):void
        {
            var item:Item;
            var item2:Item;
            var i:int;
            for each (item in this.items)
            {
                if (item.CharItemID == charItemID)
                {
                    if (((item.sES == "ar") || ((item.iQty - quantity) < 1)))
                    {
                        item.iQty = 0;
                        this.rootClass.resetInvTreeByItemID(item.ItemID);
                        this.items.removeAt(i);
                        Game.root.world.myAvatar.removeFromFiltered(item.ItemID);
                    }
                    else
                    {
                        this.items[i].iQty = (this.items[i].iQty - quantity);
                    };
                    return;
                };
                i++;
            };
            i = 0;
            for each (item2 in this.houseitems)
            {
                if (item2.CharItemID == charItemID)
                {
                    if (item2.iQty > 1)
                    {
                        this.houseitems[i].iQty--;
                    }
                    else
                    {
                        this.houseitems.removeAt(i);
                        Game.root.world.myAvatar.removeFromFiltered(item2.ItemID);
                    };
                    return;
                };
                i++;
            };
        }

        public function removeItemByID(itemID:int, quantity:int=1):void
        {
            var item:Item;
            var i:int;
            while (i < this.items.length)
            {
                item = this.items[i];
                if (item.ItemID == itemID)
                {
                    if ((((item.sES == "ar") && (!(item.sType.toLowerCase() == "enhancement"))) || (item.iQty <= quantity)))
                    {
                        item.iQty = 0;
                        this.items.removeAt(i);
                        Game.root.world.myAvatar.removeFromFiltered(itemID);
                    }
                    else
                    {
                        item.iQty = (item.iQty - quantity);
                    };
                    return;
                };
                i++;
            };
        }

        public function removeItemTemporary(itemID:int, quantity:int):void
        {
            var i:int;
            while (i < this.tempitems.length)
            {
                if (this.tempitems[i].ItemID == itemID)
                {
                    if (((this.tempitems[i].sES == "ar") || (this.tempitems[i].iQty <= quantity)))
                    {
                        this.tempitems[i].iQty = 0;
                        this.tempitems.removeAt(i);
                        Game.root.world.myAvatar.removeFromFiltered(itemID);
                    }
                    else
                    {
                        this.tempitems[i].iQty = (this.tempitems[i].iQty - quantity);
                    };
                    return;
                };
                i++;
            };
        }

        public function getItemByID(itemId:int):Item
        {
            var temp:Item;
            var item:Item;
            var house:Item;
            for each (temp in this.tempitems)
            {
                if (temp.ItemID == itemId)
                {
                    return (temp);
                };
            };
            for each (item in this.items)
            {
                if (item.ItemID == itemId)
                {
                    return (item);
                };
            };
            for each (house in this.houseitems)
            {
                if (house.ItemID == itemId)
                {
                    return (house);
                };
            };
            return (null);
        }

        public function getItemIDByName(_arg1:String):int
        {
            var _local2:int;
            var _local3:int;
            var _local4:int;
            while (_local2 < this.items.length)
            {
                if (this.items[_local2].sName == _arg1)
                {
                    return (this.items[_local2].ItemID);
                };
                _local2++;
            };
            while (_local3 < this.houseitems.length)
            {
                if (this.houseitems[_local3].sName == _arg1)
                {
                    return (this.houseitems[_local3].ItemID);
                };
                _local3++;
            };
            while (_local4 < this.tempitems.length)
            {
                if (this.tempitems[_local4].sName == _arg1)
                {
                    return (this.tempitems[_local4].ItemID);
                };
                _local4++;
            };
            return (-1);
        }

        public function isItemInBank(_arg1:Number):Boolean
        {
            var _local2:int;
            if (this.bank != null)
            {
                _local2 = 0;
                while (_local2 < this.bank.length)
                {
                    if (this.bank[_local2].ItemID == _arg1)
                    {
                        return (true);
                    };
                    _local2++;
                };
            };
            return (false);
        }

        public function isItemInInventory(_arg1:*):Boolean
        {
            var _local3:int;
            var _local4:int;
            var _local2:int = ((isNaN(Number(_arg1))) ? this.getItemIDByName(String(_arg1)) : int(_arg1));
            if (_local2 > 0)
            {
                _local3 = 0;
                while (_local3 < this.items.length)
                {
                    if (this.items[_local3].ItemID == _local2)
                    {
                        return (true);
                    };
                    _local3++;
                };
                _local4 = 0;
                while (_local4 < this.houseitems.length)
                {
                    if (this.houseitems[_local4].ItemID == _local2)
                    {
                        return (true);
                    };
                    _local4++;
                };
            };
            return (false);
        }

        public function isItemStackMaxed(itemID:int):Boolean
        {
            return (((isItemStackMaxedCheck(itemID, this.items)) || (isItemStackMaxedCheck(itemID, this.bank))) || (isItemStackMaxedCheck(itemID, this.houseitems)));
        }

        public function checkTempItem(itemID:int, quantity:int):Boolean
        {
            var item:Item;
            for each (item in this.tempitems)
            {
                if (((item.ItemID == itemID) && (item.iQty >= quantity)))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getWearAtES(_arg1:String):Object
        {
            var item:Item;
            for each (item in this.items)
            {
                if (((item.bWear) && (item.sES == _arg1)))
                {
                    return (item);
                };
            };
            return (null);
        }

        public function unwearItemAtES(_arg1:String):void
        {
            var _local2:int;
            while (_local2 < this.items.length)
            {
                if (this.items[_local2].sES == _arg1)
                {
                    this.items[_local2].bWear = false;
                };
                _local2++;
            };
        }

        public function wearItem(_arg1:int):void
        {
            var item:Item;
            this.rootClass.world.afkPostpone();
            if (((!(this.items == null)) && (this.items.length > 0)))
            {
                for each (item in this.items)
                {
                    if (item.ItemID == _arg1)
                    {
                        this.unwearItemAtES(item.sES);
                        item.bWear = true;
                        return;
                    };
                };
            };
        }

        public function unwearItem(_arg1:int):void
        {
            var _local2:int;
            _local2 = 0;
            while (_local2 < this.items.length)
            {
                if (this.items[_local2].ItemID == _arg1)
                {
                    this.items[_local2].bWear = false;
                };
                _local2++;
            };
        }

        public function unequipItemAtES(_arg1:String):void
        {
            var _local2:int;
            _local2 = 0;
            while (_local2 < this.items.length)
            {
                if (this.items[_local2].sES == _arg1)
                {
                    this.items[_local2].bEquip = false;
                };
                _local2++;
            };
            _local2 = 0;
            while (_local2 < this.tempitems.length)
            {
                if (this.tempitems[_local2].sES == _arg1)
                {
                    this.tempitems[_local2].bEquip = false;
                };
                _local2++;
            };
        }

        public function equipItem(_arg1:int):void
        {
            var item:Item;
            var item2:Item;
            this.rootClass.world.afkPostpone();
            if (((!(this.items == null)) && (this.items.length > 0)))
            {
                for each (item in this.items)
                {
                    if (item.ItemID == _arg1)
                    {
                        this.unequipItemAtES(item.sES);
                        item.bEquip = true;
                        return;
                    };
                };
            };
            if (((!(this.tempitems == null)) && (this.tempitems.length > 0)))
            {
                for each (item2 in this.tempitems)
                {
                    if (item2.ItemID == _arg1)
                    {
                        this.unequipItemAtES(item2.sES);
                        item2.bEquip = true;
                        return;
                    };
                };
            };
        }

        public function unequipItem(_arg1:int):void
        {
            var _local2:int;
            if (((!(this.items == null)) && (this.items.length > 0)))
            {
                _local2 = 0;
                while (_local2 < this.items.length)
                {
                    if (this.items[_local2].ItemID == _arg1)
                    {
                        this.items[_local2].bEquip = false;
                        return;
                    };
                    _local2++;
                };
            };
            if (((!(this.tempitems == null)) && (this.tempitems.length > 0)))
            {
                _local2 = 0;
                while (_local2 < this.tempitems.length)
                {
                    if (this.tempitems[_local2].ItemID == _arg1)
                    {
                        this.tempitems[_local2].bEquip = false;
                        return;
                    };
                    _local2++;
                };
            };
        }

        public function isItemEquipped(itemId:int):Boolean
        {
            var item:Object = this.getItemByID(itemId);
            return (!(((item == null) || (item.bEquip == null)) || (item.bEquip == 0)));
        }

        public function getClassArmor(_arg1:String):Object
        {
            var _local2:int;
            while (_local2 < this.items.length)
            {
                if (((this.items[_local2].sName == _arg1) && (this.items[_local2].sES == "ar")))
                {
                    return (this.items[_local2]);
                };
                _local2++;
            };
            return (null);
        }

        public function getEquippedItemBySlot(es:String):Item
        {
            var item:Item;
            for each (item in this.items)
            {
                if (((item.bEquip) && (item.sES == es)))
                {
                    return (item);
                };
            };
            return (null);
        }

        public function getItemByEquipSlot(_arg1:String):Object
        {
            return ((((!(this.objData == null)) && (!(this.objData.eqp == null))) && (!(this.objData.eqp[_arg1] == null))) ? this.objData.eqp[_arg1] : null);
        }

        public function updateArmorRep():void
        {
            var _local1:* = this.getClassArmor(this.objData.strClassName);
            _local1.iQty = Number(this.objData.iCP);
        }

        public function handleItemAnimation():void
        {
            var _local_2:String;
            var _local_3:Class;
            var _local_4:MovieClip;
            var _local_1:Number = (Math.random() * 100);
            for (_local_2 in this.specialAnimation)
            {
                if (_local_1 < this.specialAnimation[_local_2])
                {
                    _local_3 = (this.rootClass.world.getClass(_local_2) as Class);
                    if (_local_3 != null)
                    {
                        _local_4 = (new (_local_3)() as MovieClip);
                        _local_4.x = this.pMC.x;
                        _local_4.y = this.pMC.y;
                        if (this.pMC.mcChar.scaleX < 0)
                        {
                            _local_4.scaleX = (_local_4.scaleX * -1);
                        };
                        this.rootClass.world.CHARS.addChild(_local_4);
                    };
                    return;
                };
            };
        }

        public function getArmorRep(_arg1:String=""):int
        {
            if (_arg1 == "")
            {
                _arg1 = this.objData.strClassName;
            };
            var _local2:* = this.getClassArmor(_arg1);
            if (_local2 != null)
            {
                return (_local2.iQty);
            };
            return (0);
        }

        public function getCPByID(_arg1:int):int
        {
            var _local2:* = this.getItemByID(_arg1);
            if (_local2 != null)
            {
                return (_local2.iQty);
            };
            return (-1);
        }

        public function updateRep():void
        {
            var cpToRank:int;
            var oldRank:int = this.objData.iRank;
            var oldCP:int = this.objData.iCP;
            var newRank:int = Rank.getRankFromPoints(this.objData.iCP);
            if (newRank < 10)
            {
                cpToRank = (Rank.RANKS[newRank] - Rank.RANKS[(newRank - 1)]);
            };
            this.objData.iCurCP = (oldCP - Rank.RANKS[(newRank - 1)]);
            this.objData.iRank = newRank;
            this.objData.iCPToRank = cpToRank;
            if (((this.isMyAvatar) && (!(this.objData.iRank == oldRank))))
            {
                Game.root.world.updatePortrait(this);
            };
            if (this.isMyAvatar)
            {
                Game.root.updateRepBar();
            };
        }

        public function levelUp():void
        {
            this.healAnimation();
            var levelUpDisplay:LevelUpDisplay = LevelUpDisplay(this.pMC.addChild(new LevelUpDisplay()));
            levelUpDisplay.t.ti.text = this.objData.intLevel;
            levelUpDisplay.x = this.pMC.mcChar.x;
            levelUpDisplay.y = (this.pMC.pname.y + 10);
        }

        public function rankUp(_arg1:String, _arg2:int):void
        {
            this.healAnimation();
            var rankUpDisplay:RankUpDisplay = RankUpDisplay(this.pMC.addChild(new RankUpDisplay()));
            rankUpDisplay.t.ti.htmlText = ((_arg1 + ", Rank ") + _arg2);
            rankUpDisplay.x = this.pMC.mcChar.x;
            rankUpDisplay.y = (this.pMC.pname.y + 10);
        }

        public function healAnimation():void
        {
            this.rootClass.mixer.playSound("Heal");
            var spEh1:sp_eh1 = sp_eh1(this.pMC.parent.addChild(new sp_eh1()));
            spEh1.x = this.pMC.x;
            spEh1.y = this.pMC.y;
        }

        public function isUpgraded():Boolean
        {
            return (int(this.objData.iUpgDays) >= 0);
        }

        public function hasUpgraded():Boolean
        {
            return (int(this.objData.iUpg) > 0);
        }

        public function isVerified():Boolean
        {
            return (((this.objData.intAQ > 0) || (this.objData.intDF > 0)) || (this.objData.intMQ > 0));
        }

        public function isStaff():Boolean
        {
            return (this.objData.intAccessLevel >= 40);
        }

        public function updatePending(_arg1:int):void
        {
            var _local5:String;
            var _local6:uint;
            if (this.objData.pending == null)
            {
                _local5 = "";
                _local6 = 0;
                while (_local6 < 500)
                {
                    _local5 = (_local5 + String.fromCharCode(0));
                    _local6++;
                };
                this.objData.pending = _local5;
            };
            var _local2:int = Math.floor((_arg1 >> 3));
            var _local3:int = (_arg1 % 8);
            var _local4:int = this.objData.pending.charCodeAt(_local2);
            _local4 = (_local4 | (1 << _local3));
            this.objData.pending = ((this.objData.pending.substr(0, _local2) + String.fromCharCode(_local4)) + this.objData.pending.substr((_local2 + 1)));
        }

        public function updateScrolls(_arg1:int):void
        {
            var _local5:String;
            var _local6:uint;
            if (this.objData.scrolls == null)
            {
                _local5 = "";
                _local6 = 0;
                while (_local6 < 500)
                {
                    _local5 = (_local5 + String.fromCharCode(0));
                    _local6++;
                };
                this.objData.scrolls = _local5;
            };
            var _local2:int = Math.floor((_arg1 >> 3));
            var _local3:int = (_arg1 % 8);
            var _local4:int = this.objData.scrolls.charCodeAt(_local2);
            _local4 = (_local4 | (1 << _local3));
            this.objData.scrolls = ((this.objData.scrolls.substr(0, _local2) + String.fromCharCode(_local4)) + this.objData.scrolls.substr((_local2 + 1)));
        }

        public function updateLoaded():void
        {
            this.loadCount--;
        }

        public function firstDone():void
        {
            this.firstLoad = false;
        }

        private function getFactionByID(_arg1:int):Object
        {
            var _local2:int;
            while (_local2 < this.factions.length)
            {
                if (this.factions[_local2].FactionID == _arg1)
                {
                    return (this.factions[_local2]);
                };
                _local2++;
            };
            return (null);
        }

        private function getFactionByName(_arg1:String):Object
        {
            var _local2:int;
            while (_local2 < this.factions.length)
            {
                if (this.factions[_local2].sName == _arg1)
                {
                    return (this.factions[_local2]);
                };
                _local2++;
            };
            return (null);
        }

        public function getBattlePass(battlePass:Object):Object
        {
            var userBattlePass:Object;
            for each (userBattlePass in this.objData.battlePasses)
            {
                if (userBattlePass.battlePassID == battlePass.id)
                {
                    return (userBattlePass);
                };
            };
            return (null);
        }

        public function addItemFood(food:Object):void
        {
            this.rootClass.world.cookData.items.push(food);
        }

        public function removeFood(food:Object):void
        {
            var food1:Object;
            var i:int;
            for each (food1 in this.rootClass.world.cookData.items)
            {
                if (food1.FoodID == food.FoodID)
                {
                    this.rootClass.world.cookData.items.removeAt(i);
                    return;
                };
                i++;
            };
        }

        public function removeIngredients(Food:*):void
        {
            var food:Object;
            var i:int;
            for each (food in Food.Ingredients)
            {
                i = 0;
                while (i < food.Quantity)
                {
                    this.removeFood(food);
                    i++;
                };
            };
        }

        public function removeFromFiltered(itemID:int):void
        {
            if (!this.filtered_list)
            {
                return;
            };
            if (((this.filtered_list) && (this.filtered_list.length < 1)))
            {
                return;
            };
            var _loc2_:int;
            while (_loc2_ < this.filtered_list.length)
            {
                if (this.filtered_list[_loc2_].ItemID == itemID)
                {
                    this.filtered_list.splice(_loc2_, 1);
                    break;
                };
                _loc2_++;
            };
        }

        public function get filtered_inventory():Vector.<Item>
        {
            return (((this.filtered_list) && (this.filtered_list.length > 0)) ? this.filtered_list : (((this.rootClass.ui.mcPopup.currentLabel == "HouseInventory") || (this.rootClass.ui.mcPopup.currentLabel == "HouseBank")) ? this.houseitems : this.items));
        }


    }
}//package 

