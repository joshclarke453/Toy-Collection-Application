//
//  Toy.m
//  ToyApp
//
//  Created by Joshua on 2018-10-25.
//  Copyright © 2018 jtc260. All rights reserved.
//

#import "Toy.h"

@implementation Toy

//A simple constructor for my class which builds the Toy objects.
- (instancetype)initWithDetails:(NSString*)initName
                               :(NSString*)initBrand
                               :(NSString*)initPrice
                               :(NSString*)initAddNotes
                               :(NSString*)initImageName
                               :(UIImage*)initImage{
    self.name = initName;
    self.brand = initBrand;
    self.price = initPrice;
    self.addNotes = initAddNotes;
    self.imageName = initImageName;
    self.image = initImage;
    return self;
}

//
//A bunch of accessor methods.
//
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

-(UIImage*) getImage {
    return self.image;
}

@end
