// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.Pad

package Plugins.MapBuilder
{
    public dynamic class Pad extends AbstractPad 
    {

        public var rootClass:Game = Game.root;

        public function Pad(data:Object)
        {
            super(data);
            if (data)
            {
                this.name = data.parameters;
                this.rootClass.world.map[this.name] = this;
            };
        }

    }
}//package Plugins.MapBuilder

