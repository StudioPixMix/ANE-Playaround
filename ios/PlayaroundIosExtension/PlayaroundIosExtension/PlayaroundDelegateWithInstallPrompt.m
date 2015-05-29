//
// Created by Benjamin Combes on 29/05/15.
// Copyright (c) 2015 studiopixmix. All rights reserved.
//

#import <PlayAround/PlayAround.h>
#import "PlayaroundDelegateWithInstallPrompt.h"
#import "ExtensionDefs.h"
#import "FlashRuntimeExtensions.h"


@implementation PlayaroundDelegateWithInstallPrompt
{

}

- (void) promptForInstallingPlayAroundApplication:(id<PASInstallationMessageDelegate>)installationMessageDelegate {
    DISPATCH_LOG_EVENT(self.context, @"Prompt for installing Playaround app.");

    DISPATCH_ANE_EVENT(self.context, EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT, (uint8_t*)[@"" UTF8String]);
}

@end