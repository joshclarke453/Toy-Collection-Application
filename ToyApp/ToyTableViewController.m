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

@synthesize data;
@synthesize cellData;

- (void)viewDidLoad {
    [super viewDidLoad];
    cellData = [[NSMutableArray alloc] init];
    //Toy* t1 = [[Toy alloc] initWithoutPicture:@"NES" :@"Nintendo" : @"259.99" :@"Childhood Dreams"];
    //[cellData addObject:t1];
    [self readArrayFromFile];
    self.navigationItem.title = @"List Of Toys";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushToDetail" sender:indexPath];
}

-(void)saveImageToDocuments {
    NSData *pngData = UIImagePNGRepresentation([self.addedToy getImage]);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[self.addedToy getImageName]];
    [pngData writeToFile:filePath atomically:YES];
}

-(UIImage*)getImageFromDocuments:(NSString*) toyName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:toyName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

-(void)readArrayFromFile {
    self.cellData = [self.cellData init];
    self.data = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"toys" ofType:@"plist"]];
    NSEnumerator *enumerator = [self.data objectEnumerator];
    id value;
    while ((value = [enumerator nextObject]) != nil) {
        NSArray *allValues = [value allValues];
        //NSLog(@"%@__%@", allKeys, allValues);
        NSString* toyNotes = allValues[0];
        NSString* toyName = allValues[1];
        NSString* toyBrand = allValues[2];
        NSString* toyImageName = allValues[3];
        NSString* toyPrice = allValues[4];
        UIImage* toyImage = [self getImageFromDocuments:toyImageName];
        Toy *tempToy = [[Toy alloc] initWithDetails: toyName : toyBrand : toyPrice : toyNotes : toyImageName : toyImage];
        if (tempToy.image) {
            NSLog(@"Not Null");
        } else {
            //NSLog(@"Null");
        }
        [self.cellData addObject:tempToy];
    }
}

-(void)writeArrayToFile {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"toys" ofType:@"plist"];
    NSMutableDictionary *toyDict = self.data;
    if ([toyDict writeToFile:filePath atomically:YES])
        NSLog(@"data saved to plist");
    else
        NSLog(@"unable to save data to plist");
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"toyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    Toy *toyName = cellData[indexPath.row];
    cell.textLabel.text = [toyName getName];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", [toyName getBrand],[toyName getPrice]];
    cell.imageView.image = [toyName getImage];
    
    return cell;
}

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
    //id objects[] = [self.addedToy getNotes],[self.addedToy getName],@"",[self.addedToy getBrand],@"",[self.addedToy getImageName],@"",[self.addedToy getPrice],@"", nil];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[self.addedToy getNotes],@"AddNotes",[self.addedToy getName],@"Name",[self.addedToy getBrand],@"Brand",[self.addedToy getImageName],@"ImageName",[self.addedToy getPrice],@"Price", nil];
    [self.data setObject:newDict forKey:[self.addedToy getName]];
    [self saveImageToDocuments];
    [self writeArrayToFile];
    [self.tableView reloadData];
}

- (IBAction)cancelUnwind:(UIStoryboardSegue*)segue {
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
