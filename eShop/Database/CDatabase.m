//
//  CDatabase.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "CDatabase.h"

@implementation CDatabase

static    sqlite3 *contactDB; //Declare a pointer to sqlite database structure

+(NSString *)getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"PriceList.db"];
}

+(void) createTables{
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    NSLog(@"Database path:%@",dbPath);
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    
    //Prepare array of commands ...
    NSMutableArray *sSqlQueries = [NSMutableArray array];
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS SHOPS( SHOP_ID INTEGER PRIMARY KEY, NAME TEXT UNIQUE NOT NULL);"]; // same with float values
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRODUCTS(PRODUCT_ID INTEGER PRIMARY KEY, NAME TEXT UNIQUE NOT NULL);"];
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRICES(PRODUCT_ID INT NOT NULL REFERENCES SHOPS(SHOP_ID), SHOP_ID INT NOT NULL REFERENCES PRODUCTS(PRODUCT_ID),PRICE INT NOT NULL);"];
    
    
    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSASCIIStringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result){
            NSLog(@"Error in Shops Table (%s)", errInfo);
            return;
        }
    }
    
    //Close database
    result = sqlite3_close(contactDB);
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
}

+(void) dropTables{
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    NSLog(@"Database path:%@",dbPath);
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    
    //Prepare array of commands ...
    NSMutableArray *sSqlQueries = [NSMutableArray array];
    [sSqlQueries addObject:@"DROP TABLE SHOPS;"]; // same with float values
    [sSqlQueries addObject:@"DROP TABLE PRODUCTS;"];
    [sSqlQueries addObject:@"DROP TABLE PRICES;"];
    
    
    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSASCIIStringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);        
    }
    
}

+(void) fillData{
    
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    NSLog(@"Database path:%@",dbPath);
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    NSMutableArray *sSqlQueries = [NSMutableArray array];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'M');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'B');"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'C');"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'F');"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'A');"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (1, 1,10);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (2, 2,20);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (1, 1,15);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (1, 2,13);"];

    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSASCIIStringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }
    
}

@end
