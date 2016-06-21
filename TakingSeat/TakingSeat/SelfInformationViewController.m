//
//  SelfInformationViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-11-24.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "SelfInformationViewController.h"

@interface SelfInformationViewController ()

@end

@implementation SelfInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selfimage.alpha = 0;
    self.selfview.hidden =YES;
    [_information.layer setMasksToBounds:YES];
    [_information.layer setCornerRadius:8.0];
    [_information.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.53, 0.72, 0.98, 1 });
    [_information.layer setBorderColor:colorref];
    
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

- (IBAction)check:(id)sender {
    self.selfview.alpha=1;
    [UIView animateWithDuration:1.0f
                     animations:^{
       self.selfimage.alpha= 1;
       self.selfview.hidden =NO;
     //   self.selfimage.alpha= 1;
                     }];
}
- (IBAction)dismiss:(id)sender {
    if (self.selfview.hidden ==NO) {
        [UIView animateWithDuration:2.0f
                         animations:^{
                             self.selfimage.alpha= 0;
                             self.selfview.alpha = 0;
                             //   self.selfimage.alpha= 1;
                         }];

    }
}
@end
