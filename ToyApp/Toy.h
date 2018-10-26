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

- (instancetype)initWithoutPicture:(NSString*)initName
                                  :(NSString*)initBrand
                                  :(NSString*)initPrice
                                  :(NSString*)initAddNotes;

- (NSString*)getName;
- (NSString*)getBrand;
- (NSString*)getPrice;
- (NSString*)getNotes;
- (NSString*)getImageName;
- (UIImage*)getImage;

@end

NS_ASSUME_NONNULL_END
