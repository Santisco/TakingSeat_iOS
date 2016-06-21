//
//  SelfInformationViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-11-24.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInformationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *selfimage;
- (IBAction)check:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *selfview;
- (IBAction)dismiss:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *information;

@end
