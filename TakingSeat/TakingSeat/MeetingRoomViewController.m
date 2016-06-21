//
//  MeetingRoomViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-11-4.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "MeetingRoomViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"

@interface MeetingRoomViewController ()

@end

@implementation MeetingRoomViewController
@synthesize num;
@synthesize classroom;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _number.text = num;
    classroom.text = _room;
    NSLog(@"%@ %@",num,_room);
    
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

- (IBAction)order:(id)sender {
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (delegate.isLogin==true) {
    NSURL *url = [NSURL URLWithString:@"http://219.216.96.47/Takenseat/public/api/order/orderboardroom/1/101/2015-6-15%2008:00/2015-6-15%2012:00"];
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
    //   [request setUseCookiePersistence:NO];
    [request startSynchronous];
    NSString *response = [request responseString];   
    if ([response isEqualToString:@"{\"error_code\":4007}"]) {
        UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:@"自习室预定成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView2 show];
    }
    else{
        UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:response delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView2 show];
    }
    }
    else if(delegate.isLogin ==NO)
    {
        UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:@"请先登陆！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView2 show];

    }
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
