//
//  PASError.h
//  PlayAroundSDK
//
//  Created by Benjamin Combes on 07/03/15.
//  Copyright (c) 2015 Benjamin Combes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	PASErrorUncompatible,
	PASErrorAvailableUsersNotLoaded,
	PASErrorInitEmptySecretKey,
	PASErrorInitEmptyUserId,
	PASErrorInitIncorrectSecretKey,
	PASErrorInternalSDK,
	PASErrorWebservice,
	PASErrorNetwork,
	PASErrorUserDoeNotExist,
	PASUnknowError,
	PASWarningPlayAroundSDKNotInitialized,
	PASWarningPlayAroundApplicationNotInstalled,
	PASWarninSilentLoginUserNotLoggedIn
} PlayAroundStatus;

@interface PASError : NSError

+ (PASError*)newWithType:(PlayAroundStatus)status;
+ (PASError*)webserviceWithType:(NSDictionary*)errorInfo;

@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) PlayAroundStatus status;

@end
