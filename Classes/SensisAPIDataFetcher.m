

#import "SensisAPIDataFetcher.h"
#import "ASIHTTPRequest.h"
#import "urlEncode.h"
#import "SensisAPIKey.h"

#define SEARCH_URL @"http://api.sensis.com.au/20110229/search?key=" API_KEY

@implementation SensisAPIDataFetcher

- (id)init
{
    self = [super init];
    if (self) 
	{
		searchParams = [[NSMutableDictionary alloc] init];
		sbJsonParser = [[SBJSON alloc] init];
		
		[searchParams setObject:@"20" forKey:@"rows"];
    }
    return self;
}


- (void)dealloc 
{
	[searchParams release];
	[sbJsonParser release];
	[super dealloc];
}


+(SensisAPIDataFetcher*) sharedSensisAPIDataFetcher
{
	static SensisAPIDataFetcher* sharedSensisAPIDataFetcher = nil;
	if(!sharedSensisAPIDataFetcher)
		sharedSensisAPIDataFetcher = [[SensisAPIDataFetcher alloc] init];
	
	return sharedSensisAPIDataFetcher;
}


- (ASIHTTPRequest*) createSearchRequest
{
	NSMutableString* urlString = [NSMutableString stringWithString:SEARCH_URL];
	for(NSString* key in searchParams)
	{
		NSMutableString* value = [searchParams objectForKey:key];
		[urlString appendFormat:@"&%@=%@",key,urlEncode(value),nil];
	}

#ifdef DEBUG
	NSLog(@"createSearchRequest: %@",urlString);
#endif

	ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
	request.timeOutSeconds = 20.0f;
	request.delegate = self;
	[request setDidFinishSelector:@selector(ASIHTTPRequestFinished:)];
	[request setDidFailSelector:@selector(ASIHTTPRequestFailed:)];
	return request;
}

-(void) beginWithDelegate:(id <SensisAPIDataDelegate>)delegate
{
	NSAssert([[searchParams objectForKey:@"query"] length] > 0,@"query parameter is required");
	NSAssert([[searchParams objectForKey:@"location"] length] > 0,@"location parameter is required");
	
	ASIHTTPRequest* request = [self createSearchRequest];
	[request startAsynchronous];
	delegate_ = [delegate retain];
}

#pragma mark Properties

-(NSString*) query
{ 
	return [searchParams objectForKey:@"query"];
}
-(void) setQuery:(NSString*)query 
{
	[searchParams setValue:query forKey:@"query"];
}

-(NSString*) location 
{
	return [searchParams objectForKey:@"location"]; 
}
-(void) setLocation:(NSString*)location 
{
	[searchParams setValue:location forKey:@"location"];
}


#pragma mark ASIHTTP Delegate

- (void) ASIHTTPRequestFailed:(ASIHTTPRequest *)request
{
	NSDictionary* result = [sbJsonParser objectWithString:[request responseString]];

	int code = [[result objectForKey:@"code"] intValue];
	NSString* message = [result objectForKey:@"message"];
	
	[delegate_ didFailWithFetcher:self errorCode:code errorMessage:message];

	[delegate_ release];
}


- (void) ASIHTTPRequestFinished:(ASIHTTPRequest *)request
{
#ifdef DEBUG
	NSLog(@"%@", [request responseString]);
#endif	
	
	if(request.responseStatusCode != 200)
	{
		[self ASIHTTPRequestFailed:request];
		return;
	}

	NSDictionary* result = [sbJsonParser objectWithString:[request responseString]];
	[delegate_ didSucceedWithFetcher:self result:result];
	[delegate_ release];
}

@end
