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
#import "CProductPrice.h"

@interface CDatabase : NSObject{


    NSString *sDBPath;
}


+(NSString *)getDBPath;
+(void) createTables;
+(void) dropTables;
+(void) fillData;

+(NSMutableArray*) getShopsList;
+(NSMutableArray*) getShopPriceList:(CShop*)p_cShop;
+(NSMutableArray*) getShopNotExistingProducts:(CShop*)p_cShop;
+(int) getNumberShopNotExistingProducts:(CShop*)p_cShop;
+(void) insertProductPrice:(CProductPrice*)p_cProductPrice inShop:(CShop *)p_cShop;
+(void) recategorizeProducts:(CProductPrice*)p_cProductPrice;
+(void) deleteShop:(CShop*)p_cShop;
+(void) updateShop:(CShop*)p_CShop;
+(void) addShop:(CShop*)p_CShop;

+(NSMutableArray*) getProductsList;
+(NSMutableArray*) getProductPriceList:(CProduct*)p_cProduct;
+(NSMutableArray*) getProductNotExistingShops:(CProduct*)p_cProduct;
+(int) getNumberProductNotExistingShops:(CProduct*)p_cProduct;
+(void) insertShopPrice:(CProductPrice*)p_cProductPrice inProduct:(CProduct *)p_cProduct;
+(void) deleteProduct:(CProduct*)p_cProduct;
+(void) updateProduct:(CProduct*)p_CProduct;
+(void) addProduct:(CProduct*)p_CProduct;


@end
