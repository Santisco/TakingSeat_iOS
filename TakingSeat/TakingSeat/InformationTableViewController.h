//
//  InformationTableViewController.h
//  TakingSeat
//
//  Created by 吴冠龙 on 15-12-4.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationTableViewController : UITableViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *showview;
@property (weak, nonatomic) IBOutlet UIPickerView *sex;
@property(nonatomic,strong)NSArray * depart;
@property (weak, nonatomic) IBOutlet UILabel *sexlab;
- (IBAction)end:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *school;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *hometown;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *instruction;



@end
