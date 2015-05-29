#import "PlayaroundJsonObject.h"
#import <PlayAround/PlayAround.h>

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
                                      @(PASErrorIncompatible) :                         @"PASErrorIncompatible",
                                      @(PASErrorAvailableUsersNotLoaded) :              @"PASErrorAvailableUsersNotLoaded",
                                      @(PASErrorInitEmptySecretKey) :                   @"PASErrorInitEmptySecretKey",
                                      @(PASErrorInitEmptyUserId) :                      @"PASErrorInitEmptyUserId",
                                      @(PASErrorInitIncorrectSecretKey) :               @"PASErrorInitIncorrectSecretKey",
                                      @(PASErrorInternalSDK) :                          @"PASErrorInternalSDK",
                                      @(PASErrorWebservice) :                           @"PASErrorWebservice",
                                      @(PASErrorNetwork) :                              @"PASErrorNetwork",
                                      @(PASErrorUserDoeNotExist) :                      @"PASErrorUserDoeNotExist",
                                      @(PASUnknownError) :                              @"PASUnknownError",
                                      @(PASWarningPlayAroundSDKNotInitialized) :        @"PASWarningPlayAroundSDKNotInitialized",
                                      @(PASWarningPlayAroundApplicationNotInstalled) :  @"PASWarningPlayAroundApplicationNotInstalled",
                                      @(PASWarningSilentLoginUserNotLoggedIn) :         @"PASWarningSilentLoginUserNotLoggedIn",
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
    return @{
             @"id" :        [self getEmptyStringIfNull:user.userId],
             @"name" :      [self getEmptyStringIfNull:user.name],
             @"nickname" :  [self getEmptyStringIfNull:user.nickname],
             @"age" :       [NSNumber numberWithInteger:user.age],
             @"distance" :  [self getEmptyStringIfNull:user.distance],
             @"photoURL" :  [self getEmptyStringIfNull:user.photo]
    };
}

- (NSString*) getEmptyStringIfNull:(NSString *)string {
    if (string == nil)
        return @"";
    
    return string;
}


@end
