#import "PlayaroundJsonObject.h"
#import <PlayAround-iOS-SDK-v0.1.0/PlayAround.h>

#define playaroundErrorToString(enum) [@[@"value1",@"value2",@"value3"] objectAtIndex:enum]

@implementation PlayaroundJsonObject

-(uint8_t *) formatForDispatchEvent {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.objectToConvert options:NSJSONWritingPrettyPrinted error:nil];
    
    return (uint8_t*)[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] UTF8String];
}

-(id) initWithError:(PASError*) error {
    self = [super init];
    
    if (!self)
        return nil;
    
    self.objectToConvert = [NSDictionary dictionaryWithObjectsAndKeys:
                                [[PlayaroundJsonObject playaroundErrorsToStrings] objectForKey:@(error.status)], @"status",
                                error.message, @"message",
                                nil];
    
    return self;
}

+(NSDictionary*) playaroundErrorsToStrings
{
    static NSDictionary* playaroundErrorsToStrings = nil;
    
    if (playaroundErrorsToStrings == nil) {
        playaroundErrorsToStrings = @{
                                      @(PASErrorUncompatible) :                         @"PASErrorUncompatible",
                                      @(PASErrorAvailableUsersNotLoaded) :              @"PASErrorAvailableUsersNotLoaded",
                                      @(PASErrorInitEmptySecretKey) :                   @"PASErrorInitEmptySecretKey",
                                      @(PASErrorInitEmptyUserId) :                      @"PASErrorInitEmptyUserId",
                                      @(PASErrorInitIncorrectSecretKey) :               @"PASErrorInitIncorrectSecretKey",
                                      @(PASErrorInternalSDK) :                          @"PASErrorInternalSDK",
                                      @(PASErrorWebservice) :                           @"PASErrorWebservice",
                                      @(PASErrorNetwork) :                              @"PASErrorNetwork",
                                      @(PASErrorUserDoeNotExist) :                      @"PASErrorUserDoeNotExist",
                                      @(PASUnknowError) :                               @"PASUnknowError",
                                      @(PASWarningPlayAroundSDKNotInitialized) :        @"PASWarningPlayAroundSDKNotInitialized",
                                      @(PASWarningPlayAroundApplicationNotInstalled) :  @"PASWarningPlayAroundApplicationNotInstalled",
                                      @(PASWarninSilentLoginUserNotLoggedIn) :          @"PASWarninSilentLoginUserNotLoggedIn",
                                      };
    }
    
    return playaroundErrorsToStrings;
}


- (id) initWithUsers:(NSArray *)users {
    self = [super init];
    
    if (!self)
        return nil;
    
    self.objectToConvert = [[NSMutableArray alloc] init];
    
    for (PASUser *user in users)
        [self.objectToConvert addObject:[self buildJSONDictionaryOfUser:user]];
    
    return self;
}

- (NSDictionary *) buildJSONDictionaryOfUser:(PASUser *)user {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            user.userId,    @"id",
            user.name,      @"name",
            user.nickname,  @"nickname",
            user.age,       @"age",
            user.distance,  @"distance",
            user.photo,     @"photoURL",
            nil];
}
@end
