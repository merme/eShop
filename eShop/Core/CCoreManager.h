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
+(NSMutableArray*) getShopPriceList;
+(NSMutableArray*) getShopNotExistingProducts;
+(int) getNumberShopNotExistingProducts;
+(void) insertProductPrice:(CProductPrice*)p_cProductPrice;
+(void) deleteShop;



@end
