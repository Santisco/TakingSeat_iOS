//
//  LogoutViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-10-30.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "LogoutViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SVProgressHUD.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

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

- (IBAction)Logout:(id)sender {
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
    [self performSelector:@selector(dojob) withObject:nil afterDelay:2.0];
}
- (void)dojob{
    NSURL *url = [NSURL URLWithString:@"http://219.216.96.47/Takenseat/public/home/logout"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    //    [request setUseCookiePersistence:NO];
    [request setRequestMethod:@"GET"];
    [request responseCookies];
    [request startSynchronous];
    NSString*responce = [request responseString];
    if ([responce isEqualToString:@"{\"error_code\":4003}"]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        delegate.isLogin=NO;
        [SVProgressHUD dismissWithSuccess:@"注销成功"];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *firstController = [storyBoard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        /*        delegate.window.rootViewController = firstController;
         [delegate.window makeKeyAndVisible];*/
        //FirstViewController*Firstview = [[FirstViewController alloc]init];

        [self presentViewController:firstController animated:YES completion:nil];
    }
}
@end
