package {

	import flash.display.*;
	import flash.events.*;


	public class Earth extends MovieClip {

		public var isRight: Boolean = false;
		public var isLeft: Boolean = false;
		public var isUp: Boolean = false;
		public var isDown: Boolean = false;
		public var _moveSpeed: Number = 5;

		// Scaling variables
		private var SCALING = "SCALING"; // Add to actions object & set to true to make it active.
		private var scaleSpeed: Number = .00;
		private var growSpeed: Number = 0.02; // static for now, unless we want to randomize it later
		private var shrinkSpeed: Number = -0.02; // static for now, unless we want to randomize it later

		// "Rolling" Control (in this case we are rotating the clip, but the earth looks like it's 'rolling')
		private var ROLLING = "ROLLING";
		private var rolling: Boolean = false;
		private var rollingSpeed: Number = 0;
		private var rollingClockwise: Boolean = true;


		//  1-9 modifier keys
		private var intensityKey: Number = 53; // 53 = 5 => is middle key
		private var intensityMultiplier: Number = 1; // start with 0 multiplier
		
		// Rotating - movieclip animation spinning earth
		private var ROTATING = "ROTATING"; // TODO - have to learn how to control frame rate for nested movieclip? - seems hard
		public var isRotating: Boolean = false;
		
		// Keep track of what actions are currently active
		private var actions: Object = { };

		public var xPos: Number = 0;
		public var yPos: Number = 0;

		public var xSpeed: Number = 0;
		public var ySpeed: Number = 0;

		public var radius: Number = 0;

		public var scale: Number = 0;
		public var alphaValue: Number = 0;

		public var maxHeight: Number = 0;
		public var maxWidth: Number = 0;


		public function Earth() {
			// constructor code
			trace('create earth');
		}

		public function SetInitialEarthProperties() {
			this.SetInitialProperties();
			this.SetInitialListeners();
		}
		public function SetInitialProperties() {
			//Setting the various parameters that need tweaking 
			xSpeed = .05 + Math.random() * .1;
			ySpeed = .1 + Math.random() * 3;
			radius = .1 + Math.random() * 2;
			scale = 1; // + Math.random();
			alphaValue = .8;

			var stageObject: Stage = this.stage as Stage;
			maxWidth = stageObject.stageWidth;
			maxHeight = stageObject.stageHeight;

			this.x = maxWidth / 2;
			this.y = maxHeight / 2;

			xPos = this.x;
			yPos = this.y;

			this.scaleX = this.scaleY = scale;
			this.alpha = alphaValue;

			this.actions = { };
			this.actions[this.SCALING] = false;
			this.actions[this.ROLLING] = false;
			this.actions[this.ROTATING] = false;
			this.isRotating = false;
			this.rolling = false;
			this.rotation = 0;
		}
		
		public function SetInitialListeners() {
			//this.addEventListener(Event.ENTER_FRAME, MoveSnowFlake);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
			stage.addEventListener(Event.ENTER_FRAME, loop);
		}


		function onDown(e: KeyboardEvent): void {
			var key = e.keyCode;

			// SCALING code
			// a - scale -> grow
			if (key == 65) {
				this.scaleSpeed = this.growSpeed;
				actions[this.SCALING] = true;
			}
			// s - scale -> shrink
			if (key == 83) {
				this.scaleSpeed = this.shrinkSpeed;
				actions[this.SCALING] = true;
			}

		}
		private function onUp(e: KeyboardEvent) {
			var key = e.keyCode;
			// Controls for q + 1-9 - controls strength of rolling speed
			if (key == 49 || key == 50  || key == 51  || key == 52  ||
					key == 52  || key == 53  || key == 54  || key == 55  ||
					key == 56  || key == 57 || key == 48) {
						this.intensityKey = key;
						
						
						
				// if key is 48 (switch) direction
				if (key == 48) {
					trace(this.rollingClockwise);
					this.rollingClockwise = this.rollingClockwise ? false : true;
					trace(this.rollingClockwise);
				}
				var rollDirectionPreserver = rollingClockwise ? 1 : -1;
				 
				// Preserve the same direction for all other keys with above variable

						
				// take the max of the keys pressed between key codes 49-57, 48 = 0
				var multiplier: Number = key == 48 ? this.intensityMultiplier * -1 : (key - 48) * rollDirectionPreserver; // turn 0 into 10 intensity, otherwise standarize key between 1-10 for intensity
				//var multiplier: Number = key == 48 ? this.intensityMultiplier * -1 : key - 48; // turn 0 into 10 intensity, otherwise standarize key between 1-10 for intensity
				this.intensityMultiplier = multiplier; // * -1 = reverse speed
				//trace('e.keyCode: ' + e.keyCode + ' -> multiplier: ' + multiplier);
			}

			// a || s got released - stop scaling the size of the object
			if (key == 65 || key == 83) {
				this.scaleSpeed = 0;
				actions[this.SCALING] = false;
			}
			
			// w - Earth rotation (the gif inside - tween animation)
			if (key == 87) {
				this.isRotating = this.isRotating ? false : true; // Toggle controlling	
				actions[this.ROTATING] = this.isRotating;
			}
			
			// q - rolling
			if (key == 81) { // Hit same button twice to toggle this one
				if (this.rolling) { // remove rolling var and just use ROLLING inside of actions
					this.rollingSpeed = 0;
					this.rolling = false;
					actions[this.ROLLING] = false;

				} else {
					this.rollingSpeed = 1;
					this.rolling = true;
					actions[this.ROLLING] = true;
				}
			}

			// Apply intensity multipliers to active actions
			if (actions[this.SCALING]) {
				this.scaleSpeed *= intensityMultiplier;
			}
			if (actions[this.ROLLING]) { // DOTO boolean condition check is probably faster than array indexing..?
				this.rollingSpeed = .5 * intensityMultiplier;
				trace(rollingSpeed);
			}
			
			// e - reset back to original properties
			if (key == 69) {
				this.SetInitialProperties();		
			}

		}

		// Do stuff every frame
		private function loop(Event) {
			
			
			// Size controls
			if (this.actions[this.SCALING] == true) {
				this.scaleX += this.scaleSpeed;
				this.scaleY += this.scaleSpeed;
			}
			
			
			// Make sure that the size of the planet is staying within the bounds
			// * Sometimes it's fun to turn on of these off and let it grrrrooowwwww
			if (this.width >= this.stage.stageWidth) {
				this.scaleSpeed = this.shrinkSpeed;
			} else if (this.width * -1 >= this.stage.stageWidth) {
				this.scaleSpeed = this.growSpeed;
			}


			if (this.isRotating) {
				this.earthgif.play();
			} else if (!this.isRotating) {
				this.earthgif.stop();
			}
			
			if (this.rolling) {
				this.rotation += rollingSpeed;
			}
			
			
			/*private function shrink() {
			this.scaleX -= this.scaleSpeed;
			this.scaleY -= this.scaleSpeed;
			}
			private function grow() {
				this.scaleX += this.scaleSpeed;
				this.scaleY += this.scaleSpeed;
			}*/
		}

	}
}