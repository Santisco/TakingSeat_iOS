//
//  RegisterViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-25.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "RegisterViewController.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <SMS_SDK/SMS_SDK.h>
@interface RegisterViewController ()


@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Register:(id)sender {
    BOOL isSwitch = true;
    NSString *errormessage;
    if ([_Label1 text] == nil ||[[_Label1 text] isEqualToString:@""]) {
        isSwitch =false;
        errormessage = @"邮箱不能为空！";
    }
    if ([_label2 text] == nil ||[[_label2 text] isEqualToString:@""]) {
        isSwitch =false;
        errormessage = @"手机号不能为空！";
    }
    if ([_label3 text] == nil ||[[_label3 text] isEqualToString:@""]) {
        isSwitch =false;
        errormessage = @"密码不能为空！";
        
    }
    if (![[_label3 text] isEqualToString: [_label4 text]]) {
        isSwitch =false;
        errormessage = @"两次密码输入不同！";

    }
    if (!isSwitch) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:errormessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSString*email = _Label1.text;
        NSString*password= _label3.text;
        NSString*stu_id=_stu_id.text;
        NSURL *url = [NSURL URLWithString:@"http://219.216.96.47/Takenseat/public/home/create"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:email forKey:@"email"];
        [request setPostValue:password forKey:@"password"];
        [request setPostValue:stu_id forKey:@"stu_id"];
        [request setRequestMethod:@"POST"];
        [request startSynchronous];
        
            
            NSString *response = [request responseString];
 
     //   NSString *response = [request responseString];
        if ([response isEqualToString:@"{\"error_code\":4002}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
       else if ([response isEqualToString:@"{\"error_code\":3004}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"邮箱格式错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
       else if ([response isEqualToString:@"{\"error_code\":3005}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"邮箱已被注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else if ([response isEqualToString:@"{\"error_code\":3006}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"密码格式不对" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:response delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        }
    }
    

}

- (IBAction)getCode:(id)sender {
    NSString *zoneText = self.label5.text;
    NSString *phoneText = self.label2.text;
    
    self.result.text = @"正在发送 短信验证码...";
    [SMS_SDK getVerificationCodeBySMSWithPhone:phoneText
                                          zone:zoneText
                                        result:^(SMS_SDKError *error)
     {
         if (error){
             self.result.text = [NSString stringWithFormat:@"发送失败 状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription];
         }else{
             self.result.text = @"发送成功.";
         }
     }];

}
- (IBAction)checkCode:(id)sender {
    self.result.text = @"正在验证 code码...";
    [SMS_SDK commitVerifyCode:_inPut.text result:^(enum SMS_ResponseState state){
        switch (state) {
            case SMS_ResponseStateGetVerifyCodeFail:
            {
                self.result.text = @"验证失败";
            } break;
            case SMS_ResponseStateGetVerifyCodeSuccess:
            {
                self.result.text = @"验证成功";
            } break;
                
            default:
                self.result.text = @"未知状态";
                break;
        }
    }];
}
- (IBAction)swipe1:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];}
@end
