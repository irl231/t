// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.Collision

package Plugins.MapBuilder
{
    import flash.display.MovieClip;

    public dynamic class Collision extends AbstractPad 
    {

        public var shadow:MovieClip;

        public function Collision(data:Object)
        {
            this.isSolid = true;
            super(data);
        }

    }
}//package Plugins.MapBuilder

