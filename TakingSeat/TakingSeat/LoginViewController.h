//
//  LoginViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-27.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
@interface LoginViewController : UIViewController<WeiboSDKDelegate>
@property (weak, nonatomic) IBOutlet UIView *logview;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *Username;
- (IBAction)Login:(id)sender;
- (IBAction)swipe1:(id)sender;


@end
