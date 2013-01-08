//
//  DataManager.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

-(NSMutableArray *)getAllHaircuts;
-(BOOL)checkForCompany:(NSString *)companyName;




+(DataManager *)sharedInstance;

@end
