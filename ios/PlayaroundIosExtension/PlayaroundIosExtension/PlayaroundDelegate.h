#import <PlayAround/PlayAround.h>
#import "FlashRuntimeExtensions.h"

@interface PlayaroundDelegate : NSObject<PASDelegate>

@property FREObject context;
@property BOOL useDefaultInstallPromptDialog;

-(id) initWithContext:(FREContext)context;
@end
