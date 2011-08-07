#import "SensisAPIDataFetcher.h"
#import "LoadingView.h"

@interface SensisAPIDemoViewController : UIViewController 
	<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SensisAPIDataDelegate>
{
	NSArray* apiResults;
	UITableView* resultsTableView_;
	LoadingView* loadingView;
}

@property (assign) IBOutlet UITableView* resultsTableView;

@end

