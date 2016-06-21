//
//  ViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-23.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "DropDownListView.h"
#import "SVProgressHUD.h"

@interface ViewController ()
{
    NSMutableArray *chooseArray ;
    DropDownListView*dropDownView;
    NSInteger seat ;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.9 green:0.4 blue:0.7 alpha:0.8];
    for (int i=10001; i<110009; i++) {
        UIButton *bt=(UIButton *)[self.view viewWithTag:i];
        bt.layer.cornerRadius = 3;
    }
    self.title = @"占座";
    chooseArray = [NSMutableArray arrayWithArray:@[
                                                   @[@"101",@"102",@"103",@"104",@"105",@"106"],
                                                   @[@"逸夫楼",@"采矿馆",@"大成",@"何世礼"],
                                                   ]];
    
   dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,60, self.view.frame.size.width, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.view addSubview:dropDownView];
    if ([dropDownView.mbutton.titleLabel.text isEqualToString:@"逸夫楼"]) {
        for (int i=10001; i<110009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor colorWithRed:0.35 green:0.45 blue:0.4 alpha:0.3];
        }
        for (int i=40001; i<40009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        for (int i=80001; i<80009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        NSString*Url = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/query/seat/1/101"];
        NSURL *url = [NSURL URLWithString:Url];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        [request setDelegate:self];
        
        //   [request setUseCookiePersistence:NO];
        [request startSynchronous];
        NSData *resposeData = [request responseData];
        
        NSArray* resultData=[NSJSONSerialization JSONObjectWithData:resposeData options:NSJSONReadingMutableContainers error:nil];
        //   NSString *result =[resultData objectForKey:@"row"];
        //   NSArray *keys = [resultData allKeys];
        // NSLog(@"%@",keys);
        for (int index=0;index<[resultData count]; index++) {
            NSString *status=[[resultData objectAtIndex:index]objectForKey:@"status"];
            NSString *row=[[resultData objectAtIndex:index]objectForKey:@"row"];
            NSString *real_status=[[resultData objectAtIndex:index]objectForKey:@"real_clumn"];
            NSInteger row1 = [row integerValue];
            NSInteger real_status1 = [real_status integerValue];
            if ([status isEqualToString:@"order"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor greenColor];
            }
            if ([status isEqualToString:@"use"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor redColor];
            }

        
    }

    
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{

}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        dropDownView.chooseCellTitle = [self titleInSection:dropDownView.currentExtendSection index:indexPath.row];
        
        
        UIButton *currentSectionBtn = (UIButton *)[dropDownView viewWithTag:SECTION_BTN_TAG_BEGIN +dropDownView.currentExtendSection];
        firstbutton = (UIButton *)[dropDownView viewWithTag:SECTION_BTN_TAG_BEGIN];
        [currentSectionBtn setTitle:dropDownView.chooseCellTitle forState:UIControlStateNormal];
        
        [dropDownView.dropDownDelegate chooseAtSection:dropDownView.currentExtendSection index:indexPath.row];
        [dropDownView hideExtendedChooseView];
    if ([dropDownView.mbutton.titleLabel.text isEqualToString:@"大成"]) {
        for (int i=10001; i<110009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor colorWithRed:0.35 green:0.45 blue:0.4 alpha:0.3];
        }
        for (int i=30001; i<30009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        for (int i=90001; i<90009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }


            NSString*Url = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/query/seat/3/%@",firstbutton.titleLabel.text];
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
                if ([status isEqualToString:@"order"]) {
                    NSInteger mtag=row1+real_status1*10000;
                    UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                    bt.backgroundColor = [UIColor greenColor];
                }
                if ([status isEqualToString:@"use"]) {
                    NSInteger mtag=row1+real_status1*10000;
                    UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                    bt.backgroundColor = [UIColor redColor];
                }
            }

        }
    if ([dropDownView.mbutton.titleLabel.text isEqualToString:@"采矿馆"]) {
        for (int i=10001; i<110009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor colorWithRed:0.35 green:0.45 blue:0.4 alpha:0.3];
        }

        for (int i=30001; i<30009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        for (int i=90001; i<90009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        NSString*Url = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/query/seat/4/%@",firstbutton.titleLabel.text];
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
            if ([status isEqualToString:@"order"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor greenColor];
            }
            if ([status isEqualToString:@"use"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor redColor];
            }
        }

    }
    if ([dropDownView.mbutton.titleLabel.text isEqualToString:@"何世礼"]) {
        for (int i=10001; i<110009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor colorWithRed:0.35 green:0.45 blue:0.4 alpha:0.3];
        }

        for (int i=30001; i<30009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        for (int i=90001; i<90009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        for (int i=60001; i<60009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        NSString*Url = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/query/seat/2/%@",firstbutton.titleLabel.text];
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
            if ([status isEqualToString:@"order"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor greenColor];
            }
            if ([status isEqualToString:@"use"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor redColor];
            }
        }

    }
    if ([dropDownView.mbutton.titleLabel.text isEqualToString:@"逸夫楼"]) {
        for (int i=10001; i<110009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor colorWithRed:0.35 green:0.45 blue:0.4 alpha:0.3];
        }
        
        for (int i=40001; i<40009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        for (int i=80001; i<80009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            bt.backgroundColor = [UIColor whiteColor];
        }
        NSString*Url = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/query/seat/1/%@",firstbutton.titleLabel.text];
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
            if ([status isEqualToString:@"order"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor greenColor];
            }
            if ([status isEqualToString:@"use"]) {
                NSInteger mtag=row1+real_status1*10000;
                UIButton *bt=(UIButton *)[self.view viewWithTag:mtag];
                bt.backgroundColor = [UIColor redColor];
            }
        }

    }
}
-(IBAction)buttonclick:(UIButton*)sender{
        seat =0;
        flag=sender.tag;
        UIButton* button = (UIButton *)[self.view viewWithTag:flag];
    if (button.backgroundColor == [UIColor whiteColor]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"这是过道!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else if (button.backgroundColor == [UIColor redColor]) {
        
        button.backgroundColor= [UIColor colorWithRed:0.35 green:0.45 blue:0.4 alpha:0.3];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您取消了选择!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }
    else {
        for (int i=10001; i<110009; i++) {
            UIButton *bt=(UIButton *)[self.view viewWithTag:i];
            if (bt.backgroundColor != [UIColor whiteColor]&&bt.backgroundColor!=[UIColor greenColor]) {
            bt.backgroundColor = [UIColor colorWithRed:0.35 green:0.45 blue:0.4 alpha:0.3];
            }}
       
        NSString *location  = [NSString stringWithFormat:@"您选择了%ld列%ld座",(long)flag/10000,(long)flag%10000];
        
        
        seat = sender.tag;
        button.backgroundColor= [UIColor redColor];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:location delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
}


/*    if(_btn.backgroundColor == [UIColor blueColor])
    {
        _btn.backgroundColor = [UIColor whiteColor];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您取消了选择" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else {
        _btn.backgroundColor = [UIColor blueColor];
       
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您选择了一排四座" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];

    }
}*/


- (void)myThreadMainMethod
{
    //[self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}
/*- (void)updateUI
{
    
   // [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showSuccessWithStatus:@"dwasd" duration:10];
}*/
- (IBAction)register:(id)sender {
  /*  mythread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(myThreadMainMethod)
                                                   object:nil];
    [mythread start];*/

    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
    [self performSelector:@selector(dojob) withObject:nil afterDelay:2.0];
   
  //  [NSThread sleepForTimeInterval:100.0];
  
}
- (void)dojob
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (delegate.isLogin ==NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        
        if(seat == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择座位！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        }
        
        int m = 0;
        if([dropDownView.mbutton.titleLabel.text isEqualToString:@"何世礼"])
        {
            m=2;
        }
        if([dropDownView.mbutton.titleLabel.text isEqualToString:@"大成"])
        {
            m=3;
        }
        if([dropDownView.mbutton.titleLabel.text isEqualToString:@"逸夫楼"])
        {
            m=1;
        }
        if([dropDownView.mbutton.titleLabel.text isEqualToString:@"采矿馆"])
        {
            m=4;
        }
        NSLog(@"%@",firstbutton.titleLabel.text);
        if(firstbutton.titleLabel.text ==nil)
        {
            URL = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/using/take/%d/101/%ld/%ld",m,flag%10000,flag/10000];
        }
        else{
            URL = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/using/take/%d/%@/%ld/%ld",m,firstbutton.titleLabel.text,flag%10000,flag/10000];
        }
        NSLog(@"%d %@ %ld %ld",m,firstbutton.titleLabel.text,flag%10000,flag/10000);
        NSLog(@"%@",URL);
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
        // NSData *resposeData = [request responseData];
        
        /* NSDictionary* resultData=[NSJSONSerialization JSONObjectWithData:resposeData options:NSJSONReadingMutableContainers error:nil];
         
         NSString * result = [resultData objectForKey:@"status"];
         NSError * error = [request error];*/
        if([response isEqualToString:@"{\"error_code\":4000}"])
        {
            
            [SVProgressHUD dismissWithSuccess:@"占座成功"];
            //  UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:@"占座成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            //[alertView2 show];
            self.imagevvvv.hidden = NO;
            dropDownView.hidden = YES;
            
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
            
            NSData *resposeData = [request responseData];
            NSDictionary* resultData=[NSJSONSerialization JSONObjectWithData:resposeData options:NSJSONReadingMutableContainers error:nil];
            NSString *result =[resultData objectForKey:@"place"];
            _status.text = result;
            
            
        }
        else if([response isEqualToString:@"{\"error_code\":3002}"])
        {
            [SVProgressHUD dismissWithError:@"您已经有预约的座位！"];
        }
        else if([response isEqualToString:@"{\"error_code\":1003}"])
        {
            [SVProgressHUD dismissWithError:@"没找到这个座位！"];
            
        }
        else if([response isEqualToString:@"{\"error_code\":3001}"])
        {
            [SVProgressHUD dismissWithError:@"座位已被使用！"];
        }
        else
        {
            UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:response delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView2 show];
        }
    }

}
@end
