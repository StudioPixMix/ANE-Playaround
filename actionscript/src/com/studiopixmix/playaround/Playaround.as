package com.studiopixmix.playaround {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	
	/**
	 * The Playaround extension. Before trying to do anything (even checking for compatibility), you must initialize the 
	 * extension. Once done, use <code>isCompatible()</code> to check for compatibility with the current OS before trying 
	 * to use Playaround features.
	 */
	public class Playaround {
		
		// EVENTS
		/** Event dispatched by the extension when <code>useDefaultInstallPromptDialog</code> is set to false, and the Playaround SDK
		 * requires displaying a custom install prompt dialog. The dialog must complete either by calling <code>didAcceptInstall()</code> or 
		 * <code>didRefuseInstall()</code>. */
		public static const SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT:String = "Playaround.ShouldDisplayCustomInstallPrompt";
		
		
		// CONSTANTS :
		private static const EXTENSION_ID:String = "com.studiopixmix.Playaround";
		
		// FUNCTIONS :
		private static const FN_SET_USER:String = "playaround_setUser";
		private static const FN_IS_COMPATIBLE:String = "playaround_isCompatible";
		private static const FN_GET_AVAILABLE_USERS:String = "playaround_getAvailableUsers";
		private static const FN_POST_ACQUAINTANCE_EVENT:String = "playaround_postAcquaintanceEvent";
		private static const FN_GET_ACQUAINTANCES:String = "playaround_getAcquaintance";
		private static const FN_IS_ACQUAINTANCE:String = "playaround_isAcquaintance";
		private static const FN_DID_ACCEPT_INSTALL:String = "playaround_didAcceptInstall";
		private static const FN_DID_REFUSE_INSTALL:String = "playaround_didRefuseInstall";

		// STATUS EVENTS :
		private static const EVENT_LOG:String = "Log";
		
		private static const EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT:String = "SetUser.ShouldDisplayCustomInstallPrompt";
		
		private static const EVENT_GET_AVAILABLE_USERS_SUCCESS:String = "GetAvailableUsers.Success";
		private static const EVENT_GET_AVAILABLE_USERS_FAILURE:String = "GetAvailableUsers.Failure";
		
		private static const EVENT_POST_ACQUAINTANCE_EVENT_SUCCESS:String = "PostAcquaintanceEvent.Success";
		private static const EVENT_POST_ACQUAINTANCE_EVENT_FAILURE:String = "PostAcquaintanceEvent.Failure";
		
		private static const EVENT_GET_ACQUAINTANCES_SUCCESS:String = "GetAcquaintances.Success";
		private static const EVENT_GET_ACQUAINTANCES_FAILURE:String = "GetAcquaintances.Failure";
		
		private static const EVENT_IS_ACQUAINTANCE_SUCCESS:String = "IsAcquaintance.Success";
		private static const EVENT_IS_ACQUAINTANCE_FAILURE:String = "IsAcquaintance.Failure";
		
		// PROPERTIES :
		/** The logging function you want to use. Defaults to trace. */
		public static var logger:Function = trace;
		/** The prefix appended to every log message. Defaults to "[Playaround]". */
		public static var logPrefix:String = "[Playaround]";
		
		private static var eventDispatcher:EventDispatcher = new EventDispatcher();
		
		private static var context:ExtensionContext;
		private static var secretKey:String;
		private static var useDefaultInstallPromptDialog:Boolean;
		private static var debug:Boolean;
		
		
		////////////////
		// PUBLIC API //
		////////////////
		
		/**
		 * Initializes Playaround extension with the given secret key. Call this only once in your app, before setting the current user or checking for 
		 * extension compatibility.
		 * 
		 * @param secretKey						Your Playaround secret key
		 * @param useDefaultInstallPromptDialog	Whether you will provide your own install prompt. If true, you will need to manually call 
		 * 										<code>didAcceptInstall()</code> and <code>didRefuseInstall()</code>
		 * @param debug							Whether debug mode should be enabled
		 */
		public static function init(secretKey:String, useDefaultInstallPromptDialog:Boolean, debug:Boolean = false):void {
			if(Playaround.secretKey != null)
				throw new Error("Playaround extension already initialized");
			
			Playaround.secretKey = secretKey;
			Playaround.useDefaultInstallPromptDialog = useDefaultInstallPromptDialog;
			Playaround.debug = debug;
			
			context = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
			if(context == null)
				return;
			context.addEventListener(StatusEvent.STATUS, onNativeLog);
			context.addEventListener(StatusEvent.STATUS, onShouldDisplayInstallPrompt);
			
			log("Playaround extension initialized (secretKey : " + secretKey + ", useDefaultInstallPromptDialog : " + useDefaultInstallPromptDialog  + ", debug : " + debug + ").");
		}
		
		/**
		 * Returns true if the current platform is supported (iOS and Android API >= 14).
		 */
		public static function isCompatible():Boolean {
			if(context == null)
				throw new Error("Playaround is not initialized.");
			return context.call(FN_IS_COMPATIBLE);
		}
		
		/**
		 * Sets the current Playaround user. A Playaround user is needed for any operation (get users, acquaintances, etc.).
		 */
		public static function setUser(userId:String, userNickname:String = null):void {
			if(secretKey == null)
				throw new Error("Playaround extension is not initialized");
			
			log("Setting Playaround user (id : " + userId + ", nickname : " + userNickname + ") ...");
			context.call(FN_SET_USER, secretKey, userId, userNickname, useDefaultInstallPromptDialog, debug);
			log("Playaround user set succesfully.");
		}
		/**
		 * Get the list of single users near the current user.
		 * 
		 * @param onSuccess	function(users:Vector.&lt;PlayaroundUser&gt;):void
		 * @param onFailure	function(error:PlayaroundError):void
		 */
		public static function getAvailableUsers(onSuccess:Function, onFailure:Function):void {
			if(context == null)
				return;
			
			log("Getting available Playaround users ...");
			context.addEventListener(StatusEvent.STATUS, onStatusEvent);
			context.call(FN_GET_AVAILABLE_USERS);
			
			function onStatusEvent(ev:StatusEvent):void {
				if(ev.code == EVENT_GET_AVAILABLE_USERS_SUCCESS) {
					var result:Array = JSON.parse(ev.level) as Array;
					var users:Vector.<PlayaroundUser> = new Vector.<PlayaroundUser>();
					for(var i:int = 0 ; i < result.length ; i++) {
						users.push(PlayaroundUser.fromObject(result[i]));
					}
					
					log("Succesfully retrieved " + users.length + " users.");
					onSuccess(users);
				}
				else if(ev.code == EVENT_GET_AVAILABLE_USERS_FAILURE) {
					var error:PlayaroundError = PlayaroundError.fromObject(JSON.parse(ev.level));
					log("Error while retrieving users : " + error);
					onFailure(error);
				}
				else
					return;
				context.removeEventListener(StatusEvent.STATUS, onStatusEvent);
			}
		}
		
		/**
		 * Registers that an acquaintance event occurred between the current user and an available user.
		 * 
		 * @param friend	The friend the current user interacted with
		 * @param onSuccess	function():void
		 * @param onFailure	funciton(error:PlayaroundError):void
		 */
		public static function postAcquaintanceEvent(friendId:String, onSuccess:Function, onFailure:Function):void {
			if(context == null)
				return;
			
			log("Posting acqauintance event with " + friendId + " ...");
			context.addEventListener(StatusEvent.STATUS, onStatusEvent);
			context.call(FN_POST_ACQUAINTANCE_EVENT, friendId);
			
			function onStatusEvent(ev:StatusEvent):void {
				if(ev.code == EVENT_POST_ACQUAINTANCE_EVENT_SUCCESS) {
					log("Succesfully posted acquaintance.");
					onSuccess();
				}
				else if(ev.code == EVENT_POST_ACQUAINTANCE_EVENT_FAILURE) {
					var error:PlayaroundError = PlayaroundError.fromObject(JSON.parse(ev.level));
					log("Error while posting acquaintance : " + error);
					onFailure(error);
				}
				else
					return;
				context.removeEventListener(StatusEvent.STATUS, onStatusEvent);
			}
		}
		
		
		/**
		 * Get the list of all the users with whom the current user had an acquaintance.
		 * 
		 * @param onSuccess	function(acquaintances:Vector.&lt;PlayaroundUser&gt;):void
		 * @param onFailure	function(error:PlayaroundError):void
		 */
		public static function getAcquaintances(onSuccess:Function, onFailure:Function):void {
			if(context == null)
				return;
			
			log("Getting acquaintances ...");
			context.addEventListener(StatusEvent.STATUS, onStatusEvent);
			context.call(FN_GET_ACQUAINTANCES);
			
			function onStatusEvent(ev:StatusEvent):void {
				if(ev.code == EVENT_GET_ACQUAINTANCES_SUCCESS) {
					var result:Array = JSON.parse(ev.level) as Array;
					var users:Vector.<PlayaroundUser> = new Vector.<PlayaroundUser>();
					for(var i:int = 0 ; i < result.length ; i++) {
						users.push(PlayaroundUser.fromObject(result[i]));
					}
					
					log("Succesfully retrieved " + users.length + " acquaintances.");
					onSuccess(users);
				}
				else if(ev.code == EVENT_GET_ACQUAINTANCES_FAILURE) {
					var error:PlayaroundError = PlayaroundError.fromObject(JSON.parse(ev.level));
					log("Error while retrieving acquaintances : " + error);
					onFailure(error);
				}
				else
					return;
				context.removeEventListener(StatusEvent.STATUS, onStatusEvent);
			}
		}
		
		/**
		 * Checks if a user has an acquaintance with the current user.
		 * 
		 * @param friendId	The id of the friend to check
		 * @param onSuccess	function(isAcquaintance:Boolean):void
		 * @param onFailure	function(error:PlayaroundError):void
		 */
		public static function isAcquaintance(friendId:String, onSuccess:Function, onFailure:Function):void {
			if(context == null)
				return;
			
			log("Checking if " + friendId + " is an acquaintance ...");
			context.addEventListener(StatusEvent.STATUS, onStatusEvent);
			context.call(FN_IS_ACQUAINTANCE, friendId);
			
			function onStatusEvent(ev:StatusEvent):void {
				if(ev.code == EVENT_IS_ACQUAINTANCE_SUCCESS) {
					var result:Boolean = new Boolean(ev.level);
					log(friendId + " is acsquaintance ? " + result);
					onSuccess(result);
				}
				else if(ev.code == EVENT_IS_ACQUAINTANCE_FAILURE) {
					var error:PlayaroundError = PlayaroundError.fromObject(JSON.parse(ev.level));
					log("Error while checking acquaintance with " + friendId + " : " + error);
					onFailure(error);
				}
				else
					return;
				context.removeEventListener(StatusEvent.STATUS, onStatusEvent);
			}
		}
		
		
		///////////////////////////
		// CUSTOM INSTALL PROMPT //
		///////////////////////////
		
		private static function onShouldDisplayInstallPrompt(ev:StatusEvent):void {
			if(ev.code != EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT)
				return;
			log("Playaround SDK requires to display a custom install prompt.");
			eventDispatcher.dispatchEvent(new Event(SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT));
		}
		
		/**
		 * Call this when the user accepted to install the Playaround app (only needed if you initialized the extension with 
		 * <code>useDefaultInstallPromptDialog</code> to false).
		 */
		public static function didAcceptInstall():void {
			if(context == null)
				return;
			
			log("User did accept installing Playaroung app, informing Playaround SDK ...");
			context.call(FN_DID_ACCEPT_INSTALL);
		}
		
		/**
		 * Call this when the user refused to install the Playaround app (only needed if you initialized the extension with 
		 * <code>useDefaultInstallPromptDialog</code> to false). 
		 */
		public static function didRefuseInstall():void {
			if(context == null)
				return;
			
			log("User refused to install Playaroung app, informing Playaround SDK ...");
			context.call(FN_DID_REFUSE_INSTALL);
		}
		
		
		/////////////
		// LOGGING //
		/////////////
		
		private static function onNativeLog(ev:StatusEvent):void {
			if(ev.code != EVENT_LOG)
				return;
			log(ev.level);
		}
		
		/**
		 * Outputs the given message(s) using the provided logger function, or using trace.
		 */
		private static function log(message:String, ... additionnalMessages):void {
			if(logger == null) return;
			
			if(!additionnalMessages)
				additionnalMessages = [];
			
			logger((logPrefix && logPrefix.length > 0 ? logPrefix + " " : "") + message + " " + additionnalMessages.join(" "));
		}
		
		
		//////////////////////
		// EVENT DISPATCHER //
		//////////////////////
		
		public static function addEventListener(type:String, listener:Function):void { eventDispatcher.addEventListener(type, listener); }
		public static function hasEventListener(type:String):Boolean { return eventDispatcher.hasEventListener(type); }
		public static function removeEventListener(type:String, listener:Function):void { eventDispatcher.removeEventListener(type, listener); }
	}
}