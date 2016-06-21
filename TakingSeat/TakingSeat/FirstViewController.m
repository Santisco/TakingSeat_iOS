//
//  FirstViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-12-5.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "FirstViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
@interface FirstViewController ()
{
    int i;
    int m;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _namefield.borderStyle = UITextBorderStyleNone;
    _passfield.borderStyle = UITextBorderStyleNone;
    _headview.layer.masksToBounds =YES;
    _headview.layer.cornerRadius = 50;
    i=0;
    m=0;

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

- (IBAction)select:(id)sender {
            CGRect rect=self.namelist.frame;
    switch (i) {
        case 0:
        {   rect.size.width = 380;
            rect.size.height =150;
            
            [UIView animateWithDuration:0.1 animations:^{
                _selector.imageView.transform = CGAffineTransformRotate(_selector.imageView.transform, DEGREES_TO_RADIANS(180));
                self.namelist.frame = rect;
            }];
            i=1;
            _denglu.hidden =YES;
            _zhuce.hidden =YES;
            break;}
            
       case 1:
        {   rect.size.width = 380;
            rect.size.height =1;
            
            [UIView animateWithDuration:0.1 animations:^{
                _selector.imageView.transform = CGAffineTransformRotate(_selector.imageView.transform, DEGREES_TO_RADIANS(180));
                self.namelist.frame = rect;
            }];
            i=0;
            _denglu.hidden =NO;
            _zhuce.hidden =NO;
            break;}
    }
    
    
}


- (IBAction)login:(id)sender {
    bool isSwitch = true;
    NSString *errorMessage;
    NSString *username = self.namefield.text;
    NSString *password = self.passfield.text;
    if (!username || [username isEqualToString:@""])
    {
        isSwitch = false;
        errorMessage = @"账号不能为空";
    }
    else if (!password || [password isEqualToString:@""])
    {
        isSwitch = false;
        errorMessage = @"密码不能为空";
    }
    if (!isSwitch)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    } else {
        
         [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
        [self performSelector:@selector(dojob) withObject:nil afterDelay:2.0];

    }

}
- (void)dojob{
    NSString *username = self.namefield.text;
    NSString *password = self.passfield.text;
    NSURL *url = [NSURL URLWithString:@"http://219.216.96.47/Takenseat/public/home/loginIn"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"email"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    //    [request setUseCookiePersistence:NO];
    [request responseCookies];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    NSError *error = [request error];
    NSData *resposeData = [request responseData];
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        
        NSDictionary *cook = cookie;
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        delegate.value=[cookie valueForKey:@"value"];
        
        
        NSLog(@"%@", delegate.value);
    }

    if ([response isEqualToString:@"{\"error_code\":4001}"]) {
        [SVProgressHUD dismissWithSuccess:@"登陆成功"];
        
        [self performSegueWithIdentifier:@"link" sender:nil];
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        delegate.isLogin=YES;
        
        
        
    }
    else if([response isEqualToString:@"{\"error_code\":3003}"])
    {
        [SVProgressHUD dismissWithError:@"密码错误"];
    }
    else
    {
        [SVProgressHUD dismissWithError:@"网络状况出错"];
    }
    
}

- (IBAction)select1:(id)sender {
    
    self.duihao.hidden=YES;
    switch (m) {
        case 0:
            _duihao.hidden =YES;
            m=1;
            break;
            
        case 1:
            _duihao.hidden =NO;
            m=0;
            break;
    }
}
@end
