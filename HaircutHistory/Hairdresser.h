//
//  Hairdresser.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Company;

@interface Hairdresser : NSObject

@property int ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Company *company;


@end
