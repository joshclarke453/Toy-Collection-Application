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
@property (weak, nonatomic) NSString *imageName;
@property (weak, nonatomic) UIImage *image;

@end

@implementation AddToyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)addToy:(id)sender {
    //Create new Toy obect and add it to the array
    //dismiss the view
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
    NSString *guid = [[NSUUID new] UUIDString];
    NSString *uniqueFileName = [NSString stringWithFormat:@"%@_%@", guid, @".png"];
    self.imageName = uniqueFileName;
    self.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//-(NSString) generateFileName {
//
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
