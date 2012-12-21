//
//  DataManager.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 21/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "DataManager.h"
#import "SQLiteManager.h"
#import "Haircut.h"
#import "Hairdresser.h"
#import "Company.h"

static DataManager *instance = nil;

@implementation DataManager

-(NSMutableArray *)getAllHaircuts {
    
    NSMutableArray *haircutsArray = [[NSMutableArray alloc] init];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    char *sql = "Select Haircuts.haircutId, Haircuts.date, Hairdressers.hairdresserId, Hairdressers.name, Companies.companyId, Companies.name, Companies.telephone, Companies.address, Haircuts.description, Haircuts.rating, Haircuts.price from Haircuts, Hairdressers, Companies where Haircuts.hairdresserId = Hairdressers.hairdresserId and Hairdressers.companyId = Companies.companyId";
    
    sqlite3_stmt *sqlStatement;
    
    if (sqlite3_prepare_v2([SQLiteManager getConnection], sql, -1, &sqlStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
            
            Haircut *haircut = [[Haircut alloc] init];
            Hairdresser *hairdresser = [[Hairdresser alloc] init];
            Company *company = [[Company alloc] init];
            
            haircut.ID = sqlite3_column_int(sqlStatement, 0);
            haircut.date = [dateFormatter dateFromString:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)]];
            
            hairdresser.ID = sqlite3_column_int(sqlStatement, 2);
            hairdresser.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            
            company.ID = sqlite3_column_int(sqlStatement, 4);
            company.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
            company.telephone = sqlite3_column_int(sqlStatement, 6);
            company.address = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
            
            hairdresser.company = company;
            haircut.hairdresser = hairdresser;
            
            haircut.description = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 8)];
            haircut.rating = sqlite3_column_int(sqlStatement, 9);
            haircut.price = sqlite3_column_int(sqlStatement, 10);
            
            [haircutsArray addObject:haircut];
        }
        
    } else {
        
        NSLog(@"[DataManager] getAllHaircuts - Error: %s", sqlite3_errmsg([SQLiteManager getConnection]));
    }
    
    [SQLiteManager closeConnection];
        
    return haircutsArray;
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
    
    if (self) {
        
    }
    
    return self;   
}

@end
