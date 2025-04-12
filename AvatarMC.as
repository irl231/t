// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//AvatarMC

package 
{
    import Main.Avatar.AbstractAvatarMC;
    import flash.geom.ColorTransform;
    import flash.display.SimpleButton;
    import flash.display.MovieClip;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.system.ApplicationDomain;
    import Game_fla.ui_213;
    import Game_fla.ui_244;
    import flash.display.Graphics;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.filters.*;
    import Main.Aqw.LPF.*;
    import Main.Avatar.*;
    import Main.Controller.*;
    import Main.*;

    public class AvatarMC extends AbstractAvatarMC 
    {

        private static const NAME_GLOW:Array = [new GlowFilter(0, 1, 3, 3, 64, 1)];
        private static const CT3:ColorTransform = new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0);
        private static const CT2:ColorTransform = new ColorTransform(1, 1, 1, 1, 127, 127, 127, 0);
        private static const CT1:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        private static const parts:Array = ["cape", "backhair", "robe", "backrobe", "pvpFlag", "cloud"];
        private static const weapons:Array = ["weapon", "weaponOff", "weaponFist", "weaponFistOff", "shield"];
        private static const founders:Array = ["Consel", "Crownz", "Iron51", "Leforous"];

        public var attackFrames:Array = [];
        public var mcVending:SimpleButton;
        public var hpBar:MovieClip;
        public var proxy:MovieClip;
        public var mcChar:mcSkel;
        public var ignore:MovieClip;
        public var cShadow:MovieClip;
        public var Sounds:MovieClip;
        public var apopbutton:MovieClip;
        public var entityMC:MovieClip = null;
        public var afk:MovieClip;
        public var projClass:Projectile;
        public var spellDur:int = 0;
        public var bBackHair:Boolean = false;
        public var isLoaded:Boolean = false;
        public var isFlying:Boolean = false;
        public var kv:Killvis = null;
        public var strGender:String;
        public var hitboxR:Rectangle;
        public var strFace:String = "right";
        public var world:World;
        private var walkSpeed:Number;
        private var headPoint:Point;
        private var bLoadingEntity:Boolean = false;
        private var objLinks:Object = {};
        private var weaponLoad:Boolean = true;
        private var armorLoad:Boolean = true;
        private var classLoad:Boolean = true;
        private var entityLoad:Boolean = true;
        private var capeLoad:Boolean = true;
        private var miscLoad:Boolean = true;
        private var titleLoad:Boolean = true;
        private var animEvents:Object = {};
        private var bLoadingHelm:Boolean = false;
        private var helmLoad:Boolean = true;
        private var hairLoad:Boolean = true;
        private var isHelmLoaded:Boolean = false;

        public function AvatarMC():void
        {
            addFrameScript(0, this.frame1, 4, this.frame5, 7, this.frameStop, 9, this.frame10, 11, this.frame12, 12, this.frame13, 13, this.frameCT1, 17, this.frameStop, 19, this.frameCT1, 22, this.frameStop);
            this.Sounds.visible = false;
            this.ignore.visible = false;
            this.bubble.visible = false;
            this.mcVending.visible = false;
            this.afk.visible = false;
            this.pname.Alliance.visible = false;
            if (this.pname.VIP)
            {
                this.pname.VIP.visible = false;
            };
            if (this.pname.Ambassador)
            {
                this.pname.Ambassador.visible = false;
            };
            if (this.pname.Founder)
            {
                this.pname.Founder.visible = false;
            };
            this.mcChar.addEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.mcChar.buttonMode = true;
            this.mcChar.pvpFlag.mouseEnabled = false;
            this.mcChar.pvpFlag.mouseChildren = false;
            this.mcChar.cloud.visible = false;
            this.pname.mouseChildren = false;
            this.pname.buttonMode = false;
            this.mcChar.mouseChildren = true;
            this.bubble.mouseEnabled = (this.bubble.mouseChildren = false);
            this.shadow.mouseEnabled = (this.shadow.mouseChildren = false);
            this.addEventListener(Event.ENTER_FRAME, this.checkQueue, false, 0, true);
            this.bubble.t = "";
            this.pname.ti.text = "";
            this.headPoint = new Point(0, (this.mcChar.head.y - (1.4 * this.mcChar.head.height)));
            this.hideOptionalParts();
        }

        public function get AnimEvent():Object
        {
            return (this.animEvents);
        }

        public function clearAnimEvents():void
        {
            this.animEvents = new Object();
        }

        public function get artLoaded():Boolean
        {
            return ((((((((this.weaponLoad) && (this.capeLoad)) && (this.helmLoad)) && (this.armorLoad)) && (this.classLoad)) && (this.hairLoad)) && (this.miscLoad)) && (this.titleLoad));
        }

        override public function gotoAndPlay(frame:Object, scene:String=null):void
        {
            this.handleAnimEvent(String(frame));
            super.gotoAndPlay(frame);
        }

        override public function queueAnim(animation:String):void
        {
            var petItem:Object;
            var p:String;
            var petSplit:Array;
            var weaponItem:Object;
            var sType:String;
            var randomAnimation:String;
            var sES:String;
            if ((((!(animation)) == "Walk") && ((!(animation)) == "Idle")))
            {
                return;
            };
            if ((((this.pAV.npcType == "player") && (this.pAV.pMC == this.world.myAvatar.pMC)) && (Game.root.userPreference.data.combatHideSelfAttackAnimations)))
            {
                return;
            };
            if ((((this.pAV.npcType == "player") && (!(this.pAV.pMC == this.world.myAvatar.pMC))) && (Game.root.userPreference.data.combatHideOthersAttackAnimations)))
            {
                return;
            };
            if (((this.pAV.npcType == "monster") && (Game.root.userPreference.data.combatHideMonstersAttackAnimations)))
            {
                return;
            };
            if (((this.pAV.npcType == "npc") && (Game.root.userPreference.data.combatHideNPCsAttackAnimations)))
            {
                return;
            };
            if (animation.indexOf("Pet") > -1)
            {
                petItem = this.pAV.getItemByEquipSlot("pe");
                if (animation.indexOf(":") > -1)
                {
                    petSplit = animation.split(":");
                    animation = petSplit[0];
                    try
                    {
                        if (petItem != null)
                        {
                            if (petSplit[1] == "PetAttack")
                            {
                                p = ["Attack1", "Attack2"][Math.round(Math.random())];
                                if (((this.pAV.petMC.mcChar.currentLabel == "Idle") && (MainController.hasLabel(p, this.pAV.petMC.mcChar))))
                                {
                                    this.pAV.petMC.mcChar.gotoAndPlay(p);
                                };
                            }
                            else
                            {
                                p = petSplit[1].slice(3);
                                if (((this.pAV.petMC.mcChar.currentLabel == "Idle") && (MainController.hasLabel(p, this.pAV.petMC.mcChar))))
                                {
                                    this.pAV.petMC.mcChar.gotoAndPlay(p);
                                };
                            };
                        };
                    }
                    catch(e:Error)
                    {
                        trace(("AvatarMC queueAnim 1 " + e));
                    };
                }
                else
                {
                    if (petItem != null)
                    {
                        try
                        {
                            p = ["Attack1", "Attack2"][Math.round(Math.random())];
                            if (this.pAV.petMC.mcChar.currentLabel == "Idle")
                            {
                                this.pAV.petMC.mcChar.gotoAndPlay(p);
                            };
                            return;
                        }
                        catch(e:Error)
                        {
                            trace(("AvatarMC queueAnim 2 " + e));
                            animation = ["Attack1", "Attack2"][Math.round(Math.random())];
                        };
                    }
                    else
                    {
                        animation = ((animation.indexOf("1") > -1) ? "Attack1" : "Attack2");
                    };
                };
            };
            if (((animation == "Attack1") || (animation == "Attack2")))
            {
                weaponItem = this.pAV.getItemByEquipSlot("Weapon");
                if (weaponItem != null)
                {
                    sType = ((weaponItem.sName.toLowerCase().indexOf("unarmed") > -1) ? "Unarmed" : weaponItem.sType);
                    switch (sType)
                    {
                        case "Unarmed":
                            animation = ["UnarmedAttack1", "UnarmedAttack2", "KickAttack", "FlipAttack"][Math.round((Math.random() * 3))];
                            break;
                        case "Polearm":
                            animation = ["PolearmAttack1", "PolearmAttack2"][Math.round(Math.random())];
                            break;
                        case "Dagger":
                            animation = ["DuelWield/DaggerAttack1", "DuelWield/DaggerAttack2"][Math.round(Math.random())];
                            break;
                        case "Bow":
                            animation = "RangedAttack3";
                            break;
                        case "Whip":
                            animation = "WhipAttack";
                            break;
                        case "HandGun":
                            animation = ["GunAttack", "GunAttack2"][Math.round(Math.random())];
                            break;
                        case "Rifle":
                            animation = "RifleAttack2";
                            break;
                        case "Gauntlet":
                            animation = ["UnarmedAttack1", "UnarmedAttack2", "FistweaponAttack1", "FistweaponAttack2"][Math.round((Math.random() * 3))];
                            break;
                    };
                };
            };
            if (((AvatarUtil.playerLabels.indexOf(animation) >= 0) && (this.pAV.dataLeaf.intState > 0)))
            {
                pAV.handleItemAnimation();
                if (((AvatarUtil.combatAnims.indexOf(animation) > -1) && (AvatarUtil.combatAnims.indexOf(this.mcChar.currentLabel) > -1)))
                {
                    this.animQueue.push(animation);
                }
                else
                {
                    this.mcChar.gotoAndPlay(animation);
                    if (((!(this.pAV.objData.eqp.en == null)) && (!(this.entityMC == null))))
                    {
                        if (MainController.hasLabel(animation, this.entityMC))
                        {
                            this.entityMC.gotoAndPlay(animation);
                        }
                        else
                        {
                            randomAnimation = ["Attack1", "Attack2"][Math.round(Math.random())];
                            if (MainController.hasLabel(randomAnimation, this.entityMC))
                            {
                                this.entityMC.gotoAndPlay(randomAnimation);
                            };
                        };
                    };
                    if (((pAV.dataLeaf.intState == 2) && (!(pAV.objData.eqp == null))))
                    {
                        for (sES in pAV.objData.eqp)
                        {
                            this.handleAttack(sES);
                        };
                    };
                };
            };
        }

        override public function walkTo(toX:int, toY:int, walkSpeed:int):void
        {
            var speedAdjustment:int;
            var dx:Number;
            var actionLabel:String;
            if (((((!(this.world.rootClass.loaderDomain == null)) && (this.world.rootClass.userPreference.data.bitCheckedMobile)) && (!(this.world.strFrame == this.world.map.currentLabel))) && (this.world.rootClass.ui.joystick)))
            {
                return;
            };
            if (((this.pAV.petMC) && (this.pAV.petMC.mcChar)))
            {
                speedAdjustment = (((this.world.rootClass.loaderDomain) && (this.world.rootClass.loaderDomain.isDesktop)) ? -5 : -3);
                this.pAV.petMC.walkTo((toX - 20), (toY + 5), (walkSpeed + speedAdjustment));
            };
            this.op = new Point(this.x, this.y);
            this.tp = new Point(toX, toY);
            this.walkSpeed = walkSpeed;
            var dist:Number = Point.distance(this.op, this.tp);
            this.walkTS = new Date().getTime();
            this.walkD = Math.round((1000 * (dist / (walkSpeed * 22))));
            if (this.walkD > 0)
            {
                dx = (this.op.x - this.tp.x);
                this.turn(((dx < 0) ? "right" : "left"));
                if (!this.mcChar.onMove)
                {
                    actionLabel = ((this.isFlying) ? "Flywalk" : "Walk");
                    this.mcChar.onMove = true;
                    if (((MainController.hasLabel(actionLabel, this.mcChar)) && (!(this.mcChar.currentLabel == actionLabel))))
                    {
                        this.mcChar.gotoAndPlay(actionLabel);
                    };
                    if (((((this.pAV.objData) && (this.pAV.objData.eqp)) && (this.pAV.objData.eqp.en)) && (this.entityMC)))
                    {
                        this.entityMC.onMove = true;
                        if (((MainController.hasLabel(actionLabel, this.entityMC)) && (!(this.entityMC.currentLabel == actionLabel))))
                        {
                            this.entityMC.gotoAndPlay(actionLabel);
                        };
                    };
                    this.updateColor();
                };
                this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
                this.addEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
            }
            else
            {
                this.recoverAnimation();
            };
        }

        override public function stopWalking():void
        {
            if (this.mcChar.onMove)
            {
                this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
                if (((this.pAV.isMyAvatar) && (this.world.actionReady)))
                {
                    this.world.combatAction(this.world.getAutoAttack());
                    if (this.pAV.npcType == "npc")
                    {
                        return;
                    };
                };
                this.mcChar.onMove = false;
            };
            var actionLabel:String = ((this.walkSpeed > 23) ? "Fight" : ((this.isFlying) ? "Flyidle" : "Idle"));
            var targetMC:* = (((this.pAV.objData.eqp.en) && (this.entityMC)) ? this.entityMC : this.mcChar);
            if (((this.entityMC) && (this.pAV.objData.eqp.en)))
            {
                this.entityMC.onMove = false;
            };
            if (MainController.hasLabel(actionLabel, targetMC))
            {
                targetMC.gotoAndPlay(actionLabel);
            };
            this.recoverAnimation();
            this.updateColor();
        }

        override public function turn(position:String):void
        {
            if ((((position == "right") && (this.mcChar.scaleX < 0)) || ((position == "left") && (this.mcChar.scaleX > 0))))
            {
                this.mcChar.scaleX = (this.mcChar.scaleX * -1);
            };
            if (((((!(this.pAV.objData == null)) && (!(this.pAV.objData.eqp.en == null))) && (!(this.entityMC == null))) && (((position == "right") && (this.entityMC.scaleX < 0)) || ((position == "left") && (this.entityMC.scaleX > 0)))))
            {
                this.entityMC.scaleX = (this.entityMC.scaleX * -1);
            };
            if (this.pAV.npcType == "npc")
            {
                this.mcChar.x = ((position == "left") ? 10 : 0);
            };
            this.strFace = position;
        }

        override public function fClose():void
        {
            var KEY_PREFIX:String = this.pAV.LOADER_KEY_PREFIX;
            if (this.pAV != null)
            {
                this.unloadPet();
                if (this.pAV == this.world.myAvatar)
                {
                    this.world.setTarget(null);
                }
                else
                {
                    this.pAV.target = null;
                };
                this.pAV.pMC = null;
                this.pAV = null;
            };
            this.mcChar.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.pname.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
            this.removeEventListener(Event.ENTER_FRAME, this.checkQueue);
            if (this.world.CHARS.contains(this))
            {
                this.world.CHARS.removeChild(this);
            };
            if (this.world.TRASH.contains(this))
            {
                this.world.TRASH.removeChild(this);
            };
            var healIcon:DisplayObject = getChildByName("HealIconMC");
            if (healIcon != null)
            {
                HealIconMC(healIcon).fClose();
            };
            Game.root.onRemoveChildrens(this.fx);
            LoadController.singleton.clearLoader((KEY_PREFIX + "weapon"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "weaponoff"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "he"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "ba"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "ar"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "co"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "pe"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "mi"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "en"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "title"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "hair"));
            LoadController.singleton.clearLoader((KEY_PREFIX + "asset"));
        }

        public function loadWeapon(file:String):void
        {
            this.weaponLoad = false;
            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + "weapon"), this.onLoadWeaponComplete);
        }

        public function onLoadWeaponComplete(event:Event):MovieClip
        {
            var cls:Class;
            this.weaponLoad = true;
            this.characterLoad();
            var item:Object = this.pAV.getItemByEquipSlot("Weapon");
            if (this.mcChar.weaponFist.numChildren > 0)
            {
                this.mcChar.weaponFist.removeChildAt(0);
            };
            if (this.mcChar.weaponFistOff.numChildren > 0)
            {
                this.mcChar.weaponFistOff.removeChildAt(0);
            };
            if (this.mcChar.weapon.numChildren > 0)
            {
                this.mcChar.weapon.removeChildAt(0);
            };
            if (this.mcChar.fronthand.numChildren > 1)
            {
                this.mcChar.fronthand.removeChildAt(1);
            };
            if (this.mcChar.backhand.numChildren > 1)
            {
                this.mcChar.backhand.removeChildAt(1);
            };
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.Weapon.sLink))
            {
                cls = Class(this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.Weapon.sLink));
                switch (item.sType)
                {
                    case "Gauntlet":
                        this.mcChar.fronthand.addChildAt(new (cls)(), 1);
                        this.mcChar.fronthand.getChildAt(1).scaleX = 0.8;
                        this.mcChar.fronthand.getChildAt(1).scaleY = 0.8;
                        this.mcChar.fronthand.getChildAt(1).scaleX = (this.mcChar.fronthand.getChildAt(1).scaleX * -1);
                        this.mcChar.backhand.addChildAt(new (cls)(), 1);
                        this.mcChar.backhand.getChildAt(1).scaleX = 0.8;
                        this.mcChar.backhand.getChildAt(1).scaleY = 0.8;
                        this.mcChar.backhand.getChildAt(1).scaleX = (this.mcChar.backhand.getChildAt(1).scaleX * -1);
                        this.mcChar.weapon.mcWeapon = new MovieClip();
                        break;
                    default:
                        this.mcChar.weapon.mcWeapon = new (cls)();
                        this.mcChar.weapon.addChild(this.mcChar.weapon.mcWeapon);
                        this.setItemData(this.mcChar.weapon.mcWeapon);
                };
            }
            else
            {
                if (item.sType != "Gauntlet")
                {
                    this.mcChar.weapon.mcWeapon = MovieClip(event.target.content);
                    this.mcChar.weapon.addChild(this.mcChar.weapon.mcWeapon);
                    this.setItemData(this.mcChar.weapon.mcWeapon);
                };
            };
            this.mcChar.weapon.visible = false;
            this.mcChar.weaponOff.visible = false;
            this.mcChar.weaponFist.visible = false;
            this.mcChar.weaponFistOff.visible = false;
            if (item.sType != "Gauntlet")
            {
                this.mcChar.weapon.visible = true;
            };
            if (item.sType == "Dagger")
            {
                this.weaponLoad = false;
                this.pAV.addLoad(pAV.objData.eqp.Weapon.sFile, (this.pAV.LOADER_KEY_PREFIX + "weaponoff"), this.onLoadWeaponOffComplete);
            };
            this.disableAnimations();
            this.updateColor();
        }

        public function onLoadWeaponOffComplete(event:Event):void
        {
            this.weaponLoad = true;
            this.characterLoad();
            this.mcChar.weaponOff.removeChildAt(0);
            this.mcChar.weaponOff.addChild(((this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.Weapon.sLink)) ? new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.Weapon.sLink))() : event.target.content));
            this.mcChar.weaponOff.visible = true;
            this.setItemData(this.mcChar.weaponOff);
            this.disableAnimations();
            this.updateColor();
        }

        public function loadHair():void
        {
            var file:String = this.pAV.objData.strHairFilename;
            if ((((file == null) || (file == "")) || (file == "none")))
            {
                this.mcChar.head.hair.visible = false;
                return;
            };
            this.hairLoad = false;
            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + "hair"), this.onHairLoadComplete);
        }

        public function loadHelm(file:String):void
        {
            this.helmLoad = false;
            this.bLoadingHelm = true;
            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + "he"), this.onLoadHelmComplete);
        }

        public function onHairLoadComplete(event:Event):void
        {
            if (this.isHelmLoaded)
            {
                return;
            };
            this.hairLoad = true;
            this.characterLoad();
            if (this.pAV.applicationDomain.hasDefinition(((this.pAV.objData.strHairName + this.pAV.objData.strGender) + "Hair")))
            {
                if (this.mcChar.head.hair.numChildren > 0)
                {
                    this.mcChar.head.hair.removeChildAt(0);
                };
                this.mcChar.head.hair.addChild(new (this.pAV.applicationDomain.getDefinition(((this.pAV.objData.strHairName + this.pAV.objData.strGender) + "Hair")))());
                this.mcChar.head.hair.visible = true;
            }
            else
            {
                this.mcChar.head.hair.visible = false;
            };
            if (this.pAV.applicationDomain.hasDefinition(((this.pAV.objData.strHairName + this.pAV.objData.strGender) + "HairBack")))
            {
                if (this.mcChar.backhair.numChildren > 0)
                {
                    this.mcChar.backhair.removeChildAt(0);
                };
                this.mcChar.backhair.addChild(new (this.pAV.applicationDomain.getDefinition(((this.pAV.objData.strHairName + this.pAV.objData.strGender) + "HairBack")))());
                this.mcChar.backhair.visible = true;
                this.bBackHair = true;
            }
            else
            {
                this.mcChar.backhair.visible = false;
                this.bBackHair = false;
            };
            if (((((!(this.world == null)) && (this.pAV.isMyAvatar)) && (!(MovieClip(parent.parent.parent).ui.mcPortrait.visible))) && (!(this.bLoadingHelm))))
            {
                this.world.rootClass.showPortrait(this.pAV);
            };
            if ((("he" in this.pAV.objData.eqp) && (!(this.pAV.objData.eqp.he == null))))
            {
                this.mcChar.head.hair.visible = (!(this.pAV.dataLeaf.showHelm));
            };
        }

        public function onLoadHelmComplete(event:Event):void
        {
            var clsBack:Class;
            this.isHelmLoaded = true;
            this.helmLoad = true;
            this.characterLoad();
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.he.sLink))
            {
                if (this.mcChar.head.helm.numChildren > 0)
                {
                    this.mcChar.head.helm.removeChildAt(0);
                };
                this.mcChar.head.helm.visible = this.pAV.dataLeaf.showHelm;
                this.mcChar.head.hair.visible = (!(this.mcChar.head.helm.visible));
                clsBack = null;
                if (this.pAV.applicationDomain.hasDefinition((this.pAV.objData.eqp.he.sLink + "_backhair")))
                {
                    clsBack = Class(this.pAV.applicationDomain.getDefinition((this.pAV.objData.eqp.he.sLink + "_backhair")));
                }
                else
                {
                    if (this.pAV.applicationDomain.hasDefinition((this.pAV.objData.eqp.he.sLink + "Back")))
                    {
                        clsBack = Class(this.pAV.applicationDomain.getDefinition((this.pAV.objData.eqp.he.sLink + "Back")));
                    };
                };
                if (clsBack == null)
                {
                    this.mcChar.backhair.visible = ((this.mcChar.head.hair.visible) && (this.bBackHair));
                }
                else
                {
                    if (this.pAV.dataLeaf.showHelm)
                    {
                        if (this.mcChar.backhair.numChildren > 0)
                        {
                            this.mcChar.backhair.removeChildAt(0);
                        };
                        this.mcChar.backhair.visible = true;
                        this.mcChar.backhair.addChild(new (clsBack)());
                    };
                };
                this.mcChar.head.helm.addChild(new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.he.sLink))());
                this.setItemData(this.mcChar.head.helm);
                this.updatePortrait();
                this.updateColor();
            };
            this.bLoadingHelm = false;
            this.disableAnimations();
        }

        public function loadCape(file:String):void
        {
            this.capeLoad = false;
            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + "ba"), this.onLoadCapeComplete);
        }

        public function onLoadCapeComplete(_arg1:Event):void
        {
            this.capeLoad = true;
            this.characterLoad();
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.ba.sLink))
            {
                this.mcChar.cape.removeChildAt(0);
                this.mcChar.cape.cape = new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.ba.sLink))();
                this.mcChar.cape.addChild(this.mcChar.cape.cape);
                this.setCloakVisibility(this.pAV.dataLeaf.showCloak);
                this.setItemData(this.mcChar.cape.cape);
                this.disableAnimations();
                this.updateColor();
            };
        }

        public function loadClass(file:String):void
        {
            if (this.pAV.objData.eqp.co == null)
            {
                this.classLoad = false;
                this.pAV.addLoad(((("classes/" + this.strGender) + "/") + file), (this.pAV.LOADER_KEY_PREFIX + "ar"), this.onLoadClassComplete);
            };
        }

        public function onLoadClassComplete(_arg1:Event):void
        {
            this.classLoad = true;
            this.characterLoad();
            if (this.pAV.objData.eqp.co == null)
            {
                this.loadArmorPieces(this.pAV.objData.eqp.ar.sLink);
            };
        }

        public function loadArmor(file:String, linkage:String):void
        {
            this.objLinks.co = linkage;
            this.armorLoad = false;
            this.pAV.addLoad(((("classes/" + this.strGender) + "/") + file), (this.pAV.LOADER_KEY_PREFIX + "co"), this.onLoadArmorComplete);
        }

        public function onLoadArmorComplete(_arg1:Event):void
        {
            this.armorLoad = true;
            this.characterLoad();
            this.loadArmorPieces(this.objLinks.co);
            if ((((this.name == "previewMCB") && (!(parent == null))) && (parent.parent is LPFFrameItemPreview)))
            {
                LPFFrameItemPreview(parent.parent).preview.repositionPreview(this.mcChar);
            };
        }

        public function loadArmorPieces(linkage:String, applicationDomain:ApplicationDomain=null):void
        {
            if (applicationDomain == null)
            {
                applicationDomain = this.pAV.applicationDomain;
            };
            if (AvatarUtil.build(applicationDomain, this.mcChar.head, ((linkage + this.strGender) + "Head")) == null)
            {
                AvatarUtil.build(applicationDomain, this.mcChar.head, ("mcHead" + this.strGender));
            };
            this.updatePortrait();
            AvatarUtil.build(applicationDomain, this.mcChar.chest, ((linkage + this.strGender) + "Chest"));
            AvatarUtil.build(applicationDomain, this.mcChar.hip, ((linkage + this.strGender) + "Hip"));
            AvatarUtil.build(applicationDomain, this.mcChar.idlefoot, ((linkage + this.strGender) + "FootIdle"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontfoot, ((linkage + this.strGender) + "Foot"));
            this.mcChar.frontfoot.visible = false;
            AvatarUtil.build(applicationDomain, this.mcChar.backfoot, ((linkage + this.strGender) + "Foot"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontshoulder, ((linkage + this.strGender) + "Shoulder"));
            AvatarUtil.build(applicationDomain, this.mcChar.backshoulder, ((linkage + this.strGender) + "Shoulder"));
            AvatarUtil.build(applicationDomain, this.mcChar.fronthand, ((linkage + this.strGender) + "Hand"));
            AvatarUtil.build(applicationDomain, this.mcChar.backhand, ((linkage + this.strGender) + "Hand"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontthigh, ((linkage + this.strGender) + "Thigh"));
            AvatarUtil.build(applicationDomain, this.mcChar.backthigh, ((linkage + this.strGender) + "Thigh"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontshin, ((linkage + this.strGender) + "Shin"));
            AvatarUtil.build(applicationDomain, this.mcChar.backshin, ((linkage + this.strGender) + "Shin"));
            if (AvatarUtil.build(applicationDomain, this.mcChar.robe, ((linkage + this.strGender) + "Robe")) == null)
            {
                this.mcChar.robe.getChildAt(0).visible = false;
            };
            if (AvatarUtil.build(applicationDomain, this.mcChar.backrobe, ((linkage + this.strGender) + "RobeBack")) == null)
            {
                this.mcChar.backrobe.getChildAt(0).visible = false;
            };
            if (this.pAV.applicationDomain.hasDefinition(((linkage + this.strGender) + "Ground")))
            {
                this.shadow.removeChildAt(0);
                this.shadow.addChild(new (this.pAV.applicationDomain.getDefinition(((linkage + this.strGender) + "Ground")))());
                this.shadow.visible = true;
                this.shadow.scaleX = 0.7;
                this.shadow.scaleY = 0.7;
                this.shadow.scaleX = (this.shadow.scaleX * -1);
            }
            else
            {
                if (((Game.root.assetsDomain) && (Game.root.assetsDomain.hasDefinition("mcShadow"))))
                {
                    this.shadow.removeChildAt(0);
                    this.shadow.addChild(new (Game.root.assetsDomain.getDefinition("mcShadow"))());
                    this.shadow.scaleX = 1;
                    this.shadow.scaleY = 1;
                };
            };
            this.gotoAndPlay("in1");
            this.clearAnimEvents();
            this.isLoaded = true;
            this.disableAnimations();
            this.updateColor();
        }

        private function get doLoadPet():Boolean
        {
            return ((this.pAV.isMyAvatar) ? Game.root.uoPref.bPet : (!(Game.root.userPreference.data.hideOtherPets)));
        }

        public function loadPet():void
        {
            if (((((((this.doLoadPet) && (!(this.pAV.objData == null))) && (!(this.pAV.objData.eqp == null))) && (!(this.pAV.objData.eqp.pe == null))) && (!(this.world == null))) && (this.world.CHARS.contains(this.pAV.pMC))))
            {
                this.pAV.addLoad(this.pAV.objData.eqp.pe.sFile, (this.pAV.LOADER_KEY_PREFIX + "pe"), this.onLoadPetComplete, this.onLoadPetError);
            };
        }

        public function loadCharacterPagePet():void
        {
            if (((((this.doLoadPet) && (!(this.pAV.objData == null))) && (!(this.pAV.objData.eqp == null))) && (!(this.pAV.objData.eqp.pe == null))))
            {
                this.pAV.addLoad(this.pAV.objData.eqp.pe.sFile, (this.pAV.LOADER_KEY_PREFIX + "pe"), this.onCharacterPagePetLoadComplete, this.onLoadPetError);
            };
        }

        private function petMovieClip():void
        {
            if (this.pAV.petMC == null)
            {
                this.pAV.petMC = new PetMC();
                this.pAV.petMC.mouseEnabled = (this.pAV.petMC.mouseChildren = false);
                this.pAV.petMC.game = Game.root;
                this.pAV.petMC.pAV = this.pAV;
            };
        }

        public function onLoadPetComplete(_arg1:Event):void
        {
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.pe.sLink))
            {
                this.petMovieClip();
                this.pAV.petMC.removeChildAt(1);
                this.pAV.petMC.mcChar = MovieClip(this.pAV.petMC.addChildAt(new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.pe.sLink))(), 1));
                this.pAV.petMC.mcChar.name = "mc";
                this.setItemData(this.pAV.petMC.mcChar);
                if (this.world.uoTree[this.pAV.objData.strUsername.toLowerCase()].strFrame == this.world.strFrame)
                {
                    if (((this.pAV.petMC.stage == null) && (this.pAV.petMC.getChildByName("defaultmc") == null)))
                    {
                        MovieClip(this.world.CHARS.addChild(this.pAV.petMC)).name = ("pet_" + this.pAV.uid);
                    };
                    this.pAV.petMC.scale(this.pAV.pMC.mcChar.scaleY);
                    this.pAV.petMC.x = (this.pAV.pMC.x - 20);
                    this.pAV.petMC.y = (this.pAV.pMC.y + 5);
                    this.setItemData(this.pAV.petMC.mcChar);
                    this.disableAnimations();
                    this.updateColor();
                };
            };
        }

        public function onCharacterPagePetLoadComplete(_arg1:Event):void
        {
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.pe.sLink))
            {
                this.petMovieClip();
                this.pAV.petMC.removeChildAt(1);
                this.pAV.petMC.mcChar = MovieClip(this.pAV.petMC.addChildAt(new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.pe.sLink))(), 1));
                this.pAV.petMC.mcChar.name = "mc";
                this.pAV.pMC.addChildAt(this.pAV.petMC, 0);
                this.pAV.petMC.scale((this.mcChar.scaleY / 1.5));
                this.pAV.petMC.x = 100;
                this.pAV.petMC.y = -30;
                this.setItemData(this.pAV.petMC.mcChar);
            };
        }

        private function onLoadPetError(event:Event):void
        {
            this.unloadPet();
        }

        public function unloadPet():void
        {
            if (this.pAV.petMC == null)
            {
                return;
            };
            if (((!(this.pAV.petMC.stage == null)) && (Game.root.world.CHARS.contains(this.pAV.petMC))))
            {
                Game.root.world.CHARS.removeChild(this.pAV.petMC);
            };
            if (((this.pAV.petMC == null) || (this.pAV.petMC.mcChar == null)))
            {
                this.pAV.petMC = null;
                return;
            };
            if (((!(this.pAV.petMC.mcChar == null)) && (!(this.pAV.petMC.mcChar.parent == null))))
            {
                this.pAV.petMC.mcChar.parent.removeChild(this.pAV.petMC.mcChar);
                this.pAV.petMC = null;
            };
            this.pAV.petMC = null;
        }

        public function loadMisc(file:String):void
        {
            this.miscLoad = false;
            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + "mi"), this.onLoadMiscComplete);
        }

        public function onLoadMiscComplete(event:Event):void
        {
            this.miscLoad = true;
            if (!this.pAV.dataLeaf.showRune)
            {
                return;
            };
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.mi.sLink))
            {
                this.cShadow.visible = true;
                if (this.cShadow.numChildren > 0)
                {
                    this.cShadow.removeChildAt(0);
                };
                this.cShadow.addChild(new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.mi.sLink))());
                this.cShadow.scaleX = this.mcChar.scaleX;
                this.cShadow.scaleY = this.mcChar.scaleY;
                this.cShadow.mouseChildren = false;
                this.cShadow.mouseEnabled = false;
                this.shadow.visible = false;
                this.setGroundVisibility(this.pAV.dataLeaf.showRune);
                this.disableAnimations();
                this.updateColor();
                return;
            };
            this.cShadow.visible = false;
            this.shadow.visible = true;
        }

        public function loadEntity(file:String, linkage:String):void
        {
            this.bLoadingEntity = true;
            this.entityLoad = false;
            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + "en"), this.onLoadEntityComplete);
        }

        public function onLoadEntityComplete(_arg1:Event):void
        {
            var npcTreeNode:Object;
            this.entityLoad = true;
            this.characterLoad();
            if ((((Game.root.userPreference.data.hideOtherEntities) && (!(this.pAV.npcType == "npc"))) && (!(this.pAV.isMyAvatar))))
            {
                return;
            };
            if ((((Game.root.userPreference.data.hideAllPlayer) && (!(this.pAV.npcType == "npc"))) && (!(this.pAV.isMyAvatar))))
            {
                return;
            };
            if (((Game.root.userPreference.data.hideAllNpc) && (this.pAV.npcType == "npc")))
            {
                return;
            };
            if (((!(this.pAV.dataLeaf.showEntity)) && (this.pAV.isMyAvatar)))
            {
                this.mcChar.visible = true;
                return;
            };
            if ((((!(this.pAV.dataLeaf.showEntity)) && (!(this.pAV.isMyAvatar))) && (!(this.pAV.npcType == "npc"))))
            {
                this.mcChar.visible = (!(Game.root.userPreference.data.hideAllPlayer));
                return;
            };
            if (this.entityMC != null)
            {
                this.entityMC.parent.removeChild(this.entityMC);
            };
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.eqp.en.sLink))
            {
                this.entityMC = MovieClip(addChildAt(new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.eqp.en.sLink))(), 2));
                this.entityMC.addEventListener(MouseEvent.CLICK, this.onClickHandler);
                this.entityMC.buttonMode = true;
                this.mcChar.visible = false;
                this.scale(((this.world == null) ? 1 : this.world.SCALE));
                this.updatePortrait();
                this.turn(this.strFace);
                if (this.pAV.npcType == "npc")
                {
                    this.gotoAndPlay("in1");
                    npcTreeNode = this.world.npcTree[this.pAV.objData.NpcMapID];
                    if (((!(npcTreeNode == null)) && (this.world.rootClass.frameCheck(this.entityMC, npcTreeNode.intState))))
                    {
                        this.entityMC.gotoAndStop(((npcTreeNode.intState) ? "Idle" : "Dead"));
                    };
                };
                this.bLoadingEntity = false;
                this.updateColor();
            };
        }

        public function updatePortrait():void
        {
            if (((!(this.world == null)) && (!(this.name == "previewMCB"))))
            {
                if (this.pAV == this.world.myAvatar)
                {
                    this.world.rootClass.showPortrait(this.pAV);
                };
                if (this.pAV == this.world.myAvatar.target)
                {
                    this.world.rootClass.showPortraitTarget(this.pAV);
                };
            };
        }

        public function loadTitle(file:String, linkage:String):void
        {
            this.titleLoad = false;
            this.objLinks.title = linkage;
            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + "title"), this.onLoadTitleComplete);
        }

        public function onLoadTitleComplete(event:Event):void
        {
            this.titleLoad = true;
            if (((Game.root.userPreference.data.hideOtherTitles) && (!(this.pAV.myAvatar))))
            {
                return;
            };
            if (!this.pAV.dataLeaf.showTitle)
            {
                return;
            };
            if (this.pAV.applicationDomain.hasDefinition(this.pAV.objData.title.Link))
            {
                this.pname.title.addChild(new (this.pAV.applicationDomain.getDefinition(this.pAV.objData.title.Link))());
            };
        }

        public function disablePNameMouse():void
        {
            mouseEnabled = false;
            this.pname.mouseEnabled = false;
            this.pname.mouseChildren = false;
            this.pname.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        }

        public function showHPBar():void
        {
            this.hpBar.y = (this.pname.y - 5);
            this.hpBar.visible = true;
            this.updateHPBar();
        }

        public function hideHPBar():void
        {
            this.hpBar.visible = false;
        }

        public function updateHPBar():void
        {
            var _local3:Object;
            var _local1:MovieClip = (this.hpBar.g as MovieClip);
            var _local2:MovieClip = (this.hpBar.r as MovieClip);
            if (this.hpBar.visible)
            {
                _local3 = this.pAV.dataLeaf;
                if (((!(_local3 == null)) && (!(_local3.intHP == null))))
                {
                    _local1.visible = true;
                    _local1.width = Math.round(((_local3.intHP / _local3.intHPMax) * _local2.width));
                    if (_local3.intHP < 1)
                    {
                        _local1.visible = false;
                    };
                };
            };
        }

        public function showVending():void
        {
            this.mcVending.visible = true;
            this.mcVending.addEventListener(MouseEvent.CLICK, this.onLoadVending);
        }

        public function hideVending():void
        {
            this.mcVending.visible = false;
            this.mcVending.removeEventListener(MouseEvent.CLICK, this.onLoadVending);
        }

        public function updateName():void
        {
            var uoLeaf:Object;
            var access:Number;
            var alliance:Object;
            if (this.pAV.pnm == null)
            {
                return;
            };
            this.pname.Alliance.visible = false;
            if (this.pname.VIP)
            {
                this.pname.VIP.visible = false;
            };
            if (this.pname.Ambassador)
            {
                this.pname.Ambassador.visible = false;
            };
            if (this.pname.Founder)
            {
                this.pname.Founder.visible = false;
            };
            if (this.world != null)
            {
                uoLeaf = this.world.uoTree[this.pAV.pnm.toLowerCase()];
                if (uoLeaf.vend)
                {
                    this.showVending();
                }
                else
                {
                    this.hideVending();
                };
                if (((uoLeaf.fly) && (!(this.isFlying))))
                {
                    this.fly();
                    this.isFlying = true;
                    this.mcChar.cloud.visible = true;
                }
                else
                {
                    if (((!(uoLeaf.fly)) && (this.isFlying)))
                    {
                        this.land();
                        this.isFlying = false;
                        this.mcChar.cloud.visible = false;
                    };
                };
            };
            if (this.pAV.objData != null)
            {
                if (this.pAV.objData.title != null)
                {
                    if (this.pAV.objData.title.File == "")
                    {
                        this.pname.tl.text = (("[ " + String(this.pAV.objData.title.Name).toUpperCase()) + " ]");
                        this.pname.tl.textColor = this.pAV.objData.title.Color;
                    }
                    else
                    {
                        this.pname.tl.text = "";
                    };
                };
                this.pname.ti.text = String(this.pAV.objData.strUsername).toUpperCase();
                this.pname.filters = NAME_GLOW;
                if (this.pAV.objData.intColorName == 1)
                {
                    access = Number(this.pAV.objData.intAccessLevel);
                    if (access >= 60)
                    {
                        this.pname.ti.textColor = 12283391;
                    }
                    else
                    {
                        if (access >= 42)
                        {
                            this.pname.ti.textColor = 12283391;
                        }
                        else
                        {
                            if (access >= 40)
                            {
                                this.pname.ti.textColor = 16698168;
                            }
                            else
                            {
                                if (access >= 3)
                                {
                                    this.pname.ti.textColor = 52881;
                                }
                                else
                                {
                                    if (this.pAV.isUpgraded())
                                    {
                                        this.pname.ti.textColor = 9229823;
                                    };
                                };
                            };
                        };
                    };
                }
                else
                {
                    this.pname.ti.textColor = this.pAV.objData.intColorName;
                };
                this.afk.visible = uoLeaf.afk;
                if (uoLeaf.afk)
                {
                    this.pname.ti.text = ("<AFK> " + this.pAV.objData.strUsername);
                }
                else
                {
                    this.pname.ti.text = this.pAV.objData.strUsername;
                };
                if (this.pAV.objData.guild != null)
                {
                    this.pname.tg.text = (("< " + String(this.pAV.objData.guild.Name).toUpperCase()) + " >");
                    this.pname.tg.textColor = this.pAV.objData.guild.Color;
                    if (this.pAV.objData.guild.alliances != null)
                    {
                        for each (alliance in this.pAV.objData.guild.alliances)
                        {
                            if (alliance.Alliance.Name.toLowerCase() == this.pAV.objData.guild.Name.toLowerCase())
                            {
                                pname.Alliance.visible = true;
                            };
                        };
                    };
                };
            };
            if (((!(this.world == null)) && (this.pAV == this.world.myAvatar)))
            {
                this.world.rootClass.discord.update("status");
            };
        }

        public function setHelmVisibility(isVisible:Boolean):void
        {
            if ((((!(this.pAV.objData == null)) && (!(this.pAV.objData.eqp.he == null))) && (!(this.pAV.objData.eqp.he.sLink == null))))
            {
                if (isVisible)
                {
                    this.mcChar.head.helm.visible = true;
                    this.mcChar.head.hair.visible = false;
                    this.mcChar.backhair.visible = false;
                }
                else
                {
                    this.mcChar.head.helm.visible = false;
                    this.mcChar.head.hair.visible = true;
                    this.mcChar.backhair.visible = this.bBackHair;
                };
                this.updatePortrait();
            };
        }

        public function setPetVisibility(isVisible:Boolean):void
        {
            if (isVisible)
            {
                this.loadPet();
            }
            else
            {
                this.unloadPet();
            };
        }

        public function setTitleVisibility(isVisible:Boolean):void
        {
            Game.root.onRemoveChildrens(this.pname.title);
            if (((!(this.pAV.objData == null)) && (!(this.pAV.objData.title == null))))
            {
                if (isVisible)
                {
                    if (this.pAV.objData.title.Link != "")
                    {
                        this.loadTitle(this.pAV.objData.title.File, this.pAV.objData.title.Link);
                        return;
                    };
                    this.pname.tl.visible = true;
                }
                else
                {
                    this.pname.tl.visible = false;
                };
            };
        }

        public function setUsernameVisibility(isVisible:Boolean):void
        {
            this.pname.ti.visible = (!(isVisible));
        }

        public function setGuildVisibility(isVisible:Boolean):void
        {
            this.pname.tg.visible = (!(isVisible));
        }

        public function setGroundVisibility(isVisible:Boolean):void
        {
            if ((((!(this.pAV.objData == null)) && (!(this.pAV.objData.eqp.mi == null))) && (!(this.pAV.objData.eqp.mi.sLink == null))))
            {
                if (((isVisible) && (this.cShadow.numChildren == 0)))
                {
                    this.loadMisc(this.pAV.objData.eqp.mi.sFile);
                }
                else
                {
                    if (((!(isVisible)) && (this.cShadow.numChildren > 0)))
                    {
                        Game.root.onRemoveChildrens(this.cShadow);
                    };
                };
                this.shadow.visible = (!(isVisible));
            };
        }

        public function setCloakVisibility(isVisible:Boolean):void
        {
            if ((((!(this.pAV.objData == null)) && (!(this.pAV.objData.eqp.ba == null))) && (!(this.pAV.objData.eqp.ba.sLink == null))))
            {
                this.mcChar.cape.visible = isVisible;
            };
        }

        public function setEntityVisibility(isVisible:Boolean):void
        {
            if ((((!(this.pAV.objData == null)) && (!(this.pAV.objData.eqp.en == null))) && (!(this.pAV.objData.eqp.en.sLink == null))))
            {
                if (isVisible)
                {
                    this.loadEntity(this.pAV.objData.eqp.en.sFile, this.pAV.objData.eqp.en.sLink);
                    this.scaleEntity();
                }
                else
                {
                    if (this.entityMC != null)
                    {
                        this.entityMC.parent.removeChild(this.entityMC);
                        this.entityMC = null;
                        this.scale(this.world.SCALE);
                    };
                };
                if (((this.pAV.isMyAvatar) || ((!(Game.root.userPreference.data.hideAllPlayer)) && (!(this.pAV.isMyAvatar)))))
                {
                    this.mcChar.visible = (!(isVisible));
                };
            };
        }

        public function setColor(part:MovieClip, idk:String, location:String, shade:String):void
        {
            var color:Number = Number(this.pAV.objData[("intColor" + location)]);
            part.isColored = true;
            part.intColor = color;
            part.strLocation = location;
            part.strShade = shade;
            AvatarUtil.changeColor(part, color, shade);
        }

        public function updateColor(data:Object=null):void
        {
            var uiPortrait:ui_213;
            var uiPortraitTarget:ui_244;
            var avatarData:Object = ((data) || (this.pAV.objData));
            this.scanColor(this, avatarData);
            AvatarColor.scanColorSpecial(avatarData, this);
            if (((!(this.world == null)) && (this.world.rootClass.isGameLabel)))
            {
                if (this.pAV != null)
                {
                    uiPortrait = this.world.rootClass.ui.mcPortrait;
                    if (uiPortrait.pAV == this.pAV)
                    {
                        this.scanColor(uiPortrait.mcHead, avatarData);
                        AvatarColor.scanColorSpecial(avatarData, uiPortrait.mcHead);
                        AvatarColor.scanColorSpecial(avatarData, uiPortrait.mcHead);
                    };
                    uiPortraitTarget = this.world.rootClass.ui.mcPortraitTarget;
                    if (uiPortraitTarget.pAV == this.pAV)
                    {
                        this.scanColor(uiPortraitTarget.mcHead, avatarData);
                        AvatarColor.scanColorSpecial(avatarData, uiPortraitTarget.mcHead);
                    };
                };
            };
        }

        public function clearQueue():void
        {
            this.animQueue = [];
        }

        public function simulateTo(_arg1:int, _arg2:int, _arg3:int):Point
        {
            this.xDep = this.x;
            this.yDep = this.y;
            this.xTar = _arg1;
            this.yTar = _arg2;
            this.walkSpeed = _arg3;
            this.nDuration = Math.round((Math.sqrt((Math.pow((this.xTar - this.x), 2) + Math.pow((this.yTar - this.y), 2))) / _arg3));
            var _local4:* = new Point();
            if (this.nDuration)
            {
                this.nXStep = 0;
                this.nYStep = 0;
                if (!this.mcChar.onMove)
                {
                    this.mcChar.onMove = true;
                };
                if (((!(this.pAV.objData.eqp.en == null)) && (!(this.entityMC == null))))
                {
                    this.entityMC.onMove = true;
                };
                _local4 = this.simulateWalkLoop();
            }
            else
            {
                _local4 = null;
            };
            this.x = this.xDep;
            this.y = this.yDep;
            this.mcChar.onMove = false;
            if (((!(this.pAV.objData.eqp.en == null)) && (!(this.entityMC == null))))
            {
                this.entityMC.onMove = false;
            };
            return (_local4);
        }

        public function recoverAnimation():void
        {
            var animation:*;
            if (this.pAV.npcType == "npc")
            {
                animation = ((isNaN(this.pAV.objData.animation)) ? ((this.world.rootClass.world.rootClass.frameCheck(this.mcChar, this.pAV.objData.animation)) ? this.pAV.objData.animation : "Idle") : this.pAV.objData.animation);
                if ((this.pAV.objData.state == "Play"))
                {
                    this.mcChar.gotoAndPlay(animation);
                }
                else
                {
                    this.mcChar.gotoAndStop(animation);
                };
                this.turn(this.pAV.objData.face.toLowerCase());
            };
        }

        public function checkPadLabels():void
        {
            var _local4:*;
            var _local5:*;
            var _local3:int;
            while (_local3 < this.world.rootClass.ui.mcPadNames.numChildren)
            {
                _local4 = MovieClip(this.world.rootClass.ui.mcPadNames.getChildAt(_local3));
                _local5 = new Point(4, 8);
                _local5 = _local4.cnt.localToGlobal(_local5);
                if (this.world.rootClass.distanceO(this, _local5) < 200)
                {
                    if (!_local4.isOn)
                    {
                        _local4.isOn = true;
                        _local4.gotoAndPlay("in");
                    };
                }
                else
                {
                    if (_local4.isOn)
                    {
                        _local4.isOn = false;
                        _local4.gotoAndPlay("out");
                    };
                };
                _local3++;
            };
        }

        public function scale(scale:Number):void
        {
            var charScale:Number = ((this.pAV.dataLeaf.isAdopted) ? (scale * 0.85) : scale);
            this.mcChar.scaleX = ((this.mcChar.scaleX >= 0) ? charScale : -(charScale));
            this.mcChar.scaleY = charScale;
            this.shadow.scaleX = (this.shadow.scaleY = charScale);
            this.cShadow.scaleX = (this.cShadow.scaleY = charScale);
            var ltg:Point = this.globalToLocal(this.mcChar.localToGlobal(this.headPoint));
            this.mcVending.y = (int(ltg.y) - 13);
            this.pname.y = int(ltg.y);
            this.bubble.y = int((this.pname.y - this.bubble.height));
            this.ignore.y = int(((this.pname.y - this.ignore.height) + 28));
            this.afk.y = int(((this.pname.y - this.ignore.height) + 58));
            this.drawHitBox();
            this.scaleEntity();
            if (this.apopbutton != null)
            {
                this.apopbutton.y = int((this.pname.y - this.apopbutton.height));
            };
        }

        public function scaleEntity():void
        {
            if (this.entityMC == null)
            {
                return;
            };
            try
            {
                this.entityMC.gotoAndPlay("Idle");
            }
            catch(error:Error)
            {
                trace(error.getStackTrace());
            };
            var scale:Number = ((this.world == null) ? Game.SCALE : this.world.SCALE);
            var charScale:Number = ((this.pAV.dataLeaf.isAdopted) ? (scale * 0.85) : scale);
            this.entityMC.scaleX = ((this.entityMC.scaleX >= 0) ? charScale : -(charScale));
            this.entityMC.scaleY = charScale;
            var points:Point = this.globalToLocal(this.entityMC.localToGlobal(new Point(0, -(this.entityMC.height))));
            this.pname.y = int(points.y);
            this.bubble.y = int((this.pname.y - this.bubble.height));
            if (this.pname.y > -100)
            {
                this.pname.y = (int(points.y) + -100);
            };
            if (this.apopbutton != null)
            {
                this.apopbutton.y = (this.pname.y - 30);
            };
            if (parent != null)
            {
                if (((parent.parent.name == "npcLeft") || (parent.parent.name == "npcRight")))
                {
                    this.y = (-(points.y) + 60);
                    if (this.entityMC.height <= 50)
                    {
                        this.entityMC.scaleY = (this.entityMC.scaleX = (this.entityMC.scaleX * 3.5));
                    };
                };
            };
            if ((((Game.root.userPreference.data["disableOtherPlayerAnimation"]) && (this.pAV.npcType == "player")) && (!(this.pAV.isMyAvatar))))
            {
                Game.movieClipStopAll(this.entityMC);
            };
            if (((Game.root.userPreference.data["disableNPCsAnimation"]) && (this.pAV.npcType == "npc")))
            {
                Game.movieClipStopAll(this.entityMC);
            };
        }

        public function endAction():void
        {
            var targetMC:MovieClip;
            var currentMC:MovieClip;
            var eqpWeapon:Object;
            var sType:String;
            if (this.pAV == null)
            {
                return;
            };
            if (!this.checkQueue(null))
            {
                targetMC = (((!(this.pAV.target == null)) && (this.pAV.target.pMC)) ? this.pAV.target.pMC.mcChar : null);
                currentMC = ((this.entityMC == null) ? this.mcChar : this.entityMC);
                if (currentMC.onMove)
                {
                    if (currentMC.currentLabel != "Walk")
                    {
                        currentMC.gotoAndPlay("Walk");
                    };
                    this.turn((((x - xTar) < 0) ? "right" : "left"));
                }
                else
                {
                    if (((targetMC == null) || ((((!(targetMC.currentLabel == "Die")) && (!(targetMC.currentLabel == "Feign"))) && (!(targetMC.currentLabel == "Dead"))) && ((!(this.pAV.target.npcType == "player")) || ((!("pvpTeam" in this.pAV.dataLeaf)) || (this.pAV.dataLeaf.pvpTeam == this.pAV.target.dataLeaf.pvpTeam))))))
                    {
                        currentMC.gotoAndPlay("Idle");
                        if (((((!(this.world == null)) && (!(targetMC == null))) && (this.pAV == this.world.myAvatar)) && (this.pAV.target.dataLeaf.intState == 0)))
                        {
                            this.world.setTarget(null);
                        };
                    }
                    else
                    {
                        eqpWeapon = this.pAV.getItemByEquipSlot("Weapon");
                        sType = ((eqpWeapon.sName.toLowerCase().indexOf("unarmed") > -1) ? "Unarmed" : eqpWeapon.sType);
                        switch (sType)
                        {
                            case "Bow":
                                if (MainController.hasLabel("RangedFight", currentMC))
                                {
                                    currentMC.gotoAndPlay("RangedFight");
                                };
                                break;
                            case "Rifle":
                                if (MainController.hasLabel("RifleFight", currentMC))
                                {
                                    currentMC.gotoAndPlay("RifleFight");
                                };
                                break;
                            case "Gauntlet":
                            case "Unarmed":
                                if (MainController.hasLabel("UnarmedFight", currentMC))
                                {
                                    currentMC.gotoAndPlay("UnarmedFight");
                                };
                                break;
                            case "Polearm":
                                if (MainController.hasLabel("PolearmFight", currentMC))
                                {
                                    currentMC.gotoAndPlay("PolearmFight");
                                };
                                break;
                            case "Dagger":
                                if (MainController.hasLabel("DuelWield/DaggerFight", currentMC))
                                {
                                    currentMC.gotoAndPlay("DuelWield/DaggerFight");
                                };
                                break;
                            default:
                                if (MainController.hasLabel("Fight", currentMC))
                                {
                                    currentMC.gotoAndPlay("Fight");
                                };
                        };
                    };
                };
            };
        }

        public function showHealIcon():void
        {
            var healIcon:HealIconMC;
            if (!getChildByName("HealIconMC"))
            {
                healIcon = new HealIconMC(this.pAV);
                healIcon.name = "HealIconMC";
                addChild(healIcon);
            };
        }

        public function iaF(_arg1:Object):void
        {
            var _local2:MovieClip = (this.mcChar.head.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.chest.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.hip.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.idlefoot.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.frontfoot.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e)
                {
                };
            };
            _local2 = (this.mcChar.backfoot.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.frontshoulder.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.backshoulder.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.fronthand.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.backhand.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.frontthigh.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.backthigh.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.frontshin.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.backshin.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.robe.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
            _local2 = (this.mcChar.backrobe.getChildAt(0) as MovieClip);
            if (_local2 != null)
            {
                try
                {
                    _local2.iaF(_arg1);
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
        }

        public function playSound():void
        {
        }

        public function addAnimationListener(_arg1:String, _arg2:Function):void
        {
            if (this.animEvents[_arg1] == null)
            {
                this.animEvents[_arg1] = [];
            };
            if (!this.hasAnimationListener(_arg1, _arg2))
            {
                this.animEvents[_arg1].push(_arg2);
            };
        }

        public function removeAnimationListener(_arg1:String, _arg2:Function):void
        {
            var _local3:uint;
            if (this.animEvents[_arg1] == null)
            {
                return;
            };
            while (_local3 < this.animEvents[_arg1].length)
            {
                if (this.animEvents[_arg1][_local3] == _arg2)
                {
                    this.animEvents[_arg1].splice(_local3, 1);
                    return;
                };
                _local3++;
            };
        }

        public function hasAnimationListener(_arg1:String, _arg2:Function):Boolean
        {
            var _local3:uint;
            if (this.animEvents[_arg1] == null)
            {
                return (false);
            };
            while (_local3 < this.animEvents[_arg1].length)
            {
                if (this.animEvents[_arg1][_local3] == _arg2)
                {
                    return (true);
                };
                _local3++;
            };
            return (false);
        }

        public function setItemData(movieClip:MovieClip):void
        {
            if (movieClip.hasOwnProperty("setData"))
            {
                movieClip.setData(this);
            };
        }

        public function performAttack(movieClip:MovieClip):void
        {
            var i:int;
            for (;i < 4;i++)
            {
                if (movieClip.hasOwnProperty("bAttack"))
                {
                    movieClip.gotoAndPlay("Attack");
                }
                else
                {
                    if (((movieClip.numChildren > 0) && (movieClip.getChildAt(0) is MovieClip)))
                    {
                        movieClip = MovieClip(movieClip.getChildAt(0));
                        i++;
                        continue;
                    };
                };
                return;
            };
        }

        public function handleAttack(equipment:String):void
        {
            var item:Object;
            var part:MovieClip;
            var parts:Array;
            var frame:Object;
            if (equipment == "Weapon")
            {
                item = pAV.getItemByEquipSlot(equipment);
                if (item.sType == "Gauntlet")
                {
                    parts = [MovieClip(this.mcChar.fronthand.getChildAt(1)).getChildAt(1), MovieClip(this.mcChar.backhand.getChildAt(1)).getChildAt(0)];
                    for each (part in parts)
                    {
                        this.performAttack(part);
                    };
                    return;
                };
                if (item.sType == "Dagger")
                {
                    parts = [this.mcChar.weapon.mcWeapon, this.mcChar.weaponOff];
                    if (this.mcChar.weapon.mcWeapon.numChildren > 1)
                    {
                        parts = [MovieClip(this.mcChar.weapon.mcWeapon).getChildAt(1), MovieClip(this.mcChar.weaponOff).getChildAt(0)];
                    };
                    for each (part in parts)
                    {
                        this.performAttack(part);
                    };
                    return;
                };
                this.performAttack(this.mcChar.weapon.mcWeapon);
            };
            var i:int;
            while (i < this.attackFrames.length)
            {
                frame = this.attackFrames[i];
                if (!frame)
                {
                    this.attackFrames.splice(i, 1);
                    i--;
                }
                else
                {
                    if ((frame is MovieClip))
                    {
                        MovieClip(frame).gotoAndPlay("Attack");
                    };
                };
                i++;
            };
        }

        private function frameStop():void
        {
            stop();
        }

        private function frame1():void
        {
            this.mcChar.transform.colorTransform = AvatarMC.CT1;
            this.mcChar.alpha = 0;
            stop();
        }

        private function frame5():void
        {
            this.mcChar.transform.colorTransform = AvatarMC.CT1;
            this.mcChar.alpha = 0;
        }

        private function frame10():void
        {
            this.mcChar.alpha = 0;
        }

        private function frame12():void
        {
            this.mcChar.transform.colorTransform = AvatarMC.CT3;
        }

        private function frame13():void
        {
            this.mcChar.transform.colorTransform = AvatarMC.CT2;
        }

        private function frameCT1():void
        {
            this.mcChar.transform.colorTransform = AvatarMC.CT1;
        }

        private function characterLoad():void
        {
            if ((((this.pAV) && (this.pAV.isMyAvatar)) && (this.pAV.FirstLoad)))
            {
                this.pAV.updateLoaded();
                if (this.pAV.LoadCount <= 0)
                {
                    this.pAV.firstDone();
                };
            };
        }

        private function hideOptionalParts():void
        {
            var key:String;
            for (key in AvatarMC.parts)
            {
                if (typeof(this.mcChar[AvatarMC.parts[key]]) != undefined)
                {
                    this.mcChar[AvatarMC.parts[key]].visible = false;
                };
            };
            for (key in AvatarMC.weapons)
            {
                if (typeof(this.mcChar[AvatarMC.weapons[key]]) != undefined)
                {
                    this.mcChar[AvatarMC.weapons[key]].visible = false;
                };
            };
        }

        private function scanColor(target:MovieClip, avatarData:Object):void
        {
            var displayObject:DisplayObject;
            if ((("isColored" in target) && (target["isColored"])))
            {
                AvatarUtil.changeColor(target, Number(avatarData[("intColor" + target.strLocation)]), target.strShade);
            };
            var i:int;
            while (i < target.numChildren)
            {
                displayObject = target.getChildAt(i);
                if ((displayObject is MovieClip))
                {
                    this.scanColor(MovieClip(displayObject), avatarData);
                };
                i++;
            };
        }

        public function isInCollision():Boolean
        {
            var solid:Object;
            var solids:Array = this.world.arrSolid;
            for each (solid in solids)
            {
                if (this.shadow.hitTestObject(solid.shadow))
                {
                    return (true);
                };
            };
            return (false);
        }

        private function simulateWalkLoop():Point
        {
            var _local1:*;
            var _local2:*;
            var _local3:Boolean;
            var _local4:*;
            var _local5:*;
            var _local6:*;
            var _local7:*;
            while ((((this.nXStep <= this.nDuration) || (this.nYStep <= this.nDuration)) && (this.mcChar.onMove)))
            {
                _local1 = this.x;
                _local2 = this.y;
                this.x = MainController.linearTween(this.nXStep, this.xDep, (this.xTar - this.xDep), this.nDuration);
                this.y = MainController.linearTween(this.nYStep, this.yDep, (this.yTar - this.yDep), this.nDuration);
                _local3 = false;
                _local4 = 0;
                while (_local4 < this.world.arrSolid.length)
                {
                    if (this.shadow.hitTestObject(this.world.arrSolid[_local4].shadow))
                    {
                        _local3 = true;
                        _local4 = this.world.arrSolid.length;
                    };
                    _local4++;
                };
                if (((_local3) && (!(this.isFlying))))
                {
                    _local5 = this.y;
                    this.y = _local2;
                    _local3 = false;
                    _local6 = 0;
                    while (_local6 < this.world.arrSolid.length)
                    {
                        if (this.shadow.hitTestObject(this.world.arrSolid[_local6].shadow))
                        {
                            this.y = _local5;
                            _local3 = true;
                            break;
                        };
                        _local6++;
                    };
                    if (_local3)
                    {
                        this.x = _local1;
                        _local3 = false;
                        _local7 = 0;
                        while (_local7 < this.world.arrSolid.length)
                        {
                            if (this.shadow.hitTestObject(this.world.arrSolid[_local7].shadow))
                            {
                                _local3 = true;
                                break;
                            };
                            _local7++;
                        };
                        if (_local3)
                        {
                            this.x = _local1;
                            this.y = _local2;
                            this.mcChar.onMove = false;
                            if (((!(this.pAV.objData.eqp.en == null)) && (!(this.entityMC == null))))
                            {
                                this.entityMC.onMove = false;
                            };
                            this.nDuration = -1;
                            return (new Point(this.x, this.y));
                        };
                        if (this.nYStep <= this.nDuration)
                        {
                            this.nYStep++;
                        };
                    }
                    else
                    {
                        if (this.nXStep <= this.nDuration)
                        {
                            this.nXStep++;
                        };
                    };
                }
                else
                {
                    if (this.nXStep <= this.nDuration)
                    {
                        this.nXStep++;
                    };
                    if (this.nYStep <= this.nDuration)
                    {
                        this.nYStep++;
                    };
                };
                if ((((Math.round(_local1) == Math.round(this.x)) && (Math.round(_local2) == Math.round(this.y))) && ((this.nXStep > 1) || (this.nYStep > 1))))
                {
                    this.mcChar.onMove = false;
                    if (((!(this.pAV.objData.eqp.en == null)) && (!(this.entityMC == null))))
                    {
                        this.entityMC.onMove = false;
                    };
                    this.nDuration = -1;
                    return (new Point(this.x, this.y));
                };
            };
            this.mcChar.onMove = false;
            if (((!(this.pAV.objData.eqp.en == null)) && (!(this.entityMC == null))))
            {
                this.entityMC.onMove = false;
            };
            this.nDuration = -1;
            return (new Point(this.x, this.y));
        }

        private function drawHitBox():void
        {
            this.mcChar.hitbox.graphics.clear();
            var _local1:int = -30;
            var _local2:int = 60;
            var _local3:int = this.mcChar.head.y;
            var _local4:int = (-(_local3) * 0.8);
            this.hitboxR = new Rectangle(_local1, _local3, _local2, _local4);
            var _local5:Graphics = this.mcChar.hitbox.graphics;
            _local5.lineStyle(0, 0xFFFFFF, 0);
            _local5.beginFill(0xAA00FF, 0);
            _local5.moveTo(_local1, _local3);
            _local5.lineTo((_local1 + _local2), _local3);
            _local5.lineTo((_local1 + _local2), (_local3 + _local4));
            _local5.lineTo(_local1, (_local3 + _local4));
            _local5.lineTo(_local1, _local3);
            _local5.endFill();
        }

        private function handleAnimEvent(_arg1:String):void
        {
            var _local2:Function;
            var _local3:uint;
            if (this.animEvents[_arg1] == null)
            {
                return;
            };
            while (_local3 < this.animEvents[_arg1].length)
            {
                _local2 = this.animEvents[_arg1][_local3];
                (_local2());
                _local3++;
            };
        }

        public function ioErrorHandler(_arg1:IOErrorEvent):void
        {
        }

        public function fly():void
        {
            this.mcChar.gotoAndPlay("Groundtofly");
        }

        public function land():void
        {
            this.mcChar.gotoAndPlay("Flytoground");
        }

        public function onLoadVending(e:MouseEvent):void
        {
            this.world.rootClass.toggleAuction(this.pAV.objData.strUsername);
        }

        private function onClickHandler(mouseEvent:MouseEvent):void
        {
            var Animations:Array;
            if (((this.pAV.npcType == "npc") || (this.pAV.npcType == "npc_apop")))
            {
                return;
            };
            if (((this.world == null) || (!(this.world.CHARS.contains(this)))))
            {
                Animations = ["Wave", "Stern", "Salute", "Salute2", "Backflip", "Laugh"];
                this.mcChar.gotoAndPlay(Animations[Math.floor((Math.random() * Animations.length))]);
                return;
            };
            var avatar:Avatar = mouseEvent.currentTarget.parent.pAV;
            if (mouseEvent.shiftKey)
            {
                this.world.onWalkClick();
            }
            else
            {
                if (!mouseEvent.ctrlKey)
                {
                    if (((((!(avatar == this.world.myAvatar)) && (this.world.bPvP)) && (!(avatar.dataLeaf.pvpTeam == this.world.myAvatar.dataLeaf.pvpTeam))) && (avatar == this.world.myAvatar.target)))
                    {
                        this.world.approachTarget();
                    }
                    else
                    {
                        if (((!(this.world.myAvatar.target == avatar)) && (this.world.bPK)))
                        {
                            this.world.setTarget(avatar);
                        }
                        else
                        {
                            if ((((this.world.bPK) && (this.world.myAvatar.target == avatar)) && (!(avatar == this.world.myAvatar))))
                            {
                                this.world.approachTarget();
                            }
                            else
                            {
                                if (avatar != this.world.myAvatar.target)
                                {
                                    this.world.setTarget(avatar);
                                };
                            };
                        };
                    };
                };
            };
        }

        private function checkQueue(_arg1:Event):Boolean
        {
            var eqp:*;
            if (this.animQueue.length > 0)
            {
                if (((!(AvatarUtil.combatAnims[this.mcChar.currentLabel] == undefined)) && (this.mcChar.currentFrame > (this.mcChar.emoteLoopFrame() + 4))))
                {
                    this.mcChar.gotoAndPlay(this.animQueue[0]);
                    if (((pAV.dataLeaf.intState == 2) && (!(pAV.objData.eqp == null))))
                    {
                        for (eqp in pAV.objData.eqp)
                        {
                            this.handleAttack(eqp);
                        };
                    };
                    this.animQueue.shift();
                    return (true);
                };
            };
            return (false);
        }

        private function onEnterFrameWalk(event:Event):void
        {
            var xPoint:Number;
            var yPoint:Number;
            var shadowHit:Boolean;
            var numSolids:int;
            var shadow:DisplayObject;
            var i:int;
            var newY:Number;
            var j:int;
            var k:int;
            var arrEventLength:int;
            var l:int;
            var eventTriggered:Boolean;
            var displayObject:MovieClip;
            var localPos:Point;
            var eventBounds:Rectangle;
            var time:Number = new Date().getTime();
            var timeWalkTS:Number = ((time - this.walkTS) / this.walkD);
            if (timeWalkTS > 1)
            {
                timeWalkTS = 1;
            };
            if (((Point.distance(this.op, this.tp) > 0.5) && (this.mcChar.onMove)))
            {
                xPoint = this.x;
                yPoint = this.y;
                this.x = Point.interpolate(this.tp, this.op, timeWalkTS).x;
                this.y = Point.interpolate(this.tp, this.op, timeWalkTS).y;
                shadowHit = false;
                numSolids = this.world.arrSolid.length;
                shadow = this.shadow;
                if (!this.isFlying)
                {
                    i = 0;
                    while (i < numSolids)
                    {
                        if (shadow.hitTestObject(this.world.arrSolid[i].shadow))
                        {
                            shadowHit = true;
                            break;
                        };
                        i++;
                    };
                    if (shadowHit)
                    {
                        newY = this.y;
                        this.y = yPoint;
                        shadowHit = false;
                        j = 0;
                        while (j < numSolids)
                        {
                            if (shadow.hitTestObject(this.world.arrSolid[j].shadow))
                            {
                                this.y = newY;
                                shadowHit = true;
                                break;
                            };
                            j++;
                        };
                        if (shadowHit)
                        {
                            this.x = xPoint;
                            shadowHit = false;
                            k = 0;
                            while (k < numSolids)
                            {
                                if (shadow.hitTestObject(this.world.arrSolid[k].shadow))
                                {
                                    shadowHit = true;
                                    break;
                                };
                                k++;
                            };
                            if (shadowHit)
                            {
                                this.x = xPoint;
                                this.y = yPoint;
                                this.stopWalking();
                            };
                        };
                    };
                };
                if ((((Math.round(xPoint) == Math.round(this.x)) && (Math.round(yPoint) == Math.round(this.y))) && (time > (this.walkTS + 50))))
                {
                    this.stopWalking();
                };
                if (this.pAV.isMyAvatar)
                {
                    this.checkPadLabels();
                    arrEventLength = this.world.arrEvent.length;
                    this.world.mapScrollCheck();
                    l = 0;
                    while (l < arrEventLength)
                    {
                        eventTriggered = false;
                        displayObject = this.world.arrEvent[l];
                        if (displayObject == null)
                        {
                        }
                        else
                        {
                            if (this.world.bPvP)
                            {
                                localPos = shadow.localToGlobal(new Point(0, 0));
                                eventBounds = displayObject.shadow.getBounds(stage);
                                if (eventBounds.containsPoint(localPos))
                                {
                                    eventTriggered = true;
                                };
                            }
                            else
                            {
                                if (shadow.hitTestObject(displayObject.shadow))
                                {
                                    eventTriggered = true;
                                };
                            };
                            if (eventTriggered)
                            {
                                if (((!(displayObject._entered)) && (MovieClip(displayObject).isEvent)))
                                {
                                    displayObject._entered = true;
                                    displayObject.dispatchEvent(new Event("enter"));
                                };
                            }
                            else
                            {
                                if (displayObject._entered)
                                {
                                    displayObject._entered = false;
                                };
                            };
                        };
                        l++;
                    };
                };
            };
        }

        public function disableAnimations():*
        {
            if (((((Game.root.userPreference.data["disableOtherPlayerAnimation"]) && (!(this.pAV == null))) && (this.pAV.npcType == "player")) && (!(this.pAV.isMyAvatar))))
            {
                if (this.pAV.objData == null)
                {
                    return;
                };
                if (((!(this.pAV.objData.eqp.pe == null)) && (this.pAV.petMC)))
                {
                    Game.movieClipStopAll(this.pAV.petMC.mcChar);
                };
                if (this.pAV.objData.eqp.mi != null)
                {
                    Game.movieClipStopAll(this.cShadow);
                };
                if (((!(this.pAV.objData.eqp.co == null)) || (!(this.pAV.objData.eqp.ar == null))))
                {
                    Game.movieClipStopAll(this.mcChar);
                };
            };
            if ((((Game.root.userPreference.data["disableNPCsAnimation"]) && (!(this.pAV == null))) && ((this.pAV.npcType == "npc") || (this.pAV.npcType == "npc_apop"))))
            {
                if (((!(this.pAV.objData.eqp.pe == null)) && (this.pAV.petMC)))
                {
                    Game.movieClipStopAll(this.pAV.petMC.mcChar);
                };
                if (this.pAV.objData.eqp.mi != null)
                {
                    Game.movieClipStopAll(this.cShadow);
                };
                if (((!(this.pAV.objData.eqp.co == null)) || (!(this.pAV.objData.eqp.ar == null))))
                {
                    Game.movieClipStopAll(this.mcChar);
                };
            };
        }


    }
}//package 

