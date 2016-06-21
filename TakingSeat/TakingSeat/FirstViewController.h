//
//  FirstViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-12-5.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *passfield;
@property (weak, nonatomic) IBOutlet UIImageView *headview;
- (IBAction)select:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selector;
@property (weak, nonatomic) IBOutlet UITableView *namelist;

- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *denglu;
@property (weak, nonatomic) IBOutlet UIButton *zhuce;
@property (weak, nonatomic) IBOutlet UIImageView *duihao;
@property (weak, nonatomic) IBOutlet UIButton *gouxuan;
- (IBAction)select1:(id)sender;

@end
