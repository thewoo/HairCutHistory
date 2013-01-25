//
//  DataManager.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HairStyle;

@interface DataManager : NSObject

-(NSMutableArray *)getAllHairStyles;
-(NSMutableArray *)getImageNamesForHairStyleId:(int)idHairStyle;

-(BOOL)saveNewHairStyle:(HairStyle *)hairStyle;

-(BOOL)saveImagesForLastestHairStyle:(NSMutableArray *)imagesArray;
-(BOOL)saveImages:(NSMutableArray *)imagesArray forHairStyleId:(int)hairStyleId;




+(DataManager *)sharedInstance;

@end
