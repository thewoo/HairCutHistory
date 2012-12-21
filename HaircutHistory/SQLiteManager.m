//
//  SQLiteManager.m
//  WoWStreet
//
//  Created by Jorge Pardo on 09/11/12.
//  Copyright (c) 2012 Magic Dealers. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

sqlite3 *connection = nil;

@implementation SQLiteManager

+(void)openConnection {
    
    NSString *dataBasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"History.db"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataBasePath]) {
        
        if (sqlite3_open([dataBasePath UTF8String], &connection) != SQLITE_OK) {
            NSLog(@"[SQLiteManager : openConnection] - Failed to connect to the DataBase.");
        }
        
    } else {
        
        NSLog(@"[SQLiteManager : openConnection] - History.db won't be found under: %@", dataBasePath);
    }
}

+(void)closeConnection {
    
    if (connection) {
        sqlite3_close(connection);
        connection = nil;
    }
}



+(sqlite3 *)getConnection {
    
    if (connection == nil) {
        [self openConnection];
    }
    
    return  connection;
}

@end
