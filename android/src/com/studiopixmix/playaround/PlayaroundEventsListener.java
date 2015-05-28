package com.studiopixmix.playaround;

import com.adobe.fre.FREContext;
import com.pft.playaroundsdk.PlayAroundEventsListener;
import com.studiopixmix.playaround.utils.FRELog;

public class PlayaroundEventsListener implements PlayAroundEventsListener {
	
	// PROPERTIES :
	private FREContext context;
	
	
	// CONSTRUCTOR :
	public PlayaroundEventsListener(FREContext context) {
		super();
		
		this.context = context;
	}
	

	@Override
	public void needsAcquaintancesRefresh() {
		FRELog.i("Playaround SDK requires to refresh acquaintances, dispatching the corresponding event ...");
		context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_NEED_ACQUAINTANCES_REFRESH, "");
	}

	@Override
	public void needsAvailableUsersRefresh() {
		FRELog.i("Playaround SDK requires to refresh available users, dispatching the corresponding event ...");
		context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_NEED_AVAILABLE_USERS_REFRESH, "");
	}
	
	public void dispose() {
		this.context = null;
	}
}
