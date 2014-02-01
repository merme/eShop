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
#import "CProduct.h"

@implementation CDatabase

static    sqlite3 *contactDB; //Declare a pointer to sqlite database structure


+(void) initializeDB{
    
    if(![CDatabase existsDB]){
        // Create tables
        [CDatabase createTables];
        // Ask if user wants sample data
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                          message:@"This is your first UIAlertview message."
                                                         delegate:self
                                                cancelButtonTitle:@"Button 1"
                                                otherButtonTitles:@"Button 2", @"Button 3", nil];
        [message show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Button 1"])
    {
        NSLog(@"Button 1 was selected.");
    }
    else if([title isEqualToString:@"Button 2"])
    {
        NSLog(@"Button 2 was selected.");
    }
    else if([title isEqualToString:@"Button 3"])
    {
        NSLog(@"Button 3 was selected.");
    }
}

+(BOOL) existsDB{
    NSString *sDBFilename=[CDatabase getDBPath];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:sDBFilename];
}


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
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS SHOPS( SHOP_ID TEXT PRIMARY KEY, SHOP_NAME TEXT  NOT NULL,LOCATION TEXT);"]; // same with float values
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRODUCTS(PRODUCT_ID INTEGER PRIMARY KEY, PRODUCT_NAME TEXT UNIQUE NOT NULL,PRICE_TYPE INTEGER NOT NULL);"];
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRICES(SHOP_ID TEXT NOT NULL REFERENCES SHOPS(SHOP_ID), PRODUCT_ID INT NOT NULL REFERENCES PRODUCTS(PRODUCT_ID),PRICE DECIMAL(7,2) NOT NULL, CATEGORY INT);"];
    
    
    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
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
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
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
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('111111A', 'Mercadona','Sant Andreu de la Barca');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('222222B', 'Bon Preu','Palleja');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('333333C', 'Condis','Palleja');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('444444D', 'Bon Preu','Palleja');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('555555E', 'Condis','Palleja-Maestro Falla');"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('666666F', 'Condis','Palleja-S. Isidro');"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'Atún',0);"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'Avellanas',1);"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES (null, 'Base pizza',2);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('111111A', 1,10.123,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('222222B', 2,10,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('111111A', 3,15.567,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('111111A', 2,15,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('333333C', 2,21,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('444444D', 2,25,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('666666F', 2,30,3);"];
    [sSqlQueries addObject:@"COMMIT;"];
    
    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }
    
    sqlite3_close(contactDB);
    
}

+(NSMutableArray*) getShopsList
{
  NSMutableArray* arrShops = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    
    const char *sSqlSelect = "SELECT SHOP_ID, SHOP_NAME, LOCATION FROM SHOPS ORDER BY SHOP_NAME;";

    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, sSqlSelect, -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CShop *cShop = [[CShop alloc] init];
            cShop.sId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
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
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRODUCT_NAME, PRICE, PRODUCTS.PRODUCT_ID, CATEGORY, SHOPS.SHOP_ID FROM SHOPS,PRICES,PRODUCTS WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID='%@' ORDER BY PRODUCT_NAME", p_cShop.sId];
    //const char *sSqlSelect = "SELECT SHOP_ID, NAME, LOCATION FROM SHOPS;";
 
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 1);
            cProductPrice.iId = sqlite3_column_int(selectStatement, 2);
            cProductPrice.tCategory = sqlite3_column_int(selectStatement, 3);
            cProductPrice.sShopId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            
             [arrShopPrices addObject:cProductPrice];
            
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return arrShopPrices;
}

+(NSMutableArray*) getShopNotExistingProducts:(CShop*)p_cShop{
    
    NSMutableArray* arrShopPrices = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    

    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRODUCT_NAME, PRODUCTS.PRODUCT_ID,PRICE_TYPE FROM PRODUCTS WHERE NOT EXISTS( SELECT * FROM SHOPS,PRICES WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID='%@') ORDER BY PRODUCT_NAME", p_cShop.sId];
   
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.iId = sqlite3_column_int(selectStatement, 1);
            cProductPrice.tPriceType = sqlite3_column_int(selectStatement, 2);
            cProductPrice.sShopId=p_cShop.sId;
            
            [arrShopPrices addObject:cProductPrice];
            
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return arrShopPrices;
}

+(int) getNumberShopNotExistingProducts:(CShop*)p_cShop{
 /*
    NSMutableArray* arrShopPrices = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return 0;
    }
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRODUCT_NAME FROM PRODUCTS WHERE NOT EXISTS( SELECT * FROM SHOPS,PRICES WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID=%d) ORDER BY PRODUCT_NAME", p_cShop.iId];
    
    
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
    
    return [arrShopPrices count];
  */

    return [[CDatabase getShopNotExistingProducts:p_cShop] count];
}

+(void) insertProductPrice:(CProductPrice*)p_cProductPrice inShop:(CShop *)p_cShop{

    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    

    NSString *sSqlSelect=[[NSString alloc] initWithFormat:@"INSERT INTO PRICES VALUES ('%@', %d,%.2f,%d)", p_cShop.sId,p_cProductPrice.iId,p_cProductPrice.fPrice,p_cProductPrice.tCategory];
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlSelect cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    
    sqlite3_close(contactDB);

    //Recategorize all the products with the same product_id
    [CDatabase recategorizeProducts:p_cProductPrice];

}

+(void) updateProductPrice:(CProductPrice*)p_cProductPrice inShop:(CShop *)p_cShop{
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRICES SET PRICE=%0.2f WHERE SHOP_ID='%@' AND PRODUCT_ID=%d", p_cProductPrice.fPrice,p_cShop.sId,p_cProductPrice.iId];
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    
    sqlite3_close(contactDB);
    
    //Recategorize all the products with the same product_id
    [CDatabase recategorizeProducts:p_cProductPrice];
    
}

+(void) deleteProductPrice:(CProductPrice*)p_cProductPrice{
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    NSString *sSqlDelete=[[NSString alloc] initWithFormat:@"DELETE FROM PRICES WHERE  SHOP_ID='%@' AND PRODUCT_ID=%d", p_cProductPrice.sShopId,p_cProductPrice.iId];
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlDelete cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    
    sqlite3_close(contactDB);
    
    //Recategorize all the products with the same product_id
    [CDatabase recategorizeProducts:p_cProductPrice];
}

+(void) recategorizeProducts:(CProductPrice*)p_cProductPrice{
    
    //1st. Part Select all records of a given product
    NSMutableArray* arrShopPrices = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return ;
    }
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRICE,PRODUCT_ID, SHOP_ID, CATEGORY FROM PRICES WHERE PRICES.PRODUCT_ID=%d", p_cProductPrice.iId];
    //const char *sSqlSelect = "SELECT SHOP_ID, NAME, LOCATION FROM SHOPS;";
    
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 0);
            cProductPrice.iId = sqlite3_column_int(selectStatement, 1);
            cProductPrice.sShopId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cProductPrice.tCategory = sqlite3_column_int(selectStatement, 3);
            
            [arrShopPrices addObject:cProductPrice];
        }
    }
    
    sqlite3_close(contactDB);
    
    CProductPrice *cProductPrice;
    CProductPrice *cProductPriceNext;
    
    if([arrShopPrices count]==1){
       cProductPrice =[arrShopPrices objectAtIndex:0];
       cProductPrice.tCategory=Normal;
    }
    else if([arrShopPrices count]==2){
        cProductPrice =[arrShopPrices objectAtIndex:0];
        cProductPriceNext =[arrShopPrices objectAtIndex:1];
        
        if(cProductPrice.fPrice<cProductPriceNext.fPrice){
            cProductPrice.tCategory=VeryCheap;
            cProductPriceNext.tCategory=VeryExpensive;
        }
        else if(cProductPrice.fPrice>cProductPriceNext.fPrice){
            cProductPrice.tCategory=VeryExpensive;
            cProductPriceNext.tCategory=VeryCheap;
        }
        else{
            cProductPrice.tCategory=Normal;
            cProductPriceNext.tCategory=Normal;
        }
    }
    else if([arrShopPrices count]>2){
        //Calculate the size of the 5-segment
    
        float fMin=MAXFLOAT;
        float fMax=0;
        for (cProductPrice in arrShopPrices) {
            if(cProductPrice.fPrice<fMin) fMin=cProductPrice.fPrice;
            if(cProductPrice.fPrice>fMax) fMax=cProductPrice.fPrice;
        }
        float f5Segment=(fMax-fMin)/5;
    
        //Recategorize Product-Price
        for (cProductPrice in arrShopPrices) {
            if(cProductPrice.fPrice>=fMin && cProductPrice.fPrice<(fMin+f5Segment)) cProductPrice.tCategory=VeryCheap;
            else if(cProductPrice.fPrice>=(fMin+f5Segment) && cProductPrice.fPrice<(fMin+f5Segment*2)) cProductPrice.tCategory=Cheap;
            else if(cProductPrice.fPrice>=(fMin+f5Segment*2) && cProductPrice.fPrice<(fMin+f5Segment*3)) cProductPrice.tCategory=Normal;
            else if(cProductPrice.fPrice>=(fMin+f5Segment*3) && cProductPrice.fPrice<   (fMin+f5Segment*4)) cProductPrice.tCategory=Expensive;
            else cProductPrice.tCategory=VeryExpensive;
        }
    }
    //2nd. Update all records
    result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    
    
    //Recategorize Product-Price
    for (cProductPrice in arrShopPrices) {
    
        NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRICES SET CATEGORY=%d WHERE SHOP_ID='%@' AND PRODUCT_ID=%d", cProductPrice.tCategory,cProductPrice.sShopId,p_cProductPrice.iId];
        
        char * errInfo ;
        result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }
    
    sqlite3_close(contactDB);
}

