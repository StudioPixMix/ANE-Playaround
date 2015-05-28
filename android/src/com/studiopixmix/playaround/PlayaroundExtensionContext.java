package com.studiopixmix.playaround;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.pft.playaroundsdk.GetAcquaintancesListener;
import com.pft.playaroundsdk.GetAvailableUsersListener;
import com.pft.playaroundsdk.IsUserAcquaintanceListener;
import com.pft.playaroundsdk.PlayAround;
import com.pft.playaroundsdk.PlayAroundError;
import com.pft.playaroundsdk.PlayAroundUser;
import com.pft.playaroundsdk.PostEventListener;
import com.studiopixmix.playaround.functions.DidAcceptInstallFunction;
import com.studiopixmix.playaround.functions.DidRefuseInstallFunction;
import com.studiopixmix.playaround.functions.GetAcquaintancesFunction;
import com.studiopixmix.playaround.functions.GetAvailableUsersFunction;
import com.studiopixmix.playaround.functions.IsAcquaintanceFunction;
import com.studiopixmix.playaround.functions.IsCompatibleFunction;
import com.studiopixmix.playaround.functions.PostAcquaintanceEventFunction;
import com.studiopixmix.playaround.functions.SetUserFunction;
import com.studiopixmix.playaround.utils.FRELog;

public class PlayaroundExtensionContext extends FREContext {
	
	// PROPERTIES :
	/** The PlayAround SDK instance. */
	public static PlayAround playaround;
	/** The PlayaroundEvents listener. */
	private static PlayaroundEventsListener eventsListener;
	/** The custom install prompt listener. */
	private static PlayaroundInstallPromptListener installPromptListener;
	
	
	/////////////////
	// PLAY AROUND //
	/////////////////
	
	/**
	 * Tries to set the given PlayAround user with the given secret key, and handles debug mode and default install prompt dialog.
	 */
	public static void setUser(FREContext context, String secretKey, String userId, String userNickname, Boolean useDefaultInstallPromptDialog, Boolean debug) {
		
		if(playaround != null) {
			FRELog.i("Disconnecting previous playaround user ...");
			if(eventsListener != null) {
				playaround.unregisterForPlayAroundEvents();
				eventsListener.dispose();
				eventsListener = null;
			}
			if(installPromptListener != null) {
				playaround.unregisterForInstallPrompt();
				installPromptListener.dispose();
				installPromptListener = null;
			}
			playaround = null;
		}
		
		FRELog.i("Setting Playaround user ...");
		
		playaround = new PlayAround(context.getActivity(), secretKey, userId);
		playaround.setUserNickname(userNickname);
		playaround.setDebug(debug);
		
		FRELog.i("Registering Playaround SDK events listener ...");
		eventsListener = new PlayaroundEventsListener(context);
		playaround.registerForPlayAroundEvents(eventsListener);
		
		if(!useDefaultInstallPromptDialog) {
			FRELog.i("Registering a custom install prompt handler ...");
			installPromptListener = new PlayaroundInstallPromptListener(context);
			playaround.registerForInstallPrompt(installPromptListener);
		}
	}
	
