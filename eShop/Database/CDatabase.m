//
//  CDatabase.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "CDatabase.h"
#import "CShop.h"
#import "CProductPrice.h"

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
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    
    //Prepare array of commands ...
    NSMutableArray *sSqlQueries = [NSMutableArray array];
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS SHOPS( SHOP_ID INTEGER PRIMARY KEY, SHOP_NAME TEXT  NOT NULL,LOCATION TEXT);"]; // same with float values
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRODUCTS(PRODUCT_ID INTEGER PRIMARY KEY, PRODUCT_NAME TEXT UNIQUE NOT NULL);"];
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRICES(SHOP_ID INT NOT NULL REFERENCES SHOPS(SHOP_ID), PRODUCT_ID INT NOT NULL REFERENCES PRODUCTS(PRODUCT_ID),PRICE DECIMAL(7,2) NOT NULL);"];
    
    
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
 
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    NSMutableArray *sSqlQueries = [NSMutableArray array];
    [sSqlQueries addObject:@"BEGIN TRANSACTION;"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'Mercadona','Sant Andreu de la Barca');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'Bon Preu','Palleja');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'Condis','Palleja');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'Bon Preu','Palleja');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'Condis','Palleja-Maestro Falla');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES (null, 'Condis','Palleja-S. Isidro');"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'Atún');"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'Avellanas');"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'Base pizza');"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (1, 1,10.123);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (2, 2,20.345);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (1, 3,15.567);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES (1, 2,13.789);"];
    [sSqlQueries addObject:@"COMMIT;"];
    
    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSASCIIStringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }
    
}

+(NSMutableArray*) getShopList
{
  NSMutableArray* arrShops = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    
    const char *sSqlSelect = "SELECT SHOP_ID, SHOP_NAME, LOCATION FROM SHOPS;";

    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, sSqlSelect, -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CShop *cShop = [[CShop alloc] init];
            cShop.iId=sqlite3_column_int(selectStatement, 0);
            cShop.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cShop.sLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            
            [arrShops addObject:cShop];
        }
    }

    
    sqlite3_close(contactDB);
    
    return arrShops;
    
}

+(NSMutableArray*) getShopPriceList:(CShop*)p_cShop{
    
    NSMutableArray* arrShopPrices = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRODUCT_NAME, PRICE FROM SHOPS,PRICES,PRODUCTS WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID=%d", p_cShop.iId];
    //const char *sSqlSelect = "SELECT SHOP_ID, NAME, LOCATION FROM SHOPS;";
 
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 1);
            
             [arrShopPrices addObject:cProductPrice];
            
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return arrShopPrices;
}


@end
