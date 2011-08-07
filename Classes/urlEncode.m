
#import "urlEncode.h"

NSString* urlEncode(NSString *string)
{
	NSString *newString = [(NSString *)CFURLCreateStringByAddingPercentEscapes(
											kCFAllocatorDefault, 
											(CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), 
											CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) 
						   autorelease];
		
	return newString;

}
