//
//  MeetingTableViewController.m
//  TakingSeat
//
//  Created by 吴冠龙 on 15-10-20.
//  Copyright (c) 2015年 吴冠龙. All rights reserved.
//

#import "MeetingTableViewController.h"
#import <QuartzCore/CoreAnimation.h>

@interface MeetingTableViewController ()


@end

@implementation MeetingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],UITextAttributeTextColor,nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    m=0;
    m =indexPath.row;
    NSLog(@"%ld",(long)m);
    [self performSegueWithIdentifier:@"link" sender:nil];
    
}
/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    id mySegue=segue.destinationViewController;
    if (m==0) {
        [mySegue setValue:(_H1.text) forKey:@"room"];
        [mySegue setValue:(_H1N.text) forKey:@"num"];
    }
    else if (m==1){
        [mySegue setValue:(_H2.text) forKey:@"room"];
        [mySegue setValue:(_H2N.text) forKey:@"num"];
    }
    else if (m==2){
        [mySegue setValue:(_J1.text) forKey:@"room"];
        [mySegue setValue:(_J1N.text) forKey:@"num"];
    }
    else if (m==3){
        [mySegue setValue:(_J2.text) forKey:@"room"];
        [mySegue setValue:(_J2N.text) forKey:@"num"];
    }
    else if (m==4){
        [mySegue setValue:(_C1.text) forKey:@"room"];
        [mySegue setValue:(_C1N.text) forKey:@"num"];
    }
    else if (m==5){
        [mySegue setValue:(_C2.text) forKey:@"room"];
        [mySegue setValue:(_C2N.text) forKey:@"num"];
    }
}

/*    id mySegue=segue.destinationViewController;
    [mySegue setValue:(_C2.text) forKey:@"room"];
    [mySegue setValue:(_C2N.text) forKey:@"num"];*/




- (IBAction)swipe1:(id)sender {
    self.tabBarController.selectedIndex=2;
}
- (IBAction)swipe2:(id)sender {
    self.tabBarController.selectedIndex=0;
}
@end
