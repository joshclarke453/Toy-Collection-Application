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

//This method simple creates a Toy object from the fields of the view when the user clicks the 'Add' button.
//It also takes a copy of the Toy object it is given and stores it in its .addedToy property.
//This is because I used a unwind segue to pass the newly created object back to the TableView, so I had to store it in a property.
- (IBAction)addToy:(id)sender {
    Toy* nToy = [[Toy alloc] initWithDetails: self.itemField.text :self.brandField.text :self.priceField.text :self.notesField.text :self.imageName :self.image];
    self.addedToy = nToy;
}

//A method to register when the user clicks the image screen, allowing them to select one of their own from the gallery using UIImagePickerController.
- (IBAction)clickedOnImage:(UITapGestureRecognizer *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

//A method which takes the image that the user selected and stores it in the UIImageView field.
//It also calls a method that generates a random string for the filename.
//It then dismisses the UIImagePickerController.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    NSString *ranName = [self generateRandomString:14];
    NSString *uniqueFileName = [NSString stringWithFormat:@"%@%@", ranName, @".png"];
    self.imageName = uniqueFileName;
    self.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


//This dismisses the UIImagePickerController if the user presses cancel.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//This is the method to generate a random string. Im sure it isnt the best method but it works decently well.
-(NSString*) generateRandomString:(int) len {
    NSString* letters = @"abcdefghijklmnpqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0 ; i<len ; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((int)[letters length]) % [letters length]]];
    }
    return randomString;
}

@end
