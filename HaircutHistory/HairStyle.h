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

@interface HairStyle : NSObject

@property int idHairStyle;

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *hairdresser;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *shapeDescription;

@property int rating;

@property (nonatomic, strong) NSMutableArray *imagesArray;


@end
