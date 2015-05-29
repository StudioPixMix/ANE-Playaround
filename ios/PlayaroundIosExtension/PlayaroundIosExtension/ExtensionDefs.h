#ifndef PlayaroundIosExtension_ExtensionDefs_h
#define PlayaroundIosExtension_ExtensionDefs_h

#define EVENT_GET_AVAILABLE_USERS_SUCCESS           (uint8_t*)[@"GetAvailableUsers.Success" UTF8String]
#define EVENT_GET_AVAILABLE_USERS_FAILURE           (uint8_t*)[@"GetAvailableUsers.Failure" UTF8String]

#define EVENT_POST_ACQUAINTANCE_EVENT_SUCCESS       (uint8_t*)[@"PostAcquaintanceEvent.Success" UTF8String]
#define EVENT_POST_ACQUAINTANCE_EVENT_FAILURE       (uint8_t*)[@"PostAcquaintanceEvent.Failure" UTF8String]

#define EVENT_GET_ACQUAINTANCES_SUCCESS             (uint8_t*)[@"GetAcquaintances.Success" UTF8String]
#define EVENT_GET_ACQUAINTANCES_FAILURE             (uint8_t*)[@"GetAcquaintances.Failure" UTF8String]

#define EVENT_IS_ACQUAINTANCE_SUCCESS               (uint8_t*)[@"IsAcquaintance.Success" UTF8String]
#define EVENT_IS_ACQUAINTANCE_FAILURE               (uint8_t*)[@"IsAcquaintance.Failure" UTF8String]

#define EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT  (uint8_t*)[@"SetUser.ShouldDisplayCustomInstallPrompt" UTF8String]


#define EVENT_NEED_ACQUAINTANCES_REFRESH            (uint8_t*)[@"NeedAcquaintancesRefresh" UTF8String]
#define EVENT_NEED_AVAILABLE_USERS_REFRESH          (uint8_t*)[@"NeedAvailableUsers" UTF8String]

#define EVENT_LOG                                   (uint8_t*)[@"Log" UTF8String]

#define DISPATCH_ANE_EVENT(context, event, data) FREDispatchStatusEventAsync(context, event, data)
#define DISPATCH_LOG_EVENT(context, logMessage) FREDispatchStatusEventAsync(context, EVENT_LOG, (uint8_t*)logMessage.UTF8String)

#endif
