package {
	import flash.display.*;
	import flash.events.*;

	public class Snowflake extends MovieClip {

		public var isRight: Boolean = false;
		public var isLeft: Boolean = false;
		public var isUp: Boolean = false;
		public var isDown: Boolean = false;
		public var shiftDown: Boolean = false;
		public var _moveSpeed: Number = 5;

		/** rotationState  - 
		0 - 
		
		*/
		public var rotationState: Number = 0;
		
		private var xPos: Number = 0;
		private var yPos: Number = 0;

		private var xSpeed: Number = 0;
		public var ySpeed: Number = 0;

		private var radius: Number = 0;

		private var scale: Number = 0;
		private var alphaValue: Number = 0;

		private var maxHeight: Number = 0;
		private var maxWidth: Number = 0;

		public function Snowflake() {
			//SetInitialProperties();
		}

		public function SetInitialProperties() {
			//Setting the various parameters that need tweaking 
			xSpeed = .05 + Math.random() * .1;
			ySpeed = .1 + Math.random() * 3;
			radius = .1 + Math.random() * 2;
			scale = .01 + Math.random();
			alphaValue = .1 + Math.random();

			var stageObject: Stage = this.stage as Stage;
			maxWidth = stageObject.stageWidth + 300;
			maxHeight = stageObject.stageHeight + 200;

			this.x = Math.random() * maxWidth;
			this.y = Math.random() * maxHeight;

			xPos = this.x;
			yPos = this.y;

			this.scaleX = this.scaleY = scale;
			this.alpha = alphaValue;

			this.addEventListener(Event.ENTER_FRAME, MoveSnowFlake);
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
			stage.addEventListener(Event.ENTER_FRAME, loop);
		}

		function onDown(event: KeyboardEvent): void {
			//right press
			if (event.keyCode == 39) {
				isRight = true
			}
			//left pressed
			if (event.keyCode == 37) {
				isLeft = true
			}
			//up pressed
			if (event.keyCode == 38) {
				isUp = true
			}
			//down pressed
			if (event.keyCode == 40) {
				isDown = true
			}
			if (event.keyCode == 13) {
				shiftDown = true
			} // TODO remove

		}
		private function onUp(event: KeyboardEvent) {
			//right released
			if (event.keyCode == 39) {
				isRight = false
			}
			//left released
			if (event.keyCode == 37) {
				isLeft = false
			}
			//up released
			if (event.keyCode == 38) {
				isUp = false
			}
			//down released
			if (event.keyCode == 40) {
				isDown = false
			}
			//shift released
			if (event.keyCode == 13) {
				//shiftDown = false
				this.play();
			}

		}
		private function loop(Event) {
			if (isRight) {
				this.x += _moveSpeed
			}
			if (isLeft) {
				this.x -= _moveSpeed
			}
			if (isUp) {
				this.y -= _moveSpeed
			}
			if (isDown) {
				this.y += _moveSpeed
			}
		}

		function MoveSnowFlake(e: Event) {
			xPos += xSpeed;
			yPos += ySpeed;
			this.alpha = Math.random();

			this.x += radius * Math.cos(xPos);
			this.y += ySpeed;

			if (this.y - this.height > maxHeight) {
				this.y = -10 - this.height;
				this.x = Math.random() * maxWidth;
			}
		}
	}
}