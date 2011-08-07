
@interface ResultTableViewCell : UITableViewCell 
{

}

-(ResultTableViewCell*) initWithBusinessName:(NSString*)name address:(NSString*)address identifier:(NSString*)identifier;
-(void) updateWithBusinessName:(NSString*)name address:(NSString*)address;

@end
