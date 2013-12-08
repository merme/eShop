//
//  CCoreManager.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "CCoreManager.h"
#import "CShop.h"

@implementation CCoreManager

@synthesize arrShops;

-(id)init {
    if ( self = [super init] ) {
        self.arrShops = [[NSMutableArray alloc]init];
    }
    return self;
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
