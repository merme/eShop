//
//  SecondViewController.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinPriceList : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tbvMinPrices;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTop;

//Array of timers
@property NSArray *arrMinPrices;

@end