+(void) deleteShop:(CShop*)p_cShop{
    
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    NSMutableArray *sSqlQueries = [NSMutableArray array];
    [sSqlQueries addObject:@"BEGIN TRANSACTION;"];
    [sSqlQueries addObject:[[NSString alloc] initWithFormat:@"DELETE FROM PRICES WHERE SHOP_ID='%@'", p_cShop.sId]];
    [sSqlQueries addObject:[[NSString alloc] initWithFormat:@"DELETE FROM SHOPS WHERE SHOP_ID='%@'", p_cShop.sId]];
    [sSqlQueries addObject:@"COMMIT;"];
    
    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }
    
    sqlite3_close(contactDB);
    
}

+(void) updateShop:(CShop*)p_CShop{
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    //Recategorize Product-Price
    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE SHOPS SET SHOP_NAME='%@', LOCATION='%@' WHERE SHOP_ID='%@' ",p_CShop.sName ,p_CShop.sLocation,p_CShop.sId];
        
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    sqlite3_close(contactDB);
    
}


+(void) addShop:(CShop *)p_CShop{
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    //Recategorize Product-Price
    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"INSERT INTO SHOPS VALUES (null,'%@','%@');",p_CShop.sName ,p_CShop.sLocation];
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    sqlite3_close(contactDB);
    
}


