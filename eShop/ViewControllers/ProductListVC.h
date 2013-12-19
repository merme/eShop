//
//  ProductListVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListVC.h"

@interface ProductListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tbvProducts;

//Array of timers
@property NSArray *arrProducts;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(ProductListVC *) sharedViewController;

-(void) refreshProductList;

@end
