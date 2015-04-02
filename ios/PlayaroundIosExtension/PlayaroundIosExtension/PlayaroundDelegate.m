#import "PlayaroundDelegate.h"
#import "ExtensionDefs.h"
#import "FlashRuntimeExtensions.h"

@implementation PlayaroundDelegate

- (id) initWithContext:(FREContext)context {
    self = [super init];
    
    if (!self)
        return nil;
    
    self.context = context;
    
    [NSNotificationCenter]
    return self;
}

-(void) promptForInstallingPlayAroundApplication:(id<PASInstallationMessageDelegate>)installationMessageDelegate {
    DISPATCH_LOG_EVENT(self.context, @"Prompt for installing Playaround app.");
    
    DISPATCH_ANE_EVENT(self.context, EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT, nil);
}

@end