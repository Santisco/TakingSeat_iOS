//
//  SettingTableViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-10-31.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
- (IBAction)swipe1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *touxiang;

@end
