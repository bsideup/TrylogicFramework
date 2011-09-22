package tl.core
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * ...
	 * @author aSt
	 */
	public class Sound
	{
		protected var sound : flash.media.Sound;

		protected var soundChannel : SoundChannel;

		public function set soundClass(soundClass : Class) : void
		{
			var soundObj : Object = new soundClass();
			if (soundObj is flash.media.Sound) sound = soundObj as flash.media.Sound;
		}

		public function play(startTime : Number = 0, loops : int = 0, sndTransform : SoundTransform = null) : SoundChannel
		{
			if (sound)
			{
				soundChannel = sound.play(startTime, loops, sndTransform);
			}
			else
			{
				return null;
			}

		}

		public function stop() : void
		{
			if (soundChannel)
			{
				soundChannel.stop();
			}
		}

	}

}
