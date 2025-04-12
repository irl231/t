// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Option.SkillSetMC

package Main.Option
{
    import flash.display.MovieClip;
    import Main.Model.Skill;
    import flash.display.*;

    public class SkillSetMC extends MovieClip 
    {

        public var game:Game = Game.root;
        public var aa:MovieClip;
        public var a1:MovieClip;
        public var a2:MovieClip;
        public var a3:MovieClip;
        public var a4:MovieClip;
        public var i1:MovieClip;


        public function update():*
        {
            var actionSlot:String;
            var actionLabel:String;
            var actionSlotMC:MovieClip;
            var skill:Skill;
            var abilityNames:Array = [{
                "reference":"aa",
                "label":"Auto Attack"
            }, {
                "reference":"a1",
                "label":"Skill 1"
            }, {
                "reference":"a2",
                "label":"Skill 2"
            }, {
                "reference":"a3",
                "label":"Skill 3"
            }, {
                "reference":"a4",
                "label":"Skill 4"
            }, {
                "reference":"i1",
                "label":"Item"
            }];
            var i:int;
            while (i < abilityNames.length)
            {
                actionSlot = abilityNames[i].reference;
                actionLabel = abilityNames[i].label;
                actionSlotMC = getChildByName(actionSlot);
                skill = this.game.world.getActionByRef(actionSlot);
                actionSlotMC.mcSkill.tQty.visible = false;
                actionSlotMC.mcSkill.cnt.visible = false;
                actionSlotMC.set({"strName":actionLabel});
                if (skill)
                {
                    actionSlotMC.mcSkill.cnt.visible = true;
                    this.game.updateIcons([actionSlotMC.mcSkill], skill.icon.split(","), null);
                }
                else
                {
                    this.game.updateIcons([actionSlotMC.mcSkill], ["icu1"], null);
                };
                i++;
            };
        }


    }
}//package Main.Option

