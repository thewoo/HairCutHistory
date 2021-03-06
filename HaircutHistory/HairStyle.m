//
//  Haircut.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "HairStyle.h"

@implementation HairStyle

@synthesize idHairStyle;
@synthesize date;
@synthesize hairdresser;
@synthesize companyName;
@synthesize shapeDescription;
@synthesize rating;
@synthesize imagesArray;

#pragma mark Object's.

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.imagesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