+(NSMutableArray*) getProductsList
{
    NSMutableArray* arrProduct = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    
    const char *sSqlSelect = "SELECT PRODUCT_ID, PRODUCT_NAME, PRICE_TYPE FROM PRODUCTS ORDER BY PRODUCT_NAME;";
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, sSqlSelect, -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProduct *cProduct = [[CProduct alloc] init];
            cProduct.iId=sqlite3_column_int(selectStatement, 0);
            cProduct.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cProduct.tPriceType=sqlite3_column_int(selectStatement, 2);
            [arrProduct addObject:cProduct];
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return arrProduct;
    
}

+(NSMutableArray*) getProductPriceList:(CProduct*)p_cProduct{
    NSMutableArray* arrShopPrices = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT SHOP_NAME, PRICE, SHOPS.SHOP_ID, CATEGORY, SHOPS.LOCATION, PRODUCTS.PRODUCT_ID FROM SHOPS,PRICES,PRODUCTS WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND PRODUCTS.PRODUCT_ID=%d ORDER BY SHOP_NAME", p_cProduct.iId];

    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sShopName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 1);
            cProductPrice.sShopId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cProductPrice.tCategory = sqlite3_column_int(selectStatement, 3);
            cProductPrice.sShopLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            cProductPrice.iId = sqlite3_column_int(selectStatement, 5);
            
            [arrShopPrices addObject:cProductPrice];
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return arrShopPrices;
    
}

