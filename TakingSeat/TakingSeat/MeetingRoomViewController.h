//
//  MeetingRoomViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-11-4.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingTableViewController.h"

@interface MeetingRoomViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *classroom;
- (IBAction)order:(id)sender;
- (IBAction)cancel:(id)sender;

@property (strong,nonatomic) NSString*room;
@property (strong,nonatomic) NSString*num;
@end
