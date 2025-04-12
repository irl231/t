// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.MapBuilder.MapController

package Plugins.MapBuilder
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;
    import flash.utils.*;

    public class MapController 
    {

        public var game:Game = Game.root;
        public var mapping:Vector.<AbstractPad> = new Vector.<AbstractPad>();
        public var options:Vector.<OptionPad> = Vector.<OptionPad>([new OptionPad("Navigator", "Navigations", "Plugins.MapBuilder.Navigator"), new OptionPad("Navigation", "Navigations", "Plugins.MapBuilder.Navigation"), new OptionPad("Pad", "Navigations", "Plugins.MapBuilder.Pad"), new OptionPad("Monster", "Properties", "Plugins.MapBuilder.Monster"), new OptionPad("Collision", "Properties", "Plugins.MapBuilder.Collision"), new OptionPad("Walkable", "Properties", "Plugins.MapBuilder.Walkable"), new OptionPad("FrameDown", "Arrows", "Plugins.MapBuilder.Arrow.FrameDown"), new OptionPad("FrameSide", "Arrows", "Plugins.MapBuilder.Arrow.FrameSide"), new OptionPad("FrameSideDown", "Arrows", "Plugins.MapBuilder.Arrow.FrameSideDown"), new OptionPad("FrameSideUp", "Arrows", "Plugins.MapBuilder.Arrow.FrameSideUp"), new OptionPad("FrameUp", "Arrows", "Plugins.MapBuilder.Arrow.FrameUp"), new OptionPad("JoinDown", "Arrows", "Plugins.MapBuilder.Arrow.JoinDown"), new OptionPad("JoinSide", "Arrows", "Plugins.MapBuilder.Arrow.JoinSide"), new OptionPad("JoinSideDown", "Arrows", "Plugins.MapBuilder.Arrow.JoinSideDown"), new OptionPad("JoinSideUp", "Arrows", "Plugins.MapBuilder.Arrow.JoinSideUp"), new OptionPad("JoinUp", "Arrows", "Plugins.MapBuilder.Arrow.JoinUp")]);
        public var strFrame:String = "";


        public function destroy():void
        {
            var frame:Object;
            var i:int;
            var data:Object;
            for each (frame in this.game.world.frames)
            {
                for each (data in frame.build)
                {
                    if (data.isProcessed)
                    {
                        data.isProcessed = false;
                    };
                };
            };
            i = 0;
            while (i < this.mapping.length)
            {
                this.mapping[i].remove();
                i++;
            };
            this.mapping = new Vector.<AbstractPad>();
            this.strFrame = "";
        }

        public function visible(value:Boolean):void
        {
            var pad:AbstractPad;
            for each (pad in this.mapping)
            {
                pad.setVisible(value);
            };
        }

        public function find(frames:Array, frame:String):Object
        {
            var data:Object;
            for each (data in frames)
            {
                if (data.frame == frame)
                {
                    return (data);
                };
            };
            return (null);
        }

        public function build(frames:Array, label:String):void
        {
            var data:Object;
            var navigator:Navigator;
            var navigation:Navigation;
            var pad:Pad;
            var monster:Monster;
            var collision:Collision;
            var option:OptionPad;
            var opt:OptionPad;
            var ClassReference:Class;
            var instance:Object;
            var frame:* = this.find(frames, label);
            if (frame == null)
            {
                return;
            };
            for each (data in frame.build)
            {
                try
                {
                    if (((!(data.label == label)) || (data.isProcessed)))
                    {
                        continue;
                    };
                    data.isProcessed = true;
                    switch (data.type)
                    {
                        case "Navigator":
                            navigator = Navigator(this.game.world.map.addChild(new Navigator(data)));
                            navigator.setSize(data.height, data.width);
                            navigator.setPosition(data.x, data.y);
                            break;
                        case "Navigation":
                            navigation = Navigation(this.game.world.map.addChild(new Navigation(data)));
                            navigation.setSize(data.height, data.width);
                            navigation.setPosition(data.x, data.y);
                            break;
                        case "Pad":
                            pad = Pad(this.game.world.map.addChild(new Pad(data)));
                            pad.setPosition(data.x, data.y);
                            break;
                        case "Monster":
                            monster = Monster(this.game.world.map.addChild(new Monster(data)));
                            monster.setPosition(data.x, data.y);
                            break;
                        case "Collision":
                            collision = Collision(this.game.world.map.addChild(new Collision(data)));
                            collision.setSize(data.height, data.width);
                            collision.setPosition(data.x, data.y);
                            break;
                        default:
                            option = null;
                            for each (opt in this.options)
                            {
                                if (opt.name == data.type)
                                {
                                    option = opt;
                                    break;
                                };
                            };
                            if (option)
                            {
                                try
                                {
                                    ClassReference = (getDefinitionByName(option.link) as Class);
                                    instance = this.game.world.map.addChild(new (ClassReference)(data));
                                    if (((("setSize" in instance) && (data.height)) && (data.width)))
                                    {
                                        instance.setSize(data.height, data.width);
                                    };
                                    if (("setPosition" in instance))
                                    {
                                        instance.setPosition(data.x, data.y);
                                    };
                                }
                                catch(error:Error)
                                {
                                    trace(((("Error creating instance for type: " + data.type) + ", ") + error.message));
                                };
                            }
                            else
                            {
                                trace(("No matching option found for type: " + data.type));
                            };
                    };
                }
                catch(error:Error)
                {
                    game.chatF.pushMsg("warning", ("Error in your map build: " + error.getStackTrace()), "SERVER", "", 0);
                };
            };
            this.visible(this.game.isMapBuilderToggled());
        }


    }
}//package Plugins.MapBuilder

