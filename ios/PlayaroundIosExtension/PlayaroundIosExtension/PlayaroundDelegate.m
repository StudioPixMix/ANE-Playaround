#import "PlayaroundDelegate.h"
#import "ExtensionDefs.h"
#import "FlashRuntimeExtensions.h"

@implementation PlayaroundDelegate

- (id) initWithContext:(FREContext)context {
    self = [super init];
    
    if (!self)
        return nil;
    
    self.context = context;

    return self;
}

- (void) promptForInstallingPlayAroundApplication:(id<PASInstallationMessageDelegate>)installationMessageDelegate {
    DISPATCH_LOG_EVENT(self.context, @"Prompt for installing Playaround app.");
    
    DISPATCH_ANE_EVENT(self.context, EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT, (uint8_t*)[@"" UTF8String]);
}

- (void) needsAcquaintancesRefresh {
    DISPATCH_LOG_EVENT(self.context, @"Needs acquaintances refresh");

    DISPATCH_ANE_EVENT(self.context, EVENT_NEED_ACQUAINTANCES_REFRESH, (uint8_t*)[@"" UTF8String]);
}

- (void) needsAvailableUsersRefresh {
    DISPATCH_LOG_EVENT(self.context, @"Needs available users refresh.");

    DISPATCH_ANE_EVENT(self.context, EVENT_NEED_AVAILABLE_USERS_REFRESH, (uint8_t*)[@"" UTF8String]);
}

@end