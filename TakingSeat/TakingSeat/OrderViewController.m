//
//  OrderViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-11-6.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "OrderViewController.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "DropDownListView.h"
#import "AppDelegate.h"

@interface OrderViewController ()
{
    NSMutableArray *chooseArray ;
    DropDownListView*dropDownView;
    NSInteger seat ;
}
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) NSInteger itemCount;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    self.title = @"预约";
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
}
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    
}
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
- (IBAction)buttonclick:(UIButton*)sender{
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

#pragma mark - UIScrollView

- (void)setupScrollView {
    
    self.contentHeight = 10;
    self.itemCount = 0;
    
    //Create ScrollView

    [self.scrollView setContentSize:CGSizeMake(380,600)];
    
    
    //add pull to refresh
    __weak typeof(self) weakSelf = self;
    [self.scrollView addPullToRefreshWithPullText:@"下拉刷新" pullTextColor:[UIColor blackColor] pullTextFont:DefaultTextFont refreshingText:@"正在刷新" refreshingTextColor:[UIColor blueColor] refreshingTextFont:DefaultTextFont action:^{
        [weakSelf loadItems];
    }];
    
    
    //add some items to scroll view

}

- (void)loadItems {
    __weak typeof(UIScrollView *) weakScrollView = self.scrollView;
    __weak typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf refreshing];
        [weakScrollView finishLoading];
    });
}
- (void)refreshing{
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



- (IBAction)order:(id)sender {

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
            if(firstbutton.titleLabel.text ==nil)
            {
                URL = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/using/take/%d/101/%ld/%ld",m,flag%10000,flag/10000];
            }
            else{
                URL = [NSString stringWithFormat:@"http://219.216.96.47/Takenseat/public/api/using/take/%d/%@/%ld/%ld",m,firstbutton.titleLabel.text,flag%10000,flag/10000];
            }
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
                            }
            else if([response isEqualToString:@"{\"error_code\":3002}"])
            {
                UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:@"您已经有预约的座位！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView2 show];
            }
            else if([response isEqualToString:@"{\"error_code\":1003}"])
            {
                UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:@"没有找到这个座位！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView2 show];
            }
            else if([response isEqualToString:@"{\"error_code\":3001}"])
            {
                UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:@"座位已经被使用！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView2 show];
            }
            else
            {
                UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"" message:response delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView2 show];
            }
        }

}
@end
