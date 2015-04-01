package com.studiopixmix.playaround;

import org.json.JSONException;
import org.json.JSONObject;

import com.pft.playaroundsdk.PlayAroundError;

public class PlayaroundError {
	
	// PROPERTIES :
	public String status;
	public String message;
	
	// CONSTRUCTOR
	public PlayaroundError(PlayAroundError sdkError) {
		super();
		
		this.status = sdkError.getStatus().name();
		this.message = sdkError.getMessage();
	}
	
	
	public JSONObject toJSON() {
		try {
			JSONObject json = new JSONObject();
			json.put("status", status);
			json.put("message", message);
			return json;
		}
		catch(JSONException e) { e.printStackTrace(); }
		
		return null;
	}

}
