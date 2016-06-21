//
//  RootViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-30.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <QuartzCore/CoreAnimation.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.0
                                                        green:0.69 blue:0.88 alpha:1.0]];
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],UITextAttributeTextColor,nil]];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: _mytake.bounds      byRoundingCorners:UIRectCornerTopLeft   cornerRadii:CGSizeMake(50,0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _mytake.bounds;
    maskLayer.path = maskPath.CGPath;
    _mytake.layer.mask = maskLayer;
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect: _myorder.bounds      byRoundingCorners:UIRectCornerTopRight   cornerRadii:CGSizeMake(50,0)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = _myorder.bounds;
    maskLayer1.path = maskPath1.CGPath;
    _myorder.layer.mask = maskLayer1;
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect: _mystatus.bounds      byRoundingCorners:UIRectCornerBottomLeft   cornerRadii:CGSizeMake(50,0)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = _mystatus.bounds;
    maskLayer2.path = maskPath2.CGPath;
    _mystatus.layer.mask = maskLayer2;
    UIBezierPath *maskPath3 = [UIBezierPath bezierPathWithRoundedRect: _mylogout.bounds      byRoundingCorners:UIRectCornerBottomRight  cornerRadii:CGSizeMake(50,0)];
    CAShapeLayer *maskLayer3 = [[CAShapeLayer alloc] init];
    maskLayer3.frame = _mylogout.bounds;
    maskLayer3.path = maskPath3.CGPath;
    _mylogout.layer.mask = maskLayer3;
    NSDate * now = [NSDate date];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSUInteger unitFlags= NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *dataComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year= [dataComponent year];
    NSInteger month = [dataComponent month];
    NSInteger day = [dataComponent day];
    NSInteger hour = [dataComponent hour];
    NSInteger minute = [dataComponent minute];
    NSInteger second = [dataComponent second];
    NSString * dataSource = [NSString stringWithFormat:@"%ld年%ld月%ld日%ld小时%ld分%ld秒",(long)year,(long)month,(long)day,(long)hour,(long)minute,(long)second];
    _datalable.text = dataSource;
    
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

- (IBAction)swipe1:(id)sender {
    [UIView animateWithDuration:1.0f
                     animations:^{
                         self.tabBarController.selectedIndex=1;}];

}

- (IBAction)logOut:(id)sender {
   realclumn =0;
    realrow =0;
    building =0;
    classroom =0;
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (delegate.isLogin ==NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
       /* for (int c =1; c<=4; c++) {
        for (int i=101; i<=106; i++) {
        NSString*Url = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/query/seat/%d/%d",c,i];
        NSURL *url = [NSURL URLWithString:Url];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        [request setDelegate:self];
        
        //   [request setUseCookiePersistence:NO];
        [request startSynchronous];
        NSData *resposeData = [request responseData];
        
        NSArray* resultData=[NSJSONSerialization JSONObjectWithData:resposeData options:NSJSONReadingMutableContainers error:nil];
        //   NSString *result =[resultData objectForKey:@"row"];
        NSLog(@"%@",resultData);
        NSLog(@"%lu",(unsigned long)[resultData count]);
        //   NSArray *keys = [resultData allKeys];
        // NSLog(@"%@",keys);
        for (int index=0;index<[resultData count]; index++) {
            NSString *status=[[resultData objectAtIndex:index]objectForKey:@"status"];
            NSString *row=[[resultData objectAtIndex:index]objectForKey:@"row"];
            NSString *real_status=[[resultData objectAtIndex:index]objectForKey:@"real_clumn"];
            NSInteger row1 = [row integerValue];
            NSInteger real_status1 = [real_status integerValue];
            if ([status isEqualToString:@"use"]) {
                realrow = row1;
                realclumn = real_status1;
                building =c;
                classroom =i;
            }
        }}}*/
        NSString*URL1 = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/using/onerelease"];
    
        NSURL *url = [NSURL URLWithString:URL1];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        NSDictionary *properties = [[NSMutableDictionary alloc] init];
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [properties setValue:delegate.value forKey:NSHTTPCookieValue];
        
        [properties setValue:@"laravel_session" forKey:NSHTTPCookieName];
        [properties setValue:@"219.216.96.47" forKey:NSHTTPCookieDomain];
        [properties setValue:@"/" forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
        
        
        //   NSLog(@"%@",cookie);
        [request setRequestCookies:[NSMutableArray arrayWithObject:cookie]];
        [request setRequestMethod:@"GET"];
        [request setDelegate:self];
        //   [request setUseCookiePersistence:NO];
        [request startSynchronous];
        NSString *response = [request responseString];
        if ([response isEqualToString:@"{\"error_code\":3000}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"仍未登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else if([response isEqualToString:@"{\"error_code\":4004}"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"下自习成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else if([response isEqualToString:@"{\"error_code\":3013}"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您还没有上自习" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else if([response isEqualToString:@"{\"error_code\":5002}"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您还没有上自习！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }

        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:response delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        
       /* NSString*URL = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/using/release/%ld/%ld/%ld/%ld",(long)building,(long)classroom,(long)realrow,(long)realclumn];
        NSLog(@"%ld %ld %ld %ld",building,classroom,realrow,realclumn);
        NSURL *url = [NSURL URLWithString:URL];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        NSDictionary *properties = [[NSMutableDictionary alloc] init];
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [properties setValue:delegate.value forKey:NSHTTPCookieValue];
        
        [properties setValue:@"laravel_session" forKey:NSHTTPCookieName];
        [properties setValue:@"219.216.96.47" forKey:NSHTTPCookieDomain];
        [properties setValue:@"/" forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
        
        
        //   NSLog(@"%@",cookie);
        [request setRequestCookies:[NSMutableArray arrayWithObject:cookie]];
        [request setRequestMethod:@"GET"];
        [request setDelegate:self];
        //   [request setUseCookiePersistence:NO];
        [request startSynchronous];
        NSString *response = [request responseString];
        if ([response isEqualToString:@"{\"error_code\":4004}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"下自习成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else if ([response isEqualToString:@"{\"error_code\":3007}"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"正在使用的用户不是当前用户！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:response delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
             [alertView show];
        }*/
    }}
- (IBAction)mySit:(id)sender {
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (delegate.isLogin ==NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        NSString*URL1 = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/query/persontaken"];
        
        NSURL *url = [NSURL URLWithString:URL1];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        NSDictionary *properties = [[NSMutableDictionary alloc] init];
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [properties setValue:delegate.value forKey:NSHTTPCookieValue];
        
        [properties setValue:@"laravel_session" forKey:NSHTTPCookieName];
        [properties setValue:@"219.216.96.47" forKey:NSHTTPCookieDomain];
        [properties setValue:@"/" forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
        
        
        //   NSLog(@"%@",cookie);
        [request setRequestCookies:[NSMutableArray arrayWithObject:cookie]];
        [request setRequestMethod:@"GET"];
        [request setDelegate:self];
        //   [request setUseCookiePersistence:NO];
        [request startSynchronous];
        NSString *response = [request responseString];

        NSData *resposeData = [request responseData];
        NSDictionary* resultData=[NSJSONSerialization JSONObjectWithData:resposeData options:NSJSONReadingMutableContainers error:nil];
        NSString *result =[resultData objectForKey:@"place"];
        

        //NSString *result =[respon valueForKey:@"place"];
        //   NSString *result =[resultData objectForKey:@"row"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:result delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [self performSegueWithIdentifier:@"link" sender:nil];
     /*       NSString *status=[resultData valueForKey:@"status"];
            NSInteger row1 = [row integerValue];
            NSInteger real_status1 = [real_status integerValue];

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您已登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];*/

    }
}

- (IBAction)swipe2:(id)sender {
    [UIView animateWithDuration:1.5f
                     animations:^{
       self.rootview.transform = CGAffineTransformMakeTranslation(180, 0);
                     }];
}

- (IBAction)tap1:(id)sender {
    if (self.rootview.frame.origin.x ==180) {
        [UIView animateWithDuration:1.5f
                         animations:^{
                             self.rootview.transform = CGAffineTransformMakeTranslation(0, 0);
                         }];

    }
}



- (IBAction)takeseat:(id)sender {
  /*  AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (delegate.isLogin==YES) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您已经登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else{*/
        [self performSegueWithIdentifier:@"link2" sender:nil];
    
}
@end
