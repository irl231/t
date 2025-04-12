// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//dummyMC

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class dummyMC extends MovieClip 
    {

        public var idlefoot:MovieClip;
        public var chest:MovieClip;
        public var frontthigh:MovieClip;
        public var cape:MovieClip;
        public var frontshoulder:MovieClip;
        public var head:MovieClip;
        public var backshoulder:MovieClip;
        public var hip:MovieClip;
        public var backthigh:MovieClip;
        public var backhair:MovieClip;
        public var backshin:MovieClip;
        public var robe:MovieClip;
        public var weapon:MovieClip;
        public var frontshin:MovieClip;
        public var backfoot:MovieClip;
        public var backrobe:MovieClip;
        public var frontfoot:MovieClip;
        public var backhand:MovieClip;
        public var fronthand:MovieClip;
        public var AssetClass:*;
        public var spellFX:*;
        public var avtMC:*;
        public var rootClass:Game;
        public var rand:int;
        public var strSpell:String;
        public var spells:Array = ["sp_ea2", "sp_ea3", "sp_ed1", "sp_ee1", "sp_ee2", "sp_ef2", "sp_ef3", "sp_ef5", "sp_eh2", "sp_ei3", "sp_el2", "sp_ice2", "sp_sp1"];

        public function dummyMC():void
        {
            this.avtMC = MovieClip(parent);
            this.rootClass = this.avtMC.pAV.rootClass;
            addFrameScript(0, this.frame1, 14, this.frame15, 19, this.frame20, 31, this.frame32, 40, this.frame41, 47, this.frame48, 59, this.frame60, 72, this.frame73, 84, this.frame85, 96, this.frame97, 111, this.frame112, 127, this.frame128, 136, this.frame137, 150, this.frame151);
        }

        public function showIdleFoot():void
        {
            this.frontfoot.visible = false;
            this.idlefoot.visible = true;
        }

        public function showFrontFoot():void
        {
            this.idlefoot.visible = false;
            this.frontfoot.visible = true;
        }

        private function spell(spell:String, spell2:String):void
        {
            this.AssetClass = (this.rootClass.world.getClass(spell) as Class);
            if (this.AssetClass != null)
            {
                this.spellFX = new this.AssetClass();
                this.spellFX.spellDur = 0;
                this.rootClass.world.CHARS.addChild(this.spellFX);
                this.spellFX.mouseEnabled = false;
                this.spellFX.mouseChildren = false;
                this.spellFX.visible = true;
                this.spellFX.world = this.rootClass.world;
                this.spellFX.strl = spell2;
                this.spellFX.tMC = this.avtMC.pAV.target.pMC;
                this.spellFX.x = this.spellFX.tMC.x;
                this.spellFX.y = (this.spellFX.tMC.y + 3);
                if (this.spellFX.tMC.x < this.avtMC.x)
                {
                    this.spellFX.scaleX = (this.spellFX.scaleX * -1);
                };
            };
        }

        private function spellFX1():void
        {
            this.rand = Math.round((Math.random() * 11));
            if (((this.rand > 0) && (this.rand < 4)))
            {
                this.spell(("sp_chaos" + this.rand), "sp_chaos1");
            };
        }

        private function spellFX2():void
        {
            this.strSpell = this.spells[Math.round((Math.random() * (this.spells.length - 1)))];
            this.spell(this.strSpell, this.strSpell);
        }

        private function frame1():void
        {
            this.showIdleFoot();
            stop();
        }

        private function frame15():void
        {
            stop();
        }

        private function frame20():void
        {
            if (this.onMove)
            {
                gotoAndPlay("Walk");
            };
        }

        private function frame32():void
        {
            this.spellFX1();
        }

        private function frame41():void
        {
            stop();
        }

        private function frame48():void
        {
            this.spellFX1();
        }

        private function frame60():void
        {
            stop();
        }

        private function frame73():void
        {
            this.spellFX2();
        }

        private function frame85():void
        {
            stop();
        }

        private function frame97():void
        {
            this.spellFX2();
        }

        private function frame112():void
        {
            stop();
        }

        private function frame128():void
        {
            stop();
        }

        private function frame137():void
        {
            stop();
        }

        private function frame151():void
        {
            stop();
        }


    }
}//package 

