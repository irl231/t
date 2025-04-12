// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Avatar.AvatarUtil

package Main.Avatar
{
    import flash.geom.ColorTransform;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.system.ApplicationDomain;
    import flash.display.MovieClip;
    import Main.UI.AbstractPortrait;
    import flash.geom.*;

    public class AvatarUtil 
    {

        public static const playerLabels:Array = ["Ready", "Idle", "mountWalk", "horseWalk", "throneWalk", "Walk", "Dance", "Laugh", "Point", "Use", "Stern", "SternLoop", "Salute", "Cheer", "Facepalm", "Airguitar", "Backflip", "Sleep", "Jump", "Punt", "Dance2", "Swordplay", "Feign", "Dead", "Wave", "Bow", "Rest", "Cry", "Unsheath", "Fight", "WhipAttack", "GunAttack", "RifleAttack", "Attack1", "Attack2", "Attack3", "Attack4", "Hit", "Knockout", "Getup", "Stab", "Thrash", "Castgood", "Cast1", "Cast2", "Cast3", "Sword/ShieldFight", "Sword/ShieldAttack1", "Sword/ShieldAttack2", "ShieldBlock", "DuelWield/DaggerFight", "DuelWield/DaggerAttack1", "DuelWield/DaggerAttack2", "FistweaponFight", "FistweaponAttack1", "FistweaponAttack2", "PolearmFight", "PolearmAttack1", "PolearmAttack2", "RangedFight", "RangedAttack1", "RangedAttack2", "UnarmedFight", "UnarmedAttack1", "UnarmedAttack2", "KickAttack", "FlipAttack", "Dodge", "Powerup", "Kneel", "Jumpcheer", "Salute2", "Cry2", "Spar", "Samba", "Stepdance", "Headbang", "Dazed", "Psychic1", "Psychic2", "Danceweapon", "Useweapon", "Throw", "FireBreath", "RifleAttack2", "RifleFight", "GunAttack2", "RangedAttack3", "Casting", "Fishing", "Mining", "Hex", "Firejump", "Firewings", "Headscratch", "Shock", "Castmagic", "Dab", "Groundtofly", "Flyidle", "Flywalk", "Flytoground", "Facepalm2", "Fall", "Relax", "Toss", "Hold", "Spin", "Hop", "Idea", "Pant"];
        public static const combatAnims:Array = ["Attack1", "Attack2", "Attack3", "Attack4", "Hit", "Knockout", "Getup", "Stab", "Thrash", "Castgood", "Cast1", "Cast2", "Cast3", "Sword/ShieldFight", "Sword/ShieldAttack1", "Sword/ShieldAttack2", "ShieldBlock", "DuelWield/DaggerFight", "DuelWield/DaggerAttack1", "DuelWield/DaggerAttack2", "FistweaponFight", "FistweaponAttack1", "FistweaponAttack2", "PolearmFight", "PolearmAttack1", "PolearmAttack2", "RangedFight", "RangedAttack1", "UnarmedFight", "UnarmedAttack1", "UnarmedAttack2", "KickAttack", "FlipAttack", "Dodge", "Firejump", "Firewings"];
        public static const staticAnims:Array = ["Fall", "Knockout", "Die"];


        public static function changeColor(part:DisplayObject, color:Number, shade:String, invert:String=""):void
        {
            var colorTransform:ColorTransform = new ColorTransform();
            if (invert == "")
            {
                colorTransform.color = color;
            };
            switch (shade.toUpperCase())
            {
                case "LIGHT":
                    colorTransform.redOffset = (colorTransform.redOffset + 100);
                    colorTransform.greenOffset = (colorTransform.greenOffset + 100);
                    colorTransform.blueOffset = (colorTransform.blueOffset + 100);
                    break;
                case "DARK":
                    colorTransform.redOffset = (colorTransform.redOffset - 25);
                    colorTransform.greenOffset = (colorTransform.greenOffset - 50);
                    colorTransform.blueOffset = (colorTransform.blueOffset - 50);
                    break;
                case "DARKER":
                    colorTransform.redOffset = (colorTransform.redOffset - 125);
                    colorTransform.greenOffset = (colorTransform.greenOffset - 125);
                    colorTransform.blueOffset = (colorTransform.blueOffset - 125);
                    break;
            };
            if (invert == "-")
            {
                colorTransform.redOffset = (colorTransform.redOffset * -1);
                colorTransform.greenOffset = (colorTransform.greenOffset * -1);
                colorTransform.blueOffset = (colorTransform.blueOffset * -1);
            };
            if (((invert == "") || (!(part.transform.colorTransform.redOffset == colorTransform.redOffset))))
            {
                part.transform.colorTransform = colorTransform;
            };
        }

        public static function createAvatar(npc_type:String, place:Sprite, data:Object, scale:Number=2.5):AvatarMC
        {
            var avatarMC:AvatarMC = AvatarUtil.buildAvatar(npc_type, place, new Avatar(Game.root), data, new AvatarMC());
            if (scale != 0)
            {
                avatarMC.scale(scale);
            };
            return (avatarMC);
        }

        public static function buildAvatar(npc_type:String, place:Sprite, avatar:Avatar, data:Object, avatarMC:AvatarMC):AvatarMC
        {
            if (place != null)
            {
                place.addChild(avatarMC);
            };
            avatarMC.x = data.X;
            avatarMC.y = data.Y;
            avatarMC.name = "previewMCB";
            if (avatarMC.isLoaded)
            {
                avatarMC.gotoAndPlay("in2");
                return (avatarMC);
            };
            avatarMC.gotoAndPlay("hold");
            avatar.isMyAvatar = false;
            avatar.pMC = avatarMC;
            avatar.objData = data;
            avatar.dataLeaf.showRune = true;
            avatar.dataLeaf.showTitle = true;
            avatar.dataLeaf.showEntity = true;
            avatar.dataLeaf.showCloak = true;
            avatar.dataLeaf.showHelm = (!(data.eqp.he == null));
            avatar.dataLeaf.isAdopted = data.isAdopted;
            avatarMC.world = Game.root.world;
            avatarMC.pAV = avatar;
            avatarMC.strGender = data.strGender;
            avatarMC.hideHPBar();
            avatar.npcType = npc_type;
            avatar.initAvatar({"data":data});
            AvatarMC(avatar.pMC).loadCharacterPagePet();
            return (avatarMC);
        }

        public static function buildAvatarPreview(applicationDomain:ApplicationDomain, linkage:String):AvatarMC
        {
            var avatarMC:AvatarMC = new AvatarMC();
            avatarMC.strGender = Game.root.world.myAvatar.objData.strGender;
            avatarMC.pAV = Game.root.world.myAvatar;
            avatarMC.world = Game.root.world;
            avatarMC.hideHPBar();
            avatarMC.name = "previewMCB";
            avatarMC.loadArmorPieces(linkage, applicationDomain);
            return (avatarMC);
        }

        public static function build(applicationDomain:ApplicationDomain, place:MovieClip, linkage:String):DisplayObject
        {
            if (applicationDomain.hasDefinition(linkage))
            {
                place.removeChildAt(0);
                place.addChildAt(new (Class(applicationDomain.getDefinition(linkage)))(), 0);
                place.visible = true;
                return (place.getChildAt(0));
            };
            place.visible = false;
            return (null);
        }

        private static function buildPortrait(place:MovieClip, linkage:String="", name:String=null):MovieClip
        {
            var displayObject:DisplayObject;
            var child:DisplayObject;
            var cls:Class = Game.root.world.getClass(linkage);
            if (cls != null)
            {
                displayObject = new (cls)();
                if (name)
                {
                    child = place.getChildByName(name);
                    if (child != null)
                    {
                        place.removeChild(child);
                    };
                    displayObject.name = name;
                };
                place.addChildAt(displayObject, 0);
                place.visible = true;
                return (place);
            };
            place.visible = false;
            return (null);
        }

        public static function showPortraitBox(avatar:Avatar, mcPortraitBox:AbstractPortrait):void
        {
            var linkage:String;
            var head:MovieClip;
            mcPortraitBox.pAV = avatar;
            var entity:Boolean = ((avatar.npcType == "monster") || (!(avatar.objData.eqp.en == null)));
            if (entity)
            {
                mcPortraitBox.mcHead.head.hair.visible = false;
                mcPortraitBox.mcHead.head.helm.visible = false;
                mcPortraitBox.mcHead.backhair.visible = false;
                AvatarUtil.buildPortrait(mcPortraitBox.mcHead.head, ("mcHead" + ((avatar.objData.eqp == undefined) ? avatar.objData.strLinkage : avatar.objData.eqp.en.sLink)), "face");
            }
            else
            {
                if (((!(avatar.objData.eqp.ar == null)) || (!(avatar.objData.eqp.co == null))))
                {
                    linkage = ((avatar.objData.eqp.co == null) ? avatar.objData.eqp.ar.sLink : avatar.objData.eqp.co.sLink);
                    head = AvatarUtil.buildPortrait(mcPortraitBox.mcHead.head, ((linkage + avatar.objData.strGender) + "Head"), "face");
                    if (head == null)
                    {
                        AvatarUtil.buildPortrait(mcPortraitBox.mcHead.head, ("mcHead" + avatar.objData.strGender), "face");
                    };
                };
                Game.root.onRemoveChildrens(mcPortraitBox.mcHead.head.hair);
                AvatarUtil.buildPortrait(mcPortraitBox.mcHead.head.hair, ((avatar.objData.strHairName + avatar.objData.strGender) + "Hair"), "Hair");
                Game.root.onRemoveChildrens(mcPortraitBox.mcHead.backhair);
                AvatarUtil.buildPortrait(mcPortraitBox.mcHead.backhair, ((avatar.objData.strHairName + avatar.objData.strGender) + "HairBack"), "HairBack");
                Game.root.onRemoveChildrens(mcPortraitBox.mcHead.head.helm);
                if (((avatar.dataLeaf.showHelm) && (!(avatar.objData.eqp.he == null))))
                {
                    if (AvatarUtil.buildPortrait(mcPortraitBox.mcHead.head.helm, avatar.objData.eqp.he.sLink))
                    {
                        mcPortraitBox.mcHead.head.hair.visible = (!(mcPortraitBox.mcHead.head.helm.visible));
                    };
                    if (!AvatarUtil.buildPortrait(mcPortraitBox.mcHead.backhair, (avatar.objData.eqp.he.sLink + "_backhair"), "HelmHairBack"))
                    {
                        mcPortraitBox.mcHead.backhair.visible = ((mcPortraitBox.mcHead.head.hair.visible) && (mcPortraitBox.mcHead.backhair.visible));
                    }
                    else
                    {
                        if (mcPortraitBox.mcHead.backhair.numChildren > 1)
                        {
                            mcPortraitBox.mcHead.backhair.removeChildAt(1);
                        };
                    };
                };
                avatar.pMC.updateColor();
            };
            mcPortraitBox.visible = true;
        }


    }
}//package Main.Avatar

