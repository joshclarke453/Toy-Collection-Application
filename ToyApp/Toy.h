//
//  Toy.h
//  ToyApp
//
//  Created by Joshua on 2018-10-25.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Toy : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* brand;
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, strong) NSString* addNotes;

@end

NS_ASSUME_NONNULL_END
