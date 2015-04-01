#import <Foundation/Foundation.h>
#import <PlayAround-iOS-SDK-v0.1.0/PlayAround.h>

@interface PlayaroundJsonObject : NSObject

@property id objectToConvert;

-(id) initWithError:(PASError*) error;
-(id) initWithUsers:(NSArray*) users;

-(uint8_t *) formatForDispatchEvent;

+(NSDictionary*) playaroundErrorsToStrings;

@end