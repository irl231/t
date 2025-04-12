// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildElementRank

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class GuildElementRank extends MovieClip 
    {

        public var bg:MovieClip;
        public var id:uint;
        public var dbId:uint;
        public var Name:String;
        public var tID:TextField;
        public var tName:TextField;

        public function GuildElementRank(id:uint, dbId:uint, Name:String):void
        {
            this.setId(id);
            this.setDBID(dbId);
            this.setName(Name);
        }

        public function setId(id:uint):void
        {
            this.id = id;
            this.tID.htmlText = id;
        }

        public function setDBID(id:uint):void
        {
            this.dbId = id;
        }

        public function setName(Name:String):void
        {
            this.Name = Name;
            this.tName.htmlText = Name;
        }


    }
}//package 

