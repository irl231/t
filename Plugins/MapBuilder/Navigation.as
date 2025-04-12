// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.Navigation

package Plugins.MapBuilder
{
    import flash.display.MovieClip;
    import flash.events.Event;

    public dynamic class Navigation extends AbstractPad 
    {

        public var rootClass:Game = Game.root;
        public var shadow:MovieClip;

        public function Navigation(data:Object)
        {
            this.isEvent = true;
            super(data);
            this.addEventListener("enter", this.onEnter);
        }

        public function onEnter(event:Event):void
        {
            var cellName:String;
            var padName:String;
            if (((this.parameters is Array) && (this.parameters.length >= 2)))
            {
                cellName = this.parameters[0];
                padName = this.parameters[1];
                if (((cellName) && (padName)))
                {
                    this.rootClass.world.moveToCell(cellName, padName);
                }
                else
                {
                    trace("Navigation: Missing or invalid cellName/padName in parameters.");
                };
            }
            else
            {
                trace("Navigation: Insufficient or invalid parameters for moveToCell.");
            };
        }


    }
}//package Plugins.MapBuilder

