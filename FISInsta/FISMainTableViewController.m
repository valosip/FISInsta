//
//  FISMainTableViewController.m
//  FISInsta
//
//  Created by Val Osipenko on 6/17/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "FISMainTableViewController.h"
#import "FISHashTableViewController.h"
#import "FISMainTableViewCell.h"

@interface FISMainTableViewController ()
@property (nonatomic, strong) NSArray *sortedArrayByLikes;

@end

@implementation FISMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"FISinsta";
    
    
    NSMutableArray * filteredArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary * item in self.imageList){
        
        NSMutableDictionary * newDictionary = [[NSMutableDictionary alloc]init];
        NSString * imageURL = item[@"images"][@"thumbnail"][@"url"];
        NSString * likeCount = item[@"likes"][@"count"];
        NSArray * hashTags = item[@"tags"];
        [newDictionary setValue:imageURL forKey:@"image"];
        [newDictionary setValue:likeCount forKey:@"likes"];
        [newDictionary setValue:hashTags forKey:@"tags"];
        [filteredArray addObject:newDictionary];
    }
    
    //NSLog(@"NewArray: %@",filteredArray);
    
    NSArray * arrayToSort = [filteredArray copy];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"likes" ascending:NO];
    arrayToSort=[arrayToSort sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    self.sortedArrayByLikes = [arrayToSort copy];
    
    //NSLog(@"NewArray: %@",newArray);
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    return [self.imageList[@"data"] count];
   return [self.sortedArrayByLikes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FISMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseMainCell" forIndexPath:indexPath];
    
    // Configure the cell...

    
//    NSString *imageURL = [NSString stringWithFormat:@"%@",self.imageList[@"data"][indexPath.row][@"images"][@"low_resolution"][@"url"]];
//    cell.imageThumbnail.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
//    cell.likeCount.text =[NSString stringWithFormat:@"%@",self.imageList[@"data"][indexPath.row][@"likes"][@"count"]];
    
//    NSString *imageURL = [NSString stringWithFormat:@"%@",self.imageList[indexPath.row][@"images"][@"low_resolution"][@"url"]];
//    cell.imageThumbnail.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
//    cell.likeCount.text =[NSString stringWithFormat:@"%@",self.imageList[indexPath.row][@"likes"][@"count"]];
    
    NSString *imageURL = [NSString stringWithFormat:@"%@",self.sortedArrayByLikes[indexPath.row][@"image"]];
    cell.imageThumbnail.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    cell.likeCount.text =[NSString stringWithFormat:@"%@",self.sortedArrayByLikes[indexPath.row][@"likes"]];

    
    return cell;
}


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
    FISHashTableViewController * destination = segue.destinationViewController;
    
    
    destination.imageHashDetails = self.sortedArrayByLikes[[self.tableView indexPathForCell:sender].row];
}


@end
