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

//This method initializes the NSMutableArray for the toys to be stored in and calls a method to read a file.
- (void)viewDidLoad {
    [super viewDidLoad];
    cellData = [[NSMutableArray alloc] init];
    [self readArrayFromFile];
    self.navigationItem.title = @"List Of Toys";
}

//This method recognizes when a cell is tapped and calls a method to deal with that.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushToDetail" sender:indexPath];
}

//This method saves Images to our ToyPics folder based off the name of the Image.
-(void)saveImageToDocuments {
    NSData *pngData = UIImagePNGRepresentation([self.addedToy getImage]);
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *toyPicsPath = @"ToyPics";
    NSString *toyPicsPath2 = [path stringByAppendingPathComponent:toyPicsPath];
    NSString *filePath = [toyPicsPath2 stringByAppendingPathComponent:[self.addedToy getImageName]];
    [pngData writeToFile:filePath atomically:YES];
}

//This method reads Images from our ToyPics folder based off the name of the Image.
-(UIImage*)getImageFromDocuments:(NSString*) toyName {
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *toyPicsPath = @"ToyPics";
    NSString *toyPicsPath2 = [path stringByAppendingPathComponent:toyPicsPath];
    NSString *filePath = [toyPicsPath2 stringByAppendingPathComponent:toyName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}


//This method reads our toys.plist file and stores the dictionary it holds into self.data where we can update it when a new Toy is added and
//rewrite the plist file when we need to.
-(void)readArrayFromFile {
    self.cellData = [self.cellData init];
    self.data = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"toys" ofType:@"plist"]];
    NSEnumerator *enumerator = [self.data objectEnumerator];
    id value;
    //
    //I had a weird bug happening where it would read my dictionary differently if you Added a new toy then terminated the app and reopened it.
    //This caused the values held in the dictionarys to get assigned to the wrong fields. I couldnt find the cause of the bug so I did my best to fix it.
    //
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
        [self.cellData addObject:tempToy];
    }
}

//This method just writes our self.data dictionary into our plist file.
-(void)writeArrayToFile {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"toys" ofType:@"plist"];
    NSMutableDictionary *toyDict = self.data;
    if ([toyDict writeToFile:filePath atomically:YES])
        NSLog(@"data saved to plist");
    else
        NSLog(@"unable to save data to plist");
}

//Sets the number of sections in our TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Sets the number of rows in our TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellData count];
}

//This is where I did all my cell editing to make it have an image and 2 detail texts.
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

//This is an unwind segue coming from AddToyViewController's 'Add' button. It delivers a Toy object which is then added to both the .cellData Array and
//the .data Dictionary. It also calls a method to save the image to our toyPics folder and a method to rewrite the plist with our new data.
- (IBAction)prepareForUnwind:(UIStoryboardSegue*)segue {
    AddToyViewController* tvd = segue.sourceViewController;
    self.addedToy = tvd.addedToy;
    [cellData addObject:self.addedToy];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[self.addedToy getName],@"Name",[self.addedToy getBrand],@"Brand", [self.addedToy getPrice],@"Price",[self.addedToy getNotes],@"AddNotes",[self.addedToy getImageName],@"ImageName", nil];
    [self.data setObject:newDict forKey:[self.addedToy getName]];
    [self saveImageToDocuments];
    [self writeArrayToFile];
    [self.tableView reloadData];
}

//This is an unwind segue from the AddToyViewController aswell. This one does nothing, it is only there to bring us back to the previous page.
- (IBAction)cancelUnwind:(UIStoryboardSegue*)segue {
    
}

//This is a method preparing the ViewController to start a segue to ToyDetailedViewController. It delivers a Toy object for the new view to display.
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
