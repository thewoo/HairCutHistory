//
//  Haircut.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hairdresser;
@class Company;

@interface Haircut : NSObject

@property int ID;

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) Hairdresser *hairdresser;
@property (nonatomic, strong) Company *company;
@property (nonatomic, strong) NSString *shapeDescription;

@property int rating;
@property int price;

@property (nonatomic, strong) NSMutableArray *imagesArray;


@end
