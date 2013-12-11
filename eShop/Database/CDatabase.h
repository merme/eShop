//
//  CDatabase.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface CDatabase : NSObject{


    NSString *sDBPath;
}


+(NSString *)getDBPath;
+(void) createTables;
+(void) dropTables;
+(void) fillData;
+(NSMutableArray*) getShopList;

@end
