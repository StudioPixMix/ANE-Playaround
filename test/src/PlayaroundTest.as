package {
	import com.studiopixmix.playaround.Playaround;
	import com.studiopixmix.playaround.PlayaroundError;
	import com.studiopixmix.playaround.PlayaroundUser;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	
	/**
	 * 
	 */
	public class PlayaroundTest extends Sprite {
		
		// PROPERTIES :
		private var dy:Number;
		
		// CONSTRUCTOR
		public function PlayaroundTest() {
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initDisplay();
			initPlayaround();
		}
		
		
		/////////////
		// DISPLAY //
		/////////////
		
		private function initDisplay():void {
			dy = 30;
			
			addButton("Is compatible ?", isCompatible);
			addButton("Set user", setUser);
			addButton("Get available users", getAvailableUsers);
			addButton("Post acquaintance", postAcquaintanceEvent);
			addButton("Get acquaintances", getAcquaintances);
			addButton("is acquaintance", isAcquaintance);
			addButton("Accept install", acceptInstall);
			addButton("Refuse install", refuseInstall);
		}
		
		private function addButton(label:String, onClick:Function):void {
			var b:Sprite = new Sprite();
			b.graphics.beginFill(0xbbbbbb);
			b.graphics.lineStyle(1, 0x222222, 1, true);
			b.graphics.drawRect(0, 0, stage.stageWidth - 20, 40);
			b.graphics.endFill();
			b.x = 10;
			b.y = dy;
			dy += 70;
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("Arial", 14, 0, true, null, null, null, null, TextFormatAlign.CENTER);
			tf.text = label;
			tf.x = 10;
			tf.y = 10;
			tf.selectable = false;
			tf.width = stage.stageWidth - 40;
			tf.height = 20;
			b.addChild(tf);
			
			b.addEventListener(MouseEvent.CLICK, function(ev:MouseEvent):void { onClick(); });
			
			addChild(b);
		}
		
		
		/////////////////
		// PLAY AROUND //
		/////////////////
		
		private function initPlayaround():void {
			Playaround.init("TQeC6VaIeDcubhb916f5LQ", false, true);
			Playaround.addEventListener(Playaround.SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT, displayInstallPrompt);
		}
		
		private function isCompatible():void {
			trace(Playaround.isCompatible());
		}
		
		private function setUser():void {
			Playaround.setUser("MyTestUser1", "My Test User Nickname");
		}
		
		private function getAvailableUsers():void {
			Playaround.getAvailableUsers(
				function(users:Vector.<PlayaroundUser>):void {
					trace(users.length + " available users : ");
					for each(var u:PlayaroundUser in users) {
						trace("\t-> " + u);
					}
				},
				function(error:PlayaroundError):void {
					trace("### Error : " + error);
				}
			);
		}
		
		private function postAcquaintanceEvent():void {
			Playaround.postAcquaintanceEvent("MyFriendId1", 
				function():void {
					trace("Acquaintance posted.");
				}, 
				function(error:PlayaroundError):void {
					trace("### Error : " + error);
				}
			);
		}
		
		private function getAcquaintances():void {
			Playaround.getAcquaintances(
				function(users:Vector.<PlayaroundUser>):void {
					trace(users.length + " acquaintances : ");
					for each(var u:PlayaroundUser in users) {
						trace("\t-> " + u);
					}
				},
				function(error:PlayaroundError):void {
					trace("### Error : " + error);
				}
			);
		}
		
		private function isAcquaintance():void {
			var id:String = "MyFriendId1" + (Math.random() > .5 ? "_fake" :"");
			Playaround.isAcquaintance(id,
				function(isAcquaintance:Boolean):void {
					trace(id + " is acquaintance ? " + isAcquaintance);
				},
				function(error:PlayaroundError):void {
					trace("### Error : " + error);
				}
			);
		}
		
		
		private function displayInstallPrompt(ev:Event):void {
			trace("Install prompt should be displayed, use Accept/Refuse install buttons.");
		}
		
		private function acceptInstall():void {
			Playaround.didAcceptInstall();
		}
		
		private function refuseInstall():void {
			Playaround.didRefuseInstall();
		}
	}
}