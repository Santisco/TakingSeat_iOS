//
//  OrderViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-11-6.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController
{
    NSInteger flag;
    UIButton *firstbutton;
    NSString *URL;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)order:(id)sender;



@end
