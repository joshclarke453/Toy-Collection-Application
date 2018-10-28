//
//  AddToyViewController.m
//  ToyApp
//
//  Created by Joshua on 2018-10-24.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import "AddToyViewController.h"
#import "ToyTableViewController.h"
#import "Toy.h"
#import <Photos/Photos.h>

@interface AddToyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemField;
@property (weak, nonatomic) IBOutlet UITextField *brandField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextView *notesField;
@property (strong, nonatomic) NSString *imageName;
@property (weak, nonatomic) UIImage *image;

@end

@implementation AddToyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addToy:(id)sender {
    Toy* nToy = [[Toy alloc] initWithDetails: self.itemField.text :self.brandField.text :self.priceField.text :self.notesField.text :self.imageName :self.image];
    self.addedToy = nToy;
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)clickedOnImage:(UITapGestureRecognizer *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    NSString *ranName = [self generateRandomString:14];
    NSString *uniqueFileName = [NSString stringWithFormat:@"%@%@", ranName, @".png"];
    self.imageName = uniqueFileName;
    self.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(NSString*) generateRandomString:(int) len {
    NSString* letters = @"abcdefghijklmnpqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0 ; i<len ; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((int)[letters length]) % [letters length]]];
    }
    return randomString;
}

@end
