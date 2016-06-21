//
//  RegisterViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-25.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
- (IBAction)swipe1:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *stu_id;
@property (weak, nonatomic) IBOutlet UITextField *Label1;
@property (weak, nonatomic) IBOutlet UITextField *label2;
@property (weak, nonatomic) IBOutlet UITextField *label3;
@property (weak, nonatomic) IBOutlet UITextField *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UITextField *inPut;
@property (weak, nonatomic) IBOutlet UILabel *result;
- (IBAction)Register:(id)sender;
- (IBAction)getCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
- (IBAction)checkCode:(id)sender;

+(BOOL)isValidateEmail:(NSString *)email;
@end