+(NSMutableArray*) getProductNotExistingShops:(CProduct*)p_cProduct{

    NSMutableArray* arrProductPrices = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    
  /*
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRODUCT_NAME, PRODUCTS.PRODUCT_ID FROM PRODUCTS WHERE NOT EXISTS( SELECT * FROM SHOPS,PRICES WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID=%d) ORDER BY PRODUCT_NAME", p_cShop.iId];
  */
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT SHOP_NAME, SHOPS.SHOP_ID, LOCATION FROM SHOPS WHERE NOT EXISTS( SELECT * FROM PRODUCTS,PRICES WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND PRODUCTS.PRODUCT_ID=%d) ORDER BY SHOP_NAME", p_cProduct.iId];
    
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sShopName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.sShopId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cProductPrice.sShopLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cProductPrice.iId=p_cProduct.iId;
            
            [arrProductPrices addObject:cProductPrice];
            
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return arrProductPrices;

}

+(int) getNumberProductNotExistingShops:(CProduct*)p_cProduct{
    
    return [[CDatabase getProductNotExistingShops:p_cProduct] count];
}

+(void) insertShopPrice:(CProductPrice*)p_cProductPrice inProduct:(CProduct *)p_cProduct{
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    

    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    
    NSString *sSqlSelect=[[NSString alloc] initWithFormat:@"INSERT INTO PRICES VALUES (%@, %d,%.2f,%d)", p_cProductPrice.sShopId,p_cProduct.iId,p_cProductPrice.fPrice,p_cProductPrice.tCategory];
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlSelect cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    
    sqlite3_close(contactDB);
    
    //Recategorize all the products with the same product_id
    [CDatabase recategorizeProducts:p_cProductPrice];
}

+(void) updateShopPrice:(CProductPrice*)p_cProductPrice inProduct:(CProduct *)p_cProduct{
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    

    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRICES SET PRICE=%0.2f WHERE SHOP_ID=%@ AND PRODUCT_ID=%d", p_cProductPrice.fPrice,p_cProductPrice.sShopId,p_cProduct.iId];
    
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    
    sqlite3_close(contactDB);
    
    //Recategorize all the products with the same product_id
    [CDatabase recategorizeProducts:p_cProductPrice];
}



+(void) deleteProduct:(CProduct *)p_cProduct{
    
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    NSMutableArray *sSqlQueries = [NSMutableArray array];
    [sSqlQueries addObject:@"BEGIN TRANSACTION;"];
    [sSqlQueries addObject:[[NSString alloc] initWithFormat:@"DELETE FROM PRICES WHERE PRODUCT_ID=%d", p_cProduct.iId]];
    [sSqlQueries addObject:[[NSString alloc] initWithFormat:@"DELETE FROM PRODUCTS WHERE PRODUCT_ID=%d", p_cProduct.iId]];
    [sSqlQueries addObject:@"COMMIT;"];
    
    char * errInfo ;
    int i;
    for (i = 0 ; i < [sSqlQueries count]; i = i + 1)
    {
        result = sqlite3_exec(contactDB, [[sSqlQueries objectAtIndex:i] cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }
    
    sqlite3_close(contactDB);
    
}

+(void) updateProduct:(CProduct *)p_CProduct{
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }

    //Recategorize Product-Price
    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRODUCTS SET PRODUCT_NAME='%@',PRICE_TYPE=%d WHERE PRODUCT_ID=%d ",p_CProduct.sName,p_CProduct.tPriceType ,p_CProduct.iId];
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    sqlite3_close(contactDB);
    
}

+(void) addProduct:(CProduct*)p_CProduct{
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
        NSLog(@"%@",dbPath);
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return;
    }
    
    //Recategorize Product-Price
    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"INSERT INTO PRODUCTS VALUES (null,'%@',%d);",p_CProduct.sName ,p_CProduct.tPriceType];
    
    char * errInfo ;
    result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
    if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    
    sqlite3_close(contactDB);
    
}

@end
