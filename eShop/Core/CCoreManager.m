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
