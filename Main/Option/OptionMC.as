// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Option.OptionMC

package Main.Option
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import Main.*;

    public class OptionMC extends MovieClip 
    {

        public var game:Game = Game.root;
        public var mcWorld:MovieClip;
        public var mcAvatar:MovieClip;
        public var mcNotification:MovieClip;
        public var mcChat:MovieClip;
        public var mcCombat:MovieClip;
        public var mcQuest:MovieClip;
        public var mcPopupKeys:MovieClip;
        public var mcCombatKeys:MovieClip;
        public var mcSkillSet:MovieClip;
        public var mcMiscellaneousKeys:MovieClip;
        public var mcVideo:MovieClip;
        public var mcAudio:MovieClip;
        public var mcVideoHotkeys:MovieClip;
        public var mcAudioHotkeys:MovieClip;
        public var btnClose:SimpleButton;
        public var btnHotkeys:SimpleButton;
        public var btnOptions:SimpleButton;
        public var btnReset:SimpleButton;
        public var btnAudiovisual:SimpleButton;
        public var btnServer:SimpleButton;
        public var btnLogout:SimpleButton;
        public var txtServer:TextField;
        public var txtServerTime:TextField;
        public var mcServerSettings:MovieClip;
        public var txtReputation:TextField;
        public var txtExperience:TextField;
        public var txtClassPoints:TextField;
        public var txtDrop:TextField;
        public var txtCoins:TextField;

        public function OptionMC()
        {
            addFrameScript(1, this.options, 3, this.hotkeys, 5, this.audiovisual, 7, this.server);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnHotkeys.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnOptions.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnAudiovisual.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnServer.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        public static function preferenceCache(data:String, value:*=null):void
        {
            var game:Game = Game.root;
            if (value == null)
            {
                game.userPreference.data[data] = (!(game.userPreference.data[data]));
            }
            else
            {
                game.userPreference.data[data] = value;
            };
            game.userPreference.flush();
        }

        public static function preferenceStore(data:String, value:Boolean):void
        {
            Game.root.network.send("cmd", ["uopref", data, String(value)]);
        }

        public static function preferenceKeybind(reset:Boolean=false):void
        {
            var game:Game = Game.root;
            if (((game.userPreference.data["keys"]) && (!(reset))))
            {
                return;
            };
            game.userPreference.data["keys"] = {
                "Change Target":9,
                "Auto Attack":49,
                "Skill 1":50,
                "Skill 2":51,
                "Skill 3":52,
                "Skill 4":53,
                "Item":54,
                "Cancel Target":27,
                "Area Information":85,
                "Bank":66,
                "Character":67,
                "Friends":70,
                "Guild":71,
                "Inventory":73,
                "World Map":77,
                "Party":80,
                "Quests":81,
                "Bot":null,
                "Rest":82,
                "Option":79,
                "Settings":null,
                "Toggle Avatar HP Bar":86,
                "Inner Force":null,
                "Auction":null,
                "World Boss":null,
                "Map Builder":null,
                "Npc Builder":null,
                "Staff Panel":null,
                "Battle Pass":null,
                "Ignore":null,
                "Toggle Party Panel":null,
                "Toggle Quest Tracker":null,
                "Change Quality":null,
                "Change FPS":null,
                "Toggle Overall Sounds":null,
                "Toggle Sound Effect":null,
                "Toggle Background Music":null,
                "Player Vs Player":null,
                "Titles":null,
                "Vending":null,
                "Rebirth":null,
                "Daily Login":null,
                "Redeem Code":null,
                "Inspect User":null,
                "Toggle World":null,
                "Toggle Players":null,
                "Toggle User Interface":null,
                "Toggle Props":null,
                "Fly":null
            };
            if (((game.currentLabel == "Game") && (game.ui.mcPopup.currentLabel == "OptionPanel")))
            {
                game.ui.mcPopup.mcOptionPanel.gotoAndPlay("Hotkeys");
            };
        }


        public function options():void
        {
            stop();
            this.mcWorld.distribute("World Settings", [{
                "strName":"Disable Map Bitmap",
                "bEnabled":this.game.userPreference.data["disableRenderMapAsBitmap"],
                "strDescription":"Disable the bitmap renderer of the map.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("disableRenderMapAsBitmap");
                }
            }, {
                "strName":"Hide Monsters",
                "bEnabled":this.game.userPreference.data["hideAllMon"],
                "strDescription":"Hides all of the monsters from the map.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideAllMon");
                    game.hideMonsterCheck();
                }
            }, {
                "strName":"Hide NPCs",
                "bEnabled":this.game.userPreference.data["hideAllNpc"],
                "strDescription":"Hides all of the NPCs from the map.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideAllNpc");
                    game.hideNpcCheck();
                }
            }, {
                "strName":"Hide Players",
                "bEnabled":this.game.userPreference.data["hideAllPlayer"],
                "strDescription":"Hides all of the Players from the map.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideAllPlayer");
                    game.hidePlayerCheck();
                }
            }, {
                "strName":"Hide Map",
                "bEnabled":this.game.userPreference.data["hideMap"],
                "strDescription":"Hides the Map.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideMap");
                    game.hideMapCheck();
                }
            }, {
                "strName":"Hide User Interface",
                "bEnabled":this.game.userPreference.data["hideUserInterface"],
                "strDescription":"Hides the User Interface.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideUserInterface");
                    game.hideUserInterfaceCheck();
                }
            }, {
                "strName":"Disable Others Animations",
                "bEnabled":this.game.userPreference.data["disableOtherPlayerAnimation"],
                "strDescription":"Disables the other player's animation.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("disableOtherPlayerAnimation");
                    game.disableOtherPlayerAnimationCheck();
                }
            }, {
                "strName":"Disable NPCs Animations",
                "bEnabled":this.game.userPreference.data["disableNPCsAnimation"],
                "strDescription":"Disables the NPCs animation.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("disableNPCsAnimation");
                    game.disableNPCAnimationCheck();
                }
            }, {
                "strName":"Disable Monster Animations",
                "bEnabled":this.game.userPreference.data["disableMonsterAnimation"],
                "strDescription":"Disables the Monster animation.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("disableMonsterAnimation");
                    game.disableMonsterAnimationCheck();
                }
            }]);
            this.mcAvatar.distribute("Avatar Settings", [{
                "strName":"Hide My Pet",
                "bEnabled":(!(this.game.uoPref.bPet)),
                "strDescription":"Hides your Pet.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bPet = (!(game.uoPref.bPet));
                    game.world.myAvatar.pMC.setPetVisibility(game.uoPref.bPet);
                    preferenceStore("bPet", game.uoPref.bPet);
                }
            }, {
                "strName":"Hide My Helm",
                "bEnabled":(!(this.game.uoPref.bHelm)),
                "strDescription":"Hides your Helm.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bHelm = (!(game.uoPref.bHelm));
                    game.world.myAvatar.dataLeaf.showHelm = game.uoPref.bHelm;
                    game.world.myAvatar.pMC.setHelmVisibility(game.uoPref.bHelm);
                    preferenceStore("bHelm", game.uoPref.bHelm);
                }
            }, {
                "strName":"Hide My Cape",
                "bEnabled":(!(this.game.uoPref.bCloak)),
                "strDescription":"Hides your Cape.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bCloak = (!(game.uoPref.bCloak));
                    game.world.myAvatar.dataLeaf.showCloak = game.uoPref.bCloak;
                    game.world.myAvatar.pMC.setCloakVisibility(game.uoPref.bCloak);
                    preferenceStore("bCloak", game.uoPref.bCloak);
                }
            }, {
                "strName":"Hide My Rune",
                "bEnabled":(!(this.game.uoPref.bRune)),
                "strDescription":"Hides your Rune.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bRune = (!(game.uoPref.bRune));
                    game.world.myAvatar.dataLeaf.showRune = game.uoPref.bRune;
                    game.world.myAvatar.pMC.setGroundVisibility(game.uoPref.bRune);
                    preferenceStore("bRune", game.uoPref.bRune);
                }
            }, {
                "strName":"Hide My Title",
                "bEnabled":(!(this.game.uoPref.bTitle)),
                "strDescription":"Hides your Title.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bTitle = (!(game.uoPref.bTitle));
                    game.world.myAvatar.dataLeaf.showTitle = game.uoPref.bTitle;
                    game.world.myAvatar.pMC.setTitleVisibility(game.uoPref.bTitle);
                    preferenceStore("bTitle", game.uoPref.bTitle);
                }
            }, {
                "strName":"Hide My Entity",
                "bEnabled":(!(this.game.uoPref.bEntity)),
                "strDescription":"Hides the entities of the other players.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bEntity = (!(game.uoPref.bEntity));
                    game.world.myAvatar.dataLeaf.showEntity = game.uoPref.bEntity;
                    game.world.myAvatar.pMC.setEntityVisibility(game.uoPref.bEntity);
                    preferenceStore("bEntity", game.uoPref.bEntity);
                }
            }, {
                "strName":"Hide My Username",
                "bEnabled":this.game.userPreference.data["hideMyUsername"],
                "strDescription":"Hides your username.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideMyUsername");
                    game.hideMyUsernameCheck();
                }
            }, {
                "strName":"Hide My Guild",
                "bEnabled":this.game.userPreference.data["hideMyGuild"],
                "strDescription":"Hides your guild.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideMyGuild");
                    game.hideMyGuildCheck();
                }
            }, {
                "strName":"Hide Other Pets",
                "bEnabled":this.game.userPreference.data["hideOtherPets"],
                "strDescription":"Hides the pets of the other players.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideOtherPets");
                    game.hideOtherPetsCheck();
                }
            }, {
                "strName":"Hide Other Helms",
                "bEnabled":this.game.userPreference.data["hideOtherHelms"],
                "strDescription":"Hides the helms of the other players.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideOtherHelms");
                    game.hideOtherHelmsCheck();
                }
            }, {
                "strName":"Hide Other Capes",
                "bEnabled":this.game.userPreference.data["hideOtherCapes"],
                "strDescription":"Hides the capes of the other players.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideOtherCapes");
                    game.hideOtherCapesCheck();
                }
            }, {
                "strName":"Hide Other Runes",
                "bEnabled":this.game.userPreference.data["hideOtherRunes"],
                "strDescription":"Hides the runes of the other players.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideOtherRunes");
                    game.hideOtherRunesCheck();
                }
            }, {
                "strName":"Hide Other Entities",
                "bEnabled":this.game.userPreference.data["hideOtherEntities"],
                "strDescription":"Hides the entities of the other players.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideOtherEntities");
                    game.hideOtherEntitiesCheck();
                }
            }, {
                "strName":"Hide Other Username",
                "bEnabled":this.game.userPreference.data["hideOtherUsername"],
                "strDescription":"Hides other's username.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideOtherUsername");
                    game.hideOtherUsernamesCheck();
                }
            }, {
                "strName":"Hide Other Guild",
                "bEnabled":this.game.userPreference.data["hideOtherGuild"],
                "strDescription":"Hides other's guild.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("hideOtherGuild");
                    game.hideOtherGuildsCheck();
                }
            }, {
                "strName":"Ignore Goto",
                "bEnabled":(!(this.game.uoPref.bGoto)),
                "strDescription":"Ignores goto request from players.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bGoto = (!(game.uoPref.bGoto));
                    preferenceStore("bGoto", game.uoPref.bGoto);
                }
            }]);
            this.mcNotification.distribute("Notification Settings", [{
                "strName":"Ignore Party Invites",
                "bEnabled":(!(this.game.uoPref.bParty)),
                "strDescription":"Prevents players from sending you a party invite.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bParty = (!(game.uoPref.bParty));
                    preferenceStore("bParty", game.uoPref.bParty);
                }
            }, {
                "strName":"Ignore Friend Invites",
                "bEnabled":(!(this.game.uoPref.bFriend)),
                "strDescription":"Prevents players from sending you a friend invite.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bFriend = (!(game.uoPref.bFriend));
                    preferenceStore("bFriend", game.uoPref.bFriend);
                }
            }, {
                "strName":"Ignore Duel Invites",
                "bEnabled":(!(this.game.uoPref.bDuel)),
                "strDescription":"Prevents players from sending you a duel invite.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bDuel = (!(game.uoPref.bDuel));
                    preferenceStore("bDuel", game.uoPref.bDuel);
                }
            }, {
                "strName":"Ignore Guild Invites",
                "bEnabled":(!(this.game.uoPref.bGuild)),
                "strDescription":"Prevents players from sending you a guild invite.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bGuild = (!(game.uoPref.bGuild));
                    preferenceStore("bGuild", game.uoPref.bGuild);
                }
            }, {
                "strName":"Ignore Trade Invites",
                "bEnabled":(!(this.game.uoPref.bTrade)),
                "strDescription":"Prevents players from sending you a trade invite.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bTrade = (!(game.uoPref.bTrade));
                    preferenceStore("bTrade", game.uoPref.bTrade);
                }
            }, {
                "strName":"Ignore World Boss Invites",
                "bEnabled":(!(this.game.uoPref.bWorldBoss)),
                "strDescription":"Prevents the serer from sending you a world boss invite.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bWorldBoss = (!(game.uoPref.bWorldBoss));
                    preferenceStore("bWorldBoss", game.uoPref.bWorldBoss);
                }
            }, {
                "strName":"Ignore Guild Raid Invites",
                "bEnabled":(!(this.game.uoPref.bGuildRaid)),
                "strDescription":"Prevents the guild from sending you a guild raid invite.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bGuildRaid = (!(game.uoPref.bGuildRaid));
                    preferenceStore("bGuildRaid", game.uoPref.bGuildRaid);
                }
            }, {
                "strName":"Ignore Private Messages",
                "bEnabled":(!(this.game.uoPref.bWhisper)),
                "strDescription":"Prevents players from sending you a private message.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bWhisper = (!(game.uoPref.bWhisper));
                    preferenceStore("bWhisper", game.uoPref.bWhisper);
                }
            }, {
                "strName":"Alternative Drop Interface",
                "bEnabled":(!(this.game.uoPref.bDropInterface)),
                "strDescription":"Prevents other servers from sending you a cross chat message.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bDropInterface = (!(game.uoPref.bDropInterface));
                    preferenceStore("bDropInterface", game.uoPref.bDropInterface);
                    game.toggleDropInterface();
                }
            }, {
                "strName":"Disable Tool Tips",
                "bEnabled":(!(this.game.uoPref.bTT)),
                "strDescription":"Disable tooltips in game.",
                "component":new CheckBoxMC(),
                "callback":function ():*
                {
                    game.uoPref.bTT = (!(game.uoPref.bTT));
                    preferenceStore("bTT", game.uoPref.bTT);
                }
            }]);
            this.mcChat.distribute("Chat Settings", [{
                "strName":"Chat Timestamps",
                "bEnabled":this.game.userPreference.data["defaultChatTimestamp"],
                "strDescription":"Enables timestamps in the default chat.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("defaultChatTimestamp");
                }
            }, {
                "strName":"Disable Server Messages",
                "bEnabled":this.game.userPreference.data["defaultChatServerMessage"],
                "strDescription":"Disables server messages in the default chat.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("defaultChatServerMessage");
                }
            }]);
            this.mcCombat.distribute("Combat Settings", [{
                "strName":"Enable Combat Text Bitmap",
                "bEnabled":this.game.userPreference.data["enableRenderCombatTextAsBitmap"],
                "strDescription":"Enable the bitmap renderer of the combat text.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("enableRenderCombatTextAsBitmap");
                }
            }, {
                "strName":"Enable Target Flicker",
                "bEnabled":this.game.userPreference.data["enableTargetFlicker"],
                "strDescription":"Enable the target's flickering on hit.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("enableTargetFlicker");
                }
            }, {
                "strName":"Hide Self Auras",
                "bEnabled":this.game.userPreference.data["combatHideSelfAuras"],
                "strDescription":"Hides your avatar's active aura display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideSelfAuras");
                    game.hideSelfAurasCheck();
                }
            }, {
                "strName":"Hide Target Auras",
                "bEnabled":this.game.userPreference.data["combatHideTargetAuras"],
                "strDescription":"Hides your target's active aura display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideTargetAuras");
                    game.hideTargetAurasCheck();
                }
            }, {
                "strName":"Hide Self Damage Over Time",
                "bEnabled":this.game.userPreference.data["combatHideSelfDamageOverTime"],
                "strDescription":"Hides your self’s damage over time.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideSelfDamageOverTime");
                }
            }, {
                "strName":"Hide Others Damage Over Time",
                "bEnabled":this.game.userPreference.data["combatHideOthersDamageOverTime"],
                "strDescription":"Hides other players' damage over time.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideOthersDamageOverTime");
                }
            }, {
                "strName":"Hide Monsters Damage Over Time",
                "bEnabled":this.game.userPreference.data["combatHideMonstersDamageOverTime"],
                "strDescription":"Hides other monsters' damage over time.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideMonstersDamageOverTime");
                }
            }, {
                "strName":"Hide NPCs Damage Over Time",
                "bEnabled":this.game.userPreference.data["combatHideNPCsDamageOverTime"],
                "strDescription":"Hides NPCs' damage over time.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideNPCsDamageOverTime");
                }
            }, {
                "strName":"Hide Self Damage",
                "bEnabled":this.game.userPreference.data["combatHideSelfDamage"],
                "strDescription":"Hides your self’s damage.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideSelfDamage");
                }
            }, {
                "strName":"Hide Others Damage",
                "bEnabled":this.game.userPreference.data["combatHideOthersDamage"],
                "strDescription":"Hides other players' damage.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideOthersDamage");
                }
            }, {
                "strName":"Hide Monsters Damage",
                "bEnabled":this.game.userPreference.data["combatHideMonstersDamage"],
                "strDescription":"Hides monsters' damage.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideMonstersDamage");
                }
            }, {
                "strName":"Hide NPCs Damage",
                "bEnabled":this.game.userPreference.data["combatHideNPCsDamage"],
                "strDescription":"Hides NPCs' damage.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideNPCsDamage");
                }
            }, {
                "strName":"Hide Self Skill Animations",
                "bEnabled":this.game.userPreference.data["combatHideSelfSkillAnimations"],
                "strDescription":"Hides your self’s skill animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideSelfSkillAnimations");
                }
            }, {
                "strName":"Hide Others Skill Animations",
                "bEnabled":this.game.userPreference.data["combatHideOthersSkillAnimations"],
                "strDescription":"Hides other players' skill animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideOthersSkillAnimations");
                }
            }, {
                "strName":"Hide Monsters Skill Animations",
                "bEnabled":this.game.userPreference.data["combatHideMonstersSkillAnimations"],
                "strDescription":"Hides monsters' skill animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideMonstersSkillAnimations");
                }
            }, {
                "strName":"Hide NPCs Skill Animations",
                "bEnabled":this.game.userPreference.data["combatHideNPCsSkillAnimations"],
                "strDescription":"Hides NPCs' skill animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideNPCsSkillAnimations");
                }
            }, {
                "strName":"Hide Self Attack Animations",
                "bEnabled":this.game.userPreference.data["combatHideSelfAttackAnimations"],
                "strDescription":"Hides your self’s attack animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideSelfAttackAnimations");
                }
            }, {
                "strName":"Hide Others Attack Animations",
                "bEnabled":this.game.userPreference.data["combatHideOthersAttackAnimations"],
                "strDescription":"Hides other players' attack animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideOthersAttackAnimations");
                }
            }, {
                "strName":"Hide Monsters Attack Animations",
                "bEnabled":this.game.userPreference.data["combatHideMonstersAttackAnimations"],
                "strDescription":"Hides monsters' attack animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideMonstersAttackAnimations");
                }
            }, {
                "strName":"Hide NPCs Attack Animations",
                "bEnabled":this.game.userPreference.data["combatHideNPCsAttackAnimations"],
                "strDescription":"Hides NPCs' attack animations.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatHideNPCsAttackAnimations");
                }
            }, {
                "strName":"Show Commas in Damage Display",
                "bEnabled":this.game.userPreference.data["combatShowCommaDamageDisplay"],
                "strDescription":"Shows commas in damage display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatShowCommaDamageDisplay");
                }
            }, {
                "strName":"Show Commas in DoT Display",
                "bEnabled":this.game.userPreference.data["combatShowCommaOverTimeDisplay"],
                "strDescription":"Shows commas in damage over time display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatShowCommaOverTimeDisplay");
                }
            }, {
                "strName":"Show Commas in HP Display",
                "bEnabled":this.game.userPreference.data["combatShowCommaHPDisplay"],
                "strDescription":"Shows commas in Health Points display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatShowCommaHPDisplay");
                }
            }, {
                "strName":"Show Commas in MP Display",
                "bEnabled":this.game.userPreference.data["combatShowCommaMPDisplay"],
                "strDescription":"Shows commas in Mana Points display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatShowCommaMPDisplay");
                }
            }, {
                "strName":"Show Full Damage Display",
                "bEnabled":this.game.userPreference.data["combatShowFullDamageDisplay"],
                "strDescription":"Shows Full damage display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatShowFullDamageDisplay");
                }
            }, {
                "strName":"Show Abbreviated DoT Display",
                "bEnabled":this.game.userPreference.data["combatShowAbbreviatedDoTDisplay"],
                "strDescription":"Shows abbreviated DoT display.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("combatShowAbbreviatedDoTDisplay");
                }
            }]);
            this.mcQuest.distribute("Quest Settings", [{
                "strName":"Quest Pinner",
                "bEnabled":this.game.userPreference.data["questPinner"],
                "strDescription":'1. Open quests from any NPC\n2. Press the "Pin Quests" button (left)\n3. You can now access it from anywhere by clicking on the yellow (!) quest log icon at the top left!\nShift+Click the yellow (!) quest log icon to open the Quest Tracker!\nShift+Click the quest pinner icon to clear your pinned quests.',
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("questPinner");
                }
            }, {
                "strName":"Quest Auto Accept After Turn-In",
                "bEnabled":this.game.uoPref.bQuestAccept,
                "strDescription":"Auto Accept Quest when turned-in.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    game.uoPref.bQuestAccept = (!(game.uoPref.bQuestAccept));
                    preferenceStore("bQuestAccept", game.uoPref.bQuestAccept);
                }
            }, {
                "strName":"Hide Quest Progress Notification",
                "bEnabled":this.game.userPreference.data["questProgressNotification"],
                "strDescription":"Hides Quest Progress Notification.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("questProgressNotification");
                }
            }]);
        }

        public function hotkeys():void
        {
            stop();
            this.btnReset.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcPopupKeys.distribute("Popup Hotkeys", [{
                "strName":"Inventory",
                "strDescription":"Toggles your inventory window.",
                "component":new KeybindMC()
            }, {
                "strName":"Quests",
                "strDescription":"Toggles your quest log window.",
                "component":new KeybindMC()
            }, {
                "strName":"Friends",
                "strDescription":"Toggles your fiends window.",
                "component":new KeybindMC()
            }, {
                "strName":"Character",
                "strDescription":"Toggles your character window.",
                "component":new KeybindMC()
            }, {
                "strName":"Player Vs Player",
                "strDescription":"Toggles your PvP window.",
                "component":new KeybindMC()
            }, {
                "strName":"Guild",
                "strDescription":"Toggles your guild window.",
                "component":new KeybindMC()
            }, {
                "strName":"Settings",
                "strDescription":"Toggles your settings window.",
                "component":new KeybindMC()
            }, {
                "strName":"Area Information",
                "strDescription":"Toggles your area information window.",
                "component":new KeybindMC()
            }, {
                "strName":"World Map",
                "strDescription":"Toggles your world map window.",
                "component":new KeybindMC()
            }, {
                "strName":"Party",
                "strDescription":"Toggles your party window.",
                "component":new KeybindMC()
            }, {
                "strName":"Rebirth",
                "strDescription":"Toggles your rebirth window.",
                "component":new KeybindMC()
            }, {
                "strName":"Daily Login",
                "strDescription":"Toggles your daily login window.",
                "component":new KeybindMC()
            }, {
                "strName":"Redeem Code",
                "strDescription":"Toggles your redeem code window.",
                "component":new KeybindMC()
            }, {
                "strName":"Inspect User",
                "strDescription":"Toggles your inspect user window.",
                "component":new KeybindMC()
            }, {
                "strName":"Ignore",
                "strDescription":"Toggles your ignore player list.",
                "component":new KeybindMC()
            }, {
                "strName":"Bank",
                "strDescription":"Toggles your bank window.",
                "intAccess":2,
                "component":new KeybindMC()
            }, {
                "strName":"Auction",
                "strDescription":"Toggles your auction window.",
                "intAccess":40,
                "component":new KeybindMC()
            }, {
                "strName":"World Boss",
                "strDescription":"Toggles your world boss window.",
                "intAccess":40,
                "component":new KeybindMC()
            }, {
                "strName":"Map Builder",
                "strDescription":"Toggles the map builder window.",
                "intAccess":40,
                "component":new KeybindMC()
            }, {
                "strName":"Npc Builder",
                "strDescription":"Toggles the NPC builder window.",
                "intAccess":40,
                "component":new KeybindMC()
            }, {
                "strName":"Staff Panel",
                "strDescription":"Toggles your staff panel window.",
                "intAccess":40,
                "component":new KeybindMC()
            }, {
                "strName":"Battle Pass",
                "strDescription":"Toggles your battle pass window.",
                "intAccess":40,
                "component":new KeybindMC()
            }]);
            this.mcCombatKeys.distribute("Combat Hotkeys", [{
                "strName":"Change Target",
                "strDescription":"Changes your target randomly.",
                "component":new KeybindMC()
            }, {
                "strName":"Cancel Target",
                "strDescription":"Closes your selected target.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle Avatar HP Bar",
                "strDescription":"Toggles all player's HP Bar.",
                "component":new KeybindMC()
            }, {
                "strName":"Rest",
                "strDescription":"Toggles Rest.",
                "component":new KeybindMC()
            }]);
            this.mcMiscellaneousKeys.distribute("Miscellaneous Hotkeys", [{
                "strName":"Toggle Party Panel",
                "strDescription":"Toggles the party members display.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle Quest Tracker",
                "strDescription":"Toggles the quest tracker display.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle World",
                "strDescription":"Toggles hide and show world.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle Players",
                "strDescription":"Toggles hide and show players.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle User Interface",
                "strDescription":"Toggles user interface.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle Props",
                "strDescription":"Toggles world props.",
                "intAccess":40,
                "component":new KeybindMC()
            }, {
                "strName":"Fly",
                "strDescription":"Toggles fly.",
                "intAccess":40,
                "component":new KeybindMC()
            }]);
            this.mcSkillSet.update();
        }

        public function audiovisual():void
        {
            stop();
            this.mcVideo.distribute("Video Settings", [{
                "strName":"Quality",
                "strDescription":"Adjusts the rendering quality of the game, affecting visual fidelity and performance.",
                "component":new MeterMC(),
                "minimum":{
                    "value":0,
                    "text":"Low"
                },
                "maximum":{
                    "value":4,
                    "text":"Best"
                },
                "value":this.game.userPreference.data["videoSettingsQuality"],
                "callback":function (txtValue:TextField, intValue:int):*
                {
                    switch (intValue)
                    {
                        case 0:
                            txtValue.text = "Auto";
                            break;
                        case 1:
                            txtValue.text = "Low";
                            break;
                        case 2:
                            txtValue.text = "Medium";
                            break;
                        case 3:
                            txtValue.text = "High";
                            break;
                        case 4:
                            txtValue.text = "Best";
                            break;
                    };
                    preferenceCache("videoSettingsQuality", intValue);
                    game.videoSettingsQualityCheck();
                }
            }, {
                "strName":"FPS",
                "strDescription":"Sets the game's maximum frames per second for smoother motion or performance optimization.",
                "component":new MeterMC(),
                "minimum":{
                    "value":0,
                    "text":24
                },
                "maximum":{
                    "value":4,
                    "text":120
                },
                "value":this.game.userPreference.data["videoSettingsFPS"],
                "callback":function (txtValue:TextField, intValue:int):*
                {
                    switch (intValue)
                    {
                        case 0:
                            txtValue.text = 24;
                            break;
                        case 1:
                            txtValue.text = 30;
                            break;
                        case 2:
                            txtValue.text = 60;
                            break;
                        case 3:
                            txtValue.text = 75;
                            break;
                        case 4:
                            txtValue.text = 120;
                            break;
                    };
                    preferenceCache("videoSettingsFPS", intValue);
                    game.videoSettingsFPSCheck();
                }
            }], 552.75, 170);
            this.mcAudio.distribute("Audio Settings", [{
                "strName":"Overall Sounds",
                "strDescription":"Controls the overall volume of all game sounds, including effects and music.",
                "component":new MeterMC(),
                "minimum":{
                    "value":0,
                    "text":0
                },
                "maximum":{
                    "value":10,
                    "text":100
                },
                "value":this.game.userPreference.data["audioSettingsOverall"],
                "callback":function (txtValue:TextField, intValue:int):*
                {
                    var displayValue:* = (intValue * 10);
                    txtValue.text = displayValue.toString();
                    preferenceCache("audioSettingsOverall", intValue);
                    game.audioSettingsOverallCheck();
                }
            }, {
                "strName":"Sound Effects",
                "strDescription":"Adjusts the volume of in-game sound effects, such as explosions or footsteps.",
                "component":new MeterMC(),
                "minimum":{
                    "value":0,
                    "text":0
                },
                "maximum":{
                    "value":10,
                    "text":100
                },
                "value":this.game.userPreference.data["audioSettingsSoundEffect"],
                "callback":function (txtValue:TextField, intValue:int):*
                {
                    var displayValue:* = (intValue * 10);
                    txtValue.text = displayValue.toString();
                    preferenceCache("audioSettingsSoundEffect", intValue);
                    game.audioSettingsSoundEffectCheck();
                }
            }, {
                "strName":"Background Music",
                "strDescription":"Changes the volume of the game's background music.",
                "component":new MeterMC(),
                "minimum":{
                    "value":0,
                    "text":0
                },
                "maximum":{
                    "value":10,
                    "text":100
                },
                "value":this.game.userPreference.data["audioSettingsBackgroundMusic"],
                "callback":function (txtValue:TextField, intValue:int):*
                {
                    var displayValue:* = (intValue * 10);
                    txtValue.text = displayValue.toString();
                    preferenceCache("audioSettingsBackgroundMusic", intValue);
                    game.audioSettingsBackgroundMusicCheck();
                }
            }], 552.75, 170);
            this.mcVideoHotkeys.distribute("", [{
                "strName":"Change Quality",
                "strDescription":"Assign a key to quickly toggle or adjust the game's rendering quality.",
                "component":new KeybindMC()
            }, {
                "strName":"Change FPS",
                "strDescription":"Assign a key to adjust the game's frame rate for smoother gameplay or performance tweaks.",
                "component":new KeybindMC()
            }]);
            this.mcAudioHotkeys.distribute("", [{
                "strName":"Toggle Overall Sounds",
                "strDescription":"Assign a key to toggle the overall sound on or off quickly.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle Sound Effects",
                "strDescription":"Assign a key to quickly toggle sound effects on or off.",
                "component":new KeybindMC()
            }, {
                "strName":"Toggle Background Music",
                "strDescription":"Assign a key to toggle the background music on or off during gameplay.",
                "component":new KeybindMC()
            }]);
        }

        public function server():void
        {
            stop();
            this.btnLogout.addEventListener(MouseEvent.CLICK, this.onClick);
            this.txtServer.text = this.game.objServerInfo.Name;
            this.txtServerTime.text = this.game.date_server.toLocaleTimeString();
            this.mcServerSettings.distribute("Server Settings", [{
                "strName":"Show Server Latency",
                "bEnabled":this.game.userPreference.data["showServerLatency"],
                "strDescription":"Shows your latency in the game.",
                "component":new CheckBoxMC(),
                "callback":function ():void
                {
                    preferenceCache("showServerLatency");
                    game.showServerLatencyCheck();
                }
            }]);
            this.txtReputation.text = this.game.world.rate.rateReputation;
            this.txtExperience.text = this.game.world.rate.rateExperience;
            this.txtClassPoints.text = this.game.world.rate.rateClassPoints;
            this.txtDrop.text = this.game.world.rate.rateDrop;
            this.txtCoins.text = this.game.world.rate.rateCoins;
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
                case "btnHotkeys":
                    gotoAndPlay("Hotkeys");
                    break;
                case "btnOptions":
                    gotoAndPlay("Options");
                    break;
                case "btnAudiovisual":
                    gotoAndPlay("Audiovisual");
                    break;
                case "btnServer":
                    gotoAndPlay("Server");
                    break;
                case "btnReset":
                    MainController.modal("Would you reset your hotkey bindings?", this.resetRequest, {}, "red,medium", "dual", true);
                    break;
                case "btnLogout":
                    MainController.modal("Would you like to logout?", this.logoutRequest, {}, "red,medium", "dual", true);
                    break;
            };
        }

        private function resetRequest(event:Object):void
        {
            if (event.accept)
            {
                preferenceKeybind(true);
            };
        }

        private function logoutRequest(event:Object):void
        {
            if (event.accept)
            {
                this.game.logout();
            };
        }


    }
}//package Main.Option

