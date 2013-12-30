//
//  ShopPriceCell.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopPriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnPrice;

@end
