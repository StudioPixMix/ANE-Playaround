package com.studiopixmix.playaround {
	
	/**
	 * A Playaround user.
	 */
	public class PlayaroundUser {
		
		// PROPERTIES :
		public var id:String;
		public var name:String;
		public var nickname:String;
		public var age:int;
		public var distance:String;
		public var photoURL:String;
		
		// CONSTRUCTOR
		public function PlayaroundUser(id:String, name:String, nickname:String, age:int, distance:String, photoURL:String) {
			super();
			
			this.id = id;
			this.name = name;
			this.nickname = nickname;
			this.age = age;
			this.distance = distance;
			this.photoURL = photoURL;
		}
	}
}