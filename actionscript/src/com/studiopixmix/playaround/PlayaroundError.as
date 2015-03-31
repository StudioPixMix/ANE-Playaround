package com.studiopixmix.playaround {
	
	/**
	 * Errors thrown by Playaround SDK.
	 */
	public class PlayaroundError {
		
		// PROPERTIES :
		public var status:String;
		public var message:String;
		
		// CONSTRUCTOR
		public function PlayaroundError(status:String, message:String = null) {
			super();
			
			this.status = status;
			this.message = message;
		}
	}
}