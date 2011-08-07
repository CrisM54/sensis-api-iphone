
#import "LoadingView.h"

@implementation LoadingView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
		self.alpha = 0.75f;
		
		UIActivityIndicatorView* activityInd = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)] autorelease];
		activityInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
		activityInd.center = CGPointMake(160,240);
		[self addSubview:activityInd];
		[activityInd startAnimating];
		
		UILabel* loadingLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 24)] autorelease];
		loadingLabel.textAlignment = UITextAlignmentCenter;
		loadingLabel.font = [UIFont fontWithName:@"ArialMT" size:20.0];
		loadingLabel.textColor = [UIColor whiteColor];
		loadingLabel.center = CGPointMake(160,240-45);
		loadingLabel.backgroundColor = [UIColor clearColor];
		loadingLabel.text = @"Fetching results";
		[self addSubview:loadingLabel];
		
		
    }
    return self;
}

- (id)init
{
	return [self initWithFrame:CGRectMake(0, 0, 320, 480)];
}

- (void)dealloc {
    [super dealloc];
}


@end
