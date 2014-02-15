//
//  ShopsListVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopsListVC : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tbvShops;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTop;


//Array of timers
@property NSArray *arrShops;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(ShopsListVC *) sharedViewController;

-(void) refreshShopList;

@end
