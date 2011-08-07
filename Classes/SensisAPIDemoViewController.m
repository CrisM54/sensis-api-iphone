

#import "SensisAPIDemoViewController.h"
#import "ResultTableViewCell.h"

@implementation SensisAPIDemoViewController

@synthesize resultsTableView=resultsTableView_;

- (void)viewLoad {
	apiResults = [[NSArray alloc] init];
}


- (void)dealloc {
	[apiResults release];
    [super dealloc];
}

#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBarSender
{
	[searchBarSender setShowsCancelButton:TRUE animated:TRUE];
	return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBarSender
{
	[searchBarSender setShowsCancelButton:FALSE animated:TRUE];
	[searchBarSender resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBarSender
{
	[searchBarSender setShowsCancelButton:FALSE animated:TRUE];
	[searchBarSender resignFirstResponder];
	
	SensisAPIDataFetcher* dataFetcher = [SensisAPIDataFetcher sharedSensisAPIDataFetcher]; 
	dataFetcher.query = searchBarSender.text;
	dataFetcher.location = @"3000";
	[dataFetcher beginWithDelegate:self];
	
	loadingView = [[LoadingView alloc] init];
	loadingView.center = CGPointMake(160, 240);
	[self.view addSubview:loadingView];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [apiResults count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* businessName = [[apiResults objectAtIndex:[indexPath row]] objectForKey:@"name"];
	NSDictionary* addressDict = [[apiResults objectAtIndex:[indexPath row]] objectForKey:@"primaryAddress"];
	NSString* addressLine = [addressDict objectForKey:@"addressLine"];
	
	static NSString* identifier = @"ResultTableViewCell";
	ResultTableViewCell* cell = (ResultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(cell!=nil)
	{
		[cell updateWithBusinessName:businessName address:addressLine];
		return cell;
	}
	else
	{
		return [[[ResultTableViewCell alloc] initWithBusinessName:businessName address:addressLine identifier:identifier] autorelease];
	}
}

#pragma mark UITableViewDataSource

-(void) didSucceedWithFetcher:(SensisAPIDataFetcher*)f result:(NSDictionary*)results
{
	[apiResults release];
	apiResults = [[results objectForKey:@"results"] retain];
	
	[loadingView removeFromSuperview];
	[loadingView release];
	loadingView = nil;
	
	[resultsTableView_ reloadData];
}

-(void) didFailWithFetcher:(SensisAPIDataFetcher*)f errorCode:(int)errorCode errorMessage:(NSString*)errorMessage
{
	[loadingView removeFromSuperview];
	[loadingView release];
	loadingView = nil;
	
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"An error occured"
														 message:errorMessage
														delegate:self
											   cancelButtonTitle:@"Dismiss"
											   otherButtonTitles:nil] autorelease];
	[alertView show];
}


@end
