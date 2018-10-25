//
//  ToyTableViewController.h
//  ToyApp
//
//  Created by Joshua on 2018-10-24.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddToyViewController.h"
#import "ToyDetailedViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToyTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *cellData;

@end

NS_ASSUME_NONNULL_END
