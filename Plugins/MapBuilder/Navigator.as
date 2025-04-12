// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.Navigator

package Plugins.MapBuilder
{
    import flash.display.MovieClip;
    import flash.events.Event;

    public dynamic class Navigator extends AbstractPad 
    {

        public var rootClass:Game = Game.root;
        public var shadow:MovieClip;

        public function Navigator(data:Object)
        {
            this.isEvent = true;
            super(data);
            this.addEventListener("enter", this.onEnter);
        }

        public function onEnter(event:Event):void
        {
            var mapName:String;
            if (((this.parameters is Array) && (this.parameters.length >= 1)))
            {
                mapName = this.parameters[0];
                this.rootClass.showConfirmtaionBox((('Would you like to go to "' + mapName) + '"?'), this.done);
            }
            else
            {
                trace("Navigator: Invalid or insufficient parameters for map transition.");
            };
        }

        public function done(event:Boolean):void
        {
            var strNewMap:String;
            var cellName:String;
            var padName:String;
            if (event)
            {
                if (((this.parameters is Array) && (this.parameters.length >= 3)))
                {
                    strNewMap = this.parameters[0];
                    cellName = this.parameters[1];
                    padName = this.parameters[2];
                    if ((((strNewMap) && (cellName)) && (padName)))
                    {
                        this.rootClass.world.gotoTown(strNewMap, cellName, padName);
                    }
                    else
                    {
                        trace("Navigator: Missing or invalid parameters for gotoTown.");
                    };
                }
                else
                {
                    trace("Navigator: Insufficient parameters for gotoTown.");
                };
            };
        }


    }
}//package Plugins.MapBuilder

