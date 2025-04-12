// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildElementTechLevel

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class GuildElementTechLevel extends MovieClip 
    {

        public var bg:MovieClip;
        private var iValue:int;
        private var iLevel:int;
        public var tValue:TextField;
        public var tLevel:TextField;

        public function GuildElementTechLevel(Level:int, Value:int):void
        {
            this.Level = Level;
            this.Value = Value;
        }

        public function set Level(value:*):void
        {
            this.iLevel = value;
            this.tLevel.text = ("Level " + value);
        }

        public function get Level():int
        {
            return (this.iLevel);
        }

        public function set Value(value:*):void
        {
            this.iValue = value;
            this.tValue.text = value;
        }

        public function get Value():String
        {
            return (this.iValue);
        }


    }
}//package 