	/**
	 * Retrieves the list of available users and dispatches success/failure events when complete.
	 */
	public static void getAvailableUsers(final FREContext context) {
		FRELog.i("Retrieving the list of available users ...");
		playaround.getAvailableUsers(new GetAvailableUsersListener() {
			@Override public void onSuccess(ArrayList<PlayAroundUser> users) {
				FRELog.i("Playaround SDK returned " + users.size() + " users, returning them to AS ...");
				JSONArray array = new JSONArray();
				for(PlayAroundUser user : users) {
					array.put(new PlayaroundUser(user).toJSON());
				}
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_GET_AVAILABLE_USERS_SUCCESS, array.toString());
			}
			
			@Override public void onError(PlayAroundError error) {
				FRELog.i("Playaround SDK failed to retrieve users : " + error);
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_GET_AVAILABLE_USERS_FAILURE, new PlayaroundError(error).toJSON().toString());
			}
		});
	}
	
	/**
	 * Posts an acquaintance event with the given friend and dispatches success/failure events when complete.
	 */
	public static void postAcquaintanceEvent(final FREContext context, final String friendId) {
		FRELog.i("Posting an acquaintance event with friend " + friendId + " ...");
		playaround.postAcquaintanceEvent(friendId, new PostEventListener() {
			@Override public void onSuccess() {
				FRELog.i("Acquaintance with " + friendId + " event successfully posted.");
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_POST_ACQUAINTANCE_EVENT_SUCCESS, "");
			}
			
			@Override public void onError(PlayAroundError error) {
				FRELog.i("Playaround SDK failed to post acquaintance with " + friendId + " : " + error);
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_POST_ACQUAINTANCE_EVENT_FAILURE, new PlayaroundError(error).toJSON().toString());
			}
		});
	}
	
	/**
	 * Retrieves the list of acquaintances and dispatches success/failure events when complete.
	 */
	public static void getAcquaintances(final FREContext context) {
		FRELog.i("Retrieving acquaintances ...");
		playaround.getAcquaintances(new GetAcquaintancesListener() {
			@Override public void onSuccess(ArrayList<PlayAroundUser> users, ArrayList<String> ids) {
				FRELog.i("Playaround SDK returned " + users.size() + " users, returning them to AS ...");
				JSONArray array = new JSONArray();
				for(PlayAroundUser user : users) {
					array.put(new PlayaroundUser(user).toJSON());
				}
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_GET_ACQUAINTANCES_SUCCESS, array.toString());
			}
			
			@Override public void onError(PlayAroundError error) {
				FRELog.i("Playaround SDK failed to retrieve acquaintances : " + error);
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_GET_ACQUAINTANCES_FAILURE, new PlayaroundError(error).toJSON().toString());
			}
		});
	}
	
	/**
	 * Checks if the given friend is an acquaintance and dispatches success/failure events when complete.
	 */
	public static void isAcquaintance(final FREContext context, final String friendId) {
		FRELog.i("Checking whether " + friendId + " is an acquaintance ...");
		playaround.isUserAcquaintance(friendId, new IsUserAcquaintanceListener() {
			@Override public void onSuccess(boolean isAcquaintance) {
				FRELog.i(friendId + " is acquaintance ? " + isAcquaintance);
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_IS_ACQUAINTANCE_SUCCESS, isAcquaintance ? "true" : "false");
			}
			
			@Override public void onError(PlayAroundError error) {
				FRELog.i("Playaround SDK failed to check acquaintance with " + friendId + " : " + error);
				context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_IS_ACQUAINTANCE_FAILURE, new PlayaroundError(error).toJSON().toString());
			}
		});
	}
	
	public static void didAcceptInstall() {
		FRELog.i("Informing Playaround SDK the install prompt dialog is complete and the user accepted.");
		installPromptListener.didAcceptInstall();
	}
	
	public static void didRefuseInstall() {
		FRELog.i("Informing Playaround SDK the install prompt dialog is complete and the user refused.");
		installPromptListener.didRefuseInstall();
	}
	
	
	
	///////////////////////
	// EXTENSION CONTEXT //
	///////////////////////
	
	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		
		functions.put("playaround_isCompatible", new IsCompatibleFunction());
		functions.put("playaround_setUser", new SetUserFunction());
		functions.put("playaround_getAvailableUsers", new GetAvailableUsersFunction());
		functions.put("playaround_postAcquaintanceEvent", new PostAcquaintanceEventFunction());
		functions.put("playaround_getAcquaintance", new GetAcquaintancesFunction());
		functions.put("playaround_isAcquaintance", new IsAcquaintanceFunction());
		functions.put("playaround_didAcceptInstall", new DidAcceptInstallFunction());
		functions.put("playaround_didRefuseInstall", new DidRefuseInstallFunction());

		FRELog.i(functions.size() + " extension functions declared.");
		
		return functions;
	}
	

	@Override
	public void dispose() {
		if(eventsListener != null) {
			playaround.unregisterForPlayAroundEvents();
			eventsListener.dispose();
			eventsListener = null;
		}
		if(installPromptListener != null) {
			playaround.unregisterForInstallPrompt();
			installPromptListener.dispose();
			installPromptListener = null;
		}
		playaround = null;
	}
}
