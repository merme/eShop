//
//  SetupVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 27/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupVC : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIButton *btnCleanDB;
@property (weak, nonatomic) IBOutlet UIButton *btnRestoreDB;
@property (weak, nonatomic) IBOutlet UIImageView *bview;
@property (weak, nonatomic) IBOutlet UITableView *tbvSetup;


@end
