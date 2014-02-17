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

+(void) printFilename{
    NSLog(@"%@", [CDatabase getDBPath]);
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
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS SHOPS( SHOP_ID TEXT PRIMARY KEY, SHOP_NAME TEXT  NOT NULL,LOCATION TEXT,PICTURE BLOB);"]; // same with float values
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRODUCTS(PRODUCT_ID TEXT PRIMARY KEY, PRODUCT_NAME TEXT UNIQUE NOT NULL,PRICE_TYPE INTEGER NOT NULL,PICTURE BLOB);"];
    [sSqlQueries addObject:@"CREATE TABLE IF NOT EXISTS PRICES(SHOP_ID TEXT NOT NULL REFERENCES SHOPS(SHOP_ID), PRODUCT_ID TEXT NOT NULL REFERENCES PRODUCTS(PRODUCT_ID),PRICE DECIMAL(7,2) NOT NULL, CATEGORY INT);"];
    
    
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
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('111111A', 'Mercadona','Sant Andreu de la Barca',null);"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('222222B', 'Bon Preu','Palleja',null);"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('333333C', 'Condis','Palleja',null);"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('444444D', 'Bon Preu','Palleja',null);"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('555555E', 'Condis','Palleja-Maestro Falla',null);"];
    [sSqlQueries addObject:@"INSERT INTO SHOPS VALUES ('666666F', 'Condis','Palleja-S. Isidro',null);"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES ('001', 'Atún',0,null);"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES ('002', 'Avellanas',1,null);"];
    [sSqlQueries addObject:@"INSERT INTO PRODUCTS VALUES ('003', 'Base pizza',2,null);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('111111A', '001',10.123,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('222222B', '002',10,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('111111A', '003',15.567,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('111111A', '002',15,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('333333C', '002',21,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('444444D', '002',25,3);"];
    [sSqlQueries addObject:@"INSERT INTO PRICES VALUES ('666666F', '002',30,3);"];
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
    
    const char *sSqlSelect = "SELECT SHOP_ID, SHOP_NAME, LOCATION, PICTURE FROM SHOPS ORDER BY SHOP_NAME;";

    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, sSqlSelect, -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CShop *cShop = [[CShop alloc] init];
            cShop.sId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cShop.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cShop.sLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            int length = sqlite3_column_bytes(selectStatement, 3);
            if(length>0)
                cShop.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 3) length:length];
            
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
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRODUCT_NAME, PRICE, PRODUCTS.PRODUCT_ID, CATEGORY, SHOPS.SHOP_ID,PRODUCTS.PICTURE FROM SHOPS,PRICES,PRODUCTS WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID='%@' ORDER BY PRODUCT_NAME", p_cShop.sId];
    //const char *sSqlSelect = "SELECT SHOP_ID, NAME, LOCATION FROM SHOPS;";
 
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 1);
            cProductPrice.sId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cProductPrice.tCategory = sqlite3_column_int(selectStatement, 3);
            cProductPrice.sShopId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            int length = sqlite3_column_bytes(selectStatement, 5);
            if(length>0)
                cProductPrice.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 5) length:length];            
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
    

    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRODUCT_NAME, PRODUCTS.PRODUCT_ID,PRICE_TYPE,PRODUCTS.PICTURE FROM PRODUCTS WHERE NOT EXISTS( SELECT * FROM SHOPS,PRICES WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID='%@') ORDER BY PRODUCT_NAME", p_cShop.sId];
   
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.sId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cProductPrice.tPriceType = sqlite3_column_int(selectStatement, 2);
            cProductPrice.sShopId=p_cShop.sId;
            int length = sqlite3_column_bytes(selectStatement, 3);
            if(length>0)
                cProductPrice.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 3) length:length];
            
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
    
    NSString *sSqlSelect;
    
        sSqlSelect=[[NSString alloc] initWithFormat:@"INSERT INTO PRICES VALUES ('%@', '%@',%.2f,%d)", p_cShop.sId,p_cProductPrice.sId,p_cProductPrice.fPrice,p_cProductPrice.tCategory];

    
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
    
    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRICES SET PRICE=%0.2f WHERE SHOP_ID='%@' AND PRODUCT_ID='%@'", p_cProductPrice.fPrice,p_cShop.sId,p_cProductPrice.sId];
    
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
    
    NSString *sSqlDelete=[[NSString alloc] initWithFormat:@"DELETE FROM PRICES WHERE  SHOP_ID='%@' AND PRODUCT_ID='%@'", p_cProductPrice.sShopId,p_cProductPrice.sId];
    
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
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT PRICE,PRODUCT_ID, SHOP_ID, CATEGORY FROM PRICES WHERE PRICES.PRODUCT_ID='%@'", p_cProductPrice.sId];
    //const char *sSqlSelect = "SELECT SHOP_ID, NAME, LOCATION FROM SHOPS;";
    
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 0);
            cProductPrice.sId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
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
    
        NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRICES SET CATEGORY=%d WHERE SHOP_ID='%@' AND PRODUCT_ID='%@'", cProductPrice.tCategory,cProductPrice.sShopId,p_cProductPrice.sId];
        
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
 
    if(p_CShop.dPicture!=nil){
        // Construct the query and empty prepared statement.
        //const char *sql = "INSERT INTO `PRODUCTS` (`PRODUCT_ID`, `PRODUCT_NAME`, `PRICE_TYPE`, `PICTURE`) VALUES (?, ?, ?, ?)";
        NSString *sql = [[NSString alloc] initWithFormat:@"UPDATE SHOPS SET `SHOP_NAME`=?,`LOCATION`=?, `PICTURE`=? WHERE SHOP_ID='%@' ",p_CShop.sId];
        sqlite3_stmt *statement;
        
        // Prepare the data to bind.
        
        //http://stackoverflow.com/questions/5039343/save-image-data-to-sqlite-database-in-iphone
        if( sqlite3_prepare_v2(contactDB, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK )
        {
            sqlite3_bind_text(statement, 1, [p_CShop.sName UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [p_CShop.sLocation UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_blob(statement, 3, [p_CShop.dPicture bytes], [p_CShop.dPicture length], SQLITE_TRANSIENT);
            sqlite3_step(statement);
        }
        else NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(contactDB) );
        
        // Finalize and close database.
        sqlite3_finalize(statement);
    }
    else{
        //Recategorize Product-Price
        NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE SHOPS SET SHOP_NAME='%@', LOCATION='%@' WHERE SHOP_ID='%@' ",p_CShop.sName ,p_CShop.sLocation,p_CShop.sId];
        
        char * errInfo ;
        result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }

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
    NSString *sSqlUpdate;
    
    if(p_CShop.dPicture!=nil){
       sSqlUpdate=[[NSString alloc] initWithFormat:@"INSERT INTO SHOPS VALUES ('%@','%@','%@','%@');",p_CShop.sId,p_CShop.sName ,p_CShop.sLocation,p_CShop.dPicture];
  
        // Construct the query and empty prepared statement.
        const char *sql = "INSERT INTO `SHOPS` (`SHOP_ID`, `SHOP_NAME`, `LOCATION`, `PICTURE`) VALUES (?, ?, ?, ?)";
        sqlite3_stmt *statement;
        
        // Prepare the data to bind.
        
       //http://stackoverflow.com/questions/5039343/save-image-data-to-sqlite-database-in-iphone
        if( sqlite3_prepare_v2(contactDB, sql, -1, &statement, NULL) == SQLITE_OK )
        {
            sqlite3_bind_text(statement, 1, [p_CShop.sId UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [p_CShop.sName UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [p_CShop.sLocation UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_blob(statement, 4, [p_CShop.dPicture bytes], [p_CShop.dPicture length], SQLITE_TRANSIENT);
            sqlite3_step(statement);
        }
        else NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(contactDB) );
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        
        
        
    }
    else{
         sSqlUpdate=[[NSString alloc] initWithFormat:@"INSERT INTO SHOPS VALUES ('%@','%@','%@',null);",p_CShop.sId,p_CShop.sName ,p_CShop.sLocation];
        
        char * errInfo ;
        result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
        

    }
    

    sqlite3_close(contactDB);
}


+(CShop*) getShopById:(CShop*) p_CShop{
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT SHOP_ID, SHOP_NAME, LOCATION, PICTURE FROM SHOPS WHERE SHOP_ID='%@'", p_CShop.sId];
    
    
    CShop *cShopFound=nil;
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            cShopFound = [[CShop alloc] init];
            cShopFound.sId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cShopFound.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cShopFound.sLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cShopFound.sId=p_CShop.sId;
            int length = sqlite3_column_bytes(selectStatement, 3);
            cShopFound.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 3) length:length];
            
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return cShopFound;

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
    
    const char *sSqlSelect = "SELECT PRODUCT_ID, PRODUCT_NAME, PRICE_TYPE, PICTURE FROM PRODUCTS ORDER BY PRODUCT_NAME;";
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, sSqlSelect, -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProduct *cProduct = [[CProduct alloc] init];
            cProduct.sId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProduct.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cProduct.tPriceType=sqlite3_column_int(selectStatement, 2);
            int length = sqlite3_column_bytes(selectStatement, 3);
            cProduct.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 3) length:length];
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
    
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT SHOP_NAME, PRICE, SHOPS.SHOP_ID, CATEGORY, SHOPS.LOCATION, PRODUCTS.PRODUCT_ID,SHOPS.PICTURE FROM SHOPS,PRICES,PRODUCTS WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND PRODUCTS.PRODUCT_ID='%@' ORDER BY PRICES.PRICE", p_cProduct.sId];

    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sShopName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 1);
            cProductPrice.sShopId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cProductPrice.tCategory = sqlite3_column_int(selectStatement, 3);
            cProductPrice.sShopLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            cProductPrice.sId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            int length = sqlite3_column_bytes(selectStatement, 6);
            if(length>0)
                cProductPrice.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 6) length:length];
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
    
    NSString *sSqlSelect = [[NSString alloc] initWithFormat:@"SELECT SHOP_NAME, SHOPS.SHOP_ID, LOCATION, SHOPS.PICTURE FROM SHOPS WHERE NOT EXISTS( SELECT * FROM PRODUCTS,PRICES WHERE SHOPS.SHOP_ID=PRICES.SHOP_ID  AND PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND PRODUCTS.PRODUCT_ID='%@') ORDER BY SHOP_NAME", p_cProduct.sId];
    
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, [sSqlSelect UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sShopName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.sShopId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cProductPrice.sShopLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cProductPrice.sId=p_cProduct.sId;
            int length = sqlite3_column_bytes(selectStatement, 3);
            if(length>0)
                cProductPrice.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 3) length:length];
            
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
    
    
    NSString *sSqlSelect=[[NSString alloc] initWithFormat:@"INSERT INTO PRICES VALUES ('%@', '%@',%.2f,%d)", p_cProductPrice.sShopId,p_cProduct.sId,p_cProductPrice.fPrice,p_cProductPrice.tCategory];
    
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
    

    NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRICES SET PRICE=%0.2f WHERE SHOP_ID='%@' AND PRODUCT_ID='%@'", p_cProductPrice.fPrice,p_cProductPrice.sShopId,p_cProduct.sId];
    
    
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
    [sSqlQueries addObject:[[NSString alloc] initWithFormat:@"DELETE FROM PRICES WHERE PRODUCT_ID='%@'", p_cProduct.sId]];
    [sSqlQueries addObject:[[NSString alloc] initWithFormat:@"DELETE FROM PRODUCTS WHERE PRODUCT_ID='%@'", p_cProduct.sId]];
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

    
    if(p_CProduct.dPicture!=nil){
            // Construct the query and empty prepared statement.
            //const char *sql = "INSERT INTO `PRODUCTS` (`PRODUCT_ID`, `PRODUCT_NAME`, `PRICE_TYPE`, `PICTURE`) VALUES (?, ?, ?, ?)";
            NSString *sql = [[NSString alloc] initWithFormat:@"UPDATE PRODUCTS SET `PRODUCT_NAME`=?,`PRICE_TYPE`=?, `PICTURE`=? WHERE PRODUCT_ID='%@' ",p_CProduct.sId];
            sqlite3_stmt *statement;
            
            // Prepare the data to bind.
            
            //http://stackoverflow.com/questions/5039343/save-image-data-to-sqlite-database-in-iphone
            if( sqlite3_prepare_v2(contactDB, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK )
            {
                sqlite3_bind_text(statement, 1, [p_CProduct.sName UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_int(statement, 2, p_CProduct.tPriceType );
                sqlite3_bind_blob(statement, 3, [p_CProduct.dPicture bytes], [p_CProduct.dPicture length], SQLITE_TRANSIENT);
                sqlite3_step(statement);
            }
            else NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(contactDB) );
            
            // Finalize and close database.
            sqlite3_finalize(statement);
            
            
            
    }
    else{
        //Recategorize Product-Price
        NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"UPDATE PRODUCTS SET PRODUCT_NAME='%@',PRICE_TYPE=%d WHERE PRODUCT_ID='%@' ",p_CProduct.sName,p_CProduct.tPriceType ,p_CProduct.sId];
    
        char * errInfo ;
        result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
        if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
    }

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
     if(p_CProduct.dPicture!=nil){

     
     // Construct the query and empty prepared statement.
     const char *sql = "INSERT INTO `PRODUCTS` (`PRODUCT_ID`, `PRODUCT_NAME`, `PRICE_TYPE`, `PICTURE`) VALUES (?, ?, ?, ?)";
     sqlite3_stmt *statement;
     
     // Prepare the data to bind.
     
     //http://stackoverflow.com/questions/5039343/save-image-data-to-sqlite-database-in-iphone
     if( sqlite3_prepare_v2(contactDB, sql, -1, &statement, NULL) == SQLITE_OK )
     {
     sqlite3_bind_text(statement, 1, [p_CProduct.sId UTF8String], -1, SQLITE_TRANSIENT);
     sqlite3_bind_text(statement, 2, [p_CProduct.sName UTF8String], -1, SQLITE_TRANSIENT);
     sqlite3_bind_int(statement, 3, p_CProduct.tPriceType );
     sqlite3_bind_blob(statement, 4, [p_CProduct.dPicture bytes], [p_CProduct.dPicture length], SQLITE_TRANSIENT);
     sqlite3_step(statement);
     }
     else NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(contactDB) );
     
     // Finalize and close database.
     sqlite3_finalize(statement);
     
     
     
     }
     else{
         //Recategorize Product-Price
         NSString *sSqlUpdate=[[NSString alloc] initWithFormat:@"INSERT INTO PRODUCTS VALUES ('%@','%@',%d,null);",p_CProduct.sId,p_CProduct.sName ,p_CProduct.tPriceType];
         
         char * errInfo ;
         result = sqlite3_exec(contactDB, [sSqlUpdate cStringUsingEncoding:NSUTF8StringEncoding], nil, nil, &errInfo);
         if (SQLITE_OK != result) NSLog(@"Error in Shops Table (%s)", errInfo);
     
     }
     
     
    

    
    sqlite3_close(contactDB);
    
}

