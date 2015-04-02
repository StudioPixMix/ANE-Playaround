//
//  PlayAround.h
//  PlayAroundSDK
//
//  Created by Marc Bounthong on 07/03/15.
//  Copyright (c) 2015 Marc Bounthong. All rights reserved.
//

#import "PASUser.h"
#import "PASError.h"

typedef void (^PASAvailableUsersBlock)(NSArray *users, PASError *error);
typedef void (^PASAcquaintancesBlock)(NSArray *users, NSArray *ids, PASError *error);
typedef void (^PASIsUserAcquaintanceBlock)(BOOL isAcquainted, PASError *error);
typedef void (^PASEventBlock)(PASError *error);


@protocol PASInstallationMessageDelegate
@required
- (void)didAcceptPlayAroundInstallation:(BOOL)accepted;
@end

@protocol PASDelegate
@optional
- (void)promptForInstallingPlayAroundApplication:(id<PASInstallationMessageDelegate>)installationMessageDelegate;
@end

@interface PlayAround : NSObject<PASInstallationMessageDelegate>


@property (nonatomic, assign) id<PASDelegate> delegate;

// Singleton
+ (id)sharedInstance;

// Init
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId;
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId userNickname:(NSString *)userNickname;
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId delegate:(id<PASDelegate>)delegate;
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId userNickname:(NSString *)userNickname delegate:(id<PASDelegate>)delegate;

+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

- (void)setUserId:(NSString*)userId;
- (void)setUserNickname:(NSString*)nickname;

// Config tools
+ (BOOL)isCompatible;
+ (void)setDebug:(BOOL)debug;

// Webservice
- (void)getAvailableUsers:(PASAvailableUsersBlock)completionBlock;
- (void)getAcquaintances:(PASAcquaintancesBlock)completionBlock;
- (void)postAcquaintanceEvent:(NSString*)userId completion:(PASEventBlock)completionBlock;

- (void)isAcquaintedWith:(NSString*)userId completion:(PASIsUserAcquaintanceBlock)completionBlock;


@end




