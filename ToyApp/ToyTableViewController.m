//
//  ToyTableViewController.m
//  ToyApp
//
//  Created by Joshua on 2018-10-24.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import "ToyTableViewController.h"
#import "AddToyViewController.h"
#import "ToyDetailedViewController.h"
#import "Toy.h"

@interface ToyTableViewController ()
@end

@implementation ToyTableViewController

@synthesize cellData;

- (void)viewDidLoad {
    [super viewDidLoad];
    cellData = [[NSMutableArray alloc] init];
    Toy* t1 = [[Toy alloc] initWithoutPicture:@"NES" :@"Nintendo" : @"259.99" :@"Childhood Dreams"];
    [cellData addObject:t1];
    self.navigationItem.title = @"List Of Toys";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushToDetail" sender:indexPath];
}

-(void)saveArrayToFile {
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"toyList.plist"];
    [cellData writeToFile:filePath atomically:YES];
}

-(void)readArrayFromFile {
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    NSString *filePath = [documentFolder stringByAppendingFormat:@"toyList.plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile: filePath];
    for (int i = 0; 0 < [plistArray count]; i++) {
        [cellData addObject:plistArray[i]];
    }
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toyCell" forIndexPath:indexPath];
    Toy *toyName = cellData[indexPath.row];
    cell.textLabel.text = [toyName getName];
    cell.imageView.image = [UIImage imageNamed:[toyName getImageName]];
    
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
- (IBAction)prepareForUnwind:(UIStoryboardSegue*)segue {
    AddToyViewController* tvd = segue.sourceViewController;
    self.addedToy = tvd.addedToy;
    [cellData addObject:self.addedToy];
    [self.tableView reloadData];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //ToyDetailedViewController *selectedToy = [segue destinationViewController];
    //selectedToy.dataModel = cellData
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[ToyDetailedViewController class]]) {
            ToyDetailedViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            Toy *toy = self.cellData[path.row];
            targetViewController.selectedToy = toy;
        }
    }
}


@end
