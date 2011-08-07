

#import "ResultTableViewCell.h"

@implementation ResultTableViewCell

-(void) updateWithBusinessName:(NSString*)name address:(NSString*)address
{
	self.textLabel.text = name;
	self.detailTextLabel.text = address;
}

-(ResultTableViewCell*) initWithBusinessName:(NSString*)name address:(NSString*)address identifier:(NSString*)identifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    if (self) {
		self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		self.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];

		[self updateWithBusinessName:name address:address];
    }
    return self;
	
}

- (void)dealloc {
    [super dealloc];
}


@end
