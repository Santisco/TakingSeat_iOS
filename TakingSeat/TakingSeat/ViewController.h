//
//  ViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-9-23.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
@interface ViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource>
{
    NSInteger flag;
    UIButton *firstbutton;
    NSString *URL;
    NSThread *mythread;
}
- (IBAction)register:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIView *showstatus;
@property (weak, nonatomic) IBOutlet UIImageView *imagevvvv;


@end

