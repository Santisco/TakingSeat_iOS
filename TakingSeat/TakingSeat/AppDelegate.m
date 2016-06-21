//
//  AppDelegate.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-23.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "WeiboSDK.h"
#import "RootViewController.h"

#define appKey @"5b2655c71290"
#define appSecret @"55988074b9a3faadffa6f74cd3ae7845"


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize isLogin;
@synthesize value;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [SMS_SDK registerApp:appKey withSecret:appSecret];
    isLogin= NO;
   /* UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main.storyboard" bundle:nil];
    if (isLogin ==YES) {
        UIViewController *RootViewController  = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
        self.window.rootViewController =RootViewController;
    }
    if (isLogin ==NO) {
        UIViewController *RootViewController  = [storyBoard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        self.window.rootViewController =RootViewController;
    }
    [self.window makeKeyAndVisible];*/
    return YES;
  
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        //        NSString *title = @"发送结果";
        //        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
        //                                                        message:message
        //                                                       delegate:nil
        //                                              cancelButtonTitle:@"确定"
        //                                              otherButtonTitles:nil];
        //        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
@end
