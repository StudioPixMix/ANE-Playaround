package com.studiopixmix.playaround {
	
	/**
	 * Errors thrown by Playaround SDK.
	 */
	public class PlayaroundError {
		
		// CONSTANTS :
		/** iOS only. */
		public static const ERROR_UNCOMPATIBLE:String = "ERROR_UNCOMPATIBLE";
		/** You must first call the getAvailableUsers() method */
		public static const ERROR_AVAILABLE_USERS_NOT_LOADED:String = "ERROR_AVAILABLE_USERS_NOT_LOADED";
		/** Empty secret key */
		public static const ERROR_INIT_EMPTY_SECRET_KEY:String = "ERROR_INIT_EMPTY_SECRET_KEY";
		/** Empty user ID */
		public static const ERROR_INIT_EMPTY_USER_ID:String = "ERROR_INIT_EMPTY_USER_ID";
		/** Incorrect secret key: must have 22 characters and must contain [azA-Z0-9-_] characters only. */
		public static const ERROR_INIT_INCORRECT_SECRET_KEY:String = "ERROR_INIT_INCORRECT_SECRET_KEY";
		/** Error due to internal SDK, contact us at contact@goplayme.com */
		public static const ERROR_INTERNAL_SDK:String = "ERROR_INTERNAL_SDK";
		/** iOS only */
		public static const ERROR_WEBSERVICE:String = "ERROR_WEBSERVICE";
		/** Internet permission missing: add to your manifest */
		public static const ERROR_INTERNET_PERMISSION_MISSING:String = "ERROR_INTERNET_PERMISSION_MISSING";
		/** Network error, check your internet connection */
		public static const ERROR_NETWORK:String = "ERROR_NETWORK";
		/** You tried to perform an operation on a user that does not exist */
		public static const ERROR_USER_DOES_NOT_EXIST:String = "ERROR_USER_DOES_NOT_EXIST";
		/** Android only. */
		public static const SUCCESS:String = "SUCCESS";
		/** Unknown error, contact us at contact@goplayme.com */
		public static const UNKNOWN_ERROR:String = "UNKNOWN_ERROR";
		/** iOS only */
		public static const WARNING_PLAY_AROUND_SDK_NOT_INITIALIZED:String = "WARNING_PLAY_AROUND_SDK_NOT_INITIALIZED";
		/** This is a warning, and does not expect any specific action. */
		public static const WARNING_PLAY_AROUND_APPLICATION_NOT_INSTALLED:String = "WARNING_PLAY_AROUND_APPLICATION_NOT_INSTALLED";
		/** This is a warning, and does not expect any specific action. */
		public static const WARNING_SILENT_LOGIN_USER_NOT_LOGGED_IN:String = "WARNING_SILENT_LOGIN_USER_NOT_LOGGED_IN";
		
		// PROPERTIES :
		public var status:String;
		public var message:String;
		
		// CONSTRUCTOR
		public function PlayaroundError(status:String, message:String = null) {
			super();
			
			switch(status) {
				case "PASErrorUncompatible":
					this.status = ERROR_UNCOMPATIBLE;
					break;
				case "ERROR_AVAILABLE_USERS_NOT_LOADED": 
				case "PASErrorAvailableUsersNotLoaded": 
					this.status = ERROR_AVAILABLE_USERS_NOT_LOADED;
					break;
				case "ERROR_INIT_EMPTY_SECRET_KEY":
				case "PASErrorInitEmptySecretKey":
					this.status = ERROR_INIT_EMPTY_SECRET_KEY;
					break;
				case "ERROR_INIT_EMPTY_USER_ID":
				case "PASErrorInitEmptyUserId":
					this.status = ERROR_INIT_EMPTY_USER_ID;
					break;
				case "ERROR_INIT_INCORRECT_SECRET_KEY":
				case "PASErrorInitIncorrectSecretKey":
					this.status = ERROR_INIT_INCORRECT_SECRET_KEY;
					break;
				case "ERROR_INTERNAL_SDK":
				case "PASErrorInternalSDK":
					this.status = ERROR_INTERNAL_SDK;
					break;
				case "PASErrorWebservice":
					this.status = ERROR_WEBSERVICE;
					break;
				case "ERROR_INTERNET_PERMISSION_MISSING":
					this.status = ERROR_INTERNET_PERMISSION_MISSING;
					break;
				case "ERROR_NETWORK":
				case "PASErrorNetwork":
					this.status = ERROR_NETWORK;
					break;
				case "ERROR_USER_DOES_NOT_EXIST":
				case "PASErrorUserDoeNotExist":
					this.status = ERROR_USER_DOES_NOT_EXIST;
					break;
				case "SUCCESS":
					this.status = SUCCESS;
					break;
				case "UNKNOWN_ERROR":
				case "PASUnknowError":
					this.status = UNKNOWN_ERROR;
					break;
				case "PASWarningPlayAroundSDKNotInitialized":
					this.status = WARNING_PLAY_AROUND_SDK_NOT_INITIALIZED;
					break;
				case "WARNING_PLAY_AROUND_APPLICATION_NOT_INSTALLED":
				case "PASWarningPlayAroundApplicationNotInstalled":
					this.status = WARNING_PLAY_AROUND_APPLICATION_NOT_INSTALLED;
					break;
				case "WARNING_SILENT_LOGIN_USER_NOT_LOGGED_IN":
				case "PASWarninSilentLoginUserNotLoggedIn":
					this.status = WARNING_SILENT_LOGIN_USER_NOT_LOGGED_IN;
					break;
				default:
					this.status = status;
			}
			
			this.message = message;
		}
		
		
		internal static function fromObject(object:Object):PlayaroundError {
			return new PlayaroundError(object.status, object.message);
		}
		
		public function toString():String {
			return "<PlayaroundError[" + status + (message != null ? "|" + message : "") + "]>";
		}
	}
}