//
//  ProductPriceCell.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ProductPriceCell.h"
#import "ProductListPricesVC.h"

@implementation ProductPriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnConfirmPrice:(id)sender {
    [ProductListPricesVC setNewShopProductPrice:self.txtPrice.text];
    [[ProductListPricesVC sharedProductListPricesVC] refreshProductShopPrices];
    [sender resignFirstResponder];
}

@end
