//
//  ShopListPricesVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CProductPrice.h"



@interface ShopListPricesVC : UIViewController <UITableViewDataSource,UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UITableView *tbvShopProductPrices;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAdd;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTop;


@property NSArray *arrShopProductPrices;
@property CProductPrice *cProductPrice;

-(void) setProductPrice:(CProductPrice*)p_cProductPrice;

@end
