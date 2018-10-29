//
//  ToyDetailedViewController.h
//  ToyApp
//
//  Created by Joshua on 2018-10-24.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toy.h"
#import "ToyTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToyDetailedViewController : UIViewController

@property (nonatomic, strong) Toy *selectedToy;

@end

NS_ASSUME_NONNULL_END
