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
		public function PlayaroundUser(id:String = null, name:String = null, nickname:String = null, age:int = -1, distance:String = null, photoURL:String = null) {
			super();
			
			this.id = id;
			this.name = name;
			this.nickname = nickname;
			this.age = age;
			this.distance = distance;
			this.photoURL = photoURL;
		}
		
		
		internal static function fromObject(object:Object):PlayaroundUser {
			return new PlayaroundUser(object.id, object.name, object.nickname, object.age, object.distance, object.photoURL);
		}
		
		public function toString():String {
			return "<PlayaroundUser[" + id + ", name:" + name + ", nickname:" + nickname + ", age:" + age + ", distance:" + distance + ", photoURL:" + photoURL + "]>";
		}
	}
}