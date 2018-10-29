//
//  ToyDetailedViewController.m
//  ToyApp
//
//  Created by Joshua on 2018-10-24.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import "ToyDetailedViewController.h"
#import "Toy.h"


@interface ToyDetailedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel* itemLabel;
@property (weak, nonatomic) IBOutlet UILabel* brandLabel;
@property (weak, nonatomic) IBOutlet UILabel* priceLabel;
@property (weak, nonatomic) IBOutlet UITextView* notesField;

@end

@implementation ToyDetailedViewController

//This just takes the Toy that it recieves from a segue and displays its information.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.selectedToy getName];
    self.itemLabel.text = [@"Item: " stringByAppendingString:[self.selectedToy getName]] ;
    self.brandLabel.text = [@"Brand: " stringByAppendingString: [self.selectedToy getBrand]];
    self.priceLabel.text = [@"Price: $" stringByAppendingString: [self.selectedToy getPrice]];
    self.notesField.text = [self.selectedToy getNotes];
    self.imageView.image = [self getImageFromDocuments:[self.selectedToy getImageName]];
}

//This method gets the image from my 'ToyPics' resource folder when it is given a name;
-(UIImage*)getImageFromDocuments:(NSString*) toyName {
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *toyPicsPath = @"ToyPics";
    NSString *toyPicsPath2 = [path stringByAppendingPathComponent:toyPicsPath];
    NSString *filePath = [toyPicsPath2 stringByAppendingPathComponent:toyName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

@end
