//
//  SQLiteManager.h
//  WoWStreet
//
//  Created by Jorge Pardo on 09/11/12.
//  Copyright (c) 2012 Magic Dealers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLiteManager : NSObject

+(void)openConnection;
+(void)closeConnection;

+(sqlite3 *)getConnection;

@end
