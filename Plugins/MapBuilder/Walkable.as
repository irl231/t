// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.Walkable

package Plugins.MapBuilder
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;

    public dynamic class Walkable extends AbstractPad 
    {

        public var rootClass:Game = Game.root;
        public var btnWalkingArea:MovieClip;

        public function Walkable(data:Object)
        {
            super(data);
            this.btnWalkingArea.addEventListener(MouseEvent.CLICK, this.walk);
        }

        public function walk(event:MouseEvent):*
        {
            this.rootClass.world.onWalkClick();
        }


    }
}//package Plugins.MapBuilder

