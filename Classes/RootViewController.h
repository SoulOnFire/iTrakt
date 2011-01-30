#import <UIKit/UIKit.h>
#import "Episode.h"

@interface RootViewController : UITableViewController {
  NSArray *broadcastDates;
}

@property (nonatomic, retain) NSArray *broadcastDates;

- (void)ensureShowPosterIsloaded:(Episode *)episode forCellAtIndexPath:(NSIndexPath *)indexPath;

@end
