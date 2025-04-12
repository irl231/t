// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//SoundFX

package 
{
    import flash.events.EventDispatcher;
    import flash.media.SoundTransform;
    import flash.media.*;
    import Main.*;

    public class SoundFX extends EventDispatcher 
    {

        public var bSoundOn:Boolean = true;

        public var stf:SoundTransform = new SoundTransform(0.7, 0);
        private const sfx:Object = {};


        public function playSound(strSound:String):void
        {
            var cls:Class;
            if (this.bSoundOn)
            {
                if (((!(this.sfx[strSound] == undefined)) && (!(this.sfx[strSound] == null))))
                {
                    this.sfx[strSound].play(0, 0, this.stf);
                    return;
                };
                cls = ((Game.root.world == null) ? (((Game.root.assetsDomain) && (Game.root.assetsDomain.hasDefinition(strSound))) ? Class(Game.root.assetsDomain.getDefinition(strSound)) : null) : Game.root.world.getClass(strSound));
                if (cls == null)
                {
                    if (Config.isDebug)
                    {
                        trace("[SoundFX] audio not found");
                    };
                    return;
                };
                this.sfx[strSound] = new (cls)();
                this.sfx[strSound].play(0, 0, this.stf);
            };
        }

        public function soundOn():void
        {
            this.bSoundOn = true;
        }

        public function soundOff():void
        {
            this.bSoundOn = false;
        }


    }
}//package 

