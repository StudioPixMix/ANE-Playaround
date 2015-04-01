package com.studiopixmix.playaround;

/**
 * The list of internal events.
 */
public class PlayaroundEvent {
	
	public static final String EVENT_LOG = "Log";
	
	public static final String EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT = "SetUser.ShouldDisplayCustomInstallPrompt";
	
	public static final String EVENT_GET_AVAILABLE_USERS_SUCCESS = "GetAvailableUsers.Success";
	public static final String EVENT_GET_AVAILABLE_USERS_FAILURE = "GetAvailableUsers.Failure";
	
	public static final String EVENT_POST_ACQUAINTANCE_EVENT_SUCCESS = "PostAcquaintanceEvent.Success";
	public static final String EVENT_POST_ACQUAINTANCE_EVENT_FAILURE = "PostAcquaintanceEvent.Failure";
	
	public static final String EVENT_GET_ACQUAINTANCES_SUCCESS = "GetAcquaintances.Success";
	public static final String EVENT_GET_ACQUAINTANCES_FAILURE = "GetAcquaintances.Failure";
	
	public static final String EVENT_IS_ACQUAINTANCE_SUCCESS = "IsAcquaintance.Success";
	public static final String EVENT_IS_ACQUAINTANCE_FAILURE = "IsAcquaintance.Failure";
	
}
