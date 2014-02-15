//
//  SetupVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 27/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupVC : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnCleanDB;
@property (weak, nonatomic) IBOutlet UIButton *btnRestoreDB;
@property (weak, nonatomic) IBOutlet UIImageView *bview;

@end
