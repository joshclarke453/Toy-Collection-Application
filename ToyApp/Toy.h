//
//  Toy.h
//  ToyApp
//
//  Created by Joshua on 2018-10-25.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//I created a 'Toy' class which models the Toys we are storing information about. This was mostly just for ease of storing and accessing information
@interface Toy : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* brand;
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* addNotes;
@property (nonatomic, strong) NSString* imageName;
@property (nonatomic, strong) UIImage* image;

- (instancetype)initWithDetails:(NSString*)initName
                               :(NSString*)initBrand
                               :(NSString*)initPrice
                               :(NSString*)initAddNotes
                               :(NSString*)initImageName
                               :(UIImage*)initImage;

- (NSString*)getName;
- (NSString*)getBrand;
- (NSString*)getPrice;
- (NSString*)getNotes;
- (NSString*)getImageName;
- (UIImage*)getImage;

@end

NS_ASSUME_NONNULL_END
