//
//  InformationTableViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-12-4.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "InformationTableViewController.h"

@interface InformationTableViewController ()
{
    NSMutableArray * chooseArray;
    
}

@end

@implementation InformationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _nickname.borderStyle = UITextBorderStyleNone;
    _birthday.borderStyle = UITextBorderStyleNone;
    _school.borderStyle = UITextBorderStyleNone;
    _hometown.borderStyle = UITextBorderStyleNone;
    _instruction.borderStyle = UITextBorderStyleNone;
    _email.borderStyle = UITextBorderStyleNone;
    _location.borderStyle = UITextBorderStyleNone;
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    chooseArray = [NSMutableArray arrayWithObjects:@"男",@"女", nil];
    _sex.delegate = self;
    _sex.dataSource = self;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger m=0;
    NSInteger n=0;
    m =indexPath.row;
    n=indexPath.section;
    if (m==1&&n==0) {
        [UIView animateWithDuration:1.5f
                         animations:^{
                             self.showview.transform = CGAffineTransformMakeTranslation(0, -200);

                         }];

    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *name=chooseArray[row];
    return name;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (row ==0) {
        self.sexlab.text = @"男";
    }
    if (row ==1) {
        self.sexlab.text = @"女";
    }
}
- (IBAction)end:(id)sender {
    [UIView animateWithDuration:1.5f
                     animations:^{
                         self.showview.transform = CGAffineTransformMakeTranslation(0, 200);
                     }];

    
}
@end
