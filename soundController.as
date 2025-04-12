// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//soundController

package 
{
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.display.MovieClip;
    import flash.media.*;

    public class soundController 
    {

        private var sound:Sound;
        private var soundChannel:SoundChannel;
        private var bSong:Boolean;
        private var songOn:Boolean;

        public function soundController(sound:Sound)
        {
            this.sound = sound;
            this.soundChannel = new SoundChannel();
            this.soundChannel.soundTransform.volume = 0.35;
            this.bSong = false;
            this.songOn = true;
        }

        public function checkSound(movieClip:MovieClip=null):void
        {
            if (((movieClip == null) || (movieClip.txtMusic == null)))
            {
                return;
            };
            if (((Game.root.mixer.bSoundOn) || (this.songOn)))
            {
                movieClip.txtMusic.text = "Music Off";
                return;
            };
            if (this.songOn)
            {
                if (!this.bSong)
                {
                    this.soundChannel = this.sound.play(0, 9999, this.soundChannel.soundTransform);
                    this.bSong = true;
                    if (movieClip != null)
                    {
                        movieClip.txtMusic.text = "Music On";
                    };
                };
            };
        }

        public function stopMusic(movieClip:MovieClip=null):void
        {
            SoundMixer.stopAll();
            this.songOn = false;
            if (((movieClip == null) || (movieClip.txtMusic == null)))
            {
                return;
            };
            movieClip.txtMusic.text = "Music Off";
        }

        public function buttonClick(movieClip:MovieClip):void
        {
            if (this.bSong)
            {
                SoundMixer.stopAll();
                this.songOn = false;
                if (((!(movieClip == null)) && (!(movieClip.txtMusic == null))))
                {
                    movieClip.txtMusic.text = "Music Off";
                };
            }
            else
            {
                if (Game.root.mixer.bSoundOn)
                {
                    this.soundChannel = this.sound.play(0, 9999, this.soundChannel.soundTransform);
                    this.songOn = true;
                    if (((!(movieClip == null)) && (!(movieClip.txtMusic == null))))
                    {
                        movieClip.txtMusic.text = "Music On";
                    };
                };
            };
            this.bSong = (!(this.bSong));
        }


    }
}//package 

