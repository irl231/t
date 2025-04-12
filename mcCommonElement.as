// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcCommonElement

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.Sprite;

    public class mcCommonElement extends MovieClip 
    {

        public var game:Game = Game.root;
        public var Data:Object;
        public var Name:TextField;
        public var Lock:Sprite;
        public var Equipped:Sprite;
        public var Rarity:MovieClip;

        public function mcCommonElement(data:Object, equipped:Boolean)
        {
            this.buttonMode = true;
            this.Data = data;
            this.Name.text = this.Data.Name;
            this.Lock.visible = Boolean(this.Data.Lock);
            this.Equipped.visible = equipped;
        }

    }
}//package 

