//
//  CDatabase.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "CShop.h"

@interface CDatabase : NSObject{


    NSString *sDBPath;
}


+(NSString *)getDBPath;
+(void) createTables;
+(void) dropTables;
+(void) fillData;
+(NSMutableArray*) getShopList;
+(NSMutableArray*) getShopPriceList:(CShop*)p_cShop;
+(NSMutableArray*) getShopNotExistingProducts:(CShop*)p_cShop;
+(int) getNumberShopNotExistingProducts:(CShop*)p_cShop;




@end
