//
//  RootViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-30.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIGestureRecognizerDelegate>
{
    NSInteger realrow;
    NSInteger realclumn;
    NSInteger classroom;
    NSInteger building;
}
@property (weak, nonatomic) IBOutlet UIView *rootview;
@property (weak, nonatomic) IBOutlet UILabel *datalable;
@property (weak, nonatomic) IBOutlet UIButton *myorder;
- (IBAction)swipe1:(id)sender;
- (IBAction)logOut:(id)sender;
- (IBAction)mySit:(id)sender;
- (IBAction)swipe2:(id)sender;
- (IBAction)tap1:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *mytake;
@property (weak, nonatomic) IBOutlet UIButton *mystatus;
@property (weak, nonatomic) IBOutlet UIButton *mylogout;
- (IBAction)takeseat:(id)sender;

@end
