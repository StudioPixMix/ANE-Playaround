#import <PlayAround/PlayAround.h>
#import "FlashRuntimeExtensions.h"

@interface PlayaroundDelegate : NSObject<PASDelegate>

@property FREObject context;

-(id) initWithContext:(FREContext)context;
@end
