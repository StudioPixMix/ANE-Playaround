package com.studiopixmix.playaround {
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	/**
	 * The Playaround extension. Before trying to do anything (even checking for compatibility), you must initialize the 
	 * extension. Once initialized, use <code>isCompatible()</code> to check for compatibility with the current OS before
	 * trying to display Playaround features to the user.
	 */
	public class Playaround {
		
		// CONSTANTS :
		private static const EXTENSION_ID:String = "com.studiopixmix.Playaround";
		
		private static const IS_COMPATIBLE:String = "playaround_isCompatible";
		private static const SET_USER:String = "playaround_setUser";
		private static const GET_AVAILABLE_USERS:String = "playaround_getAvailableUsers";
		private static const POST_ACQUAINTANCE_EVENT:String = "playaround_postAcquaintanceEvent";
		private static const GET_ACQUAINTANCES:String = "playaround_getAcquaintance";
		private static const IS_ACQUAINTANCE:String = "playaround_isAcquaintance";
		private static const DID_ACCEPT_INSTALL:String = "playaround_didAcceptInstall";
		private static const DID_REFUSE_INSTALL:String = "playaround_didRefuseInstall";
		
		
		// PROPERTIES :
		/** The logging function you want to use. Defaults to trace. */
		public static var logger:Function = trace;
		/** The prefix appended to every log message. Defaults to "[Playaround]". */
		public static var logPrefix:String = "[Playaround]";
		
		private static var context:ExtensionContext;
		private static var secretKey:String;
		private static var useDefaultInstallPromptDialog:Boolean;
		private static var debug:Boolean;
		
		
		////////////////
		// PUBLIC API //
		////////////////
		
		/**
		 * Initializes Playaround extension with the given secret key. Call this only once in your app, before setting the current user.
		 * 
		 * @param secretKey						Your Playaround secret key
		 * @param useDefaultInstallPromptDialog	Whether you will provide your own install prompt. If true, you will need to manually call 
		 * 										<code>didAcceptInstall()</code> and <code>didRefuseInstall()</code>
		 * @param debug							Whether debug mode should be enabled
		 */
		public function init(secretKey:String, useDefaultInstallPromptDialog:Boolean, debug:Boolean = false):void {
			// TODO
		}
		
		/**
		 * Returns true if the current platform is supported (iOS and Android API >= 14).
		 */
		public function isCompatible():Boolean {
			// TODO
		}
		
		
		/**
		 * Sets the current Playaround user. A Playaround user is needed for any operation (get users, acquaintances, etc.).
		 */
		public function setUser(userId:String, userNickname:String = null):void {
			// TODO
		}
		
		/**
		 * Get the list of single users near the current user.
		 * 
		 * @param onSuccess	function(users:Vector.&lt;PlayaroundUser&gt;):void
		 * @param onFailure	function(error:PlayaroundError):void
		 */
		public function getAvailableUsers(onSuccess:Function, onFailure:Function):void {
			// TODO
		}
		
		/**
		 * Registers that an acquaintance event occurred between the current user and an available user.
		 * 
		 * @param friend	The friend the current user interacted with
		 * @param onSuccess	function():void
		 * @param onFailure	funciton(error:PlayaroundError):void
		 */
		public function postAcquaintanceEvent(friendId:String, onSuccess:Function, onFailure:Function):void {
			// TODO
		}
		
		
		/**
		 * Get the list of all the users with whom the current user had an acquaintance.
		 * 
		 * @param onSuccess	function(acquaintances:Vector.&lt;PlayaroundUser&gt;):void
		 * @param onFailure	function(error:PlayaroundError):void
		 */
		public function getAcquaintances(onSuccess:Function, onFailure:Function):void {
			// TODO
		}
		
		/**
		 * Checks if a user has an acquaintance with the current user.
		 * 
		 * @param friendId	The id of the friend to check
		 * @param onSuccess	function(isAcquaintance:Boolean):void
		 * @param onFailure	function(error:PlayaroundError):void
		 */
		public function isAcquaintance(friendId:String, onSuccess:Function, onFailure:Function):void {
			// TODO
		}
		
		/**
		 * Call this when the user accepted to install the Playaround app (only needed if you initialized the extension with 
		 * <code>useDefaultInstallPromptDialog</code> to false).
		 */
		public function didAcceptInstall():void {
			// TODO
		}
		
		/**
		 * Call this when the user refused to install the Playaround app (only needed if you initialized the extension with 
		 * <code>useDefaultInstallPromptDialog</code> to false). 
		 */
		public function didRefuseInstall():void {
			// TODO
		}
		
		
		
		
		/////////////
		// LOGGING //
		/////////////
		
		/**
		 * Outputs the given message(s) using the provided logger function, or using trace.
		 */
		private static function log(message:String, ... additionnalMessages):void {
			if(logger == null) return;
			
			if(!additionnalMessages)
				additionnalMessages = [];
			
			logger((logPrefix && logPrefix.length > 0 ? logPrefix + " " : "") + message + " " + additionnalMessages.join(" "));
		}
	}
}