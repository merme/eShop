//
//  CCoreManager.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CShop.h"
#import "CProductPrice.h"
#import "CProduct.h"


@interface CCoreManager : NSObject{
    
    //Array of timers
    NSMutableArray *arrShops;
    
}

//Array of timers
@property (strong, nonatomic) NSMutableArray *arrShops;

-(void) addShop:(CShop*) r_CShop;
-(NSArray*) listShop;
-(void) fillWithSampleData;

+(void) setActiveShop:(CShop*) r_CShop;
+(CShop*) getActiveShop;
+(NSMutableArray*) getShopsList;
+(NSMutableArray*) getShopPriceList;
+(NSMutableArray*) getShopNotExistingProducts;
+(int) getNumberShopNotExistingProducts;
+(void) insertProductPrice:(CProductPrice*)p_cProductPrice;
+(void) updateProductPrice:(CProductPrice*)p_cProductPrice;
+(void) deleteShop;
+(void) updateShop:(CShop*) p_CShop;
+(void) addShop:(CShop*) p_CShop;



+(void) setActiveProduct:(CProduct*) p_CProduct;
+(CProduct*) getActiveProduct;
+(NSMutableArray*) getProductsList;
+(NSMutableArray*) getProductPriceList;
+(NSMutableArray*) getProductNotExistingShops;
+(int) getNumberProductNotExistingShops;
+(void) insertShopPrice:(CProductPrice*)p_cProductPrice;
+(void) updateShopPrice:(CProductPrice*)p_cProductPrice;
+(void) deleteProduct;
+(void) updateProduct:(CProduct*) p_CProduct;
+(void) addProduct:(CProduct*) p_CProduct;


@end
