//
//  CCoreManager.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "CCoreManager.h"
#import "CDatabase.h"
#import "CShop.h"

static CShop *cAtiveShop;

@implementation CCoreManager

@synthesize arrShops;

-(id)init {
    if ( self = [super init] ) {
        self.arrShops = [[NSMutableArray alloc]init];
        cAtiveShop=nil;
    }
    return self;
}


+(void) setActiveShop:(CShop*) r_CShop{
    
  cAtiveShop=r_CShop;
}

+(CShop*) getActiveShop{
    
    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return cAtiveShop;
}

+(NSMutableArray*) getShopPriceList{
    
    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getShopPriceList:cAtiveShop];
}

+(NSMutableArray*) getShopNotExistingProducts{

    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getShopNotExistingProducts:cAtiveShop];

}

+(int) getNumberShopNotExistingProducts{
    
    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getNumberShopNotExistingProducts:cAtiveShop];
    
}

+(void) insertProductPrice:(CProductPrice*)p_cProductPrice{
    
    CShop *cShop = [CCoreManager getActiveShop];
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase insertProductPrice:p_cProductPrice inShop:cShop];
}

+(void) deleteShop{
 
    CShop *cShop = [CCoreManager getActiveShop];
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase deleteShop:cShop];
}

+(void) updateShop:(CShop*) p_CShop{
    
    [CDatabase updateShop:p_CShop];
    [CCoreManager setActiveShop:p_CShop];
}


-(void) addShop:(CShop*) r_CShop
{
   
    //Insert new prescription
    [arrShops addObject:r_CShop];
    
}

-(NSArray*) listShop
{
    return arrShops;
}



-(void) fillWithSampleData{
    [arrShops addObject:[[CShop alloc]initWithName:@"Mercadona"]];
    [arrShops addObject:[[CShop alloc]initWithName:@"Bon Preu"]];
    [arrShops addObject:[[CShop alloc]initWithName:@"Area de Guissona"]];
    
    
}

@end
