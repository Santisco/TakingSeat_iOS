//
//  LoginViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-27.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "LoginViewController.h"
 #import "ASIHTTPRequest.h"
 #import "ASIFormDataRequest.h"
#import "AppDelegate.h"


@interface LoginViewController ()

@end

@implementation LoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self makeTabBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Login:(id)sender {
    bool isSwitch = true;
    NSString *errorMessage = @"";
    NSString *username = self.Username.text;
    NSString *password = self.Password.text;
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

        NSURL *url = [NSURL URLWithString:@"http://219.216.96.47/Takenseat/public/home/loginIn"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:username forKey:@"email"];
        [request setPostValue:password forKey:@"password"];
        [request setDelegate:self];
    //    [request setUseCookiePersistence:NO];
        [request responseCookies];
        [request startSynchronous];
       // NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        //for (NSHTTPCookie *cookie in [cookieJar cookies]) {
          //  NSLog(@"%@", cookie);
        
        NSString *response = [request responseString];
        NSError *error = [request error];
        NSData *resposeData = [request responseData];
        
     //   NSDictionary* resultData=[NSJSONSerialization JSONObjectWithData:resposeData options:NSJSONReadingMutableContainers error:nil];
     //   NSString *result =[resultData objectForKey:@"error_code"];
       // NSLog(@"%@",result);
      //  NSString *cookieString = [[response allHeaderFields] valueForKey:@"value"];
         NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
           // NSArray* resultData=[NSJSONSerialization JSONObjectWithData:cookie options:NSJSONReadingMutableContainers error:nil];
          //    NSString *value =[cookie objectForKey:@"value"];
           // NSString *cookieString = [[response allHeaderFields] valueForKey:@"value"];
         //   NSLog(@"%@",resultData);
         //   NSLog(@"%lu",(unsigned long)[resultData count]);
            //   NSArray *keys = [resultData allKeys];
            // NSLog(@"%@",keys);
           // for (int index=0;index<[resultData count]; index++) {
            NSDictionary *cook = cookie;
            AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
               delegate.value=[cookie valueForKey:@"value"];

            
            NSLog(@"%@", delegate.value);
        }
        if ([response isEqualToString:@"{\"error_code\":4001}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"登陆成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            self.logview.hidden = NO;
         //   NSURL *urL = [NSURL URLWithString:@"http://219.216.96.47/Takenseat/public/api/using/take/1/101/2/7"];
            
        //    ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:urL];
          //  NSDictionary *properties = [[NSMutableDictionary alloc] init];
          //  [properties setValue:[NSString stringWithFormat:@"4001"  forKey:NSHTTPCookieValue];
            
          //  [properties setValue:@"4001" forKey:NSHTTPCookieName];
            //[properties setValue:@"4001" forKey:NSHTTPCookieDomain];
            //[properties setValue:@"/" forKey:NSHTTPCookiePath];
            //NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
            
            //NSLog(@"%@",cookie);
          //  [request1 setRequestCookies:[NSMutableArray arrayWithObject:cookie]];
           // [request setRequestCookies:[NSMutableArray arrayWithObject:@"4001"]];
      //      [request1 setRequestMethod:@"GET"];
        //    [request1 setDelegate:self];
          //  [request1 startSynchronous];
       //     NSError *error = [request error];
            
          //  if (!error) {
                
         //       NSString * responsem = [request1 responseString];
                //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:responsem //delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
              //  [alertView show];
                
       //     }

           AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            delegate.isLogin=YES;
            

            //用模态跳转到主界面
   /*         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            
            id mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainView"];
            
            [self presentViewController:mainViewController animated:YES completion:^{
            }];
*/

        }
        else if([response isEqualToString:@"{\"error_code\":3003}"])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
        else
            {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"no"
                                                                    delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
          
        }

    
    }

- (IBAction)swipe1:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}
@end

