//
//  CProduct.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRICE_TYPES[NSArray arrayWithObjects:NSLocalizedString(@"UNIT", nil),NSLocalizedString(@"KILO", nil),NSLocalizedString(@"500GR", nil),NSLocalizedString(@"250GR", nil),NSLocalizedString(@"100GR", nil),NSLocalizedString(@"LITER", nil),NSLocalizedString(@"250CL", nil),NSLocalizedString(@"100CL", nil),NSLocalizedString(@"33CL", nil),NSLocalizedString(@"POUND", nil),NSLocalizedString(@"OUNCE", nil),NSLocalizedString(@"GALLON", nil),nil]

@interface CProduct : NSObject

typedef enum Price : NSUInteger {
    PriceUnit,
    Price1Kilo,
    Price500Gr,
    Price250Gr,
    Price100Gr,
    Price1Liter,
    Price250Cl,
    Price100Cl,
    Price33Cl,
    PricePound,
    PriceOnce,
    PriceGallon
} PriceType;


@property (nonatomic) enum Price tPriceType;

@property (strong,nonatomic) NSString *sId;
@property (strong,nonatomic) NSString *sName;
@property (strong,nonatomic) NSData *dPicture;


@end
