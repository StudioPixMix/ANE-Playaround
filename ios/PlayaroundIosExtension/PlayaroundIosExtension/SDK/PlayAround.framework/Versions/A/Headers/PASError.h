//
//  PASError.h
//  PlayAroundSDK
//
//  Created by Benjamin Combes on 07/03/15.
//  Copyright (c) 2015 Benjamin Combes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    PASErrorIncompatible,
    PASErrorAvailableUsersNotLoaded,
    PASErrorInitEmptySecretKey,
    PASErrorInitEmptyUserId,
    PASErrorInitIncorrectSecretKey,
    PASErrorInternalSDK,
    PASErrorWebservice,
    PASErrorNetwork,
    PASErrorUserDoeNotExist,
    PASUnknownError,
    PASWarningPlayAroundSDKNotInitialized,
    PASWarningPlayAroundApplicationNotInstalled,
    PASWarningPlayAroundApplicationInstallation,
    PASWarningSilentLoginUserNotLoggedIn
} PlayAroundStatus;

@interface PASError : NSError

+ (PASError *)newWithType:(PlayAroundStatus)status;

+ (PASError *)webserviceWithType:(NSDictionary *)errorInfo;

@property(nonatomic, readonly) NSString *message;
@property(nonatomic, readonly) PlayAroundStatus status;

@end
