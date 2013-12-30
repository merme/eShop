//
//  ProductListPricesVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CProductPrice.h"

@interface ProductListPricesVC :  UITableViewController <UITableViewDataSource,UITableViewDelegate>

#import "CProductPrice.h"

@property (strong, nonatomic) IBOutlet UITableView *tbvProductShopPrices;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAdd;


@property NSArray *arrProductShopPrices;
@property CProductPrice *cProductPrice;

+(ProductListPricesVC *) sharedProductListPricesVC;

+(void) setNewShopProductPrice:(NSString*)p_sPrice;

-(void) refreshProductShopPrices;

@end
