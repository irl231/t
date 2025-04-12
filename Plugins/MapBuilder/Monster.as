// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.Monster

package Plugins.MapBuilder
{
    public dynamic class Monster extends AbstractPad 
    {

        public var isGenerated:Boolean = false;
        public var MonMapID:int;
        public var strDir:String;
        public var intScale:Number;
        public var noMove:Boolean;

        public function Monster(data:Object)
        {
            this.isMonster = true;
            super(data);
            if (((data) && (this.parameters is Array)))
            {
                this.strDir = ((this.parameters.length > 0) ? this.parameters[0] : null);
                this.MonMapID = ((this.parameters.length > 1) ? int(this.parameters[1]) : 0);
                this.intScale = ((this.parameters.length > 2) ? Number(this.parameters[2]) : 1);
                this.noMove = ((this.parameters.length > 3) ? (Number(this.parameters[3]) == 1) : 0);
            }
            else
            {
                this.strDir = null;
                this.MonMapID = 0;
                this.intScale = 1;
                this.noMove = false;
            };
        }

    }
}//package Plugins.MapBuilder

