package  {
	
	import flash.display.MovieClip;
		import flash.events.KeyboardEvent;
		import flash.events.Event;

	
	public class Piano extends MovieClip {
		
		// Piano Keys: yuiop
		private var keys:Array = new Array();
		
		public function Piano() {
			// constructor code
			keys.push(this.key1);
			keys.push(this.key2);
			keys.push(this.key3);
			keys.push(this.key4);
			keys.push(this.key5);
		}
		public function SetInitialPianoProperties() {	
			
			this.key1["shrinkRate"] = -10;
			this.key2["shrinkRate"] = -15;
			this.key3["shrinkRate"] = -18;
			this.key4["shrinkRate"] = -21;
			this.key5["shrinkRate"] = -25;
			
			this.key1.alpha = .1;
			this.key2.alpha = .1;
			this.key3.alpha = .1;
			this.key4.alpha = .1;
			this.key5.alpha = .1;
			
			this.key1.height = 10;
			this.key2.height = 10;
			this.key3.height = 10;
			this.key4.height = 10;
			this.key5.height = 10;			
			
			this.x = 100;
			this.y = 800;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
			stage.addEventListener(Event.ENTER_FRAME, loop);

		}
		
		function onDown(e: KeyboardEvent): void {
			var key = e.keyCode;
			
			// key1 = y
			if (key == 89) {
				this.key1.alpha = .8;
			}
			// key2 = u
			if (key == 85) {
				this.key2.alpha = .8;
				
			}
			// key3 = i
			if (key == 73) {
				this.key3.alpha = .8;
				
			}
			// key4 = o
			if (key == 79) {
				this.key4.alpha = .8;
				
			}
			// key5 = p
			if (key == 80) {
				this.key5.alpha = .8;
				
			}
		}
		function onUp(e: KeyboardEvent): void {
			var key = e.keyCode;
			
			// key1 = y
			if (key == 89) {
				this.key1.alpha = .2; // Fade keys out back to .1
				//backKeysBackToDefault(this.key1);
				this.key1.height += 200;
			}
			// key2 = u
			if (key == 85) {
				this.key2.alpha = .2;
				//backKeysBackToDefault(this.key2);
				this.key2.height += 230;
			}
			// key3 = i
			if (key == 73) {
				this.key3.alpha = .2;
				//backKeysBackToDefault(this.key3);
				this.key3.height += 260;
			}
			// key4 = o
			if (key == 79) {
				this.key4.alpha = .2;
				//backKeysBackToDefault(this.key4);
				this.key4.height += 290;
			}
			// key5 = p
			if (key == 80) {
				this.key5.alpha = .2;
				this.key5.height += 320;
				//backKeysBackToDefault(this.key5);
				//this.key5.alpha = .2;
			}
		}
		
		// TODO not working
		function backKeysBackToDefault(key): void {
			while(key.alpha > .1) {
				key.alpha -= .0001
			}
	
		}
		
		function loop(e: Event) {

			if (this.key1.height > 10) {
				key1.height += key1["shrinkRate"];
			}
			if (this.key2.height > 10) {
				key2.height += key2["shrinkRate"];
			}
			if (this.key3.height > 10) {
				key3.height += key3["shrinkRate"];
			}
			if (this.key4.height > 10) {
				key4.height += key4["shrinkRate"];
			}
			if (this.key5.height > 10) {
				key5.height += key5["shrinkRate"];
			}
			
		}

	}
	
}
