
#import "SBJSON.h"

@protocol SensisAPIDataDelegate;

@interface SensisAPIDataFetcher : NSObject
{
	NSMutableDictionary* searchParams;
	SBJSON* sbJsonParser;
	id<SensisAPIDataDelegate> delegate_;
}

@property (assign) NSString* query;
@property (assign) NSString* location;

+(SensisAPIDataFetcher*) sharedSensisAPIDataFetcher;
-(void) beginWithDelegate:(id <SensisAPIDataDelegate>)delegate;

@end



@protocol SensisAPIDataDelegate <NSObject>
@required
-(void) didSucceedWithFetcher:(SensisAPIDataFetcher*)f result:(NSDictionary*)resultsDictionary;
-(void) didFailWithFetcher:(SensisAPIDataFetcher*)f errorCode:(int)errorCode errorMessage:(NSString*)errorMessage;
@end
