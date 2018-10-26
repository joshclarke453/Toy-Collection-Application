//
//  AddToyViewController.h
//  ToyApp
//
//  Created by Joshua on 2018-10-24.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toy.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddToyViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) Toy* addedToy;

@end

NS_ASSUME_NONNULL_END
