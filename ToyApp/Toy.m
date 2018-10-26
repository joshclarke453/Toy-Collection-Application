//
//  Toy.m
//  ToyApp
//
//  Created by Joshua on 2018-10-25.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import "Toy.h"

@implementation Toy

- (instancetype)initWithDetails:(NSString*)initName
                               :(NSString*)initBrand
                               :(NSString*)initPrice
                               :(NSString*)initAddNotes
                               :(NSString*)initImageName {
    self.name = initName;
    self.brand = initBrand;
    self.price = initPrice;
    self.addNotes = initAddNotes;
    self.imageName = initImageName;
    return self;
}

- (instancetype)initWithoutPicture:(NSString *)initName
                                  :(NSString*)initBrand
                                  :(NSString*)initPrice
                                  :(NSString*)initAddNotes {
    self.name = initName;
    self.brand = initBrand;
    self.price = initPrice;
    self.addNotes = initAddNotes;
    self.imageName = @"yo";
    return self;
}

-(NSString*) getName {
    return self.name;
}

-(NSString*) getBrand {
    return self.brand;
}

-(NSString*) getPrice {
    return self.price;
}

-(NSString*) getNotes {
    return self.addNotes;
}

-(NSString*) getImageName {
    return self.imageName;
}

@end
