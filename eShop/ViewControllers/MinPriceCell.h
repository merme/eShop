//
//  MinPriceCell.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/02/14.
//  Copyright (c) 2014 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinPriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgProd;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblShopName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;


@end