+(NSMutableArray*) getProductsMinList{

    
    NSMutableArray* arrProductsMin = [[NSMutableArray alloc] init];
    
    //Get Temporary Directory
    NSString* dbPath = [CDatabase getDBPath];
    
    
    int result = sqlite3_open([dbPath UTF8String], &contactDB);
    
    if (SQLITE_OK != result) {
        NSLog(@"myDB opening error");
        return nil;
    }
  
    const char *sSqlSelect = "SELECT PRODUCTS.PRODUCT_ID,PRODUCTS.PRODUCT_NAME,SHOPS.SHOP_ID,SHOPS.SHOP_NAME,MIN(PRICE), PRODUCTS.PICTURE  FROM PRODUCTS, PRICES,SHOPS WHERE PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID=PRICES.SHOP_ID GROUP BY PRODUCTS.PRODUCT_ID";
    /*
    const char *sSqlSelect = "SELECT PRODUCTS.PRODUCT_ID,PRODUCTS.PRODUCT_NAME,SHOPS.SHOP_ID,SHOPS.SHOP_NAME,MIN(PRICE)  FROM PRODUCTS, PRICES,SHOPS WHERE PRODUCTS.PRODUCT_ID=PRICES.PRODUCT_ID AND SHOPS.SHOP_ID=PRICES.SHOP_ID GROUP BY PRODUCTS.PRODUCT_ID";
  */
    
    sqlite3_stmt *selectStatement;
    if(sqlite3_prepare_v2(contactDB, sSqlSelect, -1, &selectStatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            CProductPrice *cProductPrice = [[CProductPrice alloc] init];
            cProductPrice.sId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            cProductPrice.sName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            cProductPrice.sShopId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            cProductPrice.sShopName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)];
            cProductPrice.fPrice = (float)sqlite3_column_double(selectStatement, 4);
            
            int length = sqlite3_column_bytes(selectStatement, 5);
            if(length>0)
                cProductPrice.dPicture = [NSData dataWithBytes:sqlite3_column_blob(selectStatement, 5) length:length];
            [arrProductsMin addObject:cProductPrice];
        }
    }
    
    
    sqlite3_close(contactDB);
    
    return arrProductsMin;
    
}

@end
