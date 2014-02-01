//
//  ShopListPricesVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CProductPrice.h"
#import "AddProductToAShopVC.h"




@interface ShopListPricesVC : UIViewController <UITableViewDataSource,UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UITableView *tbvShopProductPrices;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAdd;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDelShop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEditShop;


@property NSArray *arrShopProductPrices;
@property CProductPrice *cProductPrice;

+(ShopListPricesVC *) sharedShopListPricesVC;

+(void) setNewProductShopPrice:(NSString*)p_sPrice;



-(void) refreshShopProductPrices;

@end
