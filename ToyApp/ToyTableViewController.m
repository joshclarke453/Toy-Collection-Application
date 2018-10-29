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
    [self readArrayFromFile];
    self.navigationItem.title = @"List Of Toys";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushToDetail" sender:indexPath];
}

-(void)saveImageToDocuments {
    NSData *pngData = UIImagePNGRepresentation([self.addedToy getImage]);
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *toyPicsPath = @"ToyPics";
    NSString *toyPicsPath2 = [path stringByAppendingPathComponent:toyPicsPath];
    NSString *filePath = [toyPicsPath2 stringByAppendingPathComponent:[self.addedToy getImageName]];
    [pngData writeToFile:filePath atomically:YES];
}

-(UIImage*)getImageFromDocuments:(NSString*) toyName {
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *toyPicsPath = @"ToyPics";
    NSString *toyPicsPath2 = [path stringByAppendingPathComponent:toyPicsPath];
    NSString *filePath = [toyPicsPath2 stringByAppendingPathComponent:toyName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

-(void)readArrayFromFile {
    self.cellData = [self.cellData init];
    self.data = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"toys" ofType:@"plist"]];
    NSEnumerator *enumerator = [self.data objectEnumerator];
    id value;
    NSString* toyNotes;
    NSString* toyName;
    NSString* toyBrand;
    NSString* toyImageName;
    NSString* toyPrice;
    while (value = [enumerator nextObject]) {
        NSArray *allValues = [value allValues];
        NSArray *allKeys = [value allKeys];
        if ([allKeys[0] isEqualToString:@"AddNotes"]) {
            toyNotes = allValues[0];
            toyName = allValues[1];
            toyBrand = allValues[2];
            toyImageName = allValues[3];
            toyPrice = allValues[4];
        } else {
            toyNotes = allValues[1];
            toyName = allValues[3];
            toyBrand = allValues[4];
            toyImageName = allValues[0];
            toyPrice = allValues[2];
        }
        UIImage* toyImage = [self getImageFromDocuments:toyImageName];
        Toy *tempToy = [[Toy alloc] initWithDetails: toyName : toyBrand : toyPrice : toyNotes : toyImageName : toyImage];
        if (tempToy.image) {
            NSLog(@"Not Null");
        } else {
            NSLog(@"Null");
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

#pragma mark - Navigation
- (IBAction)prepareForUnwind:(UIStoryboardSegue*)segue {
    AddToyViewController* tvd = segue.sourceViewController;
    self.addedToy = tvd.addedToy;
    [cellData addObject:self.addedToy];
    //id objects[] = [self.addedToy getNotes],[self.addedToy getName],@"",[self.addedToy getBrand],@"",[self.addedToy getImageName],@"",[self.addedToy getPrice],@"", nil];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[self.addedToy getName],@"Name",[self.addedToy getBrand],@"Brand", [self.addedToy getPrice],@"Price",[self.addedToy getNotes],@"AddNotes",[self.addedToy getImageName],@"ImageName", nil];
    [self.data setObject:newDict forKey:[self.addedToy getName]];
    [self saveImageToDocuments];
    [self writeArrayToFile];
    [self.tableView reloadData];
}

- (IBAction)cancelUnwind:(UIStoryboardSegue*)segue {
    
}

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
