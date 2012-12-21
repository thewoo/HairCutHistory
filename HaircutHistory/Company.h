//
//  Company.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property int ID;
@property (nonatomic, strong) NSString *name;
@property int telephone;
@property (nonatomic, strong) NSString *address;

@end
