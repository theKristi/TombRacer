package com.trdevt.sprites.obstacles 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class CrushGuyObstacle extends Obstacle 
	{
		private var _crushTimer:Timer;
		private var _warningTimer:Timer;
		private var _downSpeed:Number;
		private var _upSpeed:Number;
		private var _direction:uint;
		private var _startY:Number;
		[Embed(source = "../../../../../../images/SpriteSheets/crushguysprite.png")] private var _crushGuySprite:Class;
		public function CrushGuyObstacle(X:Number=0, Y:Number=0) 
		{
			super(X, Y, _crushGuySprite);
			this.loadGraphic(_spriteSheet, true, false, 64, 64);
			this.addAnimation("idle", [0]);
			this.addAnimation("ready", [1]);
			this.addAnimation("crushing", [2]);
			this.play("idle");
			_crushTimer = new Timer(2500);
			_crushTimer.addEventListener(TimerEvent.TIMER, _onReady);
			_warningTimer = new Timer(500);
			_warningTimer.addEventListener(TimerEvent.TIMER, _onCrush);
			_crushTimer.start();
			_downSpeed = 8;
			_upSpeed = 4;
			_startY = Y;
		}
		
		override public function update():void 
		{
			super.update();
			if (_direction == FlxObject.DOWN)
			{
				this.y += _downSpeed;
			}
			else if (_direction == FlxObject.UP)
			{
				if (this.y / 32 != _startY)
				{
					this.y -= _upSpeed;
				}
				else
				{
					_direction = FlxObject.NONE;
					_crushTimer.reset();
					_warningTimer.reset();
					_crushTimer.start();
				}
			}
		}
		
		/**
		 * stops all timers and such
		 */
		public function die():void
		{
			trace("killing crush guy!");
			_crushTimer.removeEventListener(TimerEvent.TIMER, _onReady);

			_warningTimer.removeEventListener(TimerEvent.TIMER, _onCrush);
			
			_warningTimer.stop();
			_crushTimer.stop();
		}
		
		private function _onReady(e:Event):void
		{
			if (this == null || _warningTimer == null || _crushTimer == null)
			{
				return;
			}
			this.play("ready");
			_warningTimer.start();
			_crushTimer.stop();
		}
		
		private function _onCrush(e:Event):void
		{
			this.play("crushing");
			_direction = FlxObject.DOWN;
			//_crushTimer.removeEventListener(TimerEvent.TIMER, _onCrush);
			//_crushTimer.stop();
			_warningTimer.stop();
		}
		
		override public function onCollision():void
		{
			this.play("idle");
			_direction = FlxObject.UP;
		}
	}

}