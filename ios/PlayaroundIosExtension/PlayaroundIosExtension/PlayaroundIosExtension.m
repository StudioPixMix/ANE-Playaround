#import "PlayaroundDelegate.h"
#import "FlashRuntimeExtensions.h"
#import <PlayAround/PlayAround.h>
#import "PlayaroundTypeConversionHelper.h"
#import "ExtensionDefs.h"
#import "PlayaroundJsonObject.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

PlayaroundDelegate* playaroundDelegate;
PlayaroundTypeConversionHelper* playaroundConversionHelper;

/**
 * Small helper to dispatch a Playaround error with the given event.
 */
void dispatchErrorEvent(FREContext context, PASError* error, uint8_t* eventName) {
    NSString* logMessage = [NSString stringWithFormat:@"An error occured : %@", error.message];
    DISPATCH_LOG_EVENT(context, logMessage);
    
    PlayaroundJsonObject* jsonObject = [[PlayaroundJsonObject alloc] initWithError:error];

    DISPATCH_ANE_EVENT(context, eventName, [jsonObject formatForDispatchEvent]);
}


// ANE FUNCTIONS


DEFINE_ANE_FUNCTION(playaround_setUser) {
    NSString* secretKey;
    NSString* userId;
    NSString* userNickname;
    uint32_t useDefaultInstallPromptDialog;
    uint32_t debug;
    
    [playaroundConversionHelper FREGetObject:argv[0] asString:&secretKey];
    [playaroundConversionHelper FREGetObject:argv[1] asString:&userId];
    [playaroundConversionHelper FREGetObject:argv[2] asString:&userNickname];
    [playaroundConversionHelper FREGetObject:argv[3] asBoolean:&useDefaultInstallPromptDialog];
    [playaroundConversionHelper FREGetObject:argv[4] asBoolean:&debug];
    
    NSString* logMessage = [NSString stringWithFormat:
                            @"Set user [userId : %@, userNickname : %@, useDefaultInstallPromptDialog : %u, debug : %u",
                            userId, userNickname, useDefaultInstallPromptDialog, debug];
    
    DISPATCH_LOG_EVENT(context, logMessage);
    
    [PlayAround setDebug:(debug == 1)];
    
    // Without delegate = default prompt dialog
    // With delegate = custom prompt dialog
    
    if (useDefaultInstallPromptDialog == 1)
        playaroundDelegate = nil;
    else
        playaroundDelegate = [[PlayaroundDelegate alloc] initWithContext:context];
    
    [PlayAround sharedInstanceWithSecretKey:secretKey userId:userId userNickname:userNickname delegate:playaroundDelegate];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(playaround_isCompatible) {
    FREObject isCompatible;
    
    [playaroundConversionHelper FREGetBool:[PlayAround isCompatible] asObject:&isCompatible];
    
    return isCompatible;
}

DEFINE_ANE_FUNCTION(playaround_getAvailableUsers) {
    DISPATCH_LOG_EVENT(context, @"Getting available users...");
    
    [[PlayAround sharedInstance] getAvailableUsers:^(NSArray *users, PASError *error) {
        if (error != nil) {
            DISPATCH_LOG_EVENT(context, @"Could not get available users");
            
            dispatchErrorEvent(context, error, EVENT_GET_AVAILABLE_USERS_FAILURE);
            return;
        }
        
        DISPATCH_LOG_EVENT(context, @"Successfully loaded available users.");
        
        PlayaroundJsonObject* jsonObject = [[PlayaroundJsonObject alloc] initWithUsers:users];
        
        DISPATCH_ANE_EVENT(context, EVENT_GET_AVAILABLE_USERS_SUCCESS, [jsonObject formatForDispatchEvent]);
    }];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(playaround_postAcquaintanceEvent) {
    NSString* userId;
    
    [playaroundConversionHelper FREGetObject:argv[0] asString:&userId];
    
    NSString* logMessage = [NSString stringWithFormat:@"Posting acquaintance event for user id %@", userId];
    DISPATCH_LOG_EVENT(context, logMessage);
    
    [[PlayAround sharedInstance] postAcquaintanceEvent:userId completion:^(PASError *error) {
        if (error != nil) {
            DISPATCH_LOG_EVENT(context, @"Could not post acquaintance event.");
            
            dispatchErrorEvent(context, error, EVENT_POST_ACQUAINTANCE_EVENT_FAILURE);
            return;
        }
        
        DISPATCH_LOG_EVENT(context, @"Successfully posted acquaintance event.");
        
        DISPATCH_ANE_EVENT(context, EVENT_POST_ACQUAINTANCE_EVENT_SUCCESS, (uint8_t*)[@"" UTF8String]);
    }];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(playaround_getAcquaintance) {
    DISPATCH_LOG_EVENT(context, @"Getting acquaintance...");
    
    [[PlayAround sharedInstance] getAcquaintances:^(NSArray *users, NSArray *ids, PASError *error) {
        if (error != nil) {
            DISPATCH_LOG_EVENT(context, @"Could not get acquaintance.");
            
            dispatchErrorEvent(context, error, EVENT_GET_ACQUAINTANCES_FAILURE);
            return;
        }
        
        DISPATCH_LOG_EVENT(context, @"Successfully got acquaintances.");
        
        PlayaroundJsonObject* jsonObject = [[PlayaroundJsonObject alloc] initWithUsers:users];
        
        DISPATCH_ANE_EVENT(context, EVENT_GET_ACQUAINTANCES_SUCCESS, [jsonObject formatForDispatchEvent]);
    }];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(playaround_isAcquaintance) {
    NSString* userId;
    
    [playaroundConversionHelper FREGetObject:argv[0] asString:&userId];
    
    NSString* logMessage = [NSString stringWithFormat:@"Checking if user is acquainted with %@", userId];
    DISPATCH_LOG_EVENT(context, logMessage);
    

    [[PlayAround sharedInstance] isAcquaintedWith:userId completion:^(BOOL isAcquainted, PASError *error) {
        if (error != nil) {
            DISPATCH_LOG_EVENT(context, @"Could not check acquaintance.");
            
            dispatchErrorEvent(context, error, EVENT_IS_ACQUAINTANCE_FAILURE);
            return;
        }
        
        NSString* logMessage = [NSString stringWithFormat:@"Acquaintance checked : %i", isAcquainted];
        DISPATCH_LOG_EVENT(context, logMessage);
        
        // AS side excepts a string representation of the boolean
        NSString* isAcquaintedString = (isAcquainted ? @"true" : @"false");
        
        DISPATCH_ANE_EVENT(context, EVENT_IS_ACQUAINTANCE_SUCCESS, (uint8_t*)isAcquaintedString.UTF8String);
    }];

    return NULL;
}

DEFINE_ANE_FUNCTION(playaround_didAcceptInstall) {
    DISPATCH_LOG_EVENT(context, @"Did accept install.");
    
    [[PlayAround sharedInstance] didAcceptPlayAroundInstallation:YES];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(playaround_didRefuseInstall) {
    DISPATCH_LOG_EVENT(context, @"Did refuse install.");
    
    [[PlayAround sharedInstance] didAcceptPlayAroundInstallation:NO];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(playaround_handleOpenUrl) {
    DISPATCH_LOG_EVENT(context, @"Handle open URL");
    
    NSString* urlAsString;
    NSString* sourceApplication;
    
    [playaroundConversionHelper FREGetObject:argv[0] asString:&urlAsString];
    [playaroundConversionHelper FREGetObject:argv[1] asString:&sourceApplication];

    NSURL* url = [NSURL URLWithString:urlAsString];
    [PlayAround handleOpenURL:url sourceApplication:sourceApplication];

    return NULL;
}

// ANE INITIALIZER/FINALIZER

void PlayaroundIosExtensionContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction mopubFunctionMap[] =
    {
        MAP_FUNCTION(playaround_setUser, NULL),
        MAP_FUNCTION(playaround_isCompatible, NULL),
        MAP_FUNCTION(playaround_getAvailableUsers, NULL),
        MAP_FUNCTION(playaround_postAcquaintanceEvent, NULL),
        MAP_FUNCTION(playaround_getAcquaintance, NULL),
        MAP_FUNCTION(playaround_isAcquaintance, NULL),
        MAP_FUNCTION(playaround_didAcceptInstall, NULL),
        MAP_FUNCTION(playaround_didRefuseInstall, NULL),
        MAP_FUNCTION(playaround_handleOpenUrl, NULL),
    };
    
    *numFunctionsToSet = sizeof( mopubFunctionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = mopubFunctionMap;
}

void PlayaroundIosExtensionContextFinalizer( FREContext ctx )
{
    return;
}

void PlayaroundIosExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet )
{
    extDataToSet = NULL;
    *ctxInitializerToSet = &PlayaroundIosExtensionContextInitializer;
    *ctxFinalizerToSet = &PlayaroundIosExtensionContextFinalizer;
    
    playaroundDelegate = [[PlayaroundDelegate alloc] init];
    playaroundConversionHelper = [[PlayaroundTypeConversionHelper alloc] init];
}

void PlayaroundIosExtensionFinalizer()
{
    return;
}