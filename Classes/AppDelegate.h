

#import <UIKit/UIKit.h>

@class SensisAPIDemoViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SensisAPIDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SensisAPIDemoViewController *viewController;

@end

