package com.studiopixmix.playaround;

import org.json.JSONException;
import org.json.JSONObject;

import com.pft.playaroundsdk.PlayAroundUser;

public class PlayaroundUser {
	
	// PROPERTIES :
	public String id;
	public String name;
	public String nickname;
	public int age;
	public String distance;
	public String photoURL;
			
	// CONSTRUCTOR
	public PlayaroundUser(PlayAroundUser sdkUser) {
		super();
		
		this.id = sdkUser.getId();
		this.name = sdkUser.getName();
		this.nickname = sdkUser.getNickname();
		this.age = sdkUser.getAge();
		this.distance = sdkUser.getDistance();
		this.photoURL = sdkUser.getPhoto();
	}
	
	
	// METHODS :
	public JSONObject toJSON() {
		try {
			JSONObject json = new JSONObject();
			json.put("id", id);
			json.put("name", name);
			json.put("nickname", nickname);
			json.put("age", age);
			json.put("distance", distance);
			json.put("photoURL", photoURL);

			return json;
		}
		catch (JSONException e) { e.printStackTrace(); }
		return null;
	}

}
