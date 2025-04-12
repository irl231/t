// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildListElement

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class GuildListElement extends MovieClip 
    {

        public var bg:MovieClip;
        private var iID:uint;
        private var sName:String;
        private var sDescription:String;
        private var sMOTD:String;
        private var sLeader:String;
        private var sMember:Array;
        private var sLevel:int;
        private var sSlot:int;
        private var sStatus:int;
        public var tLevel:TextField;
        public var tName:TextField;
        public var tLeader:TextField;
        public var tSlots:TextField;
        public var tStatus:TextField;

        public function GuildListElement(iID:uint, sName:String, sDescription:String, sMOTD:String, sLeader:String, sLevel:int, sMember:Array, sSlot:int, sStatus:int):void
        {
            this.ID = iID;
            this.Name = sName;
            this.Description = sDescription;
            this.MOTD = sMOTD;
            this.Leader = sLeader;
            this.Level = sLevel;
            this.Member = sMember;
            this.Slot = sSlot;
            this.Status = sStatus;
        }

        public function set ID(value:uint):void
        {
            this.iID = value;
        }

        public function get ID():uint
        {
            return (this.iID);
        }

        public function set Name(value:String):void
        {
            this.sName = value;
            this.tName.text = value;
        }

        public function get Name():String
        {
            return (this.sName);
        }

        public function set Description(value:String):void
        {
            this.sDescription = value;
        }

        public function get Description():String
        {
            return (this.sDescription);
        }

        public function set MOTD(value:String):void
        {
            this.sMOTD = value;
        }

        public function get MOTD():String
        {
            return (this.sMOTD);
        }

        public function set Leader(value:String):void
        {
            this.sLeader = value;
            this.tLeader.text = value;
        }

        public function get Leader():String
        {
            return (this.sLeader);
        }

        public function set Level(value:uint):void
        {
            this.sLevel = value;
            this.tLevel.text = value;
        }

        public function get Level():uint
        {
            return (this.sLevel);
        }

        public function set Member(value:Array):void
        {
            this.sMember = value;
        }

        public function get Member():Array
        {
            return (this.sMember);
        }

        public function set Slot(value:uint):void
        {
            this.sSlot = value;
            this.tSlots.text = ((this.sMember.length + "/") + value);
        }

        public function get Slot():uint
        {
            return (this.sSlot);
        }

        public function set Status(value:uint):void
        {
            this.sStatus = value;
            switch (value)
            {
                case 0:
                    this.tStatus.htmlText = "Close";
                    break;
                case 1:
                    this.tStatus.htmlText = "<font color='#39FF35'>Open</font>";
                    break;
                case 2:
                    this.tStatus.htmlText = "<font color='#FF0000'>Request</font>";
                    break;
            };
        }

        public function get Status():uint
        {
            return (this.sStatus);
        }


    }
}//package 

