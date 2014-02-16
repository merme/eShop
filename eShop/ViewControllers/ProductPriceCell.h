//
//  ProductPriceCell.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblShopName;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgCategory;
@property (weak, nonatomic) IBOutlet UIImageView *imgShop;


@end
