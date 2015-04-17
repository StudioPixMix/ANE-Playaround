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

/**
* Returns shared instance of PlayAround object. Must be initialized prior to use with any "sharedInstanceWith" method
*/
+ (id)sharedInstance;

/// ---------------------------------
/// Initialization
/// ---------------------------------

/**
* Returns initialized shared instance of PlayAround object
* @param secretKey  Secret key of your PlayAround developer account.
* @param userId     The ID of the user currently playing your app.
*/
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId;

/**
* Returns initialized shared instance of PlayAround object
* @param secretKey      Secret key of your PlayAround developer account.
* @param userId         The ID of the user currently playing your app.
* @param userNickname   The nickname of the user currently playing your app.
*/
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId userNickname:(NSString *)userNickname;

/**
* Returns initialized shared instance of PlayAround object
* @param secretKey  Secret key of your PlayAround developer account.
* @param userId     The ID of the user currently playing your app.
* @param delegate   A delegate, used if you want to customize install prompt popup.
*/
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId delegate:(id<PASDelegate>)delegate;

/**
* Returns initialized shared instance of PlayAround object
* @param secretKey      Secret key of your PlayAround developer account.
* @param userId         The ID of the user currently playing your app.
* @param userNickname   The nickname of the user currently playing your app.
* @param delegate       A delegate, used if you want to customize install prompt popup.
*/
+ (PlayAround*)sharedInstanceWithSecretKey:(NSString*)secret userId:(NSString*)userId userNickname:(NSString *)userNickname delegate:(id<PASDelegate>)delegate;

/// ---------------------------------
/// URL Scheme
/// ---------------------------------

/**
* Method to be called when your AppDelegate's application:openURL:sourceApplication:annotation: is called
*/
+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

/// ---------------------------------
/// Configuration
/// ---------------------------------

/**
* Sets the ID of the user currently playing your app.
*/
- (void)setUserId:(NSString*)userId;

/**
* Sets the nicknameof the user currently playing your app.
*/
- (void)setUserNickname:(NSString*)nickname;

/// ---------------------------------
/// Miscellaneous
/// ---------------------------------

/**
* Checks is the SDK is compatible with the current app.
* iOS required minimum version is iOS 7.
*
* @return true if compatible, else false.
*/
+ (BOOL)isCompatible;

/**
* Sets the SDK debug mode, to log debug information.
*
* @param debug YES to be in debug mode.
*/
+ (void)setDebug:(BOOL)debug;

/// ---------------------------------
/// Main SDK tasks
/// ---------------------------------

/**
* Get the list of single users near the current user.
* If no error occurred, it will return a list of 0 to 5 users.
* If the PlayAround app isn't installed on the current device, the user will be asked to install it.
* If the user isn't logged in the PlayAround app, the user will be redirected to the login screen in the PlayAround app.
* If the PlayAround app is already installed and the user is already logged in, this operation will be transparent for the user.
*
* @param completionBlock The completion block with retrieved users or error.
*/
- (void)getAvailableUsers:(PASAvailableUsersBlock)completionBlock;

/**
* Get the list of all the  users with whom the current user had an acquaintance (registered with @postAcquaintanceEvent).
*
* @param completionBlock The completion block with retrieved users or error.
*/
- (void)getAcquaintances:(PASAcquaintancesBlock)completionBlock;

/**
* Registers that an acquaintance event occurred between the current user and an available user.
* It has to be used when the current user interacted with an external user ; for example the user started a duel with an external user, challenged him in a battle etc.
* Can only be called once with the same {userId}.
*
* @param userId             User ID of the external user.
* @param completionBlock    The completion block, possibly with an error.
*/
- (void)postAcquaintanceEvent:(NSString*)userId completion:(PASEventBlock)completionBlock;

/**
* Checks if a user has an acquaintance with the current user.
*
* @param userId             The ID of the user.
* @param completionBlock    The completion block with retrieved users or error.
*/
- (void)isAcquaintedWith:(NSString*)userId completion:(PASIsUserAcquaintanceBlock)completionBlock;


@end




