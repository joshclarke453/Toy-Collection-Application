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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.selectedToy getName];
    self.itemLabel.text = [@"Item: " stringByAppendingString:[self.selectedToy getName]] ;
    self.brandLabel.text = [@"Brand: " stringByAppendingString: [self.selectedToy getBrand]];
    self.priceLabel.text = [@"Price: $" stringByAppendingString: [self.selectedToy getPrice]];
    self.notesField.text = [self.selectedToy getNotes];
    //self.imageView.image = [UIImage imageNamed: [self.selectedToy getImageName]];
    self.imageView.image = [self getImageFromDocuments:self.selectedToy];
    NSLog(@"did it get here?");
    // Do any additional setup after loading the view.
}

-(UIImage*)getImageFromDocuments:(Toy*) selectedToy {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[selectedToy getImageName]];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

@end
