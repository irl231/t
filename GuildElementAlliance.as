// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildElementAlliance

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;

    public dynamic class GuildElementAlliance extends MovieClip 
    {

        public var bg:MovieClip;
        private var iID:int;
        private var sDate:String;
        private var sName:String;
        private var iLevel:int;
        public var tDate:TextField;
        public var tName:TextField;
        public var tLevel:TextField;
        public var btnApprove:SimpleButton;
        public var btnDecline:SimpleButton;

        public function GuildElementAlliance(ID:int, _arg_2:String, Name:String, Level:int):void
        {
            this.ID = ID;
            this.Date = _arg_2;
            this.Name = Name;
            this.Level = Level;
        }

        public function set ID(value:*):void
        {
            this.iID = value;
        }

        public function get ID():int
        {
            return (this.iID);
        }

        public function set Date(value:*):void
        {
            this.sDate = value;
            this.tDate.text = value;
        }

        public function get Date():String
        {
            return (this.sDate);
        }

        public function set Name(value:*):void
        {
            this.sName = value;
            this.tName.text = value;
        }

        public function get Name():String
        {
            return (this.sName);
        }

        public function set Level(value:*):void
        {
            this.iLevel = value;
            this.tLevel.text = value;
        }

        public function get Level():int
        {
            return (this.iLevel);
        }


    }
}//package 

