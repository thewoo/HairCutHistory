//
//  DataManager.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "DataManager.h"
#import "SQLiteManager.h"
#import "HairStyle.h"

static DataManager *instance = nil;

@implementation DataManager


#pragma mark DataBase Calls (Selects).

-(NSMutableArray *)getAllHairStyles {
    
    NSMutableArray *haircutsArray = [[NSMutableArray alloc] init];
    
    char *sql = "Select * from HairStyles";
    
    sqlite3_stmt *sqlStatement;
    
    if (sqlite3_prepare_v2([SQLiteManager getConnection], sql, -1, &sqlStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
            
            HairStyle *haircut = [[HairStyle alloc] init];
            
            haircut.idHairStyle = sqlite3_column_int(sqlStatement, 0);
            haircut.date = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            
            haircut.shapeDescription = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            haircut.rating = sqlite3_column_int(sqlStatement, 3);
            
            if (sqlite3_column_text(sqlStatement, 4) != NULL) {
                haircut.hairdresser = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
            }
            
            if (sqlite3_column_text(sqlStatement, 5) != NULL) {
                haircut.companyName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
            }
            
            haircut.imagesArray = [self getImageNamesForHairStyleId:haircut.idHairStyle];
            
            [haircutsArray addObject:haircut];
        }
        
    } else {        
        NSLog(@"[DataManager] getAllHaircuts - Error: %s", sqlite3_errmsg([SQLiteManager getConnection]));
    }
    
    [SQLiteManager closeConnection];
    
    return haircutsArray;
}



-(NSMutableArray *)getImageNamesForHairStyleId:(int)idHairStyle {
    
    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
    
    NSString *imagesQuery = [NSString stringWithFormat:@"Select name from Images where hairStyleId = %d", idHairStyle];
    const char *sqlImages = [imagesQuery UTF8String];
    sqlite3_stmt *imagesStatement;
    
    if (sqlite3_prepare_v2([SQLiteManager getConnection], sqlImages, -1, &imagesStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(imagesStatement) == SQLITE_ROW) {
            [imagesArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(imagesStatement, 0)]];
        }
        
    } else {        
        NSLog(@"[DataManager] getImageNamesForHairStyleId - Error: %s", sqlite3_errmsg([SQLiteManager getConnection]));
    }
    
    [SQLiteManager closeConnection];
    
    return imagesArray;
}




#pragma mark DataBase Calls (Inserts).

-(BOOL)saveNewHairStyle:(HairStyle *)hairStyle {
    
    BOOL success = YES;
    
    NSString *insertString = [NSString stringWithFormat:@"Insert into HairStyles values (null, '%@', '%@', %d, '%@', '%@')", hairStyle.date, hairStyle.shapeDescription, hairStyle.rating, hairStyle.hairdresser, hairStyle.companyName];
    
    const char *insertSQL = [insertString UTF8String];
    sqlite3_stmt *insertStatement;
    
    if (sqlite3_prepare_v2([SQLiteManager getConnection], insertSQL, -1, &insertStatement, NULL) == SQLITE_OK) {
        
        if (sqlite3_step(insertStatement) == SQLITE_DONE) {
            
            sqlite3_finalize(insertStatement);
            
        } else {
            NSLog(@"[DataManager] saveNewHairStyle  - Error with Insertion: %s", sqlite3_errmsg([SQLiteManager getConnection]));
            success = NO;
        }        
        
    } else {        
        NSLog(@"[DataManager] saveNewHairStyle  - Error with Insert Statement: %s", sqlite3_errmsg([SQLiteManager getConnection]));
        success = NO;        
    }
    
   
    [SQLiteManager closeConnection];
    
    return success;
}

-(BOOL)saveImagesForLastestHairStyle:(NSMutableArray *)imagesArray {
    
    BOOL success = YES;
    
    int lastHairStyleId = 0;
    
    const char *lastIdSQL = "Select max(hairStyleId) from HairStyles";
    sqlite3_stmt *selectStatement;
    
    if (sqlite3_prepare_v2([SQLiteManager getConnection], lastIdSQL, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            lastHairStyleId = sqlite3_column_int(selectStatement, 0);
        }
    
    } else {
        NSLog(@"[DataManager] saveImagesForLastestHairStyle  - Error with Select Statement: %s", sqlite3_errmsg([SQLiteManager getConnection]));
    }
    
    
    
    
    
    return success;
}






-(BOOL)saveImages:(NSMutableArray *)imagesArray forHairStyleId:(int)hairStyleId {
    
    BOOL success = YES;
    
    for (int x = 0; x < [imagesArray count]; x++) {
        
        NSString *insertString = [NSString stringWithFormat:@"Insert into Images values (null, '%@', %d)", [imagesArray objectAtIndex:x], hairStyleId];
        const char *insertSQL = [insertString UTF8String];
        sqlite3_stmt *insertStatement;

        
        if (sqlite3_prepare_v2([SQLiteManager getConnection], insertSQL, -1, &insertStatement, NULL) == SQLITE_OK) {
            
            if (sqlite3_step(insertStatement) == SQLITE_DONE) {
                
                sqlite3_finalize(insertStatement);
                
            } else {
                NSLog(@"[DataManager] saveImages  - Error with Insertion: %s", sqlite3_errmsg([SQLiteManager getConnection]));
                success = NO;
            }
            
        } else {
            NSLog(@"[DataManager] saveImages  - Error with Insert Statement: %s", sqlite3_errmsg([SQLiteManager getConnection]));
            success = NO;        
        }
        
    }
    
    [SQLiteManager closeConnection];
    
    return success;
}



#pragma mark Singleton's.

+(DataManager *)sharedInstance {
    
    if (instance == nil) {
        instance = [[DataManager alloc] init];
    }
    
    return instance;
}


#pragma mark Object's.

-(id)init {
    
    self = [super init];
    
    if (self) {}
    
    return self;
}

@end
