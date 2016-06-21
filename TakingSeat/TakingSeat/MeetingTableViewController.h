//
//  MeetingTableViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-10-20.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetingTableViewController : UITableViewController<UIGestureRecognizerDelegate>
{
    NSInteger m;
}
- (IBAction)swipe1:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *H1;
@property (weak, nonatomic) IBOutlet UILabel *H2;
@property (weak, nonatomic) IBOutlet UILabel *J1;
@property (weak, nonatomic) IBOutlet UILabel *J2;
@property (weak, nonatomic) IBOutlet UILabel *C1;
@property (weak, nonatomic) IBOutlet UILabel *C2;
@property (weak, nonatomic) IBOutlet UILabel *H1N;
@property (weak, nonatomic) IBOutlet UILabel *H2N;
@property (weak, nonatomic) IBOutlet UILabel *J1N;
@property (weak, nonatomic) IBOutlet UILabel *J2N;
@property (weak, nonatomic) IBOutlet UILabel *C1N;
@property (weak, nonatomic) IBOutlet UILabel *C2N;
- (IBAction)swipe2:(id)sender;

@end
