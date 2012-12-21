//
//  Haircut.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hairdresser;

@interface Haircut : NSObject

@property int ID;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) Hairdresser *hairdresser;
@property (nonatomic, strong) NSString *description;

@property int rating;
@property int price;

@property (nonatomic, strong) NSMutableArray *imagesArray;


@end
