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

@interface AddToyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemField;
@property (weak, nonatomic) IBOutlet UITextField *brandField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextView *notesField;
@property (weak, nonatomic) Toy* addedToy;

@end

@implementation AddToyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)addToy:(id)sender {
    //Create new Toy obect and add it to the array
    //dismiss the view
    Toy* nToy = [[Toy alloc] initWithDetails:self.itemField.text :self.brandField.text :self.priceField.text :self.notesField.text];
    self.addedToy = nToy;
    [self performSegueWithIdentifier:@"addButtonClicked" sender:nToy];
}

- (IBAction)cancel:(id)sender {
    //dismiss the view, add nothing.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[Toy class]]) {
        if ([segue.destinationViewController isKindOfClass:[ToyTableViewController class]]) {
            ToyTableViewController *targetViewController = segue.destinationViewController;
            Toy *thisToy = self.addedToy;
            targetViewController.addedToy = thisToy;
        }
    }
}

@end
